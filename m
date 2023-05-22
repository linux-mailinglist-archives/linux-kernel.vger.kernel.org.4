Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8718E70C590
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 20:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjEVSxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 14:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjEVSxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 14:53:36 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88C2CA;
        Mon, 22 May 2023 11:53:35 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-62382e9cb8dso28259286d6.2;
        Mon, 22 May 2023 11:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684781615; x=1687373615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30Eg1W0/PVJoNgJmlhViRtPm/hFCComHEofZ84WbfT0=;
        b=brsvc4vjuFNOIePz5krAnwGysQawUWClCxx8s2XANWCrZmucEXAQL6QT4bhG/14HO1
         U8/l1bM6PCTEbvquyTQvB+n6XabC0UJKNY9/fI0aG2+jeLH9XINjl9WS0E3kjtGgwCHK
         nF4JMiVIRgMO+q6xifp/Jlj7yUoLzYO2vSh4DS+Z08e2NQAj6BaT3gpGs77qDgyMW7f2
         0dnzB59sDRSgUEOaDK7PKflHjo6ryYs0LGUpSjeG8lhN+ORjysL07UIvZpRn6yA/dQZn
         fB6ZB4QD0rj/sp6tuGOFs3gI6g/KYiOti6zuMtx3iwYFGPE2NMCVaKLKJaOR7P0eatmP
         zZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684781615; x=1687373615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30Eg1W0/PVJoNgJmlhViRtPm/hFCComHEofZ84WbfT0=;
        b=R/hcwzdFcRHnP4CMvkoZ+PG2BuJ9Ra8OIYdtb4qAJKFk/XihNpgZuOGl/8F7uJ6NQp
         OO7A2aPtxAxdJFT2Kh563emR9sRqrzTiAXa+jDS81CrWTHyLIP5OBkWJW3g120H39vIr
         4iVaCeje7fkjza59nwC4oWXi3RQuvSMGNl3w4qJC8vr09Ayf4jgq8BqSCp18hfewAKRh
         3DlfiZw62Oxzcv+zZRq5VpTqNRoNly2iStSPv2oPpvjnMYXYpSly4SwzHQ9BcjyE47AA
         PwWqEQIstoYQW9ndkq3G1qgu7B5Rmvdja9Xjqx6ZL81s0Z8zYb3spf70MK74LN+1ISW9
         zGgg==
X-Gm-Message-State: AC+VfDxPMYXOrqITTeQ4smNzQzL7my9e689tIVD0whpmtMOX4mdyCIq+
        cYWHmCnoML08/xoU8U4oWpaxwYOcoJ32pFFvSHs=
X-Google-Smtp-Source: ACHHUZ7dgu7HMNUNsbWJ26VQFc6i8a9UoEtfSZ7Ik3KH30Q78I/Obk3lcIK78xCnFSlXJF/52ow7ETv3TrOjgSUesAk=
X-Received: by 2002:a05:6214:21e8:b0:618:e1d9:75b8 with SMTP id
 p8-20020a05621421e800b00618e1d975b8mr19386293qvj.34.1684781614780; Mon, 22
 May 2023 11:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230517195238.34069-1-mmkurbanov@sberdevices.ru>
 <20230517195238.34069-3-mmkurbanov@sberdevices.ru> <CAHp75VdEc9x=v-NU4wqrg-S0vEjqc27JPqZAK0TJsNUc37ZTmg@mail.gmail.com>
 <20230522071426.GP404509@google.com> <CAHp75VdG6nSHgzmp9yA2aAwvzWuaYf2Q71tz2ruDPnwb=h=hiQ@mail.gmail.com>
 <20230522163537.GR404509@google.com>
In-Reply-To: <20230522163537.GR404509@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 22 May 2023 21:52:58 +0300
Message-ID: <CAHp75Ve4EAAj+6VTtYPS-5n+RSobN6ZcwS61kHFaGzHQ-8YhYw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] leds: add aw20xx driver
To:     Lee Jones <lee@kernel.org>
Cc:     Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@sberdevices.ru
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

On Mon, May 22, 2023 at 7:35=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
> On Mon, 22 May 2023, Andy Shevchenko wrote:
> > On Mon, May 22, 2023 at 10:14=E2=80=AFAM Lee Jones <lee@kernel.org> wro=
te:
> > > On Thu, 18 May 2023, Andy Shevchenko wrote:
> > > > On Wed, May 17, 2023 at 10:52=E2=80=AFPM Martin Kurbanov
> > > > <mmkurbanov@sberdevices.ru> wrote:

...

> > > > I would do
> > > >
> > > >   i =3D 0;
> > > >
> > > > here and drop the assignment in the definition block to be more rob=
ust
> > >
> > > "here" where?
> >
> > > You've removed all context.
> >
> > That's not true. The below line exclusively defines the location in
> > the code that I'm talking about. Note, Martin understood that AFAICT
> > and addressed in the new version.
>
> I'd expect the author to have a solid understanding of the code.  I
> found this difficult to read as-was and had to go look at the patch to
> understand it.

I see your point.

> No biggy.  Just something to bear in mind.

No worries, and thanks for the remark. I'll try my best to satisfy
others and not only the author of the code in the future reviews.

> > > > against sudden reuse of i in between.
> > > >
> > > > > +       device_for_each_child_node(dev, child) {
> > > >
> > > > > +               i++;
> > > > > +       }


--=20
With Best Regards,
Andy Shevchenko
