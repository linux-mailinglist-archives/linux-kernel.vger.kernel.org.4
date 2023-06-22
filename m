Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F5773A5F2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 18:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjFVQU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 12:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFVQUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 12:20:25 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0841E1BD8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 09:20:24 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-62fd844ad58so58018586d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 09:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687450823; x=1690042823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XELcs0KjDsqiSRNO8EY3VKhL4hoV52jGXB5PnafOp0=;
        b=CzM7F26e9LXYl0fTNN1xYIPzqGWXfb9wFaBmTtUucf3sth/KsvghYciw+kzlCdA9sK
         O3gJorqwfPMI/RsBz5OjcLWoZnM6bmNTEUP9a5PbNQTVSBBkMSYXMdEwGfGCWtFcNsVR
         Iibp9LwkV9yBN2WsCZfJGzY0ofxELsalVTTqQLmQVRPB5Aa89sK99xHpWz7SNDXu2wGs
         u+6w/aT/A92/B+Qtv2dZkwuGyScVKfBAmpgny2cNtb/E2wWaNz5J1+4GpZBTrHyLdcTf
         xkxMeFUbWbsR9jvPYAFFBGnyD/QQTeOQsQJ7jCGvQsbe9cR4t2FUoPonbk6OO8p4rz/a
         /YqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687450823; x=1690042823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XELcs0KjDsqiSRNO8EY3VKhL4hoV52jGXB5PnafOp0=;
        b=DJMhQOqvmPVPTFAT7keFCWqvKbEc1O8CPd6CoViozShpEpIboQhTdgoj44oBVDA9z+
         j+Jx5+aWnyoSlzL4Hc47isCa+r1pgt+II3W2sFK2VIbXYqoPLFjvyGwEiHkG0mfxVx0e
         HOdLn/eNR13EPrkT0+1uacEI0nhPQBNyGnax/zJzJq+AHonMe7UuSsBf9N+p1feD4iBR
         ES59XwOTlGC/+hRTSQ85UXtm1c5u0H/mCa63JdIVgOHpYicJAY9NiJlPqI+QEwUzgpVE
         J8zL29uhh6VoZCL4au2hpHKOd8l9win0no9guV+M8ZKj6PzF823F5h1HRpykIZvEFEbX
         m2Dg==
X-Gm-Message-State: AC+VfDzt2MxJ4dEE2oCxK+vBvsuCr38MmgGjLsqTMT0AHG7Xs8J0Yth8
        qetr48Fu0IUMgeIHnh1X7g7awEodSyaVLLzVEOD8x4ljUirzIWTo+KLcrw==
X-Google-Smtp-Source: ACHHUZ4QnOdDZ1SJvTnClzD/x4ZLcqOLIU6cnGayXHpnw19L8DM77/zvixXvQpc42DuoeynwhOOZCzuixWc6rSmW6tE=
X-Received: by 2002:a05:6214:5098:b0:630:1faa:a404 with SMTP id
 kk24-20020a056214509800b006301faaa404mr12713532qvb.39.1687450823024; Thu, 22
 Jun 2023 09:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230608142428.256985-1-masahiroy@kernel.org> <20230608142428.256985-4-masahiroy@kernel.org>
 <bb5048e7-5e8f-4391-a9a0-ff15b5384186@roeck-us.net> <CAK7LNAQpgx5uYnQTb0Pu=uR=YPWkJX7P75p55Qva5okhRpaN_g@mail.gmail.com>
In-Reply-To: <CAK7LNAQpgx5uYnQTb0Pu=uR=YPWkJX7P75p55Qva5okhRpaN_g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 22 Jun 2023 09:20:11 -0700
Message-ID: <CAKwvOdn4n1fqMz+7wcEBv-kxLf7tWHgC2P+m73mGQ7m6BoOxwQ@mail.gmail.com>
Subject: Re: [PATCH v7 03/11] kbuild: generate KSYMTAB entries by modpost
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-um@lists.infradead.org, Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 7:27=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Thu, Jun 22, 2023 at 1:15=E2=80=AFAM Guenter Roeck <linux@roeck-us.net=
> wrote:
> >
> > On Thu, Jun 08, 2023 at 11:24:20PM +0900, Masahiro Yamada wrote:
> > > Commit 7b4537199a4a ("kbuild: link symbol CRCs at final link, removin=
g
> > > CONFIG_MODULE_REL_CRCS") made modpost output CRCs in the same way
> > > whether the EXPORT_SYMBOL() is placed in *.c or *.S.
> > >
> > ...
> >
> > > We can do this better now; modpost can selectively emit KSYMTAB entri=
es
> > > that are really used by modules.
> > >
> >
> > This patch results in
> >
> > Building alpha:defconfig ... failed
> > --------------
> > Error log:
> > <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp=
]
> > WARNING: modpost: "saved_config" [vmlinux] is COMMON symbol
> I do not know much about the warning for "saved_config".
>
>
>
> __attribute((common)) was added in the following commit:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commi=
t/?id=3D3c7940961fbf9f252e20f9c455f2fe63f273294c
>
>
> It was more than 20 years ago, and there is
> no commit description.
> I do not know the intention of __attribute((common)).

Adding __attribute__((common)) to a variable declaration, the
generated assembler will contain a .comm assembler directive.
https://godbolt.org/z/6jvoaGs8M
https://sourceware.org/binutils/docs/as/Comm.html

>>> .comm declares a common symbol named symbol. When linking, a common sym=
bol in one object file may be merged with a defined or common symbol of the=
 same name in another object file.

When I see this, I think some kind of ODR tricks are afoot.  C doesn't
have ODR; C++ does, but this attribute allows for ODR-like linker
merging where the linker discards duplicates because "they ought to be
the same."

IIRC, I think C++ template instantiations are emitted with common
linkage.  LLVM IR has a linkage type corresponding to this that I
initially didn't understand, because without this attribute, I don't
think that linkage type is ever emitted for C code.

Indeed, for alpha, we can see the same symbol marked common in arch/alpha/:
arch/alpha/kernel/core_tsunami.c:36:} saved_config[2] __attribute__((common=
));
arch/alpha/kernel/sys_sio.c:43:} saved_config __attribute((common));
arch/alpha/kernel/core_cia.c:577:} saved_config __attribute((common));
arch/alpha/kernel/core_titan.c:36:} saved_config[4] __attribute__((common))=
;

All of these have different sizes, so according to the GAS manual,
this line comes into play:

>>> If ld sees multiple common symbols with the same name, and they do not =
all have the same size, it will allocate space using the largest size.

This kind of smells like some overcomplicating code to save like 30B
of static memory.  Fixing this requires careful use of enums.  For
arch/alpha/ not sure such a rework is worth it, given the imminent
demise of the architecture I sense looming on the horizon.


>
> I hope the maintainers will fix the warnings,
> but I do not know if it is likely to happen.
>
> MAINTAINERS says "Odd Fixes"
>
> If you find a build regression, please let me know.
> So far, I did not get new reports from 0day bot.
>
>
> Thanks.
>
>
>
>
> > Guenter
> >
> > ---
> > Bisect log:
> >
> > # bad: [15e71592dbae49a674429c618a10401d7f992ac3] Add linux-next specif=
ic files for 20230621
> > # good: [45a3e24f65e90a047bef86f927ebdc4c710edaa1] Linux 6.4-rc7
> > git bisect start 'HEAD' 'v6.4-rc7'
> > # bad: [e867e67cd55ae460c860ffd896c7fc96add2821c] Merge branch 'master'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
> > git bisect bad e867e67cd55ae460c860ffd896c7fc96add2821c
> > # bad: [57b289d5b1005a9c39d6d6567e0ef6115bd59cea] Merge branch 'for-nex=
t' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
> > git bisect bad 57b289d5b1005a9c39d6d6567e0ef6115bd59cea
> > # bad: [dc6399fc9ae6d2530fc38fb3ae96bcc8393bd66f] Merge branch 'for-nex=
t/perf' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git
> > git bisect bad dc6399fc9ae6d2530fc38fb3ae96bcc8393bd66f
> > # good: [6d366ba598334a0457d917a7bf38efd118c5b7be] Merge branch 'mm-sta=
ble' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > git bisect good 6d366ba598334a0457d917a7bf38efd118c5b7be
> > # good: [82fe2e45cdb00de4fa648050ae33bdadf9b3294a] perf pmus: Check if =
we can encode the PMU number in perf_event_attr.type
> > git bisect good 82fe2e45cdb00de4fa648050ae33bdadf9b3294a
> > # bad: [d2fa756910f88c2f5871775483744407cbf67933] Merge branch 'for-nex=
t' of git://git.infradead.org/users/hch/dma-mapping.git
> > git bisect bad d2fa756910f88c2f5871775483744407cbf67933
> > # good: [1b990bc8edc396a37a3ff1a43f7c329c361ee07c] Merge branch 'mm-non=
mm-unstable' into mm-everything
> > git bisect good 1b990bc8edc396a37a3ff1a43f7c329c361ee07c
> > # good: [cff6e7f50bd315e5b39c4e46c704ac587ceb965f] kbuild: Add CLANG_FL=
AGS to as-instr
> > git bisect good cff6e7f50bd315e5b39c4e46c704ac587ceb965f
> > # bad: [8f3847e175a0044e2212fef772e7fa912270cd6d] ia64,export.h: replac=
e EXPORT_DATA_SYMBOL* with EXPORT_SYMBOL*
> > git bisect bad 8f3847e175a0044e2212fef772e7fa912270cd6d
> > # good: [3a3f1e573a105328a2cca45a7cfbebabbf5e3192] modpost: fix off by =
one in is_executable_section()
> > git bisect good 3a3f1e573a105328a2cca45a7cfbebabbf5e3192
> > # good: [92e74fb6e6196d642505ae2b74a8e327202afef9] scripts/kallsyms: co=
nstify long_options
> > git bisect good 92e74fb6e6196d642505ae2b74a8e327202afef9
> > # good: [92e2921eeafdfca9acd9b83f07d2b7ca099bac24] ARC: define ASM_NL a=
nd __ALIGN(_STR) outside #ifdef __ASSEMBLY__ guard
> > git bisect good 92e2921eeafdfca9acd9b83f07d2b7ca099bac24
> > # bad: [bb2aa9a94b41b883037a56709d995c269204ade0] kbuild: generate KSYM=
TAB entries by modpost
> > git bisect bad bb2aa9a94b41b883037a56709d995c269204ade0
> > # good: [94d6cb68124b7a63f24fcc345795ba5f9a27e694] modpost: pass struct=
 module pointer to check_section_mismatch()
> > git bisect good 94d6cb68124b7a63f24fcc345795ba5f9a27e694
> > # first bad commit: [bb2aa9a94b41b883037a56709d995c269204ade0] kbuild: =
generate KSYMTAB entries by modpost
>
>
>
> --
> Best Regards
> Masahiro Yamada



--=20
Thanks,
~Nick Desaulniers
