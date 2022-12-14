Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0ED64C41C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 08:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237482AbiLNHAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 02:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237144AbiLNHAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 02:00:41 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CC31CFD1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 23:00:38 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id vv4so42310170ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 23:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D7e0Of+yNggFNTT7AHup7iSgLPisczF+WTo4peuI7E0=;
        b=oLYduO/svctaPUUIvjKHhbAziz4+h7+BlTMkWyrSUMfhbpNHtcso5doxP2987y1O0M
         /sGqsnbr+sS47YK04iljE/6Ote+ZNUJcAsaHK5JXQFPMIhwlqrcjtzJOFJ0iY9JxV/lM
         oZnGCviGTHJcyR/kn5lIs2tRrBDAdc+/Txd7sJLTKy4eWoP/DWSyMuvtgwmEa+OYR9Ry
         zV24DZVU7w2Ghg12HYf4lq2/mg8oyjuDBdQ5lbNj/OF4ZqQ+9f91dzWGpQHtLOMs+eBz
         ufJ4hXxsmqqyH6UpvNPBsG0YAO6ZfnTB+WXNaMhEMs+EZeIosdPa1kx5FkAC8HoSlh3J
         gD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D7e0Of+yNggFNTT7AHup7iSgLPisczF+WTo4peuI7E0=;
        b=kEvej6z4im/3IwrSSpTSWNHj7/GNs9C64UXIrYhdpS6Wt0+pQwXR7IHlwOUKLcgcyR
         ImRVdDoGqtNpBsxcCfYYXG+36RxKQJ1opO92e8e9nyaihJQhGtStoSghAqRnctm1H/nV
         rRa0kliFLiBpEEazWLmMDgjCtHDZo31WI5D9DUY7letaicbCO/qDYnASmrhWS4FumcL+
         cc7MmxhoBBncDL9wUKiVS9pTSVj1xaTbpNG/ko9O3/JB0cdolNUQKeEFmD28d1UqHxR7
         nSgoNhkYphTWbysIusljSwoGZPU/GLeiE6aFwogHjLjOc78fFQh3sq2KGNcLqiHaptvA
         30GA==
X-Gm-Message-State: ANoB5pn3Be9ogrmackkWu5pVXjnEjtZz1G5cdalNrbhz8oYpzYzSXRHn
        6+fsrR+AQOp8WuPIxMDXiqk=
X-Google-Smtp-Source: AA0mqf7LPFQisApzeY4K08BVpyr/pt+y6yMEzTq3Tlw9EezhBbM376MYa33gkmW9SkuHMGle9/9zVg==
X-Received: by 2002:a17:906:85c2:b0:7c1:27d:3df8 with SMTP id i2-20020a17090685c200b007c1027d3df8mr4535615ejy.4.1671001237148;
        Tue, 13 Dec 2022 23:00:37 -0800 (PST)
Received: from ?IPV6:2003:c7:8f35:4b22:9653:a94c:c63a:fa1f? (p200300c78f354b229653a94cc63afa1f.dip0.t-ipconnect.de. [2003:c7:8f35:4b22:9653:a94c:c63a:fa1f])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906318100b0077f20a722dfsm5393913ejy.165.2022.12.13.23.00.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 23:00:36 -0800 (PST)
Message-ID: <c1887a83-25c2-0979-e790-04cdd5ad4aec@gmail.com>
Date:   Wed, 14 Dec 2022 08:00:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] staging: vme_user: Add spaces around "<<"
To:     Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <Y5jYuKfm9d59h6bd@li-27defe4c-32e1-11b2-a85c-e202e9981075.ibm.com>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <Y5jYuKfm9d59h6bd@li-27defe4c-32e1-11b2-a85c-e202e9981075.ibm.com>
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

On 12/13/22 20:55, Abhirup Deb wrote:
> Add spaces around the "<<" in adherence to the Linux kernel coding-style.
> The issues were reported by checkpatch.pl.
> 
> Signed-off-by: Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>
> ---
>   drivers/staging/vme_user/vme.h | 28 ++++++++++++++--------------
>   1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/vme_user/vme.h b/drivers/staging/vme_user/vme.h
> index 98da8d039d60..a74724457d29 100644
> --- a/drivers/staging/vme_user/vme.h
> +++ b/drivers/staging/vme_user/vme.h
> @@ -54,20 +54,20 @@ enum vme_resource_type {
>   #define VME_R_ROBIN_MODE	0x1
>   #define VME_PRIORITY_MODE	0x2
>   
> -#define VME_DMA_PATTERN			(1<<0)
> -#define VME_DMA_PCI			(1<<1)
> -#define VME_DMA_VME			(1<<2)
> -
> -#define VME_DMA_PATTERN_BYTE		(1<<0)
> -#define VME_DMA_PATTERN_WORD		(1<<1)
> -#define VME_DMA_PATTERN_INCREMENT	(1<<2)
> -
> -#define VME_DMA_VME_TO_MEM		(1<<0)
> -#define VME_DMA_MEM_TO_VME		(1<<1)
> -#define VME_DMA_VME_TO_VME		(1<<2)
> -#define VME_DMA_MEM_TO_MEM		(1<<3)
> -#define VME_DMA_PATTERN_TO_VME		(1<<4)
> -#define VME_DMA_PATTERN_TO_MEM		(1<<5)
> +#define VME_DMA_PATTERN			(1 << 0)
> +#define VME_DMA_PCI			(1 << 1)
> +#define VME_DMA_VME			(1 << 2)
> +
> +#define VME_DMA_PATTERN_BYTE		(1 << 0)
> +#define VME_DMA_PATTERN_WORD		(1 << 1)
> +#define VME_DMA_PATTERN_INCREMENT	(1 << 2)
> +
> +#define VME_DMA_VME_TO_MEM		(1 << 0)
> +#define VME_DMA_MEM_TO_VME		(1 << 1)
> +#define VME_DMA_VME_TO_VME		(1 << 2)
> +#define VME_DMA_MEM_TO_MEM		(1 << 3)
> +#define VME_DMA_PATTERN_TO_VME		(1 << 4)
> +#define VME_DMA_PATTERN_TO_MEM		(1 << 5)
>   
>   struct vme_dma_attr {
>   	u32 type;

I propose to use the BIT macro as checkpatch proposes it when I apply 
checkpatch to your patch. Please also correct the number of tabs to align.

Thanks,

Bye Philipp

CHECK: Prefer using the BIT macro
#37: FILE: drivers/staging/vme_user/vme.h:57:
+#define VME_DMA_PATTERN			(1 << 0)
