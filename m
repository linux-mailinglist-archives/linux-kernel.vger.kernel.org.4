Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39A06FCA79
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 17:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbjEIPqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 11:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjEIPqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 11:46:05 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F46110CF;
        Tue,  9 May 2023 08:46:04 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6435bbedb4fso6530350b3a.3;
        Tue, 09 May 2023 08:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683647164; x=1686239164;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=71PM0c8jNHbE9hDVzelzE+44lPJ6yhnjh+al/DYMEGM=;
        b=SEA4YE+jIMxurE4v8za3MHr2O6gaolZclraB7UcAIamSS+Dj8yKy0jXrX7aKbd7XqM
         ODwEULvon/ZHeJlDO0e2X7NsBu3EQ9VjifJNDxJysAg5ImkgjjCBTeJ6aV/SAr+2PnrP
         r73qgNNowQKOJlzR61Cj6po0v3hMx2fl8dDNacu/Ul+YccRQ6EzlQKoue3Ew4PvJ64e9
         CvqZRSE4RgeGuuxOY+r+YWXqXDEAKd58vhrbbpGyklzNWQkYD10DyrnkdVVSnasi0q9O
         3yA4Docte3BTc1xIHgWT7+39MYRFhDvH4p+r7yzJJlKu8w6kZxSHJqhNaPKRBoLRIFjE
         2fYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683647164; x=1686239164;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=71PM0c8jNHbE9hDVzelzE+44lPJ6yhnjh+al/DYMEGM=;
        b=FZcL8YF2172WCJ8SW2A+oz5iqIR7xklbEojaXM1KRdq5+8AXOyXjQyeEsaufIvR9lQ
         txnJejphe+YD3iywews/JcyNfV7thdisO3N3PvdYAO6MiJ438qeBT1/7RGj0ruL6vZ4I
         5OvgBTIQ/B5EyGYtjdqY/VUhTiyjcd9fwehECWKffsP9F/OuKFLBry0Jtu9TpX1J7pcm
         af/MzEMxAYHL1a5fJzcL5yCL1puMfWJvDVescbzwShvCYnr/xITk9vfose4YoCXdB0rO
         6NBU9GIrMbOTOj665my2ZK+4J7CylfwhfgQtinjTKrvlr5vcS/4mlDsJTGSNrwDHF69z
         s8MA==
X-Gm-Message-State: AC+VfDwdM6AQhMDYRhzUCktQafOGcm4ydRhun5QQhppVuW9yQ8bVbmMO
        tWmxV06c/x777tVc2VstzNM=
X-Google-Smtp-Source: ACHHUZ40OSB3ygellDJMvNryY1OSEE6VRfNqx3TuFWOwXIXAE8QVpIUy0A0EEw+J+Wkbd/hFvnAwEA==
X-Received: by 2002:a05:6a20:429b:b0:101:4c8c:d1fa with SMTP id o27-20020a056a20429b00b001014c8cd1famr3595014pzj.5.1683647163538;
        Tue, 09 May 2023 08:46:03 -0700 (PDT)
Received: from [192.168.50.148] (net-2-32-39-33.cust.vodafonedsl.it. [2.32.39.33])
        by smtp.gmail.com with ESMTPSA id b30-20020a631b1e000000b0050bd4bb900csm1489844pgb.71.2023.05.09.08.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 08:46:02 -0700 (PDT)
Message-ID: <e59064e1-a826-1b90-fed4-29b0cabb1a87@gmail.com>
Date:   Tue, 9 May 2023 17:45:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 12/18] soc: qcom: Register pstore frontend region with
 minidump
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, corbet@lwn.net,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
 <1683133352-10046-13-git-send-email-quic_mojha@quicinc.com>
From:   Luca Stefani <luca.stefani.ge1@gmail.com>
In-Reply-To: <1683133352-10046-13-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FYI the following comments also apply to the downstream driver, as the 
same bogus logic is implemented.

On 03/05/23 19:02, Mukesh Ojha wrote:

> Since qcom_pstore_minidump driver creates platform device
> for qualcomm devices, so it knows the physical addresses
> of the frontend region now. Let's register the regions
> with qcom_minidump driver.
>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>   drivers/soc/qcom/qcom_pstore_minidump.c | 80 ++++++++++++++++++++++++++++++++-
>   1 file changed, 79 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/qcom/qcom_pstore_minidump.c b/drivers/soc/qcom/qcom_pstore_minidump.c
> index 8d58500..c2bba4e 100644
> --- a/drivers/soc/qcom/qcom_pstore_minidump.c
> +++ b/drivers/soc/qcom/qcom_pstore_minidump.c
> @@ -11,6 +11,8 @@
>   #include <linux/pstore_ram.h>
>   #include <soc/qcom/qcom_minidump.h>
>   
> +#define QCOM_PSTORE_TYPE_MAX	4
Unused
> +
>   struct qcom_ramoops_config {
>   	unsigned long	record_size;
>   	unsigned long	console_size;
> @@ -24,6 +26,11 @@ struct qcom_ramoops_config {
>   struct qcom_ramoops_dd {
>   	struct ramoops_platform_data qcom_ramoops_pdata;
>   	struct platform_device *ramoops_pdev;
> +	struct device *dev;
> +	struct qcom_apss_minidump_region *record_region;

In the pstore driver record_size is used to split the KDMESG region into 
different chunks.

There's no "record" region anywhere in RAM that should be preserved, it 
should instead be the dmesg_region.

> +	struct qcom_apss_minidump_region *console_region;
> +	struct qcom_apss_minidump_region *pmsg_region;
> +	struct qcom_apss_minidump_region *ftrace_region;
>   };
>   
>   static struct qcom_ramoops_config default_ramoops_config = {
> @@ -35,6 +42,64 @@ static struct qcom_ramoops_config default_ramoops_config = {
>   };
>   
>   static struct qcom_ramoops_dd *qcom_rdd;
> +
> +static int
> +__qcom_ramoops_minidump_region_register(struct qcom_apss_minidump_region *md_region,
> +					const char *name, phys_addr_t phys_addr,
> +					unsigned long size)
> +{
> +	int ret;
> +
> +	if (!size)
> +		return 0;
> +
> +	md_region = devm_kzalloc(qcom_rdd->dev, sizeof(*md_region), GFP_KERNEL);
> +	if (!md_region)
> +		return -ENOMEM;
> +
> +	strlcpy(md_region->name, name, sizeof(md_region->name));
> +	md_region->phys_addr = phys_addr;
> +	md_region->virt_addr = phys_to_virt(phys_addr);
> +	md_region->size = size;
> +	ret = qcom_apss_minidump_region_register(md_region);
> +	if (ret)
> +		dev_err(qcom_rdd->dev,
> +			"failed to add %s in minidump: err: %d\n", name, ret);
> +
> +	return ret;
> +}
> +
> +static int
> +qcom_ramoops_minidump_region_register(struct ramoops_platform_data *qcom_ramoops_data)
> +{
> +	phys_addr_t phys_addr;
> +	int ret = 0;
> +
> +	phys_addr = qcom_ramoops_data->mem_address;
> +	ret = __qcom_ramoops_minidump_region_register(qcom_rdd->record_region,
> +			"KDMESG", phys_addr, qcom_ramoops_data->record_size);

You can't use record_size here as it's not the actual size of the dmesg 
region.

The size is calculated in fs/pstore/ram.c as mem_size - console_size - 
ftrace_size - pmsg_size, where mem_size is the size on the ramoops 
memory region in the devicetree.

Since the actual size is never exposed by the pstore driver you have to 
re-purpose the same logic in this driver, hoping it never changes.

> +	if (ret)
> +		return ret;
> +
> +	phys_addr += qcom_ramoops_data->record_size;
> +	ret = __qcom_ramoops_minidump_region_register(qcom_rdd->console_region,
> +			"KCONSOLE", phys_addr, qcom_ramoops_data->console_size);
> +	if (ret)
> +		return ret;
> +
> +	phys_addr += qcom_ramoops_data->console_size;
> +	ret = __qcom_ramoops_minidump_region_register(qcom_rdd->pmsg_region,
> +			"KPMSG", phys_addr, qcom_ramoops_data->pmsg_size);
> +	if (ret)
> +		return ret;
> +
> +	phys_addr += qcom_ramoops_data->pmsg_size;
> +	ret = __qcom_ramoops_minidump_region_register(qcom_rdd->ftrace_region,
> +			"KFTRACE", phys_addr, qcom_ramoops_data->ftrace_size);
> +
> +	return ret;
> +}
> +
>   static int qcom_ramoops_probe(struct platform_device *pdev)
>   {
>   	struct device_node *of_node = pdev->dev.of_node;
> @@ -59,6 +124,7 @@ static int qcom_ramoops_probe(struct platform_device *pdev)
>   	if (!qcom_rdd)
>   		return -ENOMEM;
>   
> +	qcom_rdd->dev = &pdev->dev;
>   	cfg = of_device_get_match_data(&pdev->dev);
>   	if (!cfg) {
>   		dev_err(&pdev->dev, "failed to get supported matched data\n");
> @@ -81,13 +147,25 @@ static int qcom_ramoops_probe(struct platform_device *pdev)
>   		ret = PTR_ERR(qcom_rdd->ramoops_pdev);
>   		dev_err(&pdev->dev, "could not create platform device: %ld\n", ret);
>   		qcom_rdd->ramoops_pdev = NULL;
> +		return ret;
>   	}
>   
> -	return ret;
> +	return qcom_ramoops_minidump_region_register(pdata);
>   }
>   
>   static int qcom_ramoops_remove(struct platform_device *pdev)
>   {
> +	struct ramoops_platform_data *pdata;
> +
> +	pdata = &qcom_rdd->qcom_ramoops_pdata;
> +	if (pdata->record_size)
> +		qcom_apss_minidump_region_unregister(qcom_rdd->record_region);
> +	if (pdata->console_size)
> +		qcom_apss_minidump_region_unregister(qcom_rdd->console_region);
> +	if (pdata->pmsg_size)
> +		qcom_apss_minidump_region_unregister(qcom_rdd->pmsg_region);
> +	if (pdata->ftrace_size)
> +		qcom_apss_minidump_region_unregister(qcom_rdd->ftrace_region);
>   	platform_device_unregister(qcom_rdd->ramoops_pdev);
>   	qcom_rdd->ramoops_pdev = NULL;
>   

Regards,

Luca Stefani

