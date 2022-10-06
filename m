Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4FF5F61BB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 09:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiJFHgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 03:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiJFHgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 03:36:04 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67AB8F948
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 00:35:56 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y100so1580069ede.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 00:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0dtKZhkDgaoTTpO0pEO0vifhDrrgR+WBWj56fb3zUfQ=;
        b=W4RsQkzM7QFWf+K5p/TTKfFKwP/3vAkl3ikvYa4UUzVSCyQMmyAeRgkZ3zuyYZpFrb
         JUftfdmSzmLcggX6184vSHPvABJxE6t2J+YpnX6SsIFxwAwXEBZHJz1clQrA4TEcDNcp
         F/UP6XNrSQdF3jmwDZJIiY6jYzl1VG8YHYwSh7yMcsn8QpUDtktNKWLzOhO+g1b1gzji
         Tg6FCYROjaPOCYA/xMQR80QNQxx236f2KBJIjghQPZv2gcnCVr7SVO411apqJ6LQ9fgO
         NabZd8+h219Pw2vTF3RwlVmH/tLPkTLRXpj1zjUQyJLEL3s0hKi7Ed8DZP7hF1qJ73ei
         OWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0dtKZhkDgaoTTpO0pEO0vifhDrrgR+WBWj56fb3zUfQ=;
        b=pPtck6i0462bPW3JGQ3zoSE9C/Q6pOrMngQpe+/nZ/i+Fb86Fa3+TxUndp0U0/X+Zh
         lLDkLB5NmJf0K69cOiReR/DxhUyc+tkt0+Vn22cN51t0bzgILMfAgNxsvh1nr6SKQKS1
         j4GjzS+b1HTJQM3fMAJNNaGsYZU+z6T3YmEkDuypxnlhAIZyyOw0zMZPpc9dFHYmWjhr
         2Dn8QlNCpalTVB79Ek0+AJJDtwbhdRCpHPhU2oXCXj6BJaMOQZoSZhj7Gp1S3j7oKayq
         q8LqtFhW/7vUBNw0l+KLBiBY1eSvl9u5yTTqeiIGRmWE8BYrLS+YKM7+AtDR/brSKV6G
         UM9Q==
X-Gm-Message-State: ACrzQf2Qye/nWLO53ZMILkCb0dS+DMGRlVhmyXPB+PHGeimd4OLfsjgQ
        37kG4zZHHVnVASZNFR/z9KInW8Nx+ZLLMg==
X-Google-Smtp-Source: AMsMyM6QWzOQBtddsT3XuWD2bke2M6zHcURtDCNzNXrWLYhFV+Elgj1HIX09GNwNyVYdtaNyQ9Kc/Q==
X-Received: by 2002:a05:6402:3550:b0:451:473a:5ca3 with SMTP id f16-20020a056402355000b00451473a5ca3mr3365421edd.48.1665041755090;
        Thu, 06 Oct 2022 00:35:55 -0700 (PDT)
Received: from [192.168.1.93] (adsl-75.176.58.241.tellas.gr. [176.58.241.75])
        by smtp.gmail.com with ESMTPSA id w3-20020a1709062f8300b0072ed9efc9dfsm9879115eji.48.2022.10.06.00.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 00:35:54 -0700 (PDT)
Message-ID: <55a22602-3ae8-b09b-61c9-1fc7c01235fc@gmail.com>
Date:   Thu, 6 Oct 2022 10:35:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] xen/virtio: Fix n_pages calculation in
 xen_grant_dma_map(unmap)_page()
Content-Language: en-US
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>
References: <20221005174823.1800761-1-olekstysh@gmail.com>
 <20221005174823.1800761-2-olekstysh@gmail.com>
From:   Xenia Ragiadakou <burzalodowa@gmail.com>
In-Reply-To: <20221005174823.1800761-2-olekstysh@gmail.com>
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


On 10/5/22 20:48, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> Take page offset into the account when calculating the number of pages
> to be granted.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> Fixes: d6aca3504c7d ("xen/grant-dma-ops: Add option to restrict memory access under Xen")
> ---
>   drivers/xen/grant-dma-ops.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
> index 8973fc1e9ccc..1998d0e8ce82 100644
> --- a/drivers/xen/grant-dma-ops.c
> +++ b/drivers/xen/grant-dma-ops.c
> @@ -153,7 +153,7 @@ static dma_addr_t xen_grant_dma_map_page(struct device *dev, struct page *page,
>   					 unsigned long attrs)
>   {
>   	struct xen_grant_dma_data *data;
> -	unsigned int i, n_pages = PFN_UP(size);
> +	unsigned int i, n_pages = PFN_UP(offset + size);

Here, why do we use PFN_UP and not XEN_PFN_UP?
Also, since the variable 'n_pages' seems to refer to the number of 
grants (unless I got it all entirely wrong ...), wouldn't it be more 
suitable to call explicitly gnttab_count_grant()?
If the above questions have been already answered in the past, please 
ignore.

>   	grant_ref_t grant;
>   	dma_addr_t dma_handle;
>   
> @@ -185,7 +185,8 @@ static void xen_grant_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
>   				     unsigned long attrs)
>   {
>   	struct xen_grant_dma_data *data;
> -	unsigned int i, n_pages = PFN_UP(size);
> +	unsigned long offset = dma_handle & (PAGE_SIZE - 1);
> +	unsigned int i, n_pages = PFN_UP(offset + size);
>   	grant_ref_t grant;
>   
>   	if (WARN_ON(dir == DMA_NONE))

-- 
Xenia
