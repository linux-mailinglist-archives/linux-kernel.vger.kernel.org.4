Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6448F71700B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjE3V5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjE3V5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:57:47 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C35114;
        Tue, 30 May 2023 14:57:34 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-62614a1dd47so17920566d6.2;
        Tue, 30 May 2023 14:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685483853; x=1688075853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYiucnfM0Npgk8Dfcf+Qwmw4paZYUq2wG1w9OkYZvNg=;
        b=BRtCCLmYybQg/mv9pOtG9hKp/KqNsyfK+9vMxgL5TNYC0QOSkeJjwS5Q2bXk71h07q
         SnhD2GCtS08dXyG+M0WCr4MHSaqX4WQ53pvatrvMWDvrD/lPNH74QiBhJR9720L2jKLs
         0kyKye0RCengQPXMLZQfTVAAEssn6Oam/cygCFOE0nbrrqtEzIXYREYnbY6vSlCR84MP
         MTPBYFIO6lHBxwhnkDdbpwcw/StU612Hmf7zATxGeknGHEmlLWdAFrhCPakMJZCvZOfi
         Kzm+ZdbnhTPSHvxV5vw5yirbUOBsD+jgFtTTAfdfI+Sz49qZApaKYCCZ/Iat5RxRVPM/
         76FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685483853; x=1688075853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYiucnfM0Npgk8Dfcf+Qwmw4paZYUq2wG1w9OkYZvNg=;
        b=jry1xPvpoCwHSInAWrvCW22sOlKkK2fi3CD8slOEbIiwlQ0ssu/Pm/hU0Iegnncnoy
         chRdu3jxKajjBTev0zqM5I7wB6f5PXCMOBu3TeqSrhPW0vGyMyW8qF4a3nGsehr2XC/z
         K9M7hqUOWYASPoArXUZ+wiGwv13EkpR2eNFpcFcOB735kE4uAENxMrMTaoSgvGQBGNzF
         8xRAbdtkgwrHo6mYv2tF/XK/0twFuieUM8bU7vFSVxdzHul75vIYNP23sISlB56ZQuiO
         65+bJKi1c823GXAo/ZW0yrH/6bBZf/PKKpTrDdCxccQxwHRI5XjnPCaIQFGbmB7T0Uat
         Ry0Q==
X-Gm-Message-State: AC+VfDytadoBuxNG/Cm5Bpzehy56OnHPxlHL0tNr/kzgZMGgWqSkx+e2
        nVg3rhxANiPEBEuII95CI9fEEwRHA902snZrw2Y=
X-Google-Smtp-Source: ACHHUZ5an7ihyJFTYhsnslUfKf7Z5lKrCh1Kw7qDfmfcuNAeno51rCrapfAtR7Cpktpe5lQhKXcA1ZDDfqMvaV9v8Ag=
X-Received: by 2002:ad4:5f8b:0:b0:623:86a9:7696 with SMTP id
 jp11-20020ad45f8b000000b0062386a97696mr3918175qvb.5.1685483853670; Tue, 30
 May 2023 14:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230529140711.896830-1-hugo@hugovil.com> <20230529140711.896830-8-hugo@hugovil.com>
 <ZHUpWQafRPHW1RJQ@surfacebook> <20230530113649.73f28b9f6ba91f17ace1e12f@hugovil.com>
In-Reply-To: <20230530113649.73f28b9f6ba91f17ace1e12f@hugovil.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 31 May 2023 00:56:57 +0300
Message-ID: <CAHp75Vf35rN93sXFBU0nRZQLpUgQHR2caGC8BmHkEgPZqF=dQg@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] serial: sc16is7xx: fix regression with GPIO configuration
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
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

On Tue, May 30, 2023 at 6:36=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> =
wrote:
> On Tue, 30 May 2023 01:38:17 +0300
> andy.shevchenko@gmail.com wrote:
> > Mon, May 29, 2023 at 10:07:09AM -0400, Hugo Villeneuve kirjoitti:

...

> > GENMASK()
>
> Ok done, altough even if in general I like the bit manipulation macros be=
cause they make the code easier to read/understand, I find it less obvious =
by using GENMASK in this case IMMO.

GENMASK() was introduced to increase code robustness:
1) to make sure the bits mentioned are correct
2) to check the bit boundary.

...

> > > +           of_property_for_each_u32(dev->of_node, "nxp,modem-control=
-line-ports",
> > > +                                    prop, p, u) {
> > > +                   if (u >=3D devtype->nr_uart)
> > > +                           continue;
> > > +
> > > +                   /* Use GPIO lines as modem control lines */
> > > +                   if (u =3D=3D 0)
> > > +                           mctrl_mask |=3D SC16IS7XX_IOCONTROL_MODEM=
_A_BIT;
> > > +                   else if (u =3D=3D 1)
> > > +                           mctrl_mask |=3D SC16IS7XX_IOCONTROL_MODEM=
_B_BIT;
> > > +           }
> >
> > Can we use device properties, please?
>
> I have converted this section to use device_property_count_u32() and devi=
ce_property_read_u32_array(). Is that Ok?

Yes, thank you!

> > If you think about backporting to the earlier kernels (w/o properties i=
n use in
> > this driver), perhaps an additional followup for that?
>
> I am not sure what you mean by this?

If the device property API was not yet available for this fix being
backported to the old enough kernel we have to use old OF stuff. In
that case the device property conversion needs to be done in a
separate change.

--=20
With Best Regards,
Andy Shevchenko
