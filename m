Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B672663AA95
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbiK1OMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbiK1OMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:12:14 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF7E20BE8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:12:13 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so14111307pjc.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKw90zUbpAV+b/3rfP6iieLhvlviIys04BFE2GHKsio=;
        b=ihn7p87Ee2lLG81x5tyWrVDKub8QRgPcGbWOFaqKg/2+9VvI6IFNqpNejJ5Gc8Z+5Q
         RssyprNwjCyDnT1/5idaIO/w0Bp050LXwgtvmwY6rzdpO87VtejVe+O4j1fQRFHpIegh
         IFLgDR/0nDvqM4lG2pbZvkGvi1D0uPgf72jZIicny0HjMRwfUxS9iEH3zD7tPiIgL/e3
         8hbFDAF6h2CCkaTMOhCYUsZ7bd9mY9SoH46159euoQVqZByiKwvnds8+pAqZJU5JhABi
         GYNfc6ytFqOXgpGA7eDGj9vQPbs+2VU8dNZpO6gyChRr5LDgfwRKJhIupepCOuEya2oq
         GSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DKw90zUbpAV+b/3rfP6iieLhvlviIys04BFE2GHKsio=;
        b=qICptPqdRUM7AvcnHtqb+TphLLNYnn2N9YpvLgKYRsgWpwpqK2ncNLOk4Oh9uev8TV
         OKEGqiO2yDKY1YBnJMqZ0DdZ2k6sE6YV6+BWCZKj7RjX0NoN00fEaEUgY/krrnHFu5L1
         DuVDLchVBIgZSQ+xIuscjK/k5Y0RKHy67QnXZazNemHCEjbz77qu3pRfW3H74dr8RUhZ
         uH2Qa1aBe+sBwoakx+ApdZeOv/vRNCdRjJHwrcyUrh+fZT3DYaPR/KIQmjW9GmPRijbZ
         OTHwL8ZEkjpmpbcCaDTG2O1I+DP5CWOpWiXst9M4wpS0LGthP7/RjRruGb+Y8+qsyFlF
         cnnQ==
X-Gm-Message-State: ANoB5pmHgUQPGiMOz0S04KoeSijE2udNGB9ByKbSQCHSjI5jQBJ0lEnF
        y09/aZKIr4//f4Xeu8A++/SVxSTJzCkWSxk5Psk=
X-Google-Smtp-Source: AA0mqf5wMe8pRArVdzem5WEsZj7bzHjphjpvEdaNt6jZUlgWBfLVI4j9yuPVJaQe3PX0XZHmXMFx/CiNC1N/t3Pzboc=
X-Received: by 2002:a17:90a:dc06:b0:218:9196:1cd1 with SMTP id
 i6-20020a17090adc0600b0021891961cd1mr47707800pjv.230.1669644732976; Mon, 28
 Nov 2022 06:12:12 -0800 (PST)
MIME-Version: 1.0
References: <20220923100149.2647325-1-suagrfillet@gmail.com>
 <CAAYs2=hx49ahtY3pe1z241Vd1mRNZjc-oigubmKy0aGqg6T8ag@mail.gmail.com> <CAJF2gTRfWXZEbAjWQ0vPA8HWihkibPQ2Mb9hvYgQg+DdEFrZTA@mail.gmail.com>
In-Reply-To: <CAJF2gTRfWXZEbAjWQ0vPA8HWihkibPQ2Mb9hvYgQg+DdEFrZTA@mail.gmail.com>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Mon, 28 Nov 2022 22:12:02 +0800
Message-ID: <CAAYs2=j3Eak9vU6xbAw0zPuoh00rh8v5C2U3fePkokZFibWs2g@mail.gmail.com>
Subject: Re: [PATCH RESEND] riscv : select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
To:     Guo Ren <guoren@kernel.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, guoren@linux.alibaba.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guo Ren <guoren@kernel.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=8828=E6=97=A5=E5=
=91=A8=E4=B8=80 21:47=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Nov 22, 2022 at 6:11 PM Song Shuai <suagrfillet@gmail.com> wrote:
> >
> > Song Shuai <suagrfillet@gmail.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=8823=
=E6=97=A5=E5=91=A8=E4=BA=94 10:03=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > riscv now uses -fpatchable-function-entry with dynamic ftrace after
> > > the `afc76b8b8` commit, which means recordmcount shouldn't be called
> The ref commit format needs to be corrected. Others:
> Tested-by: Guo Ren <guoren@kernel.org>
>
Thanks for your test.
I'll correct this ref in the next version.
> > > to create the __mcount_loc section before the vmlinux linking.
> > >
> > > We should select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY to tell
> > > Makefile not to run recordmcount.
> > >
> > Hi,Guo:
> >
> > Can this patch squeeze into your v3 series ?
> They don't have a dependency, and it's unnecessary. A single patch is
> easy for the maintainer to pick up.
>
Got it.
> >
> > Thanks,
> > Song
> > > Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> > > ---
> > >  arch/riscv/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index c22f58155948..25db8cea876a 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -246,6 +246,7 @@ config ARCH_RV64I
> > >         select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-opti=
on,-fpatchable-function-entry=3D8)
> > >         select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
> > >         select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> > > +       select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if DYNAMIC_=
FTRACE
> > >         select HAVE_FUNCTION_GRAPH_TRACER
> > >         select HAVE_FUNCTION_TRACER if !XIP_KERNEL
> > >         select SWIOTLB if MMU
> > > --
> > > 2.20.1
> > >
>
>
>
> --
> Best Regards
>  Guo Ren



--=20
Thanks,
Song
