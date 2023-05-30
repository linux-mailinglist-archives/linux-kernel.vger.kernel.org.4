Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122E9716FEA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjE3VnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjE3VnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:43:17 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1645AA;
        Tue, 30 May 2023 14:43:16 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-6261a25e9b6so17258326d6.0;
        Tue, 30 May 2023 14:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685482996; x=1688074996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dtwEnZAc57spOnGNdW2PTOFa91M8IAZbZYzAn0ONSI=;
        b=sFpq+/JvfbC7qcOEKa2zDofaoqF2q9TsHKDTwOusxIZLA7LwIQOEv28qS5LGHBh9eq
         AMyoNMsmOptgNZfCWJuK5D93XNW6Pyvlh/LnIPe7x9ZM84VylnVzQOdPsHINcWRZ0LDb
         wpkHV/HC1pi8qYkDvKvzkxUIPR6MkIm9cBfKMF5T/gNnYl4CEQE9Nn/qE5XG56jbscno
         h5y7LkEM3ssF3IR/Y6El0WKtxUnqn6diB+4gL8ZM54hcL6lv2PSJoyet6NOTKCUU6I0h
         ZTTN02GuWErMcn3efrgz50/y1pgOY1KJuL59gXEXqN1b2xP4SFSHKykV2oTcN2ZWdxuy
         rCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685482996; x=1688074996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dtwEnZAc57spOnGNdW2PTOFa91M8IAZbZYzAn0ONSI=;
        b=VVDFOrtc5BgyOCzT+ZJZsjoYWKNVkqRn5dmPwVYXQZl9BTGlH3+G9RhaXfJ9tjTxId
         qTRfZpGCQuI/u/6BGLLfU27FVIO27QP9UuhocAiCTznSUcVDe1+p2EL2r+hyKpIIaNnP
         0udiYlR8A0vK+iGtIKKbWSwhizxyXibyeWZF87ltPAdKViHw5feXqoi2or8EBbe/6Jdc
         ktfPkl76N53DicXxxwbFPCQc0cE5v5JU+WNFnN6tzuTj72CN7DVF0h4CuxfHwEAwZP11
         RmcFCqL/XUvIZfBOx5qOpDpBjHqNpIaXd3memfp6Il6oXPG5IvMXhIN6GC5Lv6d8vUlB
         CH5A==
X-Gm-Message-State: AC+VfDy1TR6iCekqkUy5rtu5LEIrCoXaknse6v13xGZeeuft9trtQ5Vb
        AeYkO472F03ZziYiC3BJmxharXfVwS9f/TFFBEs=
X-Google-Smtp-Source: ACHHUZ4sL7udrrW4DpI5BcayuLBaHYhSk4L18c22qfcTH3WQFl4Un0ZAxd8awx2b4YHl638CwRWTXE3c90mZaTUmcMQ=
X-Received: by 2002:ad4:5bc6:0:b0:625:aa1a:b6d9 with SMTP id
 t6-20020ad45bc6000000b00625aa1ab6d9mr4231186qvt.59.1685482995723; Tue, 30 May
 2023 14:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230529025011.2806-1-xingtong_wu@163.com> <20230529025011.2806-2-xingtong_wu@163.com>
 <ZHSZ9cK78qc5QeZD@localhost> <CACRpkdbiRsJqxVZPNLvLPK-MzEhyjSBGffuaTgP7tt40pGGoRw@mail.gmail.com>
 <ZHSunJyh2AU1eb0H@localhost> <ZHUmHkbM-l_pRaY3@surfacebook> <ZHY4LFyyIGSMiMbm@localhost>
In-Reply-To: <ZHY4LFyyIGSMiMbm@localhost>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 31 May 2023 00:42:39 +0300
Message-ID: <CAHp75VcUGFN_kZcxfBVyUZB8i=UKEd-_-4FBgbk=zfq_gaCGmw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpio-f7188x: fix base values conflicts with other
 gpio pins
To:     simon.guinot@sequanux.org
Cc:     Linus Walleij <linus.walleij@linaro.org>, xingtong_wu@163.com,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, henning.schild@siemens.com,
        xingtong.wu@siemens.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 8:56=E2=80=AFPM <simon.guinot@sequanux.org> wrote:
> On Tue, May 30, 2023 at 01:24:30AM +0300, andy.shevchenko@gmail.com wrote=
:
> > Mon, May 29, 2023 at 03:54:36PM +0200, simon.guinot@sequanux.org kirjoi=
tti:
> > > On Mon, May 29, 2023 at 03:03:28PM +0200, Linus Walleij wrote:
> > > > On Mon, May 29, 2023 at 2:27=E2=80=AFPM <simon.guinot@sequanux.org>=
 wrote:
> > > >
> > > > > It would be nice if a pin number found in the device datasheet co=
uld
> > > > > still be converted into a Linux GPIO number by adding the base of=
 the
> > > > > first bank.
> > > >
> > > > We actively discourage this kind of mapping because of reasons stat=
ed
> > > > in drivers/gpio/TODO: we want dynamic number allocation to be the
> > > > norm.
> > >
> > > Sure but it would be nice to have a dynamic base applied to a control=
ler
> > > (and not to each chip of this controller), and to respect the interva=
l
> > > between the chips (as stated in the controllers datasheets).
> >
> > What you want is against the architecture. To fix this, you might chang=
e
> > the architecture of the driver to have one chip for the controller, but
> > it's quite questionable change. Also how can you guarantee ordering of
> > the enumeration? You probably need to *disable* SMP on the boot time.
> > This will still be fragile as long as GPIO chip can be unbound at run
> > time. Order can be changed.
> >
> > So, the patch is good and the correct way to go.
> >
> > P.S. The root cause is that hardware engineers and documentation writer=
s
> > do not consider their hardware in the multi-tasking, multi-user general
> > purpose operating system, such as Linux. I believe the ideal fix is to =
fix the
> > documentation (datasheet).
>
> Some GPIO controllers (as Super-I/O) are multifunctional devices and
> pins are multiplexed. Some can be configured to act as GPIOs and some
> cannot. So there are holes. It is an hardware reality and not only an
> issue due to poorly written documents (even if there are issues with
> them too).

So, this is done with GPIO to pin mapping (and yes, pin control has to
be present). In simpler cases the valid mask is enough.

> Today we work around these holes by splitting the GPIOs between several
> chips.

What you are saying seems like a broken architecture of the certain
driver, i.e. exposing hardware not in the correct representation
(wrong mapping). Maybe I'm missing something...

> As a consequence "hardware" GPIO numbers don't exist in Linux. It
> requires some work from a user to first find the chip a GPIO belongs to
> and then compute the number. It is not terrible. But on some machines
> with a lot of GPIO controllers and chips it can be quite challenging
> (especially when ACPI is involved).

Not sure how ACPI makes things worse (except the number space used for
GpioIo() and GpioInt() resources, which in case of existing pin
control may be different to the pin numbering). In any case the pin
control case is covered nowadays in debugfs and one may look at that
to find the mapping and pin naming.

> I am only saying it would be nice for Linux users if they could use
> hardware GPIO numbers (i.e. as read in hardware documents).

It's impossible. I can make an example which is the UP board (or UP=C2=B2
a.k.a. UP Square) where GPIO from SoC goes through CPLD and becomes
completely non-related in the documentation. AFAIU all the same for
Raspberry Pi.

Besides that, if a board has an I=C2=B2C expander, and other I=C2=B2C buses
available to connect anything, it will always be ambiguous.

--=20
With Best Regards,
Andy Shevchenko
