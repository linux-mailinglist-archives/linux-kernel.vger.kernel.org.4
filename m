Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FA565467D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbiLVTXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbiLVTXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:23:45 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A4FEE3C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:23:43 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id jr11so2122569qtb.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qa1MAQnkj/ATNQRkS/5Z8bLxE6iLjX4Tmg9yhdwVXwk=;
        b=tDueJxZ6gleR7f0q4RSWOButQWwwF9Wj2DDOIpyzAOwBXQ3LSLlzwjkLzfnhwiwXaq
         8qULrSKR/YIiTO5H9dARnVsrZlOsTrK6TX6PYCGlGVMXU3vvTVibAqhmyNgXdPrHnqAA
         sgF1j4HfQ544/g7s8+3J3oU4HMqXdwatEXjBamqVAf+2QuP1jOoR4BAAa5FlqEUcPqTb
         PhjBh+aM7p4stDHnUZSokSaxBE5AM740/leefwn3LQY0ybMhqpqQcxOLHS4zZA1GG5Qk
         yK8+cTccz40tKfjIt59FiZwXbSkhZzCPCaPzzYLlUtM4thoDquc4mK6eEFmegQjzbiih
         actw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qa1MAQnkj/ATNQRkS/5Z8bLxE6iLjX4Tmg9yhdwVXwk=;
        b=3AQDIujwsud8G/0/k6JHvI6U3VE3K1U1eSkO097rWA58Bt3q1wa38quSxIZJNCnqbe
         l54bCuzfdm9RfXdMgmdSQhQQCmmipbPZNbRnDojbbAa90fdMtUpVwOooQ/Pz8E18ckk1
         XD0spQEIE6SrZSKqJqUUnK167TUVjfk/4aJtP0IG0PTthvAchohM+zy7ygDrXMS5SAlz
         zU/3KeA+uxFRiR3qDZa3a78mY2ImdUfDdquonF5lX/HGcL3mXoqPjHi8mw639laKY++k
         fcyloSXGZkBgsybjaEzAyTXvUZEK9bvzuARNnzCI6o9VCC/yvsFnEmoS7XkOuyd35bwz
         8mEA==
X-Gm-Message-State: AFqh2koEXjtXaSCq3jPKegN9tHHxNRNTwTZYsPaRNLQr2rUniz5P0BSo
        kE+LFf23r2v2U12ltin0PoHfKw==
X-Google-Smtp-Source: AMrXdXvQliO8R965wT36ePk9rX2V21XgVjS+lRnN8Lzg3w+4ZjB0fVpMuF8VC1R8B+efBYg6AdE3ww==
X-Received: by 2002:ac8:4682:0:b0:3a7:f642:1d35 with SMTP id g2-20020ac84682000000b003a7f6421d35mr9072337qto.56.1671737022559;
        Thu, 22 Dec 2022 11:23:42 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id d19-20020a05620a241300b00704a9942708sm878258qkn.73.2022.12.22.11.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 11:23:41 -0800 (PST)
Message-ID: <5fe052ce0d9fed6dcc49d1feb550479cfacc49c0.camel@ndufresne.ca>
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
        pankaj.dubey@samsung.com, linux-fsd@tesla.com
Date:   Thu, 22 Dec 2022 14:23:39 -0500
In-Reply-To: <000001d91522$823eded0$86bc9c70$@samsung.com>
References: <20221011122516.32135-1-aakarsh.jain@samsung.com>
         <CGME20221011125155epcas5p1e47309b4dd767e81817c316aa0e8b7ca@epcas5p1.samsung.com>
         <20221011122516.32135-6-aakarsh.jain@samsung.com>
         <3b85e6ad-e734-8b36-37bf-06b9c560ca92@xs4all.nl>
         <000001d90fa6$0ff91470$2feb3d50$@samsung.com>
         <238edc4adf7e795b48cb9de98ba6f1efc67f3bfd.camel@ndufresne.ca>
         <000001d91522$823eded0$86bc9c70$@samsung.com>
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

Le mercredi 21 d=C3=A9cembre 2022 =C3=A0 15:26 +0530, Aakarsh Jain a =C3=A9=
crit=C2=A0:
>=20
> > -----Original Message-----
> > From: Nicolas Dufresne [mailto:nicolas@ndufresne.ca]
> > Sent: 16 December 2022 22:51
> > To: Aakarsh Jain <aakarsh.jain@samsung.com>; 'Hans Verkuil' <hverkuil-
> > cisco@xs4all.nl>; linux-arm-kernel@lists.infradead.org; linux-
> > media@vger.kernel.org; linux-kernel@vger.kernel.org;
> > devicetree@vger.kernel.org
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
> > Le mercredi 14 d=C3=A9cembre 2022 =C3=A0 15:52 +0530, Aakarsh Jain a =
=C3=A9crit :
> > >=20
> > > > -----Original Message-----
> > > > From: Hans Verkuil [mailto:hverkuil-cisco@xs4all.nl]
> > > > Sent: 24 November 2022 16:54
> > > > To: aakarsh jain <aakarsh.jain@samsung.com>; linux-arm-
> > > > kernel@lists.infradead.org; linux-media@vger.kernel.org; linux-
> > > > kernel@vger.kernel.org; devicetree@vger.kernel.org
> > > > Cc: m.szyprowski@samsung.com; andrzej.hajda@intel.com;
> > > > mchehab@kernel.org; ezequiel@vanguardiasur.com.ar;
> > > > jernej.skrabec@gmail.com; benjamin.gaignard@collabora.com;
> > > > stanimir.varbanov@linaro.org; dillon.minfei@gmail.com;
> > > > david.plowman@raspberrypi.com; mark.rutland@arm.com;
> > > > robh+dt@kernel.org; krzk+dt@kernel.org; andi@etezian.org;
> > > > alim.akhtar@samsung.com; aswani.reddy@samsung.com;
> > > > pankaj.dubey@samsung.com; linux-fsd@tesla.com;
> > smitha.t@samsung.com
> > > > Subject: Re: [Patch v3 05/15] Documention: v4l: Documentation for V=
P9
> > CIDs.
> > > >=20
> > > > On 11/10/2022 14:25, aakarsh jain wrote:
> > > > > From: Smitha T Murthy <smitha.t@samsung.com>
> > > > >=20
> > > > > Adds V4l2 controls for VP9 encoder documention.
> > > > >=20
> > > > > Cc: linux-fsd@tesla.com
> > > > > Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> > > > > Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> > > > > ---
> > > > >  .../media/v4l/ext-ctrls-codec.rst             | 167 ++++++++++++=
++++++
> > > > >  1 file changed, 167 insertions(+)
> > > > >=20
> > > > > diff --git
> > > > > a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > > > > b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > > > > index 2a165ae063fb..2277d83a7cf0 100644
> > > > > --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > > > > +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > > > > @@ -2187,6 +2187,16 @@ enum v4l2_mpeg_video_vp8_profile -
> > > > >      * - ``V4L2_MPEG_VIDEO_VP8_PROFILE_3``
> > > > >        - Profile 3
> > > > >=20
> > > > > +VP9 Control Reference
> > > >=20
> > > > This is wrong. There is a VPX Control Reference section for both VP=
8
> > > > and VP9 controls. That's where this should be added. I suspect
> > > > several of the controls you are adding here already exist, e.g.
> > > > V4L2_CID_MPEG_VIDEO_VPX_MIN_QP. The documentation may have
> > to be
> > > > updated to specify that it is for both VP8 and VP9.
> > > >=20
> > > Since MFC has different profiles, different quantization parameter ra=
nges
> > for both VP8 and VP9. So we can't use same control ID's for both.
> > > So for example in VP8 with control ID
> > (V4L2_CID_MPEG_VIDEO_VPX_MIN_QP), QP ranges from 0-11 and in VP9
> > with control ID  (V4L2_CID_CODEC_VP9_MIN_QP) QP ranges from 1-24. So
> > we can't club together into single control.
> > >=20
> >=20
> > V4L2_CID_MPEG_VIDEO_VPX_PROFILE has been deprecated, and replace
> > with menu controls. So we now have a
> > V4L2_CID_MPEG_VIDEO_VP8_PROFILE and a
> > V4L2_CID_MPEG_VIDEO_VP9_PROFILE as menues. Newly written drivers
> > should use these. I see that GStreamer notably has never been ported, I=
'll fix
> > it.
> >=20
> > When you implement a driver, the generic uAPI will cover all possible i=
tems,
> > as menus (a integer was an API mistake made in 2011, hence the
> > deprecation). You driver can then select which menu items it support, a=
nd its
> > server at telling userspace what this HW supports. Though, this should =
be no
> > problem if you want to keep the old CID for backward compat, since the
> > range is just totally undefined there.
> >=20
> > For V4L2_CID_MPEG_VIDEO_VPX_MIN_QP (and friends), the doc says
> > "Minimum quantization parameter for VP8.". A bit strange for a supposed=
ly
> > VPX parameter.
> > But its defines in the code as "VPX Minimum QP Value". Clearly somethin=
g to
> > be fixed. There is no VP9 encoder drivers yet in mainline.
> >=20
> > Though, the range for these controls is driver defined. In Venus, for V=
P8:
> >=20
> >=20
> >         v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
> >                 V4L2_CID_MPEG_VIDEO_VPX_MIN_QP, 1, 128, 1, 1);
> >=20
> > It seems to be 1 to 128. While in MFC, it oddly 1 to 11:
> >=20
> >=20
> >         {
> >                 .id =3D V4L2_CID_MPEG_VIDEO_VPX_MIN_QP,
> >                 .type =3D V4L2_CTRL_TYPE_INTEGER,
> >                 .minimum =3D 0,
> >                 .maximum =3D 11,
> >                 .step =3D 1,
> >                 .default_value =3D 0,
> >         },
> >=20
> > While I'm not a huge fan of this, since we all know QP does not scale l=
inearly,
> > this is how it is, and this is kind of part of the kernel API now. So u=
serspace
> > must ask the driver what is the QP range, and adapt. And in your case, =
you
> > should have no issue adding VP9 encoder with a 1 to 24 range (even if t=
his is a
> > bit odd and hw specific).
> >=20
> > Nicolas
> >=20
>=20
> So all controls which I am using in VP9 similar to VPX will implement tha=
t as menu control. Will not touch VPX controls for backward compatibility.
> Also will change all remaining VP9 controls implementation from Integer t=
o menu control.=20
>=20
> Will this be fine ?

I think so, I'd add menu control to the existing VP8 decoder, so that both =
are
supported, but I'd only implement menu controls for newly added formats. Th=
is is
to maintain backward compatibility indeed.

>=20
> >=20
> > > > > +---------------------
> > > > > +
> > > > > +The VP9 controls include controls for encoding parameters of VP9
> > > > > +video codec.
> > > > > +
> > > > > +.. _vp9-control-id:
> > > > > +
> > > > > +VP9 Control IDs
> > > > > +
> > > > >  .. _v4l2-mpeg-video-vp9-profile:
> > > > >=20
> > > > >  ``V4L2_CID_MPEG_VIDEO_VP9_PROFILE``
> > > > > @@ -2253,6 +2263,163 @@ enum v4l2_mpeg_video_vp9_level -
> > > > >      * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_6_2``
> > > > >        - Level 6.2
> > > > >=20
> > > > > +``V4L2_CID_CODEC_VP9_I_FRAME_QP``
> > > >=20
> > > > If you do need to add new controls, then please use the same
> > > > MPEG_VIDEO_ prefix.
> > > > It's a bit ugly and historical, but let's keep it consistent with t=
he others.
> > > >=20
> > > > Regards,
> > > >=20
> > > > 	Hans
> > > >=20
> > > > > +    Quantization parameter for an I frame for VP9. Valid range:
> > > > > + from 1 to
> > > > 255.
> > > > > +
> > > > > +``V4L2_CID_CODEC_VP9_P_FRAME_QP``
> > > > > +    Quantization parameter for an P frame for VP9. Valid range:
> > > > > +from 1 to
> > > > 255.
> > > > > +
> > > > > +``V4L2_CID_CODEC_VP9_MAX_QP``
> > > > > +    Maximum quantization parameter for VP9. Valid range: from 1 =
to
> > 255.
> > > > > +    Recommended range for MFC is from 230 to 255.
> > > > > +
> > > > > +``V4L2_CID_CODEC_VP9_MIN_QP``
> > > > > +    Minimum quantization parameter for VP9. Valid range: from 1 =
to
> > 255.
> > > > > +    Recommended range for MFC is from 1 to 24.
> > > > > +
> > > > > +``V4L2_CID_CODEC_VP9_RC_FRAME_RATE``
> > > > > +    Indicates the number of evenly spaced subintervals, called t=
icks,
> > within
> > > > > +    one second. This is a 16 bit unsigned integer and has a
> > > > > +maximum value
> > > > up to
> > > > > +    0xffff and a minimum value of 1.
> > > > > +
> > > > > +``V4L2_CID_CODEC_VP9_GF_REFRESH_PERIOD``
> > > > > +    Indicates the refresh period of the golden frame for VP9 enc=
oder.
> > > > > +
> > > > > +.. _v4l2-vp9-golden-frame-sel:
> > > > > +
> > > > > +``V4L2_CID_CODEC_VP9_GOLDEN_FRAMESEL``
> > > > > +    (enum)
> > > > > +
> > > > > +enum v4l2_mpeg_vp9_golden_framesel -
> > > > > +    Selects the golden frame for encoding. Valid when NUM_OF_REF=
 is
> > 2.
> > > > > +    Possible values are:
> > > > > +
> > > > > +.. raw:: latex
> > > > > +
> > > > > +    \footnotesize
> > > > > +
> > > > > +.. tabularcolumns:: |p{9.0cm}|p{8.0cm}|
> > > > > +
> > > > > +.. flat-table::
> > > > > +    :header-rows:  0
> > > > > +    :stub-columns: 0
> > > > > +
> > > > > +    * - ``V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_PREV``
> > > > > +      - Use the (n-2)th frame as a golden frame, current frame i=
ndex
> > being
> > > > > +        'n'.
> > > > > +    * - ``V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_REF_PERIOD``
> > > > > +      - Use the previous specific frame indicated by
> > > > > +        ``V4L2_CID_CODEC_VP9_GF_REFRESH_PERIOD`` as a
> > > > > +        golden frame.
> > > > > +
> > > > > +.. raw:: latex
> > > > > +
> > > > > +    \normalsize
> > > > > +
> > > > > +
> > > > > +``V4L2_CID_CODEC_VP9_HIERARCHY_QP_ENABLE``
> > > > > +    Allows host to specify the quantization parameter values for=
 each
> > > > > +    temporal layer through HIERARCHICAL_QP_LAYER. This is valid =
only
> > > > > +    if HIERARCHICAL_CODING_LAYER is greater than 1. Setting the
> > control
> > > > > +    value to 1 enables setting of the QP values for the layers.
> > > > > +
> > > > > +.. _v4l2-vp9-ref-number-of-pframes:
> > > > > +
> > > > > +``V4L2_CID_CODEC_VP9_REF_NUMBER_FOR_PFRAMES``
> > > > > +    (enum)
> > > > > +
> > > > > +enum v4l2_mpeg_vp9_ref_num_for_pframes -
> > > > > +    Number of reference pictures for encoding P frames.
> > > > > +
> > > > > +.. raw:: latex
> > > > > +
> > > > > +    \footnotesize
> > > > > +
> > > > > +.. tabularcolumns:: |p{9.0cm}|p{8.0cm}|
> > > > > +
> > > > > +.. flat-table::
> > > > > +    :header-rows:  0
> > > > > +    :stub-columns: 0
> > > > > +
> > > > > +    * - ``V4L2_CID_CODEC_VP9_1_REF_PFRAME``
> > > > > +      - Indicates one reference frame, last encoded frame will b=
e
> > searched.
> > > > > +    * - ``V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_REF_PERIOD``
> > > > > +      - Indicates 2 reference frames, last encoded frame and gol=
den
> > frame
> > > > > +        will be searched.
> > > > > +
> > > > > +.. raw:: latex
> > > > > +
> > > > > +    \normalsize
> > > > > +
> > > > > +
> > > > > +``V4L2_CID_CODEC_VP9_HIERARCHICAL_CODING_LAYER``
> > > > > +    Indicates the number of hierarchial coding layer.
> > > > > +    In normal encoding (non-hierarchial coding), it should be ze=
ro.
> > > > > +    VP9 has upto 3 layer of encoder.
> > > > > +
> > > > > +``V4L2_CID_CODEC_VP9_HIERARCHY_RC_ENABLE``
> > > > > +    Indicates enabling of bit rate for hierarchical coding layer=
s VP9
> > encoder.
> > > > > +
> > > > > +``V4L2_CID_CODEC_VP9_HIER_CODING_L0_BR``
> > > > > +    Indicates bit rate for hierarchical coding layer 0 for VP9 e=
ncoder.
> > > > > +
> > > > > +``V4L2_CID_CODEC_VP9_HIER_CODING_L1_BR``
> > > > > +    Indicates bit rate for hierarchical coding layer 1 for VP9 e=
ncoder.
> > > > > +
> > > > > +``V4L2_CID_CODEC_VP9_HIER_CODING_L2_BR``
> > > > > +    Indicates bit rate for hierarchical coding layer 2 for VP9 e=
ncoder.
> > > > > +
> > > > > +``V4L2_CID_CODEC_VP9_HIER_CODING_L0_QP``
> > > > > +    Indicates quantization parameter for hierarchical coding lay=
er 0.
> > > > > +    Valid range: [V4L2_CID_CODEC_VP9_MIN_QP,
> > > > > +    V4L2_CID_CODEC_VP9_MAX_QP].
> > > > > +
> > > > > +``V4L2_CID_CODEC_VP9_HIER_CODING_L1_QP``
> > > > > +    Indicates quantization parameter for hierarchical coding lay=
er 1.
> > > > > +    Valid range: [V4L2_CID_CODEC_VP9_MIN_QP,
> > > > > +    V4L2_CID_CODEC_VP9_MAX_QP].
> > > > > +
> > > > > +``V4L2_CID_CODEC_VP9_HIER_CODING_L2_QP``
> > > > > +    Indicates quantization parameter for hierarchical coding lay=
er 2.
> > > > > +    Valid range: [V4L2_CID_CODEC_VP9_MIN_QP,
> > > > > +    V4L2_CID_CODEC_VP9_MAX_QP].
> > > > > +
> > > > > +.. _v4l2-vp9-max-partition-depth:
> > > > > +
> > > > > +``V4L2_CID_CODEC_VP9_MAX_PARTITION_DEPTH``
> > > > > +    (enum)
> > > > > +
> > > > > +enum v4l2_mpeg_vp9_num_partitions -
> > > > > +    Indicate maximum coding unit depth.
> > > > > +
> > > > > +.. raw:: latex
> > > > > +
> > > > > +    \footnotesize
> > > > > +
> > > > > +.. tabularcolumns:: |p{9.0cm}|p{8.0cm}|
> > > > > +
> > > > > +.. flat-table::
> > > > > +    :header-rows:  0
> > > > > +    :stub-columns: 0
> > > > > +
> > > > > +    * - ``V4L2_CID_CODEC_VP9_0_PARTITION``
> > > > > +      - No coding unit partition depth.
> > > > > +    * - ``V4L2_CID_CODEC_VP9_1_PARTITION``
> > > > > +      - Allows one coding unit partition depth.
> > > > > +
> > > > > +.. raw:: latex
> > > > > +
> > > > > +    \normalsize
> > > > > +
> > > > > +
> > > > > +``V4L2_CID_CODEC_VP9_DISABLE_INTRA_PU_SPLIT``
> > > > > +    Zero indicates enable intra NxN PU split.
> > > > > +    One indicates disable intra NxN PU split.
> > > > > +
> > > > > +``V4L2_CID_CODEC_VP9_DISABLE_IVF_HEADER``
> > > > > +    Indicates IVF header generation. Zero indicates enable IVF f=
ormat.
> > > > > +    One indicates disable IVF format.
> > > > > +
> > > > >=20
> > > > >  High Efficiency Video Coding (HEVC/H.265) Control Reference
> > > > >=20
> > > >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > =3D
> > >=20
> > >=20
>=20
>=20
>=20

