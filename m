Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC526ECC3F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 14:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjDXMtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 08:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjDXMtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 08:49:03 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D5A44AE
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 05:48:57 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1a67bcde3a7so49041435ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 05:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682340537; x=1684932537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRtJI0qVSZgwFwkseB3cLSDrpXy66ayacVGu/Wcx/aQ=;
        b=BxtPBqv8KtKgkQDc0XgzWV2QxL2z6CZY6BmlfXQnG6rirWvnh14gxm+oh0CqZnq7EO
         5vjFCREuPJTfhQAlIovG5XPGf5A7JYiire0wr+u3wiXn/9d7+rrOmmnDuC7cw9VFnkN3
         zKqbc7PcRrxB4g/7Y//99ziAryrCseZrvDxXizfPRxXPZ6vUJ5Y82Dm2FwgK0jyydFEY
         K87a6BV5/hEIrOy2D60dQlyHl2ZCV98OhiXjJu4iKXvgg/vsbqBVFlA8LA4iY6Gj7cp4
         e83aOtpIWzAwYBV5w0th+Dsae2D4u4jntpPCNxvf2MSLIudzJg3NGj1Oz3nUAsb9SJw5
         3Wdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682340537; x=1684932537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tRtJI0qVSZgwFwkseB3cLSDrpXy66ayacVGu/Wcx/aQ=;
        b=imyJ0XOLMD+dcT77dabxw3TyLJaJWc4xMYUAb6rnqn0mTMkXv4fS1zwhuAFRNd9+cN
         VvMRIBDsXdkNx6OqO97pqFyG1J2jAHFCF73E+ygzRkgIZBdMqn3SnKC1xICIgz3uh9Fa
         jPnOnACwYl7PpExjEFetNRADAJO4ai9xZxr7p4oF80y+ZoxR71ub4Hzb0l3Py1ydWmEb
         TSGwZoWqbuiduvcCefmaWYGFDBtRDcSC4p/ecZAe36S0g3oE8+ApciTnH+DSwDBmg6E7
         Mz/ZRNoXRa2ZWuitxBPCYEx+ayJdBzgTlVsmADvHvBQpdQ4em+aioHfShm8ZWnIEMQi3
         NgBg==
X-Gm-Message-State: AC+VfDzdgmelvL+NynvPXsOlaQF/lld67HhkCvLogftfeWcaEUBy5WP6
        t3KYfmDF2k3U7hgq15OILHDZgIzRxMmc6LlAq17/IzhBrSI=
X-Google-Smtp-Source: ACHHUZ5ImOZ6a6KGIzUNbdDYZPMI4yRw7+MQOytkQQ/T/JP/sfPKX39tCOidkGf+Olr1FhHVF/s71XxSFfXP7v/6PWM=
X-Received: by 2002:a17:902:d4cb:b0:1a9:7eea:2626 with SMTP id
 o11-20020a170902d4cb00b001a97eea2626mr1872357plg.10.1682340536481; Mon, 24
 Apr 2023 05:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230423121232.1345909-1-aford173@gmail.com> <20230423121232.1345909-5-aford173@gmail.com>
 <CAGXv+5GHcigEahCp+UefxR+AboF7i-kYJjiNftz8fPDLAZVMow@mail.gmail.com>
 <CAHCN7x+i41UkpdqLbK8s+OJmS=ExsctZwZL0YAQAic=N6kCbAw@mail.gmail.com>
 <CGME20230424094440eucas1p1ca3d678493aef1d6a893abdfcaf01584@eucas1p1.samsung.com>
 <CAGXv+5H34ojUAPWWpF+-=XpdF6Jj_Q7nqiPg3TEKVNXu4F6JAQ@mail.gmail.com>
 <ceee0290-211b-a675-2ba5-9342ee27fc49@samsung.com> <CAHCN7x+koEFVoTOvY16DXYmSE_7+GrYkAk5mnZ02MX9gRmD=DQ@mail.gmail.com>
In-Reply-To: <CAHCN7x+koEFVoTOvY16DXYmSE_7+GrYkAk5mnZ02MX9gRmD=DQ@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 24 Apr 2023 07:48:45 -0500
Message-ID: <CAHCN7xL5Y7i=QtPcMg_CWnDATBxj_JRSa8dHNGGZC0meiS-jMA@mail.gmail.com>
Subject: Re: [PATCH V2 4/6] drm: bridge: samsung-dsim: Dynamically configure
 DPHY timing
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, dri-devel@lists.freedesktop.org,
        Marek Vasut <marex@denx.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        aford@beaconembedded.com,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        dario.binacchi@amarulasolutions.com
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

On Mon, Apr 24, 2023 at 4:50=E2=80=AFAM Adam Ford <aford173@gmail.com> wrot=
e:
>
> On Mon, Apr 24, 2023 at 4:47=E2=80=AFAM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> >
> > On 24.04.2023 11:44, Chen-Yu Tsai wrote:
> > > On Mon, Apr 24, 2023 at 5:31=E2=80=AFPM Adam Ford <aford173@gmail.com=
> wrote:
> > >> On Mon, Apr 24, 2023 at 1:12=E2=80=AFAM Chen-Yu Tsai <wenst@chromium=
.org> wrote:
> > >>> On Sun, Apr 23, 2023 at 8:13=E2=80=AFPM Adam Ford <aford173@gmail.c=
om> wrote:
> > >>>> The DPHY timings are currently hard coded. Since the input
> > >>>> clock can be variable, the phy timings need to be variable
> > >>>> too.  Add an additional variable to the driver data to enable
> > >>>> this feature to prevent breaking boards that don't support it.
> > >>>>
> > >>>> The phy_mipi_dphy_get_default_config function configures the
> > >>>> DPHY timings in pico-seconds, and a small macro converts those
> > >>>> timings into clock cycles based on the pixel clock rate.
> > >>>>
> > >>>> Signed-off-by: Adam Ford <aford173@gmail.com>
> > >>>> ---
> > >>>>   drivers/gpu/drm/bridge/samsung-dsim.c | 79 +++++++++++++++++++++=
++----
> > >>>>   include/drm/bridge/samsung-dsim.h     |  1 +
> > >>>>   2 files changed, 70 insertions(+), 10 deletions(-)
> > >>>>
> > >>>> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/d=
rm/bridge/samsung-dsim.c
> > >>>> index 5b6e7825b92f..f165483d5044 100644
> > >>>> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> > >>>> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> > >>>> @@ -18,9 +18,7 @@
> > >>>>   #include <linux/media-bus-format.h>
> > >>>>   #include <linux/of_device.h>
> > >>>>   #include <linux/phy/phy.h>
> > >>>> -
> > >>>>   #include <video/mipi_display.h>
> > >>>> -
> > >>>>   #include <drm/bridge/samsung-dsim.h>
> > >>>>   #include <drm/drm_panel.h>
> > >>>>   #include <drm/drm_print.h>
> > >>>> @@ -218,6 +216,8 @@
> > >>>>
> > >>>>   #define OLD_SCLK_MIPI_CLK_NAME         "pll_clk"
> > >>>>
> > >>>> +#define PS_TO_CYCLE(PS, MHz) DIV64_U64_ROUND_CLOSEST(((PS) * (MHz=
)), 1000000000000ULL)
> > >>>> +
> > >>>>   static const char *const clk_names[5] =3D {
> > >>>>          "bus_clk",
> > >>>>          "sclk_mipi",
> > >>>> @@ -487,6 +487,7 @@ static const struct samsung_dsim_driver_data i=
mx8mm_dsi_driver_data =3D {
> > >>>>          .m_min =3D 64,
> > >>>>          .m_max =3D 1023,
> > >>>>          .vco_min =3D 1050,
> > >>>> +       .dynamic_dphy =3D 1,
> > >>>>   };
> > >>>>
> > >>>>   static const struct samsung_dsim_driver_data *
> > >>>> @@ -698,13 +699,50 @@ static void samsung_dsim_set_phy_ctrl(struct=
 samsung_dsim *dsi)
> > >>>>          const struct samsung_dsim_driver_data *driver_data =3D ds=
i->driver_data;
> > >>>>          const unsigned int *reg_values =3D driver_data->reg_value=
s;
> > >>>>          u32 reg;
> > >>>> +       struct drm_display_mode *m =3D &dsi->mode;
> > >>>> +       int bpp =3D mipi_dsi_pixel_format_to_bpp(dsi->format);
> > >>>> +       struct phy_configure_opts_mipi_dphy cfg;
> > >>>> +       int clk_prepare, lpx, clk_zero, clk_post, clk_trail;
> > >>>> +       int hs_exit, hs_prepare, hs_zero, hs_trail;
> > >>>> +       unsigned long long clock_in_hz =3D m->clock * 1000;
> > >>>>
> > >>>>          if (driver_data->has_freqband)
> > >>>>                  return;
> > >>>>
> > >>>> +       /* The dynamic_phy has the ability to adjust PHY Timing se=
ttings */
> > >>>> +       if (driver_data->dynamic_dphy) {
> > >>>> +               phy_mipi_dphy_get_default_config(clock_in_hz, bpp,=
 dsi->lanes, &cfg);
> > >>> This requires adding "select GENERIC_PHY_MIPI_DPHY" to DRM_SAMSUNG_=
DSIM,
> > >>> otherwise with CONFIG_DRM_SAMSUNG_DSIM=3Dm:
> > >>>
> > >>> ERROR: modpost: "phy_mipi_dphy_get_default_config"
> > >>> [drivers/gpu/drm/bridge/samsung-dsim.ko] undefined!
> > >>> make[5]: *** [scripts/Makefile.modpost:136: Module.symvers] Error 1
> > >>> make[4]: *** [Makefile:1978: modpost] Error 2
> > >>> make[3]: *** [Makefile:357: __build_one_by_one] Error 2
> > >>>
> > >>> I'm sure there'll be a similar error if CONFIG_DRM_SAMSUNG_DSIM=3Dy=
.
> > >> That's interesting, I didn't come across that.
> > >> What did you use for a starting point when you applied the patches?
> > >> I want to see if I can replicate it.
> > > next-20230421. My config is pretty much tailored to the Hummingbird P=
ulse.
> > > Device drivers for other hardware or things that I can't enable are a=
ll
> > > disabled. For example I don't have PHY_MIXEL_MIPI_DPHY enabled.
> > >
> > > Maybe you have some other bridge or phy that selects it enabled?
> >
> >
> > I've observed similar issue while building exynos_defconfig for arm 32b=
it.
>
> Thanks to both of you for the head's up.  I'll add a patch to update
> Kconfig to explicitly select that when I do V3.  I was just using the
> base arm64 'defconfig' option without any customization.

Marek S & Chen-Yu,

I added a patch into the series to make this select
GENERIC_PHY_MIPI_DPHY, and I tested it with the 32-bit arm config,
exynos_defconfig and it now builds successfully.

I'm going to wait a few more hours to see if anyone else has any
feedback before I send V3.

adam



>
> adam
> >
> >
> > Best regards
> > --
> > Marek Szyprowski, PhD
> > Samsung R&D Institute Poland
> >
