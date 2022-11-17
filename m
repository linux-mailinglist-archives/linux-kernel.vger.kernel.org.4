Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E38962D4CE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239489AbiKQILA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239456AbiKQIKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:10:53 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669D66BDDD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:10:52 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id v7so855644wmn.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rS3CeytroYBrMcNfPAlV3kO7KBX6UypX1JFTunmJQ6E=;
        b=MUvEyxH4DRxNaF7xFHViK9OG50/qiE94TeFhQ+WKPXbtu6yvEkisNv6BqW/aWMDeXc
         4r1osV2RoM4r8EyV5Wwv6u/NV5VEMEIpDAHkTWv6RjKGQFzq4TaUbp48aJ/DCqfpQawO
         UU7bA/vtI+Tp3wGKuTUUkQhvCzrG606jDgwTDqw2ya5/z9NX4b16BZ5uIsRUCWssM0Qv
         L60ckv466eVN761sHHu3/wODYF2FMoR0/NEW2164I14r2QFYx1ubP5pClJwT/kLJvFPO
         t1Uk9CcWH1vytbnggod9PT2k4YKKwVu6JgMNquDBaJFr9DUlJnuEJm8ZryFgMAwUWaiN
         BvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rS3CeytroYBrMcNfPAlV3kO7KBX6UypX1JFTunmJQ6E=;
        b=0TLpF3SoXbcbLrbpJxAIYj3XDX5bnAr0Gjh3c80crBSCwKGt0Czz58sg7nrZmeT6SI
         pGTF0ZpSgTZ4PSo7gApdrI/FzRVEKOUjD5tolQsC045nJLLim/r43+i1bV2mYwMJK1nD
         UBelifbmn/kf05eMh5sGA/FdQ9DtZmMHu7r6WgS6/85ejUmPwpkbw61v6SHCb8V52nPa
         r/PyQCUDLzkvUoZuoBFSuBqLFJCpsIGGuw2mWiImAybON5bCW9DMjFrxSESwemSpk+Rc
         umg3cxVXrhtGXL+vOsAwvo/de4oWGIaxVN9vsNZwLFXbySWP0G0Tc88nNDE3L7UvWT0m
         9grw==
X-Gm-Message-State: ANoB5pk8NrviH0/uc6DRG6UeDtUpK2bMtiZQjhWAUTqpT4rG/rOiFjOJ
        29VnEwvkxKRI09Lddqhfi/u8WQ==
X-Google-Smtp-Source: AA0mqf6DHcphfUQiQ1Qf31pjKrpHs6JhRRfu6R33TLUn1mY/HZDYnfvDwkZp8OgPXhOEszdnwb0PNA==
X-Received: by 2002:a05:600c:5389:b0:3cf:a343:9a28 with SMTP id hg9-20020a05600c538900b003cfa3439a28mr4369653wmb.186.1668672650950;
        Thu, 17 Nov 2022 00:10:50 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id t6-20020a5d6906000000b0022e47b57735sm219490wru.97.2022.11.17.00.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 00:10:50 -0800 (PST)
Date:   Thu, 17 Nov 2022 10:10:48 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 7/9] clk: qcom: rpmh: Add support for SM8550 rpmh clocks
Message-ID: <Y3XsiDSQNQ7Squaz@linaro.org>
References: <20221116104716.2583320-1-abel.vesa@linaro.org>
 <20221116104716.2583320-8-abel.vesa@linaro.org>
 <010238f2-f520-41b8-c2cf-d65e9c12160d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010238f2-f520-41b8-c2cf-d65e9c12160d@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-11-16 12:27:16, Konrad Dybcio wrote:
> 
> 
> On 16/11/2022 11:47, Abel Vesa wrote:
> > Adds the RPMH clocks present in SM8550 SoC.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >   drivers/clk/qcom/clk-rpmh.c | 110 +++++++++++++++++++++++++++++-------
> >   1 file changed, 90 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> > index 1da45a6e2f29..63975490ab54 100644
> > --- a/drivers/clk/qcom/clk-rpmh.c
> > +++ b/drivers/clk/qcom/clk-rpmh.c
> > @@ -579,6 +579,73 @@ static const struct clk_rpmh_desc clk_rpmh_sm8450 = {
> >   	.num_clks = ARRAY_SIZE(sm8450_rpmh_clocks),
> >   };
> > +#define DEFINE_CLK_RPMH_FIXED(_platform, _name, _name_active,	\
> > +				  _parent_name, _name_active_parent,	\
> > +				  _div)					\
> > +	static struct clk_fixed_factor _platform##_##_name = {		\
> > +		.mult = 1,						\
> > +		.div = _div,						\
> > +		.hw.init = &(struct clk_init_data){			\
> > +			.ops = &clk_fixed_factor_ops,			\
> > +			.name = #_name,					\
> > +			.parent_data =  &(const struct clk_parent_data){ \
> > +					.fw_name = #_parent_name,	\
> > +					.name = #_parent_name,		\
> No need to introduce .name if we do DT properly from the get-go, I think

Sure. Will drop it. Will also move the define up, close to the other
ones.

Thanks,
Abel

> 
> 
> Konrad
> > +			},						\
> > +			.num_parents = 1,				\
> > +		},							\
> > +	};								\
> > +	static struct clk_fixed_factor _platform##_##_name_active = {	\
> > +		.mult = 1,						\
> > +		.div = _div,						\
> > +		.hw.init = &(struct clk_init_data){			\
> > +			.ops = &clk_fixed_factor_ops,			\
> > +			.name = #_name_active,				\
> > +			.parent_data =  &(const struct clk_parent_data){ \
> > +					.fw_name = #_name_active_parent,\
> > +					.name = #_name_active_parent,	\
> > +			},						\
> > +			.num_parents = 1,				\
> > +		},							\
> > +	}
> > +
> > +DEFINE_CLK_RPMH_ARC(sm8550, xo_pad, xo_pad_ao, "xo.lvl", 0x03, 2);
> > +DEFINE_CLK_RPMH_FIXED(sm8550, bi_tcxo, bi_tcxo_ao, xo_pad, xo_pad_ao, 2);
> > +DEFINE_CLK_RPMH_VRM(sm8550, rf_clk1, rf_clk1_ao, "clka1", 1);
> > +DEFINE_CLK_RPMH_VRM(sm8550, rf_clk2, rf_clk2_ao, "clka2", 1);
> > +DEFINE_CLK_RPMH_VRM(sm8550, rf_clk3, rf_clk3_ao, "clka3", 1);
> > +DEFINE_CLK_RPMH_VRM(sm8550, rf_clk4, rf_clk4_ao, "clka4", 1);
> > +DEFINE_CLK_RPMH_VRM(sm8550, ln_bb_clk1, ln_bb_clk1_ao, "clka6", 2);
> > +DEFINE_CLK_RPMH_VRM(sm8550, ln_bb_clk2, ln_bb_clk2_ao, "clka7", 2);
> > +DEFINE_CLK_RPMH_VRM(sm8550, ln_bb_clk3, ln_bb_clk3_ao, "clka8", 2);
> > +
> > +static struct clk_hw *sm8550_rpmh_clocks[] = {
> > +	[RPMH_CXO_PAD_CLK]      = &sm8550_xo_pad.hw,
> > +	[RPMH_CXO_PAD_CLK_A]    = &sm8550_xo_pad_ao.hw,
> > +	[RPMH_CXO_CLK]		= &sm8550_bi_tcxo.hw,
> > +	[RPMH_CXO_CLK_A]	= &sm8550_bi_tcxo_ao.hw,
> > +	[RPMH_LN_BB_CLK1]	= &sm8550_ln_bb_clk1.hw,
> > +	[RPMH_LN_BB_CLK1_A]	= &sm8550_ln_bb_clk1_ao.hw,
> > +	[RPMH_LN_BB_CLK2]	= &sm8550_ln_bb_clk2.hw,
> > +	[RPMH_LN_BB_CLK2_A]	= &sm8550_ln_bb_clk2_ao.hw,
> > +	[RPMH_LN_BB_CLK3]	= &sm8550_ln_bb_clk3.hw,
> > +	[RPMH_LN_BB_CLK3_A]	= &sm8550_ln_bb_clk3_ao.hw,
> > +	[RPMH_RF_CLK1]		= &sm8550_rf_clk1.hw,
> > +	[RPMH_RF_CLK1_A]	= &sm8550_rf_clk1_ao.hw,
> > +	[RPMH_RF_CLK2]		= &sm8550_rf_clk2.hw,
> > +	[RPMH_RF_CLK2_A]	= &sm8550_rf_clk2_ao.hw,
> > +	[RPMH_RF_CLK3]		= &sm8550_rf_clk3.hw,
> > +	[RPMH_RF_CLK3_A]	= &sm8550_rf_clk3_ao.hw,
> > +	[RPMH_RF_CLK4]		= &sm8550_rf_clk4.hw,
> > +	[RPMH_RF_CLK4_A]	= &sm8550_rf_clk4_ao.hw,
> > +	[RPMH_IPA_CLK]		= &sdm845_ipa.hw,
> > +};
> > +
> > +static const struct clk_rpmh_desc clk_rpmh_sm8550 = {
> > +	.clks = sm8550_rpmh_clocks,
> > +	.num_clks = ARRAY_SIZE(sm8550_rpmh_clocks),
> > +};
> > +
> >   static struct clk_hw *sc7280_rpmh_clocks[] = {
> >   	[RPMH_CXO_CLK]      = &sc7280_bi_tcxo.hw,
> >   	[RPMH_CXO_CLK_A]    = &sc7280_bi_tcxo_ao.hw,
> > @@ -694,29 +761,31 @@ static int clk_rpmh_probe(struct platform_device *pdev)
> >   		name = hw_clks[i]->init->name;
> > -		rpmh_clk = to_clk_rpmh(hw_clks[i]);
> > -		res_addr = cmd_db_read_addr(rpmh_clk->res_name);
> > -		if (!res_addr) {
> > -			dev_err(&pdev->dev, "missing RPMh resource address for %s\n",
> > -				rpmh_clk->res_name);
> > -			return -ENODEV;
> > -		}
> > +		if (hw_clks[i]->init->ops != &clk_fixed_factor_ops) {
> > +			rpmh_clk = to_clk_rpmh(hw_clks[i]);
> > +			res_addr = cmd_db_read_addr(rpmh_clk->res_name);
> > +			if (!res_addr) {
> > +				dev_err(&pdev->dev, "missing RPMh resource address for %s\n",
> > +					rpmh_clk->res_name);
> > +				return -ENODEV;
> > +			}
> > -		data = cmd_db_read_aux_data(rpmh_clk->res_name, &aux_data_len);
> > -		if (IS_ERR(data)) {
> > -			ret = PTR_ERR(data);
> > -			dev_err(&pdev->dev,
> > -				"error reading RPMh aux data for %s (%d)\n",
> > -				rpmh_clk->res_name, ret);
> > -			return ret;
> > -		}
> > +			data = cmd_db_read_aux_data(rpmh_clk->res_name, &aux_data_len);
> > +			if (IS_ERR(data)) {
> > +				ret = PTR_ERR(data);
> > +				dev_err(&pdev->dev,
> > +					"error reading RPMh aux data for %s (%d)\n",
> > +					rpmh_clk->res_name, ret);
> > +				return ret;
> > +			}
> > -		/* Convert unit from Khz to Hz */
> > -		if (aux_data_len == sizeof(*data))
> > -			rpmh_clk->unit = le32_to_cpu(data->unit) * 1000ULL;
> > +			/* Convert unit from Khz to Hz */
> > +			if (aux_data_len == sizeof(*data))
> > +				rpmh_clk->unit = le32_to_cpu(data->unit) * 1000ULL;
> > -		rpmh_clk->res_addr += res_addr;
> > -		rpmh_clk->dev = &pdev->dev;
> > +			rpmh_clk->res_addr += res_addr;
> > +			rpmh_clk->dev = &pdev->dev;
> > +		}
> >   		ret = devm_clk_hw_register(&pdev->dev, hw_clks[i]);
> >   		if (ret) {
> > @@ -752,6 +821,7 @@ static const struct of_device_id clk_rpmh_match_table[] = {
> >   	{ .compatible = "qcom,sm8250-rpmh-clk", .data = &clk_rpmh_sm8250},
> >   	{ .compatible = "qcom,sm8350-rpmh-clk", .data = &clk_rpmh_sm8350},
> >   	{ .compatible = "qcom,sm8450-rpmh-clk", .data = &clk_rpmh_sm8450},
> > +	{ .compatible = "qcom,sm8550-rpmh-clk", .data = &clk_rpmh_sm8550},
> >   	{ .compatible = "qcom,sc7280-rpmh-clk", .data = &clk_rpmh_sc7280},
> >   	{ }
> >   };
