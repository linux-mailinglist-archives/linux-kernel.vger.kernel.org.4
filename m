Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2982694D0C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjBMQiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjBMQio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:38:44 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0768F11641
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:38:43 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id cr22so14347516qtb.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=of5ICr9L1SNi/fIIwLV0Ou7LNrmAbw9vuFF0UoeHvV0=;
        b=D0b3HumuyZdrCW31MwzKs4JncPmAdXl/+lI40vyr3i253KzPDxd/I0M0sTPGj/xVLO
         J74GErmrkmv7vaOwjmZBpgV826+Y7aL0s/CXR/zCzOKRFmLl/bMUUSKQDT1LRkpGYqGs
         xjIOy2IoXkpX+Pxbam0PxnCNmCZQp4RkvXUzknqYvAMyQIDb3vP6xNJjGIRiLu3NoJBA
         ugWXnBUNfPw/7cUdPUJGaGjR8VoosuugGCxJvcrbmqZcc6wj/y06QT/cR7/OMqHEWbV9
         quvZB0vUnoB5wwdnq8r1gdDWGoaKRwsFQmAHUy581BGG7ZGfjq183yb0+AJt4ndAVFeu
         u1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=of5ICr9L1SNi/fIIwLV0Ou7LNrmAbw9vuFF0UoeHvV0=;
        b=S8ULd3J6oEqfYpM4cmbQrWfR9bCVaNH79+N3E2rSHs+yuujkPXdRmWbc2Q8EXayV8e
         c+DoNc2TA3uZXJ0eChtT8zLaCM/UJDBd2RAS6jNxOZh2rHqr4y8qc865odMm/wV2b085
         LLab+RyIF52qF9DzelICUAJ0SW9jiZvDBZD6tnVYPsD9z0UqBWbUsOiVAAR0DXmLCBG3
         9rIQQgQmDphYnVlSzThCq99FBwBhSfqSRVdQXQarJ/fBDJEmTjrRhMmobNcs8EXXArtf
         kKXu0CkDmYoE/OKCTAhpyeC967vtkPA0zEBaPYjaeD0dysRqiP0nwzhkm1Elr+mbE0j4
         O9vg==
X-Gm-Message-State: AO0yUKX5KSsfI14jQzfO/sNcM7sQ3qcWYRPMNl3H6hfmejC1ZIzVsSq3
        l1riNlKZAwrG6TGYFTMKRzihsw==
X-Google-Smtp-Source: AK7set/eFg9C/RdSOP104CBK6c0/68ffH4q9gO44zsLJrYEKZP0sqMZqqVyLsKKxGZFMvCbNA8nkog==
X-Received: by 2002:a05:622a:413:b0:3b9:b57d:4646 with SMTP id n19-20020a05622a041300b003b9b57d4646mr45134039qtx.18.1676306322110;
        Mon, 13 Feb 2023 08:38:42 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id o5-20020ac80245000000b003b64f1b1f40sm9503620qtg.40.2023.02.13.08.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 08:38:41 -0800 (PST)
Message-ID: <ddd0082ee020165dc84d7e57265cd4e92135c144.camel@ndufresne.ca>
Subject: Re: [EXT] Re: [PATCH v2 02/10] media: Add Y012 video format
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ming Qian <ming.qian@nxp.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 13 Feb 2023 11:38:40 -0500
In-Reply-To: <AM6PR04MB63418F16201148ECB0935A4CE7DD9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <cover.1675230665.git.ming.qian@nxp.com>
         <93889cdefacaad260d978a8353066dd384a64609.1675230665.git.ming.qian@nxp.com>
         <fa6fcd8a905bff34f6d436ef328f5142b72b854c.camel@ndufresne.ca>
         <AM6PR04MB63418F16201148ECB0935A4CE7DD9@AM6PR04MB6341.eurprd04.prod.outlook.com>
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

Le lundi 13 f=C3=A9vrier 2023 =C3=A0 09:22 +0000, Ming Qian a =C3=A9crit=C2=
=A0:
> > From: Nicolas Dufresne <nicolas@ndufresne.ca>
> > Sent: 2023=E5=B9=B42=E6=9C=8810=E6=97=A5 23:18
> > To: Ming Qian <ming.qian@nxp.com>; mchehab@kernel.org; Mirela Rabulea
> > (OSS) <mirela.rabulea@oss.nxp.com>; hverkuil-cisco@xs4all.nl
> > Cc: shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> > festevam@gmail.com; X.H. Bao <xiahong.bao@nxp.com>; dl-linux-imx <linux=
-
> > imx@nxp.com>; linux-media@vger.kernel.org; linux-kernel@vger.kernel.org=
;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Subject: [EXT] Re: [PATCH v2 02/10] media: Add Y012 video format
> >=20
> > Caution: EXT Email
> >=20
> > Le mercredi 01 f=C3=A9vrier 2023 =C3=A0 14:02 +0800, Ming Qian a =C3=A9=
crit :
> > > Y012 is a luma-only formats with 12-bits per pixel, expanded to
> > > 16bits.
> > > Data in the 12 high bits, zeros in the 4 low bits, arranged in little
> > > endian order.
> > >=20
> > > Signed-off-by: Ming Qian <ming.qian@nxp.com>
> > > ---
> > > =C2=A0.../userspace-api/media/v4l/pixfmt-yuv-luma.rst       | 11 ++++=
+++++++
> > > =C2=A0drivers/media/v4l2-core/v4l2-ioctl.c                  |  1 +
> > > =C2=A0include/uapi/linux/videodev2.h                        |  1 +
> > > =C2=A03 files changed, 13 insertions(+)
> > >=20
> > > diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rs=
t
> > > b/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
> > > index 6a387f9df3ba..3ffa29000238 100644
> > > --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
> > > +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
> > > @@ -103,6 +103,17 @@ are often referred to as greyscale formats.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- ...
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- ...
> > >=20
> > > +    * .. _V4L2-PIX-FMT-Y012:
> >=20
> > Why the 0, can't this be name Y12 (just like Y14) ?
> >=20
>=20
> Hi Nicolas,
> =C2=A0=C2=A0=C2=A0=C2=A0As the V4L2_PIX_FMT_Y12 is defined, but it's data=
 is in the 12 low bits,
> zeros in the high bits.
> =C2=A0=C2=A0=C2=A0=C2=A0Here I want to place the 12 bits data in the high=
 bits, with zeros in the
> 4 low bits.
> =C2=A0=C2=A0=C2=A0=C2=A0So I add 0 before 12, I want to say that the low =
bits are padding data 0.
> =C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0Or do you have a better suggestion?

I see, I had missed this aspect. I think in this context, it would be fair
naming. Maybe drop a note in the doc saying just that:

"In contrast to V4L2_PIX_FMT_Y12 format, which have its padding located in =
the
most significant bits of the 16 bit word".

Or something similar.,
Nicolas

>=20
> Ming
>=20
> > > +
> > > +      - ``V4L2_PIX_FMT_Y012``
> > > +      - 'Y012'
> > > +
> > > +      - Y'\ :sub:`0`\ [3:0] `0000`
> > > +      - Y'\ :sub:`0`\ [11:4]
> > > +      - ...
> > > +      - ...
> > > +      - ...
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* .. _V4L2-PIX-FMT-Y14:
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- ``V4L2_PIX_FMT_Y14``
> > > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c
> > > b/drivers/media/v4l2-core/v4l2-ioctl.c
> > > index 067dbdd0a9ef..0ee730aa6cc7 100644
> > > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > > @@ -1303,6 +1303,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdes=
c
> > *fmt)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case V4L2_PIX_FMT_Y6:           d=
escr =3D "6-bit Greyscale"; break;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case V4L2_PIX_FMT_Y10:          d=
escr =3D "10-bit Greyscale"; break;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case V4L2_PIX_FMT_Y12:          d=
escr =3D "12-bit Greyscale"; break;
> > > +     case V4L2_PIX_FMT_Y012:         descr =3D "12-bit Greyscale"; b=
reak;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case V4L2_PIX_FMT_Y14:          d=
escr =3D "14-bit Greyscale"; break;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case V4L2_PIX_FMT_Y16:          d=
escr =3D "16-bit Greyscale"; break;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case V4L2_PIX_FMT_Y16_BE:       d=
escr =3D "16-bit Greyscale BE";
> > > break;
> > > diff --git a/include/uapi/linux/videodev2.h
> > > b/include/uapi/linux/videodev2.h index 5448aa3b7858..3d8f89bff33c
> > > 100644
> > > --- a/include/uapi/linux/videodev2.h
> > > +++ b/include/uapi/linux/videodev2.h
> > > @@ -583,6 +583,7 @@ struct v4l2_pix_format {
> > > =C2=A0#define V4L2_PIX_FMT_Y6      v4l2_fourcc('Y', '0', '6', ' ') /*=
  6=20
> > > Greyscale     */
> > > =C2=A0#define V4L2_PIX_FMT_Y10     v4l2_fourcc('Y', '1', '0', ' ') /*=
 10=20
> > > Greyscale
> > */
> > > =C2=A0#define V4L2_PIX_FMT_Y12     v4l2_fourcc('Y', '1', '2', ' ') /*=
 12=20
> > > Greyscale
> > */
> > > +#define V4L2_PIX_FMT_Y012    v4l2_fourcc('Y', '0', '1', '2') /* 12=
=20
> > > Greyscale
> > */
> > > =C2=A0#define V4L2_PIX_FMT_Y14     v4l2_fourcc('Y', '1', '4', ' ') /*=
 14=20
> > > Greyscale
> > */
> > > =C2=A0#define V4L2_PIX_FMT_Y16     v4l2_fourcc('Y', '1', '6', ' ') /*=
 16=20
> > > Greyscale
> > */
> > > =C2=A0#define V4L2_PIX_FMT_Y16_BE  v4l2_fourcc_be('Y', '1', '6', ' ')=
 /* 16
> > > Greyscale BE  */
>=20

