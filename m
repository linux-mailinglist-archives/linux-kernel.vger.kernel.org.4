Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C985F8998
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 08:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiJIGNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 02:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJIGNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 02:13:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2631F9DD
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 23:13:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BAF9B80C85
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 06:13:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33ED2C433C1
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 06:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665296018;
        bh=nGBC93MowSDU0u0exT1yFjmxGsBuy5ubnjjtDzl6fuk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nZI233A3r7vtIAeIXUXTH9137z0hdLi9haktz0Fz53tvnyVCAl6yx46CL1J6HQPMB
         zgp5tRaIqt54zd7I4j9w5s6CTe4GrA8FkeV1N/ykGxwJqbt9p5CkN7lpY+9K7ZBsIp
         xeBVKKgycwnyhW/4Wzjj+5CCu9C01OzuHmlg7Qm9QvYTOO1/buD6XFuf/1XkrLBUEn
         G3HffqJV1/zNdLfscSv9QleLvRClCdOtGzD5QWq6dn2H3DJHpc+vzv0TUrOXuxWg9u
         ZprxRVdywjg7lKJJMc0Cfe7YjcKlw+vUniOfquDolv0mJ/9VPtYwqkFQno48eOGHR2
         mt06kYy5r98Ow==
Received: by mail-ej1-f50.google.com with SMTP id nb11so19044422ejc.5
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 23:13:38 -0700 (PDT)
X-Gm-Message-State: ACrzQf32rh1L2WhCLUFmkeL+3/E/vtjSuR6PMG1GtGx6AAE831TOS5i+
        zFtTJHkaAa68pE61J9umLvj09E9N76MsU6ZSG3M=
X-Google-Smtp-Source: AMsMyM5iMHmI9aJwCtbDagcj/2qipPBnbSG54Nql5jQ4/PxJt67addHuxJ/LnJfSb9cBaO5eE8M9qjmjb2FXrtL/v7A=
X-Received: by 2002:a17:906:fe45:b0:788:15a5:7495 with SMTP id
 wz5-20020a170906fe4500b0078815a57495mr10163814ejb.633.1665296016240; Sat, 08
 Oct 2022 23:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20221004140230.748788-1-wangrui@loongson.cn>
In-Reply-To: <20221004140230.748788-1-wangrui@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 9 Oct 2022 14:13:27 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6e9ZyC8TkpWK3Etgz4-kEEEU4Hj=i5obMFk=URgCwrgw@mail.gmail.com>
Message-ID: <CAAhV-H6e9ZyC8TkpWK3Etgz4-kEEEU4Hj=i5obMFk=URgCwrgw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: mm: Refactor TLB handlers
To:     Rui Wang <wangrui@loongson.cn>
Cc:     loongarch@lists.linux.dev, WANG Xuerui <kernel@xen0n.name>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued for loongarch-next, thanks.

Huacai

On Tue, Oct 4, 2022 at 10:02 PM Rui Wang <wangrui@loongson.cn> wrote:
>
> This patch simplifies TLB load, store and modify exception handlers:
>
> 1. Reduce instructions. such as alu/csr and memory access
> 2. Execute tlbsrch only in the fast path.
> 3. Return directly from the fast path for huge pages.
>
> And fixes the concurrent modification issue of fast path for huge pages.
> This issue will occur in the following steps:
>
>    CPU-1 (In TLB exception)         CPU-2 (In THP)
> 1: Load PMD entry (HUGE=1)
> 2: Goto huge path
> 3:                                  Store PMD entry (HUGE=0)
> 4: Reload PMD entry (HUGE=0)
> 5: Fill TLB entry (PA is incorrect)
>
> This also slightly improves the TLB processing performance:
>
> * Normal pages: 2.15%
> * Huge pages:   1.70%
>
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <unistd.h>
>   #include <sys/mman.h>
>
>   int main(int argc, char *argv[])
>   {
>         size_t page_size;
>         size_t mem_size;
>         size_t off;
>         void *base;
>         int flags;
>         int i;
>
>         if (argc < 2) {
>                 fprintf(stderr, "%s MEM_SIZE [HUGE]\n", argv[0]);
>                 return -1;
>         }
>
>         page_size = sysconf(_SC_PAGESIZE);
>         flags = MAP_PRIVATE | MAP_ANONYMOUS;
>         mem_size = strtoul(argv[1], NULL, 10);
>         if (argc > 2)
>                 flags |= MAP_HUGETLB;
>
>         for (i = 0; i < 10; i++) {
>                 base = mmap(NULL, mem_size, PROT_READ, flags, -1, 0);
>                 if (base == MAP_FAILED) {
>                         fprintf(stderr, "Map memory failed!\n");
>                         return -1;
>                 }
>
>                 for (off = 0; off < mem_size; off += page_size)
>                         *(volatile int *)(base + off);
>
>                 munmap(base, mem_size);
>         }
>
>         return 0;
>   }
>
> Signed-off-by: Rui Wang <wangrui@loongson.cn>
> ---
>  arch/loongarch/mm/tlbex.S | 223 ++++++++++++++++----------------------
>  1 file changed, 93 insertions(+), 130 deletions(-)
>
> diff --git a/arch/loongarch/mm/tlbex.S b/arch/loongarch/mm/tlbex.S
> index 39743337999e..c97bcaad2ff4 100644
> --- a/arch/loongarch/mm/tlbex.S
> +++ b/arch/loongarch/mm/tlbex.S
> @@ -10,6 +10,11 @@
>  #include <asm/regdef.h>
>  #include <asm/stackframe.h>
>
> +#define PTRS_PER_PGD_BITS      (PAGE_SHIFT - 3)
> +#define PTRS_PER_PUD_BITS      (PAGE_SHIFT - 3)
> +#define PTRS_PER_PMD_BITS      (PAGE_SHIFT - 3)
> +#define PTRS_PER_PTE_BITS      (PAGE_SHIFT - 3)
> +
>         .macro tlb_do_page_fault, write
>         SYM_FUNC_START(tlb_do_page_fault_\write)
>         SAVE_ALL
> @@ -52,25 +57,17 @@ SYM_FUNC_START(handle_tlb_load)
>
>  vmalloc_done_load:
>         /* Get PGD offset in bytes */
> -       srli.d  t0, t0, PGDIR_SHIFT
> -       andi    t0, t0, (PTRS_PER_PGD - 1)
> -       slli.d  t0, t0, 3
> -       add.d   t1, t1, t0
> +       bstrpick.d      ra, t0, PTRS_PER_PGD_BITS + PGDIR_SHIFT - 1, PGDIR_SHIFT
> +       alsl.d          t1, ra, t1, 3
>  #if CONFIG_PGTABLE_LEVELS > 3
> -       csrrd   t0, LOONGARCH_CSR_BADV
>         ld.d    t1, t1, 0
> -       srli.d  t0, t0, PUD_SHIFT
> -       andi    t0, t0, (PTRS_PER_PUD - 1)
> -       slli.d  t0, t0, 3
> -       add.d   t1, t1, t0
> +       bstrpick.d      ra, t0, PTRS_PER_PUD_BITS + PUD_SHIFT - 1, PUD_SHIFT
> +       alsl.d          t1, ra, t1, 3
>  #endif
>  #if CONFIG_PGTABLE_LEVELS > 2
> -       csrrd   t0, LOONGARCH_CSR_BADV
>         ld.d    t1, t1, 0
> -       srli.d  t0, t0, PMD_SHIFT
> -       andi    t0, t0, (PTRS_PER_PMD - 1)
> -       slli.d  t0, t0, 3
> -       add.d   t1, t1, t0
> +       bstrpick.d      ra, t0, PTRS_PER_PMD_BITS + PMD_SHIFT - 1, PMD_SHIFT
> +       alsl.d          t1, ra, t1, 3
>  #endif
>         ld.d    ra, t1, 0
>
> @@ -79,27 +76,20 @@ vmalloc_done_load:
>          * instead contains the tlb pte. Check the PAGE_HUGE bit and
>          * see if we need to jump to huge tlb processing.
>          */
> -       andi    t0, ra, _PAGE_HUGE
> -       bnez    t0, tlb_huge_update_load
> +       rotri.d ra, ra, _PAGE_HUGE_SHIFT + 1
> +       bltz    ra, tlb_huge_update_load
>
> -       csrrd   t0, LOONGARCH_CSR_BADV
> -       srli.d  t0, t0, PAGE_SHIFT
> -       andi    t0, t0, (PTRS_PER_PTE - 1)
> -       slli.d  t0, t0, _PTE_T_LOG2
> -       add.d   t1, ra, t0
> +       rotri.d ra, ra, 64 - (_PAGE_HUGE_SHIFT + 1)
> +       bstrpick.d      t0, t0, PTRS_PER_PTE_BITS + PAGE_SHIFT - 1, PAGE_SHIFT
> +       alsl.d  t1, t0, ra, _PTE_T_LOG2
>
>  #ifdef CONFIG_SMP
>  smp_pgtable_change_load:
> -#endif
> -#ifdef CONFIG_SMP
>         ll.d    t0, t1, 0
>  #else
>         ld.d    t0, t1, 0
>  #endif
> -       tlbsrch
> -
> -       srli.d  ra, t0, _PAGE_PRESENT_SHIFT
> -       andi    ra, ra, 1
> +       andi    ra, t0, _PAGE_PRESENT
>         beqz    ra, nopage_tlb_load
>
>         ori     t0, t0, _PAGE_VALID
> @@ -109,8 +99,8 @@ smp_pgtable_change_load:
>  #else
>         st.d    t0, t1, 0
>  #endif
> -       ori     t1, t1, 8
> -       xori    t1, t1, 8
> +       tlbsrch
> +       bstrins.d       t1, zero, 3, 3
>         ld.d    t0, t1, 0
>         ld.d    t1, t1, 8
>         csrwr   t0, LOONGARCH_CSR_TLBELO0
> @@ -133,23 +123,22 @@ vmalloc_load:
>          */
>  tlb_huge_update_load:
>  #ifdef CONFIG_SMP
> -       ll.d    t0, t1, 0
> -#else
> -       ld.d    t0, t1, 0
> +       ll.d    ra, t1, 0
>  #endif
> -       srli.d  ra, t0, _PAGE_PRESENT_SHIFT
> -       andi    ra, ra, 1
> -       beqz    ra, nopage_tlb_load
> -       tlbsrch
> +       andi    t0, ra, _PAGE_PRESENT
> +       beqz    t0, nopage_tlb_load
>
> -       ori     t0, t0, _PAGE_VALID
>  #ifdef CONFIG_SMP
> +       ori     t0, ra, _PAGE_VALID
>         sc.d    t0, t1, 0
>         beqz    t0, tlb_huge_update_load
> -       ld.d    t0, t1, 0
> +       ori     t0, ra, _PAGE_VALID
>  #else
> +       rotri.d ra, ra, 64 - (_PAGE_HUGE_SHIFT + 1)
> +       ori     t0, ra, _PAGE_VALID
>         st.d    t0, t1, 0
>  #endif
> +       tlbsrch
>         addu16i.d       t1, zero, -(CSR_TLBIDX_EHINV >> 16)
>         addi.d          ra, t1, 0
>         csrxchg         ra, t1, LOONGARCH_CSR_TLBIDX
> @@ -173,9 +162,8 @@ tlb_huge_update_load:
>         srli.d  t1, t1, (_PAGE_HGLOBAL_SHIFT - _PAGE_GLOBAL_SHIFT)
>         or      t0, t0, t1
>
> -       addi.d  ra, t0, 0
> -       csrwr   t0, LOONGARCH_CSR_TLBELO0
> -       addi.d  t0, ra, 0
> +       move    ra, t0
> +       csrwr   ra, LOONGARCH_CSR_TLBELO0
>
>         /* Convert to entrylo1 */
>         addi.d  t1, zero, 1
> @@ -193,6 +181,11 @@ tlb_huge_update_load:
>         addu16i.d       t0, zero, (CSR_TLBIDX_PS >> 16)
>         addu16i.d       t1, zero, (PS_DEFAULT_SIZE << (CSR_TLBIDX_PS_SHIFT - 16))
>         csrxchg         t1, t0, LOONGARCH_CSR_TLBIDX
> +leave_huge_load:
> +       csrrd   t0, EXCEPTION_KS0
> +       csrrd   t1, EXCEPTION_KS1
> +       csrrd   ra, EXCEPTION_KS2
> +       ertn
>
>  nopage_tlb_load:
>         dbar    0
> @@ -215,26 +208,17 @@ SYM_FUNC_START(handle_tlb_store)
>
>  vmalloc_done_store:
>         /* Get PGD offset in bytes */
> -       srli.d  t0, t0, PGDIR_SHIFT
> -       andi    t0, t0, (PTRS_PER_PGD - 1)
> -       slli.d  t0, t0, 3
> -       add.d   t1, t1, t0
> -
> +       bstrpick.d      ra, t0, PTRS_PER_PGD_BITS + PGDIR_SHIFT - 1, PGDIR_SHIFT
> +       alsl.d          t1, ra, t1, 3
>  #if CONFIG_PGTABLE_LEVELS > 3
> -       csrrd   t0, LOONGARCH_CSR_BADV
>         ld.d    t1, t1, 0
> -       srli.d  t0, t0, PUD_SHIFT
> -       andi    t0, t0, (PTRS_PER_PUD - 1)
> -       slli.d  t0, t0, 3
> -       add.d   t1, t1, t0
> +       bstrpick.d      ra, t0, PTRS_PER_PUD_BITS + PUD_SHIFT - 1, PUD_SHIFT
> +       alsl.d          t1, ra, t1, 3
>  #endif
>  #if CONFIG_PGTABLE_LEVELS > 2
> -       csrrd   t0, LOONGARCH_CSR_BADV
>         ld.d    t1, t1, 0
> -       srli.d  t0, t0, PMD_SHIFT
> -       andi    t0, t0, (PTRS_PER_PMD - 1)
> -       slli.d  t0, t0, 3
> -       add.d   t1, t1, t0
> +       bstrpick.d      ra, t0, PTRS_PER_PMD_BITS + PMD_SHIFT - 1, PMD_SHIFT
> +       alsl.d          t1, ra, t1, 3
>  #endif
>         ld.d    ra, t1, 0
>
> @@ -243,28 +227,21 @@ vmalloc_done_store:
>          * instead contains the tlb pte. Check the PAGE_HUGE bit and
>          * see if we need to jump to huge tlb processing.
>          */
> -       andi    t0, ra, _PAGE_HUGE
> -       bnez    t0, tlb_huge_update_store
> +       rotri.d ra, ra, _PAGE_HUGE_SHIFT + 1
> +       bltz    ra, tlb_huge_update_store
>
> -       csrrd   t0, LOONGARCH_CSR_BADV
> -       srli.d  t0, t0, PAGE_SHIFT
> -       andi    t0, t0, (PTRS_PER_PTE - 1)
> -       slli.d  t0, t0, _PTE_T_LOG2
> -       add.d   t1, ra, t0
> +       rotri.d ra, ra, 64 - (_PAGE_HUGE_SHIFT + 1)
> +       bstrpick.d      t0, t0, PTRS_PER_PTE_BITS + PAGE_SHIFT - 1, PAGE_SHIFT
> +       alsl.d  t1, t0, ra, _PTE_T_LOG2
>
>  #ifdef CONFIG_SMP
>  smp_pgtable_change_store:
> -#endif
> -#ifdef CONFIG_SMP
>         ll.d    t0, t1, 0
>  #else
>         ld.d    t0, t1, 0
>  #endif
> -       tlbsrch
> -
> -       srli.d  ra, t0, _PAGE_PRESENT_SHIFT
> -       andi    ra, ra, ((_PAGE_PRESENT | _PAGE_WRITE) >> _PAGE_PRESENT_SHIFT)
> -       xori    ra, ra, ((_PAGE_PRESENT | _PAGE_WRITE) >> _PAGE_PRESENT_SHIFT)
> +       andi    ra, t0, _PAGE_PRESENT | _PAGE_WRITE
> +       xori    ra, ra, _PAGE_PRESENT | _PAGE_WRITE
>         bnez    ra, nopage_tlb_store
>
>         ori     t0, t0, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
> @@ -274,9 +251,8 @@ smp_pgtable_change_store:
>  #else
>         st.d    t0, t1, 0
>  #endif
> -
> -       ori     t1, t1, 8
> -       xori    t1, t1, 8
> +       tlbsrch
> +       bstrins.d       t1, zero, 3, 3
>         ld.d    t0, t1, 0
>         ld.d    t1, t1, 8
>         csrwr   t0, LOONGARCH_CSR_TLBELO0
> @@ -299,25 +275,23 @@ vmalloc_store:
>          */
>  tlb_huge_update_store:
>  #ifdef CONFIG_SMP
> -       ll.d    t0, t1, 0
> -#else
> -       ld.d    t0, t1, 0
> +       ll.d    ra, t1, 0
>  #endif
> -       srli.d  ra, t0, _PAGE_PRESENT_SHIFT
> -       andi    ra, ra, ((_PAGE_PRESENT | _PAGE_WRITE) >> _PAGE_PRESENT_SHIFT)
> -       xori    ra, ra, ((_PAGE_PRESENT | _PAGE_WRITE) >> _PAGE_PRESENT_SHIFT)
> -       bnez    ra, nopage_tlb_store
> -
> -       tlbsrch
> -       ori     t0, t0, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
> +       andi    t0, ra, _PAGE_PRESENT | _PAGE_WRITE
> +       xori    t0, t0, _PAGE_PRESENT | _PAGE_WRITE
> +       bnez    t0, nopage_tlb_store
>
>  #ifdef CONFIG_SMP
> +       ori     t0, ra, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
>         sc.d    t0, t1, 0
>         beqz    t0, tlb_huge_update_store
> -       ld.d    t0, t1, 0
> +       ori     t0, ra, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
>  #else
> +       rotri.d ra, ra, 64 - (_PAGE_HUGE_SHIFT + 1)
> +       ori     t0, ra, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
>         st.d    t0, t1, 0
>  #endif
> +       tlbsrch
>         addu16i.d       t1, zero, -(CSR_TLBIDX_EHINV >> 16)
>         addi.d          ra, t1, 0
>         csrxchg         ra, t1, LOONGARCH_CSR_TLBIDX
> @@ -340,9 +314,8 @@ tlb_huge_update_store:
>         srli.d  t1, t1, (_PAGE_HGLOBAL_SHIFT - _PAGE_GLOBAL_SHIFT)
>         or      t0, t0, t1
>
> -       addi.d  ra, t0, 0
> -       csrwr   t0, LOONGARCH_CSR_TLBELO0
> -       addi.d  t0, ra, 0
> +       move    ra, t0
> +       csrwr   ra, LOONGARCH_CSR_TLBELO0
>
>         /* Convert to entrylo1 */
>         addi.d  t1, zero, 1
> @@ -361,6 +334,11 @@ tlb_huge_update_store:
>         addu16i.d       t0, zero, (CSR_TLBIDX_PS >> 16)
>         addu16i.d       t1, zero, (PS_DEFAULT_SIZE << (CSR_TLBIDX_PS_SHIFT - 16))
>         csrxchg         t1, t0, LOONGARCH_CSR_TLBIDX
> +leave_huge_store:
> +       csrrd   t0, EXCEPTION_KS0
> +       csrrd   t1, EXCEPTION_KS1
> +       csrrd   ra, EXCEPTION_KS2
> +       ertn
>
>  nopage_tlb_store:
>         dbar    0
> @@ -383,25 +361,17 @@ SYM_FUNC_START(handle_tlb_modify)
>
>  vmalloc_done_modify:
>         /* Get PGD offset in bytes */
> -       srli.d  t0, t0, PGDIR_SHIFT
> -       andi    t0, t0, (PTRS_PER_PGD - 1)
> -       slli.d  t0, t0, 3
> -       add.d   t1, t1, t0
> +       bstrpick.d      ra, t0, PTRS_PER_PGD_BITS + PGDIR_SHIFT - 1, PGDIR_SHIFT
> +       alsl.d          t1, ra, t1, 3
>  #if CONFIG_PGTABLE_LEVELS > 3
> -       csrrd   t0, LOONGARCH_CSR_BADV
>         ld.d    t1, t1, 0
> -       srli.d  t0, t0, PUD_SHIFT
> -       andi    t0, t0, (PTRS_PER_PUD - 1)
> -       slli.d  t0, t0, 3
> -       add.d   t1, t1, t0
> +       bstrpick.d      ra, t0, PTRS_PER_PUD_BITS + PUD_SHIFT - 1, PUD_SHIFT
> +       alsl.d          t1, ra, t1, 3
>  #endif
>  #if CONFIG_PGTABLE_LEVELS > 2
> -       csrrd   t0, LOONGARCH_CSR_BADV
>         ld.d    t1, t1, 0
> -       srli.d  t0, t0, PMD_SHIFT
> -       andi    t0, t0, (PTRS_PER_PMD - 1)
> -       slli.d  t0, t0, 3
> -       add.d   t1, t1, t0
> +       bstrpick.d      ra, t0, PTRS_PER_PMD_BITS + PMD_SHIFT - 1, PMD_SHIFT
> +       alsl.d          t1, ra, t1, 3
>  #endif
>         ld.d    ra, t1, 0
>
> @@ -410,27 +380,20 @@ vmalloc_done_modify:
>          * instead contains the tlb pte. Check the PAGE_HUGE bit and
>          * see if we need to jump to huge tlb processing.
>          */
> -       andi    t0, ra, _PAGE_HUGE
> -       bnez    t0, tlb_huge_update_modify
> +       rotri.d ra, ra, _PAGE_HUGE_SHIFT + 1
> +       bltz    ra, tlb_huge_update_modify
>
> -       csrrd   t0, LOONGARCH_CSR_BADV
> -       srli.d  t0, t0, PAGE_SHIFT
> -       andi    t0, t0, (PTRS_PER_PTE - 1)
> -       slli.d  t0, t0, _PTE_T_LOG2
> -       add.d   t1, ra, t0
> +       rotri.d ra, ra, 64 - (_PAGE_HUGE_SHIFT + 1)
> +       bstrpick.d      t0, t0, PTRS_PER_PTE_BITS + PAGE_SHIFT - 1, PAGE_SHIFT
> +       alsl.d  t1, t0, ra, _PTE_T_LOG2
>
>  #ifdef CONFIG_SMP
>  smp_pgtable_change_modify:
> -#endif
> -#ifdef CONFIG_SMP
>         ll.d    t0, t1, 0
>  #else
>         ld.d    t0, t1, 0
>  #endif
> -       tlbsrch
> -
> -       srli.d  ra, t0, _PAGE_WRITE_SHIFT
> -       andi    ra, ra, 1
> +       andi    ra, t0, _PAGE_WRITE
>         beqz    ra, nopage_tlb_modify
>
>         ori     t0, t0, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
> @@ -440,8 +403,8 @@ smp_pgtable_change_modify:
>  #else
>         st.d    t0, t1, 0
>  #endif
> -       ori     t1, t1, 8
> -       xori    t1, t1, 8
> +       tlbsrch
> +       bstrins.d       t1, zero, 3, 3
>         ld.d    t0, t1, 0
>         ld.d    t1, t1, 8
>         csrwr   t0, LOONGARCH_CSR_TLBELO0
> @@ -464,23 +427,19 @@ vmalloc_modify:
>          */
>  tlb_huge_update_modify:
>  #ifdef CONFIG_SMP
> -       ll.d    t0, t1, 0
> -#else
> -       ld.d    t0, t1, 0
> +       ll.d    ra, t1, 0
>  #endif
> -
> -       srli.d  ra, t0, _PAGE_WRITE_SHIFT
> -       andi    ra, ra, 1
> -       beqz    ra, nopage_tlb_modify
> -
> -       tlbsrch
> -       ori     t0, t0, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
> +       andi    t0, ra, _PAGE_WRITE
> +       beqz    t0, nopage_tlb_modify
>
>  #ifdef CONFIG_SMP
> +       ori     t0, ra, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
>         sc.d    t0, t1, 0
>         beqz    t0, tlb_huge_update_modify
> -       ld.d    t0, t1, 0
> +       ori     t0, ra, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
>  #else
> +       rotri.d ra, ra, 64 - (_PAGE_HUGE_SHIFT + 1)
> +       ori     t0, ra, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
>         st.d    t0, t1, 0
>  #endif
>         /*
> @@ -499,9 +458,8 @@ tlb_huge_update_modify:
>         srli.d  t1, t1, (_PAGE_HGLOBAL_SHIFT - _PAGE_GLOBAL_SHIFT)
>         or      t0, t0, t1
>
> -       addi.d  ra, t0, 0
> -       csrwr   t0, LOONGARCH_CSR_TLBELO0
> -       addi.d  t0, ra, 0
> +       move    ra, t0
> +       csrwr   ra, LOONGARCH_CSR_TLBELO0
>
>         /* Convert to entrylo1 */
>         addi.d  t1, zero, 1
> @@ -520,6 +478,11 @@ tlb_huge_update_modify:
>         addu16i.d       t0, zero, (CSR_TLBIDX_PS >> 16)
>         addu16i.d       t1, zero, (PS_DEFAULT_SIZE << (CSR_TLBIDX_PS_SHIFT - 16))
>         csrxchg         t1, t0, LOONGARCH_CSR_TLBIDX
> +leave_huge_modify:
> +       csrrd   t0, EXCEPTION_KS0
> +       csrrd   t1, EXCEPTION_KS1
> +       csrrd   ra, EXCEPTION_KS2
> +       ertn
>
>  nopage_tlb_modify:
>         dbar    0
> --
> 2.37.3
>
