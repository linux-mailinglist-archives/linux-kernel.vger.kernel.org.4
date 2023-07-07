Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E7C74B660
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 20:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjGGSeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 14:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjGGSeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 14:34:17 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FAF212D
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 11:34:16 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40320e38b64so17988371cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 11:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20221208.gappssmtp.com; s=20221208; t=1688754855; x=1691346855;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q8zzG4W58cY1DMRLw33Pxd069pFxJi7Rdv1xoKGNoM0=;
        b=I3Gm/yVjt+KbvNaT43A8VDkuPL20ZGVvHXyMa73RzcengqGcVYRMG/tAdYOpNp4OZy
         v0UznlVB+1Gb+oU477T89Itk1Eyu3LY1L4btT9ObPimuCjof0zg1YkMn+kv8lxjX8Y5Z
         CkErhUoz5jGbAO+xryLKCNgO4xX/eYQ81QRu+Pit71z7+Adt/r0bgg1v7ArJathd1O3J
         IGzmJ7/1qhN5jKdOOM4XyaX739ax3j7UCKfN7hUFPvQOh/AJtrSzDDVmIHkzRNxTR+zx
         RqIdWKNlNSX3cZ5uGHUGk83Joej/nrGVv6yfxtKWcWf+PjU9xid+jEDtiXcFYVPjnthJ
         xvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688754855; x=1691346855;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q8zzG4W58cY1DMRLw33Pxd069pFxJi7Rdv1xoKGNoM0=;
        b=gtxL/+x5nYS43pBTAJTKJIwOfW/nXjHW9CKvhiV0QgKeq4d/vV+qS36bB1tGh5faB3
         THgkUQcq3gJymqNUrBapGLMSk4bd4sz7cU6Z4WdOzXFD0jcwRFUlDSzMdeMGLGqo9LZ4
         tzeqKbY4ceXIk0a6IsUZerVlHTh1JH2TP7YFJ69Vd17+vhwjiHl0c/LMN09+XvO793XE
         LXir6R8BCZcrFcuYz+r3oWQSZMg7c99+S6YlDXK7JxYX2LI72scKImlK5vdl7WZIjMXh
         DVSZlOk12YJRRxEk3jGxkn+HBOA2y1H8eZobzjsptupwbB27rNKWATmL8MN/SyZ9TQKk
         Z3yw==
X-Gm-Message-State: ABy/qLb28FBlzZF76U0gp2A3ZmP9WGWZ4FZA6l11iHscz+6iqxfphT3z
        1/N7pgvqTbrNzcJDfbTKEKgPb0jVs7s6GQB3VH+SiQ==
X-Google-Smtp-Source: APBJJlEinjEQtqOyggHzF0vaZ+wtg5OXm/r0LgOaCOfbAWEl/c65xrYR8JXPV4S29M58zJAhuA0fLw==
X-Received: by 2002:a05:622a:111:b0:3fd:de11:d8e4 with SMTP id u17-20020a05622a011100b003fdde11d8e4mr8131217qtw.23.1688754855384;
        Fri, 07 Jul 2023 11:34:15 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (mtl.collabora.ca. [66.171.169.34])
        by smtp.gmail.com with ESMTPSA id w25-20020ac84d19000000b003f394decd08sm1978812qtv.62.2023.07.07.11.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 11:34:14 -0700 (PDT)
Message-ID: <626c87dc2aede6998053bf2184f8aacace92ba93.camel@ndufresne.ca>
Subject: Re: [RFC PATCH 1/3] media: Add 10, 12, and 16 bit RGB formats
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     =?UTF-8?Q?Pawe=C5=82?= Anikiel <pan@semihalf.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     dinguyen@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mchehab@kernel.org, upstream@semihalf.com, amstan@chromium.org,
        ribalda@chromium.org
Date:   Fri, 07 Jul 2023 14:34:13 -0400
In-Reply-To: <20230630144006.1513270-2-pan@semihalf.com>
References: <20230630144006.1513270-1-pan@semihalf.com>
         <20230630144006.1513270-2-pan@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le vendredi 30 juin 2023 =C3=A0 16:40 +0200, Pawe=C5=82 Anikiel a =C3=A9cri=
t=C2=A0:
> Add the RGB30U, RGB30L, RGB36U, RGB36L, and RGB48 pixel formats.
>=20
> Signed-off-by: Pawe=C5=82 Anikiel <pan@semihalf.com>
> ---
>  drivers/media/v4l2-core/v4l2-ioctl.c | 5 +++++
>  include/uapi/linux/videodev2.h       | 5 +++++
>  2 files changed, 10 insertions(+)
>=20
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-co=
re/v4l2-ioctl.c
> index a858acea6547..5ee616704225 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1300,6 +1300,11 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *=
fmt)
>  	case V4L2_PIX_FMT_ARGB2101010:	descr =3D "32-bit ARGB 2-10-10-10"; brea=
k;
>  	case V4L2_PIX_FMT_BGR48_12:	descr =3D "12-bit Depth BGR"; break;
>  	case V4L2_PIX_FMT_ABGR64_12:	descr =3D "12-bit Depth BGRA"; break;
> +	case V4L2_PIX_FMT_RGB30U:	descr =3D "30-bit RXGXBX-10-10-10"; break;
> +	case V4L2_PIX_FMT_RGB30L:	descr =3D "30-bit XRXGXB-10-10-10"; break;
> +	case V4L2_PIX_FMT_RGB36U:	descr =3D "36-bit RXGXBX-12-12-12"; break;
> +	case V4L2_PIX_FMT_RGB36L:	descr =3D "36-bit XRXGXB-12-12-12"; break;
> +	case V4L2_PIX_FMT_RGB48:	descr =3D "48-bit RGB-16-16-16"; break;
>  	case V4L2_PIX_FMT_GREY:		descr =3D "8-bit Greyscale"; break;
>  	case V4L2_PIX_FMT_Y4:		descr =3D "4-bit Greyscale"; break;
>  	case V4L2_PIX_FMT_Y6:		descr =3D "6-bit Greyscale"; break;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev=
2.h
> index aee75eb9e686..3568819eabeb 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -583,6 +583,11 @@ struct v4l2_pix_format {
>  /* RGB formats (6 or 8 bytes per pixel) */
>  #define V4L2_PIX_FMT_BGR48_12    v4l2_fourcc('B', '3', '1', '2') /* 48  =
BGR 12-bit per component */
>  #define V4L2_PIX_FMT_ABGR64_12   v4l2_fourcc('B', '4', '1', '2') /* 64  =
BGRA 12-bit per component */
> +#define V4L2_PIX_FMT_RGB30U  v4l2_fourcc('R', '3', '0', 'U') /* 30  RXGX=
BX-10-10-10 */
> +#define V4L2_PIX_FMT_RGB30L  v4l2_fourcc('R', '3', '0', 'L') /* 30  XRXG=
XB-10-10-10 */
> +#define V4L2_PIX_FMT_RGB36U  v4l2_fourcc('R', '3', '6', 'U') /* 36  RXGX=
BX-12-12-12 */
> +#define V4L2_PIX_FMT_RGB36L  v4l2_fourcc('R', '3', '6', 'L') /* 36  XRXG=
XB-12-12-12 */
> +#define V4L2_PIX_FMT_RGB48   v4l2_fourcc('R', 'G', 'B', '6') /* 48  RGB-=
16-16-16    */

In a finalize patch, this would also need to be documented in
Documentation/userspace-api/media/v4l/pixfmt-rgb.rst . About this, what doe=
s  U
and L stands for ? Upper/lower for the padded bit placement ? Though, it lo=
oks
like the other way around in the comment, which may underline a Linux DRM s=
tyle
format documentation.

Nicolas

> =20
>  /* Grey formats */
>  #define V4L2_PIX_FMT_GREY    v4l2_fourcc('G', 'R', 'E', 'Y') /*  8  Grey=
scale     */

