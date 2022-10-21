Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE11B60771A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 14:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiJUMk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 08:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJUMki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 08:40:38 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA38F6177A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 05:40:20 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221021123946epoutp04e94405054360e44ce248dcb56e21bebe~gFfD5f3R01691516915epoutp04n
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 12:39:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221021123946epoutp04e94405054360e44ce248dcb56e21bebe~gFfD5f3R01691516915epoutp04n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1666355986;
        bh=YfJb8DPCQmdsvtdp624Ktcdy6+mh/872BbqznrsQFxU=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=KBnFRWy3Nb8V359xKNEN1wvHJ3har8TNkzfhETYBTkcJPt1Gi+ukb7woF25bbpyjY
         ZntSfBirKE++KH0gcbvxIdJm/PPzBflIyx3itj8MeOpoy3ocZ9NKasrQz6nCUdYvIK
         H7aRtU1orgw8lGEDu472DZEUFIc1aztplcbW+GOc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221021123946epcas5p39f732b32bc22f61eb0d3ba97eb3ef805~gFfDRa0522308023080epcas5p3B;
        Fri, 21 Oct 2022 12:39:46 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Mv3vM5vH8z4x9Pv; Fri, 21 Oct
        2022 12:39:43 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FA.DB.39477.F0392536; Fri, 21 Oct 2022 21:39:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221021052633epcas5p217cbdacbc132ba33ed58ab3b2bbe29e7~f-k0J_svB1999119991epcas5p2M;
        Fri, 21 Oct 2022 05:26:33 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221021052633epsmtrp22a9962d00ae83afe70d0dc48fdb743ef~f-k0ItR8v2478624786epsmtrp2d;
        Fri, 21 Oct 2022 05:26:33 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-0f-6352930f4747
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.9D.18644.98D22536; Fri, 21 Oct 2022 14:26:33 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221021052627epsmtip23239d69069a19941a4ff09bab7394e0f~f-kufpEJa2441424414epsmtip2M;
        Fri, 21 Oct 2022 05:26:27 +0000 (GMT)
From:   "Aakarsh Jain" <aakarsh.jain@samsung.com>
To:     "'Nicolas Dufresne'" <nicolas@ndufresne.ca>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     <m.szyprowski@samsung.com>, <andrzej.hajda@intel.com>,
        <mchehab@kernel.org>, <hverkuil-cisco@xs4all.nl>,
        <ezequiel@vanguardiasur.com.ar>, <jernej.skrabec@gmail.com>,
        <benjamin.gaignard@collabora.com>, <stanimir.varbanov@linaro.org>,
        <dillon.minfei@gmail.com>, <david.plowman@raspberrypi.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <andi@etezian.org>, <alim.akhtar@samsung.com>,
        <aswani.reddy@samsung.com>, <pankaj.dubey@samsung.com>,
        <linux-fsd@tesla.com>, <smitha.t@samsung.com>
In-Reply-To: <1f3b8e326d64810999e1430da56fbe2f3efc0a91.camel@ndufresne.ca>
Subject: RE: [Patch v3 05/15] Documention: v4l: Documentation for VP9 CIDs.
Date:   Fri, 21 Oct 2022 10:56:26 +0530
Message-ID: <017901d8e50d$aebe1ce0$0c3a56a0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIjXZOHgvokXGuofbg3rWbxTFZEMQHl4WsmAsDEgksCHqqNhK1NNIqA
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbVRzHd+697S3EjiugOxI3mqsYYBQoK91hgjgZ5MoWJHPRZAZrU66A
        QNu0sAl/8FAwGTAne5i1IM8OE8azUMYzgY6HIz6G8shGYRuwMAbWjaIDBostBeW/z+/5Pb/f
        yY+Hu1aSHrwkRRqrVshSaK4z0XbTx1vocumkPHBwxhfdL2vjourVeQzdq7YSyNRiJFHraAmO
        fhzq5aDy/l856EbfDIGaH9miI9opAs2XNwC0oJvmIsPsOAc9ePwx+qOzlIuKmowcVN8/RaJr
        EyMYqjFsYGh5uANHVcYVEuX39JNoqrsNoLxv+rF3IVNXVgeY9ik9YCb0yzjToZsimeruBYwx
        1J7jMubxbi7Tos9mWh4V4kz+wDrBfNtaC5gXX/1AMgX9E1zGajjADP9tJWNdTieHJrKyeFYt
        YBVyZXySIiGMPv6hNEIaLAkUCUUh6DAtUMhS2TD62IlYYVRSim0XtOCMLCXd5oqVaTR0wDuh
        amV6GitIVGrSwmhWFZ+iEqv8NbJUTboiwV/Bph0RBQYGBdsSP0tOHF+MVGnlX1rKXuA5YENa
        AJx4kBLDcmszKADOPFeqC8DJnCGOw1gG8Je8TsJhWAHcrG0ld0q6R25jjkAngM+MHdv18wCO
        WnJxexaXCoD3hou2erlT7QBau4yk3cCpCwR8fuf7rV5OVDTMz+0FdnajjsOVZT1mZ4LygrOD
        Jo6d+VQIrDhn2OaX4S3tHGFnnDoIayoXccebBHDtYc1WjjsVBS9OPyUdOfvgwFoRbheG1F0n
        +PtivU2MZzOOwRpjlKPWDT4e2pnNA1otPVwHy+Fs1cJ2/xTY2H2ZcHA47B0tJextcMoHNnYG
        ONz74ZXhBswhuxeefz6HOfx82F62w2/BUvMqx8Gvw5vXr4HvAK3bNZlu12S6XRPo/lerAEQt
        eI1VaVITWE2wKkjBnv3vx+XKVAPYuhXf6Hbw4P4TfxPAeMAEIA+n3fko66TclR8vy8hk1Uqp
        Oj2F1ZhAsG3dxbjHK3Kl7dgUaVKROCRQLJFIxCGHJCJ6H7/6qq/clUqQpbHJLKti1Tt1GM/J
        IweLa7zN8Q7tWv8zY4b2sijzxq8c+ugfl+JwXfzIJ60TdxcVnvj6Un3hqwoyeVLlcrjp/WeZ
        Wd5W84qEauBE5obFeM7HTbpNyqqWCoRvrp0yxvCLKmXcn78eLz7jZzbuuUQAvwMnzLecBwXV
        YwtXdbmLm3s5CT7SC7FB+s9Pr0YcFYo9tW6mvt+C6t44dZbHey9LED5zfiUTHWneKLxjzp7O
        LZm2rAqfxNA/DZEHtYTekENHYBb4UmTrnuy4Gxnavz4YbEGX/XoGirl4iVd36WCfZGxpfswn
        sOHhfktXRnzS2xYqMidmdG5Tb3b+NNplvvrpxmqJ8ej1tS9Qk6ZC3EUTmkSZyBdXa2T/AmPg
        ElG0BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZdlhJXrdTNyjZ4OIrY4sH87axWSz+8ZzJ
        4v7izywWhzZvZbfYcmU2s8Xy4wdYLeYfOcdqsf3gIxaLjS+Ashdn3mWxeD5/HaPFy1n32Cw2
        Pb7GavHwVbjF5V1z2Cx6NmxltVh75C67xdLrF5kslm36w2Tx6dROZotFW7+wW7TuPcJucXfP
        NkaLlrYjTA4SHmvmrWH02HF3CaPH9SWfmD12zrrL7rF4z0smj02rOtk87lzbw+axeUm9x+YX
        3cwerUd/sXj0bVnF6PGvaS67R9eR62wenzfJeZz6+pk9gD+KyyYlNSezLLVI3y6BK6PxzCLG
        ggnOFQcXLGFuYLxj0sXIySEhYCKx5+IFJhBbSGAHo8TCTjmIuIzE/7Zj7BC2sMTKf8+BbC6g
        mqeMEtvWbmABSbAJ6EvcP9XDCpIQEdjDKLF8+y42EIdZYCmLxJXl11khWv4zSly8Og+shVPA
        S6K18QAjiC0s4C3x5dMSsN0sAqoSj48dYgWxeQUsJRZ0boKyBSVOznwC1sssoC3x9OZTOHvZ
        wtfMEPcpSPx8ugysXkTATWLSvY/sEDXiEkd/9jBPYBSehWTULCSjZiEZNQtJywJGllWMkqkF
        xbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMHJRUtrB+OeVR/0DjEycTAeYpTgYFYS4S14F5As
        xJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA9PiJVo3VjDc
        4T9oOMfr0PKDEk4Lqz3F2yNFJ8qmWZ1aJrNm9XGh4DMzPMXuZ7i9fsLzMof76t+kYveABVy3
        V0oIHd/88j7/smOyr+tXPbstyv71uCjrfxW+vDJ97k0d2R0Fr38s8L/R6dA6N/j+Zp3fH17a
        rOS6/PD+v+QDFjNPBGh4hxafaz2XWvD2cf/GtQWBfmVmYn7z+Tn+mqza9reTvX+/sfDpOr3K
        aR3pyRXnnh6XvHvWpEE3a8vCM1KLxa6IN/2et/Pwz2ZF//+GwtXPY497m3/YYMBhsLFy1659
        T6cun/ks1VP9JAeD/ostrSLhpxeWLy32DzziPOWubipbXltl506Xp36aARpPQi8psRRnJBpq
        MRcVJwIAQlKJe50DAAA=
X-CMS-MailID: 20221021052633epcas5p217cbdacbc132ba33ed58ab3b2bbe29e7
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
        <1f3b8e326d64810999e1430da56fbe2f3efc0a91.camel@ndufresne.ca>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Nicolas Dufresne =5Bmailto:nicolas=40ndufresne.ca=5D
> Sent: 18 October 2022 20:36
> To: aakarsh jain <aakarsh.jain=40samsung.com>; linux-arm-
> kernel=40lists.infradead.org; linux-media=40vger.kernel.org; linux-
> kernel=40vger.kernel.org; devicetree=40vger.kernel.org
> Cc: m.szyprowski=40samsung.com; andrzej.hajda=40intel.com;
> mchehab=40kernel.org; hverkuil-cisco=40xs4all.nl;
> ezequiel=40vanguardiasur.com.ar; jernej.skrabec=40gmail.com;
> benjamin.gaignard=40collabora.com; stanimir.varbanov=40linaro.org;
> dillon.minfei=40gmail.com; david.plowman=40raspberrypi.com;
> mark.rutland=40arm.com; robh+dt=40kernel.org; krzk+dt=40kernel.org;
> andi=40etezian.org; alim.akhtar=40samsung.com; aswani.reddy=40samsung.com=
;
> pankaj.dubey=40samsung.com; linux-fsd=40tesla.com; smitha.t=40samsung.com
> Subject: Re: =5BPatch v3 05/15=5D Documention: v4l: Documentation for VP9=
 CIDs.
>=20
> Hi,
>=20
> thanks for your patch, very minor comment below.
>=20
> Le mardi 11 octobre 2022 =C3=A0=2017:55=20+0530,=20aakarsh=20jain=20a=20=
=C3=A9crit=20:=0D=0A>=20>=20From:=20Smitha=20T=20Murthy=20<smitha.t=40samsu=
ng.com>=0D=0A>=20>=0D=0A>=20>=20Adds=20V4l2=20controls=20for=20VP9=20encode=
r=20documention.=0D=0A>=20>=0D=0A>=20>=20Cc:=20linux-fsd=40tesla.com=0D=0A>=
=20>=20Signed-off-by:=20Smitha=20T=20Murthy=20<smitha.t=40samsung.com>=0D=
=0A>=20>=20Signed-off-by:=20Aakarsh=20Jain=20<aakarsh.jain=40samsung.com>=
=0D=0A>=20>=20---=0D=0A>=20>=20=20.../media/v4l/ext-ctrls-codec.rst=20=20=
=20=20=20=20=20=20=20=20=20=20=20=7C=20167=20++++++++++++++++++=0D=0A>=20>=
=20=201=20file=20changed,=20167=20insertions(+)=0D=0A>=20>=0D=0A>=20>=20dif=
f=20--git=20a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst=0D=
=0A>=20>=20b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst=0D=
=0A>=20>=20index=202a165ae063fb..2277d83a7cf0=20100644=0D=0A>=20>=20---=20a=
/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst=0D=0A>=20>=20+++=
=20b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst=0D=0A>=20>=
=20=40=40=20-2187,6=20+2187,16=20=40=40=20enum=20v4l2_mpeg_video_vp8_profil=
e=20-=0D=0A>=20>=20=20=20=20=20=20*=20-=20=60=60V4L2_MPEG_VIDEO_VP8_PROFILE=
_3=60=60=0D=0A>=20>=20=20=20=20=20=20=20=20-=20Profile=203=0D=0A>=20>=0D=0A=
>=20>=20+VP9=20Control=20Reference=0D=0A>=20>=20+---------------------=0D=
=0A>=20>=20+=0D=0A>=20>=20+The=20VP9=20controls=20include=20controls=20for=
=20encoding=20parameters=20of=20VP9=0D=0A>=20>=20+video=20codec.=0D=0A>=20>=
=20+=0D=0A>=20>=20+..=20_vp9-control-id:=0D=0A>=20>=20+=0D=0A>=20>=20+VP9=
=20Control=20IDs=0D=0A>=20>=20+=0D=0A>=20>=20=20..=20_v4l2-mpeg-video-vp9-p=
rofile:=0D=0A>=20>=0D=0A>=20>=20=20=60=60V4L2_CID_MPEG_VIDEO_VP9_PROFILE=60=
=60=0D=0A>=20>=20=40=40=20-2253,6=20+2263,163=20=40=40=20enum=20v4l2_mpeg_v=
ideo_vp9_level=20-=0D=0A>=20>=20=20=20=20=20=20*=20-=20=60=60V4L2_MPEG_VIDE=
O_VP9_LEVEL_6_2=60=60=0D=0A>=20>=20=20=20=20=20=20=20=20-=20Level=206.2=0D=
=0A>=20>=0D=0A>=20>=20+=60=60V4L2_CID_CODEC_VP9_I_FRAME_QP=60=60=0D=0A>=20>=
=20+=20=20=20=20Quantization=20parameter=20for=20an=20I=20frame=20for=20VP9=
.=20Valid=20range:=20from=201=20to=0D=0A>=20255.=0D=0A>=20>=20+=0D=0A>=20>=
=20+=60=60V4L2_CID_CODEC_VP9_P_FRAME_QP=60=60=0D=0A>=20>=20+=20=20=20=20Qua=
ntization=20parameter=20for=20an=20P=20frame=20for=20VP9.=20Valid=20range:=
=20from=201=20to=0D=0A>=20255.=0D=0A>=20>=20+=0D=0A>=20>=20+=60=60V4L2_CID_=
CODEC_VP9_MAX_QP=60=60=0D=0A>=20>=20+=20=20=20=20Maximum=20quantization=20p=
arameter=20for=20VP9.=20Valid=20range:=20from=201=20to=20255.=0D=0A>=20>=20=
+=20=20=20=20Recommended=20range=20for=20MFC=20is=20from=20230=20to=20255.=
=0D=0A>=20=0D=0A>=20We=20don't=20usually=20want=20every=20single=20HW=20to=
=20be=20documented=20in=20the=20generic=20part=0D=0A>=20of=20the=20document=
ation.=20The=20range=20supported=20by=20the=20HW=20should=20be=20found=20at=
=0D=0A>=20run-time=20I=20suppose,=20by=20querying=20the=20control.=20Would=
=20that=20work=20for=20you=20to=0D=0A>=20remove=20the=20MFC=20specifics=20h=
ere=20and=20in=20other=20controls=20?=0D=0A>=20=0D=0Aok.=20will=20remove=20=
it=20in=20next=20series.=0D=0A>=20>=20+=0D=0A>=20>=20+=60=60V4L2_CID_CODEC_=
VP9_MIN_QP=60=60=0D=0A>=20>=20+=20=20=20=20Minimum=20quantization=20paramet=
er=20for=20VP9.=20Valid=20range:=20from=201=20to=20255.=0D=0A>=20>=20+=20=
=20=20=20Recommended=20range=20for=20MFC=20is=20from=201=20to=2024.=0D=0A>=
=20>=20+=0D=0A>=20>=20+=60=60V4L2_CID_CODEC_VP9_RC_FRAME_RATE=60=60=0D=0A>=
=20>=20+=20=20=20=20Indicates=20the=20number=20of=20evenly=20spaced=20subin=
tervals,=20called=20ticks,=20within=0D=0A>=20>=20+=20=20=20=20one=20second.=
=20This=20is=20a=2016=20bit=20unsigned=20integer=20and=20has=20a=20maximum=
=20value=0D=0A>=20up=20to=0D=0A>=20>=20+=20=20=20=200xffff=20and=20a=20mini=
mum=20value=20of=201.=0D=0A>=20>=20+=0D=0A>=20>=20+=60=60V4L2_CID_CODEC_VP9=
_GF_REFRESH_PERIOD=60=60=0D=0A>=20>=20+=20=20=20=20Indicates=20the=20refres=
h=20period=20of=20the=20golden=20frame=20for=20VP9=20encoder.=0D=0A>=20>=20=
+=0D=0A>=20>=20+..=20_v4l2-vp9-golden-frame-sel:=0D=0A>=20>=20+=0D=0A>=20>=
=20+=60=60V4L2_CID_CODEC_VP9_GOLDEN_FRAMESEL=60=60=0D=0A>=20>=20+=20=20=20=
=20(enum)=0D=0A>=20>=20+=0D=0A>=20>=20+enum=20v4l2_mpeg_vp9_golden_framesel=
=20-=0D=0A>=20>=20+=20=20=20=20Selects=20the=20golden=20frame=20for=20encod=
ing.=20Valid=20when=20NUM_OF_REF=20is=202.=0D=0A>=20>=20+=20=20=20=20Possib=
le=20values=20are:=0D=0A>=20>=20+=0D=0A>=20>=20+..=20raw::=20latex=0D=0A>=
=20>=20+=0D=0A>=20>=20+=20=20=20=20=5Cfootnotesize=0D=0A>=20>=20+=0D=0A>=20=
>=20+..=20tabularcolumns::=20=7Cp=7B9.0cm=7D=7Cp=7B8.0cm=7D=7C=0D=0A>=20>=
=20+=0D=0A>=20>=20+..=20flat-table::=0D=0A>=20>=20+=20=20=20=20:header-rows=
:=20=200=0D=0A>=20>=20+=20=20=20=20:stub-columns:=200=0D=0A>=20>=20+=0D=0A>=
=20>=20+=20=20=20=20*=20-=20=60=60V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_PREV=
=60=60=0D=0A>=20>=20+=20=20=20=20=20=20-=20Use=20the=20(n-2)th=20frame=20as=
=20a=20golden=20frame,=20current=20frame=20index=20being=0D=0A>=20>=20+=20=
=20=20=20=20=20=20=20'n'.=0D=0A>=20>=20+=20=20=20=20*=20-=20=60=60V4L2_CID_=
CODEC_VP9_GOLDEN_FRAME_USE_REF_PERIOD=60=60=0D=0A>=20>=20+=20=20=20=20=20=
=20-=20Use=20the=20previous=20specific=20frame=20indicated=20by=0D=0A>=20>=
=20+=20=20=20=20=20=20=20=20=60=60V4L2_CID_CODEC_VP9_GF_REFRESH_PERIOD=60=
=60=20as=20a=0D=0A>=20>=20+=20=20=20=20=20=20=20=20golden=20frame.=0D=0A>=
=20>=20+=0D=0A>=20>=20+..=20raw::=20latex=0D=0A>=20>=20+=0D=0A>=20>=20+=20=
=20=20=20=5Cnormalsize=0D=0A>=20>=20+=0D=0A>=20>=20+=0D=0A>=20>=20+=60=60V4=
L2_CID_CODEC_VP9_HIERARCHY_QP_ENABLE=60=60=0D=0A>=20>=20+=20=20=20=20Allows=
=20host=20to=20specify=20the=20quantization=20parameter=20values=20for=20ea=
ch=0D=0A>=20>=20+=20=20=20=20temporal=20layer=20through=20HIERARCHICAL_QP_L=
AYER.=20This=20is=20valid=20only=0D=0A>=20>=20+=20=20=20=20if=20HIERARCHICA=
L_CODING_LAYER=20is=20greater=20than=201.=20Setting=20the=20control=0D=0A>=
=20>=20+=20=20=20=20value=20to=201=20enables=20setting=20of=20the=20QP=20va=
lues=20for=20the=20layers.=0D=0A>=20>=20+=0D=0A>=20>=20+..=20_v4l2-vp9-ref-=
number-of-pframes:=0D=0A>=20>=20+=0D=0A>=20>=20+=60=60V4L2_CID_CODEC_VP9_RE=
F_NUMBER_FOR_PFRAMES=60=60=0D=0A>=20>=20+=20=20=20=20(enum)=0D=0A>=20>=20+=
=0D=0A>=20>=20+enum=20v4l2_mpeg_vp9_ref_num_for_pframes=20-=0D=0A>=20>=20+=
=20=20=20=20Number=20of=20reference=20pictures=20for=20encoding=20P=20frame=
s.=0D=0A>=20>=20+=0D=0A>=20>=20+..=20raw::=20latex=0D=0A>=20>=20+=0D=0A>=20=
>=20+=20=20=20=20=5Cfootnotesize=0D=0A>=20>=20+=0D=0A>=20>=20+..=20tabularc=
olumns::=20=7Cp=7B9.0cm=7D=7Cp=7B8.0cm=7D=7C=0D=0A>=20>=20+=0D=0A>=20>=20+.=
.=20flat-table::=0D=0A>=20>=20+=20=20=20=20:header-rows:=20=200=0D=0A>=20>=
=20+=20=20=20=20:stub-columns:=200=0D=0A>=20>=20+=0D=0A>=20>=20+=20=20=20=
=20*=20-=20=60=60V4L2_CID_CODEC_VP9_1_REF_PFRAME=60=60=0D=0A>=20>=20+=20=20=
=20=20=20=20-=20Indicates=20one=20reference=20frame,=20last=20encoded=20fra=
me=20will=20be=20searched.=0D=0A>=20>=20+=20=20=20=20*=20-=20=60=60V4L2_CID=
_CODEC_VP9_GOLDEN_FRAME_USE_REF_PERIOD=60=60=0D=0A>=20>=20+=20=20=20=20=20=
=20-=20Indicates=202=20reference=20frames,=20last=20encoded=20frame=20and=
=20golden=20frame=0D=0A>=20>=20+=20=20=20=20=20=20=20=20will=20be=20searche=
d.=0D=0A>=20>=20+=0D=0A>=20>=20+..=20raw::=20latex=0D=0A>=20>=20+=0D=0A>=20=
>=20+=20=20=20=20=5Cnormalsize=0D=0A>=20>=20+=0D=0A>=20>=20+=0D=0A>=20>=20+=
=60=60V4L2_CID_CODEC_VP9_HIERARCHICAL_CODING_LAYER=60=60=0D=0A>=20>=20+=20=
=20=20=20Indicates=20the=20number=20of=20hierarchial=20coding=20layer.=0D=
=0A>=20>=20+=20=20=20=20In=20normal=20encoding=20(non-hierarchial=20coding)=
,=20it=20should=20be=20zero.=0D=0A>=20>=20+=20=20=20=20VP9=20has=20upto=203=
=20layer=20of=20encoder.=0D=0A>=20>=20+=0D=0A>=20>=20+=60=60V4L2_CID_CODEC_=
VP9_HIERARCHY_RC_ENABLE=60=60=0D=0A>=20>=20+=20=20=20=20Indicates=20enablin=
g=20of=20bit=20rate=20for=20hierarchical=20coding=20layers=20VP9=20encoder.=
=0D=0A>=20>=20+=0D=0A>=20>=20+=60=60V4L2_CID_CODEC_VP9_HIER_CODING_L0_BR=60=
=60=0D=0A>=20>=20+=20=20=20=20Indicates=20bit=20rate=20for=20hierarchical=
=20coding=20layer=200=20for=20VP9=20encoder.=0D=0A>=20>=20+=0D=0A>=20>=20+=
=60=60V4L2_CID_CODEC_VP9_HIER_CODING_L1_BR=60=60=0D=0A>=20>=20+=20=20=20=20=
Indicates=20bit=20rate=20for=20hierarchical=20coding=20layer=201=20for=20VP=
9=20encoder.=0D=0A>=20>=20+=0D=0A>=20>=20+=60=60V4L2_CID_CODEC_VP9_HIER_COD=
ING_L2_BR=60=60=0D=0A>=20>=20+=20=20=20=20Indicates=20bit=20rate=20for=20hi=
erarchical=20coding=20layer=202=20for=20VP9=20encoder.=0D=0A>=20>=20+=0D=0A=
>=20>=20+=60=60V4L2_CID_CODEC_VP9_HIER_CODING_L0_QP=60=60=0D=0A>=20>=20+=20=
=20=20=20Indicates=20quantization=20parameter=20for=20hierarchical=20coding=
=20layer=200.=0D=0A>=20>=20+=20=20=20=20Valid=20range:=20=5BV4L2_CID_CODEC_=
VP9_MIN_QP,=0D=0A>=20>=20+=20=20=20=20V4L2_CID_CODEC_VP9_MAX_QP=5D.=0D=0A>=
=20>=20+=0D=0A>=20>=20+=60=60V4L2_CID_CODEC_VP9_HIER_CODING_L1_QP=60=60=0D=
=0A>=20>=20+=20=20=20=20Indicates=20quantization=20parameter=20for=20hierar=
chical=20coding=20layer=201.=0D=0A>=20>=20+=20=20=20=20Valid=20range:=20=5B=
V4L2_CID_CODEC_VP9_MIN_QP,=0D=0A>=20>=20+=20=20=20=20V4L2_CID_CODEC_VP9_MAX=
_QP=5D.=0D=0A>=20>=20+=0D=0A>=20>=20+=60=60V4L2_CID_CODEC_VP9_HIER_CODING_L=
2_QP=60=60=0D=0A>=20>=20+=20=20=20=20Indicates=20quantization=20parameter=
=20for=20hierarchical=20coding=20layer=202.=0D=0A>=20>=20+=20=20=20=20Valid=
=20range:=20=5BV4L2_CID_CODEC_VP9_MIN_QP,=0D=0A>=20>=20+=20=20=20=20V4L2_CI=
D_CODEC_VP9_MAX_QP=5D.=0D=0A>=20>=20+=0D=0A>=20>=20+..=20_v4l2-vp9-max-part=
ition-depth:=0D=0A>=20>=20+=0D=0A>=20>=20+=60=60V4L2_CID_CODEC_VP9_MAX_PART=
ITION_DEPTH=60=60=0D=0A>=20>=20+=20=20=20=20(enum)=0D=0A>=20>=20+=0D=0A>=20=
>=20+enum=20v4l2_mpeg_vp9_num_partitions=20-=0D=0A>=20>=20+=20=20=20=20Indi=
cate=20maximum=20coding=20unit=20depth.=0D=0A>=20>=20+=0D=0A>=20>=20+..=20r=
aw::=20latex=0D=0A>=20>=20+=0D=0A>=20>=20+=20=20=20=20=5Cfootnotesize=0D=0A=
>=20>=20+=0D=0A>=20>=20+..=20tabularcolumns::=20=7Cp=7B9.0cm=7D=7Cp=7B8.0cm=
=7D=7C=0D=0A>=20>=20+=0D=0A>=20>=20+..=20flat-table::=0D=0A>=20>=20+=20=20=
=20=20:header-rows:=20=200=0D=0A>=20>=20+=20=20=20=20:stub-columns:=200=0D=
=0A>=20>=20+=0D=0A>=20>=20+=20=20=20=20*=20-=20=60=60V4L2_CID_CODEC_VP9_0_P=
ARTITION=60=60=0D=0A>=20>=20+=20=20=20=20=20=20-=20No=20coding=20unit=20par=
tition=20depth.=0D=0A>=20>=20+=20=20=20=20*=20-=20=60=60V4L2_CID_CODEC_VP9_=
1_PARTITION=60=60=0D=0A>=20>=20+=20=20=20=20=20=20-=20Allows=20one=20coding=
=20unit=20partition=20depth.=0D=0A>=20>=20+=0D=0A>=20>=20+..=20raw::=20late=
x=0D=0A>=20>=20+=0D=0A>=20>=20+=20=20=20=20=5Cnormalsize=0D=0A>=20>=20+=0D=
=0A>=20>=20+=0D=0A>=20>=20+=60=60V4L2_CID_CODEC_VP9_DISABLE_INTRA_PU_SPLIT=
=60=60=0D=0A>=20>=20+=20=20=20=20Zero=20indicates=20enable=20intra=20NxN=20=
PU=20split.=0D=0A>=20>=20+=20=20=20=20One=20indicates=20disable=20intra=20N=
xN=20PU=20split.=0D=0A>=20>=20+=0D=0A>=20>=20+=60=60V4L2_CID_CODEC_VP9_DISA=
BLE_IVF_HEADER=60=60=0D=0A>=20>=20+=20=20=20=20Indicates=20IVF=20header=20g=
eneration.=20Zero=20indicates=20enable=20IVF=20format.=0D=0A>=20>=20+=20=20=
=20=20One=20indicates=20disable=20IVF=20format.=0D=0A>=20>=20+=0D=0A>=20>=
=0D=0A>=20>=20=20High=20Efficiency=20Video=20Coding=20(HEVC/H.265)=20Contro=
l=20Reference=0D=0A>=20>=0D=0A>=20=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D=0A>=20=3D=
=0D=0AThanks=20for=20the=20review.=0D=0A=0D=0A=0D=0A
