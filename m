Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5494E692277
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjBJPlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjBJPld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:41:33 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728B755E4A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:41:31 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id jg8so16927839ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A1Krkj0HlE9Ql2Nee9gMF+rHkVhX1QhowmXp2knlFDg=;
        b=hp9Um3WQTsZC83hlfDAGYNtcbL+/NLkWpoGb8qtkv0tYuLR4iiTb2MIokqzcvCzXBq
         8gZ0pc6vroLVDnr+8ca2MVt8riGEBRzuZ64GbzB2U9whlwZe7U+dnGBeLRO5v5Np3qXP
         4J+pjrVVsj/mWHo+3yhH54t6JZQmsNFfoKNsdcHHikpwidgMek/OzHSIxLtA7nmfS5Rw
         oGT/Vm332glf57IbR7uyQDDkBu3B9Sy+bz2FEWSddOaGttsdcfuHIHSi3ZNKoOzWC7Ma
         8CHdtMOZ6g8IiehMMnciI4+Na7+R/pThZsq2mJTdRbx75TH5abiRzsrOsKbqMCZUa6bT
         2nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A1Krkj0HlE9Ql2Nee9gMF+rHkVhX1QhowmXp2knlFDg=;
        b=tnIiv6sZk7x+eS2qC0OLq+xQVzvxZRTzzQXhQWb0n0iPgYXg7fR93+n9HITUBZJ/eW
         Xy98vS4nxCWXxIhtV5149Ki/NgXOG4kqpkKW/ftDfGHhzAnWoTE7FbOzB0dS176rI2Sf
         avYIOiAt8eyNoQPOALQoOXa0rtGkxPlz4mY/KMF2n9qriKYJ/E+6N3AmIOq01053+vel
         Q40cpLjil77RJui8QmCT9iy82Ns/6rhj9P69z4z35f2SpGKAa9WaYqF8mxqcNvA6S5nX
         R2FbZkhVqQW7oOInddGVrNa4c4RqgAjHyk1D40k0gbcsN5VNr6ft+RECVas0KayyBByk
         13nA==
X-Gm-Message-State: AO0yUKU3ge0QYsoPrPXgafTzZIyqKKPXqbhT2+f+M3swsjoXQ/r7GKnu
        PLq77IfKL9TuKDnXsBfsc5kJzw==
X-Google-Smtp-Source: AK7set+VF+YEIS/EikfHWnoUysi3pO4tkHw3TiDqGHn38RHcBhEwopxcU2G9etm2BwmzAMxSYuultw==
X-Received: by 2002:a17:907:6e1f:b0:8aa:502c:44d3 with SMTP id sd31-20020a1709076e1f00b008aa502c44d3mr18760391ejc.41.1676043690024;
        Fri, 10 Feb 2023 07:41:30 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id a11-20020a170906368b00b0088519b9206bsm2489176ejc.130.2023.02.10.07.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 07:41:29 -0800 (PST)
Message-ID: <f548bb4f-9940-044f-95b2-e7c7bed276aa@linaro.org>
Date:   Fri, 10 Feb 2023 17:41:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 04/11] soc: qcom: pmic_glink: register ucsi aux device
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
References: <20230130-topic-sm8450-upstream-pmic-glink-v2-0-71fea256474f@linaro.org>
 <20230130-topic-sm8450-upstream-pmic-glink-v2-4-71fea256474f@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v2-4-71fea256474f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2023 17:02, Neil Armstrong wrote:
> Only register UCSI on know working devices, like on the SM8450
> or Sm8550 which requires UCSI to get USB mode switch events.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/soc/qcom/pmic_glink.c | 67 ++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 57 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
> index bb3fb57abcc6..c7f091f4a8c1 100644
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
> +	unsigned int client_mask;
> +
>   	struct auxiliary_device altmode_aux;
>   	struct auxiliary_device ps_aux;
>   	struct auxiliary_device ucsi_aux;
> @@ -231,8 +243,19 @@ static struct rpmsg_driver pmic_glink_rpmsg_driver = {
>   	},
>   };
>   
> +/* Do not handle altmode for now on those platforms */
> +static const unsigned int pmic_glink_sm8450_client_mask = BIT(PMIC_GLINK_CLIENT_BATT) |
> +							  BIT(PMIC_GLINK_CLIENT_UCSI);
> +
> +static const struct of_device_id pmic_glink_of_client_mask[] = {
> +	{ .compatible = "qcom,sm8450-pmic-glink", .data = &pmic_glink_sm8450_client_mask },
> +	{ .compatible = "qcom,sm8550-pmic-glink", .data = &pmic_glink_sm8450_client_mask },
> +	{}
> +};
> +

Squash this into pmic_glink_of_match, please. Then you can use 
of_device_get_match_data()

>   static int pmic_glink_probe(struct platform_device *pdev)
>   {
> +	const struct of_device_id *match;
>   	struct pdr_service *service;
>   	struct pmic_glink *pg;
>   	int ret;
> @@ -249,12 +272,27 @@ static int pmic_glink_probe(struct platform_device *pdev)
>   	mutex_init(&pg->client_lock);
>   	mutex_init(&pg->state_lock);
>   
> -	ret = pmic_glink_add_aux_device(pg, &pg->altmode_aux, "altmode");
> -	if (ret)
> -		return ret;
> -	ret = pmic_glink_add_aux_device(pg, &pg->ps_aux, "power-supply");
> -	if (ret)
> -		goto out_release_altmode_aux;
> +	match = of_match_device(pmic_glink_of_client_mask, &pdev->dev);
> +	if (match)
> +		pg->client_mask = *(const unsigned int *)match->data;
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
> @@ -278,9 +316,14 @@ static int pmic_glink_probe(struct platform_device *pdev)
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
> @@ -291,8 +334,12 @@ static int pmic_glink_remove(struct platform_device *pdev)
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
> 

-- 
With best wishes
Dmitry

