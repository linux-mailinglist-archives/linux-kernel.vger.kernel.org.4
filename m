Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22945F7210
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 01:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiJFXvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 19:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiJFXvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:51:36 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9470060480
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 16:51:35 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1563E41477
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 23:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1665100293;
        bh=f7kGweGAvVrWoZ0XynvIzuUJDcE2Jq/GgJuC22F875M=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ZktXPd/NrOcuFRhDkVYrhrAHRnmFHb1QCdmMejDyyNydH2kGu84hPtQ0DB1pcHhMF
         /ACFP8G/eYIMeg9Fz+ciLW+0NpRka0lqhw5TjdueqIm+DhCvfQBp0gqwLhPGUlxhwZ
         Ei5zJ+bcI1A3Ej//mghx/O5+UfQzABypUVKa+CppWFMAktgM6v4bWku+m3p5gRWx4D
         iS2hJaYCtGMs1GqCQOK2tHtoxSVTKtt9CcmXg/dZJidc3eq/9xzrMgUCjNiNMsRiIY
         gk3O7Rp8r6X1S5N+iWWzBIecST7SVGjIaHSMqpx5o4BUsR1su5W+VQGZG8SvK2yIIo
         Tijza4Zd7QAOw==
Received: by mail-ed1-f71.google.com with SMTP id l7-20020a056402254700b004591f1de8ffso2626059edb.15
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 16:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f7kGweGAvVrWoZ0XynvIzuUJDcE2Jq/GgJuC22F875M=;
        b=7+1mDYD+NRuqfNGoVPkXegN92FA2zooGenZ+fMoCRFDpjKuYJig+9JCcmKJByYx09V
         PiT9a+/Hm3gY7XVMAocEShU/xOk5fZz8VFl3QzzvpKRZrUY/R1mV8VcEcnHv7SPYjL7I
         gRoVqU3JgkdRqYYTxTBPkbh79KNJh5VlgZMdYS/5wH3RKCGcVoHa+W7Br+VOgIdDcm35
         PW8GTD9Su9FRWPfKgWhxTGPKipoIjFoh4di9I5DuOkKD+ZcZGQAcpWkO0TAM0vXYwBKd
         9OOpbXrOlcGXKvkc1Q1GM7Tt+4apdhXb5AGDiJHTN4DPQYrMZSrT0t4gims4/Y5ZrX/v
         f2cQ==
X-Gm-Message-State: ACrzQf1wYD1Cri13pdx2fqetHzD1B/3+fnfnkusIa1mFhs1lFWrp/Pye
        XvVNhhdHZ1js3CZVe4ex0leLIGGEq5s14vwHbToJxye1OTIHhC1V/b3f3dN1tO1gdnbYI2Sh/pJ
        6JRzR4zAIIcISGTF7fF3JWcqG9Qwxid+guuyDKWVDdQ==
X-Received: by 2002:a17:907:2672:b0:734:a952:439a with SMTP id ci18-20020a170907267200b00734a952439amr1754764ejc.539.1665100291895;
        Thu, 06 Oct 2022 16:51:31 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5lYngrZEeBFvBJJ6JL/pRmthTCtapwWcWYnD6TSUGZPRYbNlsQ6iGt0VCThOJOInBGoHbmeg==
X-Received: by 2002:a17:907:2672:b0:734:a952:439a with SMTP id ci18-20020a170907267200b00734a952439amr1754740ejc.539.1665100291651;
        Thu, 06 Oct 2022 16:51:31 -0700 (PDT)
Received: from [172.25.0.170] (ip-084-118-157-002.um23.pools.vodafone-ip.de. [84.118.157.2])
        by smtp.gmail.com with ESMTPSA id ee47-20020a056402292f00b0044eb5b922bdsm371026edb.24.2022.10.06.16.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 16:51:31 -0700 (PDT)
Message-ID: <b1306db2-74c5-c207-7c6d-beba0f1593f4@canonical.com>
Date:   Fri, 7 Oct 2022 01:51:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [v4 PATCH 2/3] RISC-V: Update image header
Content-Language: en-US
To:     Atish Patra <atishp@rivosinc.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Fu Wei <tekkamanninja@gmail.com>,
        Leif Lindholm <quic_llindhol@quicinc.com>,
        Nikita Ermakov <arei@altlinux.org>,
        Atish Patra <atishp@atishpatra.org>,
        Julian Andres Klode <julian.klode@canonical.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20221006230051.185850-1-atishp@rivosinc.com>
 <20221006230051.185850-3-atishp@rivosinc.com>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20221006230051.185850-3-atishp@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/7/22 01:00, Atish Patra wrote:
> Update the RISC-V Linux kernel image headers as per the current header.
> 
> Reference:
> <Linux kernel source>/Documentation/riscv/boot-image-header.rst
> 
> 474efecb65dc: ("riscv: modify the Image header to improve compatibility with the ARM64 header")
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>   include/grub/riscv32/linux.h | 15 ++++++++-------
>   include/grub/riscv64/linux.h | 21 +++++++++++++--------
>   2 files changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/include/grub/riscv32/linux.h b/include/grub/riscv32/linux.h
> index 512b777c8a41..de0dbdcd1be5 100644
> --- a/include/grub/riscv32/linux.h
> +++ b/include/grub/riscv32/linux.h
> @@ -19,20 +19,21 @@
>   #ifndef GRUB_RISCV32_LINUX_HEADER
>   #define GRUB_RISCV32_LINUX_HEADER 1
>   
> -#define GRUB_LINUX_RISCV_MAGIC_SIGNATURE 0x52534356 /* 'RSCV' */
> +#define GRUB_LINUX_RISCV_MAGIC_SIGNATURE 0x05435352 /* 'RSC\0x5' */

Thanks for following up on this series.

Considering 69edb312056 ("loader/arm64/linux: Remove magic number header 
field check") why should this constant exist in GRUB at all?

In a follow up patch we could remove it together with 
GRUB_LINUX_ARM_MAGIC_SIGNATURE, GRUB_LINUX_ARMXX_MAGIC_SIGNATURE, and 
GRUB_LINUX_ARMXX_MAGIC_SIGNATURE.

>   
> -/* From linux/Documentation/riscv/booting.txt */
> +/* From linux/Documentation/riscv/boot-image-header.rst */
>   struct linux_riscv_kernel_header
>   {
>     grub_uint32_t code0;		/* Executable code */
>     grub_uint32_t code1;		/* Executable code */
> -  grub_uint64_t text_offset;	/* Image load offset */
> -  grub_uint64_t res0;		/* reserved */
> -  grub_uint64_t res1;		/* reserved */
> +  grub_uint64_t text_offset;	/* Image load offset, little endian */
> +  grub_uint64_t image_size;	/* Effective Image size, little endian */
> +  grub_uint64_t flags;		/* kernel flags, little endian */
> +  grub_uint32_t version;	/* Version of this header */
> +  grub_uint32_t res1;		/* reserved */
>     grub_uint64_t res2;		/* reserved */
>     grub_uint64_t res3;		/* reserved */

According to tag next-20221006 of 
Documentation/riscv/boot-image-header.rst and of 
arch/riscv/include/asm/image.h this field is called 'magic' and filled 
it with the string 'RISCV\0\0\0'.

> -  grub_uint64_t res4;		/* reserved */
> -  grub_uint32_t magic;		/* Magic number, little endian, "RSCV" */
> +  grub_uint32_t magic;		/* Magic number, little endian, "RSC\x05" */

The Linux kernel documentation calls this field magic2.

Of course this is functionally irrelevant as we don't care about the 
content of both fields.

>     grub_uint32_t hdr_offset;	/* Offset of PE/COFF header */
>   };
>   
> diff --git a/include/grub/riscv64/linux.h b/include/grub/riscv64/linux.h
> index 3630c30fbf1a..ea77f8718222 100644
> --- a/include/grub/riscv64/linux.h
> +++ b/include/grub/riscv64/linux.h
> @@ -19,23 +19,28 @@
>   #ifndef GRUB_RISCV64_LINUX_HEADER
>   #define GRUB_RISCV64_LINUX_HEADER 1
>   
> -#define GRUB_LINUX_RISCV_MAGIC_SIGNATURE 0x52534356 /* 'RSCV' */
> +#include <grub/efi/pe32.h>
> +
> +#define GRUB_LINUX_RISCV_MAGIC_SIGNATURE 0x05435352 /* 'RSC\0x5' */

to be removed in future

Best regards

Heinrich

>   
>   #define GRUB_EFI_PE_MAGIC	0x5A4D
>   
> -/* From linux/Documentation/riscv/booting.txt */
> +/* From linux/Documentation/riscv/boot-image-header.rst */
>   struct linux_riscv_kernel_header
>   {
>     grub_uint32_t code0;		/* Executable code */
>     grub_uint32_t code1;		/* Executable code */
> -  grub_uint64_t text_offset;	/* Image load offset */
> -  grub_uint64_t res0;		/* reserved */
> -  grub_uint64_t res1;		/* reserved */
> +  grub_uint64_t text_offset;	/* Image load offset, little endian */
> +  grub_uint64_t image_size;	/* Effective Image size, little endian */
> +  grub_uint64_t flags;		/* kernel flags, little endian */
> +  grub_uint32_t version;	/* Version of this header */
> +  grub_uint32_t res1;		/* reserved */
>     grub_uint64_t res2;		/* reserved */
> -  grub_uint64_t res3;		/* reserved */
> -  grub_uint64_t res4;		/* reserved */
> -  grub_uint32_t magic;		/* Magic number, little endian, "RSCV" */
> +  grub_uint64_t magic;		/* magic (RISC-V specifc, deprecated)*/
> +  grub_uint32_t magic2;		/* Magic number 2 (to match the ARM64 'magic' field pos) */
>     grub_uint32_t hdr_offset;	/* Offset of PE/COFF header */
> +
> +  struct grub_coff_image_header coff_image_header;
>   };
>   
>   #define linux_arch_kernel_header linux_riscv_kernel_header
