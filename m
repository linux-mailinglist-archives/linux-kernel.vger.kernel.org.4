Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C40645FEA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 18:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiLGRR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 12:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiLGRRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 12:17:38 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC93568C7B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 09:16:48 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id r15so13096793qvm.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 09:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d4iOl7eZqF+ReKmlZZVWGMKifDrqJIOG9ZoU4LUD1YE=;
        b=7rOlaE+33OMqCi5q/dGXSf/QD0/wWPGt3+CoKBVlVTWbxe8fo0WdYioW40EPjUVK55
         ngRHEbnUktbfTqPnUZcwDiyKkO30eiBnhrv1rVL7INcyEAsn3wUdoNzoeOPG7iX6M2Nb
         EpEWXaxf1IEOCsKCGHgCJTZSduN4pJyYxcrae/wqahZUp913K49lMCpWg7wOQgvXpMLi
         MLu6wNSPxPMg+0tBqD6oveY67U1czYSfVonPSQsNgDs8wWjok1bLbe+MZNN12r6BUcF/
         qLItyPmCuVjvwvpowGOe/krJg91yTEaDFfHHOpSkDvb9GwUvEboeFmEefWib0DUrSu1d
         xJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d4iOl7eZqF+ReKmlZZVWGMKifDrqJIOG9ZoU4LUD1YE=;
        b=gcWIgHiPYy2p45eC55hpKee8RO4B4DA18E36xVl5u2eeXfApTbUsvZ0NMEyjhY2x6H
         3oLQ/KOvlcr91o8xMVXyzJWRXvbCWG14jMaxm0QY3YOrgBoenOhi8r6nPLIUDQ6EIeVD
         A/Ic4URq9HPX1bgxHiWUDRUuptrDxn5dOWB3d7wiAyGcbvZxiWR+llCjJCitB7ZcDHjx
         yEYIC8/tiNvzxu3Ka29tPYYgBDaSejrc8Re6mfcPsG5dVnCy4Och1DIGO6YS3CbdXmfe
         lHHxkWMpV19G26MxOG0UKy3vET+1wIxVxu9RD/JvbYx94SCagyT7tBM+UqaFwqw7b/QW
         HiPg==
X-Gm-Message-State: ANoB5pkMnFj0rrLHiOZjDnfWYu27sNrDyV3CMpZIMVn77R4BW2ctnQkZ
        uzCQGIzTeQom77rV5b02UJ5rlA==
X-Google-Smtp-Source: AA0mqf69fDbQu7o7uUga1xb5uDeW8SOYSCQyyNmk2RPIU1CO+50x9xVsU9hJ9S0VMm9dPI6uIrlEWw==
X-Received: by 2002:a0c:90c3:0:b0:4c7:e13:6459 with SMTP id p61-20020a0c90c3000000b004c70e136459mr32762993qvp.11.1670433407910;
        Wed, 07 Dec 2022 09:16:47 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id bt12-20020ac8690c000000b003a51e6b6c95sm13777213qtb.14.2022.12.07.09.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 09:16:47 -0800 (PST)
Message-ID: <a85a5c817cd2a29d6ba592fae75bf9e065d93124.camel@ndufresne.ca>
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
Date:   Wed, 07 Dec 2022 12:16:45 -0500
In-Reply-To: <07385baa-9e82-9fc8-5cc1-cc1089e87fdb@synaptics.com>
References: <20220830014032.1245359-1-hao.shi@amlogic.com>
         <b5f4e1cc04ba35d92839932d431726fd42f24320.camel@ndufresne.ca>
         <3c634dc4-1b37-1062-203d-f3466d106ad9@synaptics.com>
         <76febfd703c3eaf312f001a9e952d9cd89449fa7.camel@ndufresne.ca>
         <07385baa-9e82-9fc8-5cc1-cc1089e87fdb@synaptics.com>
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

Le mercredi 07 d=C3=A9cembre 2022 =C3=A0 15:18 +0800, Hsia-Jun Li a =C3=A9c=
rit=C2=A0:
>=20
> On 12/7/22 02:03, Nicolas Dufresne wrote:
> > CAUTION: Email originated externally, do not click links or open attach=
ments unless you recognize the sender and know the content is safe.
> >=20
> >=20
> > Le mardi 29 novembre 2022 =C3=A0 18:32 +0800, Hsia-Jun Li a =C3=A9crit =
:
> > > Hello
> > >=20
> > > I think we need to add an extra event for VP9 and AV1 which support
> > > frame scaling, which means its frame width and height could be differ=
ent
> > > to the previous frame or reference frame.
> > >=20
> > > That would be more possible for the VP9 as there is not a sequence
> > > header for VP9.
> >=20
> > The solution is unlikely in the form of an event, but yes, to complete =
VP9
> > support (and improve AV1 support) a mechanism need to be designed and s=
pecified
> > to handle inter-frame resolution changes.
> >=20
> > Why I say improve AV1, this is because VP9 bitstream does not signal SV=
C spatial
> > streams (the most common use of inter-frame resolution changes). With S=
VC
> > streams, the smaller images are alway decode-only (never displayed). Th=
is can be
> > at least partially supported as long as the maximum image dimension is =
signalled
> > by the bitstream. This is the case for AV1, but not VP9.
> >=20
> > Stateless decoders are not affected, because userspace is aware of fram=
es being
> > decoded, but not displayed. It is also aware that these frames are refe=
rence
> > frames. While on stateless decoder, userspace usually does not have thi=
s
> > knowledge. I think one way to solve this, would be for drivers to be ab=
le to
> > mark a buffer done, with a flag telling userspace that its not to be di=
splayed.
> > For the SVC case, the dimensions and stride are irrelevant.
> >=20
> > For true inter-resolution changes, like VP9 supports (though rarely use=
d), this
> > needs more APIs. It was suggested to extend CREATE_BUFS, which allow al=
location
> > with different FMT, with a DELETE_BUFS ioctl, so that userspace can smo=
othly
> > handle the allocation transition.=20
> This could only solve the problem of never display graphics buffers=20
> likes golden frame or alternative reference frame.
>=20
> About the topic timestamp tracking problem in v4l2, maybe we could start=
=20
> a new thread or move them to Gstreamer.
> https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/1619
>=20
> My idea here is event attached to buffer or just using the new request=
=20
> supported in CAPTURE side. I know you worry about the v4l2 event, it is=
=20
> out of band, more event could lead to the problem we suffer from=20
> OpenMAX. If we could have an order between event and buffer, it won't be=
=20
> a problem.
> For VP9 also, it might be required to support
> > super-frame, VP9 supper frames are the ancestor of AV1 TU, and only the=
 last
> > frame of a super-frame is every to be displayed. A newly introduced AV1=
 format
> > might also requires complete TU, rather then frames, this needs strict
> > documentation.
> I don't think the temporal unit is a good idea here.
> Most of hardware could only decode a frame once or less likes a=20
> tile(likes slice in ITU codecs).
>=20
> Considering the MPEG-TS case,
> https://aomediacodec.github.io/av1-mpeg2-ts/
> Decodable Frame Group could be more a better idea.
> Temporal Unit would lead to larger delay.

This is off topic for the tread, but this one could be fixed by setting a f=
lag
on the capture buffer, something like:

  V4L2_BUF_FLAG_DECODE_ONLY

That's similar to how it works with other CODEC API. The down side is that =
the
driver needs to remember if this is a reference frame when userspace queue =
back
that decode-only frame, so its not overwritten. Userspace is not aware of t=
he
reference state, hence can't be made responsible. I suspect a lot of the dr=
ivers
out there uses secondary buffer, meaning the reference are not the CAPTURE
buffer. This use case needs to be thought thought too. Perhaps other driver=
 uses
internally allocated memory whenever its about to produce a decode only, bu=
t
that seems to require some firmware feature that is likely uncommon. Please=
,
make your research, compare various drivers, and propose an API in the form=
 of
an RFC so we can discuss that independently from this AV1 pixel format thre=
ad.

>=20
>   Decoding frames would mean that un-display and frame of different
> > sizes get delivered, and we don't have a method to communicate these fr=
ame
> > dimension and strides at the moment.
> >=20
> > Nicolas
> >=20
> >=20
> >=20
> > >=20
> > > On 9/12/22 23:45, Nicolas Dufresne wrote:
> > > > Hi Shi,
> > > >=20
> > > > thanks for the patches, check inline for some comments. Generally s=
peaking, we
> > > > don't usually add formats ahead of time unless we have a good ratio=
nale to do
> > > > so. Should be expect a companion series against the amlogic decoder=
 driver that
> > > > enables this ?
> > > >=20
> > > > Le mardi 30 ao=C3=BBt 2022 =C3=A0 09:40 +0800, Shi Hao a =C3=A9crit=
 :
> > > > > From: "hao.shi" <hao.shi@amlogic.com>
> > > > >=20
> > > > > Add AV1 compressed pixel format. It is the more common format.
> > > > >=20
> > > > > Signed-off-by: Hao Shi <hao.shi@amlogic.com>
> > > > > ---
> > > > >    .../userspace-api/media/v4l/pixfmt-compressed.rst        | 9 +=
++++++++
> > > > >    drivers/media/v4l2-core/v4l2-ioctl.c                     | 1 +
> > > > >    include/uapi/linux/videodev2.h                           | 1 +
> > > > >    3 files changed, 11 insertions(+)
> > > > >=20
> > > > > diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compres=
sed.rst b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> > > > > index 506dd3c98884..5bdeeebdf9f5 100644
> > > > > --- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> > > > > +++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> > > > > @@ -232,6 +232,15 @@ Compressed Formats
> > > > >            Metadata associated with the frame to decode is requir=
ed to be passed
> > > > >            through the ``V4L2_CID_STATELESS_FWHT_PARAMS`` control=
.
> > > > >            See the :ref:`associated Codec Control ID <codec-state=
less-fwht>`.
> > > > > +    * .. _V4L2-PIX-FMT-AV1:
> > > > > +
> > > > > +      - ``V4L2_PIX_FMT_AV1``
> > > > > +      - 'AV1'
> > > > > +      - AV1 Access Unit. The decoder expects one Access Unit per=
 buffer.
> > > >=20
> > > > I believe this is using a MPEG LA terminology. Did you mean a Tempo=
ral Unit (TU)
> > > > ? In AV1 a TU represent 1 displayable picture, just like AU in H.26=
4 (if you
> > > > ignore interlaced video).
> > > I think it should be a complete tile group obu. From the spec, we hav=
e
> > > the term 'frame'.
> > >=20
> > > Currently, AV1 doesn't support interlace.
> > > >=20
> > > > > +        The encoder generates one Access Unit per buffer. This f=
ormat is
> > > > > +        adapted for stateful video decoders. AV1 (AOMedia Video =
1) is an
> > > > > +        open video coding format. It was developed as a successo=
r to VP9
> > > > > +        by the Alliance for Open Media (AOMedia).
> > > > >=20
> > > > >    .. raw:: latex
> > > > >=20
> > > > > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media=
/v4l2-core/v4l2-ioctl.c
> > > > > index c314025d977e..fc0f43228546 100644
> > > > > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > > > > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > > > > @@ -1497,6 +1497,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fm=
tdesc *fmt)
> > > > >                    case V4L2_PIX_FMT_MT21C:        descr =3D "Med=
iatek Compressed Format"; break;
> > > > >                    case V4L2_PIX_FMT_QC08C:        descr =3D "QCO=
M Compressed 8-bit Format"; break;
> > > > >                    case V4L2_PIX_FMT_QC10C:        descr =3D "QCO=
M Compressed 10-bit Format"; break;
> > > > > +         case V4L2_PIX_FMT_AV1:          descr =3D "AV1"; break;
> > > > >                    default:
> > > > >                            if (fmt->description[0])
> > > > >                                    return;
> > > > > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/=
videodev2.h
> > > > > index 01e630f2ec78..c5ea9f38d807 100644
> > > > > --- a/include/uapi/linux/videodev2.h
> > > > > +++ b/include/uapi/linux/videodev2.h
> > > > > @@ -738,6 +738,7 @@ struct v4l2_pix_format {
> > > > >    #define V4L2_PIX_FMT_FWHT_STATELESS     v4l2_fourcc('S', 'F', =
'W', 'H') /* Stateless FWHT (vicodec) */
> > > > >    #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4'=
) /* H264 parsed slices */
> > > > >    #define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5'=
) /* HEVC parsed slices */
> > > > > +#define V4L2_PIX_FMT_AV1      v4l2_fourcc('A', 'V', '1', '0') /*=
 AV1 */
> > > > >=20
> > > > >    /*  Vendor-specific formats   */
> > > > >    #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', 'A') =
/* cpia1 YUV */
> > > > >=20
> > > > > base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> > > >=20
> > > >=20
> > >=20
> >=20
>=20

