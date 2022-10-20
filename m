Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66626059A4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiJTIYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJTIYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:24:13 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2571183E1D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:24:10 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id c7-20020a05600c0ac700b003c6cad86f38so1747600wmr.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0uvn2r8+SbuGnCUYBaYa7eNv/J6QlUQPzRsgRxuCTqM=;
        b=KwatoKpqZLGxx/nD9zodPBdIoTcxTf7tsD1Eu01UyiGqylmxbkR4xJem8pmw5my34L
         If3IaJvU+FkrI5wyXKJCg1eDOJNIWGkr7dHMGXOi47PrdzTlTV9z8BxhuShdXuKllKOz
         hOpuZhp7bL5dr7/MTkWIEEBCvO6cTe24YN9XuQtLk6YWeEZbILuxeJunsJkbB/6yEmhE
         jYkIZr0niNJmfHzhT/GfGNBoN6CSmU6f3wXTchdyxDDeZgTrI1XMOI0mWIbvEuM5vgUr
         eN/MSIkJlC7pdOduPXLZVGwb0rFaKPSMJyNr0WNZgiahLQkLPPNVq//iH/BIPJQ2KLue
         /ujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0uvn2r8+SbuGnCUYBaYa7eNv/J6QlUQPzRsgRxuCTqM=;
        b=MdufeFmQcM4tBQk2+g4y1kuCuMKkvyweGx9yc7GEIbs3AlsTcfbaMjNV8TL5PpbShx
         CWbtJ1sUiBBPvMbx8W1qkVBSQ4zLxVhErFxojHQwIzdeWdYvDDahKYuDTshp8tFafM7g
         57eH+nMhLBEJmbpO4mTw1vObPYGz84C7gfe+nYJEipr7YhznZw7JhiFpLOTZp9vCcXZt
         J8R7jDDcg7h/PjP+WhQLXs4/P7IRsZb4jT96JFAKgm9zbrobI3bHazCoFa0lKKGij2xx
         xQy7vpKKrGeLfcDWRmtkrJDLYPd1TbTZZSVfzvtGDGI2B6ho531T0/3gZRxeM5k4JQyC
         zwGg==
X-Gm-Message-State: ACrzQf03K170xV/yAxBX84MdnMYioCtglT1L/zz94Y0gi9FZLRhtsrt/
        eTD6Tadk/XWHp/dKKcimQ8E=
X-Google-Smtp-Source: AMsMyM7RwXNA2b5CBNQ8QvInzSbgWsYrZoRbB/ISxOP/vOrQQXFtpC/vHoKAHLnVy/XPntnvtofd9g==
X-Received: by 2002:a05:600c:1906:b0:3c6:f154:d4b5 with SMTP id j6-20020a05600c190600b003c6f154d4b5mr8355717wmq.94.1666254248923;
        Thu, 20 Oct 2022 01:24:08 -0700 (PDT)
Received: from [192.168.1.93] (adsl-46.176.58.194.tellas.gr. [176.58.194.46])
        by smtp.gmail.com with ESMTPSA id d15-20020adffd8f000000b0022e309d35f8sm15774481wrr.12.2022.10.20.01.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 01:24:08 -0700 (PDT)
Message-ID: <da0d72d1-3398-8005-1c40-b5f341ff9fc8@gmail.com>
Date:   Thu, 20 Oct 2022 11:24:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2] xen/virtio: Handle PCI devices which Host controller
 is described in DT
Content-Language: en-US
To:     Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
Cc:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>
References: <20221015153409.918775-1-olekstysh@gmail.com>
 <alpine.DEB.2.22.394.2210181734440.4587@ubuntu-linux-20-04-desktop>
 <19823a2a-bc84-5458-bb69-7ac0c1b81573@gmail.com>
 <41b56c3f-1b81-a953-2e75-5a3ab8ef82a2@epam.com>
From:   Xenia Ragiadakou <burzalodowa@gmail.com>
In-Reply-To: <41b56c3f-1b81-a953-2e75-5a3ab8ef82a2@epam.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/22 22:41, Oleksandr Tyshchenko wrote:

Hi Oleksandr

> 
> On 19.10.22 11:47, Xenia Ragiadakou wrote:
> 
> Hello Xenia
> 
>> On 10/19/22 03:58, Stefano Stabellini wrote:
>>> On Sat, 15 Oct 2022, Oleksandr Tyshchenko wrote:
>>>> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>>>
>>>> Use the same "xen-grant-dma" device concept for the PCI devices
>>>> behind device-tree based PCI Host controller, but with one
>>>> modification.
>>>> Unlike for platform devices, we cannot use generic IOMMU bindings
>>>> (iommus property), as we need to support more flexible configuration.
>>>> The problem is that PCI devices under the single PCI Host controller
>>>> may have the backends running in different Xen domains and thus have
>>>> different endpoints ID (backend domains ID).
>>>>
>>>> So use generic PCI-IOMMU bindings instead (iommu-map/iommu-map-mask
>>>> properties) which allows us to describe relationship between PCI
>>>> devices and backend domains ID properly.
>>>>
>>>> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>>
>>> Now that I understood the approach and the reasons for it, I can review
>>> the patch :-)
>>>
>>> Please add an example of the bindings in the commit message.
>>>
>>>
>>>> ---
>>>> Slightly RFC. This is needed to support Xen grant mappings for
>>>> virtio-pci devices
>>>> on Arm at some point in the future. The Xen toolstack side is not
>>>> completely ready yet.
>>>> Here, for PCI devices we use more flexible way to pass backend domid
>>>> to the guest
>>>> than for platform devices.
>>>>
>>>> Changes V1 -> V2:
>>>>      - update commit description
>>>>      - rebase
>>>>      - rework to use generic PCI-IOMMU bindings instead of generic
>>>> IOMMU bindings
>>>>
>>>> Previous discussion is at:
>>>> https://urldefense.com/v3/__https://lore.kernel.org/xen-devel/20221006174804.2003029-1-olekstysh@gmail.com/__;!!GF_29dbcQIUBPA!3-vq7Edm3XfKtD5cnNjnOzDQvuo_XrhJ73yH-nPfqOkGGU0IjLG7R7MR_nAJCAPeOutHRLT44wKYwQwz3SauACie_ZAy$
>>>> [lore[.]kernel[.]org]
>>>>
>>>> Based on:
>>>> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git/log/?h=for-linus-6.1__;!!GF_29dbcQIUBPA!3-vq7Edm3XfKtD5cnNjnOzDQvuo_XrhJ73yH-nPfqOkGGU0IjLG7R7MR_nAJCAPeOutHRLT44wKYwQwz3SauAEnMDHAq$
>>>> [git[.]kernel[.]org]
>>>> ---
>>>>    drivers/xen/grant-dma-ops.c | 87
>>>> ++++++++++++++++++++++++++++++++-----
>>>>    1 file changed, 76 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
>>>> index daa525df7bdc..b79d9d6ce154 100644
>>>> --- a/drivers/xen/grant-dma-ops.c
>>>> +++ b/drivers/xen/grant-dma-ops.c
>>>> @@ -10,6 +10,7 @@
>>>>    #include <linux/module.h>
>>>>    #include <linux/dma-map-ops.h>
>>>>    #include <linux/of.h>
>>>> +#include <linux/pci.h>
>>>>    #include <linux/pfn.h>
>>>>    #include <linux/xarray.h>
>>>>    #include <linux/virtio_anchor.h>
>>>> @@ -292,12 +293,55 @@ static const struct dma_map_ops
>>>> xen_grant_dma_ops = {
>>>>        .dma_supported = xen_grant_dma_supported,
>>>>    };
>>>>    +static struct device_node *xen_dt_get_pci_host_node(struct device
>>>> *dev)
>>>> +{
>>>> +    struct pci_dev *pdev = to_pci_dev(dev);
>>>> +    struct pci_bus *bus = pdev->bus;
>>>> +
>>>> +    /* Walk up to the root bus to look for PCI Host controller */
>>>> +    while (!pci_is_root_bus(bus))
>>>> +        bus = bus->parent;
>>>> +
>>>> +    return of_node_get(bus->bridge->parent->of_node);
>>>> +}
>>>
>>> It seems silly that we need to walk the hierachy that way, but I
>>> couldn't find another way to do it
>>>
>>>
>>>> +static struct device_node *xen_dt_get_node(struct device *dev)
>>>> +{
>>>> +    if (dev_is_pci(dev))
>>>> +        return xen_dt_get_pci_host_node(dev);
>>>> +
>>>> +    return of_node_get(dev->of_node);
>>>> +}
>>>> +
>>>> +static int xen_dt_map_id(struct device *dev, struct device_node
>>>> **iommu_np,
>>>> +             u32 *sid)
>>>> +{
>>>> +    struct pci_dev *pdev = to_pci_dev(dev);
>>>> +    u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
>>>> +    struct device_node *host_np;
>>>> +    int ret;
>>>> +
>>>> +    host_np = xen_dt_get_pci_host_node(dev);
>>>> +    if (!host_np)
>>>> +        return -ENODEV;
>>>> +
>>>> +    ret = of_map_id(host_np, rid, "iommu-map", "iommu-map-mask",
>>>> iommu_np, sid);
>>>> +    of_node_put(host_np);
>>>> +    return ret;
>>>> +}
>>>> +
>>>>    static bool xen_is_dt_grant_dma_device(struct device *dev)
>>>>    {
>>>> -    struct device_node *iommu_np;
>>>> +    struct device_node *iommu_np = NULL;
>>>>        bool has_iommu;
>>>>    -    iommu_np = of_parse_phandle(dev->of_node, "iommus", 0);
>>>> +    if (dev_is_pci(dev)) {
>>>> +        if (xen_dt_map_id(dev, &iommu_np, NULL))
>>>> +            return false;
>>>> +    } else
>>>> +        iommu_np = of_parse_phandle(dev->of_node, "iommus", 0);
>>>> +
>>>>        has_iommu = iommu_np &&
>>>>                of_device_is_compatible(iommu_np, "xen,grant-dma");
>>>>        of_node_put(iommu_np);
>>>> @@ -307,9 +351,17 @@ static bool xen_is_dt_grant_dma_device(struct
>>>> device *dev)
>>>>      bool xen_is_grant_dma_device(struct device *dev)
>>>>    {
>>>> +    struct device_node *np;
>>>> +
>>>>        /* XXX Handle only DT devices for now */
>>>> -    if (dev->of_node)
>>>> -        return xen_is_dt_grant_dma_device(dev);
>>>> +    np = xen_dt_get_node(dev);
>>>> +    if (np) {
>>>> +        bool ret;
>>>> +
>>>> +        ret = xen_is_dt_grant_dma_device(dev);
>>>> +        of_node_put(np);
>>>> +        return ret;
>>>> +    }
>>>
>>> We don't need to walk the PCI hierachy twice. Maybe we can add the
>>> of_node check directly to xen_is_dt_grant_dma_device?
>>>
>>
>> I think in general we could pass directly the host bridge device if
>> dev_is_pci(dev) (which can be retrieved with
>> pci_get_host_bridge_device(to_pci_dev(dev), and after done with it
>> pci_put_host_bridge_device(phb)).
>> So that, xen_is_dt_grant_dma_device() and
>> xen_dt_grant_init_backend_domid() won't need to discover it themselves.
>> This will simplify the code.
> 
> 
> Good point. I have some remark. Can we use pci_find_host_bridge()
> instead? This way we don't have to add #include "../pci/pci.h", and have
> to drop reference afterwards.
> 
> With that xen_dt_get_pci_host_node() will became the following:
> 
> 
> static struct device_node *xen_dt_get_pci_host_node(struct device *dev)
> {
>       struct pci_host_bridge *bridge =
> pci_find_host_bridge(to_pci_dev(dev)->bus);
> 
>       return of_node_get(bridge->dev.parent->of_node);
> }
> 

You are right. I prefer your version instead of the above.

> 
> With Stefano's suggestion, we won't walk the PCI hierarchy twice when
> executing xen_is_grant_dma_device() for PCI device:
> 
> xen_is_grant_dma_device() -> xen_is_dt_grant_dma_device() ->
> xen_dt_map_id() -> xen_dt_get_pci_host_node()
> 
> 
> What do you think?
> 

I was thinking passing the device_node along with the device in the 
function arguments. More specifically, of doing this (not tested, just 
an idea):

bool xen_is_grant_dma_device(struct device *dev)
{
     struct device_node *np;
     bool has_iommu = false;

     /* XXX Handle only DT devices for now */
     np = xen_dt_get_node(dev);
     if (np)
         has_iommu = xen_is_dt_grant_dma_device(dev, np);
     of_node_put(np);
     return has_iommu;
}

static bool xen_is_dt_grant_dma_device(struct device *dev,
                                        struct device_node *np)
{
     struct device_node *iommu_np = NULL;
     bool has_iommu;

     if (dev_is_pci(dev)) {
         struct pci_dev *pdev = to_pci_dev(dev);
	u32 id = PCI_DEVID(pdev->bus->number, pdev->devfn);
         of_map_id(np, id, "iommu-map", "iommu-map-mask", &iommu_np, NULL);
     } else {
         iommu_np = of_parse_phandle(np, "iommus", 0);
     }
	
     has_iommu = iommu_np && of_device_is_compatible(iommu_np, 
"xen,grant-dma");
     of_node_put(iommu_np);

     return has_iommu;
}

I 'm wondering ... is it possible for the host bridge device node to 
have the iommus property set? meaning that all of its pci devs will have 
the same backend?

>>
>>>
>>>>        return false;
>>>>    }
>>>> @@ -325,12 +377,19 @@ bool xen_virtio_mem_acc(struct virtio_device
>>>> *dev)
>>>>    static int xen_dt_grant_init_backend_domid(struct device *dev,
>>>>                           struct xen_grant_dma_data *data)
>>>>    {
>>>> -    struct of_phandle_args iommu_spec;
>>>> +    struct of_phandle_args iommu_spec = { .args_count = 1 };
>>>>    -    if (of_parse_phandle_with_args(dev->of_node, "iommus",
>>>> "#iommu-cells",
>>>> -            0, &iommu_spec)) {
>>>> -        dev_err(dev, "Cannot parse iommus property\n");
>>>> -        return -ESRCH;
>>>> +    if (dev_is_pci(dev)) {
>>>> +        if (xen_dt_map_id(dev, &iommu_spec.np, iommu_spec.args)) {
>>>> +            dev_err(dev, "Cannot translate ID\n");
>>>> +            return -ESRCH;
>>>> +        }
>>>> +    } else {
>>>> +        if (of_parse_phandle_with_args(dev->of_node, "iommus",
>>>> "#iommu-cells",
>>>> +                0, &iommu_spec)) {
>>>> +            dev_err(dev, "Cannot parse iommus property\n");
>>>> +            return -ESRCH;
>>>> +        }
>>>>        }
>>>>          if (!of_device_is_compatible(iommu_spec.np, "xen,grant-dma") ||
>>>> @@ -354,6 +413,7 @@ static int
>>>> xen_dt_grant_init_backend_domid(struct device *dev,
>>>>    void xen_grant_setup_dma_ops(struct device *dev)
>>>>    {
>>>>        struct xen_grant_dma_data *data;
>>>> +    struct device_node *np;
>>>>          data = find_xen_grant_dma_data(dev);
>>>>        if (data) {
>>>> @@ -365,8 +425,13 @@ void xen_grant_setup_dma_ops(struct device *dev)
>>>>        if (!data)
>>>>            goto err;
>>>>    -    if (dev->of_node) {
>>>> -        if (xen_dt_grant_init_backend_domid(dev, data))
>>>> +    np = xen_dt_get_node(dev);
>>>> +    if (np) {
>>>> +        int ret;
>>>> +
>>>> +        ret = xen_dt_grant_init_backend_domid(dev, data);
>>>> +        of_node_put(np);
>>>> +        if (ret)
>>>>                goto err;
>>>>        } else if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT)) {
>>>>            dev_info(dev, "Using dom0 as backend\n");
>>>> -- 
>>>> 2.25.1
>>>>
>>>
>>

-- 
Xenia
