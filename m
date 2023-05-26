Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1578C7126E6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236799AbjEZMqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjEZMqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:46:44 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450B6116
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 05:46:43 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-4301281573aso180057137.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 05:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1685105202; x=1687697202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NRC3ZPa3NfPIdVCf+Ne21WOCDIVBC/JHwP5D+y+Ang=;
        b=LWfu1cJ7lAKhgdQXa4zj/Dr4dLmZQXh+DfzLW8FoiR98QoMCbxi8rgvHbhWTeM+u1z
         DN4HHzyoKD14zLmqmDMY0hx4UDKlDzkpmJXGmgRUR+NU964IkORyYO6JDGl+rtjNHvWh
         2DexmAjdbX9xxm2mTAM0CqutjudQt1pt+GEX0oK0wXm39HcAo7PrcTXhaf8MDTwRmQ9n
         ZsxQKzJOrPMNvepB6acquEv3ODn+u48Qn1kGmR0V7kPPPf6TQ4/hsyTXr5Ut+vZ/Wbuj
         VXP4C9AgyNOibQ5vIgXrxTPrl6oWYt+fz5abn2rw2nwXwoytbiAupultoeKdn5Da+fol
         UDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685105202; x=1687697202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NRC3ZPa3NfPIdVCf+Ne21WOCDIVBC/JHwP5D+y+Ang=;
        b=L0QXbBy8Gc38zwfR1+GawhXHHUnPl3G9ij/dRoCxQb8uKPm2t2NIbqXk+LxRUSj5Z5
         ce6+PxOtfLXlCuRHI9GpypC7lJ8rDdhqiYv501LB0E/bNBkEh9arxnQukUcwWbTK2FhQ
         2UCF2Bua9l/QyfW1khwxsU1ifpd3Thnhn3l5enVXMsjyk8zHrj+lrxxgSEBHP/czPhev
         fbCxq3bEinLp2D6RCT88enQFMDyx/MaqfNC0HdKQw+tJU7H+96EzIlGgZWaOD2O9tK+q
         wvWx8GYsPLoiUqf03D6j1yCHrRz1IUgTQclHQK+IsEx932/06AoRkDK8DsGOK7uXoBb4
         y2Gg==
X-Gm-Message-State: AC+VfDx/z1Afon4S1WTemhUTmxBkasQOKr6Nb2Vk0Erwxyxd9NK2/SAN
        leyJVfyBUMTqwiTbAuOAK90NlgbQAouliL3u4oUxJw==
X-Google-Smtp-Source: ACHHUZ78qRspKTx2S38QCxQsbeX2Mc/ES0RphyPhOWJaTDxI1wCz2hkhKvfYYy5OA2NLEndjls5zg7B6WP3Us1Q9prk=
X-Received: by 2002:a67:f58e:0:b0:43a:3295:dddf with SMTP id
 i14-20020a67f58e000000b0043a3295dddfmr329082vso.9.1685105202164; Fri, 26 May
 2023 05:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <ZGzsD_HMbMGhGwcr@surfacebook> <72990baf-6964-01ad-d891-7090831d0310@alliedtelesis.co.nz>
 <ZG2jgwjK+CBmOk3G@sol>
In-Reply-To: <ZG2jgwjK+CBmOk3G@sol>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 26 May 2023 14:46:30 +0200
Message-ID: <CAMRc=Mf4+uYuwHACF3arkwhx2sXmTAJL-t1nVk-Xbg6tVy4WFQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Avoid side effects in gpio_is_visible()
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "johan@kernel.org" <johan@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        Ben Brown <Ben.Brown@alliedtelesis.co.nz>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 7:41=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Tue, May 23, 2023 at 09:17:26PM +0000, Chris Packham wrote:
> >
> > On 24/05/23 04:38, andy.shevchenko@gmail.com wrote:
> > > Wed, May 17, 2023 at 09:30:51PM +0000, Chris Packham kirjoitti:
> > >> On 17/05/23 20:54, Andy Shevchenko wrote:
> > >>> On Wed, May 17, 2023 at 2:50=E2=80=AFAM Chris Packham
> > >>> <Chris.Packham@alliedtelesis.co.nz> wrote:
> > >>>> On 17/05/23 10:47, Kent Gibson wrote:
> > > ...
> > >
> > >> Again the problem boils down to the fact that we have a userspace sw=
itch
> > >> driver (which uses a vendor supplied non-free SDK). So despite the
> > >> kernel having quite good support for SFPs I can't use it without a
> > >> netdev to attach it to.
> > > That user space driver is using what from the kernel? GPIO sysfs?
> >
> > Yes GPIO sysfs and exported links with known names, which allows things
> > to be done per-port but also wildcarded from shell scripts if necessary=
.
> > I think the key point here is that it doesn't care about the GPIO chips
> > just the individual GPIO lines. Anything involving libgpiod currently
> > has to start caring about GPIO chips (or I'm misreading the docs).
> >
>
> As previously mentioned, the libgpiod tools now support identification of
> lines by name.
> As long as your line names are unique at system scope you should be
> good.  Otherwise you have no option but to identify by (chip,offset).
>
> Wrt the library itself, I was thinking about relocating the line name
> resolution logic from the tools into the library itself, so it would be
> more generally accessible, but haven't gotten there yet.
>
> I'm also of the opinion that libgpiod is too low level for common
> tasks.  That is necessary to access all the features of the uAPI, but
> for basic tasks it would be nice to have a higher level abstraction to
> reduce the barrier to entry.
>
> e.g. in Rust I can do this:
>
>     let led0 =3D gpiocdev::find_named_line("LED0").unwrap();
>     let req =3D Request::builder()
>         .with_found_line(&led0)
>         .as_output(Value::Active)
>         .request()?;
>

I would argue that existing high-level bindings for mainline libgpiod
(C++ and Python) allow similar functionality in a comparable number of
LOC. On the other hand - core C library should remain relatively
simple and limited in features.

Chris: are you forced to use C or could you use C++ for line lookup
and management?

I'm also in the process of designing the DBus API and the base for it
will be GLib/GObject bindings for the core C lib. Maybe this is the
place where we could place more advanced features in C as GLib already
makes C coding so much easier.

Bart

>     // change value later
>     req.set_value(led0.offset, Value::Inactive)
>
> which is the equivalent of the sysfs
>
> echo 1 > /some/sysfs/line
> ...
> echo 0 > /some/sysfs/line
>
> That is bad enough. It pains me to see how complex the equivalent is usin=
g
> the libgpiod v2 API (or v1), and that is not putting any shade on Bart or
> anyone else who worked on it - there are a lot of constraints on how it
> is designed.  It just doesn't feel complete yet, particularly from a
> casual user's perspective.
>
> One of the things I would like to see added to libgpiod is a set of worki=
ng
> examples of simple use cases.  Formerly the tools took double duty to
> fill that role, but they've now grown too complex.
> Those examples would highlight where we could provide simplified
> higher level APIs.
> Then rinse and repeat until the simple use cases are simple.
>
> > >>>> I'm sure both of these applications could be re-written around lib=
gpiod
> > >>>> but that would incur a significant amount of regression testing on
> > >>>> existing platforms. And I still consider dealing with GPIO chips a=
n
> > >>>> extra headache that the applications don't need (particularly with=
 the
> > >>>> sheer number of them the SFP case).
> > >>> It seems to me that having no in-kernel driver for your stuff is th=
e
> > >>> main point of all headache here. But I might be mistaken.
> > >> It certainly doesn't help, but I do think that is all orthogonal to =
the
> > >> fact that gpio_is_visible() changes things rather than just determin=
ing
> > >> if an attribute should be exported or not.
> > > Sorry for being unhelpful here. But without understanding the issue w=
e can't
> > > propose better solutions.
> > No problem, this is probably the most engagement I've had out of a Linu=
x
> > patch submission. Hopefully it's not too annoying for those on the Cc l=
ist.
>
> Well, now you mention it....
>
> Along the same lines as Andy, it is always useful to get feedback about
> problems people are facing, and how the available solutions aren't
> working for them.
> If we don't know the problem exists then we can't fix it - except by
> accident.
>
> Cheers,
> Kent.
