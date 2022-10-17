Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54478601B8A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJQVwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiJQVwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:52:38 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F6580BD8;
        Mon, 17 Oct 2022 14:52:37 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r14so17966167edc.7;
        Mon, 17 Oct 2022 14:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uSPRz8L/x4zaIZvnlFWanqPgSXzF0IQCjxAcmNys1g=;
        b=jir+oHr3Q9WQMzdUUsFeyKsTp9eGK+7u3wYck3PtVLmIUbzs5E5nEf3DpwGZrZs2Br
         ZXmNAE9XwORdNHrl4iwZEQlucKx5hNwG8HT6SdtdDNaf0fC8np+umLJY8eiD15BIiwsg
         Fd4sO1OOcdrilA4YJiklioGU71+CqAGZxGcAWEOjISPlKQLutST4Jq9b+rr2/MHC2Erl
         lkSmKrCEtEHlPCF+r55P+m1dzuZpTSb1qxat5AZqAHJ6z76QFhc/BqKCXc5LZgLD4kXy
         6gV5ORwVSnuPsIfafIKg9R/K7RjuVMYv4ktvnbJUmm75ZHuCsKrMuxwZeDRBl5H3zhEd
         8tdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1uSPRz8L/x4zaIZvnlFWanqPgSXzF0IQCjxAcmNys1g=;
        b=FpMAJyak0I4RckYZFN3ZanQ1J9Jwt0EjKEjyUq/7EfPZ/awZ0rEgGiSCcXmFVUg1IT
         wd4kBk8C77Fr1gPIp8FgNsnhQ6z7P6ruI7XS9iEjizktGv1luHhkV64F95mZUAkqV4Uu
         GYr4zG9dPuH0t8Ax2fL/nYbx3JC1ClrEnUqWQ8m+GVAPeunS8hpICfkFElOAzvhil8Ux
         FU2ozhzuI2K2O9QQ/I9Zu2KrX1KmcC1JiVU612FeNSMJk4IRB0gnuREzJn0op7lujbaV
         zYiSEILhgIizGn/DPML2PPpHpLrFWjd5SJjDTfcWnwkaymP/wDupfYF4fS4XQK4V4NAl
         ErZw==
X-Gm-Message-State: ACrzQf0FFabfD7+f05jUmj5czbFhwiTHZC+c72RQm0GCbWNIXsSmdCit
        PPclVD09f8Lv+vRc+I522sg=
X-Google-Smtp-Source: AMsMyM6/0V6fJjsPg/7cBjPLzZwNUZ7XVH0KICpkLIBx14ASkwjhFB2jHNNopC8sMq+N2YGDHy5GSQ==
X-Received: by 2002:a05:6402:90a:b0:458:ca4d:a2f8 with SMTP id g10-20020a056402090a00b00458ca4da2f8mr12098159edz.230.1666043555727;
        Mon, 17 Oct 2022 14:52:35 -0700 (PDT)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id c7-20020aa7d607000000b0045d74aa401fsm3929612edr.60.2022.10.17.14.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 14:52:35 -0700 (PDT)
Message-ID: <d98dd483-70b9-4bd1-0463-9e3343576955@gmail.com>
Date:   Mon, 17 Oct 2022 23:52:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH v5 3/3] mtd: core: introduce of support for dynamic
 partitions
To:     "han.xu" <han.xu@nxp.com>, Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?B?77+9ZWNraQ==?= <rafal@milecki.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220606151417.19227-1-ansuelsmth@gmail.com>
 <20220606151417.19227-4-ansuelsmth@gmail.com>
 <20221017195820.ve6c3zj2civkswm6@umbrella>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20221017195820.ve6c3zj2civkswm6@umbrella>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.10.2022 21:59, han.xu wrote:
> On 22/06/06 05:14PM, Ansuel Smith wrote:
>> We have many parser that register mtd partitions at runtime. One example
>> is the cmdlinepart or the smem-part parser where the compatible is defined
>> in the dts and the partitions gets detected and registered by the
>> parser. This is problematic for the NVMEM subsystem that requires an OF node
>> to detect NVMEM cells.
>>
>> To fix this problem, introduce an additional logic that will try to
>> assign an OF node to the MTD if declared.
>>
>> On MTD addition, it will be checked if the MTD has an OF node and if
>> not declared will check if a partition with the same label is
>> declared in DTS. If an exact match is found, the partition dynamically
>> allocated by the parser will have a connected OF node.
>>
>> The NVMEM subsystem will detect the OF node and register any NVMEM cells
>> declared statically in the DTS.
>>
>> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
>> ---
>>   drivers/mtd/mtdcore.c | 49 +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 49 insertions(+)
>>
>> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
>> index 7731796024e0..807194efb580 100644
>> --- a/drivers/mtd/mtdcore.c
>> +++ b/drivers/mtd/mtdcore.c
>> @@ -546,6 +546,54 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
>>   	return 0;
>>   }
>>   
>> +static void mtd_check_of_node(struct mtd_info *mtd)
>> +{
>> +	struct device_node *partitions, *parent_dn, *mtd_dn = NULL;
>> +	struct mtd_info *parent;
>> +	const char *mtd_name;
>> +	bool found = false;
>> +	int plen;
>> +
>> +	/* Check if MTD already has a device node */
>> +	if (dev_of_node(&mtd->dev))
>> +		return;
>> +
>> +	/* Check if a partitions node exist */
>> +	parent = mtd->parent;
>> +	parent_dn = dev_of_node(&parent->dev);
>> +	if (!parent_dn)
>> +		return;
>> +
>> +	partitions = of_get_child_by_name(parent_dn, "partitions");
>> +	if (!partitions)
>> +		goto exit_parent;
>> +
>> +	/* Search if a partition is defined with the same name */
>> +	for_each_child_of_node(partitions, mtd_dn) {
>> +		/* Skip partition with no label */
>> +		mtd_name = of_get_property(mtd_dn, "label", &plen);
>> +		if (!mtd_name)
>> +			continue;
>> +
>> +		if (!strncmp(mtd->name, mtd_name, plen)) {
>> +			found = true;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!found)
>> +		goto exit_partitions;
>> +
>> +	/* Set of_node only for nvmem */
>> +	if (of_device_is_compatible(mtd_dn, "nvmem-cells"))
>> +		mtd_set_of_node(mtd, mtd_dn);
>> +
>> +exit_partitions:
>> +	of_node_put(partitions);
>> +exit_parent:
>> +	of_node_put(parent_dn);
>> +}
>> +
>>   /**
>>    *	add_mtd_device - register an MTD device
>>    *	@mtd: pointer to new MTD device info structure
>> @@ -651,6 +699,7 @@ int add_mtd_device(struct mtd_info *mtd)
>>   	mtd->dev.devt = MTD_DEVT(i);
>>   	dev_set_name(&mtd->dev, "mtd%d", i);
>>   	dev_set_drvdata(&mtd->dev, mtd);
>> +	mtd_check_of_node(mtd);
>>   	of_node_get(mtd_get_of_node(mtd));
>>   	error = device_register(&mtd->dev);
>>   	if (error)
> 
> NXP GPMI NAND controller with 6 cmdline partitions meets refcount underflow
> with this patch. The of_node_put(parent_dn) doesn't work with cmdline parser and
> causes the issue.

Can you try:

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 18aa54460d36..0b4ca0aa4132 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -562,7 +562,7 @@ static void mtd_check_of_node(struct mtd_info *mtd)
  	if (!mtd_is_partition(mtd))
  		return;
  	parent = mtd->parent;
-	parent_dn = dev_of_node(&parent->dev);
+	parent_dn = of_node_get(dev_of_node(&parent->dev));
  	if (!parent_dn)
  		return;


