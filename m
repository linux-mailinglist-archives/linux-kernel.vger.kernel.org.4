Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF916B526B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjCJU6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjCJU6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:58:24 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535C914162A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 12:57:06 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id r27so8278032lfe.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 12:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678481789;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3iypdK/PTIyXMMhGeKVAZ2Hiv7C7qzedziRBb2TqJFw=;
        b=UxEzjf8R4xu8pXnv2U3dCAsZsJFEdvMJV2clKq0Y6h7uwE1Gc7auM2Twkft0ig70Z2
         kXZFyjBmJCblrcE6CHRG94cQsIeIDVUx9rPrGIp7r+UPfQ6+vZRJvmT4kv8bGo4Je3Zm
         IhKFltX8hAtejUBDQFYNc9K7lGxbWNHLyGrhYHWWfOm05MsnGFfGNj22ogm1n/TZi57U
         LVxxvmBDXWj8hfzosTu4MLhndCeAz9C37sS+kNuVU0cDU5/gxl2bqI0veJl98vTsdvWp
         QAH8cyBkq7da5ELF6VP662FxrzODSbLsUjhVNV0BJQHiVjfBpagDi04TRFV8XRev5ZTt
         iKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678481789;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3iypdK/PTIyXMMhGeKVAZ2Hiv7C7qzedziRBb2TqJFw=;
        b=hZUeLlnoxHm4+sB0MZFHQObmTS9oCOyrv9quh7XpRdAHpEUc8VAXDn3RcdOzx4+xfG
         p2SiNc9jNEVI3gP5tny6S8fIkm+66zhK8KPYQV7eAZqqtiP/9RVBtOFkN8hVupNGe12e
         53K7nQIAd3vRL4lZ1H7OjtKtj/jq4J0k+fs7H9okBeMLVRijnFuE9nzWiyeotri+QuF8
         5NHd6TcEmr2zqbVdzU6wV6CN7bh+xL3+mea/9m+yFxVWC468TK+nVcvhD2Y1D0wCpr27
         rQ0Fl1P6gPIMRyACy3dlaXoGc0R1+4N14N7EppE3iptrbtqhBxgSAp7GKlVxX5dJeXkO
         6inw==
X-Gm-Message-State: AO0yUKWai92idJAcM8TAXEvuJVguEp5xVIgJn3xyPjqn1C/UjYQaghbO
        y+KJnDeVnsdVPACh4P8mZ5ELYQ==
X-Google-Smtp-Source: AK7set/MD3FYf9FyCnd2BayTRaKNAA0o4NJD3OB7hB9GK+BJP31hQLkS7aGOmdTrR78C9gCDBBeJCw==
X-Received: by 2002:ac2:41d5:0:b0:4dd:af76:d3c with SMTP id d21-20020ac241d5000000b004ddaf760d3cmr7004375lfi.48.1678481789515;
        Fri, 10 Mar 2023 12:56:29 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id y28-20020ac2447c000000b004db45648d78sm94984lfl.13.2023.03.10.12.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 12:56:29 -0800 (PST)
Message-ID: <9f6b071b-63fe-8628-0826-acada06df5ae@linaro.org>
Date:   Fri, 10 Mar 2023 22:56:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 04/12] soc: qcom: pmic_glink: register ucsi aux device
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
References: <20230130-topic-sm8450-upstream-pmic-glink-v3-0-4c860d265d28@linaro.org>
 <20230130-topic-sm8450-upstream-pmic-glink-v3-4-4c860d265d28@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v3-4-4c860d265d28@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2023 15:27, Neil Armstrong wrote:
> Only register UCSI on know working devices, like on the SM8450
> or SM8550 which requires UCSI to get USB mode switch events.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/soc/qcom/pmic_glink.c | 63 ++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 53 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
> index bb3fb57abcc6..48e015fee8e9 100644
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
> +	const struct of_device_id *match;
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
> +	match = of_device_get_match_data(&pdev->dev);

This is incorrect. of_device_get_match_data() already returns 
match->data, rather than a matching of_device_id().

> +	if (match)
> +		pg->client_mask = (unsigned long)match->data;
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
> @@ -301,7 +338,13 @@ static int pmic_glink_remove(struct platform_device *pdev)
>   	return 0;
>   }
>   
> +/* Do not handle altmode for now on those platforms */
> +static const unsigned long pmic_glink_sm8450_client_mask = BIT(PMIC_GLINK_CLIENT_BATT) |
> +							   BIT(PMIC_GLINK_CLIENT_UCSI);
> +
>   static const struct of_device_id pmic_glink_of_match[] = {
> +	{ .compatible = "qcom,sm8450-pmic-glink", .data = &pmic_glink_sm8450_client_mask },
> +	{ .compatible = "qcom,sm8550-pmic-glink", .data = &pmic_glink_sm8450_client_mask },
>   	{ .compatible = "qcom,pmic-glink", },
>   	{}
>   };
> 

-- 
With best wishes
Dmitry

