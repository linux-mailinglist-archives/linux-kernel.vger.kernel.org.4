Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538BD6CB951
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjC1I0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC1I0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:26:20 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCCEB1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 01:26:18 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id a11so11625719lji.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 01:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679991977;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PDRltInM5WJ9EsRe1aHED6uAyo3C5Yid2wU2sfD+FuQ=;
        b=xf1N4f40g5dlWOXx1m2107k+O9xGp0b/dRy3VZDmEhLHAUEcIfqd10COcvBhcIJdoh
         JbrHW4vfhw06dOwOKgyIS89/poxt5NCajn2uQ8Agyz/nat6pv+DjEuRRcH6OWimdvcHf
         T15xEqAYL/KI1RClzba3JQfEUSsdXg8ytL0+N32YPaqEDdsrUS9k5dXVrcJ+568P/mBV
         4HFbxIMoG6UpWHkaNTttJepmKLX+3E6XQ0OHoPMrl0diURiB4YzM/5z9zR9jdK+/n05S
         EIENYGR0/rX7/p35XK/XIgtJBwDYqCo7e1efH2nFqx6TzGOyJE33zYqsic8/OiZ7XXpV
         u4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679991977;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PDRltInM5WJ9EsRe1aHED6uAyo3C5Yid2wU2sfD+FuQ=;
        b=71JIhmju4rANtNsq33jhw3jr6kr3gilrGo17ZYTChJJmyg+H1LTPJsFdGD3s7TL/VG
         hyRq7R+bC3n530BgE7gguylKJAonIDEhBEH+NOoIqx2vgE18PtC7J8rOfuyjHfL+GJaz
         7J2XQuXSALvbEfFqGuWdxeGZU+/BHVEuAuNVN/dkZWEI3N6euijP47e7V3wuou5Zoc4S
         jMzXfTgqQ38mTtY8eHNXL7Nas3XQ3amNnGruIbugsyAPBbSJx/H37u/i7IzWmGGCC+30
         HL1C08eWWFcykQsttgpMJyEb8GhXQfxh5u+wss4jLDYI3jp28cVwyyUoxVSTuAP4ZwOd
         eHYQ==
X-Gm-Message-State: AAQBX9frvAs+zrawLsxeQxpVN1sV1YFDUNFq/YWRIR0Y1m9APyk9r7ot
        rqNKeorlPWxBYU3IselHgyPFSA==
X-Google-Smtp-Source: AKy350ZbzBBTPMRQhngLffQy7PzpnOgmvA3rMCtcDaCYu5RetayM/piJpi1q741WwacF0lDRfL5Q9w==
X-Received: by 2002:a05:651c:201d:b0:2a3:108:d2e0 with SMTP id s29-20020a05651c201d00b002a30108d2e0mr3837706ljo.25.1679991977163;
        Tue, 28 Mar 2023 01:26:17 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id o7-20020a2e90c7000000b002958c4e96fasm4259696ljg.3.2023.03.28.01.26.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 01:26:16 -0700 (PDT)
Message-ID: <8f1a7383-ee64-3344-0971-8e2dc0277689@linaro.org>
Date:   Tue, 28 Mar 2023 10:26:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/3] remoteproc: qcom: pas: refactor SLPI remoteproc
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
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230327183736.496170-1-me@dylanvanassche.be>
 <20230327183736.496170-4-me@dylanvanassche.be>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230327183736.496170-4-me@dylanvanassche.be>
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



On 27.03.2023 20:37, Dylan Van Assche wrote:
> SLPI remoteproc initialization is the same for SDM845, SM8150, SM8250,
> SM8350 but is duplicated for each compatible. Refactor initialization
> structs for these 4 compatibles as a single struct.
> 
> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> ---
>  drivers/remoteproc/qcom_q6v5_pas.c | 66 ++++--------------------------
>  1 file changed, 9 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index d82b6f4bced4..d1c7baec4aca 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -1014,7 +1014,7 @@ static const struct adsp_data sc8180x_mpss_resource = {
>  	.ssctl_id = 0x12,
>  };
>  
> -static const struct adsp_data slpi_resource_init = {
> +static const struct adsp_data msm_slpi_resource_init = {
Clever idea, but I think naming it after the first SoC it was
used on (msm8996) will be clearer, e.g. msm8960 doesn't have SLPI.

>  		.crash_reason_smem = 424,
>  		.firmware_name = "slpi.mdt",
>  		.pas_id = 12,
> @@ -1028,7 +1028,7 @@ static const struct adsp_data slpi_resource_init = {
>  		.ssctl_id = 0x16,
>  };
>  
> -static const struct adsp_data sdm845_slpi_resource = {
> +static const struct adsp_data sm_slpi_resource_init = {
And similarly here, the sdm845 name can stay.

Konrad
>  		.crash_reason_smem = 424,
>  		.firmware_name = "slpi.mdt",
>  		.pas_id = 12,
> @@ -1044,54 +1044,6 @@ static const struct adsp_data sdm845_slpi_resource = {
>  		.ssctl_id = 0x16,
>  };
>  
> -static const struct adsp_data sm8150_slpi_resource = {
> -		.crash_reason_smem = 424,
> -		.firmware_name = "slpi.mdt",
> -		.pas_id = 12,
> -		.auto_boot = true,
> -		.proxy_pd_names = (char*[]){
> -			"lcx",
> -			"lmx",
> -			NULL
> -		},
> -		.load_state = "slpi",
> -		.ssr_name = "dsps",
> -		.sysmon_name = "slpi",
> -		.ssctl_id = 0x16,
> -};
> -
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
> @@ -1200,9 +1152,9 @@ static const struct of_device_id adsp_of_match[] = {
>  	{ .compatible = "qcom,msm8953-adsp-pil", .data = &msm8996_adsp_resource},
>  	{ .compatible = "qcom,msm8974-adsp-pil", .data = &adsp_resource_init},
>  	{ .compatible = "qcom,msm8996-adsp-pil", .data = &msm8996_adsp_resource},
> -	{ .compatible = "qcom,msm8996-slpi-pil", .data = &slpi_resource_init},
> +	{ .compatible = "qcom,msm8996-slpi-pil", .data = &msm_slpi_resource_init},
>  	{ .compatible = "qcom,msm8998-adsp-pas", .data = &msm8996_adsp_resource},
> -	{ .compatible = "qcom,msm8998-slpi-pas", .data = &slpi_resource_init},
> +	{ .compatible = "qcom,msm8998-slpi-pas", .data = &msm_slpi_resource_init},
>  	{ .compatible = "qcom,qcs404-adsp-pas", .data = &adsp_resource_init },
>  	{ .compatible = "qcom,qcs404-cdsp-pas", .data = &cdsp_resource_init },
>  	{ .compatible = "qcom,qcs404-wcss-pas", .data = &wcss_resource_init },
> @@ -1217,7 +1169,7 @@ static const struct of_device_id adsp_of_match[] = {
>  	{ .compatible = "qcom,sdm660-adsp-pas", .data = &adsp_resource_init},
>  	{ .compatible = "qcom,sdm845-adsp-pas", .data = &sdm845_adsp_resource_init},
>  	{ .compatible = "qcom,sdm845-cdsp-pas", .data = &sdm845_cdsp_resource_init},
> -	{ .compatible = "qcom,sdm845-slpi-pas", .data = &sdm845_slpi_resource},
> +	{ .compatible = "qcom,sdm845-slpi-pas", .data = &sm_slpi_resource_init},
>  	{ .compatible = "qcom,sdx55-mpss-pas", .data = &sdx55_mpss_resource},
>  	{ .compatible = "qcom,sm6115-adsp-pas", .data = &adsp_resource_init},
>  	{ .compatible = "qcom,sm6115-cdsp-pas", .data = &cdsp_resource_init},
> @@ -1228,17 +1180,17 @@ static const struct of_device_id adsp_of_match[] = {
>  	{ .compatible = "qcom,sm8150-adsp-pas", .data = &sm8150_adsp_resource},
>  	{ .compatible = "qcom,sm8150-cdsp-pas", .data = &sm8150_cdsp_resource},
>  	{ .compatible = "qcom,sm8150-mpss-pas", .data = &mpss_resource_init},
> -	{ .compatible = "qcom,sm8150-slpi-pas", .data = &sm8150_slpi_resource},
> +	{ .compatible = "qcom,sm8150-slpi-pas", .data = &sm_slpi_resource_init},
>  	{ .compatible = "qcom,sm8250-adsp-pas", .data = &sm8250_adsp_resource},
>  	{ .compatible = "qcom,sm8250-cdsp-pas", .data = &sm8250_cdsp_resource},
> -	{ .compatible = "qcom,sm8250-slpi-pas", .data = &sm8250_slpi_resource},
> +	{ .compatible = "qcom,sm8250-slpi-pas", .data = &sm_slpi_resource_init},
>  	{ .compatible = "qcom,sm8350-adsp-pas", .data = &sm8350_adsp_resource},
>  	{ .compatible = "qcom,sm8350-cdsp-pas", .data = &sm8350_cdsp_resource},
> -	{ .compatible = "qcom,sm8350-slpi-pas", .data = &sm8350_slpi_resource},
> +	{ .compatible = "qcom,sm8350-slpi-pas", .data = &sm_slpi_resource_init},
>  	{ .compatible = "qcom,sm8350-mpss-pas", .data = &mpss_resource_init},
>  	{ .compatible = "qcom,sm8450-adsp-pas", .data = &sm8350_adsp_resource},
>  	{ .compatible = "qcom,sm8450-cdsp-pas", .data = &sm8350_cdsp_resource},
> -	{ .compatible = "qcom,sm8450-slpi-pas", .data = &sm8350_slpi_resource},
> +	{ .compatible = "qcom,sm8450-slpi-pas", .data = &sm_slpi_resource_init},
>  	{ .compatible = "qcom,sm8450-mpss-pas", .data = &sm8450_mpss_resource},
>  	{ .compatible = "qcom,sm8550-adsp-pas", .data = &sm8550_adsp_resource},
>  	{ .compatible = "qcom,sm8550-cdsp-pas", .data = &sm8550_cdsp_resource},
