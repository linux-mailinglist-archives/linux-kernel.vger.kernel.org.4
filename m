Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DC65FE9A5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 09:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiJNHfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 03:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiJNHfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 03:35:31 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91278767C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 00:35:28 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id fy4so8685702ejc.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 00:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IH2CpfxEnRPwyicRs6j2xX+M8g2xRDD94KWbgPm56UQ=;
        b=WTM16MpNXdwQMpkJIl9siCRyn8/P6hXgvjHqcZ4wHq5Ylr095mkKLwo1MssyAHb7T7
         AZ5gQWH3xEMbjuplmB1Uid8GIqzqZfEXRK8/iMRtKGULNKpCsrObFi7WT4rwGIFJUdY3
         amOeedWqg0fJzgTFTD8EwKoqNV7lQdmQoJAURykshfJQenO8eOMtFzB9YXutzL3aChr9
         xyfeKZNWy/8vpE+6OIFyve7NhEBlAywrTSC/npVIJYX+OPuX4svHHSWXxPPWbKnu4sUA
         HJZAKXcR17CXxJolDRAO0v9IHKe0QPMMGaYqMRopo5bUynVUGtt7bmljiTj751SQiGk7
         MeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IH2CpfxEnRPwyicRs6j2xX+M8g2xRDD94KWbgPm56UQ=;
        b=LWdeOQ6Me8qiQHM1uw2K/tkqOx+Qw8XKyEwZj9+z9lhNg+czBwnY/DQaW6lTZoF/w6
         70SG3pUBic98Q70/k4Kjm/IG+WXu2RSO9qt/uKxOapDOvYY6gRXdJ8Ms4drlkR1MREd0
         kIdkkLzlArPkeRg+kW6LSupJGda1mNn6k6Fz2Z6GXTelm+Yhw61/xH8dpsPBhwBqyy2g
         kRSb6x591gb+v5Kg6cG1M8hpx0cCJpOGLOX5WluMvosP8wK5+4BYoxVHjITXBpO0nq2v
         Y9fXa/CTi4S1ISUFT9h8bjv3YzKu05o+Bn89h5iCg7l4p78BDZkH0PlUHrmYriRnTzmH
         WybA==
X-Gm-Message-State: ACrzQf0E6rJY8DAN3izH5Cta5dOszuIXvnZDcAgW5d2I7nWsOr+kmk0p
        fUwhaqVwDnWefzZQwdcYttc=
X-Google-Smtp-Source: AMsMyM5tm2UqwC7RYDcv5cU9uJmlRMFT3E8NR+6T0bg+FpAoctHGfjZtODhQ0PuioODwiwWi3zZivQ==
X-Received: by 2002:a17:906:9c82:b0:781:5752:4f2b with SMTP id fj2-20020a1709069c8200b0078157524f2bmr2483158ejc.561.1665732926818;
        Fri, 14 Oct 2022 00:35:26 -0700 (PDT)
Received: from [192.168.1.93] (adsl-9.109.242.227.tellas.gr. [109.242.227.9])
        by smtp.gmail.com with ESMTPSA id p13-20020a17090653cd00b0078d175d6dc5sm1040479ejo.201.2022.10.14.00.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 00:35:26 -0700 (PDT)
Message-ID: <ae26a54b-ece5-f8a3-2331-f7e495ecceea@gmail.com>
Date:   Fri, 14 Oct 2022 10:35:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2 1/2] xen/virtio: Handle cases when page offset >
 PAGE_SIZE properly
Content-Language: en-US
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>
References: <20221008151013.2537826-1-olekstysh@gmail.com>
 <20221008151013.2537826-2-olekstysh@gmail.com>
From:   Xenia Ragiadakou <burzalodowa@gmail.com>
In-Reply-To: <20221008151013.2537826-2-olekstysh@gmail.com>
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
> Passed to xen_grant_dma_map_page() offset in the page
> can be > PAGE_SIZE even if the guest uses the same page granularity
> as Xen (4KB).
> 
> Before current patch, if such case happened we ended up providing
> grants for the whole region in xen_grant_dma_map_page() which
> was really unnecessary. The more, we ended up not releasing all
> grants which represented that region in xen_grant_dma_unmap_page().
> 
> Current patch updates the code to be able to deal with such cases.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Reviewed-by: Xenia Ragiadakou <burzalodowa@gmail.com>

> ---
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Xenia Ragiadakou <burzalodowa@gmail.com>
> 
> Changes V1 -> V2:
>     - s/gfn_offset/pfn_offset
>     - clarify gfn calculation when granting a page
> 
> Previous discussion is at:
> https://lore.kernel.org/lkml/20221007132736.2275574-1-olekstysh@gmail.com/
> ---
>   drivers/xen/grant-dma-ops.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
> index c66f56d24013..1d018e3a68a0 100644
> --- a/drivers/xen/grant-dma-ops.c
> +++ b/drivers/xen/grant-dma-ops.c
> @@ -168,7 +168,9 @@ static dma_addr_t xen_grant_dma_map_page(struct device *dev, struct page *page,
>   					 unsigned long attrs)
>   {
>   	struct xen_grant_dma_data *data;
> -	unsigned int i, n_pages = PFN_UP(offset + size);
> +	unsigned long dma_offset = offset_in_page(offset),
> +			pfn_offset = PFN_DOWN(offset);
> +	unsigned int i, n_pages = PFN_UP(dma_offset + size);
>   	grant_ref_t grant;
>   	dma_addr_t dma_handle;
>   
> @@ -187,10 +189,11 @@ static dma_addr_t xen_grant_dma_map_page(struct device *dev, struct page *page,
>   
>   	for (i = 0; i < n_pages; i++) {
>   		gnttab_grant_foreign_access_ref(grant + i, data->backend_domid,
> -				xen_page_to_gfn(page) + i, dir == DMA_TO_DEVICE);
> +				pfn_to_gfn(page_to_xen_pfn(page) + i + pfn_offset),
> +				dir == DMA_TO_DEVICE);
>   	}
>   
> -	dma_handle = grant_to_dma(grant) + offset;
> +	dma_handle = grant_to_dma(grant) + dma_offset;
>   
>   	return dma_handle;
>   }

-- 
Xenia
