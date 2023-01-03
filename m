Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5906065C1E7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjACOZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238005AbjACOZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:25:04 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7222120BF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:24:23 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-466c5fb1c39so425637977b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 06:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NE5M4o+uQQasvN424i3ug4ExVm+nFuQNfHX3PyiYrhY=;
        b=i3jwR45oeE2d35x6ntkFfkol7/wtQxjvWn0I0lU5AyI9apocva0aLf5om/lKbpSFc9
         nqVX/42fAyDN+D8kQahGzdNS/dFfR7vgJVty93UCDArtK8vUvUDu/Bov8t8WXdUacmaX
         06VUEBM8F53prRApJYuAOdrBdtkQkNpYWMUdLaU+Ht+g57ofJZjv3TtIJlCU/MhgKWof
         IRlfHBJgjw80yoyl8oK4pzui0Ouqx1XtA/Jem5nKyBvDgczgJvNQo5Am1SnYHmN7PX23
         vbBpW1u4S0GysFGuZ9iqHMeu6tjvdVV9aGPFHSmZLoiHp+pMjIoJHvmnH0N9ud+Pg7SA
         qUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NE5M4o+uQQasvN424i3ug4ExVm+nFuQNfHX3PyiYrhY=;
        b=F/cPEqD4flJ3hK2wb+KIbOPfwOTWaKlWxIsxCT235PjuzFNQyv/SfQIgI1xWYt1bBO
         Dlv5QcjCbqhouR5yW/efh+77a5bbQTHHgS1yAoipBbgrp3zKgjofzjaojoOj3rlpvzSY
         0SQZAHWD+VyztBa6R/WLePDC/cWXJN/5dBCTJM/Gkce9YQH/602BzWxEN/+2Ud5A8vkH
         f2QJFO8gPApTrYqf+VigHf3avGPL6N70DHK54YjXApg2C+qBxZBJ5jEiQdPLz4d4srGl
         cYIXc5FltKHJXDaoPBEvGRh1FdUHgroxbjF29HFlTh+hMcY+n4RnLd4nX/4LPrQIZl0U
         X+YQ==
X-Gm-Message-State: AFqh2krx28xazWZKfLwnoj88xHwg5awuUOHmFBW/us5xl7OWoQUCUj/q
        EQ9A2tm4Bagy8F6vxmi3shRbfKkaxIlcCbHv/bTkOA==
X-Google-Smtp-Source: AMrXdXvfTDeGRopOZf2rluGeZaq7+pVIG0eHIP/6bV4NHM+1knLBXuE/oXdbslh3vqljSqaxplnY3e2rVZMChqZXziM=
X-Received: by 2002:a0d:dc86:0:b0:3d5:ecbb:2923 with SMTP id
 f128-20020a0ddc86000000b003d5ecbb2923mr5716457ywe.485.1672755863093; Tue, 03
 Jan 2023 06:24:23 -0800 (PST)
MIME-Version: 1.0
References: <20230103-topic-sm8550-upstream-dispcc-v1-0-81bfcc26b2dc@linaro.org>
 <20230103-topic-sm8550-upstream-dispcc-v1-3-81bfcc26b2dc@linaro.org>
In-Reply-To: <20230103-topic-sm8550-upstream-dispcc-v1-3-81bfcc26b2dc@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 3 Jan 2023 16:24:11 +0200
Message-ID: <CAA8EJprLTLCskyTOLzfchNt1mrCUu47qMH43REOKbY0c3CxYTw@mail.gmail.com>
Subject: Re: [PATCH 3/3] clk: qcom: add SM8550 DISPCC driver
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jan 2023 at 15:54, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Add support for the display clock controller found in SM8550
> based devices.
>
> This clock controller feeds the Multimedia Display SubSystem (MDSS).
> This driver is based on the SM8450 support.

Looks good, few minor nits below:

>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/clk/qcom/Kconfig         |    9 +
>  drivers/clk/qcom/Makefile        |    1 +
>  drivers/clk/qcom/dispcc-sm8550.c | 1814 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1824 insertions(+)
>

[skipped]

> +static struct clk_regmap_div disp_cc_mdss_byte0_div_clk_src = {
> +       .reg = 0x8120,
> +       .shift = 0,
> +       .width = 4,
> +       .clkr.hw.init = &(struct clk_init_data) {
> +               .name = "disp_cc_mdss_byte0_div_clk_src",
> +               .parent_data = &(const struct clk_parent_data) {
> +                       .hw = &disp_cc_mdss_byte0_clk_src.clkr.hw,
> +               },

We can use parent_hws in such cases (here and below).

> +               .num_parents = 1,
> +               .ops = &clk_regmap_div_ops,
> +       },
> +};
> +
> +static struct clk_regmap_div disp_cc_mdss_byte1_div_clk_src = {
> +       .reg = 0x813c,
> +       .shift = 0,
> +       .width = 4,
> +       .clkr.hw.init = &(struct clk_init_data) {
> +               .name = "disp_cc_mdss_byte1_div_clk_src",
> +               .parent_data = &(const struct clk_parent_data) {
> +                       .hw = &disp_cc_mdss_byte1_clk_src.clkr.hw,
> +               },
> +               .num_parents = 1,
> +               .ops = &clk_regmap_div_ops,
> +       },
> +};

[skipped most of the clocks]

> +static struct gdsc mdss_gdsc = {
> +       .gdscr = 0x9000,
> +       .pd = {
> +               .name = "mdss_gdsc",
> +       },
> +       .pwrsts = PWRSTS_OFF_ON,
> +       .flags = HW_CTRL | RETAIN_FF_ENABLE,
> +};
> +
> +static struct gdsc mdss_int2_gdsc = {
> +       .gdscr = 0xb000,
> +       .pd = {
> +               .name = "mdss_int2_gdsc",
> +       },
> +       .pwrsts = PWRSTS_OFF_ON,
> +       .flags = HW_CTRL | RETAIN_FF_ENABLE,
> +};
> +
> +static struct clk_regmap *disp_cc_sm8550_clocks[] = {
> +       [DISP_CC_MDSS_ACCU_CLK] = &disp_cc_mdss_accu_clk.clkr,
> +       [DISP_CC_MDSS_AHB1_CLK] = &disp_cc_mdss_ahb1_clk.clkr,
> +       [DISP_CC_MDSS_AHB_CLK] = &disp_cc_mdss_ahb_clk.clkr,
> +       [DISP_CC_MDSS_AHB_CLK_SRC] = &disp_cc_mdss_ahb_clk_src.clkr,
> +       [DISP_CC_MDSS_BYTE0_CLK] = &disp_cc_mdss_byte0_clk.clkr,
> +       [DISP_CC_MDSS_BYTE0_CLK_SRC] = &disp_cc_mdss_byte0_clk_src.clkr,
> +       [DISP_CC_MDSS_BYTE0_DIV_CLK_SRC] = &disp_cc_mdss_byte0_div_clk_src.clkr,
> +       [DISP_CC_MDSS_BYTE0_INTF_CLK] = &disp_cc_mdss_byte0_intf_clk.clkr,
> +       [DISP_CC_MDSS_BYTE1_CLK] = &disp_cc_mdss_byte1_clk.clkr,
> +       [DISP_CC_MDSS_BYTE1_CLK_SRC] = &disp_cc_mdss_byte1_clk_src.clkr,
> +       [DISP_CC_MDSS_BYTE1_DIV_CLK_SRC] = &disp_cc_mdss_byte1_div_clk_src.clkr,
> +       [DISP_CC_MDSS_BYTE1_INTF_CLK] = &disp_cc_mdss_byte1_intf_clk.clkr,
> +       [DISP_CC_MDSS_DPTX0_AUX_CLK] = &disp_cc_mdss_dptx0_aux_clk.clkr,
> +       [DISP_CC_MDSS_DPTX0_AUX_CLK_SRC] = &disp_cc_mdss_dptx0_aux_clk_src.clkr,
> +       [DISP_CC_MDSS_DPTX0_CRYPTO_CLK] = &disp_cc_mdss_dptx0_crypto_clk.clkr,
> +       [DISP_CC_MDSS_DPTX0_LINK_CLK] = &disp_cc_mdss_dptx0_link_clk.clkr,
> +       [DISP_CC_MDSS_DPTX0_LINK_CLK_SRC] = &disp_cc_mdss_dptx0_link_clk_src.clkr,
> +       [DISP_CC_MDSS_DPTX0_LINK_DIV_CLK_SRC] = &disp_cc_mdss_dptx0_link_div_clk_src.clkr,
> +       [DISP_CC_MDSS_DPTX0_LINK_INTF_CLK] = &disp_cc_mdss_dptx0_link_intf_clk.clkr,
> +       [DISP_CC_MDSS_DPTX0_PIXEL0_CLK] = &disp_cc_mdss_dptx0_pixel0_clk.clkr,
> +       [DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC] = &disp_cc_mdss_dptx0_pixel0_clk_src.clkr,
> +       [DISP_CC_MDSS_DPTX0_PIXEL1_CLK] = &disp_cc_mdss_dptx0_pixel1_clk.clkr,
> +       [DISP_CC_MDSS_DPTX0_PIXEL1_CLK_SRC] = &disp_cc_mdss_dptx0_pixel1_clk_src.clkr,
> +       [DISP_CC_MDSS_DPTX0_USB_ROUTER_LINK_INTF_CLK] =
> +               &disp_cc_mdss_dptx0_usb_router_link_intf_clk.clkr,
> +       [DISP_CC_MDSS_DPTX1_AUX_CLK] = &disp_cc_mdss_dptx1_aux_clk.clkr,
> +       [DISP_CC_MDSS_DPTX1_AUX_CLK_SRC] = &disp_cc_mdss_dptx1_aux_clk_src.clkr,
> +       [DISP_CC_MDSS_DPTX1_CRYPTO_CLK] = &disp_cc_mdss_dptx1_crypto_clk.clkr,
> +       [DISP_CC_MDSS_DPTX1_LINK_CLK] = &disp_cc_mdss_dptx1_link_clk.clkr,
> +       [DISP_CC_MDSS_DPTX1_LINK_CLK_SRC] = &disp_cc_mdss_dptx1_link_clk_src.clkr,
> +       [DISP_CC_MDSS_DPTX1_LINK_DIV_CLK_SRC] = &disp_cc_mdss_dptx1_link_div_clk_src.clkr,
> +       [DISP_CC_MDSS_DPTX1_LINK_INTF_CLK] = &disp_cc_mdss_dptx1_link_intf_clk.clkr,
> +       [DISP_CC_MDSS_DPTX1_PIXEL0_CLK] = &disp_cc_mdss_dptx1_pixel0_clk.clkr,
> +       [DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC] = &disp_cc_mdss_dptx1_pixel0_clk_src.clkr,
> +       [DISP_CC_MDSS_DPTX1_PIXEL1_CLK] = &disp_cc_mdss_dptx1_pixel1_clk.clkr,
> +       [DISP_CC_MDSS_DPTX1_PIXEL1_CLK_SRC] = &disp_cc_mdss_dptx1_pixel1_clk_src.clkr,
> +       [DISP_CC_MDSS_DPTX1_USB_ROUTER_LINK_INTF_CLK] =
> +               &disp_cc_mdss_dptx1_usb_router_link_intf_clk.clkr,
> +       [DISP_CC_MDSS_DPTX2_AUX_CLK] = &disp_cc_mdss_dptx2_aux_clk.clkr,
> +       [DISP_CC_MDSS_DPTX2_AUX_CLK_SRC] = &disp_cc_mdss_dptx2_aux_clk_src.clkr,
> +       [DISP_CC_MDSS_DPTX2_CRYPTO_CLK] = &disp_cc_mdss_dptx2_crypto_clk.clkr,
> +       [DISP_CC_MDSS_DPTX2_LINK_CLK] = &disp_cc_mdss_dptx2_link_clk.clkr,
> +       [DISP_CC_MDSS_DPTX2_LINK_CLK_SRC] = &disp_cc_mdss_dptx2_link_clk_src.clkr,
> +       [DISP_CC_MDSS_DPTX2_LINK_DIV_CLK_SRC] = &disp_cc_mdss_dptx2_link_div_clk_src.clkr,
> +       [DISP_CC_MDSS_DPTX2_LINK_INTF_CLK] = &disp_cc_mdss_dptx2_link_intf_clk.clkr,
> +       [DISP_CC_MDSS_DPTX2_PIXEL0_CLK] = &disp_cc_mdss_dptx2_pixel0_clk.clkr,
> +       [DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC] = &disp_cc_mdss_dptx2_pixel0_clk_src.clkr,
> +       [DISP_CC_MDSS_DPTX2_PIXEL1_CLK] = &disp_cc_mdss_dptx2_pixel1_clk.clkr,
> +       [DISP_CC_MDSS_DPTX2_PIXEL1_CLK_SRC] = &disp_cc_mdss_dptx2_pixel1_clk_src.clkr,
> +       [DISP_CC_MDSS_DPTX3_AUX_CLK] = &disp_cc_mdss_dptx3_aux_clk.clkr,
> +       [DISP_CC_MDSS_DPTX3_AUX_CLK_SRC] = &disp_cc_mdss_dptx3_aux_clk_src.clkr,
> +       [DISP_CC_MDSS_DPTX3_CRYPTO_CLK] = &disp_cc_mdss_dptx3_crypto_clk.clkr,
> +       [DISP_CC_MDSS_DPTX3_LINK_CLK] = &disp_cc_mdss_dptx3_link_clk.clkr,
> +       [DISP_CC_MDSS_DPTX3_LINK_CLK_SRC] = &disp_cc_mdss_dptx3_link_clk_src.clkr,
> +       [DISP_CC_MDSS_DPTX3_LINK_DIV_CLK_SRC] = &disp_cc_mdss_dptx3_link_div_clk_src.clkr,
> +       [DISP_CC_MDSS_DPTX3_LINK_INTF_CLK] = &disp_cc_mdss_dptx3_link_intf_clk.clkr,
> +       [DISP_CC_MDSS_DPTX3_PIXEL0_CLK] = &disp_cc_mdss_dptx3_pixel0_clk.clkr,
> +       [DISP_CC_MDSS_DPTX3_PIXEL0_CLK_SRC] = &disp_cc_mdss_dptx3_pixel0_clk_src.clkr,
> +       [DISP_CC_MDSS_ESC0_CLK] = &disp_cc_mdss_esc0_clk.clkr,
> +       [DISP_CC_MDSS_ESC0_CLK_SRC] = &disp_cc_mdss_esc0_clk_src.clkr,
> +       [DISP_CC_MDSS_ESC1_CLK] = &disp_cc_mdss_esc1_clk.clkr,
> +       [DISP_CC_MDSS_ESC1_CLK_SRC] = &disp_cc_mdss_esc1_clk_src.clkr,
> +       [DISP_CC_MDSS_MDP1_CLK] = &disp_cc_mdss_mdp1_clk.clkr,
> +       [DISP_CC_MDSS_MDP_CLK] = &disp_cc_mdss_mdp_clk.clkr,
> +       [DISP_CC_MDSS_MDP_CLK_SRC] = &disp_cc_mdss_mdp_clk_src.clkr,
> +       [DISP_CC_MDSS_MDP_LUT1_CLK] = &disp_cc_mdss_mdp_lut1_clk.clkr,
> +       [DISP_CC_MDSS_MDP_LUT_CLK] = &disp_cc_mdss_mdp_lut_clk.clkr,
> +       [DISP_CC_MDSS_NON_GDSC_AHB_CLK] = &disp_cc_mdss_non_gdsc_ahb_clk.clkr,
> +       [DISP_CC_MDSS_PCLK0_CLK] = &disp_cc_mdss_pclk0_clk.clkr,
> +       [DISP_CC_MDSS_PCLK0_CLK_SRC] = &disp_cc_mdss_pclk0_clk_src.clkr,
> +       [DISP_CC_MDSS_PCLK1_CLK] = &disp_cc_mdss_pclk1_clk.clkr,
> +       [DISP_CC_MDSS_PCLK1_CLK_SRC] = &disp_cc_mdss_pclk1_clk_src.clkr,
> +       [DISP_CC_MDSS_RSCC_AHB_CLK] = &disp_cc_mdss_rscc_ahb_clk.clkr,
> +       [DISP_CC_MDSS_RSCC_VSYNC_CLK] = &disp_cc_mdss_rscc_vsync_clk.clkr,
> +       [DISP_CC_MDSS_VSYNC1_CLK] = &disp_cc_mdss_vsync1_clk.clkr,
> +       [DISP_CC_MDSS_VSYNC_CLK] = &disp_cc_mdss_vsync_clk.clkr,
> +       [DISP_CC_MDSS_VSYNC_CLK_SRC] = &disp_cc_mdss_vsync_clk_src.clkr,
> +       [DISP_CC_PLL0] = &disp_cc_pll0.clkr,
> +       [DISP_CC_PLL1] = &disp_cc_pll1.clkr,
> +       [DISP_CC_SLEEP_CLK] = &disp_cc_sleep_clk.clkr,
> +       [DISP_CC_SLEEP_CLK_SRC] = &disp_cc_sleep_clk_src.clkr,
> +       [DISP_CC_XO_CLK_SRC] = &disp_cc_xo_clk_src.clkr,
> +};
> +
> +static const struct qcom_reset_map disp_cc_sm8550_resets[] = {
> +       [DISP_CC_MDSS_CORE_BCR] = { 0x8000 },
> +       [DISP_CC_MDSS_CORE_INT2_BCR] = { 0xa000 },
> +       [DISP_CC_MDSS_RSCC_BCR] = { 0xc000 },
> +};
> +
> +static struct gdsc *disp_cc_sm8550_gdscs[] = {
> +       [MDSS_GDSC] = &mdss_gdsc,
> +       [MDSS_INT2_GDSC] = &mdss_int2_gdsc,
> +};
> +
> +static const struct regmap_config disp_cc_sm8550_regmap_config = {
> +       .reg_bits = 32,
> +       .reg_stride = 4,
> +       .val_bits = 32,
> +       .max_register = 0x11008,
> +       .fast_io = true,
> +};
> +
> +static struct qcom_cc_desc disp_cc_sm8550_desc = {
> +       .config = &disp_cc_sm8550_regmap_config,
> +       .clks = disp_cc_sm8550_clocks,
> +       .num_clks = ARRAY_SIZE(disp_cc_sm8550_clocks),
> +       .resets = disp_cc_sm8550_resets,
> +       .num_resets = ARRAY_SIZE(disp_cc_sm8550_resets),
> +       .gdscs = disp_cc_sm8550_gdscs,
> +       .num_gdscs = ARRAY_SIZE(disp_cc_sm8550_gdscs),
> +};
> +
> +static const struct of_device_id disp_cc_sm8550_match_table[] = {
> +       { .compatible = "qcom,sm8550-dispcc" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, disp_cc_sm8550_match_table);
> +
> +static void disp_cc_sm8550_pm_runtime_disable(void *data)
> +{
> +       pm_runtime_disable(data);
> +}
> +
> +static int disp_cc_sm8550_probe(struct platform_device *pdev)
> +{
> +       struct regmap *regmap;
> +       int ret;
> +
> +       pm_runtime_enable(&pdev->dev);

We can use devm_pm_runtime_enable() here.

> +
> +       ret = devm_add_action_or_reset(&pdev->dev, disp_cc_sm8550_pm_runtime_disable, &pdev->dev);
> +       if (ret)
> +               return ret;
> +
> +       ret = pm_runtime_resume_and_get(&pdev->dev);
> +       if (ret)
> +               return ret;
> +
> +       regmap = qcom_cc_map(pdev, &disp_cc_sm8550_desc);
> +       if (IS_ERR(regmap))
> +               return PTR_ERR(regmap);
> +
> +       clk_lucid_evo_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
> +       clk_lucid_evo_pll_configure(&disp_cc_pll1, regmap, &disp_cc_pll1_config);
> +
> +       /* Enable clock gating for MDP clocks */
> +       regmap_update_bits(regmap, DISP_CC_MISC_CMD, 0x10, 0x10);
> +
> +       /*
> +        * Keep clocks always enabled:
> +        *      disp_cc_xo_clk
> +        */
> +       regmap_update_bits(regmap, 0xe054, BIT(0), BIT(0));
> +
> +       ret = qcom_cc_really_probe(pdev, &disp_cc_sm8550_desc, regmap);
> +
> +       pm_runtime_put(&pdev->dev);
> +
> +       return ret;
> +}
> +
> +static struct platform_driver disp_cc_sm8550_driver = {
> +       .probe = disp_cc_sm8550_probe,
> +       .driver = {
> +               .name = "disp_cc-sm8550",
> +               .of_match_table = disp_cc_sm8550_match_table,
> +       },
> +};
> +
> +static int __init disp_cc_sm8550_init(void)
> +{
> +       return platform_driver_register(&disp_cc_sm8550_driver);
> +}
> +subsys_initcall(disp_cc_sm8550_init);
> +
> +static void __exit disp_cc_sm8550_exit(void)
> +{
> +       platform_driver_unregister(&disp_cc_sm8550_driver);
> +}
> +module_exit(disp_cc_sm8550_exit);
> +
> +MODULE_DESCRIPTION("QTI DISPCC SM8550 Driver");
> +MODULE_LICENSE("GPL");
>
> --
> 2.34.1



-- 
With best wishes
Dmitry
