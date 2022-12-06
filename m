Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED1A644AC3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiLFSDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiLFSDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:03:13 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303E83AC14
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 10:03:11 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id e18so10990029qvs.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 10:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j8CGxi9vT3T3m40r/08kO6b7RCldpWb7Gl7L7zv8B20=;
        b=uddkac2avd9QkSI3+vyAzQqDc8nLAmduBLFJZKMvei74VHCOQ4FT2661Uf/r8SG5Hc
         C2MMZAT2usUgZVglLH3wmSBtIwHUd/uH7Mz+l8P2d9NGNNXIPo8BdG+abTwrpfhbkgqd
         uXS4KnxsU57IDVTBE0Rf0FVxKlcO+oDYgz/yj1m6wDMhzj12vtq/l2JrxzJza+T2D3Os
         s8mZafV8ZUQmyDecmzvXHvlGAIxR1vXSip2nue6vPI0ezDX17ZZ4SbYz5VTLJb42/hzR
         gQHLjqFxGQJy05i5bbh0Iz/GJjJD0Ixrd7N0Lo1+9HM3F1K3kTuGPq/IC9kmFhB2SdWi
         REaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j8CGxi9vT3T3m40r/08kO6b7RCldpWb7Gl7L7zv8B20=;
        b=m4KsZBSGXt7rVTgmZQfdHZGHB25xfYBMTe3ucENeS+kWkFCudaZBdmRMwa+3wr240y
         kGpasAlnLBC7cLcwn5pRx+xnLYmpPbVX6Vz6WV7hu+VHSikxk3a+jM6Fgi7Nmdlv5ikS
         R6G9eDUJYXbL5N9ecw6j8a4tVjNbcbiw5md5Ke75KqsGKWtV348zuOKNoHcN4X5MSj3v
         mUcslUAmOMema7EeL5Nae8TdBuGEkcoNjycClp7Rwmu7RYVHZNPbvRoUEn73F+0MkQDd
         faWkRfUy+kJ5/bQfkO94UlvmkFj+bYMMR8oGIbro7Oh9MuoZpvlOI3pzh38jBCOfcE6f
         elUQ==
X-Gm-Message-State: ANoB5pkDaPEs+5W7F1JZ/dzHqwWZO1HpmugLUAQ3P2ZsySN7qjIRD9j8
        +f7PC0jqrc7xc8/wFZGDGuWaxA==
X-Google-Smtp-Source: AA0mqf6LCePewbco5sIKje93RwFi2duvu0yK4NuN7X6a+lopnudNGGoVFXmPsV9NQWwrIB4Ef/gNxA==
X-Received: by 2002:a0c:fa8c:0:b0:4c7:842:c504 with SMTP id o12-20020a0cfa8c000000b004c70842c504mr34015847qvn.55.1670349790219;
        Tue, 06 Dec 2022 10:03:10 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id bj31-20020a05620a191f00b006ed61f18651sm15362243qkb.16.2022.12.06.10.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 10:03:09 -0800 (PST)
Message-ID: <76febfd703c3eaf312f001a9e952d9cd89449fa7.camel@ndufresne.ca>
Subject: Re: [PATCH V2] [media] v4l2: Add AV1 pixel format
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Hsia-Jun Li <Randy.Li@synaptics.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, hans.verkuil@cisco.com,
        hverkuil-cisco@xs4all.nl, ezequiel@vanguardiasur.com.ar,
        sakari.ailus@linux.intel.com, ribalda@chromium.org,
        stanimir.varbanov@linaro.org, hui.zhang@amlogic.com,
        lele.xiang@amlogic.com, Shi Hao <hao.shi@amlogic.com>,
        laurent.pinchart@ideasonboard.com, nanxin.qin@amlogic.com
Date:   Tue, 06 Dec 2022 13:03:08 -0500
In-Reply-To: <3c634dc4-1b37-1062-203d-f3466d106ad9@synaptics.com>
References: <20220830014032.1245359-1-hao.shi@amlogic.com>
         <b5f4e1cc04ba35d92839932d431726fd42f24320.camel@ndufresne.ca>
         <3c634dc4-1b37-1062-203d-f3466d106ad9@synaptics.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 29 novembre 2022 =C3=A0 18:32 +0800, Hsia-Jun Li a =C3=A9crit=C2=
=A0:
> Hello
>=20
> I think we need to add an extra event for VP9 and AV1 which support=20
> frame scaling, which means its frame width and height could be different=
=20
> to the previous frame or reference frame.
>=20
> That would be more possible for the VP9 as there is not a sequence=20
> header for VP9.

The solution is unlikely in the form of an event, but yes, to complete VP9
support (and improve AV1 support) a mechanism need to be designed and speci=
fied
to handle inter-frame resolution changes.

Why I say improve AV1, this is because VP9 bitstream does not signal SVC sp=
atial
streams (the most common use of inter-frame resolution changes). With SVC
streams, the smaller images are alway decode-only (never displayed). This c=
an be
at least partially supported as long as the maximum image dimension is sign=
alled
by the bitstream. This is the case for AV1, but not VP9.

Stateless decoders are not affected, because userspace is aware of frames b=
eing
decoded, but not displayed. It is also aware that these frames are referenc=
e
frames. While on stateless decoder, userspace usually does not have this
knowledge. I think one way to solve this, would be for drivers to be able t=
o
mark a buffer done, with a flag telling userspace that its not to be displa=
yed.
For the SVC case, the dimensions and stride are irrelevant.

For true inter-resolution changes, like VP9 supports (though rarely used), =
this
needs more APIs. It was suggested to extend CREATE_BUFS, which allow alloca=
tion
with different FMT, with a DELETE_BUFS ioctl, so that userspace can smoothl=
y
handle the allocation transition. For VP9 also, it might be required to sup=
port
super-frame, VP9 supper frames are the ancestor of AV1 TU, and only the las=
t
frame of a super-frame is every to be displayed. A newly introduced AV1 for=
mat
might also requires complete TU, rather then frames, this needs strict
documentation. Decoding frames would mean that un-display and frame of diff=
erent
sizes get delivered, and we don't have a method to communicate these frame
dimension and strides at the moment.

Nicolas



>=20
> On 9/12/22 23:45, Nicolas Dufresne wrote:
> > Hi Shi,
> >=20
> > thanks for the patches, check inline for some comments. Generally speak=
ing, we
> > don't usually add formats ahead of time unless we have a good rationale=
 to do
> > so. Should be expect a companion series against the amlogic decoder dri=
ver that
> > enables this ?
> >=20
> > Le mardi 30 ao=C3=BBt 2022 =C3=A0 09:40 +0800, Shi Hao a =C3=A9crit=C2=
=A0:
> > > From: "hao.shi" <hao.shi@amlogic.com>
> > >=20
> > > Add AV1 compressed pixel format. It is the more common format.
> > >=20
> > > Signed-off-by: Hao Shi <hao.shi@amlogic.com>
> > > ---
> > >   .../userspace-api/media/v4l/pixfmt-compressed.rst        | 9 ++++++=
+++
> > >   drivers/media/v4l2-core/v4l2-ioctl.c                     | 1 +
> > >   include/uapi/linux/videodev2.h                           | 1 +
> > >   3 files changed, 11 insertions(+)
> > >=20
> > > diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.=
rst b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> > > index 506dd3c98884..5bdeeebdf9f5 100644
> > > --- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> > > +++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> > > @@ -232,6 +232,15 @@ Compressed Formats
> > >           Metadata associated with the frame to decode is required to=
 be passed
> > >           through the ``V4L2_CID_STATELESS_FWHT_PARAMS`` control.
> > >   	See the :ref:`associated Codec Control ID <codec-stateless-fwht>`.
> > > +    * .. _V4L2-PIX-FMT-AV1:
> > > +
> > > +      - ``V4L2_PIX_FMT_AV1``
> > > +      - 'AV1'
> > > +      - AV1 Access Unit. The decoder expects one Access Unit per buf=
fer.
> >=20
> > I believe this is using a MPEG LA terminology. Did you mean a Temporal =
Unit (TU)
> > ? In AV1 a TU represent 1 displayable picture, just like AU in H.264 (i=
f you
> > ignore interlaced video).
> I think it should be a complete tile group obu. From the spec, we have=
=20
> the term 'frame'.
>=20
> Currently, AV1 doesn't support interlace.
> >=20
> > > +        The encoder generates one Access Unit per buffer. This forma=
t is
> > > +        adapted for stateful video decoders. AV1 (AOMedia Video 1) i=
s an
> > > +        open video coding format. It was developed as a successor to=
 VP9
> > > +        by the Alliance for Open Media (AOMedia).
> > >  =20
> > >   .. raw:: latex
> > >  =20
> > > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l=
2-core/v4l2-ioctl.c
> > > index c314025d977e..fc0f43228546 100644
> > > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > > @@ -1497,6 +1497,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdes=
c *fmt)
> > >   		case V4L2_PIX_FMT_MT21C:	descr =3D "Mediatek Compressed Format"; =
break;
> > >   		case V4L2_PIX_FMT_QC08C:	descr =3D "QCOM Compressed 8-bit Format"=
; break;
> > >   		case V4L2_PIX_FMT_QC10C:	descr =3D "QCOM Compressed 10-bit Format=
"; break;
> > > +		case V4L2_PIX_FMT_AV1:		descr =3D "AV1"; break;
> > >   		default:
> > >   			if (fmt->description[0])
> > >   				return;
> > > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/vide=
odev2.h
> > > index 01e630f2ec78..c5ea9f38d807 100644
> > > --- a/include/uapi/linux/videodev2.h
> > > +++ b/include/uapi/linux/videodev2.h
> > > @@ -738,6 +738,7 @@ struct v4l2_pix_format {
> > >   #define V4L2_PIX_FMT_FWHT_STATELESS     v4l2_fourcc('S', 'F', 'W', =
'H') /* Stateless FWHT (vicodec) */
> > >   #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* =
H264 parsed slices */
> > >   #define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* =
HEVC parsed slices */
> > > +#define V4L2_PIX_FMT_AV1      v4l2_fourcc('A', 'V', '1', '0') /* AV1=
 */
> > >  =20
> > >   /*  Vendor-specific formats   */
> > >   #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', 'A') /* cp=
ia1 YUV */
> > >=20
> > > base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> >=20
> >=20
>=20

