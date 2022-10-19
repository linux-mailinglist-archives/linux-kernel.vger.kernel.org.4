Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2566603DD6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbiJSJHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbiJSJEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:04:53 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B6E9DDA1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 01:58:40 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id k2so38362591ejr.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 01:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fn0vkXWE/OgO7OZyVob5cWSHyej/WCT0UHxy2GYCHp4=;
        b=Emsnh+FxiJ3lB1Xe6RkfRkxIT5iuxz0dU0KsvvWhhFoJmkRj+86tj6eyLfc0o5x2zR
         Xpuxbxf7HoP9+bGmvQxYWvpEGxVNbVLCnXE1HP+p33s8+rA3qo24vH/22w3/GSu7b5pD
         STVQvQWhHnlsIiFFDc9xhSeRbAEoLL2OzSL3rS8+VScQSxYkDqODm7vHSqxM0HQmyKlq
         bjm0VKQgagI3tfSg2gtsPaqNaz+exH3W54JnlW7ImE+hKDU+g3Uumx/3UoG9Dk3+/Zlv
         FcjGrh4j1kuI+DT/Pgv/czMCRFSisMOA2+vZUSX0F5/02CcNsUB3de6hYyivhM3gRmqU
         jxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fn0vkXWE/OgO7OZyVob5cWSHyej/WCT0UHxy2GYCHp4=;
        b=vlLMjzhar4Ip4kf1trhp9u8dqNEKr/oA6idMO4bJVxZjf1jxRtDBbrXByK3HqmN8dG
         0qx4jNKVU8rfWa796CzuFMkdWwLu5arL8lFE88f+vcIvQwObWEEFcDgGWSodkhoWZzFA
         6TGnTTUNQ88sLY1H4McjbnKnm5o09TIK1xznOYJdCrxKZxy7G7Up1vqNU6XR1rQdSIeZ
         /2Fh2SJoikhBzwCbU5dh2sD74VsQj2hlG3O8tEtneVc6n8IqmmSfgMZLo7UdMMsTE00B
         bQROm4Rcr7VEpuqfp69PWQYkiIMjF/FRqNP5oIBwP6qxWf6szr90F5pWAgpZ9VSTCkvA
         CPYQ==
X-Gm-Message-State: ACrzQf2KJv20aVtFYMEd/IwJ1tS7vAI2uueOv9ROQdKH9Pcf/p2ob0/X
        P6ChTkVvmvYcjl+Uc+pAMTP5RFo2CBg=
X-Google-Smtp-Source: AMsMyM6S7Wg58ZQT0dZSgmjbSrfnEfkfxXF6anbfyb3hyGKS4y6IJYMBCj+vH7GR82tp8p+9wYrxsw==
X-Received: by 2002:a17:907:3e0f:b0:791:9529:3674 with SMTP id hp15-20020a1709073e0f00b0079195293674mr5663556ejc.503.1666169273367;
        Wed, 19 Oct 2022 01:47:53 -0700 (PDT)
Received: from [192.168.1.93] (adsl-166.109.242.226.tellas.gr. [109.242.226.166])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709064a1600b0074136cac2e7sm8612834eju.81.2022.10.19.01.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 01:47:52 -0700 (PDT)
Message-ID: <19823a2a-bc84-5458-bb69-7ac0c1b81573@gmail.com>
Date:   Wed, 19 Oct 2022 11:47:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2] xen/virtio: Handle PCI devices which Host controller
 is described in DT
Content-Language: en-US
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Juergen Gross <jgross@suse.com>
References: <20221015153409.918775-1-olekstysh@gmail.com>
 <alpine.DEB.2.22.394.2210181734440.4587@ubuntu-linux-20-04-desktop>
From:   Xenia Ragiadakou <burzalodowa@gmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2210181734440.4587@ubuntu-linux-20-04-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/22 03:58, Stefano Stabellini wrote:
> On Sat, 15 Oct 2022, Oleksandr Tyshchenko wrote:
>> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>
>> Use the same "xen-grant-dma" device concept for the PCI devices
>> behind device-tree based PCI Host controller, but with one modification.
>> Unlike for platform devices, we cannot use generic IOMMU bindings
>> (iommus property), as we need to support more flexible configuration.
>> The problem is that PCI devices under the single PCI Host controller
>> may have the backends running in different Xen domains and thus have
>> different endpoints ID (backend domains ID).
>>
>> So use generic PCI-IOMMU bindings instead (iommu-map/iommu-map-mask
>> properties) which allows us to describe relationship between PCI
>> devices and backend domains ID properly.
>>
>> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> Now that I understood the approach and the reasons for it, I can review
> the patch :-)
> 
> Please add an example of the bindings in the commit message.
> 
> 
>> ---
>> Slightly RFC. This is needed to support Xen grant mappings for virtio-pci devices
>> on Arm at some point in the future. The Xen toolstack side is not completely ready yet.
>> Here, for PCI devices we use more flexible way to pass backend domid to the guest
>> than for platform devices.
>>
>> Changes V1 -> V2:
>>     - update commit description
>>     - rebase
>>     - rework to use generic PCI-IOMMU bindings instead of generic IOMMU bindings
>>
>> Previous discussion is at:
>> https://lore.kernel.org/xen-devel/20221006174804.2003029-1-olekstysh@gmail.com/
>>
>> Based on:
>> https://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git/log/?h=for-linus-6.1
>> ---
>>   drivers/xen/grant-dma-ops.c | 87 ++++++++++++++++++++++++++++++++-----
>>   1 file changed, 76 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
>> index daa525df7bdc..b79d9d6ce154 100644
>> --- a/drivers/xen/grant-dma-ops.c
>> +++ b/drivers/xen/grant-dma-ops.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/module.h>
>>   #include <linux/dma-map-ops.h>
>>   #include <linux/of.h>
>> +#include <linux/pci.h>
>>   #include <linux/pfn.h>
>>   #include <linux/xarray.h>
>>   #include <linux/virtio_anchor.h>
>> @@ -292,12 +293,55 @@ static const struct dma_map_ops xen_grant_dma_ops = {
>>   	.dma_supported = xen_grant_dma_supported,
>>   };
>>   
>> +static struct device_node *xen_dt_get_pci_host_node(struct device *dev)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +	struct pci_bus *bus = pdev->bus;
>> +
>> +	/* Walk up to the root bus to look for PCI Host controller */
>> +	while (!pci_is_root_bus(bus))
>> +		bus = bus->parent;
>> +
>> +	return of_node_get(bus->bridge->parent->of_node);
>> +}
> 
> It seems silly that we need to walk the hierachy that way, but I
> couldn't find another way to do it
> 
> 
>> +static struct device_node *xen_dt_get_node(struct device *dev)
>> +{
>> +	if (dev_is_pci(dev))
>> +		return xen_dt_get_pci_host_node(dev);
>> +
>> +	return of_node_get(dev->of_node);
>> +}
>> +
>> +static int xen_dt_map_id(struct device *dev, struct device_node **iommu_np,
>> +			 u32 *sid)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +	u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
>> +	struct device_node *host_np;
>> +	int ret;
>> +
>> +	host_np = xen_dt_get_pci_host_node(dev);
>> +	if (!host_np)
>> +		return -ENODEV;
>> +
>> +	ret = of_map_id(host_np, rid, "iommu-map", "iommu-map-mask", iommu_np, sid);
>> +	of_node_put(host_np);
>> +	return ret;
>> +}
>> +
>>   static bool xen_is_dt_grant_dma_device(struct device *dev)
>>   {
>> -	struct device_node *iommu_np;
>> +	struct device_node *iommu_np = NULL;
>>   	bool has_iommu;
>>   
>> -	iommu_np = of_parse_phandle(dev->of_node, "iommus", 0);
>> +	if (dev_is_pci(dev)) {
>> +		if (xen_dt_map_id(dev, &iommu_np, NULL))
>> +			return false;
>> +	} else
>> +		iommu_np = of_parse_phandle(dev->of_node, "iommus", 0);
>> +
>>   	has_iommu = iommu_np &&
>>   		    of_device_is_compatible(iommu_np, "xen,grant-dma");
>>   	of_node_put(iommu_np);
>> @@ -307,9 +351,17 @@ static bool xen_is_dt_grant_dma_device(struct device *dev)
>>   
>>   bool xen_is_grant_dma_device(struct device *dev)
>>   {
>> +	struct device_node *np;
>> +
>>   	/* XXX Handle only DT devices for now */
>> -	if (dev->of_node)
>> -		return xen_is_dt_grant_dma_device(dev);
>> +	np = xen_dt_get_node(dev);
>> +	if (np) {
>> +		bool ret;
>> +
>> +		ret = xen_is_dt_grant_dma_device(dev);
>> +		of_node_put(np);
>> +		return ret;
>> +	}
> 
> We don't need to walk the PCI hierachy twice. Maybe we can add the
> of_node check directly to xen_is_dt_grant_dma_device?
> 

I think in general we could pass directly the host bridge device if 
dev_is_pci(dev) (which can be retrieved with 
pci_get_host_bridge_device(to_pci_dev(dev), and after done with it 
pci_put_host_bridge_device(phb)).
So that, xen_is_dt_grant_dma_device() and 
xen_dt_grant_init_backend_domid() won't need to discover it themselves.
This will simplify the code.

> 
>>   	return false;
>>   }
>> @@ -325,12 +377,19 @@ bool xen_virtio_mem_acc(struct virtio_device *dev)
>>   static int xen_dt_grant_init_backend_domid(struct device *dev,
>>   					   struct xen_grant_dma_data *data)
>>   {
>> -	struct of_phandle_args iommu_spec;
>> +	struct of_phandle_args iommu_spec = { .args_count = 1 };
>>   
>> -	if (of_parse_phandle_with_args(dev->of_node, "iommus", "#iommu-cells",
>> -			0, &iommu_spec)) {
>> -		dev_err(dev, "Cannot parse iommus property\n");
>> -		return -ESRCH;
>> +	if (dev_is_pci(dev)) {
>> +		if (xen_dt_map_id(dev, &iommu_spec.np, iommu_spec.args)) {
>> +			dev_err(dev, "Cannot translate ID\n");
>> +			return -ESRCH;
>> +		}
>> +	} else {
>> +		if (of_parse_phandle_with_args(dev->of_node, "iommus", "#iommu-cells",
>> +				0, &iommu_spec)) {
>> +			dev_err(dev, "Cannot parse iommus property\n");
>> +			return -ESRCH;
>> +		}
>>   	}
>>   
>>   	if (!of_device_is_compatible(iommu_spec.np, "xen,grant-dma") ||
>> @@ -354,6 +413,7 @@ static int xen_dt_grant_init_backend_domid(struct device *dev,
>>   void xen_grant_setup_dma_ops(struct device *dev)
>>   {
>>   	struct xen_grant_dma_data *data;
>> +	struct device_node *np;
>>   
>>   	data = find_xen_grant_dma_data(dev);
>>   	if (data) {
>> @@ -365,8 +425,13 @@ void xen_grant_setup_dma_ops(struct device *dev)
>>   	if (!data)
>>   		goto err;
>>   
>> -	if (dev->of_node) {
>> -		if (xen_dt_grant_init_backend_domid(dev, data))
>> +	np = xen_dt_get_node(dev);
>> +	if (np) {
>> +		int ret;
>> +
>> +		ret = xen_dt_grant_init_backend_domid(dev, data);
>> +		of_node_put(np);
>> +		if (ret)
>>   			goto err;
>>   	} else if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT)) {
>>   		dev_info(dev, "Using dom0 as backend\n");
>> -- 
>> 2.25.1
>>
> 

-- 
Xenia
