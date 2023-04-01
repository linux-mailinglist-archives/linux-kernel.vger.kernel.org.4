Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD3E6D2E49
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 07:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbjDAFHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 01:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjDAFHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 01:07:05 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F09CA19
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 22:07:03 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-545cb3c9898so378124547b3.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 22:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680325623; x=1682917623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/aEqUte0lNXntaneblg1P8pMDFx/ZTQ1XphUPsTzEbw=;
        b=cosa0K89QI5z2Tm18Y7gFzYHWnwTgf2EzxnI6l0nhEKtzIghNaj7FMjVCvg5Ywnt+T
         cL3VgJX4wG5P8gZxVnnXH46VL6pCXJRN0JLnwuX6BdX3pJ6KjdoQA3F4QqNKDp9TuFyU
         K9LuHYuQ9Z/5vEEe0Oea03kR84S111z6arZSQYSE5Hxa3xNHVLzq2p+RU3eqnLvdf6R0
         kMBDC9OMDZniUb0iVtHbO9M1oBuIIIjUbNZOfA9/1EClwaqrZHBF8SZkq4vfBOtuGeLI
         GdZzdrBw3n/i0+CCFuKnIm5NXxo/PY6OAUZen571AMDRBzpBe7QFs/GBgDtAO/JS4jda
         ctoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680325623; x=1682917623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/aEqUte0lNXntaneblg1P8pMDFx/ZTQ1XphUPsTzEbw=;
        b=ooahfu73Oersc7E16lJ+XdlPdc4j4q4tTClhKYO0NgDAlndDj6vw0/rV2xBP1N0DvV
         bnPvP1taglUvaK24h1eqfxNfk+rAqc3R1phRQGbBysboHuTM4rvjdonBrYbSnXis8uuZ
         6HG8+LlvwPlEHSsIV7/OBPic8wjqG1Y9XDyiNmVjvhHkhKdiIJFTWwy+YqMe7nFygUHn
         LbJBA6damvFwU21NRRImYTsCLldGdgIRnvdD0vcwOmSjIlfp+7ILCzZWivPcHEC3vpmA
         LDDZwKoFk1mWGxbHK3urBD2rIgEr0ww0y8ruF7yAhSTrDcYBwnFWoiQ+pyyxY3OxLF1I
         qaBg==
X-Gm-Message-State: AAQBX9fONutZ3U7hxGu0R0WlwcTI2/e+S1tJwCJxgb43hB6yeoZrN/EU
        iY5kpznQp1MNBh9V5JLZLpjjjq7Zgu3G55BpzA==
X-Google-Smtp-Source: AKy350bbCnV1bYRdzldfCOPfLthZAsFYYtpVkKBzRY9HZNMd94CO94zisI6FgsFeOwNoG1kh5+yrg68K7EBDNAbC2Go=
X-Received: by 2002:a0d:ec12:0:b0:545:bade:c590 with SMTP id
 q18-20020a0dec12000000b00545badec590mr12653394ywn.1.1680325622780; Fri, 31
 Mar 2023 22:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230331182839.13960-1-brgerst@gmail.com> <659B7DAA-7D24-4122-8A66-B490E0AFDEA0@zytor.com>
In-Reply-To: <659B7DAA-7D24-4122-8A66-B490E0AFDEA0@zytor.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Sat, 1 Apr 2023 01:06:51 -0400
Message-ID: <CAMzpN2hPtU=1HGxEycEXKS-0syE9_36J5HXD2VPwkskBKD0Bww@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: Clean up handling of boot_params pointer
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 9:00=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> On March 31, 2023 11:28:39 AM PDT, Brian Gerst <brgerst@gmail.com> wrote:
> >On entry from the bootloader, RSI contains the pointer to the
> >boot_params data structure.  Since the RSI register can be clobbered
> >when calling C functions, it is saved and restored around every call.
> >Instead, move it to the R12 register, which is preserved across calls.
> >
> >Signed-off-by: Brian Gerst <brgerst@gmail.com>
> >---
> > arch/x86/kernel/head_64.S | 29 ++++++++++-------------------
> > 1 file changed, 10 insertions(+), 19 deletions(-)
> >
> >diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> >index a5df3e994f04..0d130ca2e0a3 100644
> >--- a/arch/x86/kernel/head_64.S
> >+++ b/arch/x86/kernel/head_64.S
> >@@ -49,8 +49,6 @@ SYM_CODE_START_NOALIGN(startup_64)
> >        * for us.  These identity mapped page tables map all of the
> >        * kernel pages and possibly all of memory.
> >        *
> >-       * %rsi holds a physical pointer to real_mode_data.
> >-       *
> >        * We come here either directly from a 64bit bootloader, or from
> >        * arch/x86/boot/compressed/head_64.S.
> >        *
> >@@ -61,6 +59,12 @@ SYM_CODE_START_NOALIGN(startup_64)
> >        * tables and then reload them.
> >        */
> >
> >+      /*
> >+       * RSI holds a physical pointer to real_mode_data.  Move it to R1=
2,
> >+       * which is preserved across C function calls.
> >+       */
> >+      movq    %rsi, %r12
> >+
> >       /* Set up the stack for verify_cpu() */
> >       leaq    (__end_init_task - PTREGS_SIZE)(%rip), %rsp
> >
> >@@ -73,9 +77,7 @@ SYM_CODE_START_NOALIGN(startup_64)
> >       shrq    $32,  %rdx
> >       wrmsr
> >
> >-      pushq   %rsi
> >       call    startup_64_setup_env
> >-      popq    %rsi
> >
> > #ifdef CONFIG_AMD_MEM_ENCRYPT
> >       /*
> >@@ -84,10 +86,8 @@ SYM_CODE_START_NOALIGN(startup_64)
> >        * which needs to be done before any CPUID instructions are execu=
ted in
> >        * subsequent code.
> >        */
> >-      movq    %rsi, %rdi
> >-      pushq   %rsi
> >+      movq    %r12, %rdi
> >       call    sme_enable
> >-      popq    %rsi
> > #endif
> >
> >       /* Now switch to __KERNEL_CS so IRET works reliably */
> >@@ -109,9 +109,8 @@ SYM_CODE_START_NOALIGN(startup_64)
> >        * programmed into CR3.
> >        */
> >       leaq    _text(%rip), %rdi
> >-      pushq   %rsi
> >+      movq    %r12, %rsi
> >       call    __startup_64
> >-      popq    %rsi
> >
> >       /* Form the CR3 value being sure to include the CR3 modifier */
> >       addq    $(early_top_pgt - __START_KERNEL_map), %rax
> >@@ -125,8 +124,6 @@ SYM_CODE_START(secondary_startup_64)
> >        * At this point the CPU runs in 64bit mode CS.L =3D 1 CS.D =3D 0=
,
> >        * and someone has loaded a mapped page table.
> >        *
> >-       * %rsi holds a physical pointer to real_mode_data.
> >-       *
> >        * We come here either from startup_64 (using physical addresses)
> >        * or from trampoline.S (using virtual addresses).
> >        *
> >@@ -197,13 +194,9 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM=
_L_GLOBAL)
> >        * hypervisor could lie about the C-bit position to perform a ROP
> >        * attack on the guest by writing to the unencrypted stack and wa=
it for
> >        * the next RET instruction.
> >-       * %rsi carries pointer to realmode data and is callee-clobbered.=
 Save
> >-       * and restore it.
> >        */
> >-      pushq   %rsi
> >       movq    %rax, %rdi
> >       call    sev_verify_cbit
> >-      popq    %rsi
> >
> >       /*
> >        * Switch to new page-table
> >@@ -294,9 +287,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_=
L_GLOBAL)
> >       wrmsr
> >
> >       /* Setup and Load IDT */
> >-      pushq   %rsi
> >       call    early_setup_idt
> >-      popq    %rsi
> >
> >       /* Check if nx is implemented */
> >       movl    $0x80000001, %eax
> >@@ -332,9 +323,9 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_=
L_GLOBAL)
> >       pushq $0
> >       popfq
> >
> >-      /* rsi is pointer to real mode structure with interesting info.
> >+      /* R12 is pointer to real mode structure with interesting info.
> >          pass it to C */
> >-      movq    %rsi, %rdi
> >+      movq    %r12, %rdi
> >
> > .Ljump_to_C_code:
> >       /*
>
> Would it not make more sense to write it into a memory variable and acces=
sing that variable from the C code by name?

I think ideally we'd want to copy the real mode data as early as
possible.  However I don't know how that would interact with memory
encryption.  By reading the code, I think it would work, but I don't
have the hardware to test it.

--
Brian Gerst
