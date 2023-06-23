Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E58573BAF0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjFWO7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjFWO7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:59:45 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05201987
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:59:43 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f86a7a5499so983025e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687532382; x=1690124382;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B4/OJdczlYExXAsvuIIQOlq/URlmPtl71pqrwUBjURI=;
        b=fyI3NLEFUrtSIjj+s2A2JztYeLbDTeVfZncA9D3FZAEAsJaR+GA14hxIQ4DYVw05ro
         Gx85vCarBgl/IDfY2sbA4sfkHITvmqGN/7NbAjlJVimzASSwsSI4t/IA0+DcAYDrTCoy
         itJ1fAciQPIhIgesHi5JPuwU7MP0eAWxCexoQbPIS6330gMakFg/wGddI1d+BJF/VTJK
         Me4MVHA4nOsIwhRCHbl1ydyBBPCMTM4ZX9IbDn5luJCe7siABaDx4/8ExuzYjKxpnoOq
         Cpobm+whab7caxALV9FlddEzSszDyPucYMV0ZDYq1fi+DQ6UsJIvO8SnIozvldIeicSX
         VxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687532382; x=1690124382;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4/OJdczlYExXAsvuIIQOlq/URlmPtl71pqrwUBjURI=;
        b=DCquD8vCrtLY2HdKy5dFcszAMiAsy6dMzP8QfQENi1ucfVWVeRXr0elnAGolNVEqBg
         4X21FjBHdRIiSCkWvsKK5CHVXg/IZhVE2nkbtoXwDD1aeAi7Vs9OUi1gE5aUAGPGhrjq
         EdnhHUeIeIKknx0Grmxo+/nFjLxwo95zC2AQibq2FlN25egwIzD1nxPkAdGTUh9TEd0F
         8puRrHIwfQXuBpHU/t9Yuu6HUepsX63wTZWF8F0eoJwe2DnDxmTgVVl6yJBgwUQffJjb
         J6Hq9xR2umbQu1CP8Z0gmv4uJzdulgElLOoH0hWW3auzdkoYHMOMB7hfvMcFBGtEeQvG
         8F/w==
X-Gm-Message-State: AC+VfDxHJ1ygCQRvYPCdt+3IVSIcEbWFTUw/NYzhY+k316NjC7hWabG1
        ndAVXAk9fCbl95j+GE4wIfM4rg==
X-Google-Smtp-Source: ACHHUZ40p/DIccVDgVOPyFUWxm9saDGv2mPGJ0DeSVPwmIYQzPKvFhkIdsaR3YF2gzwz0bZzYhAP1g==
X-Received: by 2002:a19:6d1b:0:b0:4f6:2cd8:5ff4 with SMTP id i27-20020a196d1b000000b004f62cd85ff4mr12620332lfc.2.1687532382109;
        Fri, 23 Jun 2023 07:59:42 -0700 (PDT)
Received: from [192.168.1.101] (abyk30.neoplus.adsl.tpnet.pl. [83.9.30.30])
        by smtp.gmail.com with ESMTPSA id f28-20020ac251bc000000b004f13ca69dc8sm1479064lfk.72.2023.06.23.07.59.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 07:59:41 -0700 (PDT)
Message-ID: <894163b0-65f7-60c4-4054-1c6af1683af9@linaro.org>
Date:   Fri, 23 Jun 2023 16:59:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 6/6] soc: qcom: llcc: Add QDU1000 and QRU1000 LLCC
 support
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230623141806.13388-1-quic_kbajaj@quicinc.com>
 <20230623141806.13388-7-quic_kbajaj@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230623141806.13388-7-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
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

On 23.06.2023 16:18, Komal Bajaj wrote:
> Add LLCC configuration data for QDU1000 and QRU1000 SoCs
> and updating macro name for LLCC_DRE to LLCC_ECC as per
> the latest specification.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  drivers/soc/qcom/llcc-qcom.c       | 65 +++++++++++++++++++++++++++++-
>  include/linux/soc/qcom/llcc-qcom.h |  2 +-
>  2 files changed, 65 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 3c29612da1c5..d2826158ae60 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -187,7 +187,7 @@ static const struct llcc_slice_config sc8280xp_data[] = {
>  	{ LLCC_MMUHWT,   13, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
>  	{ LLCC_DISP,     16, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
>  	{ LLCC_AUDHW,    22, 2048, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> -	{ LLCC_DRE,      26, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> +	{ LLCC_ECC,      26, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
>  	{ LLCC_CVP,      28, 512,  3, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
>  	{ LLCC_APTCM,    30, 1024, 3, 1, 0x0,   0x1, 1, 0, 0, 1, 0, 0 },
>  	{ LLCC_WRCACHE,  31, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
> @@ -358,6 +358,36 @@ static const struct llcc_slice_config sm8550_data[] =  {
>  	{LLCC_VIDVSP,   28,  256, 4, 1, 0xFFFFFF, 0x0,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
>  };
>  
> +static const struct llcc_slice_config qdu1000_data_2ch[] = {
> +	{LLCC_MDMHPGRW, 7, 512, 1, 1, 0xFFF, 0x0, 0, 0, 0, 1, 0, 0, 0 },
> +	{LLCC_MODHW,    9, 256, 1, 1, 0xFFF, 0x0, 0, 0, 0, 1, 0, 0, 0 },
> +	{LLCC_MDMPNG,  21, 256, 0, 1,   0x3, 0x0, 0, 0, 0, 1, 0, 0, 0 },
> +	{LLCC_ECC,     26, 512, 3, 1, 0xFFC, 0x0, 0, 0, 0, 0, 1, 0, 0 },
> +	{LLCC_MODPE,   29, 256, 1, 1, 0xFFF, 0x0, 0, 0, 0, 1, 0, 0, 0 },
> +	{LLCC_APTCM,   30, 256, 3, 1,   0x0, 0xC, 1, 0, 0, 1, 0, 0, 0 },
> +	{LLCC_WRCACHE, 31, 128, 1, 1,   0x3, 0x0, 0, 0, 0, 0, 1, 0, 0 },
Please keep the style coherent with existing entries, so:

- spacing between curly braces and data
- tabs/spaces
- hex should be lowercase

Konrad
> +};
> +
> +static const struct llcc_slice_config qdu1000_data_4ch[] = {
> +	{LLCC_MDMHPGRW, 7, 1024, 1, 1, 0xFFF, 0x0, 0, 0, 0, 1, 0, 0, 0 },
> +	{LLCC_MODHW,    9, 512,  1, 1, 0xFFF, 0x0, 0, 0, 0, 1, 0, 0, 0 },
> +	{LLCC_MDMPNG,  21, 512,  0, 1,   0x3, 0x0, 0, 0, 0, 1, 0, 0, 0 },
> +	{LLCC_ECC,     26, 1024, 3, 1, 0xFFC, 0x0, 0, 0, 0, 0, 1, 0, 0 },
> +	{LLCC_MODPE,   29, 512,  1, 1, 0xFFF, 0x0, 0, 0, 0, 1, 0, 0, 0 },
> +	{LLCC_APTCM,   30, 512,  3, 1,   0x0, 0xC, 1, 0, 0, 1, 0, 0, 0 },
> +	{LLCC_WRCACHE, 31, 256,  1, 1,   0x3, 0x0, 0, 0, 0, 0, 1, 0, 0 },
> +};
> +
> +static const struct llcc_slice_config qdu1000_data_8ch[] = {
> +	{LLCC_MDMHPGRW, 7, 2048, 1, 1, 0xFFF, 0x0, 0, 0, 0, 1, 0, 0, 0 },
> +	{LLCC_MODHW,    9, 1024, 1, 1, 0xFFF, 0x0, 0, 0, 0, 1, 0, 0, 0 },
> +	{LLCC_MDMPNG,  21, 1024, 0, 1,   0x3, 0x0, 0, 0, 0, 1, 0, 0, 0 },
> +	{LLCC_ECC,     26, 2048, 3, 1, 0xFFC, 0x0, 0, 0, 0, 0, 1, 0, 0 },
> +	{LLCC_MODPE,   29, 1024, 1, 1, 0xFFF, 0x0, 0, 0, 0, 1, 0, 0, 0 },
> +	{LLCC_APTCM,   30, 1024, 3, 1,   0x0, 0xC, 1, 0, 0, 1, 0, 0, 0 },
> +	{LLCC_WRCACHE, 31, 512,  1, 1,   0x3, 0x0, 0, 0, 0, 0, 1, 0, 0 },
> +};
> +
>  static const struct llcc_edac_reg_offset llcc_v1_edac_reg_offset = {
>  	.trp_ecc_error_status0 = 0x20344,
>  	.trp_ecc_error_status1 = 0x20348,
> @@ -557,6 +587,38 @@ static const struct qcom_llcc_config sm8550_cfg[] = {
>  	{ },
>  };
>  
> +static const struct qcom_llcc_config qdu1000_cfg[] = {
> +	{
> +		.sct_data       = qdu1000_data_8ch,
> +		.size		= ARRAY_SIZE(qdu1000_data_8ch),
> +		.need_llcc_cfg	= true,
> +		.reg_offset	= llcc_v2_1_reg_offset,
> +		.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
> +	},
> +	{
> +		.sct_data       = qdu1000_data_4ch,
> +		.size           = ARRAY_SIZE(qdu1000_data_4ch),
> +		.need_llcc_cfg  = true,
> +		.reg_offset     = llcc_v2_1_reg_offset,
> +		.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
> +	},
> +	{
> +		.sct_data       = qdu1000_data_4ch,
> +		.size           = ARRAY_SIZE(qdu1000_data_4ch),
> +		.need_llcc_cfg  = true,
> +		.reg_offset     = llcc_v2_1_reg_offset,
> +		.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
> +	},
> +	{
> +		.sct_data       = qdu1000_data_2ch,
> +		.size           = ARRAY_SIZE(qdu1000_data_2ch),
> +		.need_llcc_cfg  = true,
> +		.reg_offset     = llcc_v2_1_reg_offset,
> +		.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
> +	},
> +	{ },
> +};
> +
>  static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
>  
>  /**
> @@ -1114,6 +1176,7 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id qcom_llcc_of_match[] = {
> +	{ .compatible = "qcom,qdu1000-llcc", .data = qdu1000_cfg},
>  	{ .compatible = "qcom,sc7180-llcc", .data = sc7180_cfg },
>  	{ .compatible = "qcom,sc7280-llcc", .data = sc7280_cfg },
>  	{ .compatible = "qcom,sc8180x-llcc", .data = sc8180x_cfg },
> diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
> index 93417ba1ead4..1a886666bbb6 100644
> --- a/include/linux/soc/qcom/llcc-qcom.h
> +++ b/include/linux/soc/qcom/llcc-qcom.h
> @@ -30,7 +30,7 @@
>  #define LLCC_NPU         23
>  #define LLCC_WLHW        24
>  #define LLCC_PIMEM       25
> -#define LLCC_DRE         26
> +#define LLCC_ECC         26
>  #define LLCC_CVP         28
>  #define LLCC_MODPE       29
>  #define LLCC_APTCM       30
