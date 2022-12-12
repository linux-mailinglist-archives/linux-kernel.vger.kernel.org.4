Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C86649B84
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 10:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiLLJ5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 04:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLLJ5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 04:57:50 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD2FBED;
        Mon, 12 Dec 2022 01:57:46 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BC9vb5s008226;
        Mon, 12 Dec 2022 03:57:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1670839057;
        bh=f/8EKndXfsEThqDxyjK53OX/DBlEEp1jFw0Ih8fPlUc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=dZlEz6CIDeEc1EMD+H1xDuc7cfYDgjoEDb21weRQlvb52FZONmpbHd3Ec5DoO/jRF
         V6+BKudL6/XsoPYsipIfXIanV3h07xosBFPGoUQt1Vw0gRIZCy0a0ORqrofHafmdrM
         Vq6FKSR1oYkBIoDpKkv3fGkEanf4Yn9R5koexgtg=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BC9vbu7005408
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Dec 2022 03:57:37 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 12
 Dec 2022 03:57:37 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 12 Dec 2022 03:57:37 -0600
Received: from [10.24.69.114] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BC9vW2p027584;
        Mon, 12 Dec 2022 03:57:33 -0600
Message-ID: <aeea24c9-ab6c-c524-fd88-fc11f844cfa6@ti.com>
Date:   Mon, 12 Dec 2022 15:27:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [EXTERNAL] Re: [EXTERNAL] Re: [PATCH v11 3/6] remoteproc: pru:
 Add APIs to get and put the PRU cores
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Suman Anna <s-anna@ti.com>, "Andrew F . Davis" <afd@ti.com>,
        <nm@ti.com>, <vigneshr@ti.com>, <srk@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20221207110411.441692-1-danishanwar@ti.com>
 <20221207110411.441692-4-danishanwar@ti.com>
 <77d79939-53bb-bc27-a8f8-ea5bf509a15f@kernel.org>
 <a8b8ba60-0413-5568-ae9a-57c25840dca7@ti.com>
 <7d73a0a4-c5e2-74bb-4ef9-9bc2dadd6272@kernel.org>
From:   Md Danish Anwar <a0501179@ti.com>
In-Reply-To: <7d73a0a4-c5e2-74bb-4ef9-9bc2dadd6272@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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

Hi Roger,

On 12/12/22 14:47, Roger Quadros wrote:
> Danish,
> 
> On 09/12/2022 06:55, Md Danish Anwar wrote:
>> Hi Roger,
>>
>> On 08/12/22 16:05, Roger Quadros wrote:
>>> Hi,
>>>
>>> On 07/12/2022 13:04, MD Danish Anwar wrote:
>>>> Add two new APIs, pru_rproc_get() and pru_rproc_put(), to the PRU
>>>> driver to allow client drivers to acquire and release the remoteproc
>>>> device associated with a PRU core. The PRU cores are treated as
>>>> resources with only one client owning it at a time.
>>>>
>>>> The pru_rproc_get() function returns the rproc handle corresponding
>>>> to a PRU core identified by the device tree "ti,prus" property under
>>>> the client node. The pru_rproc_put() is the complementary function
>>>> to pru_rproc_get().
>>>>
>>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>>> Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>> ---
>>>>  drivers/remoteproc/pru_rproc.c | 133 ++++++++++++++++++++++++++++++++-
>>>>  include/linux/pruss.h          |  29 +++++++
>>>>  2 files changed, 160 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
>>>> index a1a208b31846..7d4ed39b3772 100644
>>>> --- a/drivers/remoteproc/pru_rproc.c
>>>> +++ b/drivers/remoteproc/pru_rproc.c
>>>> @@ -2,12 +2,14 @@
>>>>  /*
>>>>   * PRU-ICSS remoteproc driver for various TI SoCs
>>>>   *
>>>> - * Copyright (C) 2014-2020 Texas Instruments Incorporated - https://www.ti.com/
>>>> + * Copyright (C) 2014-2022 Texas Instruments Incorporated - https://www.ti.com/
>>>>   *
>>>>   * Author(s):
>>>>   *	Suman Anna <s-anna@ti.com>
>>>>   *	Andrew F. Davis <afd@ti.com>
>>>>   *	Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org> for Texas Instruments
>>>> + *	Puranjay Mohan <p-mohan@ti.com>
>>>> + *	Md Danish Anwar <danishanwar@ti.com>
>>>>   */
>>>>  
>>>>  #include <linux/bitops.h>
>>>> @@ -112,6 +114,8 @@ struct pru_private_data {
>>>>   * @rproc: remoteproc pointer for this PRU core
>>>>   * @data: PRU core specific data
>>>>   * @mem_regions: data for each of the PRU memory regions
>>>> + * @client_np: client device node
>>>> + * @lock: mutex to protect client usage
>>>>   * @fw_name: name of firmware image used during loading
>>>>   * @mapped_irq: virtual interrupt numbers of created fw specific mapping
>>>>   * @pru_interrupt_map: pointer to interrupt mapping description (firmware)
>>>> @@ -127,6 +131,8 @@ struct pru_rproc {
>>>>  	struct rproc *rproc;
>>>>  	const struct pru_private_data *data;
>>>>  	struct pruss_mem_region mem_regions[PRU_IOMEM_MAX];
>>>> +	struct device_node *client_np;
>>>> +	struct mutex lock;
>>>>  	const char *fw_name;
>>>>  	unsigned int *mapped_irq;
>>>>  	struct pru_irq_rsc *pru_interrupt_map;
>>>> @@ -147,6 +153,125 @@ void pru_control_write_reg(struct pru_rproc *pru, unsigned int reg, u32 val)
>>>>  	writel_relaxed(val, pru->mem_regions[PRU_IOMEM_CTRL].va + reg);
>>>>  }
>>>>  
>>>> +static struct rproc *__pru_rproc_get(struct device_node *np, int index)
>>>> +{
>>>> +	struct rproc *rproc;
>>>> +	phandle rproc_phandle;
>>>> +	int ret;
>>>> +
>>>> +	ret = of_property_read_u32_index(np, "ti,prus", index, &rproc_phandle);
>>>> +	if (ret)
>>>> +		return ERR_PTR(ret);
>>>> +
>>>> +	rproc = rproc_get_by_phandle(rproc_phandle);
>>>> +	if (!rproc) {
>>>> +		ret = -EPROBE_DEFER;
>>>> +		goto err_no_rproc_handle;
>>>> +	}
>>>> +
>>>> +	/* make sure it is PRU rproc */
>>>> +	if (!is_pru_rproc(rproc->dev.parent)) {
>>>> +		rproc_put(rproc);
>>>> +		return ERR_PTR(-ENODEV);
>>>> +	}
>>>> +
>>>> +	return rproc;
>>>> +
>>>> +err_no_rproc_handle:
>>>> +	rproc_put(rproc);
>>>> +	return ERR_PTR(ret);
>>>> +}
>>>> +
>>>> +/**
>>>> + * pru_rproc_get() - get the PRU rproc instance from a device node
>>>> + * @np: the user/client device node
>>>> + * @index: index to use for the ti,prus property
>>>> + * @pru_id: optional pointer to return the PRU remoteproc processor id
>>>> + *
>>>> + * This function looks through a client device node's "ti,prus" property at
>>>> + * index @index and returns the rproc handle for a valid PRU remote processor if
>>>> + * found. The function allows only one user to own the PRU rproc resource at a
>>>> + * time. Caller must call pru_rproc_put() when done with using the rproc, not
>>>> + * required if the function returns a failure.
>>>> + *
>>>> + * When optional @pru_id pointer is passed the PRU remoteproc processor id is
>>>> + * returned.
>>>> + *
>>>> + * Return: rproc handle on success, and an ERR_PTR on failure using one
>>>> + * of the following error values
>>>> + *    -ENODEV if device is not found
>>>> + *    -EBUSY if PRU is already acquired by anyone
>>>> + *    -EPROBE_DEFER is PRU device is not probed yet
>>>> + */
>>>> +struct rproc *pru_rproc_get(struct device_node *np, int index,
>>>> +			    enum pruss_pru_id *pru_id)
>>>> +{
>>>> +	struct rproc *rproc;
>>>> +	struct pru_rproc *pru;
>>>> +	struct device *dev;
>>>> +	int ret;
>>>> +
>>>> +	rproc = __pru_rproc_get(np, index);
>>>> +	if (IS_ERR(rproc))
>>>> +		return rproc;
>>>> +
>>>> +	pru = rproc->priv;
>>>> +	dev = &rproc->dev;
>>>> +
>>>> +	mutex_lock(&pru->lock);
>>>> +
>>>> +	if (pru->client_np) {
>>>> +		mutex_unlock(&pru->lock);
>>>> +		put_device(dev);
>>>
>>> Is this put_device() to counter balance the get_device() you had earlier?
>>> Is it still needed?
>>>> Did we do the right thing by getting rid of the additional get_device()?
>>> I didn't see a reason for it.
>>>
>>
>> The previous get_device() in __pru_rproc_get() was additional/not required as
>> the same get_device() was called by rproc_get_by_phandle() API before it's
>> completion.
>>
>> So that get_device() is not needed.
>>
>> The put_device() here is to counter the get_device() called by
>> rproc_get_by_phandle() in the API __pru_rproc_get().
>>
>> So I think, this put_device() is still needed.
> 
> But at the end of this function we are calling rproc_put()
> which also does a put_device(), right?
> 

Yes, from here we are going to the label err_no_rproc_handle where rproc_put()
API is called. Which is further calling put_device(). So essentially we are
doing two put device instead of one.

So I think, I should remove the put_device() from the below if block

if (pru->client_np) {
    mutex_unlock(&pru->lock);
    put_device(dev);
    ret = -EBUSY;
    goto err_no_rproc_handle;
}

>>
>>>> +		ret = -EBUSY;
>>>> +		goto err_no_rproc_handle;
>>>> +	}
>>>> +
>>>> +	pru->client_np = np;
>>>> +
>>>> +	mutex_unlock(&pru->lock);
>>>> +
>>>> +	if (pru_id)
>>>> +		*pru_id = pru->id;
>>>> +
>>>> +	return rproc;
>>>> +
>>>> +err_no_rproc_handle:
>>>> +	rproc_put(rproc);
>>>> +	return ERR_PTR(ret);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(pru_rproc_get);
> 
> <snip>
> 
> cheers,
> -roger
