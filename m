Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446FE64F046
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 18:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbiLPRV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 12:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiLPRVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 12:21:25 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D734730D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 09:21:23 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id m2so2899811vsv.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 09:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2FBdM4o1a+ti6VZvKdo29XWcFolLLNxcu/qJZdBQUc8=;
        b=KGRQ6N0/BQYIgsGICHE/WL8GuBYtTEBuGVmpZUiNWuAYTHt9PuLyuCVWL+MEOj1KCt
         MLGwq+YYuFBm6XXKPh07Ej3MTs/yiET/FoNmzWB8mXIqOUQKC51aocD/Dub0wK/RvCGw
         wEphBRLBJLsriGS4z6tqS/0MU5T+AAZJx21m+sQFUQwdQGQTuxWPHa8X5M6xGp/DJLW/
         hBj8lcIuFZ938UzVgNq/tHgHPW7ghHsxOMCWGdDneWtBOhA5lDt5yqvfVPmt0f73jKDu
         xxGV6FoPMGRKf/84NdavZJcVD/cynwhL/lOnYZ3O8HRPddLdkqUZjZtm+c0joDJO0lIj
         FaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2FBdM4o1a+ti6VZvKdo29XWcFolLLNxcu/qJZdBQUc8=;
        b=PXBLCnly/1jusNsJZhsbiz26NcX/cHEn7XUwa5AB/B4KJLhESlE7XB7U12xYj17FMY
         LXyzD+uUEULA5wB7Ra4CRD0uAIs9Uo5R6o80TiWBrbkuizqAFZ5HBYzAr8qz7l3RQ59y
         V8MXFQfyujFNqZQw4LucqIszPXYYVz+QT+hvpHx5xtuIICmFCrgzbQSND+1YHWi+lPFG
         BYkfSy83F7dEmRNSbYYImy+pSonLbT59imP3AxtJmg1UcjbgrMBDJZaZNSZmfipQv/tI
         9Y/sqEzAeoYH56XbX//7QsCkE17GEFkg38lJEBfEurn3+UnToq2CYdCyvHfLPY3iUNnT
         OeTw==
X-Gm-Message-State: ANoB5plSCxVewKKoe1tsu2d7AJRpeKXjgJTEWAzSDliIlppO8P7ypfM5
        zEHx9BrwM95bHKm9Li1qXbvIkw==
X-Google-Smtp-Source: AA0mqf48u5sX8/OYx/qesecfTP54psXqEUJ6N7JWv9oQObEy9DjAxCb1RFoaPmkrZDm7OehIqNnW6A==
X-Received: by 2002:a67:6d01:0:b0:3aa:8a33:ce9f with SMTP id i1-20020a676d01000000b003aa8a33ce9fmr19391926vsc.3.1671211282051;
        Fri, 16 Dec 2022 09:21:22 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id d16-20020a05620a241000b006ec62032d3dsm1926735qkn.30.2022.12.16.09.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 09:21:21 -0800 (PST)
Message-ID: <238edc4adf7e795b48cb9de98ba6f1efc67f3bfd.camel@ndufresne.ca>
Subject: Re: [Patch v3 05/15] Documention: v4l: Documentation for VP9 CIDs.
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Aakarsh Jain <aakarsh.jain@samsung.com>,
        'Hans Verkuil' <hverkuil-cisco@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        jernej.skrabec@gmail.com, benjamin.gaignard@collabora.com,
        stanimir.varbanov@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, andi@etezian.org,
        alim.akhtar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, linux-fsd@tesla.com, smitha.t@samsung.com
Date:   Fri, 16 Dec 2022 12:21:19 -0500
In-Reply-To: <000001d90fa6$0ff91470$2feb3d50$@samsung.com>
References: <20221011122516.32135-1-aakarsh.jain@samsung.com>
         <CGME20221011125155epcas5p1e47309b4dd767e81817c316aa0e8b7ca@epcas5p1.samsung.com>
         <20221011122516.32135-6-aakarsh.jain@samsung.com>
         <3b85e6ad-e734-8b36-37bf-06b9c560ca92@xs4all.nl>
         <000001d90fa6$0ff91470$2feb3d50$@samsung.com>
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

Le mercredi 14 d=C3=A9cembre 2022 =C3=A0 15:52 +0530, Aakarsh Jain a =C3=A9=
crit=C2=A0:
>=20
> > -----Original Message-----
> > From: Hans Verkuil [mailto:hverkuil-cisco@xs4all.nl]
> > Sent: 24 November 2022 16:54
> > To: aakarsh jain <aakarsh.jain@samsung.com>; linux-arm-
> > kernel@lists.infradead.org; linux-media@vger.kernel.org; linux-
> > kernel@vger.kernel.org; devicetree@vger.kernel.org
> > Cc: m.szyprowski@samsung.com; andrzej.hajda@intel.com;
> > mchehab@kernel.org; ezequiel@vanguardiasur.com.ar;
> > jernej.skrabec@gmail.com; benjamin.gaignard@collabora.com;
> > stanimir.varbanov@linaro.org; dillon.minfei@gmail.com;
> > david.plowman@raspberrypi.com; mark.rutland@arm.com;
> > robh+dt@kernel.org; krzk+dt@kernel.org; andi@etezian.org;
> > alim.akhtar@samsung.com; aswani.reddy@samsung.com;
> > pankaj.dubey@samsung.com; linux-fsd@tesla.com; smitha.t@samsung.com
> > Subject: Re: [Patch v3 05/15] Documention: v4l: Documentation for VP9 C=
IDs.
> >=20
> > On 11/10/2022 14:25, aakarsh jain wrote:
> > > From: Smitha T Murthy <smitha.t@samsung.com>
> > >=20
> > > Adds V4l2 controls for VP9 encoder documention.
> > >=20
> > > Cc: linux-fsd@tesla.com
> > > Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> > > Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> > > ---
> > >  .../media/v4l/ext-ctrls-codec.rst             | 167 ++++++++++++++++=
++
> > >  1 file changed, 167 insertions(+)
> > >=20
> > > diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rs=
t
> > > b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > > index 2a165ae063fb..2277d83a7cf0 100644
> > > --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > > +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > > @@ -2187,6 +2187,16 @@ enum v4l2_mpeg_video_vp8_profile -
> > >      * - ``V4L2_MPEG_VIDEO_VP8_PROFILE_3``
> > >        - Profile 3
> > >=20
> > > +VP9 Control Reference
> >=20
> > This is wrong. There is a VPX Control Reference section for both VP8 an=
d VP9
> > controls. That's where this should be added. I suspect several of the c=
ontrols
> > you are adding here already exist, e.g.
> > V4L2_CID_MPEG_VIDEO_VPX_MIN_QP. The documentation may have to be
> > updated to specify that it is for both VP8 and VP9.
> >=20
> Since MFC has different profiles, different quantization parameter ranges=
 for both VP8 and VP9. So we can't use same control ID's for both.
> So for example in VP8 with control ID (V4L2_CID_MPEG_VIDEO_VPX_MIN_QP), Q=
P ranges from 0-11 and in VP9 with control ID  (V4L2_CID_CODEC_VP9_MIN_QP) =
QP ranges from 1-24. So we can't club together into single control.
>=20

V4L2_CID_MPEG_VIDEO_VPX_PROFILE has been deprecated, and replace with menu
controls. So we now have a V4L2_CID_MPEG_VIDEO_VP8_PROFILE and a
V4L2_CID_MPEG_VIDEO_VP9_PROFILE as menues. Newly written drivers should use
these. I see that GStreamer notably has never been ported, I'll fix it.

When you implement a driver, the generic uAPI will cover all possible items=
, as
menus (a integer was an API mistake made in 2011, hence the deprecation). Y=
ou
driver can then select which menu items it support, and its server at telli=
ng
userspace what this HW supports. Though, this should be no problem if you w=
ant
to keep the old CID for backward compat, since the range is just totally
undefined there.

For V4L2_CID_MPEG_VIDEO_VPX_MIN_QP (and friends), the doc says "Minimum
quantization parameter for VP8.". A bit strange for a supposedly VPX parame=
ter.
But its defines in the code as "VPX Minimum QP Value". Clearly something to=
 be
fixed. There is no VP9 encoder drivers yet in mainline.

Though, the range for these controls is driver defined. In Venus, for VP8:


        v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
                V4L2_CID_MPEG_VIDEO_VPX_MIN_QP, 1, 128, 1, 1);

It seems to be 1 to 128. While in MFC, it oddly 1 to 11:


        {
                .id =3D V4L2_CID_MPEG_VIDEO_VPX_MIN_QP,
                .type =3D V4L2_CTRL_TYPE_INTEGER,
                .minimum =3D 0,
                .maximum =3D 11,
                .step =3D 1,
                .default_value =3D 0,
        },

While I'm not a huge fan of this, since we all know QP does not scale linea=
rly,
this is how it is, and this is kind of part of the kernel API now. So users=
pace
must ask the driver what is the QP range, and adapt. And in your case, you
should have no issue adding VP9 encoder with a 1 to 24 range (even if this =
is a
bit odd and hw specific).

Nicolas


> > > +---------------------
> > > +
> > > +The VP9 controls include controls for encoding parameters of VP9
> > > +video codec.
> > > +
> > > +.. _vp9-control-id:
> > > +
> > > +VP9 Control IDs
> > > +
> > >  .. _v4l2-mpeg-video-vp9-profile:
> > >=20
> > >  ``V4L2_CID_MPEG_VIDEO_VP9_PROFILE``
> > > @@ -2253,6 +2263,163 @@ enum v4l2_mpeg_video_vp9_level -
> > >      * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_6_2``
> > >        - Level 6.2
> > >=20
> > > +``V4L2_CID_CODEC_VP9_I_FRAME_QP``
> >=20
> > If you do need to add new controls, then please use the same
> > MPEG_VIDEO_ prefix.
> > It's a bit ugly and historical, but let's keep it consistent with the o=
thers.
> >=20
> > Regards,
> >=20
> > 	Hans
> >=20
> > > +    Quantization parameter for an I frame for VP9. Valid range: from=
 1 to
> > 255.
> > > +
> > > +``V4L2_CID_CODEC_VP9_P_FRAME_QP``
> > > +    Quantization parameter for an P frame for VP9. Valid range: from=
 1 to
> > 255.
> > > +
> > > +``V4L2_CID_CODEC_VP9_MAX_QP``
> > > +    Maximum quantization parameter for VP9. Valid range: from 1 to 2=
55.
> > > +    Recommended range for MFC is from 230 to 255.
> > > +
> > > +``V4L2_CID_CODEC_VP9_MIN_QP``
> > > +    Minimum quantization parameter for VP9. Valid range: from 1 to 2=
55.
> > > +    Recommended range for MFC is from 1 to 24.
> > > +
> > > +``V4L2_CID_CODEC_VP9_RC_FRAME_RATE``
> > > +    Indicates the number of evenly spaced subintervals, called ticks=
, within
> > > +    one second. This is a 16 bit unsigned integer and has a maximum =
value
> > up to
> > > +    0xffff and a minimum value of 1.
> > > +
> > > +``V4L2_CID_CODEC_VP9_GF_REFRESH_PERIOD``
> > > +    Indicates the refresh period of the golden frame for VP9 encoder=
.
> > > +
> > > +.. _v4l2-vp9-golden-frame-sel:
> > > +
> > > +``V4L2_CID_CODEC_VP9_GOLDEN_FRAMESEL``
> > > +    (enum)
> > > +
> > > +enum v4l2_mpeg_vp9_golden_framesel -
> > > +    Selects the golden frame for encoding. Valid when NUM_OF_REF is =
2.
> > > +    Possible values are:
> > > +
> > > +.. raw:: latex
> > > +
> > > +    \footnotesize
> > > +
> > > +.. tabularcolumns:: |p{9.0cm}|p{8.0cm}|
> > > +
> > > +.. flat-table::
> > > +    :header-rows:  0
> > > +    :stub-columns: 0
> > > +
> > > +    * - ``V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_PREV``
> > > +      - Use the (n-2)th frame as a golden frame, current frame index=
 being
> > > +        'n'.
> > > +    * - ``V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_REF_PERIOD``
> > > +      - Use the previous specific frame indicated by
> > > +        ``V4L2_CID_CODEC_VP9_GF_REFRESH_PERIOD`` as a
> > > +        golden frame.
> > > +
> > > +.. raw:: latex
> > > +
> > > +    \normalsize
> > > +
> > > +
> > > +``V4L2_CID_CODEC_VP9_HIERARCHY_QP_ENABLE``
> > > +    Allows host to specify the quantization parameter values for eac=
h
> > > +    temporal layer through HIERARCHICAL_QP_LAYER. This is valid only
> > > +    if HIERARCHICAL_CODING_LAYER is greater than 1. Setting the cont=
rol
> > > +    value to 1 enables setting of the QP values for the layers.
> > > +
> > > +.. _v4l2-vp9-ref-number-of-pframes:
> > > +
> > > +``V4L2_CID_CODEC_VP9_REF_NUMBER_FOR_PFRAMES``
> > > +    (enum)
> > > +
> > > +enum v4l2_mpeg_vp9_ref_num_for_pframes -
> > > +    Number of reference pictures for encoding P frames.
> > > +
> > > +.. raw:: latex
> > > +
> > > +    \footnotesize
> > > +
> > > +.. tabularcolumns:: |p{9.0cm}|p{8.0cm}|
> > > +
> > > +.. flat-table::
> > > +    :header-rows:  0
> > > +    :stub-columns: 0
> > > +
> > > +    * - ``V4L2_CID_CODEC_VP9_1_REF_PFRAME``
> > > +      - Indicates one reference frame, last encoded frame will be se=
arched.
> > > +    * - ``V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_REF_PERIOD``
> > > +      - Indicates 2 reference frames, last encoded frame and golden =
frame
> > > +        will be searched.
> > > +
> > > +.. raw:: latex
> > > +
> > > +    \normalsize
> > > +
> > > +
> > > +``V4L2_CID_CODEC_VP9_HIERARCHICAL_CODING_LAYER``
> > > +    Indicates the number of hierarchial coding layer.
> > > +    In normal encoding (non-hierarchial coding), it should be zero.
> > > +    VP9 has upto 3 layer of encoder.
> > > +
> > > +``V4L2_CID_CODEC_VP9_HIERARCHY_RC_ENABLE``
> > > +    Indicates enabling of bit rate for hierarchical coding layers VP=
9 encoder.
> > > +
> > > +``V4L2_CID_CODEC_VP9_HIER_CODING_L0_BR``
> > > +    Indicates bit rate for hierarchical coding layer 0 for VP9 encod=
er.
> > > +
> > > +``V4L2_CID_CODEC_VP9_HIER_CODING_L1_BR``
> > > +    Indicates bit rate for hierarchical coding layer 1 for VP9 encod=
er.
> > > +
> > > +``V4L2_CID_CODEC_VP9_HIER_CODING_L2_BR``
> > > +    Indicates bit rate for hierarchical coding layer 2 for VP9 encod=
er.
> > > +
> > > +``V4L2_CID_CODEC_VP9_HIER_CODING_L0_QP``
> > > +    Indicates quantization parameter for hierarchical coding layer 0=
.
> > > +    Valid range: [V4L2_CID_CODEC_VP9_MIN_QP,
> > > +    V4L2_CID_CODEC_VP9_MAX_QP].
> > > +
> > > +``V4L2_CID_CODEC_VP9_HIER_CODING_L1_QP``
> > > +    Indicates quantization parameter for hierarchical coding layer 1=
.
> > > +    Valid range: [V4L2_CID_CODEC_VP9_MIN_QP,
> > > +    V4L2_CID_CODEC_VP9_MAX_QP].
> > > +
> > > +``V4L2_CID_CODEC_VP9_HIER_CODING_L2_QP``
> > > +    Indicates quantization parameter for hierarchical coding layer 2=
.
> > > +    Valid range: [V4L2_CID_CODEC_VP9_MIN_QP,
> > > +    V4L2_CID_CODEC_VP9_MAX_QP].
> > > +
> > > +.. _v4l2-vp9-max-partition-depth:
> > > +
> > > +``V4L2_CID_CODEC_VP9_MAX_PARTITION_DEPTH``
> > > +    (enum)
> > > +
> > > +enum v4l2_mpeg_vp9_num_partitions -
> > > +    Indicate maximum coding unit depth.
> > > +
> > > +.. raw:: latex
> > > +
> > > +    \footnotesize
> > > +
> > > +.. tabularcolumns:: |p{9.0cm}|p{8.0cm}|
> > > +
> > > +.. flat-table::
> > > +    :header-rows:  0
> > > +    :stub-columns: 0
> > > +
> > > +    * - ``V4L2_CID_CODEC_VP9_0_PARTITION``
> > > +      - No coding unit partition depth.
> > > +    * - ``V4L2_CID_CODEC_VP9_1_PARTITION``
> > > +      - Allows one coding unit partition depth.
> > > +
> > > +.. raw:: latex
> > > +
> > > +    \normalsize
> > > +
> > > +
> > > +``V4L2_CID_CODEC_VP9_DISABLE_INTRA_PU_SPLIT``
> > > +    Zero indicates enable intra NxN PU split.
> > > +    One indicates disable intra NxN PU split.
> > > +
> > > +``V4L2_CID_CODEC_VP9_DISABLE_IVF_HEADER``
> > > +    Indicates IVF header generation. Zero indicates enable IVF forma=
t.
> > > +    One indicates disable IVF format.
> > > +
> > >=20
> > >  High Efficiency Video Coding (HEVC/H.265) Control Reference
> > >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D
>=20
>=20

