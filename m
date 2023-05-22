Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3A070C9DF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbjEVTwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbjEVTwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:52:33 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3B49C
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:52:25 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-75b0b5c9eb8so78221085a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684785144; x=1687377144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p52m+WWp6aApwkHVTkNg5kh/c1TUE8xWnOr/swu4YQM=;
        b=lRpK3qNuuiQELF1mYf+pdqtoRndN/uBy+fRujNOBmFoKNNZHXdQGn1YvzpvVdJmEsc
         o3aMGlzGMRo5bQ1kgH0uISw+aX/9dQxYn75ifiSczdRoxgRETgSHrFpUk4Qz4Bw1R2IJ
         MhyAJcR09p9R18n7Ziq0C2mjuHP7B4FjFS+arj7kNxBLuT0bp/xmQbQiuodgr3hztHl/
         4CPSJAhCovLJTkhnzO8WN/7IrW0xiT3nz9471apMj6tER1aIMTmaI6NmSsejQ1mOhrk3
         3MLyEXrK/w5i0DCPURMZjSV0NUoL5yt0rFbJz/MTHoB08PJ8bVAkFVwax4tQar1VwO4p
         hNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684785144; x=1687377144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p52m+WWp6aApwkHVTkNg5kh/c1TUE8xWnOr/swu4YQM=;
        b=enXpWcJPHMwmIOAy4XRLgFOws5BNu/sT1jf3Z3iyw5A/vmYD3pZ5bvIbTpWbcjkS/7
         tTvn0sw0E/rzRG0MN+/jdkcuNFX4qDGIFFPFdC/vPtZJ2muDtj3nfCfncV97ZOtqmRXU
         H/15pSdqRqZ+D86X7t1HOTHwJhsOKX+JPWdwy8yjQ9KhLwsVIwH+8lsMXMFOnGwLZKES
         sr+eVvy0+6oG/oUbj+QF7hF+kLRuUUd5RoGq9MpJdBioB/EwF3DQR2nq/jK32Cz1pO5/
         DcGvDUL+FSCJ+Ul7N+0dswAyNTLJ76W88lFYUa4L2QYHiNN8BTiWwepYZrpPIwyqd+aF
         HFsw==
X-Gm-Message-State: AC+VfDyZXinhlFYbXEUvI1C/IqYIhai8M2Uo3PaLH/S9QZFuoK6q19sw
        6XyauJWG1zfWbfXAV2NVqmPLASyf5dPiLcDG0k5pRw==
X-Google-Smtp-Source: ACHHUZ62p53t5Jx/dLsMCHu7hh9zeJ6bLdglFzoT+d04I0no2SNO9KMZS5dewAaI/LY85SD7r51/PuKHsSa9AFk227A=
X-Received: by 2002:a05:6214:f0a:b0:5fd:7701:88c5 with SMTP id
 gw10-20020a0562140f0a00b005fd770188c5mr23825727qvb.6.1684785144362; Mon, 22
 May 2023 12:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOd=4hBcU4fAkddU0b-GOZc9FzTZoj3PFW6ZZrX0jS8x+bg@mail.gmail.com>
 <17c91d37-7d9c-0df4-2438-2b30ca0b5777@collabora.com> <CAKwvOdk4QO8x_bs64fFRCsMu__AjhXd4Ew2KfgzQOb9Q3FMqSA@mail.gmail.com>
 <b5d0cf82-0e42-f6a1-c9f5-c145fdc4c622@collabora.com> <CAKwvOdkFxu9hYSL_RCXadpR0dQd1+dZmAUVXdfFiLUfxg4D_Xw@mail.gmail.com>
 <878rdlk9bi.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
 <CAKwvOd=8LVU+iANkFx18Wm1jg7gYiAXovAmo9t5ZZaVdMULn-Q@mail.gmail.com>
 <875y8ok9b5.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
 <CAKwvOdmJJibt6sHSp91v2s7BxUWBC6xG7F7+3C6gUxNMzZ2xRA@mail.gmail.com>
 <87353ok78h.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
 <2023052247-bobtail-factsheet-d104@gregkh>
In-Reply-To: <2023052247-bobtail-factsheet-d104@gregkh>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 May 2023 12:52:13 -0700
Message-ID: <CAKwvOd=2zAV_mizvzLFdyHE_4OzBY5OVu6KLWuQPOMZK37vsmQ@mail.gmail.com>
Subject: Re: [PATCH v4] Makefile.compiler: replace cc-ifversion with
 compiler-specific macros
To:     Greg KH <gregkh@linuxfoundation.org>,
        Maksim Panchenko <maks@meta.com>,
        =?UTF-8?Q?Ricardo_Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
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

On Mon, May 22, 2023 at 9:52=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, May 22, 2023 at 12:09:34PM +0200, Ricardo Ca=C3=B1uelo wrote:
> > On vie, may 19 2023 at 08:57:24, Nick Desaulniers <ndesaulniers@google.=
com> wrote:
> > > It could be; if the link order was changed, it's possible that this
> > > target may be hitting something along the lines of:
> > > https://isocpp.org/wiki/faq/ctors#static-init-order i.e. the "static
> > > initialization order fiasco"
> > >
> > > I'm struggling to think of how this appears in C codebases, but I
> > > swear years ago I had a discussion with GKH (maybe?) about this. I
> > > think I was playing with converting Kbuild to use Ninja rather than
> > > Make; the resulting kernel image wouldn't boot because I had modified
> > > the order the object files were linked in.  If you were to randomly
> > > shuffle the object files in the kernel, I recall some hazard that may
> > > prevent boot.
> >
> > I thought that was specifically a C++ problem? But then again, the
> > kernel docs explicitly say that the ordering of obj-y goals in kbuild i=
s
> > significant in some instances [1]:
>
> Yes, it matters, you can not change it.  If you do, systems will break.
> It is the only way we have of properly ordering our init calls within
> the same "level".

Ah, right it was the initcall ordering. Thanks for the reminder.

(There's a joke in there similar to the use of regexes to solve a
problem resulting in two new problems; initcalls have levels for
ordering, but we still have (unexpressed) dependencies between calls
of the same level; brittle!).

+Maksim, since that might be relevant info for the BOLT+Kernel work.

Ricardo,
https://elinux.org/images/e/e8/2020_ELCE_initcalls_myjosserand.pdf
mentions that there's a kernel command line param `initcall_debug`.
Perhaps that can be used to see if
5750121ae7382ebac8d47ce6d68012d6cd1d7926 somehow changed initcall
ordering, resulting in a config that cannot boot?
--=20
Thanks,
~Nick Desaulniers
