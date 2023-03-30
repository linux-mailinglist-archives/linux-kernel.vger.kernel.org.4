Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6696D12C2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 01:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjC3XDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 19:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjC3XDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 19:03:18 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16DE1024A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 16:03:15 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y20so26644065lfj.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 16:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680217394;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zEkKtE0vkt21sRhBuffpmUPW8xKmTGht7NHfZQIbEiU=;
        b=H/iHltE0zvRh2+v+yhNTxSmUP6TvEYLOdH3fjscSVHLA5JH1/QMZkSdiI/MqJ4uJkZ
         HnuQKICaN+5c6YUTiz9jy4rXtXUbNncMzaB7yTTiASuHhAMDpQlYD+XaguKer+zewkQi
         B7AvORSXdJoL3D8FtdsgTAj+znHie4Ec3TdB0YW1vKz43R/W6TiqeewSptEFnDkeSGaI
         PNZ8iZPBVdrF6AokNRRFXNaUG93IdhhKqY91dAkihJgJOe9NK39wH9OzOP5pk7i6kS50
         5f+EqwbDrok8z6jh8ToCAWYzOSXo70XeOIkwkOP4J8p3kL+UPjWKrqWOxMIfuPrzA5Zg
         ZcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680217394;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zEkKtE0vkt21sRhBuffpmUPW8xKmTGht7NHfZQIbEiU=;
        b=wwTYVgBK8ILFBC4MWJVHDpLHSR5/EfO/R1uJjd3hzTVnEOH9VF87WFdeHe2pl/OxMZ
         EgQYf1bDkGRaVWITez/M47Gpv9vkK70aLoCCVoZ88Bm8ujIRzPAip4nCdLFBCmkQ5RTp
         wYv6DmMzJATsrDxTAssp3r97IaNRFhotbpVyaCQ/b3ToL03zmcZlp0HQ2Nt88JAWYp80
         iUbrGdqcZCb/bAlnXZ1UrUabl7QqYZcezxETv9bgVeD/DH9aB/mQRU1iOd6AWov5h7lS
         h0ua9JCYBClTy09hIsO3knjTTtk09PUI+TBKIamLzFD6AbHbDKe3O8N7nrrTa8G5Ywom
         y0Jw==
X-Gm-Message-State: AAQBX9c1eDV9Rww38rAesykH2BezxormpDu439E9thUgPuQvlSF0/c9c
        sTtHitE76CulrEPd87ztbq7HEg==
X-Google-Smtp-Source: AKy350Yi5FonEUBAnrg07fYLsht6nsgvcree+VutXuEZnPzsXyh/qq/4KeKw+ls/qHo+1BgXrWhrIg==
X-Received: by 2002:a19:c502:0:b0:4e9:85e5:23ff with SMTP id w2-20020a19c502000000b004e985e523ffmr8109157lfe.40.1680217394012;
        Thu, 30 Mar 2023 16:03:14 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id w9-20020ac25d49000000b004dbebb3a6fasm120913lfd.175.2023.03.30.16.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 16:03:13 -0700 (PDT)
Message-ID: <b96beb22-88ab-35ce-0c7f-6abf4c196c74@linaro.org>
Date:   Fri, 31 Mar 2023 01:03:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 2/3] remoteproc: qcom: pas: refactor SLPI remoteproc
 init
Content-Language: en-US
To:     Dylan Van Assche <me@dylanvanassche.be>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230330164633.117335-1-me@dylanvanassche.be>
 <20230330164633.117335-3-me@dylanvanassche.be>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230330164633.117335-3-me@dylanvanassche.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.03.2023 18:46, Dylan Van Assche wrote:
> SLPI remoteproc initialization is the same for SDM845, SM8150, SM8250,
> SM8350 but is duplicated for each compatible. Refactor initialization
> structs for these 4 compatibles as a single struct.
> 
> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/remoteproc/qcom_q6v5_pas.c | 48 +++++-------------------------
>  1 file changed, 8 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index c99a20542685..b96020c93e58 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -1014,7 +1014,7 @@ static const struct adsp_data sc8180x_mpss_resource = {
>  	.ssctl_id = 0x12,
>  };
>  
> -static const struct adsp_data slpi_resource_init = {
> +static const struct adsp_data msm8996_slpi_resource_init = {
>  		.crash_reason_smem = 424,
>  		.firmware_name = "slpi.mdt",
>  		.pas_id = 12,
> @@ -1028,7 +1028,7 @@ static const struct adsp_data slpi_resource_init = {
>  		.ssctl_id = 0x16,
>  };
>  
> -static const struct adsp_data sm8150_slpi_resource = {
> +static const struct adsp_data sdm845_slpi_resource_init = {
>  		.crash_reason_smem = 424,
>  		.firmware_name = "slpi.mdt",
>  		.pas_id = 12,
> @@ -1044,38 +1044,6 @@ static const struct adsp_data sm8150_slpi_resource = {
>  		.ssctl_id = 0x16,
>  };
>  
> -static const struct adsp_data sm8250_slpi_resource = {
> -	.crash_reason_smem = 424,
> -	.firmware_name = "slpi.mdt",
> -	.pas_id = 12,
> -	.auto_boot = true,
> -	.proxy_pd_names = (char*[]){
> -		"lcx",
> -		"lmx",
> -		NULL
> -	},
> -	.load_state = "slpi",
> -	.ssr_name = "dsps",
> -	.sysmon_name = "slpi",
> -	.ssctl_id = 0x16,
> -};
> -
> -static const struct adsp_data sm8350_slpi_resource = {
> -	.crash_reason_smem = 424,
> -	.firmware_name = "slpi.mdt",
> -	.pas_id = 12,
> -	.auto_boot = true,
> -	.proxy_pd_names = (char*[]){
> -		"lcx",
> -		"lmx",
> -		NULL
> -	},
> -	.load_state = "slpi",
> -	.ssr_name = "dsps",
> -	.sysmon_name = "slpi",
> -	.ssctl_id = 0x16,
> -};
> -
>  static const struct adsp_data wcss_resource_init = {
>  	.crash_reason_smem = 421,
>  	.firmware_name = "wcnss.mdt",
> @@ -1184,9 +1152,9 @@ static const struct of_device_id adsp_of_match[] = {
>  	{ .compatible = "qcom,msm8953-adsp-pil", .data = &msm8996_adsp_resource},
>  	{ .compatible = "qcom,msm8974-adsp-pil", .data = &adsp_resource_init},
>  	{ .compatible = "qcom,msm8996-adsp-pil", .data = &msm8996_adsp_resource},
> -	{ .compatible = "qcom,msm8996-slpi-pil", .data = &slpi_resource_init},
> +	{ .compatible = "qcom,msm8996-slpi-pil", .data = &msm8996_slpi_resource_init},
>  	{ .compatible = "qcom,msm8998-adsp-pas", .data = &msm8996_adsp_resource},
> -	{ .compatible = "qcom,msm8998-slpi-pas", .data = &slpi_resource_init},
> +	{ .compatible = "qcom,msm8998-slpi-pas", .data = &msm8996_slpi_resource_init},
>  	{ .compatible = "qcom,qcs404-adsp-pas", .data = &adsp_resource_init },
>  	{ .compatible = "qcom,qcs404-cdsp-pas", .data = &cdsp_resource_init },
>  	{ .compatible = "qcom,qcs404-wcss-pas", .data = &wcss_resource_init },
> @@ -1211,17 +1179,17 @@ static const struct of_device_id adsp_of_match[] = {
>  	{ .compatible = "qcom,sm8150-adsp-pas", .data = &sm8150_adsp_resource},
>  	{ .compatible = "qcom,sm8150-cdsp-pas", .data = &sm8150_cdsp_resource},
>  	{ .compatible = "qcom,sm8150-mpss-pas", .data = &mpss_resource_init},
> -	{ .compatible = "qcom,sm8150-slpi-pas", .data = &sm8150_slpi_resource},
> +	{ .compatible = "qcom,sm8150-slpi-pas", .data = &sdm845_slpi_resource_init},
>  	{ .compatible = "qcom,sm8250-adsp-pas", .data = &sm8250_adsp_resource},
>  	{ .compatible = "qcom,sm8250-cdsp-pas", .data = &sm8250_cdsp_resource},
> -	{ .compatible = "qcom,sm8250-slpi-pas", .data = &sm8250_slpi_resource},
> +	{ .compatible = "qcom,sm8250-slpi-pas", .data = &sdm845_slpi_resource_init},
>  	{ .compatible = "qcom,sm8350-adsp-pas", .data = &sm8350_adsp_resource},
>  	{ .compatible = "qcom,sm8350-cdsp-pas", .data = &sm8350_cdsp_resource},
> -	{ .compatible = "qcom,sm8350-slpi-pas", .data = &sm8350_slpi_resource},
> +	{ .compatible = "qcom,sm8350-slpi-pas", .data = &sdm845_slpi_resource_init},
>  	{ .compatible = "qcom,sm8350-mpss-pas", .data = &mpss_resource_init},
>  	{ .compatible = "qcom,sm8450-adsp-pas", .data = &sm8350_adsp_resource},
>  	{ .compatible = "qcom,sm8450-cdsp-pas", .data = &sm8350_cdsp_resource},
> -	{ .compatible = "qcom,sm8450-slpi-pas", .data = &sm8350_slpi_resource},
> +	{ .compatible = "qcom,sm8450-slpi-pas", .data = &sdm845_slpi_resource_init},
>  	{ .compatible = "qcom,sm8450-mpss-pas", .data = &sm8450_mpss_resource},
>  	{ .compatible = "qcom,sm8550-adsp-pas", .data = &sm8550_adsp_resource},
>  	{ .compatible = "qcom,sm8550-cdsp-pas", .data = &sm8550_cdsp_resource},
