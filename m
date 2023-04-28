Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4EE6F1A3F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 16:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346067AbjD1OKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 10:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjD1OKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 10:10:08 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1394232
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 07:09:56 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-52091c58109so9275748a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 07:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682690996; x=1685282996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2b78iqTC7OToTOHQ6fHrEeDrWrCuNdZPNAb0fZD55U=;
        b=ZLkCHgrXybRzPv+DwSbafrfSNV39zdsVZBmrPykFn1NLr65U7rjnAkOXL8Fx2Jwat5
         DB+pVf5II54c4Gh9Zyj0uJ1V6NL14c08jj7TRJMdmg3g97eOvc2rWHBC3HzSTD1nXDBx
         MIRZ82u6JAEJzkuTRreiOBby//730kfRhqsCn6fng4ZLdqI58KGiJPjVn0p+2fiX35Aw
         nGy9W9/ffg1vzPYUW26EiIWFwZ3NdFPxjZHMH0vuj9dnPaoWB1Zz1wSE2Z6o5dBiIHsu
         FMcMoBNiMbUFoTITXmsH0gT/4i9fv4iwjlKSKDekjY45MN6Zo2MBeBvdYqmmNaA0kUWf
         XWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682690996; x=1685282996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2b78iqTC7OToTOHQ6fHrEeDrWrCuNdZPNAb0fZD55U=;
        b=lHtLqCQFFvfuh4tCHSRww8h+rmoyh5dk7QIDT6NyCBKBVqkt0vtzeoL/tEeQMfSDHf
         exnBsY/nyI7oo0DI0BiCmx6Kv6Vu9WhBXzWqtCs7HSpQS8Kad+yaFdX2ty+bcz+YQ26z
         mA4xYWWzJswCSJ/tiPcgsBp011S1DsFkaq6S2OoK7BrNmro7mB7zg8I/RDlEzLPw1NQa
         Iff8S9xJNNR9GYl4bSj3MwmxN9p+HdG9CHqCDmVKDd/9FMDo6QdR1CJ1Fde/YrSYViDJ
         aggTfBlJxRoZJy5JHFeTZ0hiEn+UkqNnjBH6vxD+sSkxgMIcMSO9XSHJ6vxo++CDavb/
         DcWA==
X-Gm-Message-State: AC+VfDwe/FT6Lv8OLzgLlwpc6Rd44wwWJeuf9Mx/wK2tqHpLV6GiZqGj
        9tYDG3abVL4Ue+paXjkHi6AnBkM9imZ+KEiAN3A=
X-Google-Smtp-Source: ACHHUZ5AEt7w1BySwRThXroxDTX4QU1RNchIAB/DIvq3N/HIBZ2/uQDtKAhJKESIEP3SitEDbDdQb5t3yok7tYSQIKw=
X-Received: by 2002:a17:90a:bc8d:b0:246:a782:d94 with SMTP id
 x13-20020a17090abc8d00b00246a7820d94mr5992258pjr.7.1682690995638; Fri, 28 Apr
 2023 07:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230423121232.1345909-1-aford173@gmail.com> <CGME20230423121305eucas1p287a952d41b1884b117fa15a748b9e1a2@eucas1p2.samsung.com>
 <20230423121232.1345909-6-aford173@gmail.com> <b6b53da5-6986-a958-ef84-650b3a57ad9c@samsung.com>
 <CAHCN7x+vd-bP8NgS-cRrnm8ojq0kwUg6aXokJv6xSU7BrT04Vw@mail.gmail.com>
 <343f8d25-566f-9d14-64db-4e796cc9e406@samsung.com> <CAHCN7x+QU29Wv9TQEANhbxLcL4jCZUKbk+uGu2sOwhCcTt798A@mail.gmail.com>
 <46429c9b-cf14-a67e-81a8-b56be0350ea3@samsung.com>
In-Reply-To: <46429c9b-cf14-a67e-81a8-b56be0350ea3@samsung.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 28 Apr 2023 09:09:44 -0500
Message-ID: <CAHCN7xKcHELG3n8+f4pjj05NCFUhBfz0_q_huN9bP65Fv6Ombg@mail.gmail.com>
Subject: Re: [PATCH V2 5/6] drm: bridge: samsung-dsim: Support non-burst mode
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, aford@beaconembedded.com,
        dario.binacchi@amarulasolutions.com, l.stach@pengutronix.de,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
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

On Fri, Apr 28, 2023 at 9:04=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 28.04.2023 15:35, Adam Ford wrote:
> > On Fri, Apr 28, 2023 at 7:31=E2=80=AFAM Marek Szyprowski
> > <m.szyprowski@samsung.com> wrote:
> >> On 24.04.2023 12:00, Adam Ford wrote:
> >>> On Mon, Apr 24, 2023 at 3:25=E2=80=AFAM Marek Szyprowski
> >>> <m.szyprowski@samsung.com> wrote:
> >>>> On 23.04.2023 14:12, Adam Ford wrote:
> >>>>> The high-speed clock is hard-coded to the burst-clock
> >>>>> frequency specified in the device tree.  However, when
> >>>>> using devices like certain bridge chips without burst mode
> >>>>> and varying resolutions and refresh rates, it may be
> >>>>> necessary to set the high-speed clock dynamically based
> >>>>> on the desired pixel clock for the connected device.
> >>>>>
> >>>>> This also removes the need to set a clock speed from
> >>>>> the device tree for non-burst mode operation, since the
> >>>>> pixel clock rate is the rate requested from the attached
> >>>>> device like an HDMI bridge chip.  This should have no
> >>>>> impact for people using burst-mode and setting the burst
> >>>>> clock rate is still required for those users.
> >>>>>
> >>>>> Signed-off-by: Adam Ford <aford173@gmail.com>
> >>>> This one breaks Exynos-5433 based TM2e board with a DSI panel.
> >>> Marek S,
> >>>
> >>> Thank you for testing!  I knoiw there are several of us who appreciat=
e
> >>> your testing this since it's hard to know if something broke without
> >>> hardware.  Is there any way you can tell me if the flag is set to
> >>> enable MIPI_DSI_MODE_VIDEO_BURST?
> >> TM2e board uses the DSI panel operated in command mode and handled by
> >> panel-samsung-s6e3ha2.c driver. The MIPI_DSI_MODE_VIDEO_BURST flag is
> >> not set by the driver. However, the MIPI_DSI_CLOCK_NON_CONTINUOUS flag=
s
> >> is set there. I really have no idea if setting VIDEO_BURST would make
> >> sense together with CLOCK_NON_CONTINUOUS or not. Maybe the driver lack=
s
> >> setting it?
> >>
> >>
> >>> I was trying to be diligent about not breaking your boards, but
> >>> without your boards, it's difficult.  The theory was that if
> >>> MIPI_DSI_MODE_VIDEO_BURST is set and there is a burst clock set in th=
e
> >>> device tree, it would use the burst clock.
> >>>
> >>> As a fall-back I could just simply check for the presence of the
> >>> burst_clock_rate instead of both MIPI_DSI_MODE_VIDEO_BURST and
> >>> burst_clock_rate.
> >> Maybe you should extend your check also for the
> >> MIPI_DSI_CLOCK_NON_CONTINUOUS flag? Does it make sense?
> > Looking at some of the devices that might attach in the future, It
> > appears that ti-sn65dsi86.c sets this flag.  It's a display port
> > bridge, so I would expect it to need a variable clock rate similar to
> > how the HDMI bridge that I need works.  I am concerned that I make the
> > burst clock dependent on MIPI_DSI_CLOCK_NON_CONTINUOUS, it might break
> > the Display Port bridge.
> >
> > I think it's better to just check if the samsung,burst-clock-frequency
> > is present in the device tree and use it when present.  If it's not
> > present, then fall back to the pixel clock of the connected device.
>
> Right, this sounds rational.
>
> > I looked at a bunch of Exynos parts, and it looks like they all use
> > the samsung,burst-clock-frequency device tree setting.  Is that true,
> > or did I miss one?
>
> That true. All Exynos based boards with DSI panels use constant DSI
> burst frequency defined in the device tree.

Thanks for the feedback.  I'll try to get another rev of this series
pushed later today or Monday.

adam
>
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
