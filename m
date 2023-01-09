Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4751662DF9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236909AbjAISDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237379AbjAISDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:03:00 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1AF68CBF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 10:01:40 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id bx6so9731410ljb.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 10:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0nchYfFciduIgtDWcWldBXJodGzRQnAudPYiS68F7uY=;
        b=o9GnZch66riUGw3i7tM7UyrGfBfJ5ZHoNVpoIEKuao9rjQ5bVABB94iiGfgNdLKisG
         tzwGrPDmQq0GPTOzLf2HUkcVMTe/ra4iyGaxEF08V7uTBr5BIErXDvI3huoTQPkr2ni3
         hGsTDPBVpnz7UqVv+FQY/b6mSEups8rv9wn61e8WMeChb2PoLBSh2u7K3BZauiKvxfou
         9RdS0dlF2a+KQ2w5lgtSRaX/NfIFODY+/p/LinoqVY0Bf4O6XIjCDXowRvQG4i8saCYO
         ysHfnK0CQ+wPrGWIXVNfVLvTySau60GtvsRUKege/3LiTd/LzMv0a1bYHXCWKCf1pz4R
         lolg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0nchYfFciduIgtDWcWldBXJodGzRQnAudPYiS68F7uY=;
        b=oSDTw0lhAAW+ReIp+9Y2SkhtpkLWrBwnx1oUAs+Gq7vcyizIZssEzknzSPjMhxIvy1
         9+Pf4A87tdpZlVSl2Fhke3N4tzrL/ts6F21/KRSIN58PBHeFPssWgdEv9823JbO4WxjY
         1Mq/Bja0AhG9YyXqMOQg53aGQ9TWJp8qYKKpTUWxxW6aBOYzJZz7xLDLkHvYW1nT+qml
         XV0yS7mWX/uBZcwjdOjrhlLi8cyibc14d+KVpiJFys9f+qNjASfUJIF+FC2d1s8HWUxN
         JvYurBp9q8zBZOOC+aOenA/DGVu7mCAlOGoj3KFeBXhVCuSAy1+ai2Z0COECDiMUDmeZ
         ILxA==
X-Gm-Message-State: AFqh2kqOw4qvLzox8zVkhYywA7q/oLsIMRSrtkXXsiB7sr/qXNyhT9LQ
        jQyE8I0Ux2gMn9Z1uV8IDyqYVw==
X-Google-Smtp-Source: AMrXdXvCliBmQJx6g9X+m7pGnQkIW8vhJbyDvLJgsA/EJ9/6OZK+h3y7oWEywJR0DkXPjHKw9Vg5+w==
X-Received: by 2002:a05:651c:b21:b0:27f:fdde:ad36 with SMTP id b33-20020a05651c0b2100b0027ffddead36mr7356885ljr.17.1673287298555;
        Mon, 09 Jan 2023 10:01:38 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id f21-20020a2e6a15000000b00284126dbea2sm614466ljc.55.2023.01.09.10.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 10:01:37 -0800 (PST)
Message-ID: <432c7615-23d3-6580-e176-c1a25cd349d5@linaro.org>
Date:   Mon, 9 Jan 2023 19:01:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 05/18] clk: qcom: rpmh: add clocks for sa8775p
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-gpio@vger.kernel.org,
        netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230109174511.1740856-1-brgl@bgdev.pl>
 <20230109174511.1740856-6-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230109174511.1740856-6-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9.01.2023 18:44, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Hm.. are you sending this from the correct email? Not that it
matters *that* much, authorship is more important..

> 
> Extend the driver with a description of clocks for sa8775p platforms.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/clk/qcom/clk-rpmh.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> index 586a810c682c..d5f7ec2edbbe 100644
> --- a/drivers/clk/qcom/clk-rpmh.c
> +++ b/drivers/clk/qcom/clk-rpmh.c
> @@ -396,6 +396,22 @@ static const struct clk_rpmh_desc clk_rpmh_sdm845 = {
>  	.num_clks = ARRAY_SIZE(sdm845_rpmh_clocks),
>  };
>  
> +static struct clk_hw *sa8775p_rpmh_clocks[] = {
> +	[RPMH_CXO_CLK]		= &clk_rpmh_bi_tcxo_div2.hw,
> +	[RPMH_CXO_CLK_A]	= &clk_rpmh_bi_tcxo_div2_ao.hw,
> +	[RPMH_LN_BB_CLK1]	= &clk_rpmh_ln_bb_clk1_a2.hw,
> +	[RPMH_LN_BB_CLK2]	= &clk_rpmh_ln_bb_clk2_a2.hw,
> +	[RPMH_LN_BB_CLK2_A]	= &clk_rpmh_ln_bb_clk2_a4_ao.hw,
> +	[RPMH_IPA_CLK]		= &clk_rpmh_ipa.hw,
> +	[RPMH_PKA_CLK]		= &clk_rpmh_pka.hw,
> +	[RPMH_HWKM_CLK]		= &clk_rpmh_hwkm.hw,
> +};
> +
> +static const struct clk_rpmh_desc clk_rpmh_sa8775p = {
> +	.clks = sa8775p_rpmh_clocks,
> +	.num_clks = ARRAY_SIZE(sa8775p_rpmh_clocks),
> +};
> +
>  static struct clk_hw *sdm670_rpmh_clocks[] = {
>  	[RPMH_CXO_CLK]		= &clk_rpmh_bi_tcxo_div2.hw,
>  	[RPMH_CXO_CLK_A]	= &clk_rpmh_bi_tcxo_div2_ao.hw,
> @@ -730,6 +746,7 @@ static int clk_rpmh_probe(struct platform_device *pdev)
>  
>  static const struct of_device_id clk_rpmh_match_table[] = {
>  	{ .compatible = "qcom,qdu1000-rpmh-clk", .data = &clk_rpmh_qdu1000},
> +	{ .compatible = "qcom,sa8775p-rpmh-clk", .data = &clk_rpmh_sa8775p},
>  	{ .compatible = "qcom,sc7180-rpmh-clk", .data = &clk_rpmh_sc7180},
>  	{ .compatible = "qcom,sc8180x-rpmh-clk", .data = &clk_rpmh_sc8180x},
>  	{ .compatible = "qcom,sc8280xp-rpmh-clk", .data = &clk_rpmh_sc8280xp},
