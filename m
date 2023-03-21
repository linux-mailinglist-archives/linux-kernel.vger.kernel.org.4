Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071C26C35D5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjCUPiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjCUPiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:38:13 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296477D89
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:38:10 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j11so19620425lfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679413087;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q/hHAe5iawN3skZzVZDnwhhdvLIa9hx/rH3tuAV1a/Y=;
        b=nl+cB0MrV4ln5nxojPnc/K4a0UCvfGjtmVhygVZpD7PVa/igo4qoW/bWhyN58nE345
         sOcsidbdyQelA0q5yyb9CKK/7Vdshos6+YQWgiK6za7PZtTRs9l2JhRNFtr6F58VsC3o
         S/rBGzfytaeT4LmmjvNV+ZFZjYV5vQOzTmLE2zmjJBni0QbfsVsemeBI8eF5EtzZw285
         lthQRCX/7kOEOvH+7gtdT2tVdw892MHQ+A4eeK3Tk4Baa1cKXWyZIxE5TVjGxsP7ArPG
         ZWQc1ymC0IKKpOvNebI4KA1kF/jgmkC0wft0eIjYAlPVZpO2wPPcK+ED2RtpBZXfIQiE
         njcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679413087;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/hHAe5iawN3skZzVZDnwhhdvLIa9hx/rH3tuAV1a/Y=;
        b=rACy45kZoxN0MS3bDbOR6N+Sc8TDnjmWAiwIq8jHp12BjIfZxQE1XhxrPAbylAnoh+
         cdwa00BAw3ipiGlHqVReZgoJf4tq+EPPCfz78+kxOPHAl7NtNoZ3Jqj7no4E9aV8JKc4
         ve1IVM2QivdfePcGUeMuPHl+GmCQLgTNdxSG4kafQuXqYDCxs8spQdK23m/GsE3itvsl
         WJWwb3Eg2scRUEf47PCwiq7jzI2C7F0NtPj4wTfttJoBknEa1j8YKIALDXsHWDEDog0k
         87Eh6T6SuHiggawC+EBgCEumooZG4iqYSaxb6R3ZIV19ZGoV0B8tXtO9s3SbRqOpi67j
         hSRA==
X-Gm-Message-State: AO0yUKXKzFa8BUJLwEkInm3vPUH97xF319Q2sSEFVOTVW1C+cvDph6Aa
        3FzNgtLWbjsTAznKfM/b8i3nLA==
X-Google-Smtp-Source: AK7set+STU3G9QvNmNnVmdGOtK+qF7WbPNGCp2TWURDMZxtNtpOd5g+l+wav4QS+f2Wk7N556My/8Q==
X-Received: by 2002:ac2:424e:0:b0:4db:3e56:55c8 with SMTP id m14-20020ac2424e000000b004db3e5655c8mr1010770lfl.59.1679413087349;
        Tue, 21 Mar 2023 08:38:07 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id v5-20020a056512048500b004db513b0175sm2208560lfq.136.2023.03.21.08.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 08:38:06 -0700 (PDT)
Message-ID: <7ef646e0-388e-b2ef-a28c-f1fcce486203@linaro.org>
Date:   Tue, 21 Mar 2023 17:38:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 04/12] soc: qcom: pmic_glink: register ucsi aux device
Content-Language: en-GB
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230130-topic-sm8450-upstream-pmic-glink-v5-0-552f3b721f9e@linaro.org>
 <20230130-topic-sm8450-upstream-pmic-glink-v5-4-552f3b721f9e@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v5-4-552f3b721f9e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2023 15:21, Neil Armstrong wrote:
> Only register UCSI on know working devices, like on the SM8450
> or SM8550 which requires UCSI to get USB mode switch events.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Two nits below:

> ---
>   drivers/soc/qcom/pmic_glink.c | 65 +++++++++++++++++++++++++++++++++++--------
>   1 file changed, 54 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
> index bb3fb57abcc6..8bf95df0a56a 100644
> --- a/drivers/soc/qcom/pmic_glink.c
> +++ b/drivers/soc/qcom/pmic_glink.c
> @@ -4,6 +4,7 @@
>    * Copyright (c) 2022, Linaro Ltd
>    */
>   #include <linux/auxiliary_bus.h>
> +#include <linux/of_device.h>
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
>   #include <linux/rpmsg.h>
> @@ -11,12 +12,23 @@
>   #include <linux/soc/qcom/pdr.h>
>   #include <linux/soc/qcom/pmic_glink.h>
>   
> +enum {
> +	PMIC_GLINK_CLIENT_BATT = 0,
> +	PMIC_GLINK_CLIENT_ALTMODE,
> +	PMIC_GLINK_CLIENT_UCSI,
> +};
> +
> +#define PMIC_GLINK_CLIENT_DEFAULT	(BIT(PMIC_GLINK_CLIENT_BATT) |	\
> +					 BIT(PMIC_GLINK_CLIENT_ALTMODE))
> +
>   struct pmic_glink {
>   	struct device *dev;
>   	struct pdr_handle *pdr;
>   
>   	struct rpmsg_endpoint *ept;
>   
> +	unsigned long client_mask;
> +
>   	struct auxiliary_device altmode_aux;
>   	struct auxiliary_device ps_aux;
>   	struct auxiliary_device ucsi_aux;
> @@ -233,6 +245,7 @@ static struct rpmsg_driver pmic_glink_rpmsg_driver = {
>   
>   static int pmic_glink_probe(struct platform_device *pdev)
>   {
> +	const unsigned long *match_data;
>   	struct pdr_service *service;
>   	struct pmic_glink *pg;
>   	int ret;
> @@ -249,12 +262,27 @@ static int pmic_glink_probe(struct platform_device *pdev)
>   	mutex_init(&pg->client_lock);
>   	mutex_init(&pg->state_lock);
>   
> -	ret = pmic_glink_add_aux_device(pg, &pg->altmode_aux, "altmode");
> -	if (ret)
> -		return ret;
> -	ret = pmic_glink_add_aux_device(pg, &pg->ps_aux, "power-supply");
> -	if (ret)
> -		goto out_release_altmode_aux;
> +	match_data = (unsigned long *)of_device_get_match_data(&pdev->dev);

Nit: type cast should not be necessary here.

> +	if (match_data)
> +		pg->client_mask = *match_data;
> +	else
> +		pg->client_mask = PMIC_GLINK_CLIENT_DEFAULT;
> +
> +	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI)) {
> +		ret = pmic_glink_add_aux_device(pg, &pg->ucsi_aux, "ucsi");
> +		if (ret)
> +			return ret;
> +	}
> +	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_ALTMODE)) {
> +		ret = pmic_glink_add_aux_device(pg, &pg->altmode_aux, "altmode");
> +		if (ret)
> +			goto out_release_ucsi_aux;
> +	}
> +	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_BATT)) {
> +		ret = pmic_glink_add_aux_device(pg, &pg->ps_aux, "power-supply");
> +		if (ret)
> +			goto out_release_altmode_aux;
> +	}
>   
>   	pg->pdr = pdr_handle_alloc(pmic_glink_pdr_callback, pg);
>   	if (IS_ERR(pg->pdr)) {
> @@ -278,9 +306,14 @@ static int pmic_glink_probe(struct platform_device *pdev)
>   out_release_pdr_handle:
>   	pdr_handle_release(pg->pdr);
>   out_release_aux_devices:
> -	pmic_glink_del_aux_device(pg, &pg->ps_aux);
> +	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_BATT))
> +		pmic_glink_del_aux_device(pg, &pg->ps_aux);
>   out_release_altmode_aux:
> -	pmic_glink_del_aux_device(pg, &pg->altmode_aux);
> +	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_ALTMODE))
> +		pmic_glink_del_aux_device(pg, &pg->altmode_aux);
> +out_release_ucsi_aux:
> +	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI))
> +		pmic_glink_del_aux_device(pg, &pg->ucsi_aux);
>   
>   	return ret;
>   }
> @@ -291,8 +324,12 @@ static int pmic_glink_remove(struct platform_device *pdev)
>   
>   	pdr_handle_release(pg->pdr);
>   
> -	pmic_glink_del_aux_device(pg, &pg->ps_aux);
> -	pmic_glink_del_aux_device(pg, &pg->altmode_aux);
> +	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_BATT))
> +		pmic_glink_del_aux_device(pg, &pg->ps_aux);
> +	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_ALTMODE))
> +		pmic_glink_del_aux_device(pg, &pg->altmode_aux);
> +	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI))
> +		pmic_glink_del_aux_device(pg, &pg->ucsi_aux);
>   
>   	mutex_lock(&__pmic_glink_lock);
>   	__pmic_glink = NULL;
> @@ -301,8 +338,14 @@ static int pmic_glink_remove(struct platform_device *pdev)
>   	return 0;
>   }
>   
> +/* Do not handle altmode for now on those platforms */
> +static const unsigned long pmic_glink_sm8450_client_mask = BIT(PMIC_GLINK_CLIENT_BATT) |
> +							   BIT(PMIC_GLINK_CLIENT_UCSI);
> +
>   static const struct of_device_id pmic_glink_of_match[] = {
> -	{ .compatible = "qcom,pmic-glink", },

Nit: one can leave comma in place to remove noise.

> +	{ .compatible = "qcom,sm8450-pmic-glink", .data = &pmic_glink_sm8450_client_mask },
> +	{ .compatible = "qcom,sm8550-pmic-glink", .data = &pmic_glink_sm8450_client_mask },
> +	{ .compatible = "qcom,pmic-glink" },
>   	{}
>   };
>   MODULE_DEVICE_TABLE(of, pmic_glink_of_match);
> 

-- 
With best wishes
Dmitry

