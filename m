Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857055FE9AA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 09:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiJNHgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 03:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiJNHgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 03:36:10 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CDDA3AA4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 00:35:50 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id q9so8790866ejd.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 00:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VCPRZPimy1jhKBoGPGG0+X9sDq3h3O7tAPxelD7f+No=;
        b=oP4Eynge3Xwu3n7mPW7fEyfo4HONe5tc2NiQWhi65iJ6tg0w66pwIlZXsWv3JOguT+
         T1IVGUBrzmbhQ1ptGs+Y5olPhewrE+jI8xrTzJrjFhaj7mJEe2sisCrAhk+4swVyz0dC
         mdjopwiXEGTEuc/Ox4rtfhisH2zHbCgEVyhVckCy76EhZ5FYGBpnj9DCw+avwOXSesDb
         UgXcC9osox1zEy03CeYfRa/qU6z2qKcXPUGLyeTDSc0dMxdHSkmwp4/g+uj41LZKj2TN
         2ZudF4UrNiJ5wcA32xCcAlOnKPPwdFjx4dC76QEOdCgP3uAqiWjJGoTwYRJUOS9lA8Sr
         j3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VCPRZPimy1jhKBoGPGG0+X9sDq3h3O7tAPxelD7f+No=;
        b=qzf0xpwBm3OWHJGjJ/RvZS6TVd3wja6UdayKPHZWHhsDHG3YzUewziAFa3lEVHx3j2
         tDxSzqHvHT74A4fnfeBe5QAldITkgB2xa0Ve10GzG5jMLyJ1ZkNkCmmuIxVZ9GkNqrZn
         H2aTZedkk8L0iBYT0+XLTEGoWkmZ1xLNdrMsrgFJd+bhBGlIZ3arSJ+Mayr2Zn9S6J8g
         96tu0dFQ5Ak6kqZmFhnFU9X8wNReiyMrbC8iFSSzFIhOXPPyMo+vezfCPNQ8hivP42Bt
         pP/b8eeyI/oOhwADIxlwqnDEK9f4gItds5SJj6tpdSHjC8nlgP9uqu/2+utq6O/LS1gU
         oD+Q==
X-Gm-Message-State: ACrzQf0jIvlhtBvUbMGn4tGycM60QYUym3WSPjfAJrKzoOHiQ2svgpK4
        CwlM9ru1Ly2qH9yYVYe5XVQ=
X-Google-Smtp-Source: AMsMyM7Msvwm+JCWrbOjkGwWYLVbCwYItTXEbA6DFbHuzSJTsvZqlE5dCqRtecgcQe4shNB6I4pZ5Q==
X-Received: by 2002:a17:907:168c:b0:78d:8b6c:a209 with SMTP id hc12-20020a170907168c00b0078d8b6ca209mr2746472ejc.185.1665732948046;
        Fri, 14 Oct 2022 00:35:48 -0700 (PDT)
Received: from [192.168.1.93] (adsl-9.109.242.227.tellas.gr. [109.242.227.9])
        by smtp.gmail.com with ESMTPSA id kx22-20020a170907775600b00738795e7d9bsm1138971ejc.2.2022.10.14.00.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 00:35:47 -0700 (PDT)
Message-ID: <bb45c1fa-5f6e-05f5-eba6-8dedb9270a98@gmail.com>
Date:   Fri, 14 Oct 2022 10:35:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2 2/2] xen/virtio: Convert PAGE_SIZE/PAGE_SHIFT/PFN_UP to
 Xen counterparts
Content-Language: en-US
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>
References: <20221008151013.2537826-1-olekstysh@gmail.com>
 <20221008151013.2537826-3-olekstysh@gmail.com>
From:   Xenia Ragiadakou <burzalodowa@gmail.com>
In-Reply-To: <20221008151013.2537826-3-olekstysh@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/22 18:10, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> Currently, a grant ref is always based on the Xen page granularity
> (4KB), and guest commonly uses the same page granularity.
> But the guest may use a different page granularity (i.e 64KB).
> So adopt the code to be able to deal with it.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Reviewed-by: Xenia Ragiadakou <burzalodowa@gmail.com>

> ---
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Xenia Ragiadakou <burzalodowa@gmail.com>
> 
> Changes V1 -> V2:
>     - update commit description
>     - rebase
>     - use xen_offset_in_page() in xen_grant_dma_map(unmap)_page()
> 
> Previous discussion is at:
> https://lore.kernel.org/xen-devel/20221006120912.1948459-1-olekstysh@gmail.com/
> ---
>   drivers/xen/grant-dma-ops.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
> index 1d018e3a68a0..aff0f95ed954 100644
> --- a/drivers/xen/grant-dma-ops.c
> +++ b/drivers/xen/grant-dma-ops.c
> @@ -31,12 +31,12 @@ static DEFINE_XARRAY_FLAGS(xen_grant_dma_devices, XA_FLAGS_LOCK_IRQ);
>   
>   static inline dma_addr_t grant_to_dma(grant_ref_t grant)
>   {
> -	return XEN_GRANT_DMA_ADDR_OFF | ((dma_addr_t)grant << PAGE_SHIFT);
> +	return XEN_GRANT_DMA_ADDR_OFF | ((dma_addr_t)grant << XEN_PAGE_SHIFT);
>   }
>   
>   static inline grant_ref_t dma_to_grant(dma_addr_t dma)
>   {
> -	return (grant_ref_t)((dma & ~XEN_GRANT_DMA_ADDR_OFF) >> PAGE_SHIFT);
> +	return (grant_ref_t)((dma & ~XEN_GRANT_DMA_ADDR_OFF) >> XEN_PAGE_SHIFT);
>   }
>   
>   static struct xen_grant_dma_data *find_xen_grant_dma_data(struct device *dev)
> @@ -79,7 +79,7 @@ static void *xen_grant_dma_alloc(struct device *dev, size_t size,
>   				 unsigned long attrs)
>   {
>   	struct xen_grant_dma_data *data;
> -	unsigned int i, n_pages = PFN_UP(size);
> +	unsigned int i, n_pages = XEN_PFN_UP(size);
>   	unsigned long pfn;
>   	grant_ref_t grant;
>   	void *ret;
> @@ -91,14 +91,14 @@ static void *xen_grant_dma_alloc(struct device *dev, size_t size,
>   	if (unlikely(data->broken))
>   		return NULL;
>   
> -	ret = alloc_pages_exact(n_pages * PAGE_SIZE, gfp);
> +	ret = alloc_pages_exact(n_pages * XEN_PAGE_SIZE, gfp);
>   	if (!ret)
>   		return NULL;
>   
>   	pfn = virt_to_pfn(ret);
>   
>   	if (gnttab_alloc_grant_reference_seq(n_pages, &grant)) {
> -		free_pages_exact(ret, n_pages * PAGE_SIZE);
> +		free_pages_exact(ret, n_pages * XEN_PAGE_SIZE);
>   		return NULL;
>   	}
>   
> @@ -116,7 +116,7 @@ static void xen_grant_dma_free(struct device *dev, size_t size, void *vaddr,
>   			       dma_addr_t dma_handle, unsigned long attrs)
>   {
>   	struct xen_grant_dma_data *data;
> -	unsigned int i, n_pages = PFN_UP(size);
> +	unsigned int i, n_pages = XEN_PFN_UP(size);
>   	grant_ref_t grant;
>   
>   	data = find_xen_grant_dma_data(dev);
> @@ -138,7 +138,7 @@ static void xen_grant_dma_free(struct device *dev, size_t size, void *vaddr,
>   
>   	gnttab_free_grant_reference_seq(grant, n_pages);
>   
> -	free_pages_exact(vaddr, n_pages * PAGE_SIZE);
> +	free_pages_exact(vaddr, n_pages * XEN_PAGE_SIZE);
>   }
>   
>   static struct page *xen_grant_dma_alloc_pages(struct device *dev, size_t size,
> @@ -168,9 +168,9 @@ static dma_addr_t xen_grant_dma_map_page(struct device *dev, struct page *page,
>   					 unsigned long attrs)
>   {
>   	struct xen_grant_dma_data *data;
> -	unsigned long dma_offset = offset_in_page(offset),
> -			pfn_offset = PFN_DOWN(offset);
> -	unsigned int i, n_pages = PFN_UP(dma_offset + size);
> +	unsigned long dma_offset = xen_offset_in_page(offset),
> +			pfn_offset = XEN_PFN_DOWN(offset);
> +	unsigned int i, n_pages = XEN_PFN_UP(dma_offset + size);
>   	grant_ref_t grant;
>   	dma_addr_t dma_handle;
>   
> @@ -203,8 +203,8 @@ static void xen_grant_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
>   				     unsigned long attrs)
>   {
>   	struct xen_grant_dma_data *data;
> -	unsigned long offset = dma_handle & (PAGE_SIZE - 1);
> -	unsigned int i, n_pages = PFN_UP(offset + size);
> +	unsigned long dma_offset = xen_offset_in_page(dma_handle);
> +	unsigned int i, n_pages = XEN_PFN_UP(dma_offset + size);
>   	grant_ref_t grant;
>   
>   	if (WARN_ON(dir == DMA_NONE))

-- 
Xenia
