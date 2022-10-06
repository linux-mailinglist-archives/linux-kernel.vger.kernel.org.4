Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11E35F6D4B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 19:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiJFR7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 13:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJFR7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 13:59:38 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F711DDF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 10:59:36 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id nb11so6311768ejc.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 10:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9C7ByqeSaw8akdMJt6lEHhq8DB9Wv7neSKwYSa568Bc=;
        b=GBm0FgVhh/SmHkKRk0VR06xZUv2s5FfWzez1BIME/djcjD8cCDknzdtn1Fzhu5g/kg
         S0nic5/R50Bm/zdW792pnzivTdOkci4ZuJd6UtTqZkWQR+bgoIeaRseAhInbl5QEe0et
         8N9tZHW6xeR/VzU5/A/FgJuS8BCAfMW2jbFDvQk6P/9FFkXYFHolvelHSX0+cC3UQHsT
         sbTIVXvPoU0hKTnRuQIheFe9SkyQKUzCkxiQfgRPn5TKhablgXDgTJotMao2Y2fAanLQ
         K2x1hQrwtmzM/aRWdW6b7HIO9mMYR5nU8rLvbd3Nhsd4eWQlW3wVo7MOTKd5tTGzY/XV
         cC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9C7ByqeSaw8akdMJt6lEHhq8DB9Wv7neSKwYSa568Bc=;
        b=QEKA+cEzU+yeTIfdOSP7gJzHAhvTfOgkSwRvcbpAPPh0R/kZ6jr9jRxWI4E5hUkC1S
         IBm5gyhjw0RUsW329hCVEimH4/IIzv28QQA1hwBH3L4h3MVxpEwWxrCLmFdKQgFvePd7
         7eEYn2V4alhVjSOdGMPRQ3n3ssdAHijWphBNZ4oZxn4+Ntyg2kBdPgds4J/uPN3L7mcx
         R+lm4ifUHVCIv36c7MPb2KkB7NIwr3yRyzuJggGmEEb1C1CqNl8n87vd1Q0P5pY9m0nh
         K1YKNKqrBizVGri7wY2NmdK+46GXtEOyT2S/9BrAMimpeWAI+rJjNDrCq2Q8ZAZJW23o
         SM0w==
X-Gm-Message-State: ACrzQf14VKpFP3kSKUOxVS9LsCs0+Z8/epZRiGwzwx9m4/iJAR0/UNsv
        ZyTRdp1GalbPHiuAYuyye97PHXTb7Js0ag==
X-Google-Smtp-Source: AMsMyM5kuaauO1vW4syhZvX2RO/dfucMb6YYgUT3lLJ4eHvtA3RTG8amKMunPAeu3qoE1ar1WyyYcA==
X-Received: by 2002:a17:907:8a0a:b0:78d:2ecb:63e6 with SMTP id sc10-20020a1709078a0a00b0078d2ecb63e6mr919611ejc.620.1665079174812;
        Thu, 06 Oct 2022 10:59:34 -0700 (PDT)
Received: from [192.168.1.93] (adsl-75.176.58.241.tellas.gr. [176.58.241.75])
        by smtp.gmail.com with ESMTPSA id b17-20020a17090630d100b0078b03d57fa7sm45931ejb.34.2022.10.06.10.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 10:59:34 -0700 (PDT)
Message-ID: <96a16b32-0950-b538-65e5-9955ed8cc529@gmail.com>
Date:   Thu, 6 Oct 2022 20:59:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] xen/virtio: Convert PAGE_SIZE/PAGE_SHIFT/PFN_UP to Xen
 counterparts
Content-Language: en-US
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>
References: <20221006120912.1948459-1-olekstysh@gmail.com>
From:   Xenia Ragiadakou <burzalodowa@gmail.com>
In-Reply-To: <20221006120912.1948459-1-olekstysh@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/6/22 15:09, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> Although XEN_PAGE_SIZE is equal to PAGE_SIZE (4KB) for now, it would
> be more correct to use Xen specific #define-s as XEN_PAGE_SIZE can
> be changed at some point in the future.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> ---
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Xenia Ragiadakou <burzalodowa@gmail.com>
> 
> As it was proposed at:
> https://lore.kernel.org/xen-devel/20221005174823.1800761-1-olekstysh@gmail.com/
> 
> Should go in only after that series.
> ---
>   drivers/xen/grant-dma-ops.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
> index c66f56d24013..5392fdc25dca 100644
> --- a/drivers/xen/grant-dma-ops.c
> +++ b/drivers/xen/grant-dma-ops.c
> @@ -31,12 +31,12 @@ static DEFINE_XARRAY_FLAGS(xen_grant_dma_devices, XA_FLAGS_LOCK_IRQ);
>   
>   static inline dma_addr_t grant_to_dma(grant_ref_t grant)
>   {
> -	return XEN_GRANT_DMA_ADDR_OFF | ((dma_addr_t)grant << PAGE_SHIFT);
> +	return XEN_GRANT_DMA_ADDR_OFF | ((dma_addr_t)grant << XEN_PAGE_SHIFT);
>   }

With this change, can the offset added to the dma handle, generated by 
grant_to_dma(), be the offset in the page? Couldn't it corrupt the grant 
ref?

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
> @@ -168,7 +168,7 @@ static dma_addr_t xen_grant_dma_map_page(struct device *dev, struct page *page,
>   					 unsigned long attrs)
>   {
>   	struct xen_grant_dma_data *data;
> -	unsigned int i, n_pages = PFN_UP(offset + size);
> +	unsigned int i, n_pages = XEN_PFN_UP(offset + size);

The offset, here, refers to the offset in the page ...

>   	grant_ref_t grant;
>   	dma_addr_t dma_handle;
>   
> @@ -200,8 +200,8 @@ static void xen_grant_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
>   				     unsigned long attrs)
>   {
>   	struct xen_grant_dma_data *data;
> -	unsigned long offset = dma_handle & (PAGE_SIZE - 1);
> -	unsigned int i, n_pages = PFN_UP(offset + size);
> +	unsigned long offset = dma_handle & ~XEN_PAGE_MASK;

... while, here, it refers to the offset in the grant.
So, the calculated number of grants may differ.

> +	unsigned int i, n_pages = XEN_PFN_UP(offset + size);
>   	grant_ref_t grant;
>   
>   	if (WARN_ON(dir == DMA_NONE))

-- 
Xenia
