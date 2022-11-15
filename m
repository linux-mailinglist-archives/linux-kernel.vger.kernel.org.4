Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F283362A14C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiKOS2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKOS2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:28:37 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A42210EF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:28:34 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id q1so14024857pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eN8Y8tmcXY1Sx8X/CKBIpdvOb7TPXPJYWBMc1VPUnfE=;
        b=rXAHNSao3J24HGE7DiY019ib/78iKD4I9HRM2WnnP4fVWYL2LCHiU0trOH28PI+i59
         Riijn7BvZ0tXXSV+xUCt/pqKrHKwpyP/Sh3s9iY+r9uMsSBKFm8STlW56JX+B/TWX9gW
         GyKnGkdvPx4WsU/9AwbwdcNFQWXxGezce0A51L0/5pzX/zxC/U/LUkz6y2XWasW7Ze6b
         NRd3IRxyf4A9I9JBSOtTiVM2EXFIvy0Ezsna1t2hYbuDvb8y9Jd5cgvJ53glj21/ANPR
         pgg0coAy1ijKmfHrK425wh1JhGIuKuqN6G/AmW1c6F2x/5RcLh2Yw6Het2Ysi7IkRLFD
         X6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eN8Y8tmcXY1Sx8X/CKBIpdvOb7TPXPJYWBMc1VPUnfE=;
        b=edu4OcacEH8qaDuiQIc+PpTvRXnxFRoBc7ZDPerEV4g+DrNH1L22/bSXc3XMv4ptoW
         IQI5aChqO6IyKTHKoE72BavI7alFN0HznBO1ymruxobK8bQ86GjsZh4d+HtLrjyvT+Pu
         33oMCfuY6IhdxECu5La4/q9tcTnxts/pJKgrrmv3jjH3omU4dhq1M3KAPmJ/qsIjZcvn
         k7v7xQ9iVx9CGes9f2tBkUynizG/cNEgBe0F4mnHO9CiQ6WEs4VzvPKcWOGA0j9+vVsI
         kYaFBJprZCWBZfRstgA7Ny7ciWMCukJWoCnHxLHqPPEYm4vOEHq9YWbabrpLpb3v/JhG
         BACg==
X-Gm-Message-State: ANoB5pnNDeAjzNokt0MlEyDNZFqPsVnmMrS1gfOjzJ3k8OgUPFURh9qB
        hb3VNziwJP4zMxGnzgGVVqiFMw==
X-Google-Smtp-Source: AA0mqf76d87lFv9TGgIz9I/2+zNAKDJj01NBvRaRPkIKsREVZncSt6oyj/qVXHVy9h7pcGLErOpmow==
X-Received: by 2002:a63:524b:0:b0:474:66fb:41fa with SMTP id s11-20020a63524b000000b0047466fb41famr16582322pgl.21.1668536913650;
        Tue, 15 Nov 2022 10:28:33 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id m15-20020a656a0f000000b0045dc85c4a5fsm8048610pgu.44.2022.11.15.10.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 10:28:32 -0800 (PST)
Date:   Tue, 15 Nov 2022 11:28:30 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Md Danish Anwar <a0501179@ti.com>
Cc:     MD Danish Anwar <danishanwar@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Suman Anna <s-anna@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        "Andrew F . Davis" <afd@ti.com>, nm@ti.com, vigneshr@ti.com,
        srk@ti.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 2/5] remoteproc: pru: Add APIs to get and put the PRU
 cores
Message-ID: <20221115182830.GA61935@p14s>
References: <20221031073801.130541-1-danishanwar@ti.com>
 <20221031073801.130541-3-danishanwar@ti.com>
 <20221114205057.GA8042@p14s>
 <5e07e4e1-142e-1c48-6ee0-78c537e126b9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e07e4e1-142e-1c48-6ee0-78c537e126b9@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 11:29:19AM +0530, Md Danish Anwar wrote:
> Hi Mathieu,
> 
> On 15/11/22 02:20, Mathieu Poirier wrote:
> > On Mon, Oct 31, 2022 at 01:07:58PM +0530, MD Danish Anwar wrote:
> >> From: Tero Kristo <t-kristo@ti.com>
> >>
> >> Add two new APIs, pru_rproc_get() and pru_rproc_put(), to the PRU
> >> driver to allow client drivers to acquire and release the remoteproc
> >> device associated with a PRU core. The PRU cores are treated as
> >> resources with only one client owning it at a time.
> >>
> >> The pru_rproc_get() function returns the rproc handle corresponding
> >> to a PRU core identified by the device tree "ti,prus" property under
> >> the client node. The pru_rproc_put() is the complementary function
> >> to pru_rproc_get().
> >>
> >> Co-developed-by: Suman Anna <s-anna@ti.com>
> >> Signed-off-by: Suman Anna <s-anna@ti.com>
> >> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> >> Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
> >> Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
> >> Co-developed-by: Puranjay Mohan <p-mohan@ti.com>
> >> Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
> >> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> > 
> > The above is very tedious to look at.  Other than yours, please replace all the
> > SoBs with Co-developed-by tags.  Even that seems to be an overkill...  Anyways,
> > for this patch and the other ones in this set.
> > 
> 
> Sure, I will replace all the SoBs (other than mine) with Co-developed by tags
> for all the patches in this series.
> 
> >> ---
> >>  drivers/remoteproc/pru_rproc.c | 142 +++++++++++++++++++++++++++++++--
> >>  include/linux/pruss.h          |  56 +++++++++++++
> >>  2 files changed, 193 insertions(+), 5 deletions(-)
> >>  create mode 100644 include/linux/pruss.h
> >>
> >> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
> >> index 128bf9912f2c..9ba73cfc29e2 100644
> >> --- a/drivers/remoteproc/pru_rproc.c
> >> +++ b/drivers/remoteproc/pru_rproc.c
> >> @@ -2,12 +2,14 @@
> >>  /*
> >>   * PRU-ICSS remoteproc driver for various TI SoCs
> >>   *
> >> - * Copyright (C) 2014-2020 Texas Instruments Incorporated - https://www.ti.com/
> >> + * Copyright (C) 2014-2022 Texas Instruments Incorporated - https://www.ti.com/
> >>   *
> >>   * Author(s):
> >>   *	Suman Anna <s-anna@ti.com>
> >>   *	Andrew F. Davis <afd@ti.com>
> >>   *	Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org> for Texas Instruments
> >> + *	Puranjay Mohan <p-mohan@ti.com>
> >> + *	Md Danish Anwar <danishanwar@ti.com>
> >>   */
> >>  
> >>  #include <linux/bitops.h>
> >> @@ -16,6 +18,7 @@
> >>  #include <linux/module.h>
> >>  #include <linux/of_device.h>
> >>  #include <linux/of_irq.h>
> >> +#include <linux/pruss.h>
> >>  #include <linux/pruss_driver.h>
> >>  #include <linux/remoteproc.h>
> >>  
> >> @@ -111,6 +114,8 @@ struct pru_private_data {
> >>   * @rproc: remoteproc pointer for this PRU core
> >>   * @data: PRU core specific data
> >>   * @mem_regions: data for each of the PRU memory regions
> >> + * @client_np: client device node
> >> + * @lock: mutex to protect client usage
> >>   * @fw_name: name of firmware image used during loading
> >>   * @mapped_irq: virtual interrupt numbers of created fw specific mapping
> >>   * @pru_interrupt_map: pointer to interrupt mapping description (firmware)
> >> @@ -126,6 +131,8 @@ struct pru_rproc {
> >>  	struct rproc *rproc;
> >>  	const struct pru_private_data *data;
> >>  	struct pruss_mem_region mem_regions[PRU_IOMEM_MAX];
> >> +	struct device_node *client_np;
> >> +	struct mutex lock; /* client access lock */
> > 
> > Why is there a comment here when the field is already documented above?
> > 
> 
> I will remove the comment from here.
> 
> > I will wait for you to address Roger's comments before looking at this set
> > further.
> > 
> 
> I had addressed two out of three of Roger's comments earlier. I missed one
> comment. I have responded to that now. Please have a look at this set.

I won't - spin off a new revision after addressing Roger's comments and I will
look at that one.

> 
> > Thanks,
> > Mathieu
> > 
> >>  	const char *fw_name;
> >>  	unsigned int *mapped_irq;
> >>  	struct pru_irq_rsc *pru_interrupt_map;
> >> @@ -146,6 +153,127 @@ void pru_control_write_reg(struct pru_rproc *pru, unsigned int reg, u32 val)
> >>  	writel_relaxed(val, pru->mem_regions[PRU_IOMEM_CTRL].va + reg);
> >>  }
> >>  
> >> +static struct rproc *__pru_rproc_get(struct device_node *np, int index)
> >> +{
> >> +	struct rproc *rproc;
> >> +	phandle rproc_phandle;
> >> +	int ret;
> >> +
> >> +	ret = of_property_read_u32_index(np, "ti,prus", index, &rproc_phandle);
> >> +	if (ret)
> >> +		return ERR_PTR(ret);
> >> +
> >> +	rproc = rproc_get_by_phandle(rproc_phandle);
> >> +	if (!rproc) {
> >> +		ret = -EPROBE_DEFER;
> >> +		goto err_no_rproc_handle;
> >> +	}
> >> +
> >> +	/* make sure it is PRU rproc */
> >> +	if (!is_pru_rproc(rproc->dev.parent)) {
> >> +		rproc_put(rproc);
> >> +		return ERR_PTR(-ENODEV);
> >> +	}
> >> +
> >> +	get_device(&rproc->dev);
> >> +
> >> +	return rproc;
> >> +
> >> +err_no_rproc_handle:
> >> +	rproc_put(rproc);
> >> +	return ERR_PTR(ret);
> >> +}
> >> +
> >> +/**
> >> + * pru_rproc_get() - get the PRU rproc instance from a device node
> >> + * @np: the user/client device node
> >> + * @index: index to use for the ti,prus property
> >> + * @pru_id: optional pointer to return the PRU remoteproc processor id
> >> + *
> >> + * This function looks through a client device node's "ti,prus" property at
> >> + * index @index and returns the rproc handle for a valid PRU remote processor if
> >> + * found. The function allows only one user to own the PRU rproc resource at a
> >> + * time. Caller must call pru_rproc_put() when done with using the rproc, not
> >> + * required if the function returns a failure.
> >> + *
> >> + * When optional @pru_id pointer is passed the PRU remoteproc processor id is
> >> + * returned.
> >> + *
> >> + * Return: rproc handle on success, and an ERR_PTR on failure using one
> >> + * of the following error values
> >> + *    -ENODEV if device is not found
> >> + *    -EBUSY if PRU is already acquired by anyone
> >> + *    -EPROBE_DEFER is PRU device is not probed yet
> >> + */
> >> +struct rproc *pru_rproc_get(struct device_node *np, int index,
> >> +			    enum pruss_pru_id *pru_id)
> >> +{
> >> +	struct rproc *rproc;
> >> +	struct pru_rproc *pru;
> >> +	struct device *dev;
> >> +	int ret;
> >> +
> >> +	rproc = __pru_rproc_get(np, index);
> >> +	if (IS_ERR(rproc))
> >> +		return rproc;
> >> +
> >> +	pru = rproc->priv;
> >> +	dev = &rproc->dev;
> >> +
> >> +	mutex_lock(&pru->lock);
> >> +
> >> +	if (pru->client_np) {
> >> +		mutex_unlock(&pru->lock);
> >> +		put_device(dev);
> >> +		ret = -EBUSY;
> >> +		goto err_no_rproc_handle;
> >> +	}
> >> +
> >> +	pru->client_np = np;
> >> +
> >> +	mutex_unlock(&pru->lock);
> >> +
> >> +	if (pru_id)
> >> +		*pru_id = pru->id;
> >> +
> >> +	return rproc;
> >> +
> >> +err_no_rproc_handle:
> >> +	rproc_put(rproc);
> >> +	return ERR_PTR(ret);
> >> +}
> >> +EXPORT_SYMBOL_GPL(pru_rproc_get);
> >> +
> >> +/**
> >> + * pru_rproc_put() - release the PRU rproc resource
> >> + * @rproc: the rproc resource to release
> >> + *
> >> + * Releases the PRU rproc resource and makes it available to other
> >> + * users.
> >> + */
> >> +void pru_rproc_put(struct rproc *rproc)
> >> +{
> >> +	struct pru_rproc *pru;
> >> +
> >> +	if (IS_ERR_OR_NULL(rproc) || !is_pru_rproc(rproc->dev.parent))
> >> +		return;
> >> +
> >> +	pru = rproc->priv;
> >> +
> >> +	mutex_lock(&pru->lock);
> >> +
> >> +	if (!pru->client_np) {
> >> +		mutex_unlock(&pru->lock);
> >> +		return;
> >> +	}
> >> +
> >> +	pru->client_np = NULL;
> >> +	mutex_unlock(&pru->lock);
> >> +
> >> +	rproc_put(rproc);
> >> +}
> >> +EXPORT_SYMBOL_GPL(pru_rproc_put);
> >> +
> >>  static inline u32 pru_debug_read_reg(struct pru_rproc *pru, unsigned int reg)
> >>  {
> >>  	return readl_relaxed(pru->mem_regions[PRU_IOMEM_DEBUG].va + reg);
> >> @@ -438,7 +566,7 @@ static void *pru_d_da_to_va(struct pru_rproc *pru, u32 da, size_t len)
> >>  	dram0 = pruss->mem_regions[PRUSS_MEM_DRAM0];
> >>  	dram1 = pruss->mem_regions[PRUSS_MEM_DRAM1];
> >>  	/* PRU1 has its local RAM addresses reversed */
> >> -	if (pru->id == 1)
> >> +	if (pru->id == PRUSS_PRU1)
> >>  		swap(dram0, dram1);
> >>  	shrd_ram = pruss->mem_regions[PRUSS_MEM_SHRD_RAM2];
> >>  
> >> @@ -747,14 +875,14 @@ static int pru_rproc_set_id(struct pru_rproc *pru)
> >>  	case RTU0_IRAM_ADDR_MASK:
> >>  		fallthrough;
> >>  	case PRU0_IRAM_ADDR_MASK:
> >> -		pru->id = 0;
> >> +		pru->id = PRUSS_PRU0;
> >>  		break;
> >>  	case TX_PRU1_IRAM_ADDR_MASK:
> >>  		fallthrough;
> >>  	case RTU1_IRAM_ADDR_MASK:
> >>  		fallthrough;
> >>  	case PRU1_IRAM_ADDR_MASK:
> >> -		pru->id = 1;
> >> +		pru->id = PRUSS_PRU1;
> >>  		break;
> >>  	default:
> >>  		ret = -EINVAL;
> >> @@ -816,6 +944,8 @@ static int pru_rproc_probe(struct platform_device *pdev)
> >>  	pru->pruss = platform_get_drvdata(ppdev);
> >>  	pru->rproc = rproc;
> >>  	pru->fw_name = fw_name;
> >> +	pru->client_np = NULL;
> >> +	mutex_init(&pru->lock);
> >>  
> >>  	for (i = 0; i < ARRAY_SIZE(mem_names); i++) {
> >>  		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> >> @@ -904,7 +1034,7 @@ MODULE_DEVICE_TABLE(of, pru_rproc_match);
> >>  
> >>  static struct platform_driver pru_rproc_driver = {
> >>  	.driver = {
> >> -		.name   = "pru-rproc",
> >> +		.name   = PRU_RPROC_DRVNAME,
> >>  		.of_match_table = pru_rproc_match,
> >>  		.suppress_bind_attrs = true,
> >>  	},
> >> @@ -916,5 +1046,7 @@ module_platform_driver(pru_rproc_driver);
> >>  MODULE_AUTHOR("Suman Anna <s-anna@ti.com>");
> >>  MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
> >>  MODULE_AUTHOR("Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>");
> >> +MODULE_AUTHOR("Puranjay Mohan <p-mohan@ti.com>");
> >> +MODULE_AUTHOR("Md Danish Anwar <danishanwar@ti.com>");
> >>  MODULE_DESCRIPTION("PRU-ICSS Remote Processor Driver");
> >>  MODULE_LICENSE("GPL v2");
> >> diff --git a/include/linux/pruss.h b/include/linux/pruss.h
> >> new file mode 100644
> >> index 000000000000..fdc719b43db0
> >> --- /dev/null
> >> +++ b/include/linux/pruss.h
> >> @@ -0,0 +1,56 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-only */
> >> +/**
> >> + * PRU-ICSS Subsystem user interfaces
> >> + *
> >> + * Copyright (C) 2015-2022 Texas Instruments Incorporated - http://www.ti.com
> >> + *	Suman Anna <s-anna@ti.com>
> >> + */
> >> +
> >> +#ifndef __LINUX_PRUSS_H
> >> +#define __LINUX_PRUSS_H
> >> +
> >> +#include <linux/device.h>
> >> +#include <linux/types.h>
> >> +
> >> +#define PRU_RPROC_DRVNAME "pru-rproc"
> >> +
> >> +/*
> >> + * enum pruss_pru_id - PRU core identifiers
> >> + */
> >> +enum pruss_pru_id {
> >> +	PRUSS_PRU0 = 0,
> >> +	PRUSS_PRU1,
> >> +	PRUSS_NUM_PRUS,
> >> +};
> >> +
> >> +struct device_node;
> >> +
> >> +#if IS_ENABLED(CONFIG_PRU_REMOTEPROC)
> >> +
> >> +struct rproc *pru_rproc_get(struct device_node *np, int index,
> >> +			    enum pruss_pru_id *pru_id);
> >> +void pru_rproc_put(struct rproc *rproc);
> >> +
> >> +#else
> >> +
> >> +static inline struct rproc *
> >> +pru_rproc_get(struct device_node *np, int index, enum pruss_pru_id *pru_id)
> >> +{
> >> +	return ERR_PTR(-EOPNOTSUPP);
> >> +}
> >> +
> >> +static inline void pru_rproc_put(struct rproc *rproc) { }
> >> +
> >> +#endif /* CONFIG_PRU_REMOTEPROC */
> >> +
> >> +static inline bool is_pru_rproc(struct device *dev)
> >> +{
> >> +	const char *drv_name = dev_driver_string(dev);
> >> +
> >> +	if (strncmp(drv_name, PRU_RPROC_DRVNAME, sizeof(PRU_RPROC_DRVNAME)))
> >> +		return false;
> >> +
> >> +	return true;
> >> +}
> >> +
> >> +#endif /* __LINUX_PRUSS_H */
> >> -- 
> >> 2.25.1
> >>
> 
> Thanks,
> Danish
