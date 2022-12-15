Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EAB64E243
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 21:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiLOUSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 15:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLOUSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 15:18:16 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC3B3F04C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 12:18:14 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 192so87980ybt.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 12:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sq1wOPmjPdWN6W/hciSBOtnPGyWNfva1VZZEXTV1ooM=;
        b=zd7r4r/4DTi2Dpv9ZxhuahqKm3+DoFA41TTtDnHOAZev+0Yltvff+UycyWXnQ9yK6W
         UdVeIYeAiLQDZ1nd2G3jT/jbhNM2ncgp9gRF+ZdsA//Er3BX5gNtzXDcc8Jxvjifv0/0
         8O0xNWnhmpoPSFqJmfP8imyGd6/Wfyvq5YpinkWDzkEf/NhHTEPRKWrSsYtO0tFwAaRN
         /Lg4jh6RKZJC5FuCg0Q/rlexbs9Fx+LnYJKkUJRnk23+v+k+otbYkG1sGhHOIPhV0Ogv
         kNbZQEVk0f/zcQAnH0Wj8CDdx7gQvflITNJYarNDfPA9Z+bdaMwc0C7OjJp3BZE/ecNf
         ZXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sq1wOPmjPdWN6W/hciSBOtnPGyWNfva1VZZEXTV1ooM=;
        b=dlHpjfM9lDDcA82G1YmnzcgjUkNHoRHvN5pRsjppEpqdmGn//xdVM6DBWxGlNdsoWV
         BHVP/70mii9eArgOqTYou7rwhIlmD8j3Cc57gCK7LDIz+icwp4Bo6J1fjLYN8ZTrGBsZ
         g6N2GlkCIuuiA8Oh/CRUsUcSER9l5uTFkZFkKEjbWc2yH0Buy7gxWr8hvhZqszwg05nw
         om/0XTdZPwdoCEX8om00O5AZ0zdMSzFFOs5GgUSsNhRfrV5n9lRdo4JPFJQTId6W6UWD
         c/Tu1QFDEfEM4WrDwdYzCsStz5f1LkmH3yMc3Cxo6cbV+mUE93CysubnUT9uZyy0yKO1
         E1oQ==
X-Gm-Message-State: ANoB5pnaqi78u3n0PgmIIm46wvB3+2Tjta5dij3itmPuoETt9dn75YhV
        Y72nu3m3/M2tVbwEddx8IoMhXeTFQLICe/Ds
X-Google-Smtp-Source: AA0mqf5LjU1ufZ3pKcQ0gH4GY2D95drqeWfWxr7PeaSsQiaT/WzuSMyG1a8uiemgWyz9We/bIPPe/Q==
X-Received: by 2002:a25:3ca:0:b0:712:feaf:5f0f with SMTP id 193-20020a2503ca000000b00712feaf5f0fmr26626184ybd.14.1671135493373;
        Thu, 15 Dec 2022 12:18:13 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id c25-20020a05620a269900b006cec8001bf4sm12884278qkp.26.2022.12.15.12.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 12:18:12 -0800 (PST)
Message-ID: <943654c448f260e04aaf7157f4edae35ae86fff2.camel@ndufresne.ca>
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
Date:   Thu, 15 Dec 2022 15:18:10 -0500
In-Reply-To: <1480f5a3-700d-9c1a-7e05-b64abc94c9e1@synaptics.com>
References: <20220830014032.1245359-1-hao.shi@amlogic.com>
         <b5f4e1cc04ba35d92839932d431726fd42f24320.camel@ndufresne.ca>
         <3c634dc4-1b37-1062-203d-f3466d106ad9@synaptics.com>
         <76febfd703c3eaf312f001a9e952d9cd89449fa7.camel@ndufresne.ca>
         <07385baa-9e82-9fc8-5cc1-cc1089e87fdb@synaptics.com>
         <a85a5c817cd2a29d6ba592fae75bf9e065d93124.camel@ndufresne.ca>
         <1480f5a3-700d-9c1a-7e05-b64abc94c9e1@synaptics.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 08 d=C3=A9cembre 2022 =C3=A0 10:39 +0800, Hsia-Jun Li a =C3=A9crit=
=C2=A0:
>=20
> On 12/8/22 01:16, Nicolas Dufresne wrote:
> > CAUTION: Email originated externally, do not click links or open attach=
ments unless you recognize the sender and know the content is safe.
> >=20
> >=20
> > Le mercredi 07 d=C3=A9cembre 2022 =C3=A0 15:18 +0800, Hsia-Jun Li a =C3=
=A9crit :
> > >=20
> > > On 12/7/22 02:03, Nicolas Dufresne wrote:
> > > > CAUTION: Email originated externally, do not click links or open at=
tachments unless you recognize the sender and know the content is safe.
> > > >=20
> > > >=20
> > > > Le mardi 29 novembre 2022 =C3=A0 18:32 +0800, Hsia-Jun Li a =C3=A9c=
rit :
> > > > > Hello
> > > > >=20
> > > > > I think we need to add an extra event for VP9 and AV1 which suppo=
rt
> > > > > frame scaling, which means its frame width and height could be di=
fferent
> > > > > to the previous frame or reference frame.
> > > > >=20
> > > > > That would be more possible for the VP9 as there is not a sequenc=
e
> > > > > header for VP9.
> > > >=20
> > > > The solution is unlikely in the form of an event, but yes, to compl=
ete VP9
> > > > support (and improve AV1 support) a mechanism need to be designed a=
nd specified
> > > > to handle inter-frame resolution changes.
> > > >=20
> > > > Why I say improve AV1, this is because VP9 bitstream does not signa=
l SVC spatial
> > > > streams (the most common use of inter-frame resolution changes). Wi=
th SVC
> > > > streams, the smaller images are alway decode-only (never displayed)=
. This can be
>=20
> We expect to get all the result from different layers of a SVC stream.=
=20
> Which layer would be displayed is a user's decision.

This is off reality. Its the conferencing server that measure each particip=
ant
bandwidth and decide how many layers each one should get to avoid overloadi=
ng
the network. The selection happens in compressed domain. Perhaps someone co=
uld
be creative and make-up a use case for what you describe, but this isn't us=
ed in
practice. Adding multi-resolution output requires a massive API additions i=
n
stateful decoders (which this hidden RFC does not cover).

>=20
> 1. golden frame usually would be higher resolution or better quality.=20
> But we would only display frames which are lower resolution.
>=20
> 2. Higher resolution or quality layer would have longer interval, user=
=20
> may just display a lower layer in real time case (like video conference).
>=20
> > > > at least partially supported as long as the maximum image dimension=
 is signalled
> > > > by the bitstream. This is the case for AV1, but not VP9.
> > > >=20
> > > > Stateless decoders are not affected, because userspace is aware of =
frames being
> > > > decoded, but not displayed. It is also aware that these frames are =
reference
> > > > frames. While on stateless decoder, userspace usually does not have=
 this
> > > > knowledge. I think one way to solve this, would be for drivers to b=
e able to
> > > > mark a buffer done, with a flag telling userspace that its not to b=
e displayed.
> > > > For the SVC case, the dimensions and stride are irrelevant.
> > > >=20
> > > > For true inter-resolution changes, like VP9 supports (though rarely=
 used), this
> > > > needs more APIs. It was suggested to extend CREATE_BUFS, which allo=
w allocation
> > > > with different FMT, with a DELETE_BUFS ioctl, so that userspace can=
 smoothly
> > > > handle the allocation transition.
> > > This could only solve the problem of never display graphics buffers
> > > likes golden frame or alternative reference frame.
> > >=20
> > > About the topic timestamp tracking problem in v4l2, maybe we could st=
art
> > > a new thread or move them to Gstreamer.
> > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gitlab.freedes=
ktop.org_gstreamer_gstreamer_-2D_issues_1619&d=3DDwIFaQ&c=3D7dfBJ8cXbWjhc0B=
hImu8wVIoUFmBzj1s88r8EGyM0UY&r=3DP4xb2_7biqBxD4LGGPrSV6j-jf3C3xlR7PXU-mLTeZ=
E&m=3DGL3Q2_6ERpT94we1vI-sUNajRV_t3-lcd8F6DAbXt5EimufjPEa-yTi1-p3EhsCM&s=3D=
KbTA0L42trYmxvVphaiUeDsgUS4e-vm64epfaSgAYH8&e=3D
> > >=20
> > > My idea here is event attached to buffer or just using the new reques=
t
> > > supported in CAPTURE side. I know you worry about the v4l2 event, it =
is
> > > out of band, more event could lead to the problem we suffer from
> > > OpenMAX. If we could have an order between event and buffer, it won't=
 be
> > > a problem.
> > > For VP9 also, it might be required to support
> > > > super-frame, VP9 supper frames are the ancestor of AV1 TU, and only=
 the last
> > > > frame of a super-frame is every to be displayed. A newly introduced=
 AV1 format
> > > > might also requires complete TU, rather then frames, this needs str=
ict
> > > > documentation.
> > > I don't think the temporal unit is a good idea here.
> > > Most of hardware could only decode a frame once or less likes a
> > > tile(likes slice in ITU codecs).
> > >=20
> > > Considering the MPEG-TS case,
> > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__aomediacodec.g=
ithub.io_av1-2Dmpeg2-2Dts_&d=3DDwIFaQ&c=3D7dfBJ8cXbWjhc0BhImu8wVIoUFmBzj1s8=
8r8EGyM0UY&r=3DP4xb2_7biqBxD4LGGPrSV6j-jf3C3xlR7PXU-mLTeZE&m=3DGL3Q2_6ERpT9=
4we1vI-sUNajRV_t3-lcd8F6DAbXt5EimufjPEa-yTi1-p3EhsCM&s=3Df7qIYhe94ooCIv1awc=
cCfSmI-Gq0raAXHRogkCBTB4M&e=3D
> > > Decodable Frame Group could be more a better idea.
> > > Temporal Unit would lead to larger delay.
> >=20
> > This is off topic for the tread, but this one could be fixed by setting=
 a flag
> > on the capture buffer, something like:
> >=20
> >    V4L2_BUF_FLAG_DECODE_ONLY
> >=20
> > That's similar to how it works with other CODEC API. The down side is t=
hat the
> > driver needs to remember if this is a reference frame when userspace qu=
eue back
> > that decode-only frame, so its not overwritten. Userspace is not aware =
of the
> > reference state, hence can't be made responsible. I suspect a lot of th=
e drivers
> > out there uses secondary buffer, meaning the reference are not the CAPT=
URE
> > buffer.=20
> Drivers certainly could allocate its internal buffers. But I believe=20
> Android won't like this idea. They would like you allocate it from=20
> somewhere then import into driver.
>=20
> Besides, when you decode a secure(DRM) stream, you won't want to leak=20
> any data from it. While for those normal stream, you don't want occupt=
=20
> that limitted amount secure memory zone. I would like to let the=20
> userspace control the allocation of those internal buffers.
>=20
> This use case needs to be thought thought too. Perhaps other driver uses
> > internally allocated memory whenever its about to produce a decode only=
, but
> > that seems to require some firmware feature that is likely uncommon. Pl=
ease,
> > make your research, compare various drivers, and propose an API in the =
form of
> > an RFC so we can discuss that independently from this AV1 pixel format =
thread.
> My proposal for solving tracking the timestamp issue is making v4l2=20
> event have order relevant to buffer.
>=20
> It would come after I refresh the v4l2 pix format extend API.
> >=20
> > >=20
> > >    Decoding frames would mean that un-display and frame of different
> > > > sizes get delivered, and we don't have a method to communicate thes=
e frame
> > > > dimension and strides at the moment.
> > > >=20
> > > > Nicolas
> > > >=20
> > > >=20
> > > >=20
> > > > >=20
> > > > > On 9/12/22 23:45, Nicolas Dufresne wrote:
> > > > > > Hi Shi,
> > > > > >=20
> > > > > > thanks for the patches, check inline for some comments. General=
ly speaking, we
> > > > > > don't usually add formats ahead of time unless we have a good r=
ationale to do
> > > > > > so. Should be expect a companion series against the amlogic dec=
oder driver that
> > > > > > enables this ?
> > > > > >=20
> > > > > > Le mardi 30 ao=C3=BBt 2022 =C3=A0 09:40 +0800, Shi Hao a =C3=A9=
crit :
> > > > > > > From: "hao.shi" <hao.shi@amlogic.com>
> > > > > > >=20
> > > > > > > Add AV1 compressed pixel format. It is the more common format=
.
> > > > > > >=20
> > > > > > > Signed-off-by: Hao Shi <hao.shi@amlogic.com>
> > > > > > > ---
> > > > > > >     .../userspace-api/media/v4l/pixfmt-compressed.rst        =
| 9 +++++++++
> > > > > > >     drivers/media/v4l2-core/v4l2-ioctl.c                     =
| 1 +
> > > > > > >     include/uapi/linux/videodev2.h                           =
| 1 +
> > > > > > >     3 files changed, 11 insertions(+)
> > > > > > >=20
> > > > > > > diff --git a/Documentation/userspace-api/media/v4l/pixfmt-com=
pressed.rst b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
> > > > > > > index 506dd3c98884..5bdeeebdf9f5 100644
> > > > > > > --- a/Documentation/userspace-api/media/v4l/pixfmt-compressed=
.rst
> > > > > > > +++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed=
.rst
> > > > > > > @@ -232,6 +232,15 @@ Compressed Formats
> > > > > > >             Metadata associated with the frame to decode is r=
equired to be passed
> > > > > > >             through the ``V4L2_CID_STATELESS_FWHT_PARAMS`` co=
ntrol.
> > > > > > >             See the :ref:`associated Codec Control ID <codec-=
stateless-fwht>`.
> > > > > > > +    * .. _V4L2-PIX-FMT-AV1:
> > > > > > > +
> > > > > > > +      - ``V4L2_PIX_FMT_AV1``
> > > > > > > +      - 'AV1'
> > > > > > > +      - AV1 Access Unit. The decoder expects one Access Unit=
 per buffer.
> > > > > >=20
> > > > > > I believe this is using a MPEG LA terminology. Did you mean a T=
emporal Unit (TU)
> > > > > > ? In AV1 a TU represent 1 displayable picture, just like AU in =
H.264 (if you
> > > > > > ignore interlaced video).
> > > > > I think it should be a complete tile group obu. From the spec, we=
 have
> > > > > the term 'frame'.
> > > > >=20
> > > > > Currently, AV1 doesn't support interlace.
> > > > > >=20
> > > > > > > +        The encoder generates one Access Unit per buffer. Th=
is format is
> > > > > > > +        adapted for stateful video decoders. AV1 (AOMedia Vi=
deo 1) is an
> > > > > > > +        open video coding format. It was developed as a succ=
essor to VP9
> > > > > > > +        by the Alliance for Open Media (AOMedia).
> > > > > > >=20
> > > > > > >     .. raw:: latex
> > > > > > >=20
> > > > > > > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/m=
edia/v4l2-core/v4l2-ioctl.c
> > > > > > > index c314025d977e..fc0f43228546 100644
> > > > > > > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > > > > > > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > > > > > > @@ -1497,6 +1497,7 @@ static void v4l_fill_fmtdesc(struct v4l=
2_fmtdesc *fmt)
> > > > > > >                     case V4L2_PIX_FMT_MT21C:        descr =3D=
 "Mediatek Compressed Format"; break;
> > > > > > >                     case V4L2_PIX_FMT_QC08C:        descr =3D=
 "QCOM Compressed 8-bit Format"; break;
> > > > > > >                     case V4L2_PIX_FMT_QC10C:        descr =3D=
 "QCOM Compressed 10-bit Format"; break;
> > > > > > > +         case V4L2_PIX_FMT_AV1:          descr =3D "AV1"; br=
eak;
> > > > > > >                     default:
> > > > > > >                             if (fmt->description[0])
> > > > > > >                                     return;
> > > > > > > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/li=
nux/videodev2.h
> > > > > > > index 01e630f2ec78..c5ea9f38d807 100644
> > > > > > > --- a/include/uapi/linux/videodev2.h
> > > > > > > +++ b/include/uapi/linux/videodev2.h
> > > > > > > @@ -738,6 +738,7 @@ struct v4l2_pix_format {
> > > > > > >     #define V4L2_PIX_FMT_FWHT_STATELESS     v4l2_fourcc('S', =
'F', 'W', 'H') /* Stateless FWHT (vicodec) */
> > > > > > >     #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6'=
, '4') /* H264 parsed slices */
> > > > > > >     #define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6'=
, '5') /* HEVC parsed slices */
> > > > > > > +#define V4L2_PIX_FMT_AV1      v4l2_fourcc('A', 'V', '1', '0'=
) /* AV1 */
> > > > > > >=20
> > > > > > >     /*  Vendor-specific formats   */
> > > > > > >     #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', =
'A') /* cpia1 YUV */
> > > > > > >=20
> > > > > > > base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> > > > > >=20
> > > > > >=20
> > > > >=20
> > > >=20
> > >=20
> >=20
>=20

