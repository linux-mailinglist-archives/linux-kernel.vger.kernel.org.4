Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588EA6C2F32
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjCUKjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjCUKjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:39:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC0F46B2;
        Tue, 21 Mar 2023 03:39:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 461A661AC3;
        Tue, 21 Mar 2023 10:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778CBC433D2;
        Tue, 21 Mar 2023 10:39:04 +0000 (UTC)
Message-ID: <fbb6cbfd-9c40-7cf1-5790-eb3a14e12296@xs4all.nl>
Date:   Tue, 21 Mar 2023 11:39:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 02/10] media: Add Y012 video format
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        mirela.rabulea@oss.nxp.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1678788305.git.ming.qian@nxp.com>
 <e5fefc67731c492570bf468572c5894fdcefbb28.1678788305.git.ming.qian@nxp.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <e5fefc67731c492570bf468572c5894fdcefbb28.1678788305.git.ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 11:08, Ming Qian wrote:
> Y012 is a luma-only formats with 12-bits per pixel,
> expanded to 16bits.
> Data in the 12 high bits, zeros in the 4 low bits,
> arranged in little endian order.
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>  .../userspace-api/media/v4l/pixfmt-yuv-luma.rst   | 15 +++++++++++++++
>  drivers/media/v4l2-core/v4l2-ioctl.c              |  1 +
>  include/uapi/linux/videodev2.h                    |  1 +
>  3 files changed, 17 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
> index 62078a01de76..7888151f2cd4 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
> @@ -103,6 +103,17 @@ are often referred to as greyscale formats.
>        - ...
>        - ...
>  
> +    * .. _V4L2-PIX-FMT-Y012:
> +
> +      - ``V4L2_PIX_FMT_Y012``
> +      - 'Y012'
> +
> +      - Y'\ :sub:`0`\ [3:0] `0000`
> +      - Y'\ :sub:`0`\ [11:4]
> +      - ...
> +      - ...
> +      - ...
> +
>      * .. _V4L2-PIX-FMT-Y14:
>  
>        - ``V4L2_PIX_FMT_Y14``
> @@ -146,3 +157,7 @@ are often referred to as greyscale formats.
>      than 16 bits. For example, 10 bits per pixel uses values in the range 0 to
>      1023. For the IPU3_Y10 format 25 pixels are packed into 32 bytes, which
>      leaves the 6 most significant bits of the last byte padded with 0.
> +
> +    For Y012 and Y12 formats, Y012 place its data in the 12 high bits, with

place -> places

> +    padding zeros in the 4 low bits, in contrast to Y12 format, which have

to Y12 -> to the Y12
have -> has

> +    its padding located in the most significant bits of the 16 bit word.
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index 6489b67babfa..2cb485643562 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1307,6 +1307,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  	case V4L2_PIX_FMT_Y6:		descr = "6-bit Greyscale"; break;
>  	case V4L2_PIX_FMT_Y10:		descr = "10-bit Greyscale"; break;
>  	case V4L2_PIX_FMT_Y12:		descr = "12-bit Greyscale"; break;
> +	case V4L2_PIX_FMT_Y012:		descr = "12-bit Greyscale"; break;

I don't really like having two identical pixelformat names, but I can't
think of a good way to describe the difference.

Perhaps "12-bit Greyscale (bits 15-4)"?

Regards,

	Hans

>  	case V4L2_PIX_FMT_Y14:		descr = "14-bit Greyscale"; break;
>  	case V4L2_PIX_FMT_Y16:		descr = "16-bit Greyscale"; break;
>  	case V4L2_PIX_FMT_Y16_BE:	descr = "16-bit Greyscale BE"; break;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index f83a9d1210fb..db06d4c4f008 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -586,6 +586,7 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_Y6      v4l2_fourcc('Y', '0', '6', ' ') /*  6  Greyscale     */
>  #define V4L2_PIX_FMT_Y10     v4l2_fourcc('Y', '1', '0', ' ') /* 10  Greyscale     */
>  #define V4L2_PIX_FMT_Y12     v4l2_fourcc('Y', '1', '2', ' ') /* 12  Greyscale     */
> +#define V4L2_PIX_FMT_Y012    v4l2_fourcc('Y', '0', '1', '2') /* 12  Greyscale     */
>  #define V4L2_PIX_FMT_Y14     v4l2_fourcc('Y', '1', '4', ' ') /* 14  Greyscale     */
>  #define V4L2_PIX_FMT_Y16     v4l2_fourcc('Y', '1', '6', ' ') /* 16  Greyscale     */
>  #define V4L2_PIX_FMT_Y16_BE  v4l2_fourcc_be('Y', '1', '6', ' ') /* 16  Greyscale BE  */

