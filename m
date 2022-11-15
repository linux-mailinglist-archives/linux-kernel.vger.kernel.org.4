Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94D6629BFA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiKOOYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiKOOYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:24:00 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCADB252A0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:23:52 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id l8so17676381ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZpL11cNJx2l9z+r6z/7+POcZMvt9C9FRB9mdY/4v0yc=;
        b=bZ236k1sR9rLsZmH2QLK/jWvz5w55IXdkp1pkw0jB+lj12y+GkMBVdGMjPGLfWYzsr
         YQW6QNgFrUiSbt/oUHQCSZmwJKKsqjPJcU64+Wa+4cdvHGHHrs8bn9fE/rc/IiiWE09C
         CqzZJs9Qupqm1iwIFBn5QIEY3lk/bvNvSa7pe1/KKB5k1Rrel4F1heY792b7gvbdtBs9
         voXHqYupPmcnCRRIsCh1ZTraRuj0JJoYO8iWcZrGkggQ+73mmrEWUR0p7jVs020G2zS4
         h8U3kw1yPFda0FtmhaeLa9wg+0pZg7PZ4AbxOPpCGlALEU0GGq/Bo6EE2h3b/ADt4s8g
         jyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpL11cNJx2l9z+r6z/7+POcZMvt9C9FRB9mdY/4v0yc=;
        b=BHJsVaDIS4lJGt81gfdN2tu2JAWwY/WuYaNtI7pIiGfcirqeQLZsvyoNAGZIKa+m9N
         qcieLzimrsmH2NSw98f+xpu3b3auhTx+tTxUMqwJ0yGO0ngNLwKXgTuT9OGYpoBc4zPT
         JcKZ0qoBsDaLVuxhyn4VWWdv8aaAqQVIfrqT7DVrrT/63+l8opLwHR3cnCeapTsyKlUq
         KYpb17AN2c+iXmc/ovggwb98Fz0GVF5K29w9dzFIzQYWK2/tFbznwgUialRC+xhjcBzl
         xmTM4N2XFljEjOVIJLfADUksSpZXYWTaZC0up2R2aon6nLHFWF5fgXNyibN/hO2Q2whI
         e+Dg==
X-Gm-Message-State: ANoB5plT/K8e/Lx/BIFbTp1QEQhi5o897qSEK5mPR8iREK6oV7IK1if7
        cw75YchBOEFxHAiivkTxLXPwVw==
X-Google-Smtp-Source: AA0mqf5cGkz19RcK9Ps9BvdlLxu3x3Y78oitxCK1++IR4SM4ClgTCHxDYPY+NRbRPH/u/b+2Yx+vpw==
X-Received: by 2002:a2e:8184:0:b0:277:139d:78d2 with SMTP id e4-20020a2e8184000000b00277139d78d2mr5619258ljg.22.1668522231137;
        Tue, 15 Nov 2022 06:23:51 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a17-20020ac25e71000000b0049aa20af00fsm2221593lfr.21.2022.11.15.06.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 06:23:50 -0800 (PST)
Message-ID: <090831eb-2c7a-56c2-601e-e910431a9403@linaro.org>
Date:   Tue, 15 Nov 2022 15:23:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] ASoC: codecs: va-macro: add npl clk
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
References: <20221115105541.16322-1-srinivas.kandagatla@linaro.org>
 <20221115105541.16322-3-srinivas.kandagatla@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221115105541.16322-3-srinivas.kandagatla@linaro.org>
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

On 15/11/2022 11:55, Srinivas Kandagatla wrote:
> New versions of VA Macro has soundwire integrated, so handle the soundwire npl
> clock correctly in the codec driver.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/codecs/lpass-va-macro.c | 41 +++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
> index b0b6cf29cba3..d59af6d69c34 100644
> --- a/sound/soc/codecs/lpass-va-macro.c
> +++ b/sound/soc/codecs/lpass-va-macro.c
> @@ -205,6 +205,7 @@ struct va_macro {
>  	int dec_mode[VA_MACRO_NUM_DECIMATORS];
>  	struct regmap *regmap;
>  	struct clk *mclk;
> +	struct clk *npl;
>  	struct clk *macro;
>  	struct clk *dcodec;
>  	struct clk *fsgen;
> @@ -1332,6 +1333,9 @@ static int fsgen_gate_enable(struct clk_hw *hw)
>  	struct regmap *regmap = va->regmap;
>  	int ret;
>  
> +	if (va->has_swr_master)
> +		clk_prepare_enable(va->mclk);

No error path?

> +
>  	ret = va_macro_mclk_enable(va, true);
>  	if (!va->has_swr_master)
>  		return ret;
> @@ -1358,6 +1362,8 @@ static void fsgen_gate_disable(struct clk_hw *hw)
>  			   CDC_VA_SWR_CLK_EN_MASK, 0x0);
>  
>  	va_macro_mclk_enable(va, false);
> +	if (va->has_swr_master)
> +		clk_disable_unprepare(va->mclk);
>  }
>  
>  static int fsgen_gate_is_enabled(struct clk_hw *hw)
> @@ -1386,6 +1392,9 @@ static int va_macro_register_fsgen_output(struct va_macro *va)
>  	struct clk_init_data init;
>  	int ret;
>  
> +	if (va->has_swr_master)
> +		parent = va->npl;
> +
>  	parent_clk_name = __clk_get_name(parent);
>  
>  	of_property_read_string(np, "clock-output-names", &clk_name);
> @@ -1512,6 +1521,14 @@ static int va_macro_probe(struct platform_device *pdev)
>  	/* mclk rate */
>  	clk_set_rate(va->mclk, 2 * VA_MACRO_MCLK_FREQ);
>  
> +	if (va->has_swr_master) {
> +		va->npl = devm_clk_get(dev, "npl");

I think you miss:
ret = PTR_ERR(va->npl);

> +		if (IS_ERR(va->npl))
> +			goto err;
> +
> +		clk_set_rate(va->npl, 2 * VA_MACRO_MCLK_FREQ);
> +	}
> +
>  	ret = clk_prepare_enable(va->macro);
>  	if (ret)
>  		goto err;

Best regards,
Krzysztof

