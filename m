Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBFC6921D2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjBJPSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjBJPS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:18:28 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5436674056
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:18:27 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id m12so6077023qth.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kgPIjCTIkUK2HSydXpeow0zn/gWtp/nDZGA8t6qS5Fo=;
        b=fJuzmKqP1FyrpKunPWkIWZlVixMikRcsvY0XDhEg18HEtRmaR9NuBb9Oyl9QCVEYhc
         dC3+NVFqXiFEzLnSjmBvvTliOARPGyCGMIElYKwZYbnEsEBiBcar9uhx+EudsBH5lI9F
         qlOIeOq7kPqKmGv4j4XJMqO9627Tpl96OlVF8zlWN+BSgbLRfC/eY3HJVilpBhQHJA39
         8BmUM2fr/9SS31R/UzD1SOH7Vt78WiXeaue6gQRA3zhj2fbU6qm8i01LGNCBVfP4GZfI
         C6kTxwbN8Dqmhlm/k7/PPLY/X7SxQG2lyM23INYIU1yyS6U+iwJTsJmAOG93g49mFJFe
         JYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kgPIjCTIkUK2HSydXpeow0zn/gWtp/nDZGA8t6qS5Fo=;
        b=UBR8iX3HpYAO19i9sZC9cqgW0d+9oca8cHOQL2ULQl75STo3+yyJQlo4uCnAFka6Hh
         3Gw5il945zGaGJXrVMOQrOIeRbb7G0EK3AUz4RpR9cUw0z5CRuqsCrvoSJ9CDryDzSD6
         DTvB8dJqwl62vrecYtcOepHHD8RHttRaEwQk5TIQ6gpXs1pLN+FkTX/VOuqQRY6VNJ1S
         DsnX+wI63YdpCurenAwQJIgfzc514H4+kj7FdMA3dc9K70BVjvuxOcNM0ZY60weeP8f+
         CM3DwzvUmGrEWz9w1QpqKSRnrJgZF0x0BmKJwFHC/s3aT8mtIc+Ot0yXUZhjolCH7mqf
         uKew==
X-Gm-Message-State: AO0yUKXq1bkdKzOLaR/KCP6pgxCW8bbe2ec7QjnroehxbSo23bE0iYM0
        gmazzIyDuMSjhJeB0UF6wFEQNQ==
X-Google-Smtp-Source: AK7set+gUFCcFMUcL9lV8dyoEs94WpKVtWCKgY2rHe531Q1KT2iZt1vu+oZXGbFTnbBqNWfdeZU3ag==
X-Received: by 2002:a05:622a:1a05:b0:3b6:3995:2ec2 with SMTP id f5-20020a05622a1a0500b003b639952ec2mr26618793qtb.19.1676042306398;
        Fri, 10 Feb 2023 07:18:26 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id g4-20020ac80704000000b003b63b8df24asm3464597qth.36.2023.02.10.07.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 07:18:25 -0800 (PST)
Message-ID: <fa6fcd8a905bff34f6d436ef328f5142b72b854c.camel@ndufresne.ca>
Subject: Re: [PATCH v2 02/10] media: Add Y012 video format
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        mirela.rabulea@oss.nxp.com, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Fri, 10 Feb 2023 10:18:24 -0500
In-Reply-To: <93889cdefacaad260d978a8353066dd384a64609.1675230665.git.ming.qian@nxp.com>
References: <cover.1675230665.git.ming.qian@nxp.com>
         <93889cdefacaad260d978a8353066dd384a64609.1675230665.git.ming.qian@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 01 f=C3=A9vrier 2023 =C3=A0 14:02 +0800, Ming Qian a =C3=A9crit=
=C2=A0:
> Y012 is a luma-only formats with 12-bits per pixel,
> expanded to 16bits.
> Data in the 12 high bits, zeros in the 4 low bits,
> arranged in little endian order.
>=20
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>  .../userspace-api/media/v4l/pixfmt-yuv-luma.rst       | 11 +++++++++++
>  drivers/media/v4l2-core/v4l2-ioctl.c                  |  1 +
>  include/uapi/linux/videodev2.h                        |  1 +
>  3 files changed, 13 insertions(+)
>=20
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst b/=
Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
> index 6a387f9df3ba..3ffa29000238 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
> @@ -103,6 +103,17 @@ are often referred to as greyscale formats.
>        - ...
>        - ...
> =20
> +    * .. _V4L2-PIX-FMT-Y012:

Why the 0, can't this be name Y12 (just like Y14) ?

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
> =20
>        - ``V4L2_PIX_FMT_Y14``
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-co=
re/v4l2-ioctl.c
> index 067dbdd0a9ef..0ee730aa6cc7 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1303,6 +1303,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *f=
mt)
>  	case V4L2_PIX_FMT_Y6:		descr =3D "6-bit Greyscale"; break;
>  	case V4L2_PIX_FMT_Y10:		descr =3D "10-bit Greyscale"; break;
>  	case V4L2_PIX_FMT_Y12:		descr =3D "12-bit Greyscale"; break;
> +	case V4L2_PIX_FMT_Y012:		descr =3D "12-bit Greyscale"; break;
>  	case V4L2_PIX_FMT_Y14:		descr =3D "14-bit Greyscale"; break;
>  	case V4L2_PIX_FMT_Y16:		descr =3D "16-bit Greyscale"; break;
>  	case V4L2_PIX_FMT_Y16_BE:	descr =3D "16-bit Greyscale BE"; break;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev=
2.h
> index 5448aa3b7858..3d8f89bff33c 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -583,6 +583,7 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_Y6      v4l2_fourcc('Y', '0', '6', ' ') /*  6  Grey=
scale     */
>  #define V4L2_PIX_FMT_Y10     v4l2_fourcc('Y', '1', '0', ' ') /* 10  Grey=
scale     */
>  #define V4L2_PIX_FMT_Y12     v4l2_fourcc('Y', '1', '2', ' ') /* 12  Grey=
scale     */
> +#define V4L2_PIX_FMT_Y012    v4l2_fourcc('Y', '0', '1', '2') /* 12  Grey=
scale     */
>  #define V4L2_PIX_FMT_Y14     v4l2_fourcc('Y', '1', '4', ' ') /* 14  Grey=
scale     */
>  #define V4L2_PIX_FMT_Y16     v4l2_fourcc('Y', '1', '6', ' ') /* 16  Grey=
scale     */
>  #define V4L2_PIX_FMT_Y16_BE  v4l2_fourcc_be('Y', '1', '6', ' ') /* 16  G=
reyscale BE  */

