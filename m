Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196BD70BC3B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbjEVLub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbjEVLuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:50:10 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2F01B1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:50:01 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30781184e78so2401274f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684756200; x=1687348200;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKgwbXDZ93PhOsZpMHYSuhMcEuh5tVlQ5GHAYoAXTTk=;
        b=oXlZi6dQ+locvnwMb6tXz6Haerq4h2rmMsYNDuyKGsjCLrXuZZ1WoRXsul7Hmffq5V
         BAL5Xy1fvZBlwHlGAT4Gt9cdnpFuUHC2JYFmRLtAE9y3lQmrh0C+vKG4mtkZbEBMn711
         CKts6AS3KF5mRTiEiAI+P31FqY1psc+RKnBht4wKqqVdoaW+l7FwVq9KM4rxq6MEu5Fq
         Io9rAmmmjXOOwWXFp2Xy8qeX1NwzTdOOwg3ScATZSQ8mzRVx61Q2314f4i1dos2r1GoA
         cMt8ymh+xftxI78J0hkyTAuZvtfVhvhgUMELKVvy7asFaUmGTrJNEsNXE2Rowf+wWf42
         dQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684756200; x=1687348200;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sKgwbXDZ93PhOsZpMHYSuhMcEuh5tVlQ5GHAYoAXTTk=;
        b=RncacVmDTiqmB3hly+U8K459+au8ohy4JulGfPbeevOtjPetrQCO/htrh7kWuT2Ofs
         Ux6BVM182nMwq7kuNmff60v+fhtXsLn/iD6o6DcjpZKneWiBPhzWGcLGWWOE5CgRb+W0
         39KDLf/Q1nhQeSwboZeWdWxNdSq5YJ4tj80U3XDw2hDkagfMjvVOfNH9hGBmKnMCW+cz
         kEqYfS6kyjWbSBfSMJ0wTUSfydN6dtERaSksEFFIkLUXa2HIA9emKjl3jZvqxos/vkgG
         hlSXAdr6YNFsA4gUAnr1T1or51wTcYx+TqzhW+9EGe/gJfbHsYcUcdgN7vqfq+Ht28EJ
         JDsQ==
X-Gm-Message-State: AC+VfDzS+20+Rd9aqlPMPy9KMUDP8NRDYr9SSlAkzHOquANvwjQb9Cpz
        3egthzDyeo9IRRi+cMluOGOvbw==
X-Google-Smtp-Source: ACHHUZ4aNoH0wsH4IeJXzePZtSiXVMs1nKqN0mwAKpV4dgI33pkdm3OAwuaeuaJLSl4OQrhKVI7aag==
X-Received: by 2002:adf:f48f:0:b0:307:5091:5b96 with SMTP id l15-20020adff48f000000b0030750915b96mr10113342wro.22.1684756200409;
        Mon, 22 May 2023 04:50:00 -0700 (PDT)
Received: from localhost ([2a01:e0a:28d:66d0:72d:52cc:8221:fcda])
        by smtp.gmail.com with ESMTPSA id n16-20020a1c7210000000b003f6042d6d92sm3490280wmc.46.2023.05.22.04.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 04:49:59 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 22 May 2023 13:49:58 +0200
Message-Id: <CSSS892QYLWK.3T71MRNHOH0IZ@burritosblues>
Cc:     <linus.walleij@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <jpanis@baylibre.com>, <jneanne@baylibre.com>,
        <aseketeli@baylibre.com>, <sterzik@ti.com>, <u-kumar1@ti.com>
Subject: Re: [PATCH v4 1/3] rtc: tps6594: Add driver for TPS6594 RTC
From:   "Esteban Blanc" <eblanc@baylibre.com>
To:     "Andy Shevchenko" <andy.shevchenko@gmail.com>
X-Mailer: aerc 0.14.0
References: <20230512141755.1712358-1-eblanc@baylibre.com>
 <20230512141755.1712358-2-eblanc@baylibre.com>
 <ZF514wvUt_xrU1gG@surfacebook> <CSOPFJOVLSS1.1XKI60F9TLBMN@burritosblues>
 <CAHp75Vfg+yAhJ58qt76GHqxWHD48hF-6ZnT=xEUh+1rzr7UvVg@mail.gmail.com>
In-Reply-To: <CAHp75Vfg+yAhJ58qt76GHqxWHD48hF-6ZnT=xEUh+1rzr7UvVg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed May 17, 2023 at 6:52 PM CEST, Andy Shevchenko wrote:
> On Wed, May 17, 2023 at 7:47=E2=80=AFPM Esteban Blanc <eblanc@baylibre.co=
m> wrote:
> > On Fri May 12, 2023 at 7:22 PM CEST,  wrote:
> > > Fri, May 12, 2023 at 04:17:53PM +0200, Esteban Blanc kirjoitti:
>
> ...
>
> > > > +/* Multiplier for ppb conversions */
> > > > +#define PPB_MULT (1000000000LL)
> > >
> > > We have something in units.h. Can you use generic macro?
> >
> > I found GIGA, NANO and NANOHZ_PER_HZ that have the same value in
> > units.h. However I'm not sure any of them have the correct meaning in
> > this situation.
>
> MULT[IPLIER] has no units AFAIU, so SI macro can be used, no? NANO or
> GIGA depends on what the actual sign of the exponent of the multiplier
> is. Write it on paper and check the exponent in the equation(s) and
> hence decide which one to use.

Thanks. I've checked and it should be NANO.

> > > > +   if (tmp < 0)
> > > > +           tmp -=3D TICKS_PER_HOUR / 2LL;
> > > > +   else
> > > > +           tmp +=3D TICKS_PER_HOUR / 2LL;
> > >
> > > Is it guaranteed to have no overflow here?
> >
> > We know from `tps6594_rtc_set_offset` that the loaded value can't be
> > more than 277774 (register default value is 0), So `tmp` can't exceed
> > 277774000000000 which is lower than 2^63-1. No overflow here.
> >
> > TICK_PER_HOUR / 2LL =3D 117964800, so at the end of this computation,
> > `tmp` can have a maximum value of 277774117964800 which is still
> > inferior to 2^63-1.
>
> Please add a respective comment.

I've reformatted this and put it in a SAFETY comment.

Thanks for your help,

--=20
Esteban Blanc
BayLibre
