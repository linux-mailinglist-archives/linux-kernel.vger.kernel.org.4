Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B569747037
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 13:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjGDL4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 07:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGDL4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 07:56:11 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB81B18D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 04:56:09 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b6a16254a4so82317021fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 04:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688471768; x=1691063768;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0uWXTtzRor2oUBjLKY36+LrPcrmYgFnt2f4Nhe+LjrM=;
        b=q7aZvds8czfjlapaHMKIwdPQCwgFWt1IKtjiUHAQPoEjrGHy+mK1M/cJw/cffU0Ex/
         51J6HJx6cJ6xHxLcXgP4CEfDjmP3DANYxa+CzP1Zb1W3OuA9jgZeOZiVfy1BC4mvsTEs
         fP0q0VwS+0tKoLbpv8nSSpG1NqhDBnUQxke7uL13g5hg6PTLeeV/TeSezakNs81C/qS8
         9RQCAwiEsWUwVX2O3EOCXFYfxFnrzRCs/X9Fkb51c/M5OtXEJfDJDHNWMrUEFd771CGX
         9MJ7CcWyA9A67FuJ5FnAlAoqY9KC8JtcjLvMLUEq+rNwvYFYFZCE55nOZUod6tRWZkzC
         jHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688471768; x=1691063768;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0uWXTtzRor2oUBjLKY36+LrPcrmYgFnt2f4Nhe+LjrM=;
        b=flLXPLk1ps7xXy+hpYJU5aoKvtwylR67bwiNHcDHLnKegZAIoQ5ov5/y+E3p6qK6+v
         oACfWiJi++Tk0sSDD6FTSZMZcoaaSABf8ucyvcSdpHUgtNK2WiW5f+wopW/KI8/c+IFm
         PpaGMD091xjEPK9pJ+Ha35+66KFiJJtnGwA3wULukq94bQTx11agDzB7gM9zVy1St+iS
         T9SgT5grC/gO25wVA8hcYSQD5tyI5BaBKyiNur+EZ29OnFOF7tZmLAxoXJnv9XCDmCI+
         tTbffozPHp2795blqLqnOnz2kKWlc/H0xhwbsqkIhckQoW0BSwYrNNUZXNf2Yus8oqN9
         Cr+Q==
X-Gm-Message-State: ABy/qLblUMSXUlyXPrLTn2CBnbss4DuF0gdqSvkc4AGz68bUJZvVB+fU
        NvmgEZpU8Zt+o6vs0/DLR/knEg==
X-Google-Smtp-Source: APBJJlGw8dBuq5cZbx3NDZwnsFkt0mCIHTN1XIVUiZPCMEUC2O08bCKCyfsRQziZZTLyrzxRi7IvbA==
X-Received: by 2002:a2e:87cb:0:b0:2b6:e7b7:74b3 with SMTP id v11-20020a2e87cb000000b002b6e7b774b3mr4344677ljj.27.1688471767931;
        Tue, 04 Jul 2023 04:56:07 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id f6-20020a2e3806000000b00295a96a0f6csm5568146lja.102.2023.07.04.04.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 04:56:07 -0700 (PDT)
Message-ID: <801e16d1-7c41-dd80-3ed5-7e3e1b578d06@linaro.org>
Date:   Tue, 4 Jul 2023 14:56:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] clk: qcom: videocc-sm8350: Add SC8280XP support
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230703-topic-8280_videocc-v1-0-8959d4d0a93e@linaro.org>
 <20230703-topic-8280_videocc-v1-2-8959d4d0a93e@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230703-topic-8280_videocc-v1-2-8959d4d0a93e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2023 21:09, Konrad Dybcio wrote:
> SC8280XP, being a partial derivative of SM8350, shares almost the exact
> same videocc block. Extend the 8350 driver to support the bigger brother.
> 
> The only notable changes are higher possible frequencies on some clocks
> and some switcheroo within the XO/sleep registers (probably due to some
> different board crystal configuration).
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Minor nits below

> ---
>   drivers/clk/qcom/videocc-sm8350.c | 42 ++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/videocc-sm8350.c b/drivers/clk/qcom/videocc-sm8350.c
> index b148877fc73d..581ad4440615 100644
> --- a/drivers/clk/qcom/videocc-sm8350.c
> +++ b/drivers/clk/qcom/videocc-sm8350.c
> @@ -41,6 +41,10 @@ static const struct pll_vco lucid_5lpe_vco[] = {
>   	{ 249600000, 1750000000, 0 },
>   };
>   
> +static const struct pll_vco lucid_5lpe_vco_8280[] = {

Nit: _sc8280xp?

> +	{ 249600000, 1800000000, 0 },
> +};
> +
>   static const struct alpha_pll_config video_pll0_config = {
>   	.l = 0x25,
>   	.alpha = 0x8000,
> @@ -159,6 +163,16 @@ static const struct freq_tbl ftbl_video_cc_mvs0_clk_src[] = {
>   	{ }
>   };
>   
> +static const struct freq_tbl ftbl_video_cc_mvs0_clk_src_8280[] = {

And same here

> +	F(720000000, P_VIDEO_PLL0_OUT_MAIN, 1, 0, 0),
> +	F(1014000000, P_VIDEO_PLL0_OUT_MAIN, 1, 0, 0),
> +	F(1098000000, P_VIDEO_PLL0_OUT_MAIN, 1, 0, 0),
> +	F(1332000000, P_VIDEO_PLL0_OUT_MAIN, 1, 0, 0),
> +	F(1599000000, P_VIDEO_PLL0_OUT_MAIN, 1, 0, 0),
> +	F(1680000000, P_VIDEO_PLL0_OUT_MAIN, 1, 0, 0),
> +	{ }
> +};
> +
>   static struct clk_rcg2 video_cc_mvs0_clk_src = {
>   	.cmd_rcgr = 0xb94,
>   	.mnd_width = 0,
> @@ -181,6 +195,15 @@ static const struct freq_tbl ftbl_video_cc_mvs1_clk_src[] = {
>   	{ }
>   };
>   
> +static const struct freq_tbl ftbl_video_cc_mvs1_clk_src_8280[] = {
> +	F(840000000, P_VIDEO_PLL1_OUT_MAIN, 1, 0, 0),
> +	F(1098000000, P_VIDEO_PLL1_OUT_MAIN, 1, 0, 0),
> +	F(1332000000, P_VIDEO_PLL1_OUT_MAIN, 1, 0, 0),
> +	F(1600000000, P_VIDEO_PLL1_OUT_MAIN, 1, 0, 0),
> +	F(1800000000, P_VIDEO_PLL1_OUT_MAIN, 1, 0, 0),
> +	{ }
> +};
> +
>   static struct clk_rcg2 video_cc_mvs1_clk_src = {
>   	.cmd_rcgr = 0xbb4,
>   	.mnd_width = 0,
> @@ -499,6 +522,7 @@ static struct qcom_cc_desc video_cc_sm8350_desc = {
>   
>   static int video_cc_sm8350_probe(struct platform_device *pdev)
>   {
> +	u32 video_cc_xo_clk_cbcr = 0xeec;
>   	struct regmap *regmap;
>   	int ret;
>   
> @@ -510,6 +534,21 @@ static int video_cc_sm8350_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> +	if (of_device_is_compatible(pdev->dev.of_node, "qcom,sc8280xp-videocc")) {
> +		video_cc_sleep_clk_src.cmd_rcgr = 0xf38;
> +		video_cc_sleep_clk.halt_reg = 0xf58;
> +		video_cc_sleep_clk.clkr.enable_reg = 0xf58;
> +		video_cc_xo_clk_src.cmd_rcgr = 0xf14;
> +		video_cc_xo_clk_cbcr = 0xf34;
> +
> +		video_pll0.vco_table = video_pll1.vco_table = lucid_5lpe_vco_8280;
> +		/* No change, but assign it for completeness */
> +		video_pll0.num_vco = video_pll1.num_vco = ARRAY_SIZE(lucid_5lpe_vco_8280);
> +
> +		video_cc_mvs0_clk_src.freq_tbl = ftbl_video_cc_mvs0_clk_src_8280;
> +		video_cc_mvs1_clk_src.freq_tbl = ftbl_video_cc_mvs1_clk_src_8280;
> +	}
> +
>   	regmap = qcom_cc_map(pdev, &video_cc_sm8350_desc);
>   	if (IS_ERR(regmap)) {
>   		pm_runtime_put(&pdev->dev);
> @@ -525,7 +564,7 @@ static int video_cc_sm8350_probe(struct platform_device *pdev)
>   	 *      video_cc_xo_clk
>   	 */
>   	regmap_update_bits(regmap, 0xe58, BIT(0), BIT(0));
> -	regmap_update_bits(regmap, 0xeec, BIT(0), BIT(0));
> +	regmap_update_bits(regmap, video_cc_xo_clk_cbcr, BIT(0), BIT(0));
>   
>   	ret = qcom_cc_really_probe(pdev, &video_cc_sm8350_desc, regmap);
>   	pm_runtime_put(&pdev->dev);
> @@ -534,6 +573,7 @@ static int video_cc_sm8350_probe(struct platform_device *pdev)
>   }
>   
>   static const struct of_device_id video_cc_sm8350_match_table[] = {
> +	{ .compatible = "qcom,sc8280xp-videocc" },
>   	{ .compatible = "qcom,sm8350-videocc" },
>   	{ }
>   };
> 

-- 
With best wishes
Dmitry

