Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753086E87F1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 04:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjDTCYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 22:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjDTCYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 22:24:18 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9A6448A;
        Wed, 19 Apr 2023 19:24:14 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b62d2f729so476437b3a.1;
        Wed, 19 Apr 2023 19:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681957454; x=1684549454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hCnIiv0UZoUyqA3j7om4LR5r+3eUZFma/siIy2qvxI=;
        b=aHY0KqzYmBUMNi2SicP8NE4mewVj4KbcqsIdBEOZnX3xv6AbcZVdLJaMN/46ZG2byr
         rBxvGegBdnF3Blj7IULlxmIG7Vc3WSEf6BxpnZwgTSwm5BKMmNTladesWKF27zZEbwa1
         2/069yWBd3mg4yjNl+d9e9NWhFp+40oZgCrJat2dufA7loHBzTGP7MZEEccaSghk9UNB
         QdRJWyYbYJMp0DMsz6nPSJSA6qCJqVd/sd/tHuSTY6mh0fdNp7D77VyWAz3HdyDGpgw/
         MVZJFN+jnIfr2ZMz23p3AofUQ3GIbgveA3oSWQVTDDG8Ucl0RVwh3QnYcf1cgW4/5zAf
         pf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681957454; x=1684549454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5hCnIiv0UZoUyqA3j7om4LR5r+3eUZFma/siIy2qvxI=;
        b=GVf+oQFaY6dVbZ6G6pD54B55hRS7qyPREg6bf/4taRGUeIKE2VVsAGu0nnDNZkgrrD
         aAGzDOBizcdvazbaqx6bHVCGEK7183HWvboM1vDZ/5Wl5TwrcLQ2QqzGci4v0zb19n7E
         fWDQMbMay/QGK/YrzlOdSOWh9+KGJb2L06+XyFfkNVNOOQyVDHx0ZIy2x+X/oZHJGk9z
         IPhmbXv66BPXPoLL1h4BsvEz7ioV03usk3hwAx1Y1FhD2oWXauUlye7o6arn2foK7bLR
         NidWL0yI3g1OFhETNY0s103nuuxjmwSFLprj2IUaRAiCk+wiWhccCia7W7bSXPcdSMGq
         6tag==
X-Gm-Message-State: AAQBX9dsk+sISvE+Fu/LrzhqmqTYGs2EdGXpabgI6ITqa/JznjH2hmf1
        zwHx7tWKYPhto3eSkkna+ZBzJIR7bIEXLZv4n7I=
X-Google-Smtp-Source: AKy350ZadxRbNfm3xfOR9s+wQOjZ3vM83wayISANsNazFfeiI4PtzsEAeWCrcjhACnyQu547bwbY7U3jZ3QonfXSGK4=
X-Received: by 2002:a17:90a:ad90:b0:247:bd63:c3af with SMTP id
 s16-20020a17090aad9000b00247bd63c3afmr181414pjq.8.1681957453496; Wed, 19 Apr
 2023 19:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230415104104.5537-1-aford173@gmail.com> <20230415104104.5537-5-aford173@gmail.com>
 <807aa6c6-bbea-abcc-172d-17e22d1a3988@denx.de> <CAHCN7x+NUnMtLbj_7A_uqxPsi5NXRXsPFwDnn=sf1bgm-Q-BsQ@mail.gmail.com>
 <88e53197-2819-c068-eba6-a218a19d8d15@denx.de> <CAHCN7xLbbyTaN43pJe3NMdupoGb5vC3yXc_vBn6+CRChWCt92A@mail.gmail.com>
 <ac7ce475-23dd-4d9d-afd1-ad139496a510@denx.de>
In-Reply-To: <ac7ce475-23dd-4d9d-afd1-ad139496a510@denx.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 19 Apr 2023 21:24:02 -0500
Message-ID: <CAHCN7xKZnHGkErwpT-zXR6P-nMxBbg4OVNSr1An2vBaTpOsuqA@mail.gmail.com>
Subject: Re: [PATCH 5/6] drm: bridge: samsung-dsim: Support non-burst mode
To:     Marek Vasut <marex@denx.de>
Cc:     dri-devel@lists.freedesktop.org, m.szyprowski@samsung.com,
        aford@beaconembedded.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>
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

On Mon, Apr 17, 2023 at 6:23=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 4/18/23 00:24, Adam Ford wrote:
> > On Mon, Apr 17, 2023 at 3:08=E2=80=AFPM Marek Vasut <marex@denx.de> wro=
te:
> >>
> >> On 4/17/23 13:57, Adam Ford wrote:
> >>> On Sun, Apr 16, 2023 at 5:13=E2=80=AFPM Marek Vasut <marex@denx.de> w=
rote:
> >>>>
> >>>> On 4/15/23 12:41, Adam Ford wrote:
> >>>>> The high-speed clock is hard-coded to the burst-clock
> >>>>> frequency specified in the device tree.  However, when
> >>>>> using devices like certain bridge chips without burst mode
> >>>>> and varying resolutions and refresh rates, it may be
> >>>>> necessary to set the high-speed clock dynamically based
> >>>>> on the desired pixel clock for the connected device.
> >>>>
> >>>> The link rate negotiation should happen internally between the neare=
st
> >>>> bridge and DSIM, so please add that to DRM core instead of hacking
> >>>> around it by tweaking the HS clock again.
> >>>
> >>> I thought you tried to add something like this before and had some re=
sistance.
> >>
> >> Yes, all my attempts were rejected by a single reviewer. I suspended m=
y
> >> efforts in that area for now.
> >>
> >>> The Pixel clock is set by the bridge already without any new code
> >>> added to the DRM core..  I am just reading that value that's there,
> >>> and setting the clock accordingly.  I don't see how this is a hack.
> >>
> >> Assume you have a DSI-to-HDMI bridge attached to your DSIM bridge, it
> >> operates in non-burst mode, like ADV7533 . How would you configure the
> >
> > I have an ADV7535
> >
> >> HS clock rate for such a bridge in DT ? (hint: you cannot, because the
> >> required clock comes from the EDID, which may not be available just ye=
t)
> >
> > The whole idea is that you wouldn't want to or need to configure the
> > clock speed in the device tree because it comes from the
> > EDID->bridge->DSI.
> >
> > I've tested this configuration on imx8mm, imx8mn, and imx8mp and I can
> > change the resolution and refresh rate on the fly and the DSI will
> > automatically readjust accordingly.   If you fixed the clock in the
> > device tree, you wouldn't be able to do that, and that was the point
> > of this patch.
>
> Uh, I retract my comment, I was clearly confused here and we're talking
> about the same thing.

I'm working on a V2 for this series.  Are you OK with this if I update
the commit message a bit to make it more clear?

adam
