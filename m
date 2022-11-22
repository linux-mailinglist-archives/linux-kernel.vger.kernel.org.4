Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BEF633954
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbiKVKHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiKVKHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:07:23 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6932CE39;
        Tue, 22 Nov 2022 02:07:20 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AMA6xZd116018;
        Tue, 22 Nov 2022 04:06:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1669111619;
        bh=5KECzsV3oZ7XuJuaiJWcm4GxO0TJVgS0h98ei4XpzEQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=tZJFepw7T6e4rAuzU/dx3Fh1Y04hOvQYiMUAgl6aKsdRAe2kelN6iWNM0n3W1+Ehy
         QHSqHJtvalxUOxGPXn/s+b/VqHRpkluRwlvV99w7YRZ/ZghuVh6ZumhP9BZgAVAPWK
         mKFUrbFXFOOIZDQDATcTwc1SQ2bz4CvKblU8d48c=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AMA6xM2007057
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Nov 2022 04:06:59 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 22
 Nov 2022 04:06:58 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 22 Nov 2022 04:06:58 -0600
Received: from [10.24.69.114] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AMA6sb3058680;
        Tue, 22 Nov 2022 04:06:54 -0600
Message-ID: <e2b99af6-9367-0476-c013-9dfb381c6744@ti.com>
Date:   Tue, 22 Nov 2022 15:36:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [EXTERNAL] Re: [PATCH v9 2/6] remoteproc: pru: Add APIs to get
 and put the PRU cores
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        MD Danish Anwar <danishanwar@ti.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Suman Anna <s-anna@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        "Andrew F . Davis" <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <srk@ti.com>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20221118111924.3277838-1-danishanwar@ti.com>
 <20221118111924.3277838-3-danishanwar@ti.com> <20221121174938.GC457869@p14s>
From:   Md Danish Anwar <a0501179@ti.com>
In-Reply-To: <20221121174938.GC457869@p14s>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 21/11/22 23:19, Mathieu Poirier wrote:
> On Fri, Nov 18, 2022 at 04:49:20PM +0530, MD Danish Anwar wrote:
>> From: Tero Kristo <t-kristo@ti.com>
>>
>> Add two new APIs, pru_rproc_get() and pru_rproc_put(), to the PRU
>> driver to allow client drivers to acquire and release the remoteproc
>> device associated with a PRU core. The PRU cores are treated as
>> resources with only one client owning it at a time.
>>
>> The pru_rproc_get() function returns the rproc handle corresponding
>> to a PRU core identified by the device tree "ti,prus" property under
>> the client node. The pru_rproc_put() is the complementary function
>> to pru_rproc_get().
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  drivers/remoteproc/pru_rproc.c | 134 ++++++++++++++++++++++++++++++++-
>>  include/linux/pruss.h          |  47 ++++++++++++
>>  2 files changed, 179 insertions(+), 2 deletions(-)
>>  create mode 100644 include/linux/pruss.h
>>
>> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
>> index 128bf9912f2c..4769ade9c316 100644
>> --- a/drivers/remoteproc/pru_rproc.c
>> +++ b/drivers/remoteproc/pru_rproc.c
>> @@ -2,12 +2,14 @@
>>  /*
>>   * PRU-ICSS remoteproc driver for various TI SoCs
>>   *
>> - * Copyright (C) 2014-2020 Texas Instruments Incorporated - https://www.ti.com/
>> + * Copyright (C) 2014-2022 Texas Instruments Incorporated - https://www.ti.com/
>>   *
>>   * Author(s):
>>   *	Suman Anna <s-anna@ti.com>
>>   *	Andrew F. Davis <afd@ti.com>
>>   *	Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org> for Texas Instruments
>> + *	Puranjay Mohan <p-mohan@ti.com>
>> + *	Md Danish Anwar <danishanwar@ti.com>
>>   */
>>  
>>  #include <linux/bitops.h>
>> @@ -16,6 +18,7 @@
>>  #include <linux/module.h>
>>  #include <linux/of_device.h>
>>  #include <linux/of_irq.h>
>> +#include <linux/pruss.h>
>>  #include <linux/pruss_driver.h>
>>  #include <linux/remoteproc.h>
>>  
>> @@ -111,6 +114,8 @@ struct pru_private_data {
>>   * @rproc: remoteproc pointer for this PRU core
>>   * @data: PRU core specific data
>>   * @mem_regions: data for each of the PRU memory regions
>> + * @client_np: client device node
>> + * @lock: mutex to protect client usage
>>   * @fw_name: name of firmware image used during loading
>>   * @mapped_irq: virtual interrupt numbers of created fw specific mapping
>>   * @pru_interrupt_map: pointer to interrupt mapping description (firmware)
>> @@ -126,6 +131,8 @@ struct pru_rproc {
>>  	struct rproc *rproc;
>>  	const struct pru_private_data *data;
>>  	struct pruss_mem_region mem_regions[PRU_IOMEM_MAX];
>> +	struct device_node *client_np;
>> +	struct mutex lock;
>>  	const char *fw_name;
>>  	unsigned int *mapped_irq;
>>  	struct pru_irq_rsc *pru_interrupt_map;
>> @@ -146,6 +153,125 @@ void pru_control_write_reg(struct pru_rproc *pru, unsigned int reg, u32 val)
>>  	writel_relaxed(val, pru->mem_regions[PRU_IOMEM_CTRL].va + reg);
>>  }
>>  
>> +static struct rproc *__pru_rproc_get(struct device_node *np, int index)
>> +{
>> +	struct rproc *rproc;
>> +	phandle rproc_phandle;
>> +	int ret;
>> +
>> +	ret = of_property_read_u32_index(np, "ti,prus", index, &rproc_phandle);
>> +	if (ret)
>> +		return ERR_PTR(ret);
>> +
>> +	rproc = rproc_get_by_phandle(rproc_phandle);
>> +	if (!rproc) {
>> +		ret = -EPROBE_DEFER;
>> +		goto err_no_rproc_handle;
>> +	}
>> +
>> +	/* make sure it is PRU rproc */
>> +	if (!is_pru_rproc(rproc->dev.parent)) {
>> +		rproc_put(rproc);
>> +		return ERR_PTR(-ENODEV);
>> +	}
>> +
>> +	return rproc;
>> +
>> +err_no_rproc_handle:
>> +	rproc_put(rproc);
>> +	return ERR_PTR(ret);
>> +}
>> +
>> +/**
>> + * pru_rproc_get() - get the PRU rproc instance from a device node
>> + * @np: the user/client device node
>> + * @index: index to use for the ti,prus property
>> + * @pru_id: optional pointer to return the PRU remoteproc processor id
>> + *
>> + * This function looks through a client device node's "ti,prus" property at
>> + * index @index and returns the rproc handle for a valid PRU remote processor if
>> + * found. The function allows only one user to own the PRU rproc resource at a
>> + * time. Caller must call pru_rproc_put() when done with using the rproc, not
>> + * required if the function returns a failure.
>> + *
>> + * When optional @pru_id pointer is passed the PRU remoteproc processor id is
>> + * returned.
>> + *
>> + * Return: rproc handle on success, and an ERR_PTR on failure using one
>> + * of the following error values
>> + *    -ENODEV if device is not found
>> + *    -EBUSY if PRU is already acquired by anyone
>> + *    -EPROBE_DEFER is PRU device is not probed yet
>> + */
>> +struct rproc *pru_rproc_get(struct device_node *np, int index,
>> +			    enum pruss_pru_id *pru_id)
>> +{
>> +	struct rproc *rproc;
>> +	struct pru_rproc *pru;
>> +	struct device *dev;
>> +	int ret;
>> +
>> +	rproc = __pru_rproc_get(np, index);
>> +	if (IS_ERR(rproc))
>> +		return rproc;
>> +
>> +	pru = rproc->priv;
>> +	dev = &rproc->dev;
>> +
>> +	mutex_lock(&pru->lock);
>> +
>> +	if (pru->client_np) {
>> +		mutex_unlock(&pru->lock);
>> +		put_device(dev);
>> +		ret = -EBUSY;
>> +		goto err_no_rproc_handle;
>> +	}
>> +
>> +	pru->client_np = np;
>> +
>> +	mutex_unlock(&pru->lock);
>> +
>> +	if (pru_id)
>> +		*pru_id = pru->id;
>> +
>> +	return rproc;
>> +
>> +err_no_rproc_handle:
>> +	rproc_put(rproc);
>> +	return ERR_PTR(ret);
>> +}
>> +EXPORT_SYMBOL_GPL(pru_rproc_get);
>> +
>> +/**
>> + * pru_rproc_put() - release the PRU rproc resource
>> + * @rproc: the rproc resource to release
>> + *
>> + * Releases the PRU rproc resource and makes it available to other
>> + * users.
>> + */
>> +void pru_rproc_put(struct rproc *rproc)
>> +{
>> +	struct pru_rproc *pru;
>> +
>> +	if (IS_ERR_OR_NULL(rproc) || !is_pru_rproc(rproc->dev.parent))
>> +		return;
>> +
>> +	pru = rproc->priv;
>> +
>> +	mutex_lock(&pru->lock);
>> +
>> +	if (!pru->client_np) {
>> +		mutex_unlock(&pru->lock);
>> +		return;
>> +	}
>> +
>> +	pru->client_np = NULL;
>> +	mutex_unlock(&pru->lock);
>> +
>> +	rproc_put(rproc);
>> +}
>> +EXPORT_SYMBOL_GPL(pru_rproc_put);
>> +
>>  static inline u32 pru_debug_read_reg(struct pru_rproc *pru, unsigned int reg)
>>  {
>>  	return readl_relaxed(pru->mem_regions[PRU_IOMEM_DEBUG].va + reg);
>> @@ -816,6 +942,8 @@ static int pru_rproc_probe(struct platform_device *pdev)
>>  	pru->pruss = platform_get_drvdata(ppdev);
>>  	pru->rproc = rproc;
>>  	pru->fw_name = fw_name;
>> +	pru->client_np = NULL;
>> +	mutex_init(&pru->lock);
>>  
>>  	for (i = 0; i < ARRAY_SIZE(mem_names); i++) {
>>  		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> @@ -904,7 +1032,7 @@ MODULE_DEVICE_TABLE(of, pru_rproc_match);
>>  
>>  static struct platform_driver pru_rproc_driver = {
>>  	.driver = {
>> -		.name   = "pru-rproc",
>> +		.name   = PRU_RPROC_DRVNAME,
>>  		.of_match_table = pru_rproc_match,
>>  		.suppress_bind_attrs = true,
>>  	},
>> @@ -916,5 +1044,7 @@ module_platform_driver(pru_rproc_driver);
>>  MODULE_AUTHOR("Suman Anna <s-anna@ti.com>");
>>  MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
>>  MODULE_AUTHOR("Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>");
>> +MODULE_AUTHOR("Puranjay Mohan <p-mohan@ti.com>");
>> +MODULE_AUTHOR("Md Danish Anwar <danishanwar@ti.com>");
>>  MODULE_DESCRIPTION("PRU-ICSS Remote Processor Driver");
>>  MODULE_LICENSE("GPL v2");
>> diff --git a/include/linux/pruss.h b/include/linux/pruss.h
>> new file mode 100644
>> index 000000000000..4909226f14a9
>> --- /dev/null
>> +++ b/include/linux/pruss.h
>> @@ -0,0 +1,47 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/**
>> + * PRU-ICSS Subsystem user interfaces
>> + *
>> + * Copyright (C) 2015-2022 Texas Instruments Incorporated - http://www.ti.com
>> + *	Suman Anna <s-anna@ti.com>
>> + */
>> +
>> +#ifndef __LINUX_PRUSS_H
>> +#define __LINUX_PRUSS_H
>> +
>> +#include <linux/device.h>
>> +#include <linux/types.h>
>> +
>> +#define PRU_RPROC_DRVNAME "pru-rproc"
>> +
>> +struct device_node;
>> +
>> +#if IS_ENABLED(CONFIG_PRU_REMOTEPROC)
>> +
>> +struct rproc *pru_rproc_get(struct device_node *np, int index,
>> +			    enum pruss_pru_id *pru_id);
> 
> Did you really send me code that doesn't compile?  It sure looks that way... 
> 

Previously patch 2/6 and patch 3/6 of this series were part of the same patch.
In the previous version Roger asked to introduce the pruss_pru_id enum in a
separate patch. So I split the older patch 2/6 into two parts ( "Add APIs to
get and put the PRU cores" and "Add enum for PRU Core Identifiers").

I made the new patch as 3rd patch and kept this patch as second part of the
series. I compiled all the patches together and it was getting compiled properly.

There seems to be ordering issue, the current patch ([PATCH v9 2/6] remoteproc:
pru: Add APIs to get and put the PRU cores  depends on the new patch ([PATCH v9
3/6] remoteproc: pru: Add enum for PRU Core Identifiers). I should have added
the current patch after the enum introduction patch. But my bad, I added them
the other way around.

I didn't compile patches individually. I compiled all 6 of them together and
they got compiled. I'll reorder the patches and make sure each patch compiles
properly.

Thanks,
Danish.

> 
>   CC      drivers/remoteproc/pru_rproc.o
> In file included from /home/mpoirier/work/remoteproc/kernel-review/drivers/remoteproc/pru_rproc.c:21:
> /home/mpoirier/work/remoteproc/kernel-review/include/linux/pruss.h:22:13: warning: ‘enum pruss_pru_id’ declared inside parameter list will not be visible outside of this definition or declaration
>    22 |        enum pruss_pru_id *pru_id);
>       |             ^~~~~~~~~~~~
> /home/mpoirier/work/remoteproc/kernel-review/drivers/remoteproc/pru_rproc.c:207:13: warning: ‘enum pruss_pru_id’ declared inside parameter list will not be visible outside of this definition or declaration
>   207 |        enum pruss_pru_id *pru_id)
>       |             ^~~~~~~~~~~~
> /home/mpoirier/work/remoteproc/kernel-review/drivers/remoteproc/pru_rproc.c:206:15: error: conflicting types for ‘pru_rproc_get’
>   206 | struct rproc *pru_rproc_get(struct device_node *np, int index,
>       |               ^~~~~~~~~~~~~
> In file included from /home/mpoirier/work/remoteproc/kernel-review/drivers/remoteproc/pru_rproc.c:21:
> /home/mpoirier/work/remoteproc/kernel-review/include/linux/pruss.h:21:15: note: previous declaration of ‘pru_rproc_get’ was here
>    21 | struct rproc *pru_rproc_get(struct device_node *np, int index,
>       |               ^~~~~~~~~~~~~
> /home/mpoirier/work/remoteproc/kernel-review/drivers/remoteproc/pru_rproc.c: In function ‘pru_rproc_get’:
> /home/mpoirier/work/remoteproc/kernel-review/drivers/remoteproc/pru_rproc.c:235:3: error: dereferencing pointer to incomplete type ‘enum pruss_pru_id’
>   235 |   *pru_id = pru->id;
>       |   ^~~~~~~
> In file included from /home/mpoirier/work/remoteproc/kernel-review/include/linux/linkage.h:7,
>                  from /home/mpoirier/work/remoteproc/kernel-review/include/linux/fs.h:5,
>                  from /home/mpoirier/work/remoteproc/kernel-review/include/linux/debugfs.h:15,
>                  from /home/mpoirier/work/remoteproc/kernel-review/drivers/remoteproc/pru_rproc.c:16:
> /home/mpoirier/work/remoteproc/kernel-review/drivers/remoteproc/pru_rproc.c: At top level:
> /home/mpoirier/work/remoteproc/kernel-review/drivers/remoteproc/pru_rproc.c:243:19: error: conflicting types for ‘pru_rproc_get’
>   243 | EXPORT_SYMBOL_GPL(pru_rproc_get);
> 
>> +void pru_rproc_put(struct rproc *rproc);
>> +
>> +#else
>> +
>> +static inline struct rproc *
>> +pru_rproc_get(struct device_node *np, int index, enum pruss_pru_id *pru_id)
>> +{
>> +	return ERR_PTR(-EOPNOTSUPP);
>> +}
>> +
>> +static inline void pru_rproc_put(struct rproc *rproc) { }
>> +
>> +#endif /* CONFIG_PRU_REMOTEPROC */
>> +
>> +static inline bool is_pru_rproc(struct device *dev)
>> +{
>> +	const char *drv_name = dev_driver_string(dev);
>> +
>> +	if (strncmp(drv_name, PRU_RPROC_DRVNAME, sizeof(PRU_RPROC_DRVNAME)))
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>> +#endif /* __LINUX_PRUSS_H */
>> -- 
>> 2.25.1
>>
