
package com.example.stockapp.controller;

import com.example.stockapp.entity.Stock;
import com.example.stockapp.form.StockForm;
import com.example.stockapp.helper.StockHelper;
import com.example.stockapp.service.StockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/stocks")
@SessionAttributes("stockForm")
public class StockController {

    @Autowired
    private StockService stockService;

    /** 株一覧 */
    @GetMapping
    public String list(Model model) {
        List<Stock> stocks = stockService.findStocks();
        model.addAttribute("stocks", stocks);
        return "stocks/list";
    }

    /** 登録画面 */
    @GetMapping("/add")
    public String addForm(Model model) {
        model.addAttribute("stockForm", new StockForm());
        return "stocks/add";
    }

    /** 確認画面 */
    @PostMapping("/add/confirm")
    public String confirm(@Validated @ModelAttribute("stockForm") StockForm stockForm,
                          BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            return "stocks/add";
        }
        model.addAttribute("stockForm", stockForm);
        return "stocks/confirm";
    }

    /** 登録処理 */
    @PostMapping("/add/register")
    public String register(@ModelAttribute("stockForm") StockForm stockForm,
                           BindingResult bindingResult,
                           RedirectAttributes redirectAttributes) {
        if (stockService.existsByCode(stockForm.getCode())) {
            bindingResult.rejectValue("code", "error.stockForm.code", "この証券コードはすでに存在します。");
        }
        if (bindingResult.hasErrors()) {
            return "stocks/add";
        }
        stockService.createStock(StockHelper.convert(stockForm));
        redirectAttributes.addFlashAttribute("stockFormFlash", stockForm);
        return "redirect:/stocks/add/complete";
    }

    /** 登録完了画面 */
    @GetMapping("/add/complete")
    public String complete(@ModelAttribute("stockFormFlash") StockForm stockForm,
                           SessionStatus sessionStatus) {
        sessionStatus.setComplete();
        return "stocks/complete";
    }

    /** 編集画面 */
    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Long id, Model model) {
        Stock stock = stockService.findById(id);
        model.addAttribute("stockForm", StockHelper.convert(stock));
        return "stocks/edit";
    }

    /** 編集処理 */
    @PostMapping("/edit/{id}")
    public String edit(@PathVariable Long id,
                       @Validated @ModelAttribute("stockForm") StockForm stockForm,
                       BindingResult bindingResult,
                       RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            return "stocks/edit";
        }
        stockService.updateStock(id, StockHelper.convert(stockForm));
        redirectAttributes.addFlashAttribute("stockFormFlash", stockForm);
        return "redirect:/stocks/edit/complete";
    }

    /** 編集完了画面 */
    @GetMapping("/edit/complete")
    public String editComplete(@ModelAttribute("stockFormFlash") StockForm stockForm,
                               SessionStatus sessionStatus) {
        sessionStatus.setComplete();
        return "stocks/edit-complete";
    }

    /** idなし編集画面アクセス時のリダイレクト */
    @GetMapping("/edit")
    public String editNoId() {
        return "redirect:/stocks";
    }

    /** 削除処理 */
    @PostMapping("/delete/{id}")
    public String delete(@PathVariable Long id) {
        stockService.deleteStock(id);
        return "redirect:/stocks";
    }
}