Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E988652F1F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 11:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbiLUKE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 05:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiLUKDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 05:03:22 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20383222A6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 02:01:43 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221221100139epoutp04a44f4d67a89518a39503edf857e01b73~yxra6VkHo0807608076epoutp045
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 10:01:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221221100139epoutp04a44f4d67a89518a39503edf857e01b73~yxra6VkHo0807608076epoutp045
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1671616899;
        bh=VhE4M9Lw1nyfU3Kcy6azZaKjworgvKyvAk7zEK4kDgY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=KAkDXNJNebThv5Y9KRGKmq0CSSTFXoam5eO+WgyMNzuVWGtO1y81X9g8lTVuPbqUX
         5L8RDjCH8418U+JO4WJRGzV9/mf7Mdn8gJkVh9C145S/DZgvLzsBldiv+gqDgqgs4m
         3JgFxMFxUIvSaA/2AsNiRJhEp+rdpchupjip02Ds=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221221100139epcas5p35e5317560e22572ef8e2bf37722132b2~yxraSLXFo0572205722epcas5p3X;
        Wed, 21 Dec 2022 10:01:39 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4NcTVm2Zfyz4x9Q0; Wed, 21 Dec
        2022 10:01:36 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.ED.03362.089D2A36; Wed, 21 Dec 2022 19:01:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221221095634epcas5p3c4d13e8ab6d1c46c9a70bbfb9c98758a~yxm_3dmvw2753427534epcas5p37;
        Wed, 21 Dec 2022 09:56:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221221095634epsmtrp1ac15fa090283f6b5853a235846afee98~yxm_1_Hd61382613826epsmtrp1K;
        Wed, 21 Dec 2022 09:56:34 +0000 (GMT)
X-AuditID: b6c32a4b-4e5fa70000010d22-6b-63a2d980317a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        38.08.02211.258D2A36; Wed, 21 Dec 2022 18:56:34 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221221095631epsmtip1353a364b89003d683e1fe2c1a4c92e04~yxm7iDBXo0668906689epsmtip1Q;
        Wed, 21 Dec 2022 09:56:31 +0000 (GMT)
From:   "Aakarsh Jain" <aakarsh.jain@samsung.com>
To:     "'Nicolas Dufresne'" <nicolas@ndufresne.ca>,
        "'Hans Verkuil'" <hverkuil-cisco@xs4all.nl>,
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
        <pankaj.dubey@samsung.com>, <linux-fsd@tesla.com>
In-Reply-To: <238edc4adf7e795b48cb9de98ba6f1efc67f3bfd.camel@ndufresne.ca>
Subject: RE: [Patch v3 05/15] Documention: v4l: Documentation for VP9 CIDs.
Date:   Wed, 21 Dec 2022 15:26:29 +0530
Message-ID: <000001d91522$823eded0$86bc9c70$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIjXZOHgvokXGuofbg3rWbxTFZEMQHl4WsmAsDEgksBl6lGqgLjDAiaAUtd6/6tkBwBAA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ta0xTZxjHPZdeYOk8AobXZkpzMkdgAVop9bCAmMCWE+EDmQm6LaF07Ukh
        9Ja2iJhssrnScZepDEqhXCpuDMG1BYvDBLAEZJONcQu3gcAClThZuUyGbGspOr79nuf5P9c3
        LxPxq2KwmRkKLaVWiGQ43RdtfxASHJY7US/m3tZjxFxNO51oeL4EE7MNayjRY21jELaRKoS4
        1ddFI0yOQRpxt3seJb5fdkeHKmdQYsnUAhFOw290wrIwRiMePzlHDN8z0omiO2004rZjhkHc
        HB+CiUbLC5hwDXQgRH3bOoPQ3XcwiC/yHPDpQLK5phki7TNmiBw3uxCywzDDIBs6nTBpacqn
        k9NjnXTSar5MWpcLEVLX+zdKltiaIPKfz6sZZIFjnE6uWY6RAxtrjOSDH2bGpFMiCaXmUAqx
        UpKhkMbiiWeF8cIoAZcXxosmTuIchUhOxeIJSclh72XI3GfAORdEsiy3K1mk0eARp2LUyiwt
        xUlXarSxOKWSyFR8VbhGJNdkKaThCkr7Do/LPRHlFqZlphd/s4yoek3QxW+LppBc6E8DVAD5
        MAHGB2Mtpbvsh/0AgfLmDwogXze7IPBv+SOG19iEwNWuz15lWK2NiDdw351xp5nuNZYgYJ7a
        gj0qOhYBZgeKaB4O8AR6n2V7RAg2hQDd6LVdkQ92BmzM79A97I8lgnWX2e1nMlHsOFi1SzzI
        wqLBH71Sj4KFHQIPKxdRDyPY26CxbgXxDsQBW7837rVKAXe7NxCvJhD0bhXtDgqwSR+g15fs
        lgdYAtgZSfLm+oMnfTaGl9nAWZq3x2KwUO/cqy8DrZ3XUS/Hga4RI+opg2AhoPVehNd9FNwY
        aIG9bV8HxduLsNfPAvaal/wWME4/p3n5DfDgu5vQVQg37NvMsG8zw74NDP93q4XQJugIpdLI
        pZQmShWpoLJfPbhYKbdAu78kNNEOzc+thvdAMBPqgQATwQNYvzjqxH4siSjnEqVWCtVZMkrT
        A0W5j12GsA+Lle5vptAKefxoLl8gEPCjIwU8PJBFtZnEfphUpKUyKUpFqV/mwUwfdi7Mb8UO
        cpoqz49XpY746EsPhA1f+pRXen2cmj1tfNMqaM3Q0ybsU2NZdJTyj7uVe+ATl254MqfOBpv7
        7e9O1I4mLFT8Kj9DPDMoG2siriRXHz+09aIqMrb0pLwfXWxOnUspDArojx90tZk2jfKyuIqW
        tXI4tUqyI5qEn25fDGrvOxVw7SNneIfe5sy/Il0JjUk6WvswuJC+iPcEvfZj52HDphGwhsS6
        rxLZF1JMxcZz2evg50dH8oKnFYM/3UBLVtm6OuQY5XrM9RXG2bqV4SFpOZc3Y85XCP1G0/7q
        jpFt4/k5IzVfcy3SFb7+y8T5j6upMpu1IeD9pyem4s/64qgmXcQLRdQa0X+3r0LGrgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42LZdlhJTjfoxqJkg6+r1C0ezNvGZrH4x3Mm
        i/uLP7NYHNq8ld1iy5XZzBbLjx9gtZh/5ByrxfaDj1gsNr4Ayl6ceZfF4vn8dYwWL2fdY7PY
        9Pgaq8XDV+EWl3fNYbPo2bCV1WLtkbvsFkuvX2SyWLbpD5PFp1M7mS0Wbf3CbtG69wi7RUvb
        ESYHcY8189Yweuy4u4TR4/qST8weO2fdZfdYvOclk8emVZ1sHneu7WHz2Lyk3mPzi25mj9aj
        v1g8+rasYvT41zSX3aPryHU2j8+b5DxOff3MHsAfxWWTkpqTWZZapG+XwJVxZPchloJjGRWn
        px5lbmB879/FyMkhIWAisXnzMuYuRi4OIYHdjBLLjh1khEjISPxvO8YOYQtLrPz3nB2i6Cmj
        xJZl85hAEmwC+hL3T/WwgiREBF4zSjyfegCsm1ngLbPEzlYtiI57TBL7pu1nBUlwCnhJfH30
        lw3EFhbwlvjyaQnQJA4OFgFViQ87UkBMXgFLiXdH00EqeAUEJU7OfMICMVJb4unNp3D2soWv
        mSGOU5D4+XQZ2HQRgTCJ7Qe/MkPUiEsc/dnDPIFReBaSUbOQjJqFZNQsJC0LGFlWMUqmFhTn
        pucWGxYY5qWW6xUn5haX5qXrJefnbmIEpxMtzR2M21d90DvEyMTBeIhRgoNZSYT3wpGFyUK8
        KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwdf89NGGidnRd
        wN382yWCkho9b/37k1eejze+fsrETNJiw85XRxQlFN7qHD70MuzM4Y37Gyd67gvv3bOiZVU2
        s1RLctkL99glh5Ky8gR0aj/uEb63Quz6mqeCgvEzZk4uc6pbtX+SzL3Zlt2rxbLi5f6xz3r3
        Z8Vxu+nNnkvCZI9lHucXSX0/X+3zR8HaqV3W604eChFQ4fUQ5F+8giXyVrNL3JwPq3K3djY2
        Be85K683w8wl7/F7n6DtE19VPX7auq9EmOf5B+dLbYembj+ed0Fn0sY/E6z//OO65NfI8TJw
        5/Wvl2UF+rnkYvfOOfNzf62Q3q8NAk59t25wKczfek/B+k4E+z+tixN7DMqaVyuxFGckGmox
        FxUnAgALU5WslgMAAA==
X-CMS-MailID: 20221221095634epcas5p3c4d13e8ab6d1c46c9a70bbfb9c98758a
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
        <000001d90fa6$0ff91470$2feb3d50$@samsung.com>
        <238edc4adf7e795b48cb9de98ba6f1efc67f3bfd.camel@ndufresne.ca>
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
> From: Nicolas Dufresne =5Bmailto:nicolas=40ndufresne.ca=5D
> Sent: 16 December 2022 22:51
> To: Aakarsh Jain <aakarsh.jain=40samsung.com>; 'Hans Verkuil' <hverkuil-
> cisco=40xs4all.nl>; linux-arm-kernel=40lists.infradead.org; linux-
> media=40vger.kernel.org; linux-kernel=40vger.kernel.org;
> devicetree=40vger.kernel.org
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
> Le mercredi 14 d=C3=A9cembre=202022=20=C3=A0=2015:52=20+0530,=20Aakarsh=
=20Jain=20a=20=C3=A9crit=20:=0D=0A>=20>=0D=0A>=20>=20>=20-----Original=20Me=
ssage-----=0D=0A>=20>=20>=20From:=20Hans=20Verkuil=20=5Bmailto:hverkuil-cis=
co=40xs4all.nl=5D=0D=0A>=20>=20>=20Sent:=2024=20November=202022=2016:54=0D=
=0A>=20>=20>=20To:=20aakarsh=20jain=20<aakarsh.jain=40samsung.com>;=20linux=
-arm-=0D=0A>=20>=20>=20kernel=40lists.infradead.org;=20linux-media=40vger.k=
ernel.org;=20linux-=0D=0A>=20>=20>=20kernel=40vger.kernel.org;=20devicetree=
=40vger.kernel.org=0D=0A>=20>=20>=20Cc:=20m.szyprowski=40samsung.com;=20and=
rzej.hajda=40intel.com;=0D=0A>=20>=20>=20mchehab=40kernel.org;=20ezequiel=
=40vanguardiasur.com.ar;=0D=0A>=20>=20>=20jernej.skrabec=40gmail.com;=20ben=
jamin.gaignard=40collabora.com;=0D=0A>=20>=20>=20stanimir.varbanov=40linaro=
.org;=20dillon.minfei=40gmail.com;=0D=0A>=20>=20>=20david.plowman=40raspber=
rypi.com;=20mark.rutland=40arm.com;=0D=0A>=20>=20>=20robh+dt=40kernel.org;=
=20krzk+dt=40kernel.org;=20andi=40etezian.org;=0D=0A>=20>=20>=20alim.akhtar=
=40samsung.com;=20aswani.reddy=40samsung.com;=0D=0A>=20>=20>=20pankaj.dubey=
=40samsung.com;=20linux-fsd=40tesla.com;=0D=0A>=20smitha.t=40samsung.com=0D=
=0A>=20>=20>=20Subject:=20Re:=20=5BPatch=20v3=2005/15=5D=20Documention:=20v=
4l:=20Documentation=20for=20VP9=0D=0A>=20CIDs.=0D=0A>=20>=20>=0D=0A>=20>=20=
>=20On=2011/10/2022=2014:25,=20aakarsh=20jain=20wrote:=0D=0A>=20>=20>=20>=
=20From:=20Smitha=20T=20Murthy=20<smitha.t=40samsung.com>=0D=0A>=20>=20>=20=
>=0D=0A>=20>=20>=20>=20Adds=20V4l2=20controls=20for=20VP9=20encoder=20docum=
ention.=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20Cc:=20linux-fsd=40tesla.com=
=0D=0A>=20>=20>=20>=20Signed-off-by:=20Smitha=20T=20Murthy=20<smitha.t=40sa=
msung.com>=0D=0A>=20>=20>=20>=20Signed-off-by:=20Aakarsh=20Jain=20<aakarsh.=
jain=40samsung.com>=0D=0A>=20>=20>=20>=20---=0D=0A>=20>=20>=20>=20=20.../me=
dia/v4l/ext-ctrls-codec.rst=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=20167=
=20++++++++++++++++++=0D=0A>=20>=20>=20>=20=201=20file=20changed,=20167=20i=
nsertions(+)=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20diff=20--git=0D=0A>=20=
>=20>=20>=20a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst=0D=
=0A>=20>=20>=20>=20b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.=
rst=0D=0A>=20>=20>=20>=20index=202a165ae063fb..2277d83a7cf0=20100644=0D=0A>=
=20>=20>=20>=20---=20a/Documentation/userspace-api/media/v4l/ext-ctrls-code=
c.rst=0D=0A>=20>=20>=20>=20+++=20b/Documentation/userspace-api/media/v4l/ex=
t-ctrls-codec.rst=0D=0A>=20>=20>=20>=20=40=40=20-2187,6=20+2187,16=20=40=40=
=20enum=20v4l2_mpeg_video_vp8_profile=20-=0D=0A>=20>=20>=20>=20=20=20=20=20=
=20*=20-=20=60=60V4L2_MPEG_VIDEO_VP8_PROFILE_3=60=60=0D=0A>=20>=20>=20>=20=
=20=20=20=20=20=20=20-=20Profile=203=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=
=20+VP9=20Control=20Reference=0D=0A>=20>=20>=0D=0A>=20>=20>=20This=20is=20w=
rong.=20There=20is=20a=20VPX=20Control=20Reference=20section=20for=20both=
=20VP8=0D=0A>=20>=20>=20and=20VP9=20controls.=20That's=20where=20this=20sho=
uld=20be=20added.=20I=20suspect=0D=0A>=20>=20>=20several=20of=20the=20contr=
ols=20you=20are=20adding=20here=20already=20exist,=20e.g.=0D=0A>=20>=20>=20=
V4L2_CID_MPEG_VIDEO_VPX_MIN_QP.=20The=20documentation=20may=20have=0D=0A>=
=20to=20be=0D=0A>=20>=20>=20updated=20to=20specify=20that=20it=20is=20for=
=20both=20VP8=20and=20VP9.=0D=0A>=20>=20>=0D=0A>=20>=20Since=20MFC=20has=20=
different=20profiles,=20different=20quantization=20parameter=20ranges=0D=0A=
>=20for=20both=20VP8=20and=20VP9.=20So=20we=20can't=20use=20same=20control=
=20ID's=20for=20both.=0D=0A>=20>=20So=20for=20example=20in=20VP8=20with=20c=
ontrol=20ID=0D=0A>=20(V4L2_CID_MPEG_VIDEO_VPX_MIN_QP),=20QP=20ranges=20from=
=200-11=20and=20in=20VP9=0D=0A>=20with=20control=20ID=20=20(V4L2_CID_CODEC_=
VP9_MIN_QP)=20QP=20ranges=20from=201-24.=20So=0D=0A>=20we=20can't=20club=20=
together=20into=20single=20control.=0D=0A>=20>=0D=0A>=20=0D=0A>=20V4L2_CID_=
MPEG_VIDEO_VPX_PROFILE=20has=20been=20deprecated,=20and=20replace=0D=0A>=20=
with=20menu=20controls.=20So=20we=20now=20have=20a=0D=0A>=20V4L2_CID_MPEG_V=
IDEO_VP8_PROFILE=20and=20a=0D=0A>=20V4L2_CID_MPEG_VIDEO_VP9_PROFILE=20as=20=
menues.=20Newly=20written=20drivers=0D=0A>=20should=20use=20these.=20I=20se=
e=20that=20GStreamer=20notably=20has=20never=20been=20ported,=20I'll=20fix=
=0D=0A>=20it.=0D=0A>=20=0D=0A>=20When=20you=20implement=20a=20driver,=20the=
=20generic=20uAPI=20will=20cover=20all=20possible=20items,=0D=0A>=20as=20me=
nus=20(a=20integer=20was=20an=20API=20mistake=20made=20in=202011,=20hence=
=20the=0D=0A>=20deprecation).=20You=20driver=20can=20then=20select=20which=
=20menu=20items=20it=20support,=20and=20its=0D=0A>=20server=20at=20telling=
=20userspace=20what=20this=20HW=20supports.=20Though,=20this=20should=20be=
=20no=0D=0A>=20problem=20if=20you=20want=20to=20keep=20the=20old=20CID=20fo=
r=20backward=20compat,=20since=20the=0D=0A>=20range=20is=20just=20totally=
=20undefined=20there.=0D=0A>=20=0D=0A>=20For=20V4L2_CID_MPEG_VIDEO_VPX_MIN_=
QP=20(and=20friends),=20the=20doc=20says=0D=0A>=20=22Minimum=20quantization=
=20parameter=20for=20VP8.=22.=20A=20bit=20strange=20for=20a=20supposedly=0D=
=0A>=20VPX=20parameter.=0D=0A>=20But=20its=20defines=20in=20the=20code=20as=
=20=22VPX=20Minimum=20QP=20Value=22.=20Clearly=20something=20to=0D=0A>=20be=
=20fixed.=20There=20is=20no=20VP9=20encoder=20drivers=20yet=20in=20mainline=
.=0D=0A>=20=0D=0A>=20Though,=20the=20range=20for=20these=20controls=20is=20=
driver=20defined.=20In=20Venus,=20for=20VP8:=0D=0A>=20=0D=0A>=20=0D=0A>=20=
=20=20=20=20=20=20=20=20v4l2_ctrl_new_std(&inst->ctrl_handler,=20&venc_ctrl=
_ops,=0D=0A>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20V4L2_CID_MPE=
G_VIDEO_VPX_MIN_QP,=201,=20128,=201,=201);=0D=0A>=20=0D=0A>=20It=20seems=20=
to=20be=201=20to=20128.=20While=20in=20MFC,=20it=20oddly=201=20to=2011:=0D=
=0A>=20=0D=0A>=20=0D=0A>=20=20=20=20=20=20=20=20=20=7B=0D=0A>=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20.id=20=3D=20V4L2_CID_MPEG_VIDEO_VPX_=
MIN_QP,=0D=0A>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20.type=20=
=3D=20V4L2_CTRL_TYPE_INTEGER,=0D=0A>=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20.minimum=20=3D=200,=0D=0A>=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20.maximum=20=3D=2011,=0D=0A>=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20.step=20=3D=201,=0D=0A>=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20.default_value=20=3D=200,=0D=0A>=20=20=20=20=20=20=20=20=
=20=7D,=0D=0A>=20=0D=0A>=20While=20I'm=20not=20a=20huge=20fan=20of=20this,=
=20since=20we=20all=20know=20QP=20does=20not=20scale=20linearly,=0D=0A>=20t=
his=20is=20how=20it=20is,=20and=20this=20is=20kind=20of=20part=20of=20the=
=20kernel=20API=20now.=20So=20userspace=0D=0A>=20must=20ask=20the=20driver=
=20what=20is=20the=20QP=20range,=20and=20adapt.=20And=20in=20your=20case,=
=20you=0D=0A>=20should=20have=20no=20issue=20adding=20VP9=20encoder=20with=
=20a=201=20to=2024=20range=20(even=20if=20this=20is=20a=0D=0A>=20bit=20odd=
=20and=20hw=20specific).=0D=0A>=20=0D=0A>=20Nicolas=0D=0A>=20=0D=0A=0D=0ASo=
=20all=20controls=20which=20I=20am=20using=20in=20VP9=20similar=20to=20VPX=
=20will=20implement=20that=20as=20menu=20control.=20Will=20not=20touch=20VP=
X=20controls=20for=20backward=20compatibility.=0D=0AAlso=20will=20change=20=
all=20remaining=20VP9=20controls=20implementation=20from=20Integer=20to=20m=
enu=20control.=20=0D=0A=0D=0AWill=20this=20be=20fine=20?=0D=0A=0D=0A>=20=0D=
=0A>=20>=20>=20>=20+---------------------=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=
=20>=20>=20+The=20VP9=20controls=20include=20controls=20for=20encoding=20pa=
rameters=20of=20VP9=0D=0A>=20>=20>=20>=20+video=20codec.=0D=0A>=20>=20>=20>=
=20+=0D=0A>=20>=20>=20>=20+..=20_vp9-control-id:=0D=0A>=20>=20>=20>=20+=0D=
=0A>=20>=20>=20>=20+VP9=20Control=20IDs=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=
=20>=20>=20=20..=20_v4l2-mpeg-video-vp9-profile:=0D=0A>=20>=20>=20>=0D=0A>=
=20>=20>=20>=20=20=60=60V4L2_CID_MPEG_VIDEO_VP9_PROFILE=60=60=0D=0A>=20>=20=
>=20>=20=40=40=20-2253,6=20+2263,163=20=40=40=20enum=20v4l2_mpeg_video_vp9_=
level=20-=0D=0A>=20>=20>=20>=20=20=20=20=20=20*=20-=20=60=60V4L2_MPEG_VIDEO=
_VP9_LEVEL_6_2=60=60=0D=0A>=20>=20>=20>=20=20=20=20=20=20=20=20-=20Level=20=
6.2=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20+=60=60V4L2_CID_CODEC_VP9_I_FRA=
ME_QP=60=60=0D=0A>=20>=20>=0D=0A>=20>=20>=20If=20you=20do=20need=20to=20add=
=20new=20controls,=20then=20please=20use=20the=20same=0D=0A>=20>=20>=20MPEG=
_VIDEO_=20prefix.=0D=0A>=20>=20>=20It's=20a=20bit=20ugly=20and=20historical=
,=20but=20let's=20keep=20it=20consistent=20with=20the=20others.=0D=0A>=20>=
=20>=0D=0A>=20>=20>=20Regards,=0D=0A>=20>=20>=0D=0A>=20>=20>=20=09Hans=0D=
=0A>=20>=20>=0D=0A>=20>=20>=20>=20+=20=20=20=20Quantization=20parameter=20f=
or=20an=20I=20frame=20for=20VP9.=20Valid=20range:=0D=0A>=20>=20>=20>=20+=20=
from=201=20to=0D=0A>=20>=20>=20255.=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=
=20>=20+=60=60V4L2_CID_CODEC_VP9_P_FRAME_QP=60=60=0D=0A>=20>=20>=20>=20+=20=
=20=20=20Quantization=20parameter=20for=20an=20P=20frame=20for=20VP9.=20Val=
id=20range:=0D=0A>=20>=20>=20>=20+from=201=20to=0D=0A>=20>=20>=20255.=0D=0A=
>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20+=60=60V4L2_CID_CODEC_VP9_MAX_QP=60=
=60=0D=0A>=20>=20>=20>=20+=20=20=20=20Maximum=20quantization=20parameter=20=
for=20VP9.=20Valid=20range:=20from=201=20to=0D=0A>=20255.=0D=0A>=20>=20>=20=
>=20+=20=20=20=20Recommended=20range=20for=20MFC=20is=20from=20230=20to=202=
55.=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20+=60=60V4L2_CID_CODEC_VP9_M=
IN_QP=60=60=0D=0A>=20>=20>=20>=20+=20=20=20=20Minimum=20quantization=20para=
meter=20for=20VP9.=20Valid=20range:=20from=201=20to=0D=0A>=20255.=0D=0A>=20=
>=20>=20>=20+=20=20=20=20Recommended=20range=20for=20MFC=20is=20from=201=20=
to=2024.=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20+=60=60V4L2_CID_CODEC_=
VP9_RC_FRAME_RATE=60=60=0D=0A>=20>=20>=20>=20+=20=20=20=20Indicates=20the=
=20number=20of=20evenly=20spaced=20subintervals,=20called=20ticks,=0D=0A>=
=20within=0D=0A>=20>=20>=20>=20+=20=20=20=20one=20second.=20This=20is=20a=
=2016=20bit=20unsigned=20integer=20and=20has=20a=0D=0A>=20>=20>=20>=20+maxi=
mum=20value=0D=0A>=20>=20>=20up=20to=0D=0A>=20>=20>=20>=20+=20=20=20=200xff=
ff=20and=20a=20minimum=20value=20of=201.=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=
=20>=20>=20+=60=60V4L2_CID_CODEC_VP9_GF_REFRESH_PERIOD=60=60=0D=0A>=20>=20>=
=20>=20+=20=20=20=20Indicates=20the=20refresh=20period=20of=20the=20golden=
=20frame=20for=20VP9=20encoder.=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=
=20+..=20_v4l2-vp9-golden-frame-sel:=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=
=20>=20+=60=60V4L2_CID_CODEC_VP9_GOLDEN_FRAMESEL=60=60=0D=0A>=20>=20>=20>=
=20+=20=20=20=20(enum)=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20+enum=20=
v4l2_mpeg_vp9_golden_framesel=20-=0D=0A>=20>=20>=20>=20+=20=20=20=20Selects=
=20the=20golden=20frame=20for=20encoding.=20Valid=20when=20NUM_OF_REF=20is=
=0D=0A>=202.=0D=0A>=20>=20>=20>=20+=20=20=20=20Possible=20values=20are:=0D=
=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20+..=20raw::=20latex=0D=0A>=20>=20=
>=20>=20+=0D=0A>=20>=20>=20>=20+=20=20=20=20=5Cfootnotesize=0D=0A>=20>=20>=
=20>=20+=0D=0A>=20>=20>=20>=20+..=20tabularcolumns::=20=7Cp=7B9.0cm=7D=7Cp=
=7B8.0cm=7D=7C=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20+..=20flat-table=
::=0D=0A>=20>=20>=20>=20+=20=20=20=20:header-rows:=20=200=0D=0A>=20>=20>=20=
>=20+=20=20=20=20:stub-columns:=200=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=
=20>=20+=20=20=20=20*=20-=20=60=60V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_PREV=
=60=60=0D=0A>=20>=20>=20>=20+=20=20=20=20=20=20-=20Use=20the=20(n-2)th=20fr=
ame=20as=20a=20golden=20frame,=20current=20frame=20index=0D=0A>=20being=0D=
=0A>=20>=20>=20>=20+=20=20=20=20=20=20=20=20'n'.=0D=0A>=20>=20>=20>=20+=20=
=20=20=20*=20-=20=60=60V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_REF_PERIOD=60=60=
=0D=0A>=20>=20>=20>=20+=20=20=20=20=20=20-=20Use=20the=20previous=20specifi=
c=20frame=20indicated=20by=0D=0A>=20>=20>=20>=20+=20=20=20=20=20=20=20=20=
=60=60V4L2_CID_CODEC_VP9_GF_REFRESH_PERIOD=60=60=20as=20a=0D=0A>=20>=20>=20=
>=20+=20=20=20=20=20=20=20=20golden=20frame.=0D=0A>=20>=20>=20>=20+=0D=0A>=
=20>=20>=20>=20+..=20raw::=20latex=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20=
>=20+=20=20=20=20=5Cnormalsize=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20=
+=0D=0A>=20>=20>=20>=20+=60=60V4L2_CID_CODEC_VP9_HIERARCHY_QP_ENABLE=60=60=
=0D=0A>=20>=20>=20>=20+=20=20=20=20Allows=20host=20to=20specify=20the=20qua=
ntization=20parameter=20values=20for=20each=0D=0A>=20>=20>=20>=20+=20=20=20=
=20temporal=20layer=20through=20HIERARCHICAL_QP_LAYER.=20This=20is=20valid=
=20only=0D=0A>=20>=20>=20>=20+=20=20=20=20if=20HIERARCHICAL_CODING_LAYER=20=
is=20greater=20than=201.=20Setting=20the=0D=0A>=20control=0D=0A>=20>=20>=20=
>=20+=20=20=20=20value=20to=201=20enables=20setting=20of=20the=20QP=20value=
s=20for=20the=20layers.=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20+..=20_=
v4l2-vp9-ref-number-of-pframes:=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=
=20+=60=60V4L2_CID_CODEC_VP9_REF_NUMBER_FOR_PFRAMES=60=60=0D=0A>=20>=20>=20=
>=20+=20=20=20=20(enum)=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20+enum=
=20v4l2_mpeg_vp9_ref_num_for_pframes=20-=0D=0A>=20>=20>=20>=20+=20=20=20=20=
Number=20of=20reference=20pictures=20for=20encoding=20P=20frames.=0D=0A>=20=
>=20>=20>=20+=0D=0A>=20>=20>=20>=20+..=20raw::=20latex=0D=0A>=20>=20>=20>=
=20+=0D=0A>=20>=20>=20>=20+=20=20=20=20=5Cfootnotesize=0D=0A>=20>=20>=20>=
=20+=0D=0A>=20>=20>=20>=20+..=20tabularcolumns::=20=7Cp=7B9.0cm=7D=7Cp=7B8.=
0cm=7D=7C=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20+..=20flat-table::=0D=
=0A>=20>=20>=20>=20+=20=20=20=20:header-rows:=20=200=0D=0A>=20>=20>=20>=20+=
=20=20=20=20:stub-columns:=200=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20=
+=20=20=20=20*=20-=20=60=60V4L2_CID_CODEC_VP9_1_REF_PFRAME=60=60=0D=0A>=20>=
=20>=20>=20+=20=20=20=20=20=20-=20Indicates=20one=20reference=20frame,=20la=
st=20encoded=20frame=20will=20be=0D=0A>=20searched.=0D=0A>=20>=20>=20>=20+=
=20=20=20=20*=20-=20=60=60V4L2_CID_CODEC_VP9_GOLDEN_FRAME_USE_REF_PERIOD=60=
=60=0D=0A>=20>=20>=20>=20+=20=20=20=20=20=20-=20Indicates=202=20reference=
=20frames,=20last=20encoded=20frame=20and=20golden=0D=0A>=20frame=0D=0A>=20=
>=20>=20>=20+=20=20=20=20=20=20=20=20will=20be=20searched.=0D=0A>=20>=20>=
=20>=20+=0D=0A>=20>=20>=20>=20+..=20raw::=20latex=0D=0A>=20>=20>=20>=20+=0D=
=0A>=20>=20>=20>=20+=20=20=20=20=5Cnormalsize=0D=0A>=20>=20>=20>=20+=0D=0A>=
=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20+=60=60V4L2_CID_CODEC_VP9_HIERARCHICA=
L_CODING_LAYER=60=60=0D=0A>=20>=20>=20>=20+=20=20=20=20Indicates=20the=20nu=
mber=20of=20hierarchial=20coding=20layer.=0D=0A>=20>=20>=20>=20+=20=20=20=
=20In=20normal=20encoding=20(non-hierarchial=20coding),=20it=20should=20be=
=20zero.=0D=0A>=20>=20>=20>=20+=20=20=20=20VP9=20has=20upto=203=20layer=20o=
f=20encoder.=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20+=60=60V4L2_CID_CO=
DEC_VP9_HIERARCHY_RC_ENABLE=60=60=0D=0A>=20>=20>=20>=20+=20=20=20=20Indicat=
es=20enabling=20of=20bit=20rate=20for=20hierarchical=20coding=20layers=20VP=
9=0D=0A>=20encoder.=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20+=60=60V4L2=
_CID_CODEC_VP9_HIER_CODING_L0_BR=60=60=0D=0A>=20>=20>=20>=20+=20=20=20=20In=
dicates=20bit=20rate=20for=20hierarchical=20coding=20layer=200=20for=20VP9=
=20encoder.=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20+=60=60V4L2_CID_COD=
EC_VP9_HIER_CODING_L1_BR=60=60=0D=0A>=20>=20>=20>=20+=20=20=20=20Indicates=
=20bit=20rate=20for=20hierarchical=20coding=20layer=201=20for=20VP9=20encod=
er.=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20+=60=60V4L2_CID_CODEC_VP9_H=
IER_CODING_L2_BR=60=60=0D=0A>=20>=20>=20>=20+=20=20=20=20Indicates=20bit=20=
rate=20for=20hierarchical=20coding=20layer=202=20for=20VP9=20encoder.=0D=0A=
>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20+=60=60V4L2_CID_CODEC_VP9_HIER_CODIN=
G_L0_QP=60=60=0D=0A>=20>=20>=20>=20+=20=20=20=20Indicates=20quantization=20=
parameter=20for=20hierarchical=20coding=20layer=200.=0D=0A>=20>=20>=20>=20+=
=20=20=20=20Valid=20range:=20=5BV4L2_CID_CODEC_VP9_MIN_QP,=0D=0A>=20>=20>=
=20>=20+=20=20=20=20V4L2_CID_CODEC_VP9_MAX_QP=5D.=0D=0A>=20>=20>=20>=20+=0D=
=0A>=20>=20>=20>=20+=60=60V4L2_CID_CODEC_VP9_HIER_CODING_L1_QP=60=60=0D=0A>=
=20>=20>=20>=20+=20=20=20=20Indicates=20quantization=20parameter=20for=20hi=
erarchical=20coding=20layer=201.=0D=0A>=20>=20>=20>=20+=20=20=20=20Valid=20=
range:=20=5BV4L2_CID_CODEC_VP9_MIN_QP,=0D=0A>=20>=20>=20>=20+=20=20=20=20V4=
L2_CID_CODEC_VP9_MAX_QP=5D.=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20+=
=60=60V4L2_CID_CODEC_VP9_HIER_CODING_L2_QP=60=60=0D=0A>=20>=20>=20>=20+=20=
=20=20=20Indicates=20quantization=20parameter=20for=20hierarchical=20coding=
=20layer=202.=0D=0A>=20>=20>=20>=20+=20=20=20=20Valid=20range:=20=5BV4L2_CI=
D_CODEC_VP9_MIN_QP,=0D=0A>=20>=20>=20>=20+=20=20=20=20V4L2_CID_CODEC_VP9_MA=
X_QP=5D.=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20+..=20_v4l2-vp9-max-pa=
rtition-depth:=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20+=60=60V4L2_CID_=
CODEC_VP9_MAX_PARTITION_DEPTH=60=60=0D=0A>=20>=20>=20>=20+=20=20=20=20(enum=
)=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20+enum=20v4l2_mpeg_vp9_num_par=
titions=20-=0D=0A>=20>=20>=20>=20+=20=20=20=20Indicate=20maximum=20coding=
=20unit=20depth.=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20+..=20raw::=20=
latex=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20+=20=20=20=20=5Cfootnotes=
ize=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=20+..=20tabularcolumns::=20=
=7Cp=7B9.0cm=7D=7Cp=7B8.0cm=7D=7C=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=
=20+..=20flat-table::=0D=0A>=20>=20>=20>=20+=20=20=20=20:header-rows:=20=20=
0=0D=0A>=20>=20>=20>=20+=20=20=20=20:stub-columns:=200=0D=0A>=20>=20>=20>=
=20+=0D=0A>=20>=20>=20>=20+=20=20=20=20*=20-=20=60=60V4L2_CID_CODEC_VP9_0_P=
ARTITION=60=60=0D=0A>=20>=20>=20>=20+=20=20=20=20=20=20-=20No=20coding=20un=
it=20partition=20depth.=0D=0A>=20>=20>=20>=20+=20=20=20=20*=20-=20=60=60V4L=
2_CID_CODEC_VP9_1_PARTITION=60=60=0D=0A>=20>=20>=20>=20+=20=20=20=20=20=20-=
=20Allows=20one=20coding=20unit=20partition=20depth.=0D=0A>=20>=20>=20>=20+=
=0D=0A>=20>=20>=20>=20+..=20raw::=20latex=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=
=20>=20>=20+=20=20=20=20=5Cnormalsize=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=
=20>=20+=0D=0A>=20>=20>=20>=20+=60=60V4L2_CID_CODEC_VP9_DISABLE_INTRA_PU_SP=
LIT=60=60=0D=0A>=20>=20>=20>=20+=20=20=20=20Zero=20indicates=20enable=20int=
ra=20NxN=20PU=20split.=0D=0A>=20>=20>=20>=20+=20=20=20=20One=20indicates=20=
disable=20intra=20NxN=20PU=20split.=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=
=20>=20+=60=60V4L2_CID_CODEC_VP9_DISABLE_IVF_HEADER=60=60=0D=0A>=20>=20>=20=
>=20+=20=20=20=20Indicates=20IVF=20header=20generation.=20Zero=20indicates=
=20enable=20IVF=20format.=0D=0A>=20>=20>=20>=20+=20=20=20=20One=20indicates=
=20disable=20IVF=20format.=0D=0A>=20>=20>=20>=20+=0D=0A>=20>=20>=20>=0D=0A>=
=20>=20>=20>=20=20High=20Efficiency=20Video=20Coding=20(HEVC/H.265)=20Contr=
ol=20Reference=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=0D=0A>=20=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=0D=0A>=20>=20>=20=3D=0D=0A>=20>=0D=0A>=20>=0D=0A=0D=0A=0D=0A
