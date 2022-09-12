Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2E35B5B1A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 15:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiILNYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 09:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiILNYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 09:24:42 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6E19FF6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 06:24:38 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h8so8365742wrf.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 06:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=WL+Nh7rAjziI/xJkOQ3O1wRpGGpusbr7pXf0s3DVH1I=;
        b=ZmmCIxs0zh8Odf+noeVOGoaJVujATZ67Ck8St2JGlbxsgY5BIo4nohGaNxaskcMcVa
         QOyodsO0E9vv2Rc0ymS6Sq3m7jq1hIu0i0KmRpPwGTtEBhfPYiSfZY4RxIva598Usr/r
         aLCvZHsMBSRXC//fmxal3f4oDQm4mWhuJJvvHBce+ZErUSVnzNKZdv2smM5ssm2dMRZl
         hvbMXknWoWNo2ecd8nJY/W+Zp28C/sDlF8j2LfDSGR8G1kUBdtP9Cp/k//oxLfmF0hRR
         wgGOYkBdVIJjSfq+v+aBm7ThDqsQO3spMVb1A4pai6t5H9BvACraYcvrMbWg4Y5JDyBT
         9Hkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WL+Nh7rAjziI/xJkOQ3O1wRpGGpusbr7pXf0s3DVH1I=;
        b=lTQpTIxmGsbbpB6ezD3Ri1XeS0WdD2In1EVAvTgPgbEl8AeA6eyYGhyPGkmDaM4A1d
         eq7SYmQWehS869Xba1e8fbtyMdxIYh64We4CF7cT9CLyh5FzWvrMGnJf0657aZVgCGWI
         epp9/cjM+Q25iJunF5ixq4tpXmJGlQ+7OzEzSdkgIXoWCgLLa/evpO8HnIQKAeG8ZEJG
         tWZWjBRnL/zK/6RD2EVhKtiZEnRSJ+ZgRkrfuRQZX9ev/f9w0d0pThVRfu4obrwnfM4L
         y1dv2n2XiqfqaBQOe9AAW9sm4dJASO16hBbjnzVyHpYrrTzmCRNKWdbfEf66Hkl/iyMF
         xpxg==
X-Gm-Message-State: ACgBeo2SQyTRlnvxNadmk6x7IcWh1T5fO9k0fqE61tQ4juSPWLqbtOBV
        himOiYoJma913h/s9ZtcETsz8Q==
X-Google-Smtp-Source: AA6agR7qAvs5gtahKA0n1tr95xz6ON8UgECQH9MzzSYGpMOH9NeRI8e4kCQNqONNHA1CbD4FAzgvhQ==
X-Received: by 2002:a5d:4d0c:0:b0:228:cd9f:5a4c with SMTP id z12-20020a5d4d0c000000b00228cd9f5a4cmr15730431wrt.138.1662989076283;
        Mon, 12 Sep 2022 06:24:36 -0700 (PDT)
Received: from ?IPV6:2a01:cb05:8f8a:1800:1c97:b8d1:b477:d53f? (2a01cb058f8a18001c97b8d1b477d53f.ipv6.abo.wanadoo.fr. [2a01:cb05:8f8a:1800:1c97:b8d1:b477:d53f])
        by smtp.gmail.com with ESMTPSA id n22-20020a05600c3b9600b003b435c41103sm12235344wms.0.2022.09.12.06.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 06:24:35 -0700 (PDT)
Message-ID: <992019ad-5c58-d420-8a18-a82228f8e086@smile.fr>
Date:   Mon, 12 Sep 2022 15:24:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v5 2/6] remoteproc: pru: Add APIs to get and put the PRU
 cores
Content-Language: fr
To:     Md Danish Anwar <a0501179@ti.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Md Danish Anwar <danishanwar@ti.com>,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        nm@ti.com, ssantosh@kernel.org, s-anna@ti.com,
        linux-arm-kernel@lists.infradead.org, rogerq@kernel.org,
        grygorii.strashko@ti.com, vigneshr@ti.com, robh@kernel.org
References: <20220607045650.4999-1-p-mohan@ti.com>
 <20220607045650.4999-3-p-mohan@ti.com> <20220712175949.GB2945984@p14s>
 <20220714172015.GA3106020@p14s> <20c544ef-40b3-dcbc-1f29-aac140725b57@ti.com>
 <7e7ed572-93fe-a9c8-f11e-d555e5113fd1@ti.com> <20220906192827.GA65147@p14s>
 <694da03a-e34d-1939-8b01-a75bc25495e0@ti.com>
From:   Romain Naour <romain.naour@smile.fr>
In-Reply-To: <694da03a-e34d-1939-8b01-a75bc25495e0@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danish, All,

Le 07/09/2022 à 11:24, Md Danish Anwar a écrit :
> Hi Mathieu,
> 
> On 07/09/22 00:58, Mathieu Poirier wrote:
>> On Fri, Sep 02, 2022 at 03:09:04PM +0530, Md Danish Anwar wrote:
>>> Hi Mathieu,
>>>
>>>
>>> On 15/07/22 11:52, Kishon Vijay Abraham I wrote:
>>>> +Danish
>>>>
>>>> Hi Mathieu,
>>>>
>>>> On 14/07/22 22:50, Mathieu Poirier wrote:
>>>>> On Tue, Jul 12, 2022 at 11:59:49AM -0600, Mathieu Poirier wrote:
>>>>>> Hi Puranjay,
>>>>
>>>> Removed Puranjay (as he is no longer with TI) and adding Danish.
>>>>
>>>> Regards,
>>>> Kishon
>>>>>>
>>>>>> On Tue, Jun 07, 2022 at 10:26:46AM +0530, Puranjay Mohan wrote:
>>>>>>> From: Tero Kristo <t-kristo@ti.com>
>>>>>>>
>>>>>>> Add two new APIs, pru_rproc_get() and pru_rproc_put(), to the PRU
>>>>>>> driver to allow client drivers to acquire and release the remoteproc
>>>>>>> device associated with a PRU core. The PRU cores are treated as
>>>>>>> resources with only one client owning it at a time.
>>>>>>>
>>>>>>> The pru_rproc_get() function returns the rproc handle corresponding
>>>>>>> to a PRU core identified by the device tree "ti,prus" property under
>>>>>>> the client node. The pru_rproc_put() is the complementary function
>>>>>>> to pru_rproc_get().
>>>>>>>
>>>>>>> Co-developed-by: Suman Anna <s-anna@ti.com>
>>>>>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>>>>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>>>>>> Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
>>>>>>> Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
>>>>>>> Co-developed-by: Puranjay Mohan <p-mohan@ti.com>
>>>>>>> Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
>>>>>>> ---
>>>>>>>   drivers/remoteproc/pru_rproc.c | 138 +++++++++++++++++++++++++++++++--
>>>>>>>   include/linux/pruss.h          |  56 +++++++++++++
>>>>>>>   2 files changed, 189 insertions(+), 5 deletions(-)
>>>>>>>   create mode 100644 include/linux/pruss.h
>>>>>>>
>>>>>>> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
>>>>>>> index 1777a01fa84e..7a35b400287a 100644
>>>>>>> --- a/drivers/remoteproc/pru_rproc.c
>>>>>>> +++ b/drivers/remoteproc/pru_rproc.c
>>>>>>> @@ -2,12 +2,13 @@
>>>>>>>   /*
>>>>>>>    * PRU-ICSS remoteproc driver for various TI SoCs
>>>>>>>    *
>>>>>>> - * Copyright (C) 2014-2020 Texas Instruments Incorporated - https://www.ti.com/
>>>>>>> + * Copyright (C) 2014-2022 Texas Instruments Incorporated - https://www.ti.com/
>>>>>>>    *
>>>>>>>    * Author(s):
>>>>>>>    *	Suman Anna <s-anna@ti.com>
>>>>>>>    *	Andrew F. Davis <afd@ti.com>
>>>>>>>    *	Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org> for Texas Instruments
>>>>>>> + *	Puranjay Mohan <p-mohan@ti.com>
>>>>>>>    */
>>>>>>>   #include <linux/bitops.h>
>>>>>>> @@ -16,6 +17,7 @@
>>>>>>>   #include <linux/module.h>
>>>>>>>   #include <linux/of_device.h>
>>>>>>>   #include <linux/of_irq.h>
>>>>>>> +#include <linux/pruss.h>
>>>>>>>   #include <linux/pruss_driver.h>
>>>>>>>   #include <linux/remoteproc.h>
>>>>>>> @@ -111,6 +113,8 @@ struct pru_private_data {
>>>>>>>    * @rproc: remoteproc pointer for this PRU core
>>>>>>>    * @data: PRU core specific data
>>>>>>>    * @mem_regions: data for each of the PRU memory regions
>>>>>>> + * @client_np: client device node
>>>>>>> + * @lock: mutex to protect client usage
>>>>>>>    * @fw_name: name of firmware image used during loading
>>>>>>>    * @mapped_irq: virtual interrupt numbers of created fw specific mapping
>>>>>>>    * @pru_interrupt_map: pointer to interrupt mapping description (firmware)
>>>>>>> @@ -126,6 +130,8 @@ struct pru_rproc {
>>>>>>>   	struct rproc *rproc;
>>>>>>>   	const struct pru_private_data *data;
>>>>>>>   	struct pruss_mem_region mem_regions[PRU_IOMEM_MAX];
>>>>>>> +	struct device_node *client_np;
>>>>>>> +	struct mutex lock; /* client access lock */
>>>>>>>   	const char *fw_name;
>>>>>>>   	unsigned int *mapped_irq;
>>>>>>>   	struct pru_irq_rsc *pru_interrupt_map;
>>>>>>> @@ -146,6 +152,125 @@ void pru_control_write_reg(struct pru_rproc *pru, unsigned int reg, u32 val)
>>>>>>>   	writel_relaxed(val, pru->mem_regions[PRU_IOMEM_CTRL].va + reg);
>>>>>>>   }
>>>>>>> +static struct rproc *__pru_rproc_get(struct device_node *np, int index)
>>>>>>> +{
>>>>>>> +	struct device_node *rproc_np = NULL;
>>>>>>> +	struct platform_device *pdev;
>>>>>>> +	struct rproc *rproc;
>>>>>>> +
>>>>>>> +	rproc_np = of_parse_phandle(np, "ti,prus", index);
>>>>>>> +	if (!rproc_np || !of_device_is_available(rproc_np))
>>>>>>> +		return ERR_PTR(-ENODEV);
>>>>>>> +
>>>>>>> +	pdev = of_find_device_by_node(rproc_np);
>>>>>>> +	of_node_put(rproc_np);
>>>>>>> +
>>>>>>> +	if (!pdev || !(&pdev->dev) || !((&pdev->dev)->driver))
>>>>>>> +		/* probably PRU not yet probed */
>>>>>>> +		return ERR_PTR(-EPROBE_DEFER);
>>>>>>> +
>>>>>>> +	/* make sure it is PRU rproc */
>>>>>>> +	if (!is_pru_rproc(&pdev->dev)) {
>>>>>>> +		put_device(&pdev->dev);
>>>>>>> +		return ERR_PTR(-ENODEV);
>>>>>>> +	}
>>>>>>> +
>>>>>>> +	rproc = platform_get_drvdata(pdev);
>>>>>>> +	put_device(&pdev->dev);
>>>>>>> +	if (!rproc)
>>>>>>> +		return ERR_PTR(-EPROBE_DEFER);
>>>>>>> +
>>>>>>> +	get_device(&rproc->dev);
>>>>>>> +
>>>>>>> +	return rproc;
>>>>>>> +}
>>>>>>> +
>>>>>>> +/**
>>>>>>> + * pru_rproc_get() - get the PRU rproc instance from a device node
>>>>>>> + * @np: the user/client device node
>>>>>>> + * @index: index to use for the ti,prus property
>>>>>>> + * @pru_id: optional pointer to return the PRU remoteproc processor id
>>>>>>> + *
>>>>>>> + * This function looks through a client device node's "ti,prus" property at
>>>>>>> + * index @index and returns the rproc handle for a valid PRU remote processor if
>>>>>>> + * found. The function allows only one user to own the PRU rproc resource at a
>>>>>>> + * time. Caller must call pru_rproc_put() when done with using the rproc, not
>>>>>>> + * required if the function returns a failure.
>>>>>>> + *
>>>>>>> + * When optional @pru_id pointer is passed the PRU remoteproc processor id is
>>>>>>> + * returned.
>>>>>>> + *
>>>>>>> + * Return: rproc handle on success, and an ERR_PTR on failure using one
>>>>>>> + * of the following error values
>>>>>>> + *    -ENODEV if device is not found
>>>>>>> + *    -EBUSY if PRU is already acquired by anyone
>>>>>>> + *    -EPROBE_DEFER is PRU device is not probed yet
>>>>>>> + */
>>>>>>> +struct rproc *pru_rproc_get(struct device_node *np, int index,
>>>>>>> +			    enum pruss_pru_id *pru_id)
>>>>>>> +{
>>>>>>> +	struct rproc *rproc;
>>>>>>> +	struct pru_rproc *pru;
>>>>>>> +	struct device *dev;
>>>>>>> +
>>>>>>> +	try_module_get(THIS_MODULE);
>>>>>>
>>>>>> There should be a module_put() in pru_rproc_put()...
>>>>>
>>>>> ... and in the error path of this function.
>>>>>
>>>>>>
>>>>>> More comments to come tomorrow.  I'm especially worried about this API racing
>>>>>> with a remote processor being removed or detached.
>>>>>>
>>>>>
>>>>> Looking at what is done in wkup_m3_ipc_probe(), it should be possible to call
>>>>> rproc_get_by_handle() here and that would make sure the remote processor doesn't
>>>>> go away before the end of the function.
>>>>>
>>>>> More comments to come...
>>>
>>> It is possible to call rproc_get_by_handle() here instead of
>>> __pru_get_proc(), but that would not provide multiple functionality.
>>>
>>> The API rproc_get_by_handle() returns rproc handle on success, and NULL on
>>> failure where as __pru_get_proc() returns ERR_PTR on failure which provides
>>> multiple functionality and opportunity for us to distinguish between
>>> multiple errors.
>>>
>>> So we have these three options.
>>>
>>> 1. If we're using the API rproc_get_by_handle() and we want the multiple
>>> ERR_PTR on failure then we will need to change the API rproc_get_by_handle()
>>> and also all the functions that uses rproc_get_by_handle().
>>>
>>
>> Not optimal.
>>
>>> 2. Keep the API rproc_get_by_handle() as it is. That will restrict us from
>>> using multiple ERR_PTR on different kinds of error.
>>>
>>
>> Not optimal.
>>
>>> 3. Instead of using rproc_get_by_handle(), keep using __pru_get_proc(). This
>>> will make sure we have the proper ERR_PTR to retrun for different kinds of
>>> errors.
>>>
>>
>> Unacceptable for the reason I already stated.  
>>
>>> Please let me know which option to continue with.
>>
>> I suggest building a wrapper that does everything you want around rproc_get_by_phandle().
>>
> 
> Sure, I'll do that. I'll share this change in v6 of this patch series.

I'm able to test the TI prueth driver from the ti-linux-5.10.y tree [1] on a
AM5749 cpu (custom board). But I need a more recent kernel (at least 5.15) to
support other devices recently added to the Linux kernel (wifi6 module and an
ethernet switch). Also it would be nice if this driver is finally merged in the
Linux kernel.

Maybe I can help to test this series but I noticed it only provide the driver
for TI AM654x cpus [2]. Can you also provide patches for basic EMAC support with
the TI AM574x too? (I don't need advanced features like frame timestamping, HSR
etc).

Also, what about patches present in the ti-linux-kernel tree and not included
this this series? Especially patches that modify the kernel network stack [3]
(net/rpmsg: add support for new rpmsg sockets). Is this new socket protocol
really needed?

Notice the patch adding the rpmsg sockets [3] already conflict with the upstream
kernel since the AF_MCTP definition now use the value temporarly used by
AF_RPMSG [4].

Can you send an updated version of the complete series?

Thanks!

[1] https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/log/?h=ti-linux-5.10.y

[2] https://lore.kernel.org/linux-remoteproc/20220406094358.7895-1-p-mohan@ti.com/

[3]
https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/?h=ti-linux-5.10.y&id=f4b978a978c38149f712ddd137f12ed5fb914161

[4]
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=bc49d8169aa72295104f1558830c568efb946315

Best regards,
Romain


> 
>>>
>>> Thanks,
>>> Danish
>>>
>>>
>>>>>
>>>>>
>>>>>> Thanks,
>>>>>> Mathieu
>>>>>>
>>>>>>> +
>>>>>>> +	rproc = __pru_rproc_get(np, index);
>>>>>>> +	if (IS_ERR(rproc))
>>>>>>> +		return rproc;
>>>>>>> +
>>>>>>> +	pru = rproc->priv;
>>>>>>> +	dev = &rproc->dev;
>>>>>>> +
>>>>>>> +	mutex_lock(&pru->lock);
>>>>>>> +
>>>>>>> +	if (pru->client_np) {
>>>>>>> +		mutex_unlock(&pru->lock);
>>>>>>> +		put_device(dev);
>>>>>>> +		return ERR_PTR(-EBUSY);
>>>>>>> +	}
>>>>>>> +
>>>>>>> +	pru->client_np = np;
>>>>>>> +
>>>>>>> +	mutex_unlock(&pru->lock);
>>>>>>> +
>>>>>>> +	if (pru_id)
>>>>>>> +		*pru_id = pru->id;
>>>>>>> +
>>>>>>> +	return rproc;
>>>>>>> +}
>>>>>>> +EXPORT_SYMBOL_GPL(pru_rproc_get);
>>>>>>> +
>>>>>>> +/**
>>>>>>> + * pru_rproc_put() - release the PRU rproc resource
>>>>>>> + * @rproc: the rproc resource to release
>>>>>>> + *
>>>>>>> + * Releases the PRU rproc resource and makes it available to other
>>>>>>> + * users.
>>>>>>> + */
>>>>>>> +void pru_rproc_put(struct rproc *rproc)
>>>>>>> +{
>>>>>>> +	struct pru_rproc *pru;
>>>>>>> +
>>>>>>> +	if (IS_ERR_OR_NULL(rproc) || !is_pru_rproc(rproc->dev.parent))
>>>>>>> +		return;
>>>>>>> +
>>>>>>> +	pru = rproc->priv;
>>>>>>> +
>>>>>>> +	mutex_lock(&pru->lock);
>>>>>>> +
>>>>>>> +	if (!pru->client_np) {
>>>>>>> +		mutex_unlock(&pru->lock);
>>>>>>> +		return;
>>>>>>> +	}
>>>>>>> +
>>>>>>> +	pru->client_np = NULL;
>>>>>>> +	mutex_unlock(&pru->lock);
>>>>>>> +
>>>>>>> +	put_device(&rproc->dev);
>>>>>>> +}
>>>>>>> +EXPORT_SYMBOL_GPL(pru_rproc_put);
>>>>>>> +
>>>>>>>   static inline u32 pru_debug_read_reg(struct pru_rproc *pru, unsigned int reg)
>>>>>>>   {
>>>>>>>   	return readl_relaxed(pru->mem_regions[PRU_IOMEM_DEBUG].va + reg);
>>>>>>> @@ -438,7 +563,7 @@ static void *pru_d_da_to_va(struct pru_rproc *pru, u32 da, size_t len)
>>>>>>>   	dram0 = pruss->mem_regions[PRUSS_MEM_DRAM0];
>>>>>>>   	dram1 = pruss->mem_regions[PRUSS_MEM_DRAM1];
>>>>>>>   	/* PRU1 has its local RAM addresses reversed */
>>>>>>> -	if (pru->id == 1)
>>>>>>> +	if (pru->id == PRUSS_PRU1)
>>>>>>>   		swap(dram0, dram1);
>>>>>>>   	shrd_ram = pruss->mem_regions[PRUSS_MEM_SHRD_RAM2];
>>>>>>> @@ -747,14 +872,14 @@ static int pru_rproc_set_id(struct pru_rproc *pru)
>>>>>>>   	case RTU0_IRAM_ADDR_MASK:
>>>>>>>   		fallthrough;
>>>>>>>   	case PRU0_IRAM_ADDR_MASK:
>>>>>>> -		pru->id = 0;
>>>>>>> +		pru->id = PRUSS_PRU0;
>>>>>>>   		break;
>>>>>>>   	case TX_PRU1_IRAM_ADDR_MASK:
>>>>>>>   		fallthrough;
>>>>>>>   	case RTU1_IRAM_ADDR_MASK:
>>>>>>>   		fallthrough;
>>>>>>>   	case PRU1_IRAM_ADDR_MASK:
>>>>>>> -		pru->id = 1;
>>>>>>> +		pru->id = PRUSS_PRU1;
>>>>>>>   		break;
>>>>>>>   	default:
>>>>>>>   		ret = -EINVAL;
>>>>>>> @@ -816,6 +941,8 @@ static int pru_rproc_probe(struct platform_device *pdev)
>>>>>>>   	pru->pruss = platform_get_drvdata(ppdev);
>>>>>>>   	pru->rproc = rproc;
>>>>>>>   	pru->fw_name = fw_name;
>>>>>>> +	pru->client_np = NULL;
>>>>>>> +	mutex_init(&pru->lock);
>>>>>>>   	for (i = 0; i < ARRAY_SIZE(mem_names); i++) {
>>>>>>>   		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>>>>>>> @@ -903,7 +1030,7 @@ MODULE_DEVICE_TABLE(of, pru_rproc_match);
>>>>>>>   static struct platform_driver pru_rproc_driver = {
>>>>>>>   	.driver = {
>>>>>>> -		.name   = "pru-rproc",
>>>>>>> +		.name   = PRU_RPROC_DRVNAME,
>>>>>>>   		.of_match_table = pru_rproc_match,
>>>>>>>   		.suppress_bind_attrs = true,
>>>>>>>   	},
>>>>>>> @@ -915,5 +1042,6 @@ module_platform_driver(pru_rproc_driver);
>>>>>>>   MODULE_AUTHOR("Suman Anna <s-anna@ti.com>");
>>>>>>>   MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
>>>>>>>   MODULE_AUTHOR("Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>");
>>>>>>> +MODULE_AUTHOR("Puranjay Mohan <p-mohan@ti.com>");
>>>>>>>   MODULE_DESCRIPTION("PRU-ICSS Remote Processor Driver");
>>>>>>>   MODULE_LICENSE("GPL v2");
>>>>>>> diff --git a/include/linux/pruss.h b/include/linux/pruss.h
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..fdc719b43db0
>>>>>>> --- /dev/null
>>>>>>> +++ b/include/linux/pruss.h
>>>>>>> @@ -0,0 +1,56 @@
>>>>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>>>>>> +/**
>>>>>>> + * PRU-ICSS Subsystem user interfaces
>>>>>>> + *
>>>>>>> + * Copyright (C) 2015-2022 Texas Instruments Incorporated - http://www.ti.com
>>>>>>> + *	Suman Anna <s-anna@ti.com>
>>>>>>> + */
>>>>>>> +
>>>>>>> +#ifndef __LINUX_PRUSS_H
>>>>>>> +#define __LINUX_PRUSS_H
>>>>>>> +
>>>>>>> +#include <linux/device.h>
>>>>>>> +#include <linux/types.h>
>>>>>>> +
>>>>>>> +#define PRU_RPROC_DRVNAME "pru-rproc"
>>>>>>> +
>>>>>>> +/*
>>>>>>> + * enum pruss_pru_id - PRU core identifiers
>>>>>>> + */
>>>>>>> +enum pruss_pru_id {
>>>>>>> +	PRUSS_PRU0 = 0,
>>>>>>> +	PRUSS_PRU1,
>>>>>>> +	PRUSS_NUM_PRUS,
>>>>>>> +};
>>>>>>> +
>>>>>>> +struct device_node;
>>>>>>> +
>>>>>>> +#if IS_ENABLED(CONFIG_PRU_REMOTEPROC)
>>>>>>> +
>>>>>>> +struct rproc *pru_rproc_get(struct device_node *np, int index,
>>>>>>> +			    enum pruss_pru_id *pru_id);
>>>>>>> +void pru_rproc_put(struct rproc *rproc);
>>>>>>> +
>>>>>>> +#else
>>>>>>> +
>>>>>>> +static inline struct rproc *
>>>>>>> +pru_rproc_get(struct device_node *np, int index, enum pruss_pru_id *pru_id)
>>>>>>> +{
>>>>>>> +	return ERR_PTR(-EOPNOTSUPP);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static inline void pru_rproc_put(struct rproc *rproc) { }
>>>>>>> +
>>>>>>> +#endif /* CONFIG_PRU_REMOTEPROC */
>>>>>>> +
>>>>>>> +static inline bool is_pru_rproc(struct device *dev)
>>>>>>> +{
>>>>>>> +	const char *drv_name = dev_driver_string(dev);
>>>>>>> +
>>>>>>> +	if (strncmp(drv_name, PRU_RPROC_DRVNAME, sizeof(PRU_RPROC_DRVNAME)))
>>>>>>> +		return false;
>>>>>>> +
>>>>>>> +	return true;
>>>>>>> +}
>>>>>>> +
>>>>>>> +#endif /* __LINUX_PRUSS_H */
>>>>>>> -- 
>>>>>>> 2.17.1
>>>>>>>
> 

