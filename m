Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A50C648955
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 20:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiLIT7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 14:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiLIT7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 14:59:18 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E184E275F0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 11:58:52 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id mn15so3747414qvb.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 11:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAsqCIFgPt6BSntE2zK/1grKaxatSUFCPk0z0wIkAOI=;
        b=UE0ilwfG5ft6c+WNo48Hu5oJEUZt2YPjH/PVnZ40KzSKlmJi3jIAD3drUF6Tw1bJQN
         Q52cdO2w12c+G3TuI4zkOo20GjaJT9NksWJ8C1f8TW4yWn0TEvxnPC2Z0lQI7U1Gp6Rh
         bbRoIfjihl5wOovQ+clxwm7M/fvK8guNtDptvNEq29G+yWnjNeGmOtKD4b40VtEEQpcn
         t+UkhotjE+UELGPLOceW0Aln8BhFPJNwPpuw0lKZPrfEGORAGihSKvJGdYhftF2GJdEG
         M3LIUnLhFOvnwQJCUNnMkLuWhybgwLZq1W+dIoFcWJFWzSlM451nT8CyPgTNQT5Bwa1u
         8A9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZAsqCIFgPt6BSntE2zK/1grKaxatSUFCPk0z0wIkAOI=;
        b=T1+xdaR0S29Wwpj2KP2YrzrgMiptcc86wIpDAS7YGFmjKUz6md5yv5jgmfu2ohRmD+
         PQaaFWXLxObPTsu01YyKLr+Rg2TtIUl+zB6BKdnoeBE9X3A77OZc/eH5RiXRM32kPUUp
         bePxmt3CcXo/FeOiLv4MWIHv2S82DF1LdZUXZZ2+DyKMnSZCBOJlipRyso95OgkUrea4
         0x2/1fCc5tlNDNCOcd+cq3KbzM2yjlIdDSlJVbXak2cHbj4nz6L1Q4txTGHRtdo6WtXF
         RTW08OlbkJJ8EVaDDsi7aEGWUOIaIbBdlQCYwDUxLBCO0rE7IabZwshaThBXU8R83Zqj
         YHxw==
X-Gm-Message-State: ANoB5pkBOTxN/vHDKQCugYpL9SAmypJL4Suw7Z/NAoL3dj7BR9xH2Qzv
        KMhlYRbYSK9iKdgSn14K1NQDDQzHCafxEWViSK0Ym+dubE41Zg2QxhxiahH4SDwZqffUdwEqJZ3
        ehGGkkN6NwJIQLFSvAUUBptYuWb00VXhNZjUruEJN6D9cEsCUUKZXbrqIKT6TL0NT/bCu2vzaUv
        fc4Q==
X-Google-Smtp-Source: AA0mqf6RcK9eByEcPyUjUk2qnmpnl7kwj2v8T2v/MzSZXsjgQN78p1AbuhO6VwSsGCmya09XAQSJhw==
X-Received: by 2002:a0c:d843:0:b0:4b4:94d8:513e with SMTP id i3-20020a0cd843000000b004b494d8513emr9061735qvj.0.1670615930983;
        Fri, 09 Dec 2022 11:58:50 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id w5-20020a05620a444500b006eed75805a2sm523565qkp.126.2022.12.09.11.58.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 11:58:49 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id b16so6837528yba.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 11:58:48 -0800 (PST)
X-Received: by 2002:a5b:b45:0:b0:6f8:ce8a:57a5 with SMTP id
 b5-20020a5b0b45000000b006f8ce8a57a5mr40756849ybr.26.1670615928410; Fri, 09
 Dec 2022 11:58:48 -0800 (PST)
MIME-Version: 1.0
References: <mhng-975b1d7b-7b3f-4e88-804c-8b22787f9588@palmer-ri-x1c9> <e9cf13a9-561a-3438-00f0-41fe2631888d@rivosinc.com>
In-Reply-To: <e9cf13a9-561a-3438-00f0-41fe2631888d@rivosinc.com>
From:   Andrew Waterman <andrew@sifive.com>
Date:   Fri, 9 Dec 2022 11:58:37 -0800
X-Gmail-Original-Message-ID: <CA++6G0Bg8-uD+F+5JMcsu6jnMwnSSFAtH=ZEZjRqK1KHSW7C8w@mail.gmail.com>
Message-ID: <CA++6G0Bg8-uD+F+5JMcsu6jnMwnSSFAtH=ZEZjRqK1KHSW7C8w@mail.gmail.com>
Subject: Re: RISCV Vector unit disabled by default for new task (was Re:
 [PATCH v12 17/17] riscv: prctl to enable vector commands)
To:     Vineet Gupta <vineetg@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, fweimer@redhat.com,
        stillson@rivosinc.com, Paul Walmsley <paul.walmsley@sifive.com>,
        anup@brainfault.org, atishp@atishpatra.org, guoren@kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        greentime.hu@sifive.com, vincent.chen@sifive.com,
        andy.chiu@sifive.com, arnd@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        bjorn@kernel.org, libc-alpha@sourceware.org,
        christoph.muellner@vrull.eu, Aaron Durbin <adurbin@rivosinc.com>,
        linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 9, 2022 at 11:42 AM Vineet Gupta <vineetg@rivosinc.com> wrote:
>
>
> On 12/9/22 09:21, Palmer Dabbelt wrote:
> > On Fri, 09 Dec 2022 05:04:23 PST (-0800), fweimer@redhat.com wrote:
> >> * Darius Rad:
> >>
> >>> On Fri, Dec 09, 2022 at 01:32:33PM +0100, Florian Weimer via
> >>> Libc-alpha wrote:
> >>>> * Darius Rad:
> >>>>
> >>>> > On Fri, Dec 09, 2022 at 11:02:57AM +0100, Florian Weimer wrote:
> >>>> >> * Andrew Waterman:
> >>>> >>
> >>>> >> > This suggests that ld.so, early-stage libc, or possibly both
> >>>> will need
> >>>> >> > to make this prctl() call, perhaps by parsing the ELF headers
> >>>> of the
> >>>> >> > binary and each library to determine if the V extension is used.
> >>>> >>
> >>>> >> If the string functions use the V extension, it will be enabled
> >>>> >> unconditionally.  So I don't see why it's okay for libc to
> >>>> trigger this
> >>>> >> alleged UAPI change, when the kernel can't do it by default.
> >>>> >>
> >>>> >
> >>>> > Because the call to enable can fail and userspace needs to deal
> >>>> with that.
> >>>>
> >>>> Failure is usually indicated by an AT_HWCAP or AT_HWCAP2 bit remaining
> >>>> zero, or perhaps a special CPU register (although that is more
> >>>> unusual).
> >>>
> >>> That would indicate that the extension is not present, which is one
> >>> of, but
> >>> not the only way it can fail.
> >>
> >> I think you should bring down the number of failure modes. HWCAP has
> >> the advantage that it communicates kernel/hypervisor/firmware/CPU
> >> support in a single bit, which simplifies the programming model and
> >> avoids hard-to-detect bugs.  It's not clear why it would be beneficial
> >> to continue on ENOMEM failures here because the system must clearly be
> >> in bad shape at this point, and launching a new process is very unlikely
> >> to improve matters.  So I think the simpler programming model is the way
> >> to go here.
> >>
> >>> The vector extension relies on dynamically allocated memory in the
> >>> kernel,
> >>> which can fail.
> >
> > The issue I'm worried about is that V needs more space in the
> > ucontext-type structures.  We have an extensibility scheme there so we
> > think it can be made to work, but IIUC we'll need glibc to be updated
> > to handle the extended contexts in order to avoid losing state when
> > doing ucontext-related operations like signal handling.
>
> Sorry this is not relevant to this thread. I started a different thread
> on ABI/sigcontext aspects, lets discuss it there.
>
> >
> > I don't see a way to handle that with just HWCAP, as we essentially
> > need some bi-directional communicaton between userspace and the kernel
> > so they can both decide to turn on V.  I don't think we strictly need
> > a system call to do that, we kicked around the idea of encoding this
> > in the ELF, but there's a lot of flavors of vector in RISC-V and we've
> > had trouble trying to encode these in binaries before so it seems
> > easier to just use the syscall.
> >
> >> But this failure can be reported as part of execve and clone.
> >>
> >>> It also provides the opportunity for the kernel to deny access to the
> >>> vector extension, perhaps due to administrative policy or other future
> >>> mechanism.
> >>
> >> HWCAP can do this, too.
>
> Having the prctl as general purpose knob to disable the V unit for
> various reasons makes sense.
>
> But keeping the V unit disabled by default and using prctl as a
> gatekeeper to enable it feels unnecessary and tedious.
> Here's my reasoning below (I'm collating comments from prior msgs as well).
>
> 1. Doesn't it add another userspace ABI which is already a headache for
> this feature. And that needs to be built into not just libc but
> potentially other runtimes too. Even after implemention there will be an
> interim pain as the new prctl takes time to trickle down into tooling
> and headers. Besides the new stuff will never be compatible with older
> kernel but that is a minor point since older kernel not supporting V is
> a deal breaker anyways.
>
> 2. People want the prctl gatekeeping for ability to gracefully handle
> memory allocation failure for the extra V-state within kernel. But that
> is only additional 4K (for typical 128 wide V regs) per task. If that is
> failing, the system is not doing well anyways. Besides it is not an
> issue at all since ENOMEM in clone/execve for the additional space
> should handle the failure anyways. Only very sophisticated apps would
> downgrade from executing V to Scalar code if the prctl failed. Instead
> memory allocation is more likely to be an issue when copying V state on
> a deep user stack across signal handling but there's nothing we can do
> about it.
>
> 3. Another argument to prctl gatekeeping is ensuring user-space conforms
> to vector length. But isn't the holy grail of RV V-extension VLA (Vector
> Length Agnostic) programming.

Yes, a suitable ABI for the V extension should cater cleanly to the
VLA model, since that's a major selling point of this ISA.  The
baseline assumption should be that programs will execute correctly
regardless of VLEN (subject to the constraint that the V extension
requires VLEN >= 128, of course).

It's of course valid to construct programs with VLEN-dependent
behavior (e.g. dynamic dispatch to routines optimized differently for
different VLEN), but it should be considered the program's
responsibility to get that right.  I don't think the ABI needs to
furnish guard rails.

> I expect most implements to follow that.
> If there are super sophisticated (or dumb) apps that don't follow, they
> will fail randomly. I think of Vector Length as any other ISA extensions
> - its not that currently apps are required to prctl() for bitmanip
> extension if they want to use it. Sure they could use AT_HWCAP (or
> /proc/cpuinfo or any other portable way) to query the capability, same
> can be done for V as well. Besides vlen is readable from user space so
> the app can read it to make sure. My worry is we are providing
> additional safety net to a small category of apps at the expense of
> making it tiresome for everyone else.
>
> HWCAP solves the kernel to user-space communication of capabilities. The
> prctl is for user-space to kernel communication but I'm not convinced it
> is really solving problems for the common case.
>
> Thx,
> -Vineet
