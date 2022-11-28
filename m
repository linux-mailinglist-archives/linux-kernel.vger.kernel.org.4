Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D4363A9F7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbiK1NsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbiK1Nr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:47:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEC62B6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:47:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FA0EB80DBE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C564AC433D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669643272;
        bh=NIiDTX0/IjK4dtjmZD7V/yynqbAg+//GHEozsLGxsH0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KshPOnfyCLWznAToN31NfIcDe5aiv9hZ4ImkGtkeeQTuS+h/uB67zD68drnt1rDE9
         +jchvlEWofzWlvtT9W/HKiEiNN59JmG89kfzFn8kcRpgZ3MUH3Xz5Ho5ldDiZ1NzFJ
         48sOHmcjf2kz4yglz1DQ+1JJfr13tEdPXq5TACjGkZ8L1zcgWytyDWrk1UKfTq5sG6
         EVKmmnVBayHhCvdmACKlayxkuCoMw4QF9yoyAKRd4WfM1MH/aTvf4a5cAmQN7bAzZx
         40XIGddkJISHdSQE6aQYftGBHSwmWXT37xD4lIWC3VpeGuTZ7sCHX/iDrLtvvIuzV5
         eRCdPbeqqKybg==
Received: by mail-ed1-f41.google.com with SMTP id f7so15479288edc.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:47:52 -0800 (PST)
X-Gm-Message-State: ANoB5pnaA5EkcaJOiBtMbIHN3LBHiHHVIQhjQz/LzB8JZUy1aVVSVNZO
        Wm4BLXAZB/vylnb3yEk7efgJcCFbVdFYQG4fP9E=
X-Google-Smtp-Source: AA0mqf6OstHFr9LXQIKXtrTh06ozPyE/vLgj4i6TNZweiP9SGhZTDlo9YNG10HsMJtPgy16G4zfXLz4CefuLXXk12zg=
X-Received: by 2002:aa7:d551:0:b0:468:fb2c:6c8c with SMTP id
 u17-20020aa7d551000000b00468fb2c6c8cmr45770506edr.340.1669643270988; Mon, 28
 Nov 2022 05:47:50 -0800 (PST)
MIME-Version: 1.0
References: <20220923100149.2647325-1-suagrfillet@gmail.com> <CAAYs2=hx49ahtY3pe1z241Vd1mRNZjc-oigubmKy0aGqg6T8ag@mail.gmail.com>
In-Reply-To: <CAAYs2=hx49ahtY3pe1z241Vd1mRNZjc-oigubmKy0aGqg6T8ag@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 28 Nov 2022 21:47:38 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRfWXZEbAjWQ0vPA8HWihkibPQ2Mb9hvYgQg+DdEFrZTA@mail.gmail.com>
Message-ID: <CAJF2gTRfWXZEbAjWQ0vPA8HWihkibPQ2Mb9hvYgQg+DdEFrZTA@mail.gmail.com>
Subject: Re: [PATCH RESEND] riscv : select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, guoren@linux.alibaba.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 6:11 PM Song Shuai <suagrfillet@gmail.com> wrote:
>
> Song Shuai <suagrfillet@gmail.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=8823=E6=
=97=A5=E5=91=A8=E4=BA=94 10:03=E5=86=99=E9=81=93=EF=BC=9A
> >
> > riscv now uses -fpatchable-function-entry with dynamic ftrace after
> > the `afc76b8b8` commit, which means recordmcount shouldn't be called
The ref commit format needs to be corrected. Others:
Tested-by: Guo Ren <guoren@kernel.org>

> > to create the __mcount_loc section before the vmlinux linking.
> >
> > We should select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY to tell
> > Makefile not to run recordmcount.
> >
> Hi,Guo:
>
> Can this patch squeeze into your v3 series ?
They don't have a dependency, and it's unnecessary. A single patch is
easy for the maintainer to pick up.

>
> Thanks,
> Song
> > Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> > ---
> >  arch/riscv/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index c22f58155948..25db8cea876a 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -246,6 +246,7 @@ config ARCH_RV64I
> >         select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-option=
,-fpatchable-function-entry=3D8)
> >         select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
> >         select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> > +       select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if DYNAMIC_FT=
RACE
> >         select HAVE_FUNCTION_GRAPH_TRACER
> >         select HAVE_FUNCTION_TRACER if !XIP_KERNEL
> >         select SWIOTLB if MMU
> > --
> > 2.20.1
> >



--=20
Best Regards
 Guo Ren
