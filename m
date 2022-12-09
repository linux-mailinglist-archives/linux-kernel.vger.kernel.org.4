Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C0B647E2F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 08:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiLIHBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 02:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiLIHAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 02:00:45 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF10C3F045
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 22:56:51 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221209065647epoutp03840e922aeb63ae31952acc785af601ed~vDakzx0uR1924619246epoutp03N
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 06:56:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221209065647epoutp03840e922aeb63ae31952acc785af601ed~vDakzx0uR1924619246epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670569007;
        bh=7xgoN7fmlpYyrmbmjBt2rGvpXzI2IfOy50WX+DbeYio=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=NZcy46lykBAd5vj6AqhuPBY+NujArsPpuoew5ejsl1PCOzWRWW1OAdtdVhQzhzZUs
         TOvbbIRutHh+T3Yu+NqUsu0SilCwYfDUZFjrgt2mW+WSkNvT+xtP25YQPhH0sCazlD
         Kd4bSdTuYt0FF5Gd18V1M19SnGQGjxFajEs4NDSA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221209065646epcas5p4d6b2b63d9211e35b3bf6cb5264a8b071~vDakbioGd3267032670epcas5p4D;
        Fri,  9 Dec 2022 06:56:46 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NT1z04yCFz4x9Py; Fri,  9 Dec
        2022 06:56:44 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        27.1C.01710.C2CD2936; Fri,  9 Dec 2022 15:56:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221209064957epcas5p358af8d8a8e98fa50100d71b5dfc5ce84~vDUm7IvvQ1421814218epcas5p3W;
        Fri,  9 Dec 2022 06:49:57 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221209064957epsmtrp2d40a3e5e937bf97eff1b0765c1839957~vDUm5-lHG0304603046epsmtrp2d;
        Fri,  9 Dec 2022 06:49:57 +0000 (GMT)
X-AuditID: b6c32a49-c9ffa700000006ae-4b-6392dc2c9c2d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A1.AC.18644.49AD2936; Fri,  9 Dec 2022 15:49:56 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221209064953epsmtip2851a6c7432269f3ff6820f11501a5e1d~vDUju68fG2306323063epsmtip2x;
        Fri,  9 Dec 2022 06:49:53 +0000 (GMT)
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
Date:   Fri, 9 Dec 2022 12:19:52 +0530
Message-ID: <000001d90b9a$7312eeb0$5938cc10$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIjXZOHgvokXGuofbg3rWbxTFZEMQHl4WsmAsDEgksBl6lGqq2egyiA
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTVxjeuff2A0zJXWHjgEJqJ06ZlFagXIggRmKukWxsJjMuy6Bp7wqj
        tF0/ZDATCRMQBjqILFgY5bObqCiFSi2QOT6GMCAjQ1iQCmqRAcE4iht0zq3l4sa/533e9znP
        ed6Tw0a55axAdrpSR2mUEgWf6Y3d7N27J2zfdLlUWPWUR8zW3GQSDWvzCDHT4MSInjYLi2gf
        r0KJbwduMwhj3yiD6PjhIUa0/ubujl2yY8S8sQUQC4b7TML8aIJBPFg8Qfxiq2YSJTcsDOJa
        n51FNE2OIYTJ/Bwh6i2rLCK/u49FnC3oQxJeJ6/WXAWk1d4IyMnGFZS8ZbCzyIauBYQ0Nxcx
        yemJLibZ1niGzO93YeT59mZAvsj7hkUW900ySac5mBx65mQl+3yQcSCNksgoDY9SSlWydKU8
        jn/seMrhlCixUBQmiiGi+TylJJOK4ycmJYcdSVe4w/N5pyQKvZtKlmi1/PD4AxqVXkfx0lRa
        XRyfUssU6ki1QCvJ1OqVcoGS0sWKhML9Ue7B1Iw05+8/Yuq8o5/VLreguaAuthh4sSEeCdcu
        3ADFwJvNxTsBnFu8i9HFCoBDVdeYdOEEcLT3LFIM2BuS8xbco+biNgCXK6X0zDyALyoKgafB
        xMPhzFAJw9Pww60A1j0YQTwFijtReK5smOGZ8sLjoG0qb0Phix+DqyuNiAdj+C54x1aMeTAH
        j4HP175HafwqHLzk2OBR/C1oqltC6RA8uD5n2jjTDz8CrdWlTHrGH/avl6AeY4iPesHSpSkG
        LUiEnR2VTBr7wsWBdhaNA6HzSfcmL4WP6hc2DRTwetdFjMYH4e3xasyzChTfC6/bwmk6CFYM
        tSC0rw8s/cuB0DwHWmte4t2wenpt8wo7YO+VJvAV4Bu2RDNsiWbYEsHwv1stwJpBAKXWZsop
        bZRapKSy/ntxqSrTDDY+R+hRK7DPPhX0AIQNegBko3w/jslUJuVyZJLsHEqjStHoFZS2B0S5
        912GBr4mVbl/l1KXIoqMEUaKxeLImAixiO/Pabp4TsrF5RIdlUFRakrzUoewvQJzEZ9Z3mCS
        6BY3a6xDpr8AyJG5iex35hxNudnD7d8dD3m2eqb1sSV7veV+4upP7/k3CQzs9E8Suh1q4cnp
        XasVSESwzbtQL3d9Prpz3BiYfVKw/eeCX3kffjnwaV3ik8MH/1nuv/eH6ZS1NcQe5Ii9vDIy
        ZrOtIMHlOTvMlXcKfO1FuW+gswNiKWwrIIpq9lUkBMwrOvdfduYPRaeKapOjBekme0pQWX/B
        Q9e2sfg8P06ewfh1hOvNv+8GpOZwC5fWGK4vAviOnafrZKeTruyJ+nim7JVKlzH+EFVy79Ds
        IIzxtchrHv8Zsj12ar0hq2F3/ULuCeP7H719eDhj29S7zlg8lI9p0ySiUFSjlfwLN2rKtaUE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xTZxjH8547mJJjQfuK2zBVidZQQTG8OgEXk3qMiVFi4i2iDRwBpYW0
        wBxGRblpYcQLLPNQAblULfVWLdZaRGrxQgKCGIho7SYSwAsZoBPQ2Flwhm+//G95PjwMLs4i
        A5kkdRqvUSuTpZQvUXdXGhRS3H0yLvToW4T+KqujUNVoH4bcVSMEclyz0Oj6k1Icnbt/h0Tl
        zlYS3Wh8SaCr/V/d9tMuAvWVXwJoQHhBIXNPJ4n+fr0Zddj0FCq8YiHRRaeLRjVd7RgymD9j
        qNLynka59U4auex1AOXkObFVEs5UZgKc1VUNuK7qYZy7Kbhorso+gHFm4zGKe95pp7hr1Ye4
        3KZxgiu6bgTclyNnaE7n7KK4EfNPXPOHEXqD3zbflfF8clIGr1kctcs38dWYiUoVFPvK2zxE
        FqiJ0AGGgWw4LLKwOuDLiFkrgCX1ObQO+HzVf4CevHvf2B9e+NJHT4Z6Aewv/UB6DYpdDN3N
        haTXCGDtADbdMk2kcDafgJ7c5m+VYQALBipwb8WHjYS27iPAy/7sOvh+uBrzMsHOgw9sOsLL
        InY5/DzagE/ydPjw9KsJHWcXwd6nvd/ZcPYNPnnfHDjWa5g4KYBVQKv+d2oyI4FNY4X4ceAv
        TJkSpkwJU6aEKZUKQBjBLD5Vq0pQacNSl6j5X+VapUqbrk6Qx6WozGDiSWQyK7Ab/5E7AMYA
        B4AMLg0QGQwn4sSieOVvmbwmZacmPZnXOsBshpBKRG26hzvFbIIyjd/L86m85n8XY3wCs7Dz
        srH5MQ4yulKuKBqPnovXHkjIuBnsN2SLiBD0QxJ59u148nHio8Gtv7S0m6zP1546168w1xmd
        y9DVTe5P+14Gzxl8c6p2QeSayu6OtuTtcFqDJDNm0G9gRrj6RMqM0OIQY9rqy9ujHIraP3u2
        BB8THYKazKGNB1fZfhxOqi/Js0Q1Rv9x+CT0qFL6PZYVh2eSMZKC/NhS8/2mZU/IkbN7nrmz
        9WF6kdr8b1C6PWRJsJ1//M7NtGwqEAcEla0XQhbciDARffVvZek585eWDC4cb40cbVxb88kn
        sGd914uK4/s7f/Z05GRXnmnp+KgyTD+w8WBs8e58fXgrId0Rm9EQKiW0icowGa7RKv8DM+sk
        DJMDAAA=
X-CMS-MailID: 20221209064957epcas5p358af8d8a8e98fa50100d71b5dfc5ce84
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
        autolearn=ham autolearn_force=no version=3.4.6
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
okay. I will add all VP9 Control IDs in VPX Control reference section.
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
But initially you recommended to use CODEC instead of MPEG_VIDEO.
https://patchwork.kernel.org/project/linux-media/patch/20220517125548.14746=
-7-smitha.t=40samsung.com/

Anyway I will rename from CODEC to MPEG_VIDEO again.

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
Thanks for the review.


