Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1520161369C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 13:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiJaMlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 08:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJaMk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:40:58 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C0F7673;
        Mon, 31 Oct 2022 05:40:56 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id t25so29070724ejb.8;
        Mon, 31 Oct 2022 05:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OxaubAbafpenZ7N3bp3YoxG6NRX9IP+C6uvHAZg6564=;
        b=pRgwxtuYK6cj58F36SkjA4PLdkwO/JPOlWy1BSbOc0FP15lHOrmGspeGMAVbCU6D1a
         AHm+XkOKyeNHQq3UGhOBbQwZx/V8Z3w3hHtecVrNPA3TbRsuJ0TTCsZeqguC49lmdkjn
         1gOCipWPFTf54mrN/J24LtvnoGYn2mPamURV9XPo5sFQfSdSJ3Khiivkz+738BH52Jgv
         cvc99hJqATwzaOLaRb9DLTxkbwwN3icUfttgP9lqwuSHXpiVZ25TzVLtIMswfhAWuZyV
         Uq/jjKBRsg+Dn/Vjwo++/v9epzf76v+nsPlbFh8YPOxcrrfbz3A3g7PeZDhLWlJXL7oz
         AH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OxaubAbafpenZ7N3bp3YoxG6NRX9IP+C6uvHAZg6564=;
        b=mgNG90iCFcSdBu/M2lE0OAmlWzKM/57M+k+6CQEXCiP5+2tP9N5zYrAR9pBVAGKh5P
         ihXRv6aKWnjaL/CtG1lsc1vT+kFwERDIDFtj9qH5nXqdoJ3xfFp3Uf7pTjLemRAKpUbl
         jHfZ7UZdxeAiso7+0kwObByhPxyFTBp91Oj9f9IMKeYHTY1FfWkIund53uMWiA/OF/Po
         LzJud4tTfXdDwJrwdWpoz1JvFSLuPcsVfBzeuFw71WeD5e2yCqv+VyzBR6J9hS7EvW1s
         UOR3pOuvWLjzY0V6okLrL7kLRAWA/63DTDJWT9Yb/pMz8Ix3Sy5Le8a5I40sGYKgdxhK
         7N1Q==
X-Gm-Message-State: ACrzQf0AbijkIiik5/v5fMiWYTih6qcabdkAoKzYbvPLHjIhnSlbUYQ/
        KeY+JqAZ74wV4bbxxU0jeSZQW+jnGWHmK/EjWEQ=
X-Google-Smtp-Source: AMsMyM7YLrQKq/5EboPCHPbKqrRmyczuhv7AZyJNmUZ4MhcMQ7QOgQkVl6PLFX+HUhT6epeSryrEVIiqkNGV+rx2r/0=
X-Received: by 2002:a17:906:cc4d:b0:7ad:b598:9a53 with SMTP id
 mm13-20020a170906cc4d00b007adb5989a53mr10517958ejb.480.1667220054719; Mon, 31
 Oct 2022 05:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221027103104.74576-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221027103104.74576-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y1qCbUoLrR6qlQwa@paasikivi.fi.intel.com> <CA+V-a8seroka4YkyCnSYa2KMPDWMG1Zk8tyiqRntdPUQnc+nrA@mail.gmail.com>
 <Y1vJbJfFjV9jRNzz@paasikivi.fi.intel.com> <CA+V-a8tONhJ1_x3T7+6n7tu=xyFBZfsqT2v3iUGd2Jy5_NuZCg@mail.gmail.com>
 <Y1+FFD4/XCY8HyYa@paasikivi.fi.intel.com>
In-Reply-To: <Y1+FFD4/XCY8HyYa@paasikivi.fi.intel.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 31 Oct 2022 12:40:28 +0000
Message-ID: <CA+V-a8sKb4em07S5bYfe9RsgBnp3WDhf6bHu38LfuB2g+iJYZg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] media: platform: Add Renesas RZ/G2L CRU driver
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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

Hi Sakari,

On Mon, Oct 31, 2022 at 8:19 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Prabhakar,
>
> On Sun, Oct 30, 2022 at 10:32:43PM +0000, Lad, Prabhakar wrote:
> > Hi Sakari,
> >
> > On Fri, Oct 28, 2022 at 1:22 PM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hi Prabhakar,
> > >
> > > On Thu, Oct 27, 2022 at 08:04:40PM +0100, Lad, Prabhakar wrote:
> > > ...
> > > > > > +static int rzg2l_cru_ip_s_stream(struct v4l2_subdev *sd, int enable)
> > > > > > +{
> > > > > > +     struct rzg2l_cru_dev *cru;
> > > > > > +     int ret;
> > > > > > +
> > > > > > +     cru = v4l2_get_subdevdata(sd);
> > > > > > +
> > > > > > +     if (!cru->is_csi)
> > > > > > +             return -EINVAL;
> > > > > > +
> > > > > > +     ret = v4l2_subdev_call(cru->ip.remote, video, s_stream, enable);
> > > > >
> > > > > It's up to the driver how call pre_streamon() and post_streamoff(), as long
> > > > > as it takes place on both sides of s_stream().
> > > > >
> > > > > In other words, as it seems your device doesn't need anything special, you
> > > > > could waive implemeting the callbacks yourself and call pre_streamon() and
> > > > > post_streamoff() here.
> > > > >
> > > > Here the cru->ip.remote = CSI, in the rzg2l_cru_set_stream(1) where we
> > > > are calling pre_streamon()/post_streamoff() callbacks the subdev is
> > > > CRU-IP. So the calls from rzg2l_cru_set_stream() land into
> > > > rzg2l_cru_ip_pre_streamon() and rzg2l_cru_ip_post_streamoff() which
> > > > are calling pre_streamon/post_streamoff for the CSI subdev.
> > >
> > > Again, you should call the source sub-device's pre_streamon and
> > > post_streamoff from the s_stream handler (not from
> > > rzg2l_cru_ip_pre_streamon or rzg2l_cru_ip_post_streamoff).
> > >
> > > Starting streaming takes place link by link. This allows a driver to omit
> > > implementing pre_streamon and post_streamon callbacks if it doesn't need
> > > them.
> > >
> > Thank you for the explanation that makes sense now to me.
> >
> > Now with this approach the initialization sequence of CSI + CRU won't
> > align as per the HW manual. Unfortunately I'll have to switch back on
> > exporting the functions. I hope that's okay?
>
> It is not.
>
> What exactly would you like to do that you can't with the
> pre_streamon/post_streamoff callbacks called from s_stream?
>
The initialization sequence for MIPI CSI [0]. As per [0] we need to
initialize the CSI2 dphy first then setup the AXI (part of CRU driver)
and then later MIPI CSI2 link (part of csi driver) and lastly turn on
clock and link (in the cru driver).

So as per the current implementation we have the below:
1] CRU IP subdev is calling pre_stream for the CSI2 subdev in its
pre_stream on callback - This is where the CSI2 DPHY is initialized
2] Later in the flow we initialize the AXI part - ie part of
rzg2l_cru_set_stream
3] We call s_stream in rzg2l_cru_set_stream - This lands into CSI2
subdev to initialize the MIPI CSI2 Link
4] In the rzg2l_cru_set_stream we setup up the vclk and enable link reception

[0] https://ibb.co/QpHNkLh

Cheers,
Prabhakar
