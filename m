Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A9570CAB1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbjEVURL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbjEVUQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:16:41 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F7011A
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:16:22 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-623836551f5so29339166d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684786581; x=1687378581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyIggrMGmu/jRmPpyCa3rtzViddyX1LyKifAy1G4+Uc=;
        b=PD1hZQfhLc6pj4VPtdmKIvrY3F9a1RU2vIeI121lux3Wy9XF+YXxyPvYKre8KLpT1U
         HCMypgp2eTlR9ZYttd3voBbAwIoDevB+f5hhTTnkgcqH35TRIxrQkM5hQYRI69Ukmz/Q
         Dopuc/Y+aZkxgYqlxccCspubTwwnqMB3z9sWsb0tkDPUMDUywdwoXiSEQW5nY38hz/Cr
         Q+qOnU+WJAiIQ41xSnw1qHvaT1NBdx7H67PlRpb6DSeeZ0Dz07pFtGFVCFXrSivEpAwU
         AaR2zbGA1OdogFZ9jN/rcGBR2u/gbCdKBlLp5M3H+ji4q399xZuSdTN1u2r26ENcRHgz
         DMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684786581; x=1687378581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WyIggrMGmu/jRmPpyCa3rtzViddyX1LyKifAy1G4+Uc=;
        b=MtQBXi+nmRPFdcvnPUC/tAmYIw5QfTDohU/pL/yKtgOz34L7MiCxk03KXqnq97Uu7b
         l1TW6izXbkJPK+upuOWOkrbf+UZN+RXujvmFNeZYCCpl1t7Gv2aYpb3gIXKIhp9R8G5v
         ehFO+ZNeuYuyHLRAcCUcmI1g1gSnbd6KKt4Kwp5N+R+ryj6aLZx7zMfGf/Ovwv7pnrDe
         4ZW8rI3ECOYREKeRU/wBSAlwb2UXBQOKv8FG2BhsgEYTDjfe4qlz3nEr5zLConp7Pjvo
         x9U/2nflk4NZm5IEqATxuiTsOeVKHrlVhupETJKMAxvR5CzPRJmDuTaxuoDwQ70F66BI
         GMEQ==
X-Gm-Message-State: AC+VfDw5Fw5f0Jju/d5eEQQpK+lSeqC9HrOZaK+XYl8w1FxSlIMte0Hc
        CisTwt0VN/d+vHjurkgbd2txewn2mIEU1htZb4ZIvg==
X-Google-Smtp-Source: ACHHUZ7UMHbaTH3n/yjJbWJrQjcyQm2HsY9DIIff+uu7l+FKk8s5p/W/hh2NlgLI6OVzKkJecTe+YOGG7t3SIf4AWwQ=
X-Received: by 2002:ad4:5967:0:b0:5e0:ad80:6846 with SMTP id
 eq7-20020ad45967000000b005e0ad806846mr19534204qvb.0.1684786581069; Mon, 22
 May 2023 13:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdk4QO8x_bs64fFRCsMu__AjhXd4Ew2KfgzQOb9Q3FMqSA@mail.gmail.com>
 <b5d0cf82-0e42-f6a1-c9f5-c145fdc4c622@collabora.com> <CAKwvOdkFxu9hYSL_RCXadpR0dQd1+dZmAUVXdfFiLUfxg4D_Xw@mail.gmail.com>
 <878rdlk9bi.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
 <CAKwvOd=8LVU+iANkFx18Wm1jg7gYiAXovAmo9t5ZZaVdMULn-Q@mail.gmail.com>
 <875y8ok9b5.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
 <CAKwvOdmJJibt6sHSp91v2s7BxUWBC6xG7F7+3C6gUxNMzZ2xRA@mail.gmail.com>
 <87353ok78h.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
 <2023052247-bobtail-factsheet-d104@gregkh> <CAKwvOd=2zAV_mizvzLFdyHE_4OzBY5OVu6KLWuQPOMZK37vsmQ@mail.gmail.com>
 <2023052251-oncoming-glance-f1b0@gregkh>
In-Reply-To: <2023052251-oncoming-glance-f1b0@gregkh>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 May 2023 13:16:09 -0700
Message-ID: <CAKwvOdmOhuBJ0f1ZpmeP-jSg6cN=v3_oHjvnhUXc4XHp7nY9hg@mail.gmail.com>
Subject: Re: [PATCH v4] Makefile.compiler: replace cc-ifversion with
 compiler-specific macros
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Maksim Panchenko <maks@meta.com>,
        =?UTF-8?Q?Ricardo_Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Bill Wendling <morbo@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        regressions@lists.linux.dev,
        "gustavo.padovan@collabora.com" <gustavo.padovan@collabora.com>,
        Guillaume Charles Tucker <guillaume.tucker@collabora.com>,
        denys.f@collabora.com, kernelci@lists.linux.dev
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

On Mon, May 22, 2023 at 1:01=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, May 22, 2023 at 12:52:13PM -0700, Nick Desaulniers wrote:
> > On Mon, May 22, 2023 at 9:52=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Mon, May 22, 2023 at 12:09:34PM +0200, Ricardo Ca=C3=B1uelo wrote:
> > > > On vie, may 19 2023 at 08:57:24, Nick Desaulniers <ndesaulniers@goo=
gle.com> wrote:
> > > > > It could be; if the link order was changed, it's possible that th=
is
> > > > > target may be hitting something along the lines of:
> > > > > https://isocpp.org/wiki/faq/ctors#static-init-order i.e. the "sta=
tic
> > > > > initialization order fiasco"
> > > > >
> > > > > I'm struggling to think of how this appears in C codebases, but I
> > > > > swear years ago I had a discussion with GKH (maybe?) about this. =
I
> > > > > think I was playing with converting Kbuild to use Ninja rather th=
an
> > > > > Make; the resulting kernel image wouldn't boot because I had modi=
fied
> > > > > the order the object files were linked in.  If you were to random=
ly
> > > > > shuffle the object files in the kernel, I recall some hazard that=
 may
> > > > > prevent boot.
> > > >
> > > > I thought that was specifically a C++ problem? But then again, the
> > > > kernel docs explicitly say that the ordering of obj-y goals in kbui=
ld is
> > > > significant in some instances [1]:
> > >
> > > Yes, it matters, you can not change it.  If you do, systems will brea=
k.
> > > It is the only way we have of properly ordering our init calls within
> > > the same "level".
> >
> > Ah, right it was the initcall ordering. Thanks for the reminder.
> >
> > (There's a joke in there similar to the use of regexes to solve a
> > problem resulting in two new problems; initcalls have levels for
> > ordering, but we still have (unexpressed) dependencies between calls
> > of the same level; brittle!).
>
> No, the dependencies are explicitly expressed with the linker order.  So

I don't consider that "explicit."

The link order of object files does not express what symbols (if any)
are initcalls which are dependent on other symbols/initcalls from
which object file.

> it's not brittle, but rather very deterministic.

Brittle !=3D non-deterministic.

We now have implicit dependencies between some init calls, but not all.

Given two initcalls, are you confident that you could tell which must
run before the other, if there is even such a dependency?

It prevents us from reordering symbol layout for performance (or
security via FGKASLR), safely.  If such dependencies were *explicit*,
we could do so safely since we'd have information about which
initcalls are dependencies or not.

The implicit nature of such dependencies is thus what I would consider brit=
tle.

Hopefully initcall ordering related changes isn't the root cause of
the boot failure reported here, lest that lend more evidence to my
claim.

>
> When linker order didn't work for all sorts of things, we added
> different levels, but due to the huge number of init calls, of course
> can not give each one their own level.
>
> It's always been this way with Linux, nothing new here at all :)

:^)

>
> thanks,
>
> greg k-h



--=20
Thanks,
~Nick Desaulniers
