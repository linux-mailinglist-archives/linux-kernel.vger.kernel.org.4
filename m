Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBDF5B3BAB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbiIIPQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiIIPQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:16:53 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E6313BC41
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 08:16:51 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s206so1869863pgs.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 08:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=pkkVHpxNti+LsS3RaFIJvYPZ50QQRqshmqnZyXM7B3w=;
        b=6ol+C+uUDiV63QxAnyAd+FdZy3jMWxRuxeIc7GvOQ1jyxLQw+/rRNPhQeUcjI0dsSh
         EZPZzZkrB6l3ZWBTUpMvgIoF1YKWQ639NuucTNTS1p2Wre/1OlD+bhmYJ0YYt8PDtGcS
         TH3F7N0o2E3DlnYd38f6XbuuPlVjfyNWoEid7zeSU7b6Rk2r2r84wOA1Mzylbkk+U2px
         m3V8XWG6+zA9jyni1v/sSFtvFOVDi8ZEVBRFJTEd+WhV2q4jp1b2cn4DxB3UQ+CajZRK
         6xl5I93Gp1vTaKbsM5aCwU6g+Aqa08DYT82e2P1xn1fLyqg3oeFHWW6HzqBfMmRFd2O7
         KYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=pkkVHpxNti+LsS3RaFIJvYPZ50QQRqshmqnZyXM7B3w=;
        b=7SSiW/ayoUhSVEiV1n7NXbODz/+9g715BVAgFfTpaED0mnq0TdqNthLvtDakIMTdCu
         neylojZ5aJ1WNxTWGsUlpbE7yWqD9R9geH1g/Qjxa9f7K1BLe55hF+kq7M5ApM1eaJ/w
         1+xIVHlv3CUqWAU9Yjal0inXW/CsLUYXCycjEgEXrfxT6oaEjlQLbFHroqBDpzwe0Utf
         WJMo8auGznegK4GF7zjvnvX3INdkWdoGN5BA3FW4bgisKAjCkJmyylK/aGpaSSIL46lZ
         J5mCZUgjvAgkDRTZBxjhqkswmUBSnhZ+/6LtXs3Ik+a7KUsjfr1i38Jkw7FZXS0M5f6y
         7nDw==
X-Gm-Message-State: ACgBeo1aaVNU96zxjZF0YOvM8LuQc6HJ/4/26E+m8eRQ0bSGdCoSp+Hs
        N9xax4lWlCQX7SdcKrziUIQMDPXbJDfsVLJDwgK2ag==
X-Google-Smtp-Source: AA6agR6LdKaOyngOkbvfwpeXfscLxrHabNg5RtikZKiPDkYgMtFK31EsFeKXXo3Tvi2lB3Pmia+Br9R/MCzI61MCTcY=
X-Received: by 2002:a63:8a4a:0:b0:434:c99c:6fd4 with SMTP id
 y71-20020a638a4a000000b00434c99c6fd4mr12302087pgd.24.1662736611033; Fri, 09
 Sep 2022 08:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220908170133.1159747-1-abrestic@rivosinc.com>
 <20220908185006.1212126-1-abrestic@rivosinc.com> <2f5059f6-b024-1ee8-b961-5aa0b4e4c116@gmail.com>
 <dfd6cfd9-5985-030f-4c77-f9037dcebe90@gmail.com>
In-Reply-To: <dfd6cfd9-5985-030f-4c77-f9037dcebe90@gmail.com>
From:   Andrew Bresticker <abrestic@rivosinc.com>
Date:   Fri, 9 Sep 2022 11:16:40 -0400
Message-ID: <CALE4mHoDbh2Aq7eotzKAeqy80n29LWkuP+gjv8ADH7pTJAYQhQ@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: Make mmap() with PROT_WRITE imply PROT_READ
To:     Coelacanthus <coelacanthushex@gmail.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        dram <dramforever@live.com>, Ruizhe Pan <c141028@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 9, 2022 at 7:42 AM Coelacanthus <coelacanthushex@gmail.com> wrote:
>
> On 2022/9/9 11:01, Celeste Liu wrote:
> > On 2022/9/9 02:50, Andrew Bresticker wrote:
> >> Commit 2139619bcad7 ("riscv: mmap with PROT_WRITE but no PROT_READ is
> >> invalid") made mmap() return EINVAL if PROT_WRITE was set wihtout
> >> PROT_READ with the justification that a write-only PTE is considered a
> >> reserved PTE permission bit pattern in the privileged spec. This check
> >> is unnecessary since RISC-V defines its protection_map such that PROT_WRITE
> >> maps to the same PTE permissions as PROT_WRITE|PROT_READ, and it is
> >> inconsistent with other architectures that don't support write-only PTEs,
> >> creating a potential software portability issue. Just remove the check
> >> altogether and let PROT_WRITE imply PROT_READ as is the case on other
> >> architectures.
> >>
> >> Note that this also allows PROT_WRITE|PROT_EXEC mappings which were
> >> disallowed prior to the aforementioned commit; PROT_READ is implied in
> >> such mappings as well.
> >>
> >> Fixes: 2139619bcad7 ("riscv: mmap with PROT_WRITE but no PROT_READ is invalid")
> >> Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
> >> ---
> >> v1 -> v2: Update access_error() to account for write-implies-read
> >> ---
> >>  arch/riscv/kernel/sys_riscv.c | 3 ---
> >>  arch/riscv/mm/fault.c         | 3 ++-
> >>  2 files changed, 2 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> >> index 571556bb9261..5d3f2fbeb33c 100644
> >> --- a/arch/riscv/kernel/sys_riscv.c
> >> +++ b/arch/riscv/kernel/sys_riscv.c
> >> @@ -18,9 +18,6 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
> >>      if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
> >>              return -EINVAL;
> >>
> >> -    if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))
> >> -            return -EINVAL;
> >> -
> >>      return ksys_mmap_pgoff(addr, len, prot, flags, fd,
> >>                             offset >> (PAGE_SHIFT - page_shift_offset));
> >>  }
> >> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> >> index f2fbd1400b7c..d86f7cebd4a7 100644
> >> --- a/arch/riscv/mm/fault.c
> >> +++ b/arch/riscv/mm/fault.c
> >> @@ -184,7 +184,8 @@ static inline bool access_error(unsigned long cause, struct vm_area_struct *vma)
> >>              }
> >>              break;
> >>      case EXC_LOAD_PAGE_FAULT:
> >> -            if (!(vma->vm_flags & VM_READ)) {
> >> +            /* Write implies read */
> >> +            if (!(vma->vm_flags & (VM_READ | VM_WRITE))) {
> >>                      return true;
> >>              }
> >>              break;
> >
> > Hi, this did solve the problem and achieved consistency between
> > architectures, but I have a question.
> >
> > Such a change specifies behavior for a state that should not exist,
> > and if, in the future, RISC-V spec specifies a different behavior
> > for that state (I mean, RVI itself has a history of not caring about
> > downstream, like Zicsr and Zifencei), it will create inconsistencies,
> > which is bad.
> >
> > If we reject the "write but not read" state, the user gets the most direct
> > response: the state is not allowed so that they do not and cannot rely
> > on the behavior of the state. This will bring better time consistency
> > to the application if the spec specifies the behavior in the future.
> > But it lost architecture consistency.
> >
> > How do you think this situation should be handled properly?
> >
> > Yours,
> > Celeste Liu
>
> Oops!
>
> I found a mistake in my previous understanding: PTE permission!=vma permission.
> So your modification makes sense, no matter how we handle the mapping of input
> permissions to PTEs, as long as we don't use the reserved permission combinations,
> the behavior is reasonable and also independent of the architecture's definition
> of PTEs.
>
> But I think this mapping relationship should be well documented. If we have
> such a mapping behavior in all architectures, then we should change this line in
> the mmap documentation
>     On some hardware architectures (e.g., i386), PROT_WRITE implies PROT_READ.
> to apply all architectures. According to my read about code, all the vm_get_page_prot
> will do the protection_map mapping to have this feature.

I think leaving the PROT_WRITE-implies-PROT_READ as being specified as
architecture-dependent is reasonable, but of course portable programs
shouldn't rely on this behavior. There are CPUs out there that support
write-only mappings -- MIPS with RI/XI comes to mind and indeed
mmap(PROT_WRITE) on such CPUs results in write-only mappings.

-Andrew

>
> Yours,
> Celeste Liu
