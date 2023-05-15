Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD67702A70
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240196AbjEOKZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjEOKZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:25:39 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7D91B4
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 03:25:38 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-517bdc9e81dso6617670a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 03:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684146338; x=1686738338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SJD8s7/vlpUC+r9xw+PjNSxoRA6UPLfFdFyhR8/9gI=;
        b=KQHaZ6uirginWKjs5TjDpahbCg8auMau95vKtwgMirG1+Nx9CWp3NOpLX8tTx+m0ub
         MkfiOuAivpTEOc4Fg2xgwghITnNL0fEmgZMtTqJNoG6hTgfoSM5zJ+7L/VH3RmPdxiCg
         vfq+Aj+DdAaw1FH4pn6jydaMxBk5pRgcqvx+/MkxbKYbQwAcfXoEEm3wVrN5xt0cKHeo
         yk/RbOgs6gx2zgtHpX0s7ShO+YMaBL8g4zknoaXEjPOSZBHPttoZimmD+YS0bWR+yGOD
         rh1t1Tw+FWrjyZyWGC/K9j68ROiUGDNliednQmA0C3WIxb3prGpBGiwJojFqb15AgmIt
         u4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684146338; x=1686738338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0SJD8s7/vlpUC+r9xw+PjNSxoRA6UPLfFdFyhR8/9gI=;
        b=IcYvqVsyKj+7SPaMhZ+sI9K3hWgYW19PXr9SAFtkqHaWYIeAKibLAyxd7yX9Vm/qyj
         W3ooO6xaL+WlMNiqjOQIusPZn19nkPevqeJ1QuaAJs5hYcY3irSeEWj/682W5Dw+el2v
         SFnmHt3SbSFjWRy5oA3pFXy3NlU1DAO9GnZw0P6Yj9C2JXiaCqwIGuNAbFjjBW1Q2Wgh
         Fy3XzLl8eB3FJ4GXayKuzSLACQNNhuPnvysfO615VM4AHH4xhOAnw/BHxeN79Muw+gIr
         tcV7EGlprZ59+GpTkYhBLCQmghuVOWP+MX+6lBLgioDRMl+R18Wk5q/CyDGh3lGymdbH
         +Meg==
X-Gm-Message-State: AC+VfDwQQYiUhx33kug94hc7DJ0nLoUyk1AeTQf8+QDRJOWr4PR9SZvB
        /eVPgIvjbe3uW7sG+FJ1BTGMWPE4h8KVGQaYPAc=
X-Google-Smtp-Source: ACHHUZ7VZh44ksmzDFTWNKgZ/ZRBATJGXm44xz2asG416oMZTokNGZRbtejpG45L9VAFCD3q+1W5gnYg7STctGGcD8E=
X-Received: by 2002:a17:90a:cf95:b0:24e:4c8:3ae5 with SMTP id
 i21-20020a17090acf9500b0024e04c83ae5mr34750211pju.28.1684146337573; Mon, 15
 May 2023 03:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230506192453.725621-1-aford173@gmail.com> <20230506192453.725621-6-aford173@gmail.com>
 <275064c0e6c814d8e8fda6bcf70d6e8c3bdc3011.camel@pengutronix.de>
 <CGME20230512200115eucas1p180198d430c17b044e34d66b7246d4a7b@eucas1p1.samsung.com>
 <CAHCN7xKq_hZXWZVMG0xFK_zGfm18ag48a83BtL5OyE6VJ3FMTA@mail.gmail.com>
 <7a83b8c1-88ff-0ae6-9c3b-d49fc08c7ac0@samsung.com> <CAHCN7xLZNvMx=U9=Fp=qrG9xaMhU1PS_nQO5FfC2S+XLO8YLXQ@mail.gmail.com>
 <96150852-84ce-f750-2e2e-8cb53cde5719@samsung.com>
In-Reply-To: <96150852-84ce-f750-2e2e-8cb53cde5719@samsung.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 15 May 2023 05:25:26 -0500
Message-ID: <CAHCN7x+thNWWTfyARTdXb_zbdo2Aq-gqjs3kqSXB6nczsoFnRw@mail.gmail.com>
Subject: Re: [PATCH V5 5/6] drm: bridge: samsung-dsim: Dynamically configure
 DPHY timing
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        dri-devel@lists.freedesktop.org, Marek Vasut <marex@denx.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>, aford@beaconembedded.com,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Jagan Teki <jagan@amarulasolutions.com>
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

On Mon, May 15, 2023 at 2:37=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 13.05.2023 06:25, Adam Ford wrote:
> > On Fri, May 12, 2023 at 4:02=E2=80=AFPM Marek Szyprowski
> > <m.szyprowski@samsung.com> wrote:
> >> On 12.05.2023 22:00, Adam Ford wrote:
> >>> On Fri, May 12, 2023 at 2:37=E2=80=AFPM Lucas Stach <l.stach@pengutro=
nix.de> wrote:
> >>>> Am Samstag, dem 06.05.2023 um 14:24 -0500 schrieb Adam Ford:
> >>>>> The DPHY timings are currently hard coded. Since the input
> >>>>> clock can be variable, the phy timings need to be variable
> >>>>> too.  Add an additional variable to the driver data to enable
> >>>>> this feature to prevent breaking boards that don't support it.
> >>>>>
> >>>>> The phy_mipi_dphy_get_default_config function configures the
> >>>>> DPHY timings in pico-seconds, and a small macro converts those
> >>>>> timings into clock cycles based on the pixel clock rate.
> >>>>>
> >>>> This week I finally had some time to take a deeper look at this seri=
es
> >>>> and test it on some of my systems.
> >>> Thanks for testing this!
> >>>> This patch causes issues when the burst clock rate is fixed by
> >>>> supplying the DT entry. Instead of describing the issue below, I'm
> >>>> attaching the patch that makes things work on my system.
> >>> Oops, sorry about that.
> >>>
> >>>> I would appreciate if you could test this one on your side. Feel fre=
e
> >>>> to squash it into yours if you find it working properly.
> >>> I reviewed your patch, and it looks like it makes a lot of sense.
> >>> If it works, I'll squash them together and add your name to the sign-=
off.
> > That worked really well, I'll add it to my WIP directory since Marek S
> > said he'd test the other proposal of dropping the dynamic phy flag and
> > corresponding check in favor of pushing everyone to the same code.
> >
> >>>> Also I would almost bet that dynamic_dphy is working on the Exynos
> >>>> boards with that fix added. So if anyone with access to those boards
> >>>> would like to give it a shot, we may be able to get rid of the
> >>>> hardcoded PHY parameters altogether, which would be a nice cleanup.
> >>> I wondered the same thing, but I didn't want to create more work for
> >>> Marek S and since there was so much churn getting the original driver
> >>> ported, I thought it would be the safest thing to try to give the
> >>> imx8m m/n/p the features without breaking the Exynos.
> >>>
> >>> Marek S - Do you want me to post this file without the extra checks t=
o
> >>> see if it still works with Exynos?
> >> Feel free to send me patches to test or just point to your
> >> work-in-progress git repo.
> > Thanks for testing this, Marek S.  My work-in-progress branch is:
> >
> > https://protect2.fireeye.com/v1/url?k=3D2eeb1ed9-4e098384-2eea9596-000b=
abd9f1ba-9ad5c339e5ea6e4d&q=3D1&e=3D652be603-d622-4d0e-95d3-639656ab1af1&u=
=3Dhttps%3A%2F%2Fgithub.com%2Faford173%2Flinux%2Ftree%2Fdsim-updates-wip
> >
> > Depending on what you find will determine how I modify the next
> > revision of the code I push, so I very much appreciate your feedback.
> > Hopefully the suggestion from Lucas will work for your applications
> > and we can reduce some of the code complexity.
>
> The above mentioned 'dsim-updates-wip' branch works fine on all my
> Exynos based boards.

Thank you for testing.  I'll work on squashing some of the patches
together and eliminating some of the duplicative stuff so the end
result should be the same as what is in WIP and submit another
revision soon.

thanks!

adam
>
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
