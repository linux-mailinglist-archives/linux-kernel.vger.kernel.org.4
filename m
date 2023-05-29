Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E46714635
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 10:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjE2ITD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 04:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjE2ITB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 04:19:01 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECB9BB
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 01:18:56 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2af2e1725bdso37386421fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 01:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685348335; x=1687940335;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z+6vJ9zaGIlrddWwekztTVVNTWoY7fyIbT1woEoNQSA=;
        b=CevULIUtfh0nY4vuRH08Yxw24vpwpTFAzdgVFCNAtb1J0NE0GzFw9nsECTnJ+1s/g6
         QPENun5ACL0cilue2pMR+SutPLJuorgv1lxiUMR/UnmPh0uuYM0w7lBi3a/It2Kwsn4d
         sJrwiHFUZXG3UcXQK8gaCjT5NToBo/xCWtpqu+CydTt1fYu2nJHagyQApdHJFTmeZiX1
         tXcBinKL5zbMhXHlNOOJwCUYP9aCJFcWA8/gxeoWnl7CRuwp+xSs0cR+PHZGaSCo+osj
         qMD7GpAEWw1hOfOegwwxoVVbcesXAVl9nwYZGXNPOxr6m73FMsADtJpVN5IXugLtupDn
         f+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685348335; x=1687940335;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z+6vJ9zaGIlrddWwekztTVVNTWoY7fyIbT1woEoNQSA=;
        b=WTSIN36e6kkXtSXMhRYhHtszWwmsIx/KF6zPQLLPDBZjvXyAv+9Eb4oKdPIJKd8I2t
         HYaitxgXuPiKoeaHHn5ejekayO9jD/QWWhT5SRvy871xeFHhmIO58DlHlc8Fwx+wO38C
         MK48fRMInBxM7x3huB/MbZiXv5OzlwfPqBRV9X+Db6rnKzK5xS/KunVVTeukSrOrAGD1
         TaBjmhzv7Fpeo+ifKe2hU413G+Z5Ddw0eDyP3i3fZFs8qZa6VDylN9OZAItNNmnv8wYK
         6JXm54TNUnD+CsTa/Le/OLff+S2d8FWDyJieMV8AL5ApAi0Ra5gP5wrpJs3gtxkfOTUR
         aX9Q==
X-Gm-Message-State: AC+VfDySld/s4/lCOKJgL1KqQIeUdSY486p+dRhT3mKN6+y+hOGYwVnW
        ktMF0D3GXPDrChNpkPBL+AWCYQ==
X-Google-Smtp-Source: ACHHUZ4SfeeXfI9O7GCTsvx6bNolt5z6hJK7Y92EsXY8u2VrW16ZAXWEk39LHaYMdb+xl7nS1PnuKQ==
X-Received: by 2002:a2e:9f09:0:b0:295:a8e6:6b15 with SMTP id u9-20020a2e9f09000000b00295a8e66b15mr2416620ljk.4.1685348334930;
        Mon, 29 May 2023 01:18:54 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id s10-20020a2e98ca000000b002aa4713b925sm2341755ljj.21.2023.05.29.01.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 01:18:54 -0700 (PDT)
Message-ID: <2d044f14-65c0-be3f-595f-4ddb46df6fef@linaro.org>
Date:   Mon, 29 May 2023 10:18:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 3/3] clk: qcom: cbf-msm8996: Add support for MSM8996
 Pro
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230527093934.101335-1-y.oudjana@protonmail.com>
 <20230527093934.101335-4-y.oudjana@protonmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230527093934.101335-4-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.05.2023 11:39, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> The CBF PLL on MSM8996 Pro has a /4 post divisor instead of /2. Handle the
> difference accordingly.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  drivers/clk/qcom/clk-cbf-8996.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clk-cbf-8996.c b/drivers/clk/qcom/clk-cbf-8996.c
> index cfd567636f4e..ab988e6f1976 100644
> --- a/drivers/clk/qcom/clk-cbf-8996.c
> +++ b/drivers/clk/qcom/clk-cbf-8996.c
> @@ -48,7 +48,7 @@ static const u8 cbf_pll_regs[PLL_OFF_MAX_REGS] = {
>  	[PLL_OFF_STATUS] = 0x28,
>  };
>  
> -static const struct alpha_pll_config cbfpll_config = {
> +static struct alpha_pll_config cbfpll_config = {
>  	.l = 72,
>  	.config_ctl_val = 0x200d4828,
>  	.config_ctl_hi_val = 0x006,
> @@ -137,7 +137,7 @@ static int clk_cbf_8996_mux_determine_rate(struct clk_hw *hw,
>  {
>  	struct clk_hw *parent;
>  
> -	if (req->rate < (DIV_THRESHOLD / 2))
> +	if (req->rate < (DIV_THRESHOLD / cbf_pll_postdiv.div))
>  		return -EINVAL;
>  
>  	if (req->rate < DIV_THRESHOLD)
> @@ -265,6 +265,11 @@ static int qcom_msm8996_cbf_probe(struct platform_device *pdev)
>  	/* Switch CBF to use the primary PLL */
>  	regmap_update_bits(regmap, CBF_MUX_OFFSET, CBF_MUX_PARENT_MASK, 0x1);
>  
> +	if (of_device_is_compatible(dev->of_node, "qcom,msm8996pro-cbf")) {
If this was a driver for more than 1.5 SoCs, I'd propose using a
different mechanism here (match data flags or something), but since
there aren't (and hopefully won't ever be) more 8996s (automotive etc.
inherit one of these configurations so that doesn't count), I'm willing
to say

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> +		cbfpll_config.post_div_val = 0x3 << 8;
> +		cbf_pll_postdiv.div = 4;
> +	}
> +
>  	for (i = 0; i < ARRAY_SIZE(cbf_msm8996_hw_clks); i++) {
>  		ret = devm_clk_hw_register(dev, cbf_msm8996_hw_clks[i]);
>  		if (ret)
> @@ -286,6 +291,7 @@ static int qcom_msm8996_cbf_probe(struct platform_device *pdev)
>  
>  static const struct of_device_id qcom_msm8996_cbf_match_table[] = {
>  	{ .compatible = "qcom,msm8996-cbf" },
> +	{ .compatible = "qcom,msm8996pro-cbf" },
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, qcom_msm8996_cbf_match_table);
