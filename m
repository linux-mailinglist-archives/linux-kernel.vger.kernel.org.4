Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CFE74B56D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 18:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjGGQyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 12:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjGGQx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:53:59 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AA32D42
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 09:53:32 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-262ff3a4659so1609589a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 09:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688748808; x=1691340808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ganOcRrGX9gVkXMthOtdXTKyr3DXfFEecMxDKDYPHpQ=;
        b=J8Wr9p6qLani+dIxIJoalPJzoHhWv6PxfhP1BbAYAxKziU/IrMQWCVvaFDv92GEGaq
         pSkaoPtc3SY90nN8qv+dNCn6Zcj7KfohQoKKSW6JAUn31F9tG8GEfOXIW3U3uNBVbuDV
         WVZ8i/WlYex/Yz5F5I9fozzKO7sd36Iogex03SkJw/wWV+025xFGK9y6V5+6Bv+eIAbj
         t/0k7pSgVZX9SOYj0+EL6Ht8pMAKb6vWIim6Exw3tiZgfLv36fE3OS7FRKmw1Scm+MQd
         VP2BW6t0hWSSjjwrGrW4aK4PFcrH5SN0o2+9PsPCpbigXe4Pj3BPbUVb7MWCmNmdU0CQ
         WiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688748808; x=1691340808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ganOcRrGX9gVkXMthOtdXTKyr3DXfFEecMxDKDYPHpQ=;
        b=Ce1Sf1Q9O56z/ia420bXXDxn5oCm06c4sGpVdc5aN/XzrRgriGvYDejd3KZtWwPYse
         I7tPF+L8DZOzztDJBlbyKks/E50hTrJ3dZJ4IhUEKQV+uNHLG7yvS3MmfhJzO89u9CSE
         74/9f6vcx8vhfnpbyYwH9fkiCqQgwU1MHWhXFwDfoZDEZ8bheWfOaUEMMi34062uNq58
         n/wmnro/gnZAd/oXM49MNWKwpj/DM/zvoPOgqyPs0mOLfdD2HGrT2mX6gVv0AfNGeDd7
         WhyldAJIUwfhR8Z6VSSVE6BDvdIrwy00qN6cZuy84nIqP+/tDsgl2eu3vzqcrWnwHWIh
         Xs4Q==
X-Gm-Message-State: ABy/qLY4oYtkKoZOMheFYXyYWxUJpt+4mcUPPObPOSps3rbg2HNcvwOa
        6RPv/bYSqVzjGoVGs7xnzC8WgO6opIwsJr4D850=
X-Google-Smtp-Source: APBJJlGum+21E74xOHmurd3BznTUzbDzbh02qxja4NdlWrkKY0qPGktO+vX87VjpJ0ZpPOz2kKqw5zlIBr+4nwsHTJE=
X-Received: by 2002:a17:90a:d484:b0:256:2efc:270e with SMTP id
 s4-20020a17090ad48400b002562efc270emr4702991pju.5.1688748807659; Fri, 07 Jul
 2023 09:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230319125524.58803-1-aford173@gmail.com> <CAMSo37Whxvp82i9hr-L-O4Qo9Pxkh5L+hFXqw9hNQ+asrD6oyA@mail.gmail.com>
In-Reply-To: <CAMSo37Whxvp82i9hr-L-O4Qo9Pxkh5L+hFXqw9hNQ+asrD6oyA@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 7 Jul 2023 11:53:15 -0500
Message-ID: <CAHCN7xK+AQmzwc+_o7Y=vNX7CKamQMrfGnrmZ4TsHR8ifSprcw@mail.gmail.com>
Subject: Re: [PATCH V2] drm/bridge: adv7533: Fix adv7533_mode_valid for
 adv7533 and adv7535
To:     Yongqin Liu <yongqin.liu@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, dmitry.baryshkov@linaro.org,
        aford@beaconembedded.com, Robert Foss <rfoss@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-kernel@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 4, 2023 at 11:05=E2=80=AFAM Yongqin Liu <yongqin.liu@linaro.org=
> wrote:
>
> Hi, Adam, All
>
> On Sun, 19 Mar 2023 at 20:55, Adam Ford <aford173@gmail.com> wrote:
> >
> > When dynamically switching lanes was removed, the intent of the code
> > was to check to make sure that higher speed items used 4 lanes, but
> > it had the unintended consequence of removing the slower speeds for
> > 4-lane users.
> >
> > This attempts to remedy this by doing a check to see that the
> > max frequency doesn't exceed the chip limit, and a second
> > check to make sure that the max bit-rate doesn't exceed the
> > number of lanes * max bit rate / lane.
> >
> > Fixes: 9a0cdcd6649b ("drm/bridge: adv7533: remove dynamic lane switchin=
g from adv7533 bridge")
> > Reviewed-by: Robert Foss <rfoss@kernel.org>
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> >
> > V2:  Fix whitespace in comment
> >      Remove TODO comment
> >      Add R-B from Robert.
>
> With this change, the ACK android-mainline based hikey960 build failed
> to show UI on the HDMI
> monitor connected, but it works if I revert this change.
> Here is the serial console output: http://ix.io/4zK8
>
> Not sure if you have any idea what the problem is there,
> and how to have it fixed.
>
> Please let me know if you need any other information.

I'd be curious to know the desired clock rate and the number of lanes
you're trying to use.

adam
>
> Thanks,
> Yongqin Liu
>
> > diff --git a/drivers/gpu/drm/bridge/adv7511/adv7533.c b/drivers/gpu/drm=
/bridge/adv7511/adv7533.c
> > index fdfeadcefe80..7e3e56441aed 100644
> > --- a/drivers/gpu/drm/bridge/adv7511/adv7533.c
> > +++ b/drivers/gpu/drm/bridge/adv7511/adv7533.c
> > @@ -103,22 +103,19 @@ void adv7533_dsi_power_off(struct adv7511 *adv)
> >  enum drm_mode_status adv7533_mode_valid(struct adv7511 *adv,
> >                                         const struct drm_display_mode *=
mode)
> >  {
> > -       int lanes;
> > +       unsigned long max_lane_freq;
> >         struct mipi_dsi_device *dsi =3D adv->dsi;
> > +       u8 bpp =3D mipi_dsi_pixel_format_to_bpp(dsi->format);
> >
> > -       if (mode->clock > 80000)
> > -               lanes =3D 4;
> > -       else
> > -               lanes =3D 3;
> > -
> > -       /*
> > -        * TODO: add support for dynamic switching of lanes
> > -        * by using the bridge pre_enable() op . Till then filter
> > -        * out the modes which shall need different number of lanes
> > -        * than what was configured in the device tree.
> > -        */
> > -       if (lanes !=3D dsi->lanes)
> > -               return MODE_BAD;
> > +       /* Check max clock for either 7533 or 7535 */
> > +       if (mode->clock > (adv->type =3D=3D ADV7533 ? 80000 : 148500))
> > +               return MODE_CLOCK_HIGH;
> > +
> > +       /* Check max clock for each lane */
> > +       max_lane_freq =3D (adv->type =3D=3D ADV7533 ? 800000 : 891000);
> > +
> > +       if (mode->clock * bpp > max_lane_freq * adv->num_dsi_lanes)
> > +               return MODE_CLOCK_HIGH;
> >
> >         return MODE_OK;
> >  }
> > --
> > 2.34.1
> >
>
>
> --
> Best Regards,
> Yongqin Liu
> ---------------------------------------------------------------
> #mailing list
> linaro-android@lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-android
