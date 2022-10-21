Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409D2606FD5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 08:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiJUGIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 02:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJUGIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:08:44 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AD11FAE76
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:08:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u10so3234300wrq.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ChZn3e9kGcPoptLn8C3xXXF9IN3U8sryoKJLNmf8AEo=;
        b=gG+uaK0wTBudUSkunxErEsYTEwQ9KMBzlzBjLLRKi8yc/QcWZjobbsdcpyGJksC84i
         nwG7j/cCIVG2EYtOH4W5p/m4s7Vb0Lz/3osP0adIknM/JfIuwNM1DyqNW6jez0DOWiEO
         kyw5WJmEQW4iOQnYLmaDVNprlF6KGNq4zPs/L71CFCdHGGAkUTZbdGb8hdguSJRk9qa4
         as2j4sWqVQ9cy8hN8PrhgT6YYknDtUVpPq+Ysb4vGwc82mUh7cw53VU4QkpaRJQA8cqA
         3E3lef2EgxjpXtPOolzMpgmg+xYckqjREn4Ugy0h/MfrEeQkvNUHjWDc0smBkz+fJyL9
         edkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ChZn3e9kGcPoptLn8C3xXXF9IN3U8sryoKJLNmf8AEo=;
        b=xqDowM1isPQaHpnO7uDYLcgpkkoejYfEglbDbCOuO0FU9quHz1dqsgv4gcVz15fF8N
         W9wn3BPEem/5+aaeyIU+nA6VE3tJ5ECQdYqDjSZtowtEHJGMCiiirBgKOwRwqEozGPF3
         LbH2SHAIcMof8sDd52/Xs4VHOO2NgUgg1YxGpejUTGv8Y2oitggy1CknvnX7zCaNDa0J
         JZBqRiUQL4mZoP4WwYjqcOqBzpNnFM73/2utZMonetOabzSEzIQYY28FRBHOD4CWejjB
         FnawheNDlBn0v9f9nLfZqIWVaaVvZRkoe8PZJvumOqvhzTR9vN4DPxTmyy6Xj3buHOsu
         0eAA==
X-Gm-Message-State: ACrzQf1BrnHT6mEViRN5qV8/E2voo9Nz4neI8B1/2rTi/SLBdZR8rnqt
        IfRa1zrmsenBddwxCzrS3nM=
X-Google-Smtp-Source: AMsMyM5qPEzHicUh5RvC1ttVo+I5BNX7gOPOLF29Ys9HkOigt24u0c12XeM7o5VM1nEPlYaKwsALhA==
X-Received: by 2002:a05:6000:1787:b0:231:9b3f:ce98 with SMTP id e7-20020a056000178700b002319b3fce98mr11164584wrg.253.1666332519731;
        Thu, 20 Oct 2022 23:08:39 -0700 (PDT)
Received: from [192.168.1.93] (adsl-70.109.242.225.tellas.gr. [109.242.225.70])
        by smtp.gmail.com with ESMTPSA id g15-20020adfe40f000000b00226dfac0149sm18194877wrm.114.2022.10.20.23.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 23:08:39 -0700 (PDT)
Message-ID: <85e5cb11-ab58-5433-d456-fa831f4deccf@gmail.com>
Date:   Fri, 21 Oct 2022 09:08:37 +0300
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
 <da0d72d1-3398-8005-1c40-b5f341ff9fc8@gmail.com>
 <ded6c520-8f1a-6ee3-bbfa-3de7e1f74779@epam.com>
 <44fdaba0-15eb-0778-bacf-3937a36b0841@gmail.com>
 <174a4c06-b95a-c817-a400-f33cccd8d545@epam.com>
From:   Xenia Ragiadakou <burzalodowa@gmail.com>
In-Reply-To: <174a4c06-b95a-c817-a400-f33cccd8d545@epam.com>
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

On 10/20/22 23:07, Oleksandr Tyshchenko wrote:
Hi Oleksandr
> 
> On 20.10.22 21:11, Xenia Ragiadakou wrote:
> 
> Hello Xenia
> 
> 
>> On 10/20/22 17:12, Oleksandr Tyshchenko wrote:
>>>
>>> On 20.10.22 11:24, Xenia Ragiadakou wrote:
>>>> On 10/19/22 22:41, Oleksandr Tyshchenko wrote:
>>>>
>>>> Hi Oleksandr
>>>
>>>
>>> Hello Xenia
>>>
>>>
>>>>
>>>>>
>>>>> On 19.10.22 11:47, Xenia Ragiadakou wrote:
>>>>>
>>>>> Hello Xenia
>>>>>
>>>>>> On 10/19/22 03:58, Stefano Stabellini wrote:
>>>>>>> On Sat, 15 Oct 2022, Oleksandr Tyshchenko wrote:
>>>>>>>> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>>>>>>>
>>>>>>>> Use the same "xen-grant-dma" device concept for the PCI devices
>>>>>>>> behind device-tree based PCI Host controller, but with one
>>>>>>>> modification.
>>>>>>>> Unlike for platform devices, we cannot use generic IOMMU bindings
>>>>>>>> (iommus property), as we need to support more flexible
>>>>>>>> configuration.
>>>>>>>> The problem is that PCI devices under the single PCI Host
>>>>>>>> controller
>>>>>>>> may have the backends running in different Xen domains and thus
>>>>>>>> have
>>>>>>>> different endpoints ID (backend domains ID).
>>>>>>>>
>>>>>>>> So use generic PCI-IOMMU bindings instead (iommu-map/iommu-map-mask
>>>>>>>> properties) which allows us to describe relationship between PCI
>>>>>>>> devices and backend domains ID properly.
>>>>>>>>
>>>>>>>> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>>>>>>
>>>>>>> Now that I understood the approach and the reasons for it, I can
>>>>>>> review
>>>>>>> the patch :-)
>>>>>>>
>>>>>>> Please add an example of the bindings in the commit message.
>>>>>>>
>>>>>>>
>>>>>>>> ---
>>>>>>>> Slightly RFC. This is needed to support Xen grant mappings for
>>>>>>>> virtio-pci devices
>>>>>>>> on Arm at some point in the future. The Xen toolstack side is not
>>>>>>>> completely ready yet.
>>>>>>>> Here, for PCI devices we use more flexible way to pass backend
>>>>>>>> domid
>>>>>>>> to the guest
>>>>>>>> than for platform devices.
>>>>>>>>
>>>>>>>> Changes V1 -> V2:
>>>>>>>>        - update commit description
>>>>>>>>        - rebase
>>>>>>>>        - rework to use generic PCI-IOMMU bindings instead of generic
>>>>>>>> IOMMU bindings
>>>>>>>>
>>>>>>>> Previous discussion is at:
>>>>>>>> https://urldefense.com/v3/__https://lore.kernel.org/xen-devel/20221006174804.2003029-1-olekstysh@gmail.com/__;!!GF_29dbcQIUBPA!3-vq7Edm3XfKtD5cnNjnOzDQvuo_XrhJ73yH-nPfqOkGGU0IjLG7R7MR_nAJCAPeOutHRLT44wKYwQwz3SauACie_ZAy$
>>>>>>>>
>>>>>>>>
>>>>>>>> [lore[.]kernel[.]org]
>>>>>>>>
>>>>>>>> Based on:
>>>>>>>> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git/log/?h=for-linus-6.1__;!!GF_29dbcQIUBPA!3-vq7Edm3XfKtD5cnNjnOzDQvuo_XrhJ73yH-nPfqOkGGU0IjLG7R7MR_nAJCAPeOutHRLT44wKYwQwz3SauAEnMDHAq$
>>>>>>>>
>>>>>>>>
>>>>>>>> [git[.]kernel[.]org]
>>>>>>>> ---
>>>>>>>>      drivers/xen/grant-dma-ops.c | 87
>>>>>>>> ++++++++++++++++++++++++++++++++-----
>>>>>>>>      1 file changed, 76 insertions(+), 11 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/xen/grant-dma-ops.c
>>>>>>>> b/drivers/xen/grant-dma-ops.c
>>>>>>>> index daa525df7bdc..b79d9d6ce154 100644
>>>>>>>> --- a/drivers/xen/grant-dma-ops.c
>>>>>>>> +++ b/drivers/xen/grant-dma-ops.c
>>>>>>>> @@ -10,6 +10,7 @@
>>>>>>>>      #include <linux/module.h>
>>>>>>>>      #include <linux/dma-map-ops.h>
>>>>>>>>      #include <linux/of.h>
>>>>>>>> +#include <linux/pci.h>
>>>>>>>>      #include <linux/pfn.h>
>>>>>>>>      #include <linux/xarray.h>
>>>>>>>>      #include <linux/virtio_anchor.h>
>>>>>>>> @@ -292,12 +293,55 @@ static const struct dma_map_ops
>>>>>>>> xen_grant_dma_ops = {
>>>>>>>>          .dma_supported = xen_grant_dma_supported,
>>>>>>>>      };
>>>>>>>>      +static struct device_node *xen_dt_get_pci_host_node(struct
>>>>>>>> device
>>>>>>>> *dev)
>>>>>>>> +{
>>>>>>>> +    struct pci_dev *pdev = to_pci_dev(dev);
>>>>>>>> +    struct pci_bus *bus = pdev->bus;
>>>>>>>> +
>>>>>>>> +    /* Walk up to the root bus to look for PCI Host controller */
>>>>>>>> +    while (!pci_is_root_bus(bus))
>>>>>>>> +        bus = bus->parent;
>>>>>>>> +
>>>>>>>> +    return of_node_get(bus->bridge->parent->of_node);
>>>>>>>> +}
>>>>>>>
>>>>>>> It seems silly that we need to walk the hierachy that way, but I
>>>>>>> couldn't find another way to do it
>>>>>>>
>>>>>>>
>>>>>>>> +static struct device_node *xen_dt_get_node(struct device *dev)
>>>>>>>> +{
>>>>>>>> +    if (dev_is_pci(dev))
>>>>>>>> +        return xen_dt_get_pci_host_node(dev);
>>>>>>>> +
>>>>>>>> +    return of_node_get(dev->of_node);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static int xen_dt_map_id(struct device *dev, struct device_node
>>>>>>>> **iommu_np,
>>>>>>>> +             u32 *sid)
>>>>>>>> +{
>>>>>>>> +    struct pci_dev *pdev = to_pci_dev(dev);
>>>>>>>> +    u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
>>>>>>>> +    struct device_node *host_np;
>>>>>>>> +    int ret;
>>>>>>>> +
>>>>>>>> +    host_np = xen_dt_get_pci_host_node(dev);
>>>>>>>> +    if (!host_np)
>>>>>>>> +        return -ENODEV;
>>>>>>>> +
>>>>>>>> +    ret = of_map_id(host_np, rid, "iommu-map", "iommu-map-mask",
>>>>>>>> iommu_np, sid);
>>>>>>>> +    of_node_put(host_np);
>>>>>>>> +    return ret;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>      static bool xen_is_dt_grant_dma_device(struct device *dev)
>>>>>>>>      {
>>>>>>>> -    struct device_node *iommu_np;
>>>>>>>> +    struct device_node *iommu_np = NULL;
>>>>>>>>          bool has_iommu;
>>>>>>>>      -    iommu_np = of_parse_phandle(dev->of_node, "iommus", 0);
>>>>>>>> +    if (dev_is_pci(dev)) {
>>>>>>>> +        if (xen_dt_map_id(dev, &iommu_np, NULL))
>>>>>>>> +            return false;
>>>>>>>> +    } else
>>>>>>>> +        iommu_np = of_parse_phandle(dev->of_node, "iommus", 0);
>>>>>>>> +
>>>>>>>>          has_iommu = iommu_np &&
>>>>>>>>                  of_device_is_compatible(iommu_np, "xen,grant-dma");
>>>>>>>>          of_node_put(iommu_np);
>>>>>>>> @@ -307,9 +351,17 @@ static bool xen_is_dt_grant_dma_device(struct
>>>>>>>> device *dev)
>>>>>>>>        bool xen_is_grant_dma_device(struct device *dev)
>>>>>>>>      {
>>>>>>>> +    struct device_node *np;
>>>>>>>> +
>>>>>>>>          /* XXX Handle only DT devices for now */
>>>>>>>> -    if (dev->of_node)
>>>>>>>> -        return xen_is_dt_grant_dma_device(dev);
>>>>>>>> +    np = xen_dt_get_node(dev);
>>>>>>>> +    if (np) {
>>>>>>>> +        bool ret;
>>>>>>>> +
>>>>>>>> +        ret = xen_is_dt_grant_dma_device(dev);
>>>>>>>> +        of_node_put(np);
>>>>>>>> +        return ret;
>>>>>>>> +    }
>>>>>>>
>>>>>>> We don't need to walk the PCI hierachy twice. Maybe we can add the
>>>>>>> of_node check directly to xen_is_dt_grant_dma_device?
>>>>>>>
>>>>>>
>>>>>> I think in general we could pass directly the host bridge device if
>>>>>> dev_is_pci(dev) (which can be retrieved with
>>>>>> pci_get_host_bridge_device(to_pci_dev(dev), and after done with it
>>>>>> pci_put_host_bridge_device(phb)).
>>>>>> So that, xen_is_dt_grant_dma_device() and
>>>>>> xen_dt_grant_init_backend_domid() won't need to discover it
>>>>>> themselves.
>>>>>> This will simplify the code.
>>>>>
>>>>>
>>>>> Good point. I have some remark. Can we use pci_find_host_bridge()
>>>>> instead? This way we don't have to add #include "../pci/pci.h", and
>>>>> have
>>>>> to drop reference afterwards.
>>>>>
>>>>> With that xen_dt_get_pci_host_node() will became the following:
>>>>>
>>>>>
>>>>> static struct device_node *xen_dt_get_pci_host_node(struct device
>>>>> *dev)
>>>>> {
>>>>>         struct pci_host_bridge *bridge =
>>>>> pci_find_host_bridge(to_pci_dev(dev)->bus);
>>>>>
>>>>>         return of_node_get(bridge->dev.parent->of_node);
>>>>> }
>>>>>
>>>>
>>>> You are right. I prefer your version instead of the above.
>>>
>>>
>>> ok, thanks
>>>
>>>
>>>>
>>>>
>>>>>
>>>>> With Stefano's suggestion, we won't walk the PCI hierarchy twice when
>>>>> executing xen_is_grant_dma_device() for PCI device:
>>>>>
>>>>> xen_is_grant_dma_device() -> xen_is_dt_grant_dma_device() ->
>>>>> xen_dt_map_id() -> xen_dt_get_pci_host_node()
>>>>>
>>>>>
>>>>> What do you think?
>>>>>
>>>>
>>>> I was thinking passing the device_node along with the device in the
>>>> function arguments. More specifically, of doing this (not tested, just
>>>> an idea):
>>>>
>>>> bool xen_is_grant_dma_device(struct device *dev)
>>>> {
>>>>       struct device_node *np;
>>>>       bool has_iommu = false;
>>>>
>>>>       /* XXX Handle only DT devices for now */
>>>>       np = xen_dt_get_node(dev);
>>>>       if (np)
>>>>           has_iommu = xen_is_dt_grant_dma_device(dev, np);
>>>>       of_node_put(np);
>>>>       return has_iommu;
>>>> }
>>>>
>>>> static bool xen_is_dt_grant_dma_device(struct device *dev,
>>>>                                          struct device_node *np)
>>>> {
>>>>       struct device_node *iommu_np = NULL;
>>>>       bool has_iommu;
>>>>
>>>>       if (dev_is_pci(dev)) {
>>>>           struct pci_dev *pdev = to_pci_dev(dev);
>>>>       u32 id = PCI_DEVID(pdev->bus->number, pdev->devfn);
>>>>           of_map_id(np, id, "iommu-map", "iommu-map-mask", &iommu_np,
>>>> NULL);
>>>>       } else {
>>>>           iommu_np = of_parse_phandle(np, "iommus", 0);
>>>>       }
>>>>
>>>>       has_iommu = iommu_np && of_device_is_compatible(iommu_np,
>>>> "xen,grant-dma");
>>>>       of_node_put(iommu_np);
>>>>
>>>>       return has_iommu;
>>>> }
>>>
>>>
>>> I got it.
>>>
>>> xen_is_grant_dma_device() for V3 won't call xen_dt_get_node(), but call
>>> xen_is_dt_grant_dma_device() directly.
>>>
>>> static bool xen_is_dt_grant_dma_device(struct device *dev)
>>> {
>>>        struct device_node *iommu_np = NULL;
>>>        bool has_iommu;
>>>
>>>        if (dev_is_pci(dev)) {
>>>            if (xen_dt_map_id(dev, &iommu_np, NULL))
>>>                return false;
>>>        } else if (dev->of_node)
>>>            iommu_np = of_parse_phandle(dev->of_node, "iommus", 0);
>>>        else
>>>            return false;
>>>
>>>        has_iommu = iommu_np &&
>>>                of_device_is_compatible(iommu_np, "xen,grant-dma");
>>>        of_node_put(iommu_np);
>>>
>>>        return has_iommu;
>>> }
>>>
>>> bool xen_is_grant_dma_device(struct device *dev)
>>> {
>>>        /* XXX Handle only DT devices for now */
>>>        return xen_is_dt_grant_dma_device(dev);
>>> }
>>>
>>>
>>
>> Ok. One difference, that I see from the previous, is that here you
>> don't use the dynamic interface when you access the dev->of_node
>> (of_node_get/of_node_put). Before, this was guarded through the
>> external xen_dt_get_node().
>>
>> I suspect that the same needs to be done for the function
>> xen_grant_setup_dma_ops(). There, also, the code walks up to the root
>> bus twice.
> 
> 
> Hmm, xen_dt_grant_init_backend_domid() should only be called if we deal
> with device-tree based device.
> 
> I think you are completely right, thanks!
> 
> In order to address both your comments, I think I need to rework the
> code (taking into the account your example with xen_is_dt_grant_dma_device()
> 
> provided a few letters ago and extrapolate this example to
> xen_dt_grant_init_backend_domid()). Below the patch (not tested) which
> seems to address both your comments (also I dropped
> 
> xen_dt_map_id() and squashed xen_dt_get_pci_host_node() with
> xen_dt_get_node()).
> 
> 
> diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
> index daa525df7bdc..dae24dbd2ef7 100644
> --- a/drivers/xen/grant-dma-ops.c
> +++ b/drivers/xen/grant-dma-ops.c
> @@ -10,6 +10,7 @@
>    #include <linux/module.h>
>    #include <linux/dma-map-ops.h>
>    #include <linux/of.h>
> +#include <linux/pci.h>
>    #include <linux/pfn.h>
>    #include <linux/xarray.h>
>    #include <linux/virtio_anchor.h>
> @@ -292,12 +293,33 @@ static const struct dma_map_ops xen_grant_dma_ops = {
>           .dma_supported = xen_grant_dma_supported,
>    };
> 
> -static bool xen_is_dt_grant_dma_device(struct device *dev)
> +static struct device_node *xen_dt_get_node(struct device *dev)
>    {
> -       struct device_node *iommu_np;
> +       if (dev_is_pci(dev)) {
> +               struct pci_dev *pdev = to_pci_dev(dev);
> +               struct pci_host_bridge *bridge =
> pci_find_host_bridge(pdev->bus);
> +
> +               return of_node_get(bridge->dev.parent->of_node);
> +       }
> +
> +       return of_node_get(dev->of_node);
> +}
> +

It does not seem right to me to expose the struct pci_host_bridge (which 
we would need to check if it is null by the way). I would prefer your 
version for the above i.e
static struct device_node *xen_dt_get_node(struct device *dev)
{
	if (dev_is_pci(dev)) {
		struct pci_bus *bus = to_pci_dev(dev)->bus;

		/* Walk up to the root bus to look for PCI Host controller */
		while (!pci_is_root_bus(bus))
			bus = bus->parent;
		return of_node_get(bus->bridge->parent->of_node);
	}

	return of_node_get(dev->of_node);
}

> +static bool xen_is_dt_grant_dma_device(struct device *dev,
> +                                       struct device_node *np)
> +{
> +       struct device_node *iommu_np = NULL;
>           bool has_iommu;
> 
> -       iommu_np = of_parse_phandle(dev->of_node, "iommus", 0);
> +       if (dev_is_pci(dev)) {
> +               struct pci_dev *pdev = to_pci_dev(dev);
> +               u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
> +
> +               if (of_map_id(np, rid, "iommu-map", "iommu-map-mask",
> &iommu_np, NULL))
> +                       return false;
> +       } else
> +               iommu_np = of_parse_phandle(np, "iommus", 0);
> +
>           has_iommu = iommu_np &&
>                       of_device_is_compatible(iommu_np, "xen,grant-dma");
>           of_node_put(iommu_np);
> @@ -307,9 +329,17 @@ static bool xen_is_dt_grant_dma_device(struct
> device *dev)
> 
>    bool xen_is_grant_dma_device(struct device *dev)
>    {
> +       struct device_node *np;
> +
>           /* XXX Handle only DT devices for now */
> -       if (dev->of_node)
> -               return xen_is_dt_grant_dma_device(dev);
> +       np = xen_dt_get_node(dev);
> +       if (np) {
> +               bool ret;
> +
> +               ret = xen_is_dt_grant_dma_device(dev, np);
> +               of_node_put(np);
> +               return ret;
> +       }
> 
>           return false;
>    }

> @@ -323,14 +353,26 @@ bool xen_virtio_mem_acc(struct virtio_device *dev)
>    }
> 
>    static int xen_dt_grant_init_backend_domid(struct device *dev,
> +                                          struct device_node *np,
>                                              struct xen_grant_dma_data *data)
>    {
> -       struct of_phandle_args iommu_spec;
> +       struct of_phandle_args iommu_spec = { .args_count = 1 };
> 
> -       if (of_parse_phandle_with_args(dev->of_node, "iommus",
> "#iommu-cells",
> -                       0, &iommu_spec)) {
> -               dev_err(dev, "Cannot parse iommus property\n");
> -               return -ESRCH;
> +       if (dev_is_pci(dev)) {
> +               struct pci_dev *pdev = to_pci_dev(dev);
> +               u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
> +
> +               if (of_map_id(np, rid, "iommu-map", "iommu-map-mask",
> &iommu_spec.np,
> +                               iommu_spec.args)) {
> +                       dev_err(dev, "Cannot translate ID\n");
> +                       return -ESRCH;
> +               }
> +       } else {
> +               if (of_parse_phandle_with_args(np, "iommus", "#iommu-cells",
> +                               0, &iommu_spec)) {
> +                       dev_err(dev, "Cannot parse iommus property\n");
> +                       return -ESRCH;
> +               }
>           }
> 

IMO, instead of passing struct xen_grant_dma_data *data to 
xen_dt_grant_init_backend_domid(), you could pass domid_t *backend_domid 
(e.g xen_dt_grant_init_backend_domid(dev, np, &data->backend_domid)).
I think this way the internal struct xen_grant_dma_datain is manipulated 
in a single place and xen_dt_grant_init_backend_domid() does not depend 
on it.

>           if (!of_device_is_compatible(iommu_spec.np, "xen,grant-dma") ||
> @@ -354,6 +396,7 @@ static int xen_dt_grant_init_backend_domid(struct
> device *dev,
>    void xen_grant_setup_dma_ops(struct device *dev)
>    {
>           struct xen_grant_dma_data *data;
> +       struct device_node *np;
> 
>           data = find_xen_grant_dma_data(dev);
>           if (data) {
> @@ -365,8 +408,13 @@ void xen_grant_setup_dma_ops(struct device *dev)
>           if (!data)
>                   goto err;
> 
> -       if (dev->of_node) {
> -               if (xen_dt_grant_init_backend_domid(dev, data))
> +       np = xen_dt_get_node(dev);
> +       if (np) {
> +               int ret;
> +
> +               ret = xen_dt_grant_init_backend_domid(dev, np, data);
> +               of_node_put(np);
> +               if (ret)
>                           goto err;
>           } else if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT)) {
>                   dev_info(dev, "Using dom0 as backend\n");
> 
> 
> Does it look ok now?

That is what I had in mind. I do not know if Stefano agrees with this 
approach.

>>
>>
>>>>
>>>> I 'm wondering ... is it possible for the host bridge device node to
>>>> have the iommus property set? meaning that all of its pci devs will
>>>> have the same backend?
>>>
>>> Good question. I think, it is possible... This is technically what V1 is
>>> doing.
>>>
>>>
>>> Are you asking because to support "iommus" for PCI devices as well to
>>> describe that use-case with all PCI devices having the same endpoint ID
>>> (backend ID)?
>>> If yes, I think, this could be still described by "iommu-map" property,
>>> something like that (if we don't want to describe mapping for each PCI
>>> device one-by-one).
>>>
>>> iommu-map = <0x0 &iommu X 0x1>;
>>>
>>> iommu-map-mask = <0x0>;
>>>
>>> where the X is backend ID.
>>>
>>>
>>> It feels to me that it should be written down somewhere that for
>>> platform devices we expect "iommus" and for PCI devices we expect
>>> "iommu-map/iommu-map-mask" to be present.
>>
>> Thanks for the clarification, now I got it. Yes I agree.
> 
> 
> ok, good
> 
> 
>>
>>>>
>>>>
>>>>>>
>>>>>>>
>>>>>>>>          return false;
>>>>>>>>      }
>>>>>>>> @@ -325,12 +377,19 @@ bool xen_virtio_mem_acc(struct virtio_device
>>>>>>>> *dev)
>>>>>>>>      static int xen_dt_grant_init_backend_domid(struct device *dev,
>>>>>>>>                             struct xen_grant_dma_data *data)
>>>>>>>>      {
>>>>>>>> -    struct of_phandle_args iommu_spec;
>>>>>>>> +    struct of_phandle_args iommu_spec = { .args_count = 1 };
>>>>>>>>      -    if (of_parse_phandle_with_args(dev->of_node, "iommus",
>>>>>>>> "#iommu-cells",
>>>>>>>> -            0, &iommu_spec)) {
>>>>>>>> -        dev_err(dev, "Cannot parse iommus property\n");
>>>>>>>> -        return -ESRCH;
>>>>>>>> +    if (dev_is_pci(dev)) {
>>>>>>>> +        if (xen_dt_map_id(dev, &iommu_spec.np, iommu_spec.args)) {
>>>>>>>> +            dev_err(dev, "Cannot translate ID\n");
>>>>>>>> +            return -ESRCH;
>>>>>>>> +        }
>>>>>>>> +    } else {
>>>>>>>> +        if (of_parse_phandle_with_args(dev->of_node, "iommus",
>>>>>>>> "#iommu-cells",
>>>>>>>> +                0, &iommu_spec)) {
>>>>>>>> +            dev_err(dev, "Cannot parse iommus property\n");
>>>>>>>> +            return -ESRCH;
>>>>>>>> +        }
>>>>>>>>          }
>>>>>>>>            if (!of_device_is_compatible(iommu_spec.np,
>>>>>>>> "xen,grant-dma") ||
>>>>>>>> @@ -354,6 +413,7 @@ static int
>>>>>>>> xen_dt_grant_init_backend_domid(struct device *dev,
>>>>>>>>      void xen_grant_setup_dma_ops(struct device *dev)
>>>>>>>>      {
>>>>>>>>          struct xen_grant_dma_data *data;
>>>>>>>> +    struct device_node *np;
>>>>>>>>            data = find_xen_grant_dma_data(dev);
>>>>>>>>          if (data) {
>>>>>>>> @@ -365,8 +425,13 @@ void xen_grant_setup_dma_ops(struct device
>>>>>>>> *dev)
>>>>>>>>          if (!data)
>>>>>>>>              goto err;
>>>>>>>>      -    if (dev->of_node) {
>>>>>>>> -        if (xen_dt_grant_init_backend_domid(dev, data))
>>>>>>>> +    np = xen_dt_get_node(dev);
>>>>>>>> +    if (np) {
>>>>>>>> +        int ret;
>>>>>>>> +
>>>>>>>> +        ret = xen_dt_grant_init_backend_domid(dev, data);
>>>>>>>> +        of_node_put(np);
>>>>>>>> +        if (ret)
>>>>>>>>                  goto err;
>>>>>>>>          } else if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT)) {
>>>>>>>>              dev_info(dev, "Using dom0 as backend\n");
>>>>>>>> -- 
>>>>>>>> 2.25.1
>>>>>>>>
>>>>>>>
>>>>>>
>>>>
>>

-- 
Xenia
