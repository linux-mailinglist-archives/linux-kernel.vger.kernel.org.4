Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DFA6F6ECD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 17:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjEDPWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 11:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjEDPWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 11:22:01 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88688448B
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 08:21:57 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so18293952a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 08:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683213716; x=1685805716;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PiGLn/wT6jdTg1r2CmvkzZAzbbvZRfblAofN9TNz5js=;
        b=rmgboVQMXKVEmatJvwtVuNHvP3P5iF0N+kpJRgXsH1BmScQOnIuCKROJbbCYE+PZ4k
         Et8mmmAv/mF+bZhgQHJ+XR624bUizkdqUuVUuv1jBHiYhFeJT5RcfE8DjfvAEp9wnJAA
         wbv+9lUHD3qvbVnXlE/nOwl7gD95voQ8YGkx94yr7tcz1v+rGGoiSu0LP4N3pby55mZ8
         LNElVxgA5RCmA2hRT6QwW329//xpAnnVflPZ/a6iFuijnxabI8/ZIaxsvZjmDGx1jWG8
         Yj+QjwSjdWG+O1RF68bpnzepUOS+dpVn/Gyycl5vs4fLxBmjiiwk+M1Nd4fDxyBphS8D
         ymWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683213716; x=1685805716;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PiGLn/wT6jdTg1r2CmvkzZAzbbvZRfblAofN9TNz5js=;
        b=G3yz3qkKH83u+EUUArvnaf0MmYC5lYSaJUP1n+2vBTx3SQyGfJcqHJTV3SkHdzvwB9
         5f4fJQ94fTxVo40l9Or7P3a+LhidrM7vFKmActjKBqEhDpnxoJUaMTIxX2gp2WzKla+P
         fX7pSDql8+qSD6H6TyPIQU/RXpCoCsNjFBa8Y48xj0QDFGu/1SuInoWYxPQcKXSDEmBe
         mvuoX4KRHl0lMTH3EBMNwTfnkYkM4zNCrG9C2HgOG/u/wKkGcl1QgmlzvlLAkHh5eeT8
         Pt0iNNUWtH23oG3DTuEbdziZEU6oXzb/7ciqesKy/BShNAvOiSrnMrZ35tuXtQTLxUdh
         dj/A==
X-Gm-Message-State: AC+VfDyDAP0IVoMV9PEz52daXbi506SNzFrnErGycDLTEOQTuWSBpnM5
        8yk8+crLqOSqeyYuzpOKmqKxNw==
X-Google-Smtp-Source: ACHHUZ6YZYRgQMRxf5orwNObNcMlwSymaMEoEOjw1Z1jIy3dxNIXynsfLCVhIMiU2+SX4xd8hXNFcA==
X-Received: by 2002:a17:907:36c6:b0:94f:432f:243d with SMTP id bj6-20020a17090736c600b0094f432f243dmr5660822ejc.17.1683213715932;
        Thu, 04 May 2023 08:21:55 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id gq18-20020a170906e25200b0094eeda0df09sm18962558ejb.179.2023.05.04.08.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 08:21:55 -0700 (PDT)
Message-ID: <575a422d-6224-06b7-628c-8487b47882e9@linaro.org>
Date:   Thu, 4 May 2023 17:21:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 04/18] soc: qcom: Add Qualcomm minidump kernel driver
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
 <1683133352-10046-5-git-send-email-quic_mojha@quicinc.com>
 <c6f730b6-f702-91d4-4abd-71546e02f869@linaro.org>
 <23b493f4-1a01-8d03-fc12-d588b2c6fd74@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <23b493f4-1a01-8d03-fc12-d588b2c6fd74@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 14:38, Mukesh Ojha wrote:
> 
> 
> On 5/4/2023 5:06 PM, Krzysztof Kozlowski wrote:
>> On 03/05/2023 19:02, Mukesh Ojha wrote:
>>> Minidump is a best effort mechanism to collect useful and predefined
>>> data for first level of debugging on end user devices running on
>>> Qualcomm SoCs. It is built on the premise that System on Chip (SoC)
>>> or subsystem part of SoC crashes, due to a range of hardware and
>>> software bugs. Hence, the ability to collect accurate data is only
>>> a best-effort. The data collected could be invalid or corrupted,
>>> data collection itself could fail, and so on.
>>>
>>> Qualcomm devices in engineering mode provides a mechanism for
>>> generating full system ramdumps for post mortem debugging. But in some
>>> cases it's however not feasible to capture the entire content of RAM.
>>> The minidump mechanism provides the means for selecting region should
>>> be included in the ramdump. The solution supports extracting the
>>> ramdump/minidump produced either over USB or stored to an attached
>>> storage device.
>>>
>>> The core of minidump feature is part of Qualcomm's boot firmware code.
>>> It initializes shared memory(SMEM), which is a part of DDR and
>>> allocates a small section of it to minidump table i.e also called
>>> global table of content (G-ToC). Each subsystem (APSS, ADSP, ...) has
>>> their own table of segments to be included in the minidump, all
>>> references from a descriptor in SMEM (G-ToC). Each segment/region has
>>> some details like name, physical address and it's size etc. and it
>>> could be anywhere scattered in the DDR.
>>>
>>> Minidump kernel driver adds the capability to add linux region to be
>>> dumped as part of ram dump collection. It provides appropriate symbol
>>> to check its enablement and register client regions.
>>>
>>> To simplify post mortem debugging, it creates and maintain an ELF
>>> header as first region that gets updated upon registration
>>> of a new region.
>>>
>>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>> ---
>>>   drivers/soc/qcom/Kconfig         |  14 +
>>>   drivers/soc/qcom/Makefile        |   1 +
>>>   drivers/soc/qcom/qcom_minidump.c | 581 +++++++++++++++++++++++++++++++++++++++
>>>   drivers/soc/qcom/smem.c          |   8 +
>>>   include/soc/qcom/qcom_minidump.h |  61 +++-
>>>   5 files changed, 663 insertions(+), 2 deletions(-)
>>>   create mode 100644 drivers/soc/qcom/qcom_minidump.c
>>>
>>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>>> index a491718..15c931e 100644
>>> --- a/drivers/soc/qcom/Kconfig
>>> +++ b/drivers/soc/qcom/Kconfig
>>> @@ -279,4 +279,18 @@ config QCOM_INLINE_CRYPTO_ENGINE
>>>   	tristate
>>>   	select QCOM_SCM
>>>   
>>> +config QCOM_MINIDUMP
>>> +	tristate "QCOM Minidump Support"
>>> +	depends on ARCH_QCOM || COMPILE_TEST
>>> +	select QCOM_SMEM
>>> +	help
>>> +	  Enablement of core minidump feature is controlled from boot firmware
>>> +	  side, and this config allow linux to query and manages APPS minidump
>>> +	  table.
>>> +
>>> +	  Client drivers can register their internal data structures and debug
>>> +	  messages as part of the minidump region and when the SoC is crashed,
>>> +	  these selective regions will be dumped instead of the entire DDR.
>>> +	  This saves significant amount of time and/or storage space.
>>> +
>>>   endmenu
>>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>>> index 0f43a88..1ebe081 100644
>>> --- a/drivers/soc/qcom/Makefile
>>> +++ b/drivers/soc/qcom/Makefile
>>> @@ -33,3 +33,4 @@ obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
>>>   obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
>>>   obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
>>>   obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= ice.o
>>> +obj-$(CONFIG_QCOM_MINIDUMP) += qcom_minidump.o
>>> diff --git a/drivers/soc/qcom/qcom_minidump.c b/drivers/soc/qcom/qcom_minidump.c
>>> new file mode 100644
>>> index 0000000..d107a86
>>> --- /dev/null
>>> +++ b/drivers/soc/qcom/qcom_minidump.c
>>> @@ -0,0 +1,581 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +
>>> +/*
>>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>>> + */
>>> +
>>> +#include <linux/elf.h>
>>> +#include <linux/err.h>
>>> +#include <linux/errno.h>
>>> +#include <linux/export.h>
>>> +#include <linux/init.h>
>>> +#include <linux/io.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/string.h>
>>> +#include <linux/soc/qcom/smem.h>
>>> +#include <soc/qcom/qcom_minidump.h>
>>> +
>>> +/**
>>> + * struct minidump_elfhdr - Minidump table elf header
>>> + * @ehdr: Elf main header
>>> + * @shdr: Section header
>>> + * @phdr: Program header
>>> + * @elf_offset: Section offset in elf
>>> + * @strtable_idx: String table current index position
>>> + */
>>> +struct minidump_elfhdr {
>>> +	struct elfhdr		*ehdr;
>>> +	struct elf_shdr		*shdr;
>>> +	struct elf_phdr		*phdr;
>>> +	size_t			elf_offset;
>>> +	size_t			strtable_idx;
>>> +};
>>> +
>>> +/**
>>> + * struct minidump - Minidump driver private data
>>> + * @md_gbl_toc	: Global TOC pointer
>>> + * @md_apss_toc	: Application Subsystem TOC pointer
>>> + * @md_regions	: High level OS region base pointer
>>> + * @elf		: Minidump elf header
>>> + * @dev		: Minidump device
>>> + */
>>> +struct minidump {
>>> +	struct minidump_global_toc	*md_gbl_toc;
>>> +	struct minidump_subsystem	*md_apss_toc;
>>> +	struct minidump_region		*md_regions;
>>> +	struct minidump_elfhdr		elf;
>>> +	struct device			*dev;
>>> +};
>>> +
>>> +/*
>>> + * In some of the Old Qualcomm devices, boot firmware statically allocates 300
>>> + * as total number of supported region (including all co-processors) in
>>> + * minidump table out of which linux was using 201. In future, this limitation
>>> + * from boot firmware might get removed by allocating the region dynamically.
>>> + * So, keep it compatible with older devices, we can keep the current limit for
>>> + * Linux to 201.
>>> + */
>>> +#define MAX_NUM_ENTRIES	  201
>>> +#define MAX_STRTBL_SIZE	  (MAX_NUM_ENTRIES * MAX_REGION_NAME_LENGTH)
>>> +
>>> +static struct minidump *__md;
>>
>> No, no file scope or global scope statics.
> 
> Sorry, this is done as per recommendation given here [1] and this 
> matches both driver/firmware/qcom_scm.c and driver/soc/qcom/smem.c
> implementations.
> 
> [1]
> https://lore.kernel.org/lkml/f74dfcde-e59b-a9b3-9bbc-a8de644f6740@linaro.org/

That's not true. You had the static already in v2, before Srini commented.

Look:
https://lore.kernel.org/lkml/1679491817-2498-5-git-send-email-quic_mojha@quicinc.com/

+static struct minidump minidump;
+static DEFINE_MUTEX(minidump_lock);

We do not talk about the names.


>>> +
>>> +	if (size < sizeof(*mdgtoc) || !mdgtoc->status) {
>>> +		ret = -EINVAL;
>>> +		dev_err(&pdev->dev, "minidump table is not initialized: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	mutex_lock(&minidump_lock);
>>> +	md->dev = &pdev->dev;
>>> +	md->md_gbl_toc = mdgtoc;
>>
>> What are you protecting here? It's not possible to have concurrent
>> access to md, is it?
> 
> Check qcom_apss_minidump_region_{register/unregister} and it is possible
> that these API gets called parallel to this probe.

Wait, you say that something can modify local variable md before it is
assigned to __md? How?

> 
> I agree, i made a mistake in not protecting __md in {register} API
> but did it unregister API in this patch, which i have fixed in later patch.

No, you are protecting random things. Nothing will concurrently modify
md and &pdev->dev in this moment. mdgtoc is allocated above, so also
cannot by modified.

Otherwise show me the hypothetical scenario.


> 
>>
>>> +	ret = qcom_minidump_init_apss_subsystem(md);
>>> +	if (ret) {
>>> +		dev_err(&pdev->dev, "apss minidump initialization failed: %d\n", ret);
>>> +		goto unlock;
>>> +	}
>>> +
>>> +	__md = md;
>>
>> No. This is a platform device, so it can have multiple instances.
> 
> It can have only one instance that is created from SMEM driver probe.

Anyone can instantiate more of them.... how did you solve it?


> 
>>
>>> +	/* First entry would be ELF header */
>>> +	ret = qcom_apss_minidump_add_elf_header();
>>> +	if (ret) {
>>> +		dev_err(&pdev->dev, "Failed to add elf header: %d\n", ret);
>>> +		memset(md->md_apss_toc, 0, sizeof(struct minidump_subsystem));
>>> +		__md = NULL;
>>> +	}
>>> +
>>> +unlock:
>>> +	mutex_unlock(&minidump_lock);
>>> +	return ret;
>>> +}
>>> +
>>> +static int qcom_minidump_remove(struct platform_device *pdev)
>>> +{
>>> +	memset(__md->md_apss_toc, 0, sizeof(struct minidump_subsystem));
>>> +	__md = NULL;
>>
>> Don't use __ in variable names. Drop it everywhere.
> 
> As i said above, this is being followed in other drivers, so followed
> it here as per recommendation.
> 
> Let @srini comeback on this.

Which part of coding style recommends __ for driver code?

> 
>>
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static struct platform_driver qcom_minidump_driver = {
>>> +	.probe = qcom_minidump_probe,
>>> +	.remove = qcom_minidump_remove,
>>> +	.driver  = {
>>> +		.name = "qcom-minidump",
>>> +	},
>>> +};
>>> +
>>> +module_platform_driver(qcom_minidump_driver);
>>> +
>>> +MODULE_DESCRIPTION("Qualcomm APSS minidump driver");
>>> +MODULE_LICENSE("GPL v2");
>>> +MODULE_ALIAS("platform:qcom-minidump");
>>> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
>>> index 6be7ea9..d459656 100644
>>> --- a/drivers/soc/qcom/smem.c
>>> +++ b/drivers/soc/qcom/smem.c
>>> @@ -279,6 +279,7 @@ struct qcom_smem {
>>>   
>>>   	u32 item_count;
>>>   	struct platform_device *socinfo;
>>> +	struct platform_device *minidump;
>>>   	struct smem_ptable *ptable;
>>>   	struct smem_partition global_partition;
>>>   	struct smem_partition partitions[SMEM_HOST_COUNT];
>>> @@ -1151,12 +1152,19 @@ static int qcom_smem_probe(struct platform_device *pdev)
>>>   	if (IS_ERR(smem->socinfo))
>>>   		dev_dbg(&pdev->dev, "failed to register socinfo device\n");
>>>   
>>> +	smem->minidump = platform_device_register_data(&pdev->dev, "qcom-minidump",
>>> +						      PLATFORM_DEVID_NONE, NULL,
>>> +						      0);
>>> +	if (IS_ERR(smem->minidump))
>>> +		dev_dbg(&pdev->dev, "failed to register minidump device\n");
>>> +
>>>   	return 0;
>>>   }
>>>   
>>>   static int qcom_smem_remove(struct platform_device *pdev)
>>>   {
>>>   	platform_device_unregister(__smem->socinfo);
>>> +	platform_device_unregister(__smem->minidump);
>>
>> Wrong order. You registered first socinfo, right?
> 
> Any order is fine here, they are not dependent.
> But, will fix this.

No, the order is always reversed from allocation. It does not matter if
they are dependent or not.

Best regards,
Krzysztof

