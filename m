Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2037E65C2E0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjACPTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbjACPTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:19:18 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0B7F5AD
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 07:19:16 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id y8so29765246wrl.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 07:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=frkw+2sa4K20aCLL926sF1F1E/GGEbWHarFjJ8N3yrI=;
        b=F9hGOop3WwWcmh4w7qMuVk4F8YT0chwuvKoBsSInv8Kpbt8wdbaYeHzTLeKx+Y3lSB
         oZvLVvT5uA8myRxu5H6FJbS4UEcb0ICNHnUXu7kKLenVLCG2MxcG6kwaBfDg308H2MBe
         NO7rRgHrXtzks08yNxUnVH3+tOb4G+s2rKPSDeRstc4GCD2kFoWD4ZLuie3sX5XHEysC
         yXQD+HEgMxWm85KMVwJGoStPV51V1Zg4IZ+YWOQI8Me7o6K6sH4jB3tj1uIMR1kLJBqH
         akp4Hv5eSU1dvF1jm4WaTshLfI6/cDWJna82Etws14It9Uay50M74pBdVHuEMKXUtGCP
         qbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=frkw+2sa4K20aCLL926sF1F1E/GGEbWHarFjJ8N3yrI=;
        b=v5YTtIRdmm4ZJicCMRqQzrjc8HZXBn5hMdS7k1eiXqiFJf23VVx05aOlTZppBovV6A
         T3ihaWMsOTQ7pQKAo1vzJn6sa6IVLOank0a1o1s2Yy12x4aaHEFO8DE0tdfWuF3LDIrX
         QExva6IT0oLy6mVdocb7eZygZS6+CG35/WB2gFxU+9jv/1oX55tHHYlp0/7Aqrq0BBO2
         1A1ZNrbNQGtHXmewlQFNGB34aNa8Oquyh03rR0pqXWQra/YKbUqSwAvJZ4VkSQ8ln4Q0
         lOGNN9zLR7YGUufrLKw3lXUyY4/xX3yk9ODrBT7McZVee1KkvvO0D2JkAUrQ9jVN9v57
         RWSw==
X-Gm-Message-State: AFqh2kp8uhSXyfmNlhSeUrEQyUVSAoTus7ox2WcqwF+GB56V1pIyGN2F
        8WoPUS34kB0qfshCuY13qAUrkQ==
X-Google-Smtp-Source: AMrXdXvLZ3/BV8ElG0V+yLc45aUkVjMqqkEZPHqX3YIGP4eoBlETnnIEnu6xzhrdqqa9cfYDq9C64g==
X-Received: by 2002:a5d:5c0e:0:b0:269:70f0:8142 with SMTP id cc14-20020a5d5c0e000000b0026970f08142mr29591186wrb.56.1672759154608;
        Tue, 03 Jan 2023 07:19:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:581d:e915:a047:a9b4? ([2a01:e0a:982:cbb0:581d:e915:a047:a9b4])
        by smtp.gmail.com with ESMTPSA id z13-20020adff74d000000b002366f9bd717sm36798222wrp.45.2023.01.03.07.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 07:19:13 -0800 (PST)
Message-ID: <423a4c05-ccd8-4bcb-b686-c1eba79a6a3d@linaro.org>
Date:   Tue, 3 Jan 2023 16:19:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/3] clk: qcom: add SM8550 DISPCC driver
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230103-topic-sm8550-upstream-dispcc-v1-0-81bfcc26b2dc@linaro.org>
 <20230103-topic-sm8550-upstream-dispcc-v1-3-81bfcc26b2dc@linaro.org>
 <CAA8EJprLTLCskyTOLzfchNt1mrCUu47qMH43REOKbY0c3CxYTw@mail.gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <CAA8EJprLTLCskyTOLzfchNt1mrCUu47qMH43REOKbY0c3CxYTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2023 15:24, Dmitry Baryshkov wrote:
> On Tue, 3 Jan 2023 at 15:54, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> Add support for the display clock controller found in SM8550
>> based devices.
>>
>> This clock controller feeds the Multimedia Display SubSystem (MDSS).
>> This driver is based on the SM8450 support.
> 
> Looks good, few minor nits below:
> 
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/clk/qcom/Kconfig         |    9 +
>>   drivers/clk/qcom/Makefile        |    1 +
>>   drivers/clk/qcom/dispcc-sm8550.c | 1814 ++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 1824 insertions(+)
>>
> 
> [skipped]
> 
>> +static struct clk_regmap_div disp_cc_mdss_byte0_div_clk_src = {
>> +       .reg = 0x8120,
>> +       .shift = 0,
>> +       .width = 4,
>> +       .clkr.hw.init = &(struct clk_init_data) {
>> +               .name = "disp_cc_mdss_byte0_div_clk_src",
>> +               .parent_data = &(const struct clk_parent_data) {
>> +                       .hw = &disp_cc_mdss_byte0_clk_src.clkr.hw,
>> +               },
> 
> We can use parent_hws in such cases (here and below).

Sure, will switch to parent_hws for v2.

> 
>> +               .num_parents = 1,
>> +               .ops = &clk_regmap_div_ops,
>> +       },
>> +};
>> +
>> +static struct clk_regmap_div disp_cc_mdss_byte1_div_clk_src = {
>> +       .reg = 0x813c,
>> +       .shift = 0,
>> +       .width = 4,
>> +       .clkr.hw.init = &(struct clk_init_data) {
>> +               .name = "disp_cc_mdss_byte1_div_clk_src",
>> +               .parent_data = &(const struct clk_parent_data) {
>> +                       .hw = &disp_cc_mdss_byte1_clk_src.clkr.hw,
>> +               },
>> +               .num_parents = 1,
>> +               .ops = &clk_regmap_div_ops,
>> +       },
>> +};
> 
> [skipped most of the clocks]
> 
>> +static struct gdsc mdss_gdsc = {
>> +       .gdscr = 0x9000,
>> +       .pd = {
>> +               .name = "mdss_gdsc",
>> +       },
>> +       .pwrsts = PWRSTS_OFF_ON,
>> +       .flags = HW_CTRL | RETAIN_FF_ENABLE,
>> +};
>> +
>> +static struct gdsc mdss_int2_gdsc = {
>> +       .gdscr = 0xb000,
>> +       .pd = {
>> +               .name = "mdss_int2_gdsc",
>> +       },
>> +       .pwrsts = PWRSTS_OFF_ON,
>> +       .flags = HW_CTRL | RETAIN_FF_ENABLE,
>> +};
>> +
>> +static struct clk_regmap *disp_cc_sm8550_clocks[] = {
>> +       [DISP_CC_MDSS_ACCU_CLK] = &disp_cc_mdss_accu_clk.clkr,
>> +       [DISP_CC_MDSS_AHB1_CLK] = &disp_cc_mdss_ahb1_clk.clkr,
>> +       [DISP_CC_MDSS_AHB_CLK] = &disp_cc_mdss_ahb_clk.clkr,
>> +       [DISP_CC_MDSS_AHB_CLK_SRC] = &disp_cc_mdss_ahb_clk_src.clkr,
>> +       [DISP_CC_MDSS_BYTE0_CLK] = &disp_cc_mdss_byte0_clk.clkr,
>> +       [DISP_CC_MDSS_BYTE0_CLK_SRC] = &disp_cc_mdss_byte0_clk_src.clkr,
>> +       [DISP_CC_MDSS_BYTE0_DIV_CLK_SRC] = &disp_cc_mdss_byte0_div_clk_src.clkr,
>> +       [DISP_CC_MDSS_BYTE0_INTF_CLK] = &disp_cc_mdss_byte0_intf_clk.clkr,
>> +       [DISP_CC_MDSS_BYTE1_CLK] = &disp_cc_mdss_byte1_clk.clkr,
>> +       [DISP_CC_MDSS_BYTE1_CLK_SRC] = &disp_cc_mdss_byte1_clk_src.clkr,
>> +       [DISP_CC_MDSS_BYTE1_DIV_CLK_SRC] = &disp_cc_mdss_byte1_div_clk_src.clkr,
>> +       [DISP_CC_MDSS_BYTE1_INTF_CLK] = &disp_cc_mdss_byte1_intf_clk.clkr,
>> +       [DISP_CC_MDSS_DPTX0_AUX_CLK] = &disp_cc_mdss_dptx0_aux_clk.clkr,
>> +       [DISP_CC_MDSS_DPTX0_AUX_CLK_SRC] = &disp_cc_mdss_dptx0_aux_clk_src.clkr,
>> +       [DISP_CC_MDSS_DPTX0_CRYPTO_CLK] = &disp_cc_mdss_dptx0_crypto_clk.clkr,
>> +       [DISP_CC_MDSS_DPTX0_LINK_CLK] = &disp_cc_mdss_dptx0_link_clk.clkr,
>> +       [DISP_CC_MDSS_DPTX0_LINK_CLK_SRC] = &disp_cc_mdss_dptx0_link_clk_src.clkr,
>> +       [DISP_CC_MDSS_DPTX0_LINK_DIV_CLK_SRC] = &disp_cc_mdss_dptx0_link_div_clk_src.clkr,
>> +       [DISP_CC_MDSS_DPTX0_LINK_INTF_CLK] = &disp_cc_mdss_dptx0_link_intf_clk.clkr,
>> +       [DISP_CC_MDSS_DPTX0_PIXEL0_CLK] = &disp_cc_mdss_dptx0_pixel0_clk.clkr,
>> +       [DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC] = &disp_cc_mdss_dptx0_pixel0_clk_src.clkr,
>> +       [DISP_CC_MDSS_DPTX0_PIXEL1_CLK] = &disp_cc_mdss_dptx0_pixel1_clk.clkr,
>> +       [DISP_CC_MDSS_DPTX0_PIXEL1_CLK_SRC] = &disp_cc_mdss_dptx0_pixel1_clk_src.clkr,
>> +       [DISP_CC_MDSS_DPTX0_USB_ROUTER_LINK_INTF_CLK] =
>> +               &disp_cc_mdss_dptx0_usb_router_link_intf_clk.clkr,
>> +       [DISP_CC_MDSS_DPTX1_AUX_CLK] = &disp_cc_mdss_dptx1_aux_clk.clkr,
>> +       [DISP_CC_MDSS_DPTX1_AUX_CLK_SRC] = &disp_cc_mdss_dptx1_aux_clk_src.clkr,
>> +       [DISP_CC_MDSS_DPTX1_CRYPTO_CLK] = &disp_cc_mdss_dptx1_crypto_clk.clkr,
>> +       [DISP_CC_MDSS_DPTX1_LINK_CLK] = &disp_cc_mdss_dptx1_link_clk.clkr,
>> +       [DISP_CC_MDSS_DPTX1_LINK_CLK_SRC] = &disp_cc_mdss_dptx1_link_clk_src.clkr,
>> +       [DISP_CC_MDSS_DPTX1_LINK_DIV_CLK_SRC] = &disp_cc_mdss_dptx1_link_div_clk_src.clkr,
>> +       [DISP_CC_MDSS_DPTX1_LINK_INTF_CLK] = &disp_cc_mdss_dptx1_link_intf_clk.clkr,
>> +       [DISP_CC_MDSS_DPTX1_PIXEL0_CLK] = &disp_cc_mdss_dptx1_pixel0_clk.clkr,
>> +       [DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC] = &disp_cc_mdss_dptx1_pixel0_clk_src.clkr,
>> +       [DISP_CC_MDSS_DPTX1_PIXEL1_CLK] = &disp_cc_mdss_dptx1_pixel1_clk.clkr,
>> +       [DISP_CC_MDSS_DPTX1_PIXEL1_CLK_SRC] = &disp_cc_mdss_dptx1_pixel1_clk_src.clkr,
>> +       [DISP_CC_MDSS_DPTX1_USB_ROUTER_LINK_INTF_CLK] =
>> +               &disp_cc_mdss_dptx1_usb_router_link_intf_clk.clkr,
>> +       [DISP_CC_MDSS_DPTX2_AUX_CLK] = &disp_cc_mdss_dptx2_aux_clk.clkr,
>> +       [DISP_CC_MDSS_DPTX2_AUX_CLK_SRC] = &disp_cc_mdss_dptx2_aux_clk_src.clkr,
>> +       [DISP_CC_MDSS_DPTX2_CRYPTO_CLK] = &disp_cc_mdss_dptx2_crypto_clk.clkr,
>> +       [DISP_CC_MDSS_DPTX2_LINK_CLK] = &disp_cc_mdss_dptx2_link_clk.clkr,
>> +       [DISP_CC_MDSS_DPTX2_LINK_CLK_SRC] = &disp_cc_mdss_dptx2_link_clk_src.clkr,
>> +       [DISP_CC_MDSS_DPTX2_LINK_DIV_CLK_SRC] = &disp_cc_mdss_dptx2_link_div_clk_src.clkr,
>> +       [DISP_CC_MDSS_DPTX2_LINK_INTF_CLK] = &disp_cc_mdss_dptx2_link_intf_clk.clkr,
>> +       [DISP_CC_MDSS_DPTX2_PIXEL0_CLK] = &disp_cc_mdss_dptx2_pixel0_clk.clkr,
>> +       [DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC] = &disp_cc_mdss_dptx2_pixel0_clk_src.clkr,
>> +       [DISP_CC_MDSS_DPTX2_PIXEL1_CLK] = &disp_cc_mdss_dptx2_pixel1_clk.clkr,
>> +       [DISP_CC_MDSS_DPTX2_PIXEL1_CLK_SRC] = &disp_cc_mdss_dptx2_pixel1_clk_src.clkr,
>> +       [DISP_CC_MDSS_DPTX3_AUX_CLK] = &disp_cc_mdss_dptx3_aux_clk.clkr,
>> +       [DISP_CC_MDSS_DPTX3_AUX_CLK_SRC] = &disp_cc_mdss_dptx3_aux_clk_src.clkr,
>> +       [DISP_CC_MDSS_DPTX3_CRYPTO_CLK] = &disp_cc_mdss_dptx3_crypto_clk.clkr,
>> +       [DISP_CC_MDSS_DPTX3_LINK_CLK] = &disp_cc_mdss_dptx3_link_clk.clkr,
>> +       [DISP_CC_MDSS_DPTX3_LINK_CLK_SRC] = &disp_cc_mdss_dptx3_link_clk_src.clkr,
>> +       [DISP_CC_MDSS_DPTX3_LINK_DIV_CLK_SRC] = &disp_cc_mdss_dptx3_link_div_clk_src.clkr,
>> +       [DISP_CC_MDSS_DPTX3_LINK_INTF_CLK] = &disp_cc_mdss_dptx3_link_intf_clk.clkr,
>> +       [DISP_CC_MDSS_DPTX3_PIXEL0_CLK] = &disp_cc_mdss_dptx3_pixel0_clk.clkr,
>> +       [DISP_CC_MDSS_DPTX3_PIXEL0_CLK_SRC] = &disp_cc_mdss_dptx3_pixel0_clk_src.clkr,
>> +       [DISP_CC_MDSS_ESC0_CLK] = &disp_cc_mdss_esc0_clk.clkr,
>> +       [DISP_CC_MDSS_ESC0_CLK_SRC] = &disp_cc_mdss_esc0_clk_src.clkr,
>> +       [DISP_CC_MDSS_ESC1_CLK] = &disp_cc_mdss_esc1_clk.clkr,
>> +       [DISP_CC_MDSS_ESC1_CLK_SRC] = &disp_cc_mdss_esc1_clk_src.clkr,
>> +       [DISP_CC_MDSS_MDP1_CLK] = &disp_cc_mdss_mdp1_clk.clkr,
>> +       [DISP_CC_MDSS_MDP_CLK] = &disp_cc_mdss_mdp_clk.clkr,
>> +       [DISP_CC_MDSS_MDP_CLK_SRC] = &disp_cc_mdss_mdp_clk_src.clkr,
>> +       [DISP_CC_MDSS_MDP_LUT1_CLK] = &disp_cc_mdss_mdp_lut1_clk.clkr,
>> +       [DISP_CC_MDSS_MDP_LUT_CLK] = &disp_cc_mdss_mdp_lut_clk.clkr,
>> +       [DISP_CC_MDSS_NON_GDSC_AHB_CLK] = &disp_cc_mdss_non_gdsc_ahb_clk.clkr,
>> +       [DISP_CC_MDSS_PCLK0_CLK] = &disp_cc_mdss_pclk0_clk.clkr,
>> +       [DISP_CC_MDSS_PCLK0_CLK_SRC] = &disp_cc_mdss_pclk0_clk_src.clkr,
>> +       [DISP_CC_MDSS_PCLK1_CLK] = &disp_cc_mdss_pclk1_clk.clkr,
>> +       [DISP_CC_MDSS_PCLK1_CLK_SRC] = &disp_cc_mdss_pclk1_clk_src.clkr,
>> +       [DISP_CC_MDSS_RSCC_AHB_CLK] = &disp_cc_mdss_rscc_ahb_clk.clkr,
>> +       [DISP_CC_MDSS_RSCC_VSYNC_CLK] = &disp_cc_mdss_rscc_vsync_clk.clkr,
>> +       [DISP_CC_MDSS_VSYNC1_CLK] = &disp_cc_mdss_vsync1_clk.clkr,
>> +       [DISP_CC_MDSS_VSYNC_CLK] = &disp_cc_mdss_vsync_clk.clkr,
>> +       [DISP_CC_MDSS_VSYNC_CLK_SRC] = &disp_cc_mdss_vsync_clk_src.clkr,
>> +       [DISP_CC_PLL0] = &disp_cc_pll0.clkr,
>> +       [DISP_CC_PLL1] = &disp_cc_pll1.clkr,
>> +       [DISP_CC_SLEEP_CLK] = &disp_cc_sleep_clk.clkr,
>> +       [DISP_CC_SLEEP_CLK_SRC] = &disp_cc_sleep_clk_src.clkr,
>> +       [DISP_CC_XO_CLK_SRC] = &disp_cc_xo_clk_src.clkr,
>> +};
>> +
>> +static const struct qcom_reset_map disp_cc_sm8550_resets[] = {
>> +       [DISP_CC_MDSS_CORE_BCR] = { 0x8000 },
>> +       [DISP_CC_MDSS_CORE_INT2_BCR] = { 0xa000 },
>> +       [DISP_CC_MDSS_RSCC_BCR] = { 0xc000 },
>> +};
>> +
>> +static struct gdsc *disp_cc_sm8550_gdscs[] = {
>> +       [MDSS_GDSC] = &mdss_gdsc,
>> +       [MDSS_INT2_GDSC] = &mdss_int2_gdsc,
>> +};
>> +
>> +static const struct regmap_config disp_cc_sm8550_regmap_config = {
>> +       .reg_bits = 32,
>> +       .reg_stride = 4,
>> +       .val_bits = 32,
>> +       .max_register = 0x11008,
>> +       .fast_io = true,
>> +};
>> +
>> +static struct qcom_cc_desc disp_cc_sm8550_desc = {
>> +       .config = &disp_cc_sm8550_regmap_config,
>> +       .clks = disp_cc_sm8550_clocks,
>> +       .num_clks = ARRAY_SIZE(disp_cc_sm8550_clocks),
>> +       .resets = disp_cc_sm8550_resets,
>> +       .num_resets = ARRAY_SIZE(disp_cc_sm8550_resets),
>> +       .gdscs = disp_cc_sm8550_gdscs,
>> +       .num_gdscs = ARRAY_SIZE(disp_cc_sm8550_gdscs),
>> +};
>> +
>> +static const struct of_device_id disp_cc_sm8550_match_table[] = {
>> +       { .compatible = "qcom,sm8550-dispcc" },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(of, disp_cc_sm8550_match_table);
>> +
>> +static void disp_cc_sm8550_pm_runtime_disable(void *data)
>> +{
>> +       pm_runtime_disable(data);
>> +}
>> +
>> +static int disp_cc_sm8550_probe(struct platform_device *pdev)
>> +{
>> +       struct regmap *regmap;
>> +       int ret;
>> +
>> +       pm_runtime_enable(&pdev->dev);
> 
> We can use devm_pm_runtime_enable() here.

Ack

Thanks,
Neil

> 
>> +
>> +       ret = devm_add_action_or_reset(&pdev->dev, disp_cc_sm8550_pm_runtime_disable, &pdev->dev);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = pm_runtime_resume_and_get(&pdev->dev);
>> +       if (ret)
>> +               return ret;
>> +
>> +       regmap = qcom_cc_map(pdev, &disp_cc_sm8550_desc);
>> +       if (IS_ERR(regmap))
>> +               return PTR_ERR(regmap);
>> +
>> +       clk_lucid_evo_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
>> +       clk_lucid_evo_pll_configure(&disp_cc_pll1, regmap, &disp_cc_pll1_config);
>> +
>> +       /* Enable clock gating for MDP clocks */
>> +       regmap_update_bits(regmap, DISP_CC_MISC_CMD, 0x10, 0x10);
>> +
>> +       /*
>> +        * Keep clocks always enabled:
>> +        *      disp_cc_xo_clk
>> +        */
>> +       regmap_update_bits(regmap, 0xe054, BIT(0), BIT(0));
>> +
>> +       ret = qcom_cc_really_probe(pdev, &disp_cc_sm8550_desc, regmap);
>> +
>> +       pm_runtime_put(&pdev->dev);
>> +
>> +       return ret;
>> +}
>> +
>> +static struct platform_driver disp_cc_sm8550_driver = {
>> +       .probe = disp_cc_sm8550_probe,
>> +       .driver = {
>> +               .name = "disp_cc-sm8550",
>> +               .of_match_table = disp_cc_sm8550_match_table,
>> +       },
>> +};
>> +
>> +static int __init disp_cc_sm8550_init(void)
>> +{
>> +       return platform_driver_register(&disp_cc_sm8550_driver);
>> +}
>> +subsys_initcall(disp_cc_sm8550_init);
>> +
>> +static void __exit disp_cc_sm8550_exit(void)
>> +{
>> +       platform_driver_unregister(&disp_cc_sm8550_driver);
>> +}
>> +module_exit(disp_cc_sm8550_exit);
>> +
>> +MODULE_DESCRIPTION("QTI DISPCC SM8550 Driver");
>> +MODULE_LICENSE("GPL");
>>
>> --
>> 2.34.1
> 
> 
> 

