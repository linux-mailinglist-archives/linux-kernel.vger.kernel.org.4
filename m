Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3685F6366D9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237898AbiKWRTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236429AbiKWRTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:19:51 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A039595
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 09:19:49 -0800 (PST)
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com [209.85.219.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9D6223F164
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 17:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1669223987;
        bh=h7C2hHcimmZ7pO9zs58j39X1ZC+4+l5O+MNwfXCa5Gs=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=m1Jzt3iV7i9ThJbTkTDRpkIMEaZhhvUB1fHh9Ne5v7jxhsHrY1bg8arSC6AenLxP/
         HBrx16lf9WM5GyUwaT9ZiwLo4+GiDacrcZ3ux19ohqldKmw91/qVcWZCBu2W6bHG9I
         bMT+cDcUyHJ4jRNqNbnd05J3+EGc4JC90+Dm5+zrYPaR3A8rHYjjLxuO3tYCDLZ/5C
         rYC9mCY8goWHkH8oiI7LvK0cFFCEuRklt8r2Bwf6ibQUqPTMiKHaVi0rPRryouo6zu
         y5UU+SU0FpxODp2+aHw6PoRBPMkBKkz+UY1ROd6CR4Sr/O/yFUt/VuQwQhbxPyYvzt
         xEipl9dOrgwjw==
Received: by mail-yb1-f200.google.com with SMTP id a5-20020a25af05000000b006e450a5e507so16934686ybh.22
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 09:19:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7C2hHcimmZ7pO9zs58j39X1ZC+4+l5O+MNwfXCa5Gs=;
        b=Y4W3jUI14jI3q72wScZ1pLIaSd2iu3F0kKH2Y9YtjRzjufOIB7+fpFjqBERRg9o8sS
         nNTRTNuVzuTl2io1pTsU6F2BJd25E5hGR2NzPrV//iZjVdFMmNspF8zwFWLH5pJ/qR1j
         ek7YwrEtE/yWKZLC6HMOaYm07OZVB8MT4/s2hlrSrwAUuFVJtMfCrdKjGzvnYk40GkeY
         SPZvsqwfy/kUwqOIJeEaMwLUWoQnOyBkD0HRZV2DfrbDsHJViaG0+ekiZ0f1Ha4xkBdW
         K1YMFo3O8lYZCytcCIFjnDmG6OvscK6oLOX5IeBwCLzF8yLu+3PSc1KqYvjhseWpMjPC
         TaqA==
X-Gm-Message-State: ANoB5pkLxNy2KDm5gmMnAppxg7hNdULO1y2kLc25RE1QTs2qM33ACwEj
        o8xL6dx3B0y89VIKHn8slCmgYoruOsTPk5+llWzp8DNoAjSePr6yRgNvpDbTQVLNMt+Amfhb4fX
        R+hPRIq4+g69Xn+yFM6eTqKUKcEAF5BCgIUr5HK1h0Z/mhKUmnApsWpVvTQ==
X-Received: by 2002:a0d:e696:0:b0:3b1:23de:2025 with SMTP id p144-20020a0de696000000b003b123de2025mr2631658ywe.230.1669223986618;
        Wed, 23 Nov 2022 09:19:46 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6dPqwX2isjpBvx2vvZXYABsXo2bhnTP7AwHMF+2frJwg5uBRpnSXCpfEg3kl7RSJMGPnCo/egG8ZfIflVk1pw=
X-Received: by 2002:a0d:e696:0:b0:3b1:23de:2025 with SMTP id
 p144-20020a0de696000000b003b123de2025mr2631631ywe.230.1669223986399; Wed, 23
 Nov 2022 09:19:46 -0800 (PST)
MIME-Version: 1.0
References: <20221121133303.1782246-1-alexghiti@rivosinc.com>
In-Reply-To: <20221121133303.1782246-1-alexghiti@rivosinc.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 23 Nov 2022 18:19:29 +0100
Message-ID: <CAJM55Z8+QyYKEwnMia2wjg+uYYnB=J40oSU8yDxoKm8Se+TnVA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Sync efi page table's kernel mappings before switching
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On Mon, 21 Nov 2022 at 14:33, Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>
> The EFI page table is initially created as a copy of the kernel page table.
> With VMAP_STACK enabled, kernel stacks are allocated in the vmalloc area:
> if the stack is allocated in a new PGD (one that was not present at the
> moment of the efi page table creation or not synced in a previous vmalloc
> fault), the kernel will take a trap when switching to the efi page table
> when the vmalloc kernel stack is accessed, resulting in a kernel panic.
>
> Fix that by updating the efi kernel mappings before switching to the efi
> page table.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks for the patch! With this applied on the Ubuntu 5.19 kernel I
can enable CONFIG_VMAP_STACK and cat /sys/firmware/efi/efivars/* on
the Unmatched without locking up. So

Tested-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
>  arch/riscv/include/asm/efi.h     |  6 +++++-
>  arch/riscv/include/asm/pgalloc.h | 11 ++++++++---
>  2 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
> index f74879a8f1ea..e229d7be4b66 100644
> --- a/arch/riscv/include/asm/efi.h
> +++ b/arch/riscv/include/asm/efi.h
> @@ -10,6 +10,7 @@
>  #include <asm/mmu_context.h>
>  #include <asm/ptrace.h>
>  #include <asm/tlbflush.h>
> +#include <asm/pgalloc.h>
>
>  #ifdef CONFIG_EFI
>  extern void efi_init(void);
> @@ -20,7 +21,10 @@ extern void efi_init(void);
>  int efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md);
>  int efi_set_mapping_permissions(struct mm_struct *mm, efi_memory_desc_t *md);
>
> -#define arch_efi_call_virt_setup()      efi_virtmap_load()
> +#define arch_efi_call_virt_setup()      ({             \
> +               sync_kernel_mappings(efi_mm.pgd);       \
> +               efi_virtmap_load();                     \
> +       })
>  #define arch_efi_call_virt_teardown()   efi_virtmap_unload()
>
>  #define ARCH_EFI_IRQ_FLAGS_MASK (SR_IE | SR_SPIE)
> diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
> index 947f23d7b6af..59dc12b5b7e8 100644
> --- a/arch/riscv/include/asm/pgalloc.h
> +++ b/arch/riscv/include/asm/pgalloc.h
> @@ -127,6 +127,13 @@ static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
>  #define __p4d_free_tlb(tlb, p4d, addr)  p4d_free((tlb)->mm, p4d)
>  #endif /* __PAGETABLE_PMD_FOLDED */
>
> +static inline void sync_kernel_mappings(pgd_t *pgd)
> +{
> +       memcpy(pgd + USER_PTRS_PER_PGD,
> +              init_mm.pgd + USER_PTRS_PER_PGD,
> +              (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
> +}
> +
>  static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>  {
>         pgd_t *pgd;
> @@ -135,9 +142,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>         if (likely(pgd != NULL)) {
>                 memset(pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
>                 /* Copy kernel mappings */
> -               memcpy(pgd + USER_PTRS_PER_PGD,
> -                       init_mm.pgd + USER_PTRS_PER_PGD,
> -                       (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
> +               sync_kernel_mappings(pgd);
>         }
>         return pgd;
>  }
> --
> 2.37.2
>
