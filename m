Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7334F6342B4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 18:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbiKVRne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 12:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbiKVRnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 12:43:16 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB29B7F0;
        Tue, 22 Nov 2022 09:43:14 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ft34so37392515ejc.12;
        Tue, 22 Nov 2022 09:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pFa0z79Q9W1Hn5t/jpt+vR2pGJFK6uYr5SfQsMsXQ5s=;
        b=LjZPpS4gOsdi1lfll2ueJysZHGU9LnmgUxc0OL/z6m/g7XzeCFPLWZMIRWDBuLSOwe
         tw6Dgs4vMot98C8Jj3z2yU7AUNtiVq5fgi7BZf+mYtf1vXx1VG2pvXEWR4HfDK4MORZq
         P4K0HoTaQbPC3q3fZ2zCBepIkGL2x8HGGcY7EgWLVfri00WElwTiog4TPFbJzwWAGoCe
         HZhtIFL4VsdRjZTKsewT0ZhQqBE7AFFNcKSlVsmmE7rSnVBkHv9ai0IC4zWfbheC2u8m
         MPNg0iWguTASAakGDyekI9V+KK5teyHVx6FlD0ZeeKRSQtIQgSIjWPhDKVNqZuhusdej
         afqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pFa0z79Q9W1Hn5t/jpt+vR2pGJFK6uYr5SfQsMsXQ5s=;
        b=oJG/Foj1dE4WsBcEJv0W9+NibevOyO/8Jin8+WAcSwYRaqoQ8gzpjGib5WGC0OjC5N
         I2O6Gp4OAHVJKNXuklSJzIA4gVEU+dkPjPsrVCspxeylSxII1RhCigeSlDTo0mkbpHaw
         XD73s0HDAcDAmtpJGQuW5HGEyhS5Pastz+G+4WaPk6g+iygnUyV0kDj0gWNm6cADPc2w
         9WCtBOW+UnrNwNXVlt7ozuC3RtmYnaAQVVFCr/H6vCiRVZ8us4D6ttm5Zn21KcgQrj32
         DMoj/gXh0pbw5LAIX0667WBwaBGKxoN2I0J8K2i3XsNt223+FmNCxwdFmCq6DKZnvKs9
         l00w==
X-Gm-Message-State: ANoB5plcICn6/z0P2Rs3mkGVw1+Wr+YOfJ8FJ0RuXNbHSLnJr1wz5LFi
        JbsqCKyjYyBrX+RVsT6CgRUuePS8Xoio4bPgDbE=
X-Google-Smtp-Source: AA0mqf4uZUoux2M2v29/zZ3v2C44q78xUD1Msan89VfOoY5pERnUE1Q8CQ1ffdqcO4ygChClfnlLhve/MKsdIu+gkW0=
X-Received: by 2002:a17:906:79c4:b0:778:e3e2:8311 with SMTP id
 m4-20020a17090679c400b00778e3e28311mr5877319ejo.342.1669138992883; Tue, 22
 Nov 2022 09:43:12 -0800 (PST)
MIME-Version: 1.0
References: <20221102004329.5410-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221102004329.5410-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <Y3wioC4Oyl81mBGh@pendragon.ideasonboard.com>
In-Reply-To: <Y3wioC4Oyl81mBGh@pendragon.ideasonboard.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 22 Nov 2022 17:42:46 +0000
Message-ID: <CA+V-a8tqT61fsge=wJwqnG3M3ZA4Ybkiyx2o0LnArwM6LoWdfQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] media: platform: Add Renesas RZ/G2L MIPI CSI-2
 receiver driver
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Laurent,

Thank you for the review.

On Tue, Nov 22, 2022 at 1:15 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Prabhakar,
>
> Thank you for the patch.
>
> On Wed, Nov 02, 2022 at 12:43:28AM +0000, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add MIPI CSI-2 receiver driver for Renesas RZ/G2L. The MIPI
> > CSI-2 is part of the CRU module found on RZ/G2L family.
> >
> > Based on a patch in the BSP by Hien Huynh
> > <hien.huynh.px@renesas.com>
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v4 -> v5
> > * Made sure to cleanup in s_stream error path
> >
<snip>
> > +struct rzg2l_csi2_timings {
> > +     u32 t_init;
> > +     u32 tclk_miss;
> > +     u32 tclk_settle;
> > +     u32 ths_settle;
> > +     u32 tclk_prepare;
> > +     u32 ths_prepare;
> > +     u32 max_hsfreq;
> > +};
> > +
> > +static const struct rzg2l_csi2_timings rzg2l_csi2_global_timings[] = {
> > +     [0] = {
>
> You can drop [0]. Same below.
>
The ths_settle value differs for [1].

> > +             .max_hsfreq = 80,
> > +             .t_init = 79801,
> > +             .tclk_miss = 4,
> > +             .tclk_settle = 23,
> > +             .ths_settle = 31,
> > +             .tclk_prepare = 10,
> > +             .ths_prepare = 19,
> > +     },
> > +     [1] = {
> > +             .max_hsfreq = 125,
> > +             .t_init = 79801,
> > +             .tclk_miss = 4,
> > +             .tclk_settle = 23,
> > +             .ths_settle = 28,
> > +             .tclk_prepare = 10,
> > +             .ths_prepare = 19,
> > +     },
> > +     [2] = {
> > +             .max_hsfreq = 250,
> > +             .t_init = 79801,
> > +             .tclk_miss = 4,
> > +             .tclk_settle = 23,
> > +             .ths_settle = 22,
> > +             .tclk_prepare = 10,
> > +             .ths_prepare = 16,
> > +     },
> > +     [3] = {
> > +             .max_hsfreq = 360,
> > +             .t_init = 79801,
> > +             .tclk_miss = 4,
> > +             .tclk_settle = 18,
> > +             .ths_settle = 19,
> > +             .tclk_prepare = 10,
> > +             .ths_prepare = 10,
> > +     },
> > +     [4] = {
> > +             .max_hsfreq = 1500,
> > +             .t_init = 79801,
> > +             .tclk_miss = 4,
> > +             .tclk_settle = 18,
> > +             .ths_settle = 18,
> > +             .tclk_prepare = 10,
> > +             .ths_prepare = 10,
> > +     },
> > +};
> > +
> > +struct rzg2l_csi2_format {
> > +     u32 code;
> > +     unsigned int datatype;
> > +     unsigned int bpp;
> > +};
> > +
> > +static const struct rzg2l_csi2_format rzg2l_csi2_formats[] = {
> > +     { .code = MEDIA_BUS_FMT_UYVY8_1X16,     .datatype = 0x1e, .bpp = 16 },
> > +};
> > +
> > +static inline struct rzg2l_csi2 *sd_to_csi2(struct v4l2_subdev *sd)
> > +{
> > +     return container_of(sd, struct rzg2l_csi2, subdev);
> > +}
> > +
> > +static const struct rzg2l_csi2_format *rzg2l_csi2_code_to_fmt(unsigned int code)
> > +{
> > +     unsigned int i;
> > +
> > +     for (i = 0; i < ARRAY_SIZE(rzg2l_csi2_formats); i++)
> > +             if (rzg2l_csi2_formats[i].code == code)
> > +                     return &rzg2l_csi2_formats[i];
> > +
> > +     return NULL;
> > +}
> > +
> > +static inline struct rzg2l_csi2 *notifier_to_csi2(struct v4l2_async_notifier *n)
> > +{
> > +     return container_of(n, struct rzg2l_csi2, notifier);
> > +}
> > +
> > +static u32 rzg2l_csi2_read(struct rzg2l_csi2 *csi2, unsigned int reg)
> > +{
> > +     return ioread32(csi2->base + reg);
> > +}
> > +
> > +static void rzg2l_csi2_write(struct rzg2l_csi2 *csi2, unsigned int reg,
> > +                          u32 data)
> > +{
> > +     iowrite32(data, csi2->base + reg);
> > +}
> > +
> > +static void rzg2l_csi2_set(struct rzg2l_csi2 *csi2, unsigned int reg, u32 set)
> > +{
> > +     rzg2l_csi2_write(csi2, reg, rzg2l_csi2_read(csi2, reg) | set);
> > +}
> > +
> > +static void rzg2l_csi2_clr(struct rzg2l_csi2 *csi2, unsigned int reg, u32 clr)
> > +{
> > +     rzg2l_csi2_write(csi2, reg, rzg2l_csi2_read(csi2, reg) & ~clr);
> > +}
> > +
> > +static int rzg2l_csi2_calc_mbps(struct rzg2l_csi2 *csi2)
> > +{
> > +     struct v4l2_subdev *source = csi2->remote_source;
> > +     const struct rzg2l_csi2_format *format;
> > +     const struct v4l2_mbus_framefmt *fmt;
> > +     struct v4l2_subdev_state *state;
> > +     struct v4l2_ctrl *ctrl;
> > +     u64 mbps;
> > +
> > +     /* Read the pixel rate control from remote. */
> > +     ctrl = v4l2_ctrl_find(source->ctrl_handler, V4L2_CID_PIXEL_RATE);
> > +     if (!ctrl) {
> > +             dev_err(csi2->dev, "no pixel rate control in subdev %s\n",
> > +                     source->name);
> > +             return -EINVAL;
> > +     }
> > +
> > +     state = v4l2_subdev_lock_and_get_active_state(&csi2->subdev);
> > +     fmt = v4l2_subdev_get_pad_format(&csi2->subdev, state, RZG2L_CSI2_SINK);
> > +     format = rzg2l_csi2_code_to_fmt(fmt->code);
> > +     v4l2_subdev_unlock_state(state);
> > +
> > +     /*
> > +      * Calculate hsfreq in Mbps
> > +      * hsfreq = (pixel_rate * bits_per_sample) / number_of_lanes
> > +      */
> > +     mbps = v4l2_ctrl_g_ctrl_int64(ctrl) * format->bpp;
> > +     do_div(mbps, csi2->lanes * 1000000);
> > +
> > +     return mbps;
> > +}
> > +
> > +/* -----------------------------------------------------------------------------
> > + * DPHY setting
> > + */
> > +
> > +static int rzg2l_csi2_dphy_disable(struct rzg2l_csi2 *csi2)
> > +{
> > +     int ret;
> > +
> > +     /* Reset the CRU (D-PHY) */
> > +     ret = reset_control_assert(csi2->cmn_rstb);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Stop the D-PHY clock */
> > +     clk_disable_unprepare(csi2->sysclk);
> > +
> > +     /* Cancel the EN_LDO1200 register setting */
> > +     rzg2l_csi2_clr(csi2, CSIDPHYCTRL0, CSIDPHYCTRL0_EN_LDO1200);
> > +
> > +     /* Cancel the EN_BGR register setting */
> > +     rzg2l_csi2_clr(csi2, CSIDPHYCTRL0, CSIDPHYCTRL0_EN_BGR);
> > +
> > +     csi2->dphy_enabled = false;
> > +
> > +     return 0;
> > +}
> > +
> > +static int rzg2l_csi2_dphy_enable(struct rzg2l_csi2 *csi2)
> > +{
> > +     const struct rzg2l_csi2_timings *dphy_timing;
> > +     u32 dphytim0, dphytim1;
> > +     unsigned int i;
> > +     int mbps;
> > +     int ret;
> > +
> > +     mbps = rzg2l_csi2_calc_mbps(csi2);
> > +     if (mbps < 0)
> > +             return mbps;
> > +
> > +     csi2->hsfreq = mbps;
> > +
> > +     /* Set DPHY timing parameters */
> > +     for (i = 0; i < ARRAY_SIZE(rzg2l_csi2_global_timings); ++i) {
> > +             dphy_timing = &rzg2l_csi2_global_timings[i];
> > +
> > +             if (csi2->hsfreq <= dphy_timing->max_hsfreq)
> > +                     break;
> > +     }
> > +
> > +     if (i >= ARRAY_SIZE(rzg2l_csi2_global_timings))
> > +             return -EINVAL;
> > +
> > +     /* Set D-PHY timing parameters */
> > +     dphytim0 = CSIDPHYTIM0_TCLK_MISS(dphy_timing->tclk_miss) |
> > +                     CSIDPHYTIM0_T_INIT(dphy_timing->t_init);
> > +     dphytim1 = CSIDPHYTIM1_THS_PREPARE(dphy_timing->ths_prepare) |
> > +                     CSIDPHYTIM1_TCLK_PREPARE(dphy_timing->tclk_prepare) |
> > +                     CSIDPHYTIM1_THS_SETTLE(dphy_timing->ths_settle) |
> > +                     CSIDPHYTIM1_TCLK_SETTLE(dphy_timing->tclk_settle);
> > +     rzg2l_csi2_write(csi2, CSIDPHYTIM0, dphytim0);
> > +     rzg2l_csi2_write(csi2, CSIDPHYTIM1, dphytim1);
> > +
> > +     /* Enable D-PHY power control 0 */
> > +     rzg2l_csi2_write(csi2, CSIDPHYSKW0, CSIDPHYSKW0_DEFAULT_SKW);
> > +
> > +     /* Set the EN_BGR bit */
> > +     rzg2l_csi2_set(csi2, CSIDPHYCTRL0, CSIDPHYCTRL0_EN_BGR);
> > +
> > +     /* Delay 20us to be stable */
> > +     usleep_range(20, 40);
> > +
> > +     /* Enable D-PHY power control 1 */
> > +     rzg2l_csi2_set(csi2, CSIDPHYCTRL0, CSIDPHYCTRL0_EN_LDO1200);
> > +
> > +     /* Delay 10us to be stable */
> > +     usleep_range(10, 20);
> > +
> > +     /* Start supplying the internal clock for the D-PHY block */
> > +     ret = clk_prepare_enable(csi2->sysclk);
> > +     if (ret)
> > +             rzg2l_csi2_dphy_disable(csi2);
> > +
> > +     csi2->dphy_enabled = true;
> > +
> > +     return ret;
> > +}
> > +
> > +static int rzg2l_csi2_enable_reg_access(struct rzg2l_csi2 *csi2)
> > +{
> > +     int ret;
> > +
> > +     ret = reset_control_deassert(csi2->presetn);
> > +     if (ret < 0)
> > +             return ret;
>
> Could this be done in the runtime PM resume handler ? Same for
> reset_control_assert() in the runtime PM suspend handler.
>
Yes it can be done, I'll move them to the runtime PM handlers.

> > +
> > +     ret = pm_runtime_resume_and_get(csi2->dev);
> > +     if (ret)
> > +             reset_control_assert(csi2->presetn);
> > +
> > +     return ret;
> > +}
> > +
> > +static void rzg2l_csi2_disable_reg_access(struct rzg2l_csi2 *csi2)
> > +{
> > +     pm_runtime_put_sync(csi2->dev);
> > +     reset_control_assert(csi2->presetn);
> > +}
> > +
> > +static int rzg2l_csi2_dphy_setting(struct v4l2_subdev *sd, bool on)
> > +{
> > +     struct rzg2l_csi2 *csi2 = sd_to_csi2(sd);
> > +     int ret;
> > +
> > +     ret = rzg2l_csi2_enable_reg_access(csi2);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     if (on)
> > +             ret = rzg2l_csi2_dphy_enable(csi2);
> > +     else
> > +             ret = rzg2l_csi2_dphy_disable(csi2);
> > +
> > +     rzg2l_csi2_disable_reg_access(csi2);
> > +
> > +     return ret;
> > +}
> > +
> > +static void rzg2l_csi2_mipi_link_enable(struct rzg2l_csi2 *csi2)
> > +{
> > +     unsigned long vclk_rate = csi2->vclk_rate / HZ_PER_MHZ;
> > +     u32 frrskw, frrclk, frrskw_coeff, frrclk_coeff;
> > +
> > +     /* Select data lanes */
> > +     rzg2l_csi2_write(csi2, CSI2nMCT0, CSI2nMCT0_VDLN(csi2->lanes));
> > +
> > +     frrskw_coeff = 3 * vclk_rate * 8;
> > +     frrclk_coeff = frrskw_coeff / 2;
> > +     frrskw = DIV_ROUND_UP(frrskw_coeff, csi2->hsfreq);
> > +     frrclk = DIV_ROUND_UP(frrclk_coeff, csi2->hsfreq);
> > +     rzg2l_csi2_write(csi2, CSI2nMCT2, CSI2nMCT2_FRRSKW(frrskw) |
> > +                      CSI2nMCT2_FRRCLK(frrclk));
> > +
> > +     /*
> > +      * Select data type.
> > +      * FS, FE, LS, LE, Generic Short Packet Codes 1 to 8,
> > +      * Generic Long Packet Data Types 1 to 4 YUV422 8-bit,
> > +      * RGB565, RGB888, RAW8 to RAW20, User-defined 8-bit
> > +      * data types 1 to 8
> > +      */
> > +     rzg2l_csi2_write(csi2, CSI2nDTEL, 0xf778ff0f);
> > +     rzg2l_csi2_write(csi2, CSI2nDTEH, 0x00ffff1f);
> > +
> > +     /* Enable LINK reception */
> > +     rzg2l_csi2_write(csi2, CSI2nMCT3, CSI2nMCT3_RXEN);
> > +}
> > +
> > +static void rzg2l_csi2_mipi_link_disable(struct rzg2l_csi2 *csi2)
> > +{
> > +     unsigned int timeout = VSRSTS_RETRIES;
> > +
> > +     /* Stop LINK reception */
> > +     rzg2l_csi2_clr(csi2, CSI2nMCT3, CSI2nMCT3_RXEN);
> > +
> > +     /* Request a software reset of the LINK Video Pixel Interface */
> > +     rzg2l_csi2_write(csi2, CSI2nRTCT, CSI2nRTCT_VSRST);
> > +
> > +     /* Make sure CSI2nRTST.VSRSTS bit is cleared */
> > +     while (timeout--) {
> > +             if (!(rzg2l_csi2_read(csi2, CSI2nRTST) & CSI2nRTST_VSRSTS))
> > +                     break;
> > +             usleep_range(100, 200);
> > +     };
> > +
> > +     if (!timeout)
> > +             dev_err(csi2->dev, "Clearing CSI2nRTST.VSRSTS timed out\n");
> > +}
> > +
> > +static int rzg2l_csi2_mipi_link_setting(struct v4l2_subdev *sd, bool on)
> > +{
> > +     struct rzg2l_csi2 *csi2 = sd_to_csi2(sd);
> > +     int ret;
> > +
> > +     ret = rzg2l_csi2_enable_reg_access(csi2);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     if (on)
> > +             rzg2l_csi2_mipi_link_enable(csi2);
> > +     else
> > +             rzg2l_csi2_mipi_link_disable(csi2);
> > +
> > +     rzg2l_csi2_disable_reg_access(csi2);
>
> This doesn't seem right. Runtime PM isn't just about register access.
> You need to call pm_runtime_resume_and_get() at the beginning of
> rzg2l_csi2_s_stream() when enabling, and pm_runtime_put_sync() at the
> end of rzg2l_csi2_s_stream() when disabling (+ error paths for the
> enable case).
>
OK, I'll make use of runtime PM in s_stream callback.

> > +
> > +     return 0;
> > +}
> > +
> > +static int rzg2l_csi2_s_stream(struct v4l2_subdev *sd, int enable)
> > +{
> > +     struct rzg2l_csi2 *csi2 = sd_to_csi2(sd);
> > +     int s_stream_ret = 0;
> > +     int ret;
> > +
> > +     if (enable) {
> > +             int ret;
> > +
> > +             ret = rzg2l_csi2_mipi_link_setting(sd, 1);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret = reset_control_deassert(csi2->cmn_rstb);
> > +             if (ret)
> > +                     goto err_mipi_link_disable;
> > +     }
> > +
> > +     ret = v4l2_subdev_call(csi2->remote_source, video, s_stream, enable);
> > +     if (ret) {
> > +             s_stream_ret = ret;
> > +             dev_err(csi2->dev, "s_stream failed on remote source\n");
>
> With
> https://lore.kernel.org/linux-media/20221026065123.595777-1-sakari.ailus@linux.intel.com/
> I think you can drop this error message.
>
Agreed, I will drop the error message.

> > +     }
> > +
> > +     if (enable && ret)
> > +             goto err_assert_rstb;
> > +
> > +     if (!enable) {
> > +             ret = rzg2l_csi2_dphy_setting(sd, 0);
> > +             if (ret && !s_stream_ret)
> > +                     s_stream_ret = ret;
> > +             ret = rzg2l_csi2_mipi_link_setting(sd, 0);
> > +             if (ret && !s_stream_ret)
> > +                     s_stream_ret = ret;
> > +     }
> > +
> > +     return s_stream_ret;
> > +
> > +err_assert_rstb:
> > +     reset_control_assert(csi2->cmn_rstb);
> > +err_mipi_link_disable:
> > +     rzg2l_csi2_mipi_link_setting(sd, 0);
> > +     return ret;
> > +}
> > +
> > +static int rzg2l_csi2_pre_streamon(struct v4l2_subdev *sd, u32 flags)
> > +{
> > +     return rzg2l_csi2_dphy_setting(sd, 1);
> > +}
> > +
> > +static int rzg2l_csi2_post_streamoff(struct v4l2_subdev *sd)
> > +{
> > +     struct rzg2l_csi2 *csi2 = sd_to_csi2(sd);
> > +
> > +     /*
> > +      * In ideal case D-PHY will be disabled in s_stream(0) callback
> > +      * as mentioned the HW manual. The below will only happen when
> > +      * pre_streamon succeeds and further down the line s_stream(1)
> > +      * fails so we need to undo things in post_streamoff.
> > +      */
> > +     if (csi2->dphy_enabled)
> > +             return rzg2l_csi2_dphy_setting(sd, 0);
> > +
> > +     return 0;
> > +}
> > +
> > +static int rzg2l_csi2_set_format(struct v4l2_subdev *sd,
> > +                              struct v4l2_subdev_state *state,
> > +                              struct v4l2_subdev_format *fmt)
> > +{
> > +     struct v4l2_mbus_framefmt *src_format;
> > +     struct v4l2_mbus_framefmt *sink_format;
> > +
> > +     if (fmt->pad != RZG2L_CSI2_SINK && fmt->pad != RZG2L_CSI2_SOURCE)
> > +             return -EINVAL;
>
> You can drop this check as the set_format wrapper validates the pad
> value already.
>
OK, I will drop this check.

> > +
> > +     sink_format = v4l2_subdev_get_pad_format(sd, state, RZG2L_CSI2_SINK);
> > +     src_format = v4l2_subdev_get_pad_format(sd, state, RZG2L_CSI2_SOURCE);
>
> As the CSI-2 receiver can't modify the format on the output,
> set_format() on the source pad must not modify the format. Just add
>
>         if (fmt->pad == RZG2L_CSI2_SOURCE) {
>                 fmt->format = *src_format;
>                 return 0;
>         }
>
> here.
>
OK, I will update as above.

> > +
> > +     if (!rzg2l_csi2_code_to_fmt(fmt->format.code))
> > +             sink_format->code = rzg2l_csi2_formats[0].code;
> > +     else
> > +             sink_format->code = fmt->format.code;
> > +
> > +     sink_format->field = V4L2_FIELD_NONE;
> > +     sink_format->colorspace = fmt->format.colorspace;
> > +     sink_format->xfer_func = fmt->format.xfer_func;
> > +     sink_format->ycbcr_enc = fmt->format.ycbcr_enc;
> > +     sink_format->quantization = fmt->format.quantization;
> > +     sink_format->width = clamp_t(u32, fmt->format.width,
> > +                                  RZG2L_CSI2_MIN_WIDTH, RZG2L_CSI2_MAX_WIDTH);
> > +     sink_format->height = clamp_t(u32, fmt->format.height,
> > +                                   RZG2L_CSI2_MIN_HEIGHT, RZG2L_CSI2_MAX_HEIGHT);
> > +     fmt->format = *sink_format;
> > +
> > +     /* propagate format to source pad */
> > +     *src_format = *sink_format;
> > +
> > +     return 0;
> > +}
> > +
> > +static int rzg2l_csi2_init_config(struct v4l2_subdev *sd,
> > +                               struct v4l2_subdev_state *sd_state)
> > +{
> > +     struct v4l2_subdev_format fmt = { .pad = RZG2L_CSI2_SINK, };
> > +
> > +     fmt.format.width = RZG2L_CSI2_DEFAULT_WIDTH;
> > +     fmt.format.height = RZG2L_CSI2_DEFAULT_HEIGHT;
> > +     fmt.format.field = V4L2_FIELD_NONE;
> > +     fmt.format.code = RZG2L_CSI2_DEFAULT_FMT;
> > +     fmt.format.colorspace = V4L2_COLORSPACE_SRGB;
> > +     fmt.format.ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
> > +     fmt.format.quantization = V4L2_QUANTIZATION_DEFAULT;
> > +     fmt.format.xfer_func = V4L2_XFER_FUNC_DEFAULT;
> > +
> > +     return rzg2l_csi2_set_format(sd, sd_state, &fmt);
> > +}
> > +
> > +static int rzg2l_csi2_enum_mbus_code(struct v4l2_subdev *sd,
> > +                                  struct v4l2_subdev_state *sd_state,
> > +                                  struct v4l2_subdev_mbus_code_enum *code)
> > +{
> > +     if (code->index >= ARRAY_SIZE(rzg2l_csi2_formats))
> > +             return -EINVAL;
> > +
> > +     code->code = rzg2l_csi2_formats[code->index].code;
> > +
> > +     return 0;
> > +}
> > +
> > +static int rzg2l_csi2_enum_frame_size(struct v4l2_subdev *sd,
> > +                                   struct v4l2_subdev_state *sd_state,
> > +                                   struct v4l2_subdev_frame_size_enum *fse)
> > +{
> > +     if (fse->index != 0)
> > +             return -EINVAL;
> > +
> > +     fse->min_width = RZG2L_CSI2_MIN_WIDTH;
> > +     fse->min_height = RZG2L_CSI2_MIN_HEIGHT;
> > +     fse->max_width = RZG2L_CSI2_MAX_WIDTH;
> > +     fse->max_height = RZG2L_CSI2_MAX_HEIGHT;
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct v4l2_subdev_video_ops rzg2l_csi2_video_ops = {
> > +     .s_stream = rzg2l_csi2_s_stream,
> > +     .pre_streamon = rzg2l_csi2_pre_streamon,
> > +     .post_streamoff = rzg2l_csi2_post_streamoff,
> > +};
> > +
> > +static const struct v4l2_subdev_pad_ops rzg2l_csi2_pad_ops = {
> > +     .enum_mbus_code = rzg2l_csi2_enum_mbus_code,
> > +     .init_cfg = rzg2l_csi2_init_config,
> > +     .enum_frame_size = rzg2l_csi2_enum_frame_size,
> > +     .set_fmt = rzg2l_csi2_set_format,
> > +     .get_fmt = v4l2_subdev_get_fmt,
> > +};
> > +
> > +static const struct v4l2_subdev_ops rzg2l_csi2_subdev_ops = {
> > +     .video  = &rzg2l_csi2_video_ops,
> > +     .pad    = &rzg2l_csi2_pad_ops,
> > +};
> > +
> > +/* -----------------------------------------------------------------------------
> > + * Async handling and registration of subdevices and links.
> > + */
> > +
> > +static int rzg2l_csi2_notify_bound(struct v4l2_async_notifier *notifier,
> > +                                struct v4l2_subdev *subdev,
> > +                                struct v4l2_async_subdev *asd)
> > +{
> > +     struct rzg2l_csi2 *csi2 = notifier_to_csi2(notifier);
> > +
> > +     csi2->remote_source = subdev;
> > +
> > +     dev_dbg(csi2->dev, "Bound subdev: %s pad\n", subdev->name);
> > +
> > +     return media_create_pad_link(&subdev->entity, RZG2L_CSI2_SINK,
> > +                                  &csi2->subdev.entity, 0,
> > +                                  MEDIA_LNK_FL_ENABLED |
> > +                                  MEDIA_LNK_FL_IMMUTABLE);
> > +}
> > +
> > +static void rzg2l_csi2_notify_unbind(struct v4l2_async_notifier *notifier,
> > +                                  struct v4l2_subdev *subdev,
> > +                                  struct v4l2_async_subdev *asd)
> > +{
> > +     struct rzg2l_csi2 *csi2 = notifier_to_csi2(notifier);
> > +
> > +     csi2->remote_source = NULL;
> > +
> > +     dev_dbg(csi2->dev, "Unbind subdev %s\n", subdev->name);
> > +}
> > +
> > +static const struct v4l2_async_notifier_operations rzg2l_csi2_notify_ops = {
> > +     .bound = rzg2l_csi2_notify_bound,
> > +     .unbind = rzg2l_csi2_notify_unbind,
> > +};
> > +
> > +static int rzg2l_csi2_parse_v4l2(struct rzg2l_csi2 *csi2,
> > +                              struct v4l2_fwnode_endpoint *vep)
> > +{
> > +     /* Only port 0 endpoint 0 is valid. */
> > +     if (vep->base.port || vep->base.id)
> > +             return -ENOTCONN;
> > +
> > +     csi2->lanes = vep->bus.mipi_csi2.num_data_lanes;
> > +
> > +     return 0;
> > +}
> > +
> > +static int rzg2l_csi2_parse_dt(struct rzg2l_csi2 *csi2)
> > +{
> > +     struct v4l2_fwnode_endpoint v4l2_ep = {
> > +             .bus_type = V4L2_MBUS_CSI2_DPHY
> > +     };
> > +     struct v4l2_async_subdev *asd;
> > +     struct fwnode_handle *fwnode;
> > +     struct fwnode_handle *ep;
> > +     int ret;
> > +
> > +     ep = fwnode_graph_get_endpoint_by_id(dev_fwnode(csi2->dev), 0, 0, 0);
> > +     if (!ep) {
> > +             dev_err(csi2->dev, "Not connected to subdevice\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret = v4l2_fwnode_endpoint_parse(ep, &v4l2_ep);
> > +     if (ret) {
> > +             dev_err(csi2->dev, "Could not parse v4l2 endpoint\n");
> > +             fwnode_handle_put(ep);
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret = rzg2l_csi2_parse_v4l2(csi2, &v4l2_ep);
> > +     if (ret) {
> > +             fwnode_handle_put(ep);
> > +             return ret;
> > +     }
> > +
> > +     fwnode = fwnode_graph_get_remote_endpoint(ep);
> > +     fwnode_handle_put(ep);
> > +
> > +     v4l2_async_nf_init(&csi2->notifier);
> > +     csi2->notifier.ops = &rzg2l_csi2_notify_ops;
> > +
> > +     asd = v4l2_async_nf_add_fwnode(&csi2->notifier, fwnode,
> > +                                    struct v4l2_async_subdev);
> > +     fwnode_handle_put(fwnode);
> > +     if (IS_ERR(asd))
> > +             return PTR_ERR(asd);
> > +
> > +     ret = v4l2_async_subdev_nf_register(&csi2->subdev, &csi2->notifier);
> > +     if (ret)
> > +             v4l2_async_nf_cleanup(&csi2->notifier);
> > +
> > +     return ret;
> > +}
> > +
> > +static int rzg2l_validate_csi2_lanes(struct rzg2l_csi2 *csi2)
> > +{
> > +     int ret = 0;
> > +     int lanes;
> > +
> > +     if (csi2->lanes != 1 && csi2->lanes != 2 && csi2->lanes != 4) {
> > +             dev_err(csi2->dev, "Unsupported number of data-lanes: %u\n",
> > +                     csi2->lanes);
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret = rzg2l_csi2_enable_reg_access(csi2);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     /* Checking the maximum lanes support for CSI-2 module */
> > +     lanes = (rzg2l_csi2_read(csi2, CSI2nMCG) & CSI2nMCG_SDLN) >> 8;
> > +     if (lanes < csi2->lanes) {
> > +             dev_err(csi2->dev,
> > +                     "Failed to support %d data lanes\n", csi2->lanes);
> > +             ret = -EINVAL;
> > +     }
> > +
> > +     rzg2l_csi2_disable_reg_access(csi2);
> > +
> > +     return ret;
> > +}
> > +
> > +/* -----------------------------------------------------------------------------
> > + * Platform Device Driver.
> > + */
> > +
> > +static const struct media_entity_operations rzg2l_csi2_entity_ops = {
> > +     .link_validate = v4l2_subdev_link_validate,
> > +};
> > +
> > +static int rzg2l_csi2_probe(struct platform_device *pdev)
> > +{
> > +     struct rzg2l_csi2 *csi2;
> > +     struct clk *vclk;
> > +     int ret;
> > +
> > +     csi2 = devm_kzalloc(&pdev->dev, sizeof(*csi2), GFP_KERNEL);
> > +     if (!csi2)
> > +             return -ENOMEM;
> > +
> > +     csi2->base = devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(csi2->base))
> > +             return PTR_ERR(csi2->base);
> > +
> > +     csi2->cmn_rstb = devm_reset_control_get_exclusive(&pdev->dev, "cmn-rstb");
> > +     if (IS_ERR(csi2->cmn_rstb))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(csi2->cmn_rstb),
> > +                                  "Failed to get cpg cmn-rstb\n");
> > +
> > +     csi2->presetn = devm_reset_control_get_shared(&pdev->dev, "presetn");
>
> Is this really a shared reset control, or do you use the shared API only
> to enable reference counting of the reset controller ?
>
As the CSI2 block is part of CRU itself the presetn reset (enables reg
access) is shared with the CRU driver too hence the use of shared api.

Cheers,
Prabhakar
