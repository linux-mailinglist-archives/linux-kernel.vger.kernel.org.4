Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5170B612D6E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 23:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJ3WdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 18:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJ3WdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 18:33:15 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA2B95B3;
        Sun, 30 Oct 2022 15:33:11 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y69so15190376ede.5;
        Sun, 30 Oct 2022 15:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n2o/GMQ0tE3kyma8kEJB/WriSFlX/4OAcK/yGlC1IlE=;
        b=HABUGdOYJ2Ota30RMDhZXtIDHugmsIIqXOuZRUA24b6bDOpJXQ2G3HHR2xZx4lsH6m
         7MPFnhxyxZZnJalq7R6AKJyp7R8e+Q9QpYuo7SrguIFU9zScACRdg44x9drn7M1Vw5nO
         D+F8+at+RnRWoC2j74lZ9YpPJfKZwBDJx0lA75eR93WhVTKfJsrobxOuYZ7gxPhadicD
         5v5hIqYZKpEw51Gi/PlwYc725575Z/D7UzzqU0J9CMK2a6y+nKC4kOQPJRCg+LH6Xvtz
         S/+Q8oncydo38Iy6DHxXoS0zSzAFzL9jwzmAMRm7TCSrKxYKDhdjtI2OvvFWZEtoKKWN
         wvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n2o/GMQ0tE3kyma8kEJB/WriSFlX/4OAcK/yGlC1IlE=;
        b=eEfv1YkxpBLnCmyt8AhHgmiGzO+NlYcqJQolUcqKJLRqzAwOh5Bw4e6+JUufodv8ed
         TAjYbnQFt+vg0zRmcU2/obAm/pfMYt1ohwqXxz5gQt5x2onXYAMzIvZYZ5vurbCGUHaB
         GrtGyxMvDuWELcPkP1MVr8ZCbi3kjA2Cgt0GJroxLrEt+e1xHajZPBsCBSVFJtPITuK2
         KigbMS0jbgOuo4SXqwykg0ekNS4CclqcUexKkCfnkZ2P15wYbbUsEZAKKba4wkWXn9si
         QLlYpuGWou9vMuySQbdWXXuZyJpqpdKnxJW/HhjN0LnDmjivLUiGTgWDOBJtBGcm1/Kc
         OKkQ==
X-Gm-Message-State: ACrzQf079zZoMZMWw4PaVW5OuCGcUwCw8GJfcndBzILfD05WGV9Cq6QE
        qgR6sh5+HtawORncyer3UCTF+hgU8boOipa7qyo=
X-Google-Smtp-Source: AMsMyM7al3v/Q859ICA2kZ1i0JIfKddkJZDg1/XHd4Nv2cElZqaKFyOBOvfe3sVNCkvwP4CZRYWXR2Y1gqPYmcvqdho=
X-Received: by 2002:a05:6402:1219:b0:462:e788:723f with SMTP id
 c25-20020a056402121900b00462e788723fmr10523123edw.319.1667169190008; Sun, 30
 Oct 2022 15:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20221027103104.74576-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221027103104.74576-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y1qCbUoLrR6qlQwa@paasikivi.fi.intel.com> <CA+V-a8seroka4YkyCnSYa2KMPDWMG1Zk8tyiqRntdPUQnc+nrA@mail.gmail.com>
 <Y1vJbJfFjV9jRNzz@paasikivi.fi.intel.com>
In-Reply-To: <Y1vJbJfFjV9jRNzz@paasikivi.fi.intel.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sun, 30 Oct 2022 22:32:43 +0000
Message-ID: <CA+V-a8tONhJ1_x3T7+6n7tu=xyFBZfsqT2v3iUGd2Jy5_NuZCg@mail.gmail.com>
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

On Fri, Oct 28, 2022 at 1:22 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Prabhakar,
>
> On Thu, Oct 27, 2022 at 08:04:40PM +0100, Lad, Prabhakar wrote:
> ...
> > > > +static int rzg2l_cru_ip_s_stream(struct v4l2_subdev *sd, int enable)
> > > > +{
> > > > +     struct rzg2l_cru_dev *cru;
> > > > +     int ret;
> > > > +
> > > > +     cru = v4l2_get_subdevdata(sd);
> > > > +
> > > > +     if (!cru->is_csi)
> > > > +             return -EINVAL;
> > > > +
> > > > +     ret = v4l2_subdev_call(cru->ip.remote, video, s_stream, enable);
> > >
> > > It's up to the driver how call pre_streamon() and post_streamoff(), as long
> > > as it takes place on both sides of s_stream().
> > >
> > > In other words, as it seems your device doesn't need anything special, you
> > > could waive implemeting the callbacks yourself and call pre_streamon() and
> > > post_streamoff() here.
> > >
> > Here the cru->ip.remote = CSI, in the rzg2l_cru_set_stream(1) where we
> > are calling pre_streamon()/post_streamoff() callbacks the subdev is
> > CRU-IP. So the calls from rzg2l_cru_set_stream() land into
> > rzg2l_cru_ip_pre_streamon() and rzg2l_cru_ip_post_streamoff() which
> > are calling pre_streamon/post_streamoff for the CSI subdev.
>
> Again, you should call the source sub-device's pre_streamon and
> post_streamoff from the s_stream handler (not from
> rzg2l_cru_ip_pre_streamon or rzg2l_cru_ip_post_streamoff).
>
> Starting streaming takes place link by link. This allows a driver to omit
> implementing pre_streamon and post_streamon callbacks if it doesn't need
> them.
>
Thank you for the explanation that makes sense now to me.

Now with this approach the initialization sequence of CSI + CRU won't
align as per the HW manual. Unfortunately I'll have to switch back on
exporting the functions. I hope that's okay?

Cheers,
Prabhakar
