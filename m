Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9F66ABD17
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCFKmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjCFKl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:41:59 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0469A21952
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 02:41:58 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id k14so12079563lfj.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 02:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678099316;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UtGyFjMba2vD+o9VEguBzTeoj5lcH/jCRJ6HlWhk6po=;
        b=abQx6ixfVe5Ge/gSGl4euqcpeS7vB20UMBBRIjktg+iwopa2FEMHibQhrn+mqfhVdn
         0MJ/8I6Xn+5LNSgmOmtmzPWLCO3Nj0U0LrjVqKn12VSPGBGKQW7CxA5CY4VvNKBLtZ2v
         8cmPfneks/W8Zftqzx0/1Q4JGQysdEkicmBdWoHKt5bxS/DF0vrBAhD9D/06QQf7rQsD
         WxdRp1hfX/uoP4qJIygC/i0kw79ryXEQmb175oNrai1Pl+eZ9Hfd6dl3ulRVi1HUOUGO
         9RdfVe9755jhmA/9sIWDrino63KvhbDulAYFXSd9nKYNXLQLRherzzATRdvzNrFIT2e4
         7U1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678099316;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UtGyFjMba2vD+o9VEguBzTeoj5lcH/jCRJ6HlWhk6po=;
        b=wprYFklQwHUn4KeZvZjTojarlNVJxKCo/9CF8GYxevAPrFwymkVQRKcBHMLolgPdm8
         Oaf5os1VUrCtKkdBFkrcWoBBSI4eis6x/S3JjmLhajHmA+n5CVzwFj/ZcLCpioHJ4ouD
         DjuGx0MwUFj6FH3qb06I2z5OwbqNAOJQ9rGvjaNXtVl2pG7EloB//xnIncSsbOeeAwot
         AJgSRQgeo8BKipNwLZ3AIdNcrZKnRW3Uck8LjMGvGdqnqBVLBOCKaD/2jg8RBE5PzEHj
         bUfxsQu+W9Bb3gtajPHmvp62wK4R1RQ5U0ZH4RST7Z22sNae7gytiRbSmqEA2EHF2kMM
         x86g==
X-Gm-Message-State: AO0yUKVstdP+Fo1dnqudqUoMREUu948u5iCGeAa4JtgczpweHb3lvYOP
        I5ETY+144Jd08IJp+KOIAu6P/g==
X-Google-Smtp-Source: AK7set9VkKMivXkoQaPsj+ssRO23hx0/3CpPaUt9KsxFgsxvODgiw0DZtsENRHQx350mkpjl+wCDpg==
X-Received: by 2002:ac2:5587:0:b0:4dc:833b:5241 with SMTP id v7-20020ac25587000000b004dc833b5241mr2706071lfg.20.1678099315540;
        Mon, 06 Mar 2023 02:41:55 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id b14-20020a056512218e00b004dc4b00a1eesm1582671lft.261.2023.03.06.02.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 02:41:55 -0800 (PST)
Message-ID: <86c98c57-08a7-20b3-2346-803b497d562a@linaro.org>
Date:   Mon, 6 Mar 2023 11:41:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] soc: qcom: llcc: Add configuration data for SM7150
Content-Language: en-US
To:     Danila Tikhonov <danila@jiaxyga.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        andersson@kernel.org, abel.vesa@linaro.org,
        rishabhb@codeaurora.org, saiprakash.ranjan@codeaurora.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230305202627.402386-1-danila@jiaxyga.com>
 <20230305202627.402386-3-danila@jiaxyga.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230305202627.402386-3-danila@jiaxyga.com>
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



On 5.03.2023 21:26, Danila Tikhonov wrote:
> Add LLCC configuration data for SM7150 SoC.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
I checked the msm-4.14 data, everything lgtm

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/soc/qcom/llcc-qcom.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 23ce2f78c4ed..0ed8cd4f66da 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -227,6 +227,14 @@ static const struct llcc_slice_config sm6350_data[] =  {
>  	{ LLCC_MODPE,    29,  64, 1, 1, 0xFFF, 0x0, 0, 0, 0, 0, 1, 0 },
>  };
>  
> +static const struct llcc_slice_config sm7150_data[] =  {
> +	{ LLCC_CPUSS,    1,  512, 1, 0, 0xF, 0x0, 0, 0, 0, 1, 1 },
> +	{ LLCC_MDM,      8,  128, 2, 0, 0xF, 0x0, 0, 0, 0, 1, 0 },
> +	{ LLCC_GPUHTW,   11, 256, 1, 1, 0xF, 0x0, 0, 0, 0, 1, 0 },
> +	{ LLCC_GPU,      12, 256, 1, 1, 0xF, 0x0, 0, 0, 0, 1, 0 },
> +	{ LLCC_NPU,      23, 512, 1, 0, 0xF, 0x0, 0, 0, 0, 1, 0 },
> +};
> +
>  static const struct llcc_slice_config sm8150_data[] =  {
>  	{  LLCC_CPUSS,    1, 3072, 1, 1, 0xFFF, 0x0,   0, 0, 0, 1, 1 },
>  	{  LLCC_VIDSC0,   2, 512,  2, 1, 0xFFF, 0x0,   0, 0, 0, 1, 0 },
> @@ -464,6 +472,14 @@ static const struct qcom_llcc_config sm6350_cfg = {
>  	.edac_reg_offset = &llcc_v1_edac_reg_offset,
>  };
>  
> +static const struct qcom_llcc_config sm7150_cfg = {
> +	.sct_data       = sm7150_data,
> +	.size           = ARRAY_SIZE(sm7150_data),
> +	.need_llcc_cfg	= true,
> +	.reg_offset	= llcc_v1_reg_offset,
> +	.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +};
> +
>  static const struct qcom_llcc_config sm8150_cfg = {
>  	.sct_data       = sm8150_data,
>  	.size           = ARRAY_SIZE(sm8150_data),
> @@ -1022,6 +1038,7 @@ static const struct of_device_id qcom_llcc_of_match[] = {
>  	{ .compatible = "qcom,sc8280xp-llcc", .data = &sc8280xp_cfg },
>  	{ .compatible = "qcom,sdm845-llcc", .data = &sdm845_cfg },
>  	{ .compatible = "qcom,sm6350-llcc", .data = &sm6350_cfg },
> +	{ .compatible = "qcom,sm7150-llcc", .data = &sm7150_cfg },
>  	{ .compatible = "qcom,sm8150-llcc", .data = &sm8150_cfg },
>  	{ .compatible = "qcom,sm8250-llcc", .data = &sm8250_cfg },
>  	{ .compatible = "qcom,sm8350-llcc", .data = &sm8350_cfg },
