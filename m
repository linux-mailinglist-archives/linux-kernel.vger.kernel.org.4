Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6E96A419F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 13:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjB0MUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 07:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjB0MUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 07:20:06 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469DF1B336
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 04:20:01 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id c4so492436pfl.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 04:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLMXRXE6p7M2wI/v/8zIreJMb38Cw+t13v0pmAsHMHg=;
        b=ISCrTbX0cGZo4rt8H1qM6YmqIFbVPz/ztodfosWEkfyna3o6tDcFIYSi216s73nw2n
         JU6mgjeL9DQNvrLbkhBskOCANmhf5G41bewOClq+DVnbEafyDGY6eF9gr031wc/13NqF
         EdF0fw9wir/BqotzQq+cGTXKsHIOkjx3DYHpwBp+S61bd9zdBvMlo/HInDe4IE1oubVY
         RFyFVWtUs1k2yEPuiFFQHsxoBe2i3KdHnrPWAOWsTM/0xbfEdTpkrrtIJjYqGEJv9txl
         WBWiqpJysadKTuFH8Y/T45FJTALW3evmXhH8oIXbz21P6qQxj/G3bi5fngXcE5cwrEE8
         TaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLMXRXE6p7M2wI/v/8zIreJMb38Cw+t13v0pmAsHMHg=;
        b=Y0gJ+9DVdJ8yWnDzsZAC7fi5b8dqiRXrlfpyJ1zXJeKfxZ/7sCkLe389mbHCiGWCvA
         mU/uvYFFkN0maUTuLp7t5es4aM3ycMOHMc2/AuJdQDbOqVQuGTTMmbSDm7cohBmzVJH7
         sL6LueuLqIQqwYUHa1zYs4LabK8VbRoewrsHEFWpHOHw4sqqUrRLIyAZPt7BMFJRZwRv
         jbLj87dBse48YLh/bgKxerrNEpT2tBdroQ895R+Wc94yXcgKcvgXWmpk5010G1UVj0mn
         gpeG09bU6eZqo9CcHeyrGspcY5ZLmXTgvC4Q0Xz+EHJfrS1SHQQJPZezNhdvgRgjIprf
         Mwlg==
X-Gm-Message-State: AO0yUKUu/K5GZHFZGUh4t72t3qCzAYcp5DaR0lCzRrfsTOqX3SikiQES
        jghXDlYr7hK586JTdVh5I/ectNb92rTnOP99XyGsfA==
X-Google-Smtp-Source: AK7set+pRin2+DrQij1wsBd87m6EHrzz0VpUgURYwl63znWqJGO/4vKGVim0XwC9giSb9cx+snGEAxFrGhlofsJDJss=
X-Received: by 2002:a05:6a00:302a:b0:5a8:a56f:1c3a with SMTP id
 ay42-20020a056a00302a00b005a8a56f1c3amr3972323pfb.0.1677500400659; Mon, 27
 Feb 2023 04:20:00 -0800 (PST)
MIME-Version: 1.0
References: <20230222161222.11879-1-jiaxun.yang@flygoat.com>
 <20230222161222.11879-3-jiaxun.yang@flygoat.com> <CAM1=_QTDkYJANgxYwkgPZB+hUX6Rr_Pvnn7cFwSJFHQtLrpQMA@mail.gmail.com>
 <70C80F6D-A727-48FD-A767-A2CA54AA7C1E@flygoat.com>
In-Reply-To: <70C80F6D-A727-48FD-A767-A2CA54AA7C1E@flygoat.com>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Mon, 27 Feb 2023 13:19:49 +0100
Message-ID: <CAM1=_QS_ewcFdrZ1ypV15wOkK_SKkb0UUe5_Ozi_CDBdxF5JmA@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: ebpf jit: Implement R4000 workarounds
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "paulburton@kernel.org" <paulburton@kernel.org>,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 11:32=E2=80=AFAM Jiaxun Yang <jiaxun.yang@flygoat.c=
om> wrote:
> >> --- a/arch/mips/Kconfig
> >> +++ b/arch/mips/Kconfig
> >> @@ -63,9 +63,7 @@ config MIPS
> >>        select HAVE_DEBUG_STACKOVERFLOW
> >>        select HAVE_DMA_CONTIGUOUS
> >>        select HAVE_DYNAMIC_FTRACE
> >> -       select HAVE_EBPF_JIT if !CPU_MICROMIPS && \
> >> -                               !CPU_R4000_WORKAROUNDS && \
> >> -                               !CPU_R4400_WORKAROUNDS
> >
> > Is the R4400 errata also covered by this workaround?
>
> Yes, R4400 errata is basically a reduced version of R4000 one.
> They managed to fix some parts of the issue but not all.

Ok.

> >> --- a/arch/mips/net/bpf_jit_comp32.c
> >> +++ b/arch/mips/net/bpf_jit_comp32.c
> >> @@ -446,6 +446,9 @@ static void emit_mul_i64(struct jit_context *ctx, =
const u8 dst[], s32 imm)
> >>                } else {
> >>                        emit(ctx, multu, hi(dst), src);
> >>                        emit(ctx, mflo, hi(dst));
> >> +                       /* Ensure multiplication is completed */
> >> +                       if (IS_ENABLED(CONFIG_CPU_R4000_WORKAROUNDS))
> >> +                               emit(ctx, mfhi, MIPS_R_ZERO);
> >>                }
> >>
> >>                /* hi(dst) =3D hi(dst) - lo(dst) */
> >> @@ -504,6 +507,7 @@ static void emit_mul_r64(struct jit_context *ctx,
> >>        } else {
> >>                emit(ctx, multu, lo(dst), lo(src));
> >>                emit(ctx, mflo, lo(dst));
> >> +               /* No need for workaround because we have this mfhi */

For context, please specify which workaround this comment refers to:
"workaround" -> "R4000 workaround".

> > R4000 is a 64-bit CPU, so the 32-bit JIT implementation will not be
> > used. From the Makefile:
> >
> > ifeq ($(CONFIG_32BIT),y)
> >        obj-$(CONFIG_BPF_JIT) +=3D bpf_jit_comp32.o
> > else
> >        obj-$(CONFIG_BPF_JIT) +=3D bpf_jit_comp64.o
> > endif
>
> It=E2=80=99s common practice to run 32-bit kernel on R4000 based systems =
to save some memory :-)

Ok, I understand.

Looks good! I have run the test_bpf.ko test suite on MIPS and MIPS64
in QEMU with and without the workarounds enabled.

With above comment fix:
Acked-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
