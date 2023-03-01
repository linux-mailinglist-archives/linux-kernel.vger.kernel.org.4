Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298676A7421
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 20:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCATS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 14:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCATSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 14:18:24 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2471EBC2;
        Wed,  1 Mar 2023 11:18:23 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-53852143afcso384166877b3.3;
        Wed, 01 Mar 2023 11:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677698303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23JQW2toAhs2AFJdAfxCU+3AN4ytaD1vY+Dl9fhWH7Y=;
        b=KzEB5DUek2nzo+HtCjrEUZYoBEs5aHuUgNBz31smBjiZTb2IriCwgCZ1x05L9txm5L
         oLF1PWTZjY/NNm7dcAh0HPIhsFpZSZn8T0QP/Hc5xxVlyMC8bZu7VQtMSPiG9nIcNSUr
         H7bcOkq7iDdMgPKBw2pw41soe5cac8j7e0ufdDh+PVwfAPjPcQKOwRhDrIM7JLqtijfn
         WRg/xP3ZIOYeRAD38lMjvHZuuRbTyX8p+muyfYF+pyABKNUmn2npajOsrRoZ0PNkPMIt
         4fPfD9i0TK1yaojDW5jkcdZKLhLjdlUgCMayNfZFandGFIh8pgkchl3HVkviT3CU+d/2
         4UTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677698303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23JQW2toAhs2AFJdAfxCU+3AN4ytaD1vY+Dl9fhWH7Y=;
        b=oqujfuroOX2mqKYaWEv9FDC5vMOIl+g7aSIqXt6U4MJ/QKDOWuIEAvDkdUgE+tGwr5
         Kblql7O+zjuEZrRSiKI2fIi7r6pH1ZQVYzlrUb8ouy3jYrsoCq8nihxrkViGPxMLxFOY
         xwmx5wcN6NvWhte9v3Z6KXRL+rkRlS0VvzoLQ3/zRPDayIOFReUHWBRyGg5NyVSS0T7v
         RjlG+K6mJlm4QWWhwSdbA+n2jFLmkCDZvxqR8hx+EZ2hz+c4lRr+FTvSymCPYhqv1sB1
         tPmHjuVlZQaDtDUH0egw0gdWn1zX0+/VZnrssrqMWFtWZgD/usuto5ywdkFxi6sQlX4s
         A7eg==
X-Gm-Message-State: AO0yUKWWvlXhJKVNjTcx9hj0Eq5ErgfhbL9z5SOTWFhpo7W6TFeBJzvJ
        kFauWHcQXdGNwNJ5xG1Slo4kFD3OlMfhBpnGrHZq2W/x4gs=
X-Google-Smtp-Source: AK7set8MPQMxAWXOgl3x+cBDIhTdeBUXYshVeDWf0RIav50/cx1syOKs+7GO/bcO8LRiDaqgkxfITCKzmNHvqwfg5jQ=
X-Received: by 2002:a81:b603:0:b0:533:9b00:dd0b with SMTP id
 u3-20020a81b603000000b005339b00dd0bmr4707635ywh.2.1677698302873; Wed, 01 Mar
 2023 11:18:22 -0800 (PST)
MIME-Version: 1.0
References: <20230228155121.3416-1-ubizjak@gmail.com> <Y/5mguXPPqdP3MZF@google.com>
 <20230228160324.2a7c1012@gandalf.local.home> <20230228212911.GX2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230228164124.77c126d2@gandalf.local.home> <CAEXW_YQ515_DOLVUm48GvDADuaY2mSrYTaKa7u6jYDNqBncJww@mail.gmail.com>
 <20230228190846.79b06089@gandalf.local.home> <CAFULd4aY3Y8tyLN70oebZDagBebvH0erwRxKDaEX8L83Xo8gYw@mail.gmail.com>
 <20230301113813.4f16a689@gandalf.local.home> <CAFULd4aWZ+fvVZ+MEt6JD1rFaQZeO5DDWAHtPKOrx8R8DETFBw@mail.gmail.com>
 <20230301135201.59771b73@gandalf.local.home>
In-Reply-To: <20230301135201.59771b73@gandalf.local.home>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 1 Mar 2023 20:18:11 +0100
Message-ID: <CAFULd4YPP_5koKN5ZbdgOueXcpUgap97UkaxxyzzGcQ=GEV__Q@mail.gmail.com>
Subject: Re: [PATCH] rcu: use try_cmpxchg in check_cpu_stall
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
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

On Wed, Mar 1, 2023 at 7:52=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Wed, 1 Mar 2023 19:43:34 +0100
> Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > On Wed, Mar 1, 2023 at 5:38=E2=80=AFPM Steven Rostedt <rostedt@goodmis.=
org> wrote:
> > >
> > > On Wed, 1 Mar 2023 11:28:47 +0100
> > > Uros Bizjak <ubizjak@gmail.com> wrote:
> > >
> > > > These benefits are the reason the change to try_cmpxchg was accepte=
d
> > > > also in the linear code elsewhere in the linux kernel, e.g. [2,3] t=
o
> > > > name a few commits, with a thumbs-up and a claim that the new code =
is
> > > > actually *clearer* at the merge commit [4].
> > >
> > > I'll say it here too. I really like Joel's suggestion of having a
> > > cmpxchg_success() that does not have the added side effect of modifyi=
ng the
> > > old variable.
> > >
> > > I think that would allow for the arch optimizations that you are tryi=
ng to
> > > achieve, as well as remove the side effect that might cause issues do=
wn the
> > > road.
> >
> > Attached patch implements this suggestion.
>
> I like it!

Thanks!

> Anyway to make this more generic?

If we want to put the definition in generic headers, then we also need
to define acquire/release/relaxed and 64bit variants. ATM, we have two
sites that require this definition and I think that for now we could
live with two instances of the same definition in two separate
subsystems. But this would definitely be a good future addition. There
is some code in the form of

if (cmpxchg (ptr, 0, 1) =3D=3D 0)

that can not be converted to try_cmpxchg, but can use cmpxchg_success.

Uros.
