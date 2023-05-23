Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CF870E9C0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238330AbjEWXtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjEWXto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:49:44 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5C1E5
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 16:49:43 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-530638a60e1so217592a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 16:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684885783; x=1687477783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPNXxfGQLeNF8bEvaTFdcMkQDHHavm6GrTqu4kuMU/U=;
        b=dXqzkZlYGNhqeHyXfMSD/xxk50ausqaYhBIuS6ZKXQ8WbzbKoDMAWtx9ronL1FgdZI
         hCzO3K/oH4AyLlKF+RbkunEo/XTaRIY69a/HSB63MKJEBr+oJDoESLnxB9XEnViB5iV/
         e8hSATK/4aD6qoa7YWAfKAVvyvL541s2HLDcS+jumAObjB5RW9VgeltlvNINqnI7bw5o
         INKW1nrVkKY+ohFe9tn0no1RGyeaCL2PZjCbkzZI0cOwaio+JiTY+dyC+ZjyBqShOuLL
         2cyRL1+n1rDnh8E3GZjUetjDRreGtkOtt+c0hNmu3NZkzHuMgFBnL/6HVNAg1OZmdDMe
         YxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684885783; x=1687477783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPNXxfGQLeNF8bEvaTFdcMkQDHHavm6GrTqu4kuMU/U=;
        b=Z+m/oTXJVs6y85qFRL6wXEWMKtc2ZdW6cAawDGZk9RZjHRzc0TebJsJejzyAjYPDC2
         UrRZ45MQdLEUT5HTh4PuGwFv/SryV5LIEITTUcw2h0uJWnrY4agwe1uXVLXesQl6Nb9i
         okcRisGyGJNdwb/gMguHF3EBnXoo6ddfxCxVt+LIpNQWbaKZ+pvhVCAWwkKPe9TJNUcy
         OIB7g96PMnv0hiKGAAjkzcJRDYyc2vAVUbOo2sUELfM/5AuWGsmN2S7oBjtdDvZ9NwTL
         v95RfeYQ0ytk2IOIkqvWOHEIERtjBfKTN53JleL9o5MsKSqugKijLKnmPBmtuYRSyjro
         y0nQ==
X-Gm-Message-State: AC+VfDwNXfxqxsccdrBZXmMvew1CNaZ7/YSz6TFVFXvzdhU3u9nillig
        qAxtqXY3EXDrQzpfaokZZ2yz4r/vWphyudb3nKg=
X-Google-Smtp-Source: ACHHUZ7hEuV/bcfgK+HuIwaHImRM/q7K79JXh/dqQE3SOrk4OtZellWtDB81HVCETLGc/QT8nok9kDXdeID6YDasbzM=
X-Received: by 2002:a17:90b:1e49:b0:250:9aee:563c with SMTP id
 pi9-20020a17090b1e4900b002509aee563cmr14233221pjb.41.1684885782579; Tue, 23
 May 2023 16:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230518230626.404068-1-aford173@gmail.com> <CAOMZO5DBefFuLWi39txu2RiU5vdHVx-0T48Fua6M5Y6Fr9PGNg@mail.gmail.com>
 <CAHCN7xLqmMPtnHTVbApyYxY2tx97oRjsk_51abdDcZkOJmA=Tw@mail.gmail.com>
In-Reply-To: <CAHCN7xLqmMPtnHTVbApyYxY2tx97oRjsk_51abdDcZkOJmA=Tw@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 23 May 2023 18:49:31 -0500
Message-ID: <CAHCN7xJTWqf_qfaZge4GpKuuzPE_OC-Kx7hBd_hFLOchH=Ef0g@mail.gmail.com>
Subject: Re: [PATCH V7 0/6] drm: bridge: samsung-dsim: Support variable clocking
To:     Fabio Estevam <festevam@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>, aford@beaconembedded.com,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Inki Dae <inki.dae@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 8:34=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> On Thu, May 18, 2023 at 7:29=E2=80=AFPM Fabio Estevam <festevam@gmail.com=
> wrote:
> >
> > Hi Adam,
> >
> > On Thu, May 18, 2023 at 8:06=E2=80=AFPM Adam Ford <aford173@gmail.com> =
wrote:
> > >
> > > This series fixes the blanking pack size and the PMS calculation.  It=
 then
> > > adds support to allows the DSIM to dynamically DPHY clocks, and suppo=
rt
> > > non-burst mode while allowing the removal of the hard-coded clock val=
ues
> > > for the PLL for imx8m mini/nano/plus, and it allows the removal of th=
e
> > > burst-clock device tree entry when burst-mode isn't supported by conn=
ected
> > > devices like an HDMI brige.  In that event, the HS clock is set to th=
e
> > > value requested by the bridge chip.
> > >
> > > This has been tested on both an i.MX8M Nano and i.MX8M Plus, and shou=
ld
> > > work on i.MX8M Mini as well. Marek Szyprowski has tested it on variou=
s
> > > Exynos boards.
> > >
> > > Adam Ford (5):
> > >   drm: bridge: samsung-dsim: Fix PMS Calculator on imx8m[mnp]
> > >   drm: bridge: samsung-dsim: Fetch pll-clock-frequency automatically
> > >   drm: bridge: samsung-dsim: Select GENERIC_PHY_MIPI_DPHY
> > >   drm: bridge: samsung-dsim: Dynamically configure DPHY timing
> > >   drm: bridge: samsung-dsim: Support non-burst mode
> > >
> > > Lucas Stach (1):
> > >   drm: bridge: samsung-dsim: fix blanking packet size calculation
> > >
> > >  drivers/gpu/drm/bridge/Kconfig        |   1 +
> > >  drivers/gpu/drm/bridge/samsung-dsim.c | 142 +++++++++++++++++++++---=
--
> > >  include/drm/bridge/samsung-dsim.h     |   4 +
> > >  3 files changed, 124 insertions(+), 23 deletions(-)
> > >
> > > V7:  Move messages indicating the optional device tree items are goin=
g
> > >      to be automatically read elsewhere was move to dev_dbg instead o=
f
> > >      dev_info.  Cleaned up some of the comments to be a bit more clea=
r.
> > >      Eliminated a double variable assignement accidentally introduced
> > >      in V6 when some of the items were moved from patch 6 to patch 5.
> >
> > It seems you missed addressing one previous comment from Lucas:
> >
> > "Same as with the earlier patch, this needs to be documented in the DT
> > binding by moving "samsung,burst-clock-frequency" to be a optional
> > property."
>
> Aargh!
> I can't believe I did that.
>
> Inki,
>
> Can I do a single patch to which references this one and have you
> apply them together when the time is right, or do you want me to
> resend the whole series with an additional patch at the end making the
> two device tree items optional?

Inki,

I haven't heard back from you on whether or not you want the bindings
patch to be included with me resending the series as V7 or if you're
OK with a single, stand-alone patch.
Will you let me know?  I have the patch standing by waiting for
instructions.  If you're not the right person to ask, please let me
know who the right person is.

thanks

adam
> I totally forgot, and I'm sorry.
>
> adam
>
> A
