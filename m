Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985EE74CF6C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjGJIGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjGJIF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:05:58 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFAD195
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 01:05:55 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-579e212668fso60715277b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 01:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688976355; x=1691568355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QA/OQiX/pzJCCl8hjUqWSyMfpeWVEaj4HEKssATZWgM=;
        b=RZU+51thCwJE7K/xTfv65nD+a+HixYp05Wa6SBlO2OPNmy5m37MA39idOCBf48iw4I
         JAUO3x4LUqFv5n9ZrELLbiRS/BO1nAGtwpdrXb8nNN8cnDlJ8LzjAQtWkEXmxTcomt/b
         6SKNDx9Qnh0AyCoMIGQBFqko7Wj7IF9txSuTbmmzEpWua6Gd2wGn7hBgEqSgPDGJTBHx
         rX0RleQMfXN1sw6RfY3oojqQIbFW8p9AqKQHEIMY1DqZDGQmZgWBqNdXw08LUdm4UA/H
         NFFls4u9z7XvDbgPxkpjt/TGONun/oCEiAsv7cRZlG36Lvqp1p0iOWBwyDqUuyNHI4TI
         frYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688976355; x=1691568355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QA/OQiX/pzJCCl8hjUqWSyMfpeWVEaj4HEKssATZWgM=;
        b=lOGvz1G3gAs/5s1UTwm0JvR008DltAetJPT5SAVdVUZHH9eB3SmKGf4trDzYet/Lq5
         5JmPX/M24uJ9Iq1KVVVs3im28pn1b42jCGO1WSWFILukB6lbwArB282ZChjnyYCy3sfQ
         VWuRvSwGMWTJssYGAjzgPYJ5uU5fEMZfN145kiGzLe/Kq8WT0W8aXxPMJGUEgwyIdxgr
         kH7jzP3IVqHmc4DRV2HNl+KbODmC7ZlhmFScp2NnbLXX1hDt1XmIPHze58jt+kYKJ2rK
         2zdFSHF/hGwkD13+Yl+HL+uPGtlsVU8OixpQ6SyR32cEyGRdG5Htdq7lpXRFxMMMgr5Q
         AeLQ==
X-Gm-Message-State: ABy/qLZ2qk6o3vtwrp+P0yBL7NYNIinb8xmoLeDyc81JvUBwGWvGizMP
        wHKYhfPbUc6fw4SOGrVtXNEQ/S4E4ZUuXUm1zL7UQA==
X-Google-Smtp-Source: APBJJlEG5pnp9LkEiUqc/pFjf/LIV6zWlaq1ryHZ9f6Y/+cJDOgcs/p+rabjpQDm2Qv7iTSeTv8n58VhcfRI1V4/2bc=
X-Received: by 2002:a0d:d48e:0:b0:56d:2d82:63de with SMTP id
 w136-20020a0dd48e000000b0056d2d8263demr11415234ywd.3.1688976354895; Mon, 10
 Jul 2023 01:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686729444.git.Sandor.yu@nxp.com> <cec469206a166c4b070fd7d7bbf89a8df656ccc6.1686729444.git.Sandor.yu@nxp.com>
 <6f590bb6-7d17-3ae8-684d-2d4403d6ff55@linaro.org> <PAXPR04MB9448598256524162A74F0311F430A@PAXPR04MB9448.eurprd04.prod.outlook.com>
 <8966feba-eef9-2ea3-dbec-13fc53232a6b@linaro.org> <PAXPR04MB9448480F2A0E0542942A661AF430A@PAXPR04MB9448.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB9448480F2A0E0542942A661AF430A@PAXPR04MB9448.eurprd04.prod.outlook.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 10 Jul 2023 11:05:43 +0300
Message-ID: <CAA8EJppbbeZB-pdPdg+gft+kS8Pzsxvqd9v6DsRNwTkL71XSJQ@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v6 4/8] phy: Add HDMI configuration options
To:     Sandor Yu <sandor.yu@nxp.com>
Cc:     "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "robert.foss@linaro.org" <robert.foss@linaro.org>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "jonas@kwiboo.se" <jonas@kwiboo.se>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Oliver Brown <oliver.brown@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 at 11:01, Sandor Yu <sandor.yu@nxp.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Sent: 2023=E5=B9=B47=E6=9C=8810=E6=97=A5 15:44
> > To: Sandor Yu <sandor.yu@nxp.com>; andrzej.hajda@intel.com;
> > neil.armstrong@linaro.org; robert.foss@linaro.org;
> > Laurent.pinchart@ideasonboard.com; jonas@kwiboo.se;
> > jernej.skrabec@gmail.com; airlied@gmail.com; daniel@ffwll.ch;
> > robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > shawnguo@kernel.org; s.hauer@pengutronix.de; festevam@gmail.com;
> > vkoul@kernel.org; dri-devel@lists.freedesktop.org;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; linux-phy@lists.infradead.org
> > Cc: kernel@pengutronix.de; dl-linux-imx <linux-imx@nxp.com>; Oliver Bro=
wn
> > <oliver.brown@nxp.com>
> > Subject: Re: [EXT] Re: [PATCH v6 4/8] phy: Add HDMI configuration optio=
ns
> >
> >
> > On 10/07/2023 10:28, Sandor Yu wrote:
> > > Hi Dmitry,
> > >
> > > Thanks for your comments,
> > >
> > >> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> On 15/06/2023
> > >> 04:38, Sandor Yu wrote:
> > >>> Allow HDMI PHYs to be configured through the generic functions
> > >>> through a custom structure added to the generic union.
> > >>>
> > >>> The parameters added here are based on HDMI PHY implementation
> > >>> practices.  The current set of parameters should cover the potentia=
l
> > >>> users.
> > >>>
> > >>> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> > >>> ---
> > >>>    include/linux/phy/phy-hdmi.h | 38
> > >> ++++++++++++++++++++++++++++++++++++
> > >>>    include/linux/phy/phy.h      |  7 ++++++-
> > >>>    2 files changed, 44 insertions(+), 1 deletion(-)
> > >>>    create mode 100644 include/linux/phy/phy-hdmi.h
> > >>>
> > >>> diff --git a/include/linux/phy/phy-hdmi.h
> > >>> b/include/linux/phy/phy-hdmi.h new file mode 100644 index
> > >>> 000000000000..5765aa5bc175
> > >>> --- /dev/null
> > >>> +++ b/include/linux/phy/phy-hdmi.h
> > >>> @@ -0,0 +1,38 @@
> > >>> +/* SPDX-License-Identifier: GPL-2.0 */
> > >>> +/*
> > >>> + * Copyright 2022 NXP
> > >>> + */
> > >>> +
> > >>> +#ifndef __PHY_HDMI_H_
> > >>> +#define __PHY_HDMI_H_
> > >>> +
> > >>> +/**
> > >>> + * Pixel Encoding as HDMI Specification
> > >>> + * RGB, YUV422, YUV444:HDMI Specification 1.4a Section 6.5
> > >>> + * YUV420: HDMI Specification 2.a Section 7.1  */ enum
> > >>> +hdmi_phy_colorspace {
> > >>> +     HDMI_PHY_COLORSPACE_RGB,        /* RGB 4:4:4 */
> > >>> +     HDMI_PHY_COLORSPACE_YUV422,     /* YCbCr 4:2:2 */
> > >>> +     HDMI_PHY_COLORSPACE_YUV444,     /* YCbCr 4:4:4 */
> > >>> +     HDMI_PHY_COLORSPACE_YUV420,     /* YCbCr 4:2:0 */
> > >>> +     HDMI_PHY_COLORSPACE_RESERVED4,
> > >>> +     HDMI_PHY_COLORSPACE_RESERVED5,
> > >>> +     HDMI_PHY_COLORSPACE_RESERVED6, };
> > >>
> > >> This enum duplicates enum hdmi_colorspace from <linux/hdmi.h> HDMI
> > >> 2.0 defines '7' to be IDO-defined.
> > >>
> > >> Would it be better to use that enum instead?
> > > Accept. I will create head file hdmi_colorspace.h to reuse enum
> > hdmi_colorspace in <linux/hdmi.h>.
> >
> > Excuse me, it was supposed to be a question.
> >
> > Do you need another header file to reuse this enum?
> I'm not sure community whether would accept the patch that simply include=
 <linux/hdmi.h> in phy-hdmi.h
> because there are lots of other definition in <linux/hdmi.h> that not nee=
d by phy-hdmi.h.
> If the answer is yes, I happy to follow.

In my opinion it's a better alternative to creating yet another header.

>
> >
> > >
> > > B.R
> > > Sandor
> > >>
> > >>> +
> > >>> +/**
> > >>> + * struct phy_configure_opts_hdmi - HDMI configuration set
> > >>> + * @pixel_clk_rate:  Pixel clock of video modes in KHz.
> > >>> + * @bpc: Maximum bits per color channel.
> > >>> + * @color_space: Colorspace in enum hdmi_phy_colorspace.
> > >>> + *
> > >>> + * This structure is used to represent the configuration state of =
a HDMI
> > phy.
> > >>> + */
> > >>> +struct phy_configure_opts_hdmi {
> > >>> +     unsigned int pixel_clk_rate;
> > >>> +     unsigned int bpc;
> > >>> +     enum hdmi_phy_colorspace color_space; };
> > >>> +
> > >>> +#endif /* __PHY_HDMI_H_ */
> > >>
> > >> [skipped the rest]
> > >>
> > >> --
> > >> With best wishes
> > >> Dmitry
> > >
> >
> > --
> > With best wishes
> > Dmitry
>
> B.R
> Sandor
>


--=20
With best wishes
Dmitry
