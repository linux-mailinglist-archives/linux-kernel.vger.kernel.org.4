Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE9562FB88
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241919AbiKRRXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235435AbiKRRXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:23:51 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76408BC19
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:23:48 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id f18so14691198ejz.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rxvyRD/NaQsAjl7K9p9F/GYKO4FmZoDr+beCQYxmtZI=;
        b=JwN8fFEeS4qgw8afhvGopypDngHomKWs5ndp82K5dFOXpXoqZkjoqr1dYNvtHXBJZM
         ZKXpkjwwHIMmfppCizC4+GJcF552v5gqeUOtQC4B2WVl9PpCq/+T1ZgIn2Indvgc3QDu
         dlxR4gBHoXs6WXzni+YfT8g2OOe1/CWr38S1R8nAh+btShvaU6btMyH+gvwr1oSHL32Z
         necOa83otX/U/X3gCSdVLi2KvmVDYFoCRsf+YJSUtbSW+XlTFO8HTrG+0atUEMaNG7N5
         SwuTGhR0Rim03AaZDagnyb1LC0eJxhigr2tjlV+Ma5lq1DYSclrwMiUMRu+8ltHmq4pU
         BQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rxvyRD/NaQsAjl7K9p9F/GYKO4FmZoDr+beCQYxmtZI=;
        b=ORg7X7gABFJg0uw3vk6fi1+LdEJLYNWUV3YoH3nQEsL/wdItjwERO3xRriTaqPp8bd
         eq6xUl9v5ZvwXiY0dVurgcnL8fArURp8wG/XNQpvlswdyWbUaoPDiDgQ9EZ3+2tGLOEq
         YR82XFsOCEoggjv/9DQ9aJFTrRk5gs/7MiwwWhjbJB9Y9BoR/86Gk9VZtLdT7Kbbu07M
         13v34/p+s6o+uNGQlniWL7hzGCWH3RcfHsGsyVB7NVHF3kDWZEgLOiJA8jKuSVKYAkHZ
         whMooe0G3Kqj0HovT2v/Rcrd5ViWeqrbu1RPPTso5Fceg+sjFDP1zZC3gl1unz+I3Vsh
         DXcQ==
X-Gm-Message-State: ANoB5pkrRSVxaqD56z0Hq1EAoDBhutSucjqoR5gyOsmf1VseQYXmH7g5
        D/bnciVRqt7gKr0TC43/kyvXa8KQINur3Dqu0Ps1mw==
X-Google-Smtp-Source: AA0mqf5E3U3QDe/kxJnwRhAE2vuP8wTjd8B7GNWb3t/Y7tj+K6BqfHf/4CMtd+8p3qkNHsDfZwf03vVvq29hHp4Ai2U=
X-Received: by 2002:a17:906:1dc3:b0:7ad:bbcc:814 with SMTP id
 v3-20020a1709061dc300b007adbbcc0814mr6848924ejh.425.1668792227111; Fri, 18
 Nov 2022 09:23:47 -0800 (PST)
MIME-Version: 1.0
References: <20221118084244.199909-1-umang.jain@ideasonboard.com>
 <20221118084244.199909-4-umang.jain@ideasonboard.com> <166876862357.50677.2208743534141685703@Monstersaurus>
In-Reply-To: <166876862357.50677.2208743534141685703@Monstersaurus>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 18 Nov 2022 17:23:32 +0000
Message-ID: <CAPY8ntCk5ztM2FJtYS0X50rq4E658_4LtqUqEC2154s9dRb8ng@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] vc04_services: bcm2835-camera: Use bool values for mmal_fmt.remove_padding
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dan Carpenter <error27@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Umang Jain <umang.jain@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022 at 10:50, Kieran Bingham
<kieran.bingham@ideasonboard.com> wrote:
>
> Quoting Umang Jain (2022-11-18 08:42:44)
> > mmal_fmt.remove_padding is defined as a boolean type hence, use boolean
> > values for it instead of 0/1 integers. This enhances code readability.
>
> This could be (optionally) expanded:
>
> """
> The field 'remove_padding' in 'struct mmal_fmt' is defined as a boolean
> type.
>
> The initialisation of the formats[] array stores integer 0/1 values into
> this field rather than a more readable bool type.
>
> Convert the usages to boolean true/false, and fix up the local storage
> type in mmal_setup_components() to enhance code readability.
> """

Again I'll agree.

> Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

>
> > Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> > ---
> >  .../bcm2835-camera/bcm2835-camera.c           | 30 +++++++++----------
> >  1 file changed, 15 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> > index fd456d1f7061..797ebe2a973a 100644
> > --- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> > +++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> > @@ -87,21 +87,21 @@ static struct mmal_fmt formats[] = {
> >                 .depth = 12,
> >                 .mmal_component = COMP_CAMERA,
> >                 .ybbp = 1,
> > -               .remove_padding = 1,
> > +               .remove_padding = true,
> >         }, {
> >                 .fourcc = V4L2_PIX_FMT_YUYV,
> >                 .mmal = MMAL_ENCODING_YUYV,
> >                 .depth = 16,
> >                 .mmal_component = COMP_CAMERA,
> >                 .ybbp = 2,
> > -               .remove_padding = 0,
> > +               .remove_padding = false,
> >         }, {
> >                 .fourcc = V4L2_PIX_FMT_RGB24,
> >                 .mmal = MMAL_ENCODING_RGB24,
> >                 .depth = 24,
> >                 .mmal_component = COMP_CAMERA,
> >                 .ybbp = 3,
> > -               .remove_padding = 0,
> > +               .remove_padding = false,
> >         }, {
> >                 .fourcc = V4L2_PIX_FMT_JPEG,
> >                 .flags = V4L2_FMT_FLAG_COMPRESSED,
> > @@ -109,7 +109,7 @@ static struct mmal_fmt formats[] = {
> >                 .depth = 8,
> >                 .mmal_component = COMP_IMAGE_ENCODE,
> >                 .ybbp = 0,
> > -               .remove_padding = 0,
> > +               .remove_padding = false,
> >         }, {
> >                 .fourcc = V4L2_PIX_FMT_H264,
> >                 .flags = V4L2_FMT_FLAG_COMPRESSED,
> > @@ -117,7 +117,7 @@ static struct mmal_fmt formats[] = {
> >                 .depth = 8,
> >                 .mmal_component = COMP_VIDEO_ENCODE,
> >                 .ybbp = 0,
> > -               .remove_padding = 0,
> > +               .remove_padding = false,
> >         }, {
> >                 .fourcc = V4L2_PIX_FMT_MJPEG,
> >                 .flags = V4L2_FMT_FLAG_COMPRESSED,
> > @@ -125,63 +125,63 @@ static struct mmal_fmt formats[] = {
> >                 .depth = 8,
> >                 .mmal_component = COMP_VIDEO_ENCODE,
> >                 .ybbp = 0,
> > -               .remove_padding = 0,
> > +               .remove_padding = false,
> >         }, {
> >                 .fourcc = V4L2_PIX_FMT_YVYU,
> >                 .mmal = MMAL_ENCODING_YVYU,
> >                 .depth = 16,
> >                 .mmal_component = COMP_CAMERA,
> >                 .ybbp = 2,
> > -               .remove_padding = 0,
> > +               .remove_padding = false,
> >         }, {
> >                 .fourcc = V4L2_PIX_FMT_VYUY,
> >                 .mmal = MMAL_ENCODING_VYUY,
> >                 .depth = 16,
> >                 .mmal_component = COMP_CAMERA,
> >                 .ybbp = 2,
> > -               .remove_padding = 0,
> > +               .remove_padding = false,
> >         }, {
> >                 .fourcc = V4L2_PIX_FMT_UYVY,
> >                 .mmal = MMAL_ENCODING_UYVY,
> >                 .depth = 16,
> >                 .mmal_component = COMP_CAMERA,
> >                 .ybbp = 2,
> > -               .remove_padding = 0,
> > +               .remove_padding = false,
> >         }, {
> >                 .fourcc = V4L2_PIX_FMT_NV12,
> >                 .mmal = MMAL_ENCODING_NV12,
> >                 .depth = 12,
> >                 .mmal_component = COMP_CAMERA,
> >                 .ybbp = 1,
> > -               .remove_padding = 1,
> > +               .remove_padding = true,
> >         }, {
> >                 .fourcc = V4L2_PIX_FMT_BGR24,
> >                 .mmal = MMAL_ENCODING_BGR24,
> >                 .depth = 24,
> >                 .mmal_component = COMP_CAMERA,
> >                 .ybbp = 3,
> > -               .remove_padding = 0,
> > +               .remove_padding = false,
> >         }, {
> >                 .fourcc = V4L2_PIX_FMT_YVU420,
> >                 .mmal = MMAL_ENCODING_YV12,
> >                 .depth = 12,
> >                 .mmal_component = COMP_CAMERA,
> >                 .ybbp = 1,
> > -               .remove_padding = 1,
> > +               .remove_padding = true,
> >         }, {
> >                 .fourcc = V4L2_PIX_FMT_NV21,
> >                 .mmal = MMAL_ENCODING_NV21,
> >                 .depth = 12,
> >                 .mmal_component = COMP_CAMERA,
> >                 .ybbp = 1,
> > -               .remove_padding = 1,
> > +               .remove_padding = true,
> >         }, {
> >                 .fourcc = V4L2_PIX_FMT_BGR32,
> >                 .mmal = MMAL_ENCODING_BGRA,
> >                 .depth = 32,
> >                 .mmal_component = COMP_CAMERA,
> >                 .ybbp = 4,
> > -               .remove_padding = 0,
> > +               .remove_padding = false,
> >         },
> >  };
> >
> > @@ -1147,7 +1147,7 @@ static int mmal_setup_components(struct bcm2835_mmal_dev *dev,
> >         struct vchiq_mmal_port *port = NULL, *camera_port = NULL;
> >         struct vchiq_mmal_component *encode_component = NULL;
> >         struct mmal_fmt *mfmt = get_format(f);
> > -       u32 remove_padding;
> > +       bool remove_padding;
> >
> >         if (!mfmt)
> >                 return -EINVAL;
> > --
> > 2.38.1
> >
