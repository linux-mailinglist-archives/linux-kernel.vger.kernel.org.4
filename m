Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3955729C27
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjFIOEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239717AbjFIOEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:04:09 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D8D30E8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:04:06 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-39a3f2668d5so654810b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1686319442; x=1688911442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M+/tsw/Fu7oYLrMbswe2mW+6R/VrTvrAxwbkhuN1+gE=;
        b=Utd6Z28yE85i1neitAe8UZz432SrAl01+uJzUB/LjoTKQmZKRCimEc4nBq/b0Nu9xp
         C7M2mQaWndb7qwAqiUZp8SjJkBzZsIPZ3ug8UXMQFwWtKB0pxAqeXcH3t63IMm6SCMl9
         M4bke8jWOas6OUUdccm1gJAb5Sxvd01zc4K/N6KuORebv09uaOQrLUO0PTN20LGMhbeT
         N2fCskWvCpWEhfdPFHfmE46vEyq9zkARbUUeokvvwJKgY5cvoxBmz57TvpLq6zQo8chj
         EopZvcsxcsb6FnPBszfO/eFd/advpvEORDZPXcfzCBsOVP1urmCheVb2FsVQpBc4mowf
         yL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686319442; x=1688911442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+/tsw/Fu7oYLrMbswe2mW+6R/VrTvrAxwbkhuN1+gE=;
        b=lBQskyB9vsj0Maa2zWjuRM6q2zgr7gGfEjBdTjyf+PGtqI1jDomRJZhQPiehKwjYq4
         VoF1Rpi+P22792bRDly78YUyLAElXvN3eFSg8jhbBCsqgJrKejL2oS1Mt+JfHm8/PkmJ
         WmVvWXFtZTkODXq1w9SREmXDWFezEh685TFGnWAMt+HC9WU+roZIKaMh2Iak8bsJFaxn
         1RvyU64rdU3HRzyIMzjtowq9bijxMwPlIl4C31Iy8+YDyEjigL9+bbOvZimlJDMB1LNm
         qBQMzCjbs5RwWxMpEKoVv1UusAi8772Oc41mMhHFqLTtlGCZZHVpmra+bZIjaZyWC2lS
         I/Wg==
X-Gm-Message-State: AC+VfDwzsTgyjMKM7IkaI17j++x9an5M2hC8SIU+04kj9jNlecJUs6EZ
        OB0sgRBHKascCBqiopkNbjCTuFCQxwaTS3FY2RbwF99iLPl6qqEs
X-Google-Smtp-Source: ACHHUZ7xd+DAStaq6dQecRItFmQrfrlVp253/CYtE0GVX7ER0YONC2JpXH5xCh1cp/C/WvLlK7eHvBYBvpCTrfdgZRk=
X-Received: by 2002:a05:6808:bd1:b0:398:2ec7:d5ed with SMTP id
 o17-20020a0568080bd100b003982ec7d5edmr1943178oik.19.1686319442584; Fri, 09
 Jun 2023 07:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230609-v4l2-vtotal-v1-0-4b7dee7e073e@skidata.com> <20230609-v4l2-vtotal-v1-1-4b7dee7e073e@skidata.com>
In-Reply-To: <20230609-v4l2-vtotal-v1-1-4b7dee7e073e@skidata.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 9 Jun 2023 15:03:46 +0100
Message-ID: <CAPY8ntDsUPZvN0M_7pyRfERK9V0MCkD6pp7zu6G9nDWYHwSVcw@mail.gmail.com>
Subject: Re: [PATCH 1/2] media: uapi: Add V4L2_CID_VTOTAL control
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        laurent.pinchart@ideasonboard.com, jacopo.mondi@ideasonboard.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin

Thanks for the patch.

On Fri, 9 Jun 2023 at 14:16, Benjamin Bara <bbara93@gmail.com> wrote:
>
> From: Benjamin Bara <benjamin.bara@skidata.com>
>
> Currently, V4L2_CID_VBLANK can be used to control the frame duration of
> a stream. However, camera sensors usually have a register for the
> vertical total size (image data + blanking), e.g. VMAX on the imx290.
> The dependency between format height and vertical blanking results to a
> change of the vertical blanking value and limits whenever the format of
> the frame is changed and therefore makes it harder for user space to do
> calculations, e.g. the frame duration.
>
> V4L2_CID_VTOTAL does not depend on the format and therefore simplifies
> calculations. Additionally, it represents the hardware "better" and
> therefore also simplifies calculations on the driver side.
>
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> ---
>  Documentation/userspace-api/media/v4l/ext-ctrls-image-source.rst | 6 ++++++
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c                        | 1 +
>  include/uapi/linux/v4l2-controls.h                               | 1 +
>  3 files changed, 8 insertions(+)
>
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-image-source.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-image-source.rst
> index 71f23f131f97..e72d1363ad85 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-image-source.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-image-source.rst
> @@ -59,6 +59,12 @@ Image Source Control IDs
>      non-sensitive.
>      This control is required for automatic calibration of sensors/cameras.
>
> +``V4L2_CID_VTOTAL (integer)``
> +    Number of total lines per frame, including data and idle lines (blanking).
> +    The unit of the vertical total size is a line. Every line has length of the
> +    image width plus horizontal blanking at the pixel rate defined by
> +    ``V4L2_CID_PIXEL_RATE`` control in the same sub-device.
> +
>  .. c:type:: v4l2_area
>
>  .. flat-table:: struct v4l2_area

The documentation for Frame interval configuration on Raw camera
sensors[1] needs updating to describe the new behaviour as well.

  Dave

[1] https://elixir.bootlin.com/linux/latest/source/Documentation/driver-api/media/camera-sensor.rst#L80


> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> index 564fedee2c88..6a0d310d5f42 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> @@ -1112,6 +1112,7 @@ const char *v4l2_ctrl_get_name(u32 id)
>         case V4L2_CID_TEST_PATTERN_BLUE:        return "Blue Pixel Value";
>         case V4L2_CID_TEST_PATTERN_GREENB:      return "Green (Blue) Pixel Value";
>         case V4L2_CID_NOTIFY_GAINS:             return "Notify Gains";
> +       case V4L2_CID_VTOTAL:                   return "Vertical Total Size";
>
>         /* Image processing controls */
>         /* Keep the order of the 'case's the same as in v4l2-controls.h! */
> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
> index 5e80daa4ffe0..99120005634e 100644
> --- a/include/uapi/linux/v4l2-controls.h
> +++ b/include/uapi/linux/v4l2-controls.h
> @@ -1117,6 +1117,7 @@ enum v4l2_jpeg_chroma_subsampling {
>  #define V4L2_CID_TEST_PATTERN_GREENB           (V4L2_CID_IMAGE_SOURCE_CLASS_BASE + 7)
>  #define V4L2_CID_UNIT_CELL_SIZE                        (V4L2_CID_IMAGE_SOURCE_CLASS_BASE + 8)
>  #define V4L2_CID_NOTIFY_GAINS                  (V4L2_CID_IMAGE_SOURCE_CLASS_BASE + 9)
> +#define V4L2_CID_VTOTAL                                (V4L2_CID_IMAGE_SOURCE_CLASS_BASE + 10)
>
>
>  /* Image processing controls */
>
> --
> 2.34.1
>
