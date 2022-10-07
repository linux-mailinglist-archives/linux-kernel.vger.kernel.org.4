Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5705F749B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 09:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiJGHPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 03:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiJGHPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 03:15:18 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25D84E636
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 00:15:11 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id u21so5787013edi.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 00:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VdPP7ZbynXA6QuugzlRWuE4AJslI1k9PX+cmlWKyz7c=;
        b=jyPS84BTRcfJudXidSokxeG1ZdD37ZyQXS0gnxY8B3oVOQT0BKEIbeFVYQF33lL80B
         sV+DQ66TiyHvEC+3V401219cQu3R5Q1p2oSS8eWe6Rb68NR9jDw5jdnkyyVuZToAV1tj
         U4bk7ayCpi0ARbeJPV7RxH72YIFEqY7DkjXUgbeD1omF35vP3Hg4lk938r28ATLG/ACi
         vPxgkN1TUV8k8BdcPFYSMD/FTSrCfwa1TW6L7mFQpYotWD90Z3FVCX7R9cRjFkMj7r+r
         n9PUVpkY7/CjRJfNXK/bbog0XTd/qGYoApiDn73Abwst/SWZWigsd7GyH+j6rdJP4g9T
         D5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VdPP7ZbynXA6QuugzlRWuE4AJslI1k9PX+cmlWKyz7c=;
        b=fLCiLDPKyWJHh4Kf+Rw8+LBb7MflNmTBEObsfD8YT7te3h9IJBjdhDC04MZ6qL8fq8
         YPSovff0dCjBZwSSPwwCIgAbOVgZyQ89kPjmctMhDmVkyTsTE0dUwdZEU781d41JK51G
         1MHVkLsNF8qFsms1NlYic2eBIMWDymkWeLI8btPTeYKCWF8eZhbAtcGW0d9dHH1f4myN
         OpZ4SH8uFQui+oe0kIKHYfUarjKKvvW1ouzbRk33m+GdriD0vgdBGL1O8soVLIUzE7P4
         Yqs0lkBO1demg0yaHS9tIE3HkLdUGar6JacdyBEFwuD1cAHthSYimoOcOrq+CqVImVDR
         FaUw==
X-Gm-Message-State: ACrzQf2xN/FmTJhga6IBuVfGF3hFIt1rFHbvyBiksa7OozJuJBTfq7kX
        i+LNAzUZjtCH/tfSUy/xfus=
X-Google-Smtp-Source: AMsMyM7nE+3Y9YT3ZoUjnjechzTKdx8lPadALD1ODlJcHowSJch/AthJdJzGNUn/mHrKtMp3uWBksg==
X-Received: by 2002:a05:6402:1cc5:b0:453:ed3f:6a38 with SMTP id ds5-20020a0564021cc500b00453ed3f6a38mr3258525edb.346.1665126909391;
        Fri, 07 Oct 2022 00:15:09 -0700 (PDT)
Received: from [192.168.1.93] (adsl-75.176.58.241.tellas.gr. [176.58.241.75])
        by smtp.gmail.com with ESMTPSA id kx18-20020a170907775200b0073ae9ba9ba8sm792356ejc.3.2022.10.07.00.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 00:15:09 -0700 (PDT)
Message-ID: <7f54bdab-c68f-0d38-93f4-007408151f01@gmail.com>
Date:   Fri, 7 Oct 2022 10:15:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] xen/virtio: Convert PAGE_SIZE/PAGE_SHIFT/PFN_UP to Xen
 counterparts
Content-Language: en-US
To:     Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>
References: <20221006120912.1948459-1-olekstysh@gmail.com>
 <96a16b32-0950-b538-65e5-9955ed8cc529@gmail.com>
 <b3b8047e-b4a5-1e75-2a55-a7beecf8ca7d@epam.com>
From:   Xenia Ragiadakou <burzalodowa@gmail.com>
In-Reply-To: <b3b8047e-b4a5-1e75-2a55-a7beecf8ca7d@epam.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/7/22 00:13, Oleksandr Tyshchenko wrote:

Hi Oleksandr

> 
> On 06.10.22 20:59, Xenia Ragiadakou wrote:
> 
> Hello Xenia
> 
>>
>> On 10/6/22 15:09, Oleksandr Tyshchenko wrote:
>>> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>>
>>> Although XEN_PAGE_SIZE is equal to PAGE_SIZE (4KB) for now, it would
>>> be more correct to use Xen specific #define-s as XEN_PAGE_SIZE can
>>> be changed at some point in the future.
>>>
>>> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>> ---
>>> Cc: Juergen Gross <jgross@suse.com>
>>> Cc: Xenia Ragiadakou <burzalodowa@gmail.com>
>>>
>>> As it was proposed at:
>>> https://urldefense.com/v3/__https://lore.kernel.org/xen-devel/20221005174823.1800761-1-olekstysh@gmail.com/__;!!GF_29dbcQIUBPA!zHt-xZ_7tZc_EM6zva21E_YgwIiEeimFWfsJIpPwAu-TBcnzQhXHqlKzmXmwIcI6uIx_arHNZiaZeHt_428_8p-DyMpd$
>>> [lore[.]kernel[.]org]
>>>
>>> Should go in only after that series.
>>> ---
>>>    drivers/xen/grant-dma-ops.c | 20 ++++++++++----------
>>>    1 file changed, 10 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
>>> index c66f56d24013..5392fdc25dca 100644
>>> --- a/drivers/xen/grant-dma-ops.c
>>> +++ b/drivers/xen/grant-dma-ops.c
>>> @@ -31,12 +31,12 @@ static DEFINE_XARRAY_FLAGS(xen_grant_dma_devices,
>>> XA_FLAGS_LOCK_IRQ);
>>>      static inline dma_addr_t grant_to_dma(grant_ref_t grant)
>>>    {
>>> -    return XEN_GRANT_DMA_ADDR_OFF | ((dma_addr_t)grant << PAGE_SHIFT);
>>> +    return XEN_GRANT_DMA_ADDR_OFF | ((dma_addr_t)grant <<
>>> XEN_PAGE_SHIFT);
>>>    }
>>
>> With this change, can the offset added to the dma handle, generated by
>> grant_to_dma(), be the offset in the page? Couldn't it corrupt the
>> grant ref?
> 
> 
> Good point, indeed, I think it could corrupt if guest uses a different
> than Xen page granularity (i.e 64KB).
> 
> 
>>
>>>      static inline grant_ref_t dma_to_grant(dma_addr_t dma)
>>>    {
>>> -    return (grant_ref_t)((dma & ~XEN_GRANT_DMA_ADDR_OFF) >>
>>> PAGE_SHIFT);
>>> +    return (grant_ref_t)((dma & ~XEN_GRANT_DMA_ADDR_OFF) >>
>>> XEN_PAGE_SHIFT);
>>>    }
>>>      static struct xen_grant_dma_data *find_xen_grant_dma_data(struct
>>> device *dev)
>>> @@ -79,7 +79,7 @@ static void *xen_grant_dma_alloc(struct device
>>> *dev, size_t size,
>>>                     unsigned long attrs)
>>>    {
>>>        struct xen_grant_dma_data *data;
>>> -    unsigned int i, n_pages = PFN_UP(size);
>>> +    unsigned int i, n_pages = XEN_PFN_UP(size);
>>>        unsigned long pfn;
>>>        grant_ref_t grant;
>>>        void *ret;
>>> @@ -91,14 +91,14 @@ static void *xen_grant_dma_alloc(struct device
>>> *dev, size_t size,
>>>        if (unlikely(data->broken))
>>>            return NULL;
>>>    -    ret = alloc_pages_exact(n_pages * PAGE_SIZE, gfp);
>>> +    ret = alloc_pages_exact(n_pages * XEN_PAGE_SIZE, gfp);
>>>        if (!ret)
>>>            return NULL;
>>>          pfn = virt_to_pfn(ret);
>>>          if (gnttab_alloc_grant_reference_seq(n_pages, &grant)) {
>>> -        free_pages_exact(ret, n_pages * PAGE_SIZE);
>>> +        free_pages_exact(ret, n_pages * XEN_PAGE_SIZE);
>>>            return NULL;
>>>        }
>>>    @@ -116,7 +116,7 @@ static void xen_grant_dma_free(struct device
>>> *dev, size_t size, void *vaddr,
>>>                       dma_addr_t dma_handle, unsigned long attrs)
>>>    {
>>>        struct xen_grant_dma_data *data;
>>> -    unsigned int i, n_pages = PFN_UP(size);
>>> +    unsigned int i, n_pages = XEN_PFN_UP(size);
>>>        grant_ref_t grant;
>>>          data = find_xen_grant_dma_data(dev);
>>> @@ -138,7 +138,7 @@ static void xen_grant_dma_free(struct device
>>> *dev, size_t size, void *vaddr,
>>>          gnttab_free_grant_reference_seq(grant, n_pages);
>>>    -    free_pages_exact(vaddr, n_pages * PAGE_SIZE);
>>> +    free_pages_exact(vaddr, n_pages * XEN_PAGE_SIZE);
>>>    }
>>>      static struct page *xen_grant_dma_alloc_pages(struct device *dev,
>>> size_t size,
>>> @@ -168,7 +168,7 @@ static dma_addr_t xen_grant_dma_map_page(struct
>>> device *dev, struct page *page,
>>>                         unsigned long attrs)
>>>    {
>>>        struct xen_grant_dma_data *data;
>>> -    unsigned int i, n_pages = PFN_UP(offset + size);
>>> +    unsigned int i, n_pages = XEN_PFN_UP(offset + size);
>>
>> The offset, here, refers to the offset in the page ...
>>
>>>        grant_ref_t grant;
>>>        dma_addr_t dma_handle;
>>>    @@ -200,8 +200,8 @@ static void xen_grant_dma_unmap_page(struct
>>> device *dev, dma_addr_t dma_handle,
>>>                         unsigned long attrs)
>>>    {
>>>        struct xen_grant_dma_data *data;
>>> -    unsigned long offset = dma_handle & (PAGE_SIZE - 1);
>>> -    unsigned int i, n_pages = PFN_UP(offset + size);
>>> +    unsigned long offset = dma_handle & ~XEN_PAGE_MASK;
>>
>> ... while, here, it refers to the offset in the grant.
>> So, the calculated number of grants may differ.
> 
> Good point, I think you are right, so we need to additionally use
> xen_offset_in_page() macro in xen_grant_dma_map_page(),
> 
> something like that to be squashed with current patch:
> 
> 
> diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
> index 9d5eca6d638a..bb984dc05deb 100644
> --- a/drivers/xen/grant-dma-ops.c
> +++ b/drivers/xen/grant-dma-ops.c
> @@ -169,7 +169,7 @@ static dma_addr_t xen_grant_dma_map_page(struct
> device *dev, struct page *page,
>                                            unsigned long attrs)
>    {
>           struct xen_grant_dma_data *data;
> -       unsigned int i, n_pages = XEN_PFN_UP(offset + size);
> +       unsigned int i, n_pages = XEN_PFN_UP(xen_offset_in_page(offset)
> + size);
>           grant_ref_t grant;
>           dma_addr_t dma_handle;
> 
> @@ -191,7 +191,7 @@ static dma_addr_t xen_grant_dma_map_page(struct
> device *dev, struct page *page,
>                                   xen_page_to_gfn(page) + i, dir ==
> DMA_TO_DEVICE);
>           }
> 
> -       dma_handle = grant_to_dma(grant) + offset;
> +       dma_handle = grant_to_dma(grant) + xen_offset_in_page(offset);
> 
>           return dma_handle;
>    }
> 
> Did I get your point right?
> 

I think it 's more complicated than that.
Let's say that the offset in page is > XEN_PAGE_SIZE, then the 
calculation of the number of grants won't take into account the part of 
the offset that is multiple of the XEN_PAGE_SIZE i.e it will calculate 
only the strictly necessary number of grants.
But xen_grant_dma_map_page() grants access to the whole page because, as 
it can be observed in the code snippet below, it does not take into 
account the page offset.

for (i = 0; i < n_pages; i++) {
   gnttab_grant_foreign_access_ref(grant + i, data->backend_domid, 
xen_page_to_gfn(page) + i, dir == DMA_TO_DEVICE);
}

>>
>>
>>> +    unsigned int i, n_pages = XEN_PFN_UP(offset + size);
>>>        grant_ref_t grant;
>>>          if (WARN_ON(dir == DMA_NONE))
>>
> 
> Thank you.
> 
> 

-- 
Xenia
