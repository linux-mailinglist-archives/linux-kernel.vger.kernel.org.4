Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BCC628A1A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237153AbiKNUIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236559AbiKNUI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:08:27 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260701108;
        Mon, 14 Nov 2022 12:08:26 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id lf15so8454529qvb.9;
        Mon, 14 Nov 2022 12:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RrPoR3x65T0grjDuHpR6Ul7miMhp6L7F3yAVPRrhNv8=;
        b=fr/mo27KrUrwqsKRMpV3+g0YPGDR2l9bFhXDBxHx5L/f1gIHNohtIdL+L2VHWqkVkU
         bxksXaRocsMd9WpplVFnxEtarhBxMj8Jjr7luJ827cwUOE52gxWoYwg7HfWDc7ptitB9
         3xOnIMUdMf0/1HTwyd+4BUIrcx+F0BhBeBlrV/IGPV23tSrVmAupKxDJICAXg6dJcVg6
         P8sidNA5JjK6LFmP2Owc1Y2whou0B8OdfqQ2cwksPo/uccwKsRsF+DVf9rTHzmAVpgos
         z+VZHLcKAKdk0wEA5mybLMS+nX/H6Lhp7FSFrgs1b1BWBOtM3dWZSjwlkk9dFk9/Z9ZY
         Z7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RrPoR3x65T0grjDuHpR6Ul7miMhp6L7F3yAVPRrhNv8=;
        b=xbX3grwB8GkM9hUNAmUF65mK0JY4TZKgRkzvzXUk1Avet6h5/sUvabtnObbwkWYxN2
         AGq1RdzzaGiQNh68y1/556ncZGR+cGOi70jUiK1PyXrfwNfJSGmIcONqTEFPgzxuXXr6
         eUJKdASU2ErejK6fh7lMhoKnNKPK5jv03YXAAe9yeptH5F8ufW1ejHq99uqhkEgFIjwu
         +iGvz13srNHLJgNyPgiSKNqGtR/KXlJrKcPo/VS//lJVH4P23J85bP/krfquMLsbECes
         +I2HsPZF3qWVWz92bVP5sy6puUPdbeIgEjxGQYxt4CfCnUhXszMPyi/IGmPexsr8PW/1
         N2EQ==
X-Gm-Message-State: ANoB5plWpVkIAyZj7dJiQ8Y1mXgDevdSBbKFyz9wcmd2CiaerJCEYufR
        A/yPAIMxNORJ1VvlKhiTHWull1G2/Lu8N+bbVX8+vkEbobA=
X-Google-Smtp-Source: AA0mqf4QgHgx6KHxwHRyLfRUDwTF/J4/LGv++FRYLZf5oBNZ19qgB72jzHBdQGjjG4atzIN1qkl2o2GuxkfHbk1MY3I=
X-Received: by 2002:a05:6214:3d97:b0:4b1:a359:c204 with SMTP id
 om23-20020a0562143d9700b004b1a359c204mr13917524qvb.64.1668456505288; Mon, 14
 Nov 2022 12:08:25 -0800 (PST)
MIME-Version: 1.0
References: <20221114180843.1125308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB5922DDCE24ED6F6DD44B4B3F86059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8tRKxpq4LiDDKd98MW27X7DnMEUw0FoL=8MLXK11tD-ng@mail.gmail.com>
 <OS0PR01MB5922E8CB8DB680347BEB997C86059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8u0X2isaMWkPhyteqPnKLKEwcR1K=TOarQQMFb8UcGLvQ@mail.gmail.com> <OS0PR01MB5922E8AC8C77B54A6572763B86059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922E8AC8C77B54A6572763B86059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 14 Nov 2022 20:07:57 +0000
Message-ID: <CA+V-a8uSS69EpkVo1iBybdeFbZZJdsYaWkPBYxgC89MAqW4EjQ@mail.gmail.com>
Subject: Re: [PATCH] watchdog: rzg2l_wdt: Issue a reset before we put the PM clocks
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 7:59 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> > Sent: 14 November 2022 19:56
> > To: Biju Das <biju.das.jz@bp.renesas.com>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>; Wim Van Sebroeck
> > <wim@linux-watchdog.org>; Guenter Roeck <linux@roeck-us.net>; Philipp
> > Zabel <p.zabel@pengutronix.de>; linux-watchdog@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-renesas-soc@vger.kernel.org; Fabrizio
> > Castro <fabrizio.castro.jz@renesas.com>; Prabhakar Mahadev Lad
> > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Subject: Re: [PATCH] watchdog: rzg2l_wdt: Issue a reset before we put
> > the PM clocks
> >
> > On Mon, Nov 14, 2022 at 7:53 PM Biju Das <biju.das.jz@bp.renesas.com>
> > wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> > > > Sent: 14 November 2022 19:46
> > > > To: Biju Das <biju.das.jz@bp.renesas.com>
> > > > Cc: Geert Uytterhoeven <geert+renesas@glider.be>; Wim Van Sebroeck
> > > > <wim@linux-watchdog.org>; Guenter Roeck <linux@roeck-us.net>;
> > > > Philipp Zabel <p.zabel@pengutronix.de>;
> > > > linux-watchdog@vger.kernel.org; linux- kernel@vger.kernel.org;
> > > > linux-renesas-soc@vger.kernel.org; Fabrizio Castro
> > > > <fabrizio.castro.jz@renesas.com>; Prabhakar Mahadev Lad
> > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > Subject: Re: [PATCH] watchdog: rzg2l_wdt: Issue a reset before we
> > > > put the PM clocks
> > > >
> > > > HI Biju,
> > > >
> > > > Thank you for the review.
> > > >
> > > > On Mon, Nov 14, 2022 at 6:42 PM Biju Das
> > > > <biju.das.jz@bp.renesas.com>
> > > > wrote:
> > > > >
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Prabhakar <prabhakar.csengg@gmail.com>
> > > > > > Sent: 14 November 2022 18:09
> > > > > > To: Geert Uytterhoeven <geert+renesas@glider.be>; Wim Van
> > > > > > Sebroeck <wim@linux-watchdog.org>; Guenter Roeck
> > > > > > <linux@roeck-us.net>; Philipp Zabel <p.zabel@pengutronix.de>;
> > > > > > linux-watchdog@vger.kernel.org
> > > > > > Cc: linux-kernel@vger.kernel.org; linux-renesas-
> > > > soc@vger.kernel.org;
> > > > > > Prabhakar <prabhakar.csengg@gmail.com>; Biju Das
> > > > > > <biju.das.jz@bp.renesas.com>; Fabrizio Castro
> > > > > > <fabrizio.castro.jz@renesas.com>; Prabhakar Mahadev Lad
> > > > > > <prabhakar.mahadev- lad.rj@bp.renesas.com>
> > > > > > Subject: [PATCH] watchdog: rzg2l_wdt: Issue a reset before we
> > > > > > put the PM clocks
> > > > > >
> > > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > >
> > > > > > On RZ/Five SoC it was observed that setting timeout (to say 1
> > > > > > sec) wouldn't reset the system. To fix this we make sure we
> > > > > > issue a
> > > > reset
> > > > > > before putting the PM clocks to make sure the registers have
> > > > > > been
> > > > cleared.
> > > > > >
> > > > > > While at it re-used rzg2l_wdt_stop() in
> > rzg2l_wdt_set_timeout()
> > > > > > as we were calling the same functions here.
> > > > > >
> > > > > > Signed-off-by: Lad Prabhakar
> > > > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > > ---
> > > > > > Note,
> > > > > > - This patch has been tested on RZ/G2L, RZ/V2M and RZ/Five.
> > > > > > - My initial investigation showed adding the delay after
> > > > > > pm_runtime_get_sync()
> > > > > >   also fixed this issue.
> > > > > > - Do I need add the fixes tag ? what should be the operation
> > > > > > PUT-
> > > > > > >RESET/RESET->PUT?
> > > > >
> > > > > It looks like timing issue, None of the previous devices are
> > > > affected by this.
> > > > >
> > > > yep.
> > > >
> > > > > >   in case we need the tag is:
> > > > > >   Fixes: 4055ee81009e6 ("watchdog: rzg2l_wdt: Add set_timeout
> > > > > > callback")
> > > > > > ---
> > > > > >  drivers/watchdog/rzg2l_wdt.c | 7 ++-----
> > > > > >  1 file changed, 2 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/watchdog/rzg2l_wdt.c
> > > > > > b/drivers/watchdog/rzg2l_wdt.c index
> > 00438ceed17a..d1271cc7750f
> > > > > > 100644
> > > > > > --- a/drivers/watchdog/rzg2l_wdt.c
> > > > > > +++ b/drivers/watchdog/rzg2l_wdt.c
> > > > > > @@ -115,16 +115,14 @@ static int rzg2l_wdt_stop(struct
> > > > > > watchdog_device *wdev) {
> > > > > >       struct rzg2l_wdt_priv *priv =
> > watchdog_get_drvdata(wdev);
> > > > > >
> > > > > > -     pm_runtime_put(wdev->parent);
> > > > > >       reset_control_reset(priv->rstc);
> > > > > > +     pm_runtime_put(wdev->parent);
> > > > > >
> > > > > >       return 0;
> > > > > >  }
> > > > > >
> > > > > >  static int rzg2l_wdt_set_timeout(struct watchdog_device
> > *wdev,
> > > > > > unsigned int
> > > > > > timeout)  {
> > > > > > -     struct rzg2l_wdt_priv *priv =
> > watchdog_get_drvdata(wdev);
> > > > > > -
> > > > > >       wdev->timeout = timeout;
> > > > > >
> > > > > >       /*
> > > > > > @@ -132,8 +130,7 @@ static int rzg2l_wdt_set_timeout(struct
> > > > > > watchdog_device *wdev, unsigned int time
> > > > > >        * register so that it is updated with new timeout
> > values.
> > > > > >        */
> > > > >
> > > > >
> > > > > Maybe update the comment above with new code change.
> > > > >
> > > >     /*
> > > >      * If the watchdog is active, reset the module for updating
> > the
> > > > WDTSET
> > > >      * register so that it is updated with new timeout values.
> > > >      */
> > > >
> > > > The above existing comment holds good with this code change. If
> > you
> > > > prefer something else please let me know I'll update it
> > accordingly.
> > >
> > > Maybe mention, The resetting of the module is done in wdt_stop
> > function.
> > >
> >     /*
> >      * If the watchdog is active, reset the module for updating the
> > WDTSET
> >      * register by calling rzg2l_wdt_stop() (which internally calls
> > reset_control_reset() and pm_runtime_put()
>
> (which internally calls reset_control_reset() to reset the module)
>
Sure will update that in v2.

Cheers,
Prabhakar
