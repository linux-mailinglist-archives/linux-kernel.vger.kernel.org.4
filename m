Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DD27269E3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 21:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjFGTfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 15:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjFGTfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 15:35:02 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8371FEC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 12:35:01 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3f7f864525fso85983231cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 12:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686166500; x=1688758500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/N+7hZBU68Az7fq+11+0PEgFJs4BfE4zntjuKa1qEM=;
        b=cmdZ2HNddWh5tk5ncyT92Mc8F+G5Vc58B7dBambSy22hC65jaZWIbJH/DeRXJEJEIk
         LPrP6JmrY7OLnmT/Xrn3OEsQdownJDvfvxIznzyqRUb7OrISmtmWjOvvzd9ajX+H/eHR
         SbiqDBU6auywfPgq8A7Bv3AQ8a7TWDlSktec9HxnUxUB3S3AJAZlmS+CMlvtYjzjdqQu
         h1t23wwZdv4Q4e3eD8lw4mVIAEfrXq1zRjUO++AjLx+WORiBWwO6yvjqKNfs9heMPs38
         oTfssBJOqPW/UvW6nIrCScK4VWQ46rgikrUygA9eaSM9nCJsFGr7nK54ZcjnGd5726Wu
         P2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686166500; x=1688758500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/N+7hZBU68Az7fq+11+0PEgFJs4BfE4zntjuKa1qEM=;
        b=EeB4GjSNzSSkw08RkgmuP80alzZspZFpfTqDvLmgRcQ8hiC87tkcn0j7SBxomOBZ86
         6bC6GBk9A7gosb4K2X8ihWYykSRr9jZ+aUPwLIi/vf3PRmcyiKgEuDIahfOTAj9i7HKk
         jsRWTe25l3NDie1JBkiFm++8dNFkiAtw9ZhGjmyRI0khLR0cBFY65uT2Yj484XSVvmYE
         AgygRcmFPcqipwkkhvqCif89T6ISVW6F0TqQEWl7xKQiFKucmHSzZiwO+P3o/oo+FKxQ
         eKAcJYZpU+v6A5PzSoOtvBs1sDfncddsyDnkjlAMI3/etc7OOxigYEItosEiX01AjsTT
         LXpw==
X-Gm-Message-State: AC+VfDwO1jYsHTTKoQvcp3jfs4vzR0mNl1TInquykkFjbDLFt8y6KsQX
        y+1RmmADwCyCJbYffqXaUB7yHP7xdCbJpCLOqOODug==
X-Google-Smtp-Source: ACHHUZ5S+lZx99PbMn5tmQQs5d7UtgH373Cii1r5sz0Malc+YPWjUkgSMmoHDmt/kGESqJO6TQf40UUS5NeW7AAPKvc=
X-Received: by 2002:a1f:43c6:0:b0:464:6036:604f with SMTP id
 q189-20020a1f43c6000000b004646036604fmr2188987vka.7.1686166500016; Wed, 07
 Jun 2023 12:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYs4JsmNxX4+W=wijfSPdDsOy=SWLBSitZper5ncPpdxqA@mail.gmail.com>
 <CAMRc=MdRev1NBz9ga0jcDKD0oZy_W-7caq9R0tQkUG86rBQ=3Q@mail.gmail.com> <CADYN=9Kj9A6utjkPMuAQ4=ytvBiL50GnTzttauRWLQZOn5rzeQ@mail.gmail.com>
In-Reply-To: <CADYN=9Kj9A6utjkPMuAQ4=ytvBiL50GnTzttauRWLQZOn5rzeQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 7 Jun 2023 21:34:48 +0200
Message-ID: <CAMRc=Mfyt3wOzDT-4WRUG-2AzyqsJZnt6XikyPCEWhv1O8QTNA@mail.gmail.com>
Subject: Re: arm64: libgpiod: refcount_t: underflow; use-after-free.
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ferry Toth <fntoth@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>, warthog618@gmail.com,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 8:35=E2=80=AFPM Anders Roxell <anders.roxell@linaro.=
org> wrote:
>
> On Wed, 22 Feb 2023 at 13:36, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > On Mon, Feb 20, 2023 at 3:59 PM Naresh Kamboju
> > <naresh.kamboju@linaro.org> wrote:
> > >
> > > Following kernel warning notices on qemu-arm64, qemu-arm and also on =
devices
> > > running Linux version v6.2.0 while running libgpiod tests.
> > >
> >
> > I don't see it on v6.2 with libgpiod v1.6.4. Seeing the output of the
> > test script, it seems you're using an old version - what is it?
>
> Yes, I did run libgpiod v1.6.4 by mistake on todays next-20230607 tag.
> Not sure if I should or should not get the use-after-free warning by
> running the "wrong version"
> of a test suite or?
>

It doesn't matter, v1.6.4 is still supported. I'll give it a try tomorrow.

Brt

> >
> > > + ./gpiod.sh /opt/libgpiod/bin/
> >
> > What's in gpiod.sh?
>
> its a wrapper script around gpiod-test [1] to parse the output to be
> understood by our test framework
>
> Cheers,
> Anders
> [1] https://github.com/Linaro/test-definitions/blob/master/automated/linu=
x/gpiod/gpiod.sh
>
> >
> > Bart
> >
> > >   [INFO]    libgpiod test suite
> > >   [INFO]    117 tests registered
> > >   [INFO]    checking the linux kernel version
> > >   [INFO]    kernel release is v6.2.0 - ok to run tests
> > >   [INFO]    using gpio-tools from '/usr/bin'
> > > [   10.499036] ------------[ cut here ]------------
> > > [   10.499656] refcount_t: underflow; use-after-free.
> > > [   10.500264] WARNING: CPU: 2 PID: 291 at lib/refcount.c:28
> > > refcount_warn_saturate+0xf4/0x144
> > > [   10.501306] Modules linked in: gpio_mockup(-) cfg80211 bluetooth
> > > rfkill crct10dif_ce fuse drm
> > > [   10.502364] CPU: 2 PID: 291 Comm: gpiod-test Not tainted 6.2.0 #1
> > > [   10.503229] Hardware name: linux,dummy-virt (DT)
> > > [   10.503883] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS =
BTYPE=3D--)
> > > [   10.505331] pc : refcount_warn_saturate+0xf4/0x144
> > > [   10.505723] lr : refcount_warn_saturate+0xf4/0x144
> > > [   10.506115] sp : ffff800008983cd0
> > > [   10.506391] x29: ffff800008983cd0 x28: ffff0000c4c4c100 x27: 00000=
00000000000
> > > [   10.506961] x26: 0000000000000000 x25: 0000000000000000 x24: 00000=
00000000000
> > > [   10.507533] x23: 0000000000000200 x22: ffff0000c4e66800 x21: ffff0=
000c7734640
> > > [   10.508104] x20: 0000000000000001 x19: ffff0000c7734600 x18: fffff=
fffffffffff
> > > [   10.508677] x17: 3d4d455453595342 x16: ffffcf0234432020 x15: ffff8=
00088983957
> > > [   10.509424] x14: 0000000000000000 x13: 2e656572662d7265 x12: 74666=
12d65737520
> > > [   10.510003] x11: 3b776f6c66726564 x10: ffffcf02365db580 x9 : ffffc=
f0233b20138
> > > [   10.510575] x8 : 00000000ffffefff x7 : ffffcf02365db580 x6 : 00000=
00000000001
> > > [   10.511145] x5 : ffffcf023655f000 x4 : ffffcf023655f2e8 x3 : 00000=
00000000000
> > > [   10.511721] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0=
000c4c4c100
> > > [   10.512294] Call trace:
> > > [   10.512494]  refcount_warn_saturate+0xf4/0x144
> > > [   10.512971]  kobject_put+0x164/0x220
> > > [   10.513224]  fwnode_remove_software_node+0x44/0x60
> > > [   10.513554]  gpio_mockup_unregister_pdevs+0x54/0x70 [gpio_mockup]
> > > [   10.513970]  gpio_mockup_exit+0x10/0x328 [gpio_mockup]
> > > [   10.514322]  __arm64_sys_delete_module+0x190/0x2a0
> > > [   10.514653]  invoke_syscall+0x50/0x120
> > > [   10.514915]  el0_svc_common.constprop.0+0x104/0x124
> > > [   10.515277]  do_el0_svc+0x44/0xcc
> > > [   10.515541]  el0_svc+0x30/0x94
> > > [   10.515788]  el0t_64_sync_handler+0xbc/0x13c
> > > [   10.516126]  el0t_64_sync+0x190/0x194
> > > [   10.516419] ---[ end trace 0000000000000000 ]---
> > >
> > >
> > > Build and test logs,
> > > https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.2/t=
estrun/14856342/suite/libgpiod/test/ctxless-get-value-single-line/log
> > > https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.2/t=
estrun/14856342/suite/libgpiod/tests/
> > >
> > >
> > > --
> > > Linaro LKFT
> > > https://lkft.linaro.org
