Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80EB63BC19
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiK2Iv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiK2IvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:51:00 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA4559866
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:50:37 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3b48b139b46so131667437b3.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Kp6Snka7N+b4UWFXmZ9UFoqx1hY6vmM2Ik02B3IWRw=;
        b=Hl8KHITtPPburveZxz28ekrymnjV7p7U0oCIfczeR7qfkWBme2pvSF346tbJK026oQ
         /z2c7I7y4Em7uH7NtuMnkFjAlw+CIJW9ls0Ce0bEYsV3RvruhEAjC1W6rGe0ljvS6Jxi
         YMTmi3ogMveuIz3s+p+NC62/JtqmQtK4YGB0f85lI7oOmHaAlIFXqjGz4xagkgLkJiFx
         2QdaYshWuiiIWuwNomWngyZGhFGsdQj2918FQV2QAJaxiixPJy08/CRnz4+RjvQaYpr4
         Xn9Kp3xe7V2aAplq0T7c7j51ImRtsJonXyKrFPhE8hj03TygclY+0Ihdp4epMBBH8R4K
         /4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Kp6Snka7N+b4UWFXmZ9UFoqx1hY6vmM2Ik02B3IWRw=;
        b=7o8H6TCRL6hQSng8J3OGdPs4WvfAFj9lUMaQa+V+DdsKEzE5w/+zarjw7u3NZTwOM9
         GhnsLtX2E58gb3LLoFnDhFM5QF0bZ9QtbjV3jkESWUUNGK0tORmv2H46lSad6cDOZpkn
         evb9iQKnSj9xh2V3rGbnLO5ZePSUMoyCxhANOs2KKYkoPy4cLNwMu747bIP5oor0hAl3
         EOlNyZE8av87MhTyFym4fage5kqfxYKeXDeYupL3jxXB1zwkY9HSWb1irq+zH29RJh9t
         xoLaH3TAWNcyvOdmxKrZHRxfYw/kzCX0ugx/vQGc/DRRm3jU7siguV5o7sVsV/9yI6Xr
         E58g==
X-Gm-Message-State: ANoB5pnrooa/hBpa+fFkJvrlzZfZ78jy4N7u+NtgkS3ksMzCbzkrmBV/
        Lv22ZhY/+ZDCGCB6Or1RJ5hDVzMSSO2l71hVljk=
X-Google-Smtp-Source: AA0mqf5cF1az9DH687NxUDMyTcNhzp8L8Fg0Sx07n5rBK0e7nd/ftoq52BzM4cDLdZwmiJZLZJpVbw75aABa3N0lvLw=
X-Received: by 2002:a81:4642:0:b0:36a:ca92:d207 with SMTP id
 t63-20020a814642000000b0036aca92d207mr37912558ywa.429.1669711836482; Tue, 29
 Nov 2022 00:50:36 -0800 (PST)
MIME-Version: 1.0
References: <20221104124546.196077-1-ubizjak@gmail.com> <Y4U0GwlLgAuxu3WF@zn.tnic>
 <CAFULd4Yjp+sNqZrt9kq2orodNckQOWAGi84ZZeXRFPLyE65HPQ@mail.gmail.com> <Y4XDVbuYtFUYCrur@zn.tnic>
In-Reply-To: <Y4XDVbuYtFUYCrur@zn.tnic>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Tue, 29 Nov 2022 09:50:25 +0100
Message-ID: <CAFULd4Yv9ZYu_mWwFBGheJ7_XsP6Ok1uCCPDr-ChDK4yzOK3qA@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: Remove x86_32 PIC using ebx workaround
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
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

On Tue, Nov 29, 2022 at 9:31 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Nov 29, 2022 at 08:39:23AM +0100, Uros Bizjak wrote:
> > On Mon, Nov 28, 2022 at 11:20 PM Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > On Fri, Nov 04, 2022 at 01:45:46PM +0100, Uros Bizjak wrote:
> > > > Current minimum required version of GCC is version 5.1 which allows
> > > > reuse of PIC hard register on x86/x86-64 targets [1]. Remove
> > > > obsolete workaround that was needed for earlier GCC versions.
> > > >
> > > > [1] https://gcc.gnu.org/gcc-5/changes.html
> > >
> > > Thanks for the doc pointer.
> > >
> > > Lemme see if I understand this commit message correctly:
> > >
> > > SysV i386 ABI says that %ebx is used as the base reg in PIC. gcc 5 and
> > > newer can handle all possible cases properly where inline asm could
> > > clobber the PIC reg. I.e., it is able to deal with the "=b" constraint
> > > where an insn can overwrite %ebx and it'll push and pop around that
> > > statement.
> >
> > gcc-5 considers PIC register as a pseudo-register and reloads it
>
> So not a "hard" register as you say above?

There are registers of different "hardness" as far as gcc is
concerned. Before gcc-5.1, PIC register was considered as "fixed", it
was simply unavailable to a register allocator, decreasing the
miniscule available x86_32 register set by one register. Also, RA was
unable to satisfy the "=b" constraint. OTOH, a pseudo register belongs
to a certain class of registers (e.g. integer registers) and when
allocating real ("hard" ) registers, RA uses instruction (or inline
asm) register constraints to allocate correct "hard" register. In this
aspect, PIC access "requires" %ebx register in the same way as e.g.
shift instructions "require" %cl register. gcc-5.1 allows RA much more
freedom of how to use %ebx register - it can be used for other
purposes , as long as it is reloaded with correct value before insn
with PIC access.

> > x86_64 does not use PIC register for small code models. Also, it uses
> > %r15 instead of %rbx for PIC register, so the removed workaround
> > applies only to x86_32.
>
> Let's see:
>
> arch/x86/Makefile:
>         # Never want PIC in a 32-bit kernel, prevent breakage with GCC built
>         # with nonstandard options
>         KBUILD_CFLAGS += -fno-pic
>
> $ gcc -Wp,-MMD,arch/x86/boot/.cpuflags.o.d ... -fno-pic ... -D__KBUILD_MODNAME=kmod_cpuflags -c -o arch/x86/boot/cpuflags.o arch/x86/boot/cpuflags.c
>
> So this workaround applies to nothing, I'd say. :)

It looks like the workaround serves no purpose even when compiled with
gcc < 5.1.

Uros.
