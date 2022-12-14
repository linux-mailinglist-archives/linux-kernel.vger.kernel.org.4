Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33BE64E7BC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 08:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiLPH3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 02:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiLPH3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 02:29:09 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CBB28704
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 23:29:06 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221216072903epoutp048b4d86296dc5b5c65d8170f34c0d0ed9~xNXwOJo_j1095610956epoutp04j
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:29:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221216072903epoutp048b4d86296dc5b5c65d8170f34c0d0ed9~xNXwOJo_j1095610956epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1671175743;
        bh=ClpMFEkDfw9DMkD5bYy0ucjXGtEAxFMwv/ISi+MvMCE=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=uO7MMDZEJ8HEH2Ji8K99+t4hBe/1js12AJd8A2Px9a2WrUYtIn4TvUO58H/aYP1c9
         Dy/gQLWpKDRh6hMaut/2aNY9BkYzJVT0R4Za42SSMNTVhtpA8m4VfojclfvFuUeqzx
         LlY4ODaLgSDzVv5Hi2hATKJj4yGPUt+fRTk+9cdU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221216072902epcas5p34a73e8bbdde91d6352383ba05765fad5~xNXvYzxU22672526725epcas5p3Y;
        Fri, 16 Dec 2022 07:29:02 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4NYLM112vwz4x9Q7; Fri, 16 Dec
        2022 07:29:01 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.73.01710.C3E1C936; Fri, 16 Dec 2022 16:29:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221214102309epcas5p2cf91fd7020fea2719d1346111dcd4f7e~wodMHDcvs2848628486epcas5p23;
        Wed, 14 Dec 2022 10:23:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221214102309epsmtrp1989683492a8d94c6399f684f779543d7~wodMGCX0E0404404044epsmtrp1V;
        Wed, 14 Dec 2022 10:23:09 +0000 (GMT)
X-AuditID: b6c32a49-a41ff700000006ae-d5-639c1e3c8164
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        37.69.14392.D04A9936; Wed, 14 Dec 2022 19:23:09 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221214102304epsmtip25f3b431f17d9c80b9790ab06e41959a9~wodHw9blq0341703417epsmtip2i;
        Wed, 14 Dec 2022 10:23:04 +0000 (GMT)
From:   "Aakarsh Jain" <aakarsh.jain@samsung.com>
To:     "'Hans Verkuil'" <hverkuil-cisco@xs4all.nl>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     <m.szyprowski@samsung.com>, <andrzej.hajda@intel.com>,
        <mchehab@kernel.org>, <ezequiel@vanguardiasur.com.ar>,
        <jernej.skrabec@gmail.com>, <benjamin.gaignard@collabora.com>,
        <stanimir.varbanov@linaro.org>, <dillon.minfei@gmail.com>,
        <david.plowman@raspberrypi.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>, <andi@etezian.org>,
        <alim.akhtar@samsung.com>, <aswani.reddy@samsung.com>,
        <pankaj.dubey@samsung.com>, <linux-fsd@tesla.com>,
        <smitha.t@samsung.com>
In-Reply-To: <3b85e6ad-e734-8b36-37bf-06b9c560ca92@xs4all.nl>
Subject: RE: [Patch v3 05/15] Documention: v4l: Documentation for VP9 CIDs.
Date:   Wed, 14 Dec 2022 15:52:56 +0530
Message-ID: <000001d90fa6$0ff91470$2feb3d50$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIjXZOHgvokXGuofbg3rWbxTFZEMQHl4WsmAsDEgksBl6lGqq2mhHWw
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0zbVRTHvb9f21/ZZP5WEC7IGDSyCAqlWsoto2Nxc/kxjKKbcWoiNOUn
        EEpb2zJ1mozhwALdGO4ltTDeJmzCeK7DzmFXRnhIhmMQcYXxkgHKeD8GLrYUdP997vl+zzn3
        3JvDxjm5hCc7Ua6hVXKJjMvawmi45f9SoNjbIA1etWDoQUEDC5Usj2FooGSOgcy19QSq6/4e
        Rz+0NDHRJUsnE137ZYiBqh/a1K48KwONXaoEaFzfz0I1wz1MNDjxPrrbaGAh3dV6JvrRYiVQ
        WW8Xhspr1jBUXD9PoPQbFgKdzLBge92oKwVXAGW0lgKqt3QWp67rrQRVYhrHqJqKTBZ1v8fE
        ompLj1PpzY8Z1Om6CkA9ScsnqCxLL4uaq/Gm2hbmiOhtHyaFJ9CSOFrlQ8ulirhEebyYG3Uo
        Zl9MiDCYH8gXoVCuj1ySTIu5+9+MDjyQKLMNz/U5KpGl2ELRErWay9sTrlKkaGifBIVaI+bS
        yjiZUqAMUkuS1Sny+CA5rQnjBwe/GmIzxiYlVHxdiSurIj9fvKglUoEpLAs4sSEpgHXZS8ws
        sIXNIX8CsLZxCbcLHHIWwJyyFxzCIoCtp0bxzYy/Vzoxh+kGgHdWtjpMYwD+cb2FsAsskgcH
        2nTrZV1JI4BFg79i9gNOzuFQm9vBtLucSDFs7EsDdnYho+D8bOl6WQbpB0/OT66zMymCQ2vt
        wMHbYWveCMPOOPkyLC+a3LiSD1wZLV+v6UoegIbhbzGHxx02r+g2PDedYF8qcvB+ePN2JnCw
        C5xoqSMc7AnHczI2WAqHi8c3cmWwynSO4eAI2NRtsDHbVt8fVjXyHOEd8Hxb5UbbbfDU6gjm
        iDtDY8Em74KG+8tMB3vBW5fLwBnA1T81mf6pyfRPTaD/v1shYFQAD1qpTo6n1SFKvpz+7L8P
        lyqSa8D6bgREGoH1wXSQGWBsYAaQjXNdnaNH9VKOc5zki2O0ShGjSpHRajMIsT13Lu75vFRh
        Wy65JoYvEAULhEKhQPSakM91dy47p5VyyHiJhk6iaSWt2szD2E6eqVj6n/fMvMiG1YOZkwOB
        fX2xE0sLIxeo6Zy377g0P/4on3MszKTrmBgtzorNPhTVV62/cDS/6y0xcZojjNA0+nKm3H4P
        ObNr+9m9biJpqPf0J8+uLYqmW8Ndml0W/BqiXvw5553veB6BB4MKyg5PaXMVfhG8orxi8z9s
        uqQ3wGrJm9qhlVejnYfr+v29jhiC7iUvN8xkftWUXqj+JlTUXpo489fx1Irfnok5kfGke2WP
        r/X11S9jvT28BI/ec5UYZ661u/vzC2v3Ffo+7D/fcvmND3Q7X8k27JYZb3eHMcbuvpu2delE
        R2uE69nd5uekF8tnOpu903T+R1a19f2Dpo+v9gyNPfqUy1AnSPgBuEot+Re9nPPtpAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRyG+c45O+dozU7O2KemxqBIRc0o+8q0gohDkYkUhkW29OD9wmZ2
        gdJEW24jokBy5X1amd3mtTTNNY20JM2UonmrZTa6za1UTGtbhf898Lzv+31//GjcOZvnRiek
        ZnCSVHGyiHQkGh6LvPz46sKYNSP5AjRS3ECiiqlxDA1XTBJIW1tPobr+Kzi69uQRD5Xoenio
        sX2MQPc+/rG9hXoCjZfcBmhCNUQizbsBHhr9FIlePrhKIuXdeh66pdNTqHKwF0NVmlkMldeb
        KZT3UEchfUsDQLlnddhWIVtTXAPYJr0asINqE87eV+kptqJlAmM11fkk+3aghWRr1VlsXscM
        wZ6vqwbsXE4Rxcp1gyQ7qfFkuyyTVLhTlOPmWC45IZOTBIQedoy/8zUi/dmO43OzMiobPN4g
        Bw40ZNbBz9M9mBw40s5MM4AKWR9mF8vh/NlOys4CeGNunLKHDAD+NBuBVZBMABzuUvKswoVp
        AbCjucaWwhkZAefzuv5WTH92J0pxa8WBCYEP3uTY6gJmFzSb1Lb3CGYlzDUbbcxnNsKx2W5g
        56XwaeF7wso44wsNrw3/uarMiNv/twJOG6p4VnZhdsCr7y5i9owQdkwr8QtAoFowpVowpVow
        pVpQKQVENXDl0qUpcSnSwPTAVO6Yv1ScIj2aGucfk5aiAbYj8fFuAo3V3/y1AKOBFkAaF7nw
        V64uiHHmx4pPnOQkadGSo8mcVAvcaUIk5L+QP412ZuLEGVwSx6Vzkn8Wox3csrGYoaipDUJ1
        5Wj55bLgoEsaE6sV3Lk8fzyRVCq6M2dqE9OaTx0K37PFzXIvITN+25FV3gWLvVpfjShlUx7s
        mbGEvLpDbW+ecZ/UIaHGD6d9stwjxUFZW0rCgqG+7tzS6/3bvTcP00SSe6/n+hXz+QrfPcSP
        yaFbX6lW151d2d6WqFceggFSFwvD1ua2lZJ7I3zalRVP+uiNu0dHuuP53/cVKWT6IJn5taZk
        f3Twwcwy10RMEl7Oj/QcQjLf543hO3eVHhjGnKKTO2+ojYovnvKHmqifS9bgi063jgr5WMCM
        ZX3ozUa4PdiQtIz267dkOGl/AdNJj76eTZfGOgO+iQhpvDjQB5dIxb8BwjgLi5MDAAA=
X-CMS-MailID: 20221214102309epcas5p2cf91fd7020fea2719d1346111dcd4f7e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221011125155epcas5p1e47309b4dd767e81817c316aa0e8b7ca
References: <20221011122516.32135-1-aakarsh.jain@samsung.com>
        <CGME20221011125155epcas5p1e47309b4dd767e81817c316aa0e8b7ca@epcas5p1.samsung.com>
        <20221011122516.32135-6-aakarsh.jain@samsung.com>
        <3b85e6ad-e734-8b36-37bf-06b9c560ca92@xs4all.nl>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Hans Verkuil =5Bmailto:hverkuil-cisco=40xs4all.nl=5D
> Sent: 24 November 2022 16:54
> To: aakarsh jain <aakarsh.jain=40samsung.com>; linux-arm-
> kernel=40lists.infradead.org; linux-media=40vger.kernel.org; linux-
> kernel=40vger.kernel.org; devicetree=40vger.kernel.org
> Cc: m.szyprowski=40samsung.com; andrzej.hajda=40intel.com;
> mchehab=40kernel.org; ezequiel=40vanguardiasur.com.ar;
> jernej.skrabec=40gmail.com; benjamin.gaignard=40collabora.com;
> stanimir.varbanov=40linaro.org; dillon.minfei=40gmail.com;
> david.plowman=40raspberrypi.com; mark.rutland=40arm.com;
> robh+dt=40kernel.org; krzk+dt=40kernel.org; andi=40etezian.org;
> alim.akhtar=40samsung.com; aswani.reddy=40samsung.com;
> pankaj.dubey=40samsung.com; linux-fsd=40tesla.com; smitha.t=40samsung.com
> Subject: Re: =5BPatch v3 05/15=5D Documention: v4l: Documentation for VP9=
 CIDs.
>=20
> On 11/10/2022 14:25, aakarsh jain wrote:
> > From: Smitha T Murthy <smitha.t=40samsung.com>
> >
> > Adds V4l2 controls for VP9 encoder documention.
> >
> > Cc: linux-fsd=40tesla.com
> > Signed-off-by: Smitha T Murthy <smitha.t=40samsung.com>
> > Signed-off-by: Aakarsh Jain <aakarsh.jain=40samsung.com>
> > ---
> >  .../media/v4l/ext-ctrls-codec.rst             =7C 167 ++++++++++++++++=
++
> >  1 file changed, 167 insertions(+)
> >
> > diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > index 2a165ae063fb..2277d83a7cf0 100644
> > --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > =40=40 -2187,6 +2187,16 =40=40 enum v4l2_mpeg_video_vp8_profile -
> >      * - =60=60V4L2_MPEG_VIDEO_VP8_PROFILE_3=60=60
> >        - Profile 3
> >
> > +VP9 Control Reference
>=20
> This is wrong. There is a VPX Control Reference section for both VP8 and =
VP9
> controls. That's where this should be added. I suspect several of the con=
trols
> you are adding here already exist, e.g.
> V4L2_CID_MPEG_VIDEO_VPX_MIN_QP. The documentation may have to be
> updated to specify that it is for both VP8 and VP9.
>=20
Since MFC has different profiles, different quantization parameter ranges f=
or both VP8 and VP9. So we can't use same control ID's for both.
So for example in VP8 with control ID (V4L2_CID_MPEG_VIDEO_VPX_MIN_QP), QP =
ranges from 0-11 and in VP9 with control ID  (V4L2_CID_CODEC_VP9_MIN_QP) QP=
 ranges from 1-24. So we can't club together into single control.=20

> > +---------------------
> > +
> > +The VP9 controls include controls for encoding parameters of VP9
> > +video codec.
> > +
> > +.. _vp9-control-id:
> > +
> > +VP9 Control IDs
> > +
> >  .. _v4l2-mpeg-video-vp9-profile:
> >
> >  =60=60V4L2_CID_MPEG_VIDEO_VP9_PROFILE=60=60
> > =40=40 -2253,6 +2263,163 =40=40 enum v4l2_mpeg_video_vp9_level -
> >      * - =60=60V4L2_MPEG_VIDEO_VP9_LEVEL_6_2=60=60
> >        - Level 6.2
> >
> > +=60=60V4L2_CID_CODEC_VP9_I_FRAME_QP=60=60
>=20
> If you do need to add new controls, then please use the same
> MPEG_VIDEO_ prefix.
> It's a bit ugly and historical, but let's keep it consistent with the oth=
ers.
>=20
> Regards,
>=20
> 	Hans
>=20
> > +    Quantization parameter for an I frame for VP9. Valid range: from 1=
 to
> 255.
> > +
> > +=60=60V4L2_CID_CODEC_VP9_P_FRAME_QP=60=60
> > +    Quantization parameter for an P frame for VP9. Valid range: from 1=
 to
> 255.
> > +
> > +=60=60V4L2_CID_CODEC_VP9_MAX_QP=60=60
> > +    Maximum quantization parameter for VP9. Valid range: from 1 to 255=
.
> > +    Recommended range for MFC is from 230 to 255.
> > +
> > +=60=60V4L2_CID_CODEC_VP9_MIN_QP=60=60
> > +    Minimum quantization parameter for VP9. Valid range: from 1 to 255=
.
> > +    Recommended range for MFC is from 1 to 24.
> > +
> > +=60=60V4L2_CID_CODEC_VP9_RC_FRAME_RATE=60=60
> > +    Indicates the number of evenly spaced subintervals, called ticks, =
within
> > +    one second. This is a 16 bit unsigned integer and has a maximum va=
lue
> up to
> > +    0xffff and a minimum value of 1.
> > +
> > +=60=60V4L2_CID_CODEC_VP9_GF_REFRESH_PERIOD=60=60
> > +    Indicates the refresh period of the golden frame for VP9 encoder.
> > +
> > +.. _v4l2-vp9-golden-frame-sel:
> > +
> > +=60=60V4L2_CID_CODEC_VP9_GOLDEN_FRAMESEL=60=60
> > +    (enum)
> > +
> > +enum v4l2_mpeg_vp9_golden_framesel -
> > +    Selects the golden frame for encoding. Valid when NUM_OF_REF is 2.
> > +    Possible values are:
> > +
> > +.. raw:: latex
> > +
> > +    =5Cfootnotesize
> > +
> > +.. tabularcolumns:: =7Cp=7B9.0cm=7D=7Cp=7B8.0cm=7D=7C
> > +
> > +.. flat-table::
> > +    :header-rows:  0
> > +    :stub-columns: 0
> > +
> > +    * - =60=60V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_PREV=60=60
> > +      - Use the (n-2)th frame as a golden frame, current frame index b=
eing
> > +        'n'.
> > +    * - =60=60V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_REF_PERIOD=60=60
> > +      - Use the previous specific frame indicated by
> > +        =60=60V4L2_CID_CODEC_VP9_GF_REFRESH_PERIOD=60=60 as a
> > +        golden frame.
> > +
> > +.. raw:: latex
> > +
> > +    =5Cnormalsize
> > +
> > +
> > +=60=60V4L2_CID_CODEC_VP9_HIERARCHY_QP_ENABLE=60=60
> > +    Allows host to specify the quantization parameter values for each
> > +    temporal layer through HIERARCHICAL_QP_LAYER. This is valid only
> > +    if HIERARCHICAL_CODING_LAYER is greater than 1. Setting the contro=
l
> > +    value to 1 enables setting of the QP values for the layers.
> > +
> > +.. _v4l2-vp9-ref-number-of-pframes:
> > +
> > +=60=60V4L2_CID_CODEC_VP9_REF_NUMBER_FOR_PFRAMES=60=60
> > +    (enum)
> > +
> > +enum v4l2_mpeg_vp9_ref_num_for_pframes -
> > +    Number of reference pictures for encoding P frames.
> > +
> > +.. raw:: latex
> > +
> > +    =5Cfootnotesize
> > +
> > +.. tabularcolumns:: =7Cp=7B9.0cm=7D=7Cp=7B8.0cm=7D=7C
> > +
> > +.. flat-table::
> > +    :header-rows:  0
> > +    :stub-columns: 0
> > +
> > +    * - =60=60V4L2_CID_CODEC_VP9_1_REF_PFRAME=60=60
> > +      - Indicates one reference frame, last encoded frame will be sear=
ched.
> > +    * - =60=60V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_REF_PERIOD=60=60
> > +      - Indicates 2 reference frames, last encoded frame and golden fr=
ame
> > +        will be searched.
> > +
> > +.. raw:: latex
> > +
> > +    =5Cnormalsize
> > +
> > +
> > +=60=60V4L2_CID_CODEC_VP9_HIERARCHICAL_CODING_LAYER=60=60
> > +    Indicates the number of hierarchial coding layer.
> > +    In normal encoding (non-hierarchial coding), it should be zero.
> > +    VP9 has upto 3 layer of encoder.
> > +
> > +=60=60V4L2_CID_CODEC_VP9_HIERARCHY_RC_ENABLE=60=60
> > +    Indicates enabling of bit rate for hierarchical coding layers VP9 =
encoder.
> > +
> > +=60=60V4L2_CID_CODEC_VP9_HIER_CODING_L0_BR=60=60
> > +    Indicates bit rate for hierarchical coding layer 0 for VP9 encoder=
.
> > +
> > +=60=60V4L2_CID_CODEC_VP9_HIER_CODING_L1_BR=60=60
> > +    Indicates bit rate for hierarchical coding layer 1 for VP9 encoder=
.
> > +
> > +=60=60V4L2_CID_CODEC_VP9_HIER_CODING_L2_BR=60=60
> > +    Indicates bit rate for hierarchical coding layer 2 for VP9 encoder=
.
> > +
> > +=60=60V4L2_CID_CODEC_VP9_HIER_CODING_L0_QP=60=60
> > +    Indicates quantization parameter for hierarchical coding layer 0.
> > +    Valid range: =5BV4L2_CID_CODEC_VP9_MIN_QP,
> > +    V4L2_CID_CODEC_VP9_MAX_QP=5D.
> > +
> > +=60=60V4L2_CID_CODEC_VP9_HIER_CODING_L1_QP=60=60
> > +    Indicates quantization parameter for hierarchical coding layer 1.
> > +    Valid range: =5BV4L2_CID_CODEC_VP9_MIN_QP,
> > +    V4L2_CID_CODEC_VP9_MAX_QP=5D.
> > +
> > +=60=60V4L2_CID_CODEC_VP9_HIER_CODING_L2_QP=60=60
> > +    Indicates quantization parameter for hierarchical coding layer 2.
> > +    Valid range: =5BV4L2_CID_CODEC_VP9_MIN_QP,
> > +    V4L2_CID_CODEC_VP9_MAX_QP=5D.
> > +
> > +.. _v4l2-vp9-max-partition-depth:
> > +
> > +=60=60V4L2_CID_CODEC_VP9_MAX_PARTITION_DEPTH=60=60
> > +    (enum)
> > +
> > +enum v4l2_mpeg_vp9_num_partitions -
> > +    Indicate maximum coding unit depth.
> > +
> > +.. raw:: latex
> > +
> > +    =5Cfootnotesize
> > +
> > +.. tabularcolumns:: =7Cp=7B9.0cm=7D=7Cp=7B8.0cm=7D=7C
> > +
> > +.. flat-table::
> > +    :header-rows:  0
> > +    :stub-columns: 0
> > +
> > +    * - =60=60V4L2_CID_CODEC_VP9_0_PARTITION=60=60
> > +      - No coding unit partition depth.
> > +    * - =60=60V4L2_CID_CODEC_VP9_1_PARTITION=60=60
> > +      - Allows one coding unit partition depth.
> > +
> > +.. raw:: latex
> > +
> > +    =5Cnormalsize
> > +
> > +
> > +=60=60V4L2_CID_CODEC_VP9_DISABLE_INTRA_PU_SPLIT=60=60
> > +    Zero indicates enable intra NxN PU split.
> > +    One indicates disable intra NxN PU split.
> > +
> > +=60=60V4L2_CID_CODEC_VP9_DISABLE_IVF_HEADER=60=60
> > +    Indicates IVF header generation. Zero indicates enable IVF format.
> > +    One indicates disable IVF format.
> > +
> >
> >  High Efficiency Video Coding (HEVC/H.265) Control Reference
> >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D


