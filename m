Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EED5F7E7A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 22:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiJGUIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 16:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJGUI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 16:08:29 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17DF12C888
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 13:08:27 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id kg6so13522246ejc.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 13:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HBOe/w/Fu0j7MLMffzEkPrMeW/s5zdVs37pyRRTl5iM=;
        b=W6KR0cMugR1UnP1CCQZ3ASDqHQevdVexZ5nEPTpqCd9GiwmioTuqxaoR8OgmdgchWg
         CEbftxa2u3449IKL4hrII/xSDA6yMkUFwz3VW/z/KsAS9QExPe6K/kuawP7MzCuQwKZs
         JkFEA1Fj465vF2JpaxCWiGA2mrgugUUODqNfPXxPOk34FhJn4+XKQ6yNqhx6hPnURrql
         hEvavDxgq5VbcnASqSXacN3RY3ggUdA5yufsITuR8Djni/4jpXLEyuAOvL5LJGQNtaJJ
         UqHLojdK8IJUKj6IQaYFJV0BJnAchhp3Sgz2WNebYj88SZrqG6jVA5LKHTGVU1aZWLVE
         giMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HBOe/w/Fu0j7MLMffzEkPrMeW/s5zdVs37pyRRTl5iM=;
        b=lRoc2p8eNV+NwM7OGxGJ4MlfjsOkLH6bIy8jBXmHl+62SxG4le5y1yILMZ5Qk5X2Ws
         u+y+lAls1OABfBF5X6SKUfatMv+8brJa0xoP6Ig8Y0dJ0k8HwcDp8ro2azqBDVkmdzca
         sgLKTpNEdHThlPUE33I0c7jmGIcfOW+CF4JZHxzlylHLiUYFYgDWxVnN25xhiv2vktbi
         PZqqIwoGNXoLGah1GN/EQuQS5hcUd5KKunz8B4FGnCvRFm+jTycSVQ9nXYcBdzj8JmpG
         KBTeK9kOZlSaUXmG14vgI2hzndiigSc7ttXt1rsBzpfC5yCRKAgXJMja3Ru7JlZtEU81
         6Dcw==
X-Gm-Message-State: ACrzQf3ipcPtSHntHeC1YRvZY7zAyywfNckKouYK+872so7OFsIDbkUt
        bg5c/McXeGlpNkVImMxbSx8=
X-Google-Smtp-Source: AMsMyM5tCMXYlhiuVdVI/TXN6k/EOqIbQBcV4m5rKvXyXqoxlumh/2KamC4uSAzbG1P3upXmtcCfxA==
X-Received: by 2002:a17:907:6d03:b0:782:abba:936c with SMTP id sa3-20020a1709076d0300b00782abba936cmr5438080ejc.758.1665173306030;
        Fri, 07 Oct 2022 13:08:26 -0700 (PDT)
Received: from [192.168.1.93] (adsl-75.176.58.241.tellas.gr. [176.58.241.75])
        by smtp.gmail.com with ESMTPSA id 27-20020a170906059b00b0077ab3ca93efsm1619051ejn.223.2022.10.07.13.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 13:08:25 -0700 (PDT)
Message-ID: <a7d21774-ec30-fa8b-e607-c8b4d43cd0ae@gmail.com>
Date:   Fri, 7 Oct 2022 23:08:24 +0300
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
 <7f54bdab-c68f-0d38-93f4-007408151f01@gmail.com>
 <816da52a-f646-c114-fa6d-9320152a0e79@epam.com>
 <677bc264-c507-3bed-6d51-0d010a0dd449@gmail.com>
 <ab4ef342-5982-6e0e-7859-eaab026d48a4@epam.com>
 <55d9f368-bf20-5439-e821-04c7709cb9a5@epam.com>
From:   Xenia Ragiadakou <burzalodowa@gmail.com>
In-Reply-To: <55d9f368-bf20-5439-e821-04c7709cb9a5@epam.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/7/22 20:35, Oleksandr Tyshchenko wrote:

Hi Oleksandr

>>>>>>> On 10/6/22 15:09, Oleksandr Tyshchenko wrote:
>>>>>>>> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>>>>>>>
>>>>>>>> Although XEN_PAGE_SIZE is equal to PAGE_SIZE (4KB) for now, it
>>>>>>>> would
>>>>>>>> be more correct to use Xen specific #define-s as XEN_PAGE_SIZE can
>>>>>>>> be changed at some point in the future.
>>>>>>>>
>>>>>>>> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>>>>>>> ---
>>>>>>>> Cc: Juergen Gross <jgross@suse.com>
>>>>>>>> Cc: Xenia Ragiadakou <burzalodowa@gmail.com>
>>>>>>>>
>>>>>>>> As it was proposed at:
>>>>>>>> https://urldefense.com/v3/__https://lore.kernel.org/xen-devel/20221005174823.1800761-1-olekstysh@gmail.com/__;!!GF_29dbcQIUBPA!zHt-xZ_7tZc_EM6zva21E_YgwIiEeimFWfsJIpPwAu-TBcnzQhXHqlKzmXmwIcI6uIx_arHNZiaZeHt_428_8p-DyMpd$
>>>>>>>>
>>>>>>>>
>>>>>>>> [lore[.]kernel[.]org]
>>>>>>>>
>>>>>>>> Should go in only after that series.
>>>>>>>> ---
>>>>>>>>      drivers/xen/grant-dma-ops.c | 20 ++++++++++----------
>>>>>>>>      1 file changed, 10 insertions(+), 10 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/xen/grant-dma-ops.c
>>>>>>>> b/drivers/xen/grant-dma-ops.c
>>>>>>>> index c66f56d24013..5392fdc25dca 100644
>>>>>>>> --- a/drivers/xen/grant-dma-ops.c
>>>>>>>> +++ b/drivers/xen/grant-dma-ops.c
>>>>>>>> @@ -31,12 +31,12 @@ static
>>>>>>>> DEFINE_XARRAY_FLAGS(xen_grant_dma_devices,
>>>>>>>> XA_FLAGS_LOCK_IRQ);
>>>>>>>>        static inline dma_addr_t grant_to_dma(grant_ref_t grant)
>>>>>>>>      {
>>>>>>>> -    return XEN_GRANT_DMA_ADDR_OFF | ((dma_addr_t)grant <<
>>>>>>>> PAGE_SHIFT);
>>>>>>>> +    return XEN_GRANT_DMA_ADDR_OFF | ((dma_addr_t)grant <<
>>>>>>>> XEN_PAGE_SHIFT);
>>>>>>>>      }
>>>>>>>
>>>>>>> With this change, can the offset added to the dma handle,
>>>>>>> generated by
>>>>>>> grant_to_dma(), be the offset in the page? Couldn't it corrupt the
>>>>>>> grant ref?
>>>>>>
>>>>>>
>>>>>> Good point, indeed, I think it could corrupt if guest uses a
>>>>>> different
>>>>>> than Xen page granularity (i.e 64KB).
>>>>>>
>>>>>>
>>>>>>>
>>>>>>>>        static inline grant_ref_t dma_to_grant(dma_addr_t dma)
>>>>>>>>      {
>>>>>>>> -    return (grant_ref_t)((dma & ~XEN_GRANT_DMA_ADDR_OFF) >>
>>>>>>>> PAGE_SHIFT);
>>>>>>>> +    return (grant_ref_t)((dma & ~XEN_GRANT_DMA_ADDR_OFF) >>
>>>>>>>> XEN_PAGE_SHIFT);
>>>>>>>>      }
>>>>>>>>        static struct xen_grant_dma_data
>>>>>>>> *find_xen_grant_dma_data(struct
>>>>>>>> device *dev)
>>>>>>>> @@ -79,7 +79,7 @@ static void *xen_grant_dma_alloc(struct device
>>>>>>>> *dev, size_t size,
>>>>>>>>                       unsigned long attrs)
>>>>>>>>      {
>>>>>>>>          struct xen_grant_dma_data *data;
>>>>>>>> -    unsigned int i, n_pages = PFN_UP(size);
>>>>>>>> +    unsigned int i, n_pages = XEN_PFN_UP(size);
>>>>>>>>          unsigned long pfn;
>>>>>>>>          grant_ref_t grant;
>>>>>>>>          void *ret;
>>>>>>>> @@ -91,14 +91,14 @@ static void *xen_grant_dma_alloc(struct device
>>>>>>>> *dev, size_t size,
>>>>>>>>          if (unlikely(data->broken))
>>>>>>>>              return NULL;
>>>>>>>>      -    ret = alloc_pages_exact(n_pages * PAGE_SIZE, gfp);
>>>>>>>> +    ret = alloc_pages_exact(n_pages * XEN_PAGE_SIZE, gfp);
>>>>>>>>          if (!ret)
>>>>>>>>              return NULL;
>>>>>>>>            pfn = virt_to_pfn(ret);
>>>>>>>>            if (gnttab_alloc_grant_reference_seq(n_pages, &grant)) {
>>>>>>>> -        free_pages_exact(ret, n_pages * PAGE_SIZE);
>>>>>>>> +        free_pages_exact(ret, n_pages * XEN_PAGE_SIZE);
>>>>>>>>              return NULL;
>>>>>>>>          }
>>>>>>>>      @@ -116,7 +116,7 @@ static void xen_grant_dma_free(struct
>>>>>>>> device
>>>>>>>> *dev, size_t size, void *vaddr,
>>>>>>>>                         dma_addr_t dma_handle, unsigned long attrs)
>>>>>>>>      {
>>>>>>>>          struct xen_grant_dma_data *data;
>>>>>>>> -    unsigned int i, n_pages = PFN_UP(size);
>>>>>>>> +    unsigned int i, n_pages = XEN_PFN_UP(size);
>>>>>>>>          grant_ref_t grant;
>>>>>>>>            data = find_xen_grant_dma_data(dev);
>>>>>>>> @@ -138,7 +138,7 @@ static void xen_grant_dma_free(struct device
>>>>>>>> *dev, size_t size, void *vaddr,
>>>>>>>>            gnttab_free_grant_reference_seq(grant, n_pages);
>>>>>>>>      -    free_pages_exact(vaddr, n_pages * PAGE_SIZE);
>>>>>>>> +    free_pages_exact(vaddr, n_pages * XEN_PAGE_SIZE);
>>>>>>>>      }
>>>>>>>>        static struct page *xen_grant_dma_alloc_pages(struct
>>>>>>>> device *dev,
>>>>>>>> size_t size,
>>>>>>>> @@ -168,7 +168,7 @@ static dma_addr_t xen_grant_dma_map_page(struct
>>>>>>>> device *dev, struct page *page,
>>>>>>>>                           unsigned long attrs)
>>>>>>>>      {
>>>>>>>>          struct xen_grant_dma_data *data;
>>>>>>>> -    unsigned int i, n_pages = PFN_UP(offset + size);
>>>>>>>> +    unsigned int i, n_pages = XEN_PFN_UP(offset + size);
>>>>>>>
>>>>>>> The offset, here, refers to the offset in the page ...
>>>>>>>
>>>>>>>>          grant_ref_t grant;
>>>>>>>>          dma_addr_t dma_handle;
>>>>>>>>      @@ -200,8 +200,8 @@ static void xen_grant_dma_unmap_page(struct
>>>>>>>> device *dev, dma_addr_t dma_handle,
>>>>>>>>                           unsigned long attrs)
>>>>>>>>      {
>>>>>>>>          struct xen_grant_dma_data *data;
>>>>>>>> -    unsigned long offset = dma_handle & (PAGE_SIZE - 1);
>>>>>>>> -    unsigned int i, n_pages = PFN_UP(offset + size);
>>>>>>>> +    unsigned long offset = dma_handle & ~XEN_PAGE_MASK;
>>>>>>>
>>>>>>> ... while, here, it refers to the offset in the grant.
>>>>>>> So, the calculated number of grants may differ.
>>>>>>
>>>>>> Good point, I think you are right, so we need to additionally use
>>>>>> xen_offset_in_page() macro in xen_grant_dma_map_page(),
>>>>>>
>>>>>> something like that to be squashed with current patch:
>>>>>>
>>>>>>
>>>>>> diff --git a/drivers/xen/grant-dma-ops.c
>>>>>> b/drivers/xen/grant-dma-ops.c
>>>>>> index 9d5eca6d638a..bb984dc05deb 100644
>>>>>> --- a/drivers/xen/grant-dma-ops.c
>>>>>> +++ b/drivers/xen/grant-dma-ops.c
>>>>>> @@ -169,7 +169,7 @@ static dma_addr_t xen_grant_dma_map_page(struct
>>>>>> device *dev, struct page *page,
>>>>>>                                              unsigned long attrs)
>>>>>>      {
>>>>>>             struct xen_grant_dma_data *data;
>>>>>> -       unsigned int i, n_pages = XEN_PFN_UP(offset + size);
>>>>>> +       unsigned int i, n_pages =
>>>>>> XEN_PFN_UP(xen_offset_in_page(offset)
>>>>>> + size);
>>>>>>             grant_ref_t grant;
>>>>>>             dma_addr_t dma_handle;
>>>>>>
>>>>>> @@ -191,7 +191,7 @@ static dma_addr_t xen_grant_dma_map_page(struct
>>>>>> device *dev, struct page *page,
>>>>>>                                     xen_page_to_gfn(page) + i, dir ==
>>>>>> DMA_TO_DEVICE);
>>>>>>             }
>>>>>>
>>>>>> -       dma_handle = grant_to_dma(grant) + offset;
>>>>>> +       dma_handle = grant_to_dma(grant) +
>>>>>> xen_offset_in_page(offset);
>>>>>>
>>>>>>             return dma_handle;
>>>>>>      }
>>>>>>
>>>>>> Did I get your point right?
>>>>>>
>>>>>
>>>>> I think it 's more complicated than that.
>>>>> Let's say that the offset in page is > XEN_PAGE_SIZE, then the
>>>>> calculation of the number of grants won't take into account the part
>>>>> of the offset that is multiple of the XEN_PAGE_SIZE i.e it will
>>>>> calculate only the strictly necessary number of grants.
>>>>> But xen_grant_dma_map_page() grants access to the whole page because,
>>>>> as it can be observed in the code snippet below, it does not take into
>>>>> account the page offset.
>>>>>
>>>>> for (i = 0; i < n_pages; i++) {
>>>>>     gnttab_grant_foreign_access_ref(grant + i, data->backend_domid,
>>>>> xen_page_to_gfn(page) + i, dir == DMA_TO_DEVICE);
>>>>> }
>>>>
>>>>
>>>> Thanks, valid point. Agree it's indeed more complicated. I will comment
>>>> on that later. I have just pushed another fix, it is not related to
>>>> XEN_PAGE_SIZE directly, but also about page offset > PAGE_SIZE
>>>>
>>>
>>> I got a little bit confused with the order that the patches will be
>>> applied :)
>>
>> This series should go in the first [1]:
>>
>> Current patch depends on it and new patch [2] also depends on it. I
>> think (but might mistake) that current patch we need/want to postpone
>> (because it doesn't fix/improve something immediately, but more for
>> future use-cases),
>>
>> but the new patch is a fix for the real situation. Once we decide with
>> new patch [2] we will be able to return to the current patch and
>> rebase it.
>>
>>
>> [1]
>> https://lore.kernel.org/xen-devel/20221005174823.1800761-1-olekstysh@gmail.com/
>>
>> [2]
>> https://lore.kernel.org/xen-devel/20221007132736.2275574-1-olekstysh@gmail.com/
>>
>>
>>
>>> IIUC the above scenario cannot happen, i.e the offset to be >
>>> PAGE_SIZE, because this callback is used to map for transfer a
>>> portion of a single page.
>>
>> It happens. I have rechecked that. And can provide some debug prints
>> if needed.
> 
> 
> This is the print in xen_grant_dma_map_page() which is only triggers if
> passed offset > PAGE_SIZE (I applied it on top of [2])
> 
> @@ -195,6 +195,12 @@ static dma_addr_t xen_grant_dma_map_page(struct
> device *dev, struct page *page,
> 
>           dma_handle = grant_to_dma(grant) + dma_offset;
> 
> +       if (offset > PAGE_SIZE) {
> +               printk("%s[%d] dma_handle 0x%llx: offset 0x%lx
> (dma_offset 0x%lx gfn_offset 0x%lx) size 0x%lx n_pages %d\n", __func__,
> __LINE__,
> +                               dma_handle, offset, dma_offset,
> gfn_offset, size, n_pages);
> +               WARN_ON(1);
> +       }
> +
>           return dma_handle;
>    }
> 
> 
> At the runtime we have, for example:
> 
> [   10.277599] xen_grant_dma_map_page[199] dma_handle
> 0x8000000000044aa8: offset 0x3aa8 (dma_offset 0xaa8 gfn_offset 0x3) size
> 0x3a0 n_pages 1
> 
> [   10.277695] ------------[ cut here ]------------
> [   10.277715] WARNING: CPU: 3 PID: 122 at
> drivers/xen/grant-dma-ops.c:201 xen_grant_dma_map_page+0x194/0x1a0
> [   10.277757] Modules linked in:
> [   10.277779] CPU: 3 PID: 122 Comm: kworker/u8:6 Tainted: G        W
> 6.0.0-rc7-yocto-standard-00352-g0c5e442382bb-dirty #1
> [   10.277823] Hardware name: XENVM-4.17 (DT)
> [   10.277840] Workqueue: rpciod rpc_async_schedule
> [   10.277870] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS
> BTYPE=--)
> [   10.277897] pc : xen_grant_dma_map_page+0x194/0x1a0
> [   10.277920] lr : xen_grant_dma_map_page+0x194/0x1a0
> [   10.477036] sp : ffff800009eb34a0
> [   10.477068] x29: ffff800009eb34b0 x28: ffff0001c1e0c600 x27:
> ffff0001c0bb3f00
> [   10.477116] x26: 0000000000003aa8 x25: ffff0001c0fbab80 x24:
> fffffc0000000000
> [   10.477167] x23: 0000000000000003 x22: 0000000000000001 x21:
> 0000000000000001
> [   10.477215] x20: fffffc0007048800 x19: 8000000000044aa8 x18:
> 0000000000000010
> [   10.477265] x17: 657366666f203a38 x16: 00000000deadbeef x15:
> 3030303030303878
> [   10.477311] x14: 00000000000005d5 x13: ffff0001c0fbafe0 x12:
> 00000000ffffffea
> [   10.477361] x11: 00000000ffffefff x10: 00000000ffffefff x9 :
> ffff80000969acc0
> [   10.477407] x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 :
> 000000000000bff4
> [   10.477459] x5 : 0000000000057fa8 x4 : 0000000000000000 x3 :
> ffff800009eb3238
> [   10.477507] x2 : acd9abf2a61fc800 x1 : 0000000000000000 x0 :
> 000000000000007f
> [   10.477554] Call trace:
> [   10.477570]  xen_grant_dma_map_page+0x194/0x1a0
> [   10.477608]  dma_map_page_attrs+0x1d4/0x230
> [   10.477638]  vring_map_one_sg+0x60/0x70
> [   10.477668]  virtqueue_add_outbuf+0x248/0x780
> [   10.477705]  start_xmit+0x1d0/0x518
> [   10.477734]  dev_hard_start_xmit+0x98/0x158
> [   10.477767]  sch_direct_xmit+0xec/0x378
> [   10.477795]  __dev_queue_xmit+0x5b8/0xc50
> [   10.477820]  ip_finish_output2+0x234/0x560
> [   10.477853]  __ip_finish_output+0xac/0x268
> [   10.477878]  ip_output+0xfc/0x1b0
> [   10.477905]  ip_local_out+0x48/0x60
> [   10.477934]  __ip_queue_xmit+0x140/0x3c8
> [   10.477960]  ip_queue_xmit+0x14/0x20
> [   10.477986]  __tcp_transmit_skb+0x480/0xad0
> [   10.478014]  tcp_write_xmit+0x5dc/0x1048
> [   10.478045]  __tcp_push_pending_frames+0x3c/0xc8
> [   10.478077]  __tcp_sock_set_cork.part.0+0x60/0x70
> [   10.478113]  tcp_sock_set_cork+0x50/0x68
> [   10.478141]  xs_tcp_send_request+0x1d0/0x248
> [   10.478174]  xprt_transmit+0x154/0x298
> [   10.478206]  call_transmit+0x98/0xb0
> [   10.478232]  __rpc_execute+0xb0/0x338
> [   10.478258]  rpc_async_schedule+0x2c/0x50
> [   10.478286]  process_one_work+0x1d0/0x320
> [   10.478314]  worker_thread+0x4c/0x400
> [   10.478341]  kthread+0x110/0x120
> [   10.478371]  ret_from_fork+0x10/0x20
> [   10.478399] ---[ end trace 0000000000000000 ]---
> 
> 
> We get an offset 0x3aa8. We are in the process of mapping virtio
> descriptor which is passed from the top level as scatterlist, according
> to the dump
> 
> the dma_map_page() is called from here with scatterlist parameters:
> 
> https://elixir.bootlin.com/linux/v6.0-rc7/source/drivers/virtio/virtio_ring.c#L363
> 
> So we are not dealing with a range within a single page.
> 
> 
> Or I really missed something.
> 
> 

No, you are right. I had a look at the code as well. It's legal for an 
sg to have offset greater than the page size. So, yes the code needs to 
account for this. And the size can be greater than the page size (since 
this is legal too for the sg length). My mistake.

-- 
Xenia
