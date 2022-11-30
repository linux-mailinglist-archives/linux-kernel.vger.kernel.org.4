Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C597163CD93
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 03:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbiK3C5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 21:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiK3C5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 21:57:16 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514C65B5A2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 18:57:15 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id p27-20020a056830319b00b0066d7a348e20so10412466ots.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 18:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yqRh6zFYfdvcwjVTC7gbxOs3fLzw2E3nIla7lM5ElzY=;
        b=inGuix8UwubRSyaLlm7ASL/4E2+avb2XsMoo27gGrOexgnR0Ee/diox6DrhUByiZTE
         iBP8PVzt3u7S6vmCZfIJYo1ObtAKapo1PVLuP4FgWmy1gEHltDhZc0f8VkN5PS3fnCt7
         u7JDzod7SsNbuDjPRSLyGeJZVKbcCokqYuIOh1P2aC40DubZAFM11PewnxTMu+Wjz6xr
         zj+lzF8ldRnFchCYpFfA9DVmviI08ttIChBOA6Qtz2Av+G4DFnmf+PiI59c1uYIamv/+
         90Mtbasdv3CsfyAqtzWCfVh1emh1wPoFZ2JCUTIqXqUQcFXzaTXgmq5NGJpwrm7VAMw+
         40ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yqRh6zFYfdvcwjVTC7gbxOs3fLzw2E3nIla7lM5ElzY=;
        b=amRjj4cHf2aLHv4RprXvHH8HliySJ7vvIqCNv8/dxIkyKoL0iZiP5YcMFMKq8D7X/f
         vsro1qJ8kWrvY6Vz9GLWUkencudJw5blBJKlap89scf75le1L2fWyV7ogf3CdO8EMsc6
         PRPX5KEf46r93ED/c9hkWrlnKNTo0S3/AZF2UYuUx9X/EfhtH93A1MJRaDbEULC/bB9+
         nlIL3AqSHWmHFnAzbjpGZta0sKN4YRW6Ek0PG9PsUUuaWl1P7/AuCYfUFb9sJMUDHuNa
         gN2bLGqgiO4qiSd8/3Glo6m+tsblxsZJX70YmsoUp9qY7FKik4WleEVVEHsAmi0Q0ERv
         tJgw==
X-Gm-Message-State: ANoB5pmKUnTZv/oX85S82h/LIM5Dywt1t+s7BIPHOm0YzMf47rj0S2Ge
        iCtyuVFefDEcXOATSKThK9wnYDXTYwEt1Fot+Fw=
X-Google-Smtp-Source: AA0mqf7SyGB2YZO1KCxAp/1+577LPkjcSeAjdac5fv8pZSEhRgwI9D6ztKN2yMNUB3avU6+cECiz+rDOEKnFdHusuxo=
X-Received: by 2002:a9d:6a44:0:b0:66c:fb5b:1d67 with SMTP id
 h4-20020a9d6a44000000b0066cfb5b1d67mr30211208otn.111.1669777034528; Tue, 29
 Nov 2022 18:57:14 -0800 (PST)
MIME-Version: 1.0
References: <CAMKF1srMj5aH4_+iwbFuu+AEgyyz85y+UPEszUGeQ7U=u19R3Q@mail.gmail.com>
 <mhng-0a99c7e2-7e15-4a5f-a5fa-1e4c844a5ecd@palmer-ri-x1c9a>
In-Reply-To: <mhng-0a99c7e2-7e15-4a5f-a5fa-1e4c844a5ecd@palmer-ri-x1c9a>
From:   Khem Raj <raj.khem@gmail.com>
Date:   Tue, 29 Nov 2022 18:56:48 -0800
Message-ID: <CAMKF1sryF=inn0B=n=cZi7ZmRcWh3cAtR4uq9DYJfVpD_zOpVA@mail.gmail.com>
Subject: Re: [PATCH 1/2] RISC-V: Align the shadow stack
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     jszhang@kernel.org, guoren@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 6:50 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> On Tue, 29 Nov 2022 18:47:55 PST (-0800), Khem Raj wrote:
> > Hi Palmer
> >
> > On Tue, Nov 29, 2022 at 6:36 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
> >>
> >> The standard RISC-V ABIs all require 16-byte stack alignment.  We're
> >> only calling that one function on the shadow stack so I doubt it'd
> >> result in a real issue, but might as well keep this lined up.
> >
> > Is 16-byte alignment required on rv32 as well ?
>
> For the standard ABIs that's the case, it's so the Q extension can spill
> without aligning the stack.  There's also at least a proposed embedded
> ABI that has just XLEN (32-bit on rv32) alignment, as the bigger stack
> alignment has an impact on some use cases.

Thanks, so in this case 16byte will be valid for both rv64/rv32 here.

>
> >> Fixes: 31da94c25aea ("riscv: add VMAP_STACK overflow detection")
> >> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> >> ---
> >>  arch/riscv/kernel/traps.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> >> index be54ccea8c47..acdfcacd7e57 100644
> >> --- a/arch/riscv/kernel/traps.c
> >> +++ b/arch/riscv/kernel/traps.c
> >> @@ -206,7 +206,7 @@ static DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)],
> >>   * shadow stack, handled_ kernel_ stack_ overflow(in kernel/entry.S) is used
> >>   * to get per-cpu overflow stack(get_overflow_stack).
> >>   */
> >> -long shadow_stack[SHADOW_OVERFLOW_STACK_SIZE/sizeof(long)];
> >> +long shadow_stack[SHADOW_OVERFLOW_STACK_SIZE/sizeof(long)] __aligned(16);
> >>  asmlinkage unsigned long get_overflow_stack(void)
> >>  {
> >>         return (unsigned long)this_cpu_ptr(overflow_stack) +
> >> --
> >> 2.38.1
> >>
> >>
> >> _______________________________________________
> >> linux-riscv mailing list
> >> linux-riscv@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-riscv
