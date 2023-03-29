Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3756CD82D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjC2LGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjC2LGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:06:46 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8F046B4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:06:17 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id t14so15645861ljd.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680087973;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=etQbhrM6MU2XcAvOg/pcuO+n7EAOZrzaAg4KJ9fc/1U=;
        b=L598pYGTk5dQhsP3xakAE1nlbw8icPPUU4fLZTviNSmBOZM47k89eqjMRZSHQI+lJ5
         r8+UK5FbcFLnnqcfKNAKorjXAJ9DQW77M9f8fkrvF0AVJWZ7rgljGmysBLJj8zTKEVJE
         wwSx/MyYlxxvnaTLBPNsmLytw7JGs60cNvcCij2wD9wAtpfBHA2AFFNvTlWlgt/zJjxd
         XjjzRoht2fDeTwKAH3ayCLe0UqKoO+v5RRIOX1pT2NZZwg9R5xOu4AGOPZm+GpNzgLQI
         AoZKvlW1VYvDsouInb2j3aZCiHTJSwNP3cTImHOQqUvHBWiUwtL57WyRlHBmYrfWAwa3
         QDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680087973;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=etQbhrM6MU2XcAvOg/pcuO+n7EAOZrzaAg4KJ9fc/1U=;
        b=TTbTz+A8ccRawHtQMpzmxtUPlRYFIDejkFlbicPXw07IqvLxe20vGFBZwgiwODETA9
         s6DOKNYwV3MyAMdoJcxg/yQV9Aj5Ji+V295aNrPk7DocW7CvCcRDcdtD44pKA2V7ldtY
         iYP/jYrToPDpZfuKfWkeuUqDkyMxgchbNCrAQG7NPCjDDhmgn8poa9uXgdd0KjvH4Yfl
         WEl/oyAFqshGw+Ev46HeQBCSNd04rOR1ZSkrCq6lOBJrc+qEZj92dZ53/ZQ+thEvFydD
         gJZB9+rI+OVu55dFqRjWSmVnQIAymLRIYKuHWxvkwtxlnUnvL4Lipwxjqp4Xn3UR2t6f
         tiyQ==
X-Gm-Message-State: AAQBX9dKLKSvQBfOFnoJzfEgwcWSfvvRzvC/owV/LgrdTJB/m+0Eetgy
        VFEe6ukiPtvS6cVmvSsic9A9+Q==
X-Google-Smtp-Source: AKy350b+/6URBf3qxA94iYZXtupPRGRA1fBUy1YSTEaHaifqR95Qb3k0SvhFQZErzc8p36ToU28zJw==
X-Received: by 2002:a2e:9997:0:b0:29e:5dc2:903a with SMTP id w23-20020a2e9997000000b0029e5dc2903amr6754833lji.23.1680087973255;
        Wed, 29 Mar 2023 04:06:13 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id e4-20020ac25464000000b004d58e782886sm5419690lfn.303.2023.03.29.04.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 04:06:12 -0700 (PDT)
Message-ID: <c42b8c24-2159-64ae-d36c-92c69274f24f@linaro.org>
Date:   Wed, 29 Mar 2023 13:06:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] irqchip: irq-qcom-mpm: Support passing a slice of
 SRAM as reg space
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230328-topic-msgram_mpm-v1-0-1b788a5f5a33@linaro.org>
 <20230328-topic-msgram_mpm-v1-2-1b788a5f5a33@linaro.org>
 <20230329034958.GC3554086@dragon>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230329034958.GC3554086@dragon>
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



On 29.03.2023 05:49, Shawn Guo wrote:
> On Tue, Mar 28, 2023 at 12:02:53PM +0200, Konrad Dybcio wrote:
>> The MPM hardware is accessible to us from the ARM CPUs through a shared
>> memory region (RPM MSG RAM) that's also concurrently accessed by other
>> kinds of cores on the system (like modem, ADSP etc.). Modeling this
>> relation in a (somewhat) sane manner in the device tree basically
>> requires us to either present the MPM as a child of said memory region
>> (which makes little sense, as a mapped memory carveout is not a bus),
>> define nodes which bleed their register spaces into one another, or
>> passing their slice of the MSG RAM through some kind of a property.
>>
>> Go with the third option and add a way to map a region passed through
>> the "qcom,rpm-msg-ram" property as our register space.
>>
>> The current way of using 'reg' is preserved for ABI reasons.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/irqchip/irq-qcom-mpm.c | 30 +++++++++++++++++++++++++-----
>>  1 file changed, 25 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mpm.c
>> index d30614661eea..6fe59f4deef4 100644
>> --- a/drivers/irqchip/irq-qcom-mpm.c
>> +++ b/drivers/irqchip/irq-qcom-mpm.c
>> @@ -14,6 +14,7 @@
>>  #include <linux/mailbox_client.h>
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>> +#include <linux/of_address.h>
>>  #include <linux/of_device.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/pm_domain.h>
>> @@ -322,8 +323,10 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
>>  	struct device *dev = &pdev->dev;
>>  	struct irq_domain *parent_domain;
>>  	struct generic_pm_domain *genpd;
>> +	struct device_node *msgram_np;
>>  	struct qcom_mpm_priv *priv;
>>  	unsigned int pin_cnt;
>> +	struct resource res;
>>  	int i, irq;
>>  	int ret;
>>  
>> @@ -374,9 +377,21 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
>>  
>>  	raw_spin_lock_init(&priv->lock);
>>  
>> -	priv->base = devm_platform_ioremap_resource(pdev, 0);
>> -	if (IS_ERR(priv->base))
>> -		return PTR_ERR(priv->base);
>> +	/* If we have a handle to an RPM message ram partition, use it. */
>> +	msgram_np = of_parse_phandle(np, "qcom,rpm-msg-ram", 0);
>> +	if (msgram_np) {
>> +		ret = of_address_to_resource(msgram_np, 0, &res);
>> +		/* Don't use devm_ioremap_resource, as we're accessing a shared region. */
>> +		priv->base = ioremap(res.start, resource_size(&res));
> 
> Are you suggesting that other cores/drivers will also need to access
> the mpm slice below?
> 
> 	apss_mpm: sram@1b8 {
> 		reg = <0x1b8 0x48>;
> 	};
Yes, the RPM M3 core. Other slices may be accessed
by any core at any time.

Konrad
> 
> Shawn
> 
>> +		of_node_put(msgram_np);
>> +		if (IS_ERR(priv->base))
>> +			return PTR_ERR(priv->base);
>> +	} else {
>> +		/* Otherwise, fall back to simple MMIO. */
>> +		priv->base = devm_platform_ioremap_resource(pdev, 0);
>> +		if (IS_ERR(priv->base))
>> +			return PTR_ERR(priv->base);
>> +	}
>>  
>>  	for (i = 0; i < priv->reg_stride; i++) {
>>  		qcom_mpm_write(priv, MPM_REG_ENABLE, i, 0);
>> @@ -387,8 +402,10 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
>>  	}
>>  
>>  	irq = platform_get_irq(pdev, 0);
>> -	if (irq < 0)
>> -		return irq;
>> +	if (irq < 0) {
>> +		ret = irq;
>> +		goto unmap_base;
>> +	}
>>  
>>  	genpd = &priv->genpd;
>>  	genpd->flags = GENPD_FLAG_IRQ_SAFE;
>> @@ -451,6 +468,9 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
>>  	mbox_free_channel(priv->mbox_chan);
>>  remove_genpd:
>>  	pm_genpd_remove(genpd);
>> +unmap_base:
>> +	if (res.start)
>> +		iounmap(priv->base);
>>  	return ret;
>>  }
>>  
>>
>> -- 
>> 2.40.0
>>
