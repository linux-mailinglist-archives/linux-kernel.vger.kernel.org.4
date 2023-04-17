Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0BF6E54AD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 00:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjDQWYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 18:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjDQWYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 18:24:46 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCCE422F;
        Mon, 17 Apr 2023 15:24:45 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-517bd9b1589so1695801a12.1;
        Mon, 17 Apr 2023 15:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681770284; x=1684362284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rwGvdlgofaq/OnMesfSQWB2dx8nX+b4YsY9vlTE0GY=;
        b=aYLxs4270fY8KaUuTyY4q+hyjrtluEj+7zROEfIPr7TlKhMnU8Xt06VC3Nz24Z93rT
         YlOQ0PDYKpIBPZd8+LnKB7N5e9XcZrHsBE9m2QEYFKEfJjuuhm0r39ZGPdox/Lf88bms
         CmrWVWKon7oX8VrThBQFczUmrqwqIiPDfjj6mtHHUocp5jEvRPJvsrraygatrfQmkPVK
         Rd4PqZZCKgVdto5bDDqe97JgbEmiJT0uOtkBSccACJvmspEHLKcfgWpOsyQe/JWwg0GZ
         kzTGUUI6cJnzYLvXQkusEyB6XOl62Kb5bmDFeHYMCNfzXSRpCNpa1FxEYYyV4Zi8dj5B
         z0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681770284; x=1684362284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rwGvdlgofaq/OnMesfSQWB2dx8nX+b4YsY9vlTE0GY=;
        b=k/FSSgcbXAmTpAfNwNvgurRwj6m9wyPSp5DouAwvBnJ+DqeK4ZW4Ey30WNjfCxKxj8
         zjJ7AX+zfqDyAjQK6FC3KCFMkU12gEJmfu7pxubHrbXr8LipmUj6ShU5KN/7xpXQuPCL
         FQJev+ALJ+qRKxNHNhdbDLB+OSXbhSY6tYzvpiwGRtipHuJDmzuQx4MVOOP6QJkfZjd1
         8W28DSSxw1KxLwqBrO9IK4SJ9bA9i+01Gan15WIBN/VaPGwe1SKHPgoJb+5QRf6QtYss
         uSSaJbMSr8yfn8nRe6/DhLf5GDK4d81QTBJQt7MgpAK7tC4+H+0CqSC/QxkTe5wiml2P
         LjUg==
X-Gm-Message-State: AAQBX9dW2uKLtVohxsXB1t2Sr/H4Ima0m4RanOKmV/j56FGkKp74JLp+
        PqTpkJmRHO6QleVtKDU/oP3YKcClRoMgPPdn3Wk=
X-Google-Smtp-Source: AKy350ZAhVd3Lfj2zKF3GaKXZM7iufK+bBwmHjWGjJPf35olU0n+dshsZL36NZteW0f9jL1yboC6CI+f8btMah2HDF4=
X-Received: by 2002:a63:df09:0:b0:51b:415a:6db5 with SMTP id
 u9-20020a63df09000000b0051b415a6db5mr19362pgg.7.1681770284420; Mon, 17 Apr
 2023 15:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230415104104.5537-1-aford173@gmail.com> <20230415104104.5537-5-aford173@gmail.com>
 <807aa6c6-bbea-abcc-172d-17e22d1a3988@denx.de> <CAHCN7x+NUnMtLbj_7A_uqxPsi5NXRXsPFwDnn=sf1bgm-Q-BsQ@mail.gmail.com>
 <88e53197-2819-c068-eba6-a218a19d8d15@denx.de>
In-Reply-To: <88e53197-2819-c068-eba6-a218a19d8d15@denx.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 17 Apr 2023 17:24:31 -0500
Message-ID: <CAHCN7xLbbyTaN43pJe3NMdupoGb5vC3yXc_vBn6+CRChWCt92A@mail.gmail.com>
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

On Mon, Apr 17, 2023 at 3:08=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 4/17/23 13:57, Adam Ford wrote:
> > On Sun, Apr 16, 2023 at 5:13=E2=80=AFPM Marek Vasut <marex@denx.de> wro=
te:
> >>
> >> On 4/15/23 12:41, Adam Ford wrote:
> >>> The high-speed clock is hard-coded to the burst-clock
> >>> frequency specified in the device tree.  However, when
> >>> using devices like certain bridge chips without burst mode
> >>> and varying resolutions and refresh rates, it may be
> >>> necessary to set the high-speed clock dynamically based
> >>> on the desired pixel clock for the connected device.
> >>
> >> The link rate negotiation should happen internally between the nearest
> >> bridge and DSIM, so please add that to DRM core instead of hacking
> >> around it by tweaking the HS clock again.
> >
> > I thought you tried to add something like this before and had some resi=
stance.
>
> Yes, all my attempts were rejected by a single reviewer. I suspended my
> efforts in that area for now.
>
> > The Pixel clock is set by the bridge already without any new code
> > added to the DRM core..  I am just reading that value that's there,
> > and setting the clock accordingly.  I don't see how this is a hack.
>
> Assume you have a DSI-to-HDMI bridge attached to your DSIM bridge, it
> operates in non-burst mode, like ADV7533 . How would you configure the

I have an ADV7535

> HS clock rate for such a bridge in DT ? (hint: you cannot, because the
> required clock comes from the EDID, which may not be available just yet)

The whole idea is that you wouldn't want to or need to configure the
clock speed in the device tree because it comes from the
EDID->bridge->DSI.

I've tested this configuration on imx8mm, imx8mn, and imx8mp and I can
change the resolution and refresh rate on the fly and the DSI will
automatically readjust accordingly.   If you fixed the clock in the
device tree, you wouldn't be able to do that, and that was the point
of this patch.


adam
