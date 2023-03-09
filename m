Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906F76B395B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjCJJAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCJI7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:59:17 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163AE6FFD3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:52:53 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230310085251epoutp04f4b670c26d53eb57a63d5498230d6d9f~LAs5uSQEF0687906879epoutp04k
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:52:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230310085251epoutp04f4b670c26d53eb57a63d5498230d6d9f~LAs5uSQEF0687906879epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678438371;
        bh=mbTVRARZa00Wt/5CaAguT27mR1eA5Av02KT8R3nPBik=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=X5v4ImQh9eXPvpsQWKDGg1dPyVjoYR2PPw86qkaRXGY+HRZBvhpgUQap4s2W8B6b1
         nWELVP2bZnZYdbMgP6ncVbhfAA7i5aLP2JlO3b4p1lyfYHdOfFW/aZFRtLndKu4Ofw
         0M2dqW3dmRkGpmIP/E2c1TNC9KbWzWasKP9Bpimc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230310085251epcas5p3d9549dfb79fde065675ca9164922d34b~LAs5CMCwI2685626856epcas5p3B;
        Fri, 10 Mar 2023 08:52:51 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PY0Dx21RVz4x9Q7; Fri, 10 Mar
        2023 08:52:49 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.E4.55678.0EFEA046; Fri, 10 Mar 2023 17:52:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230309084828epcas5p414b1687d51abf484520820d9d6fe7582~Ks-yEME0L3190631906epcas5p48;
        Thu,  9 Mar 2023 08:48:28 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230309084828epsmtrp17eb7966e64f8b8d175cfaa027eaf651f~Ks-yDNo6E1369313693epsmtrp1c;
        Thu,  9 Mar 2023 08:48:28 +0000 (GMT)
X-AuditID: b6c32a4a-6a3ff7000000d97e-3a-640aefe08848
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        75.73.18071.C5D99046; Thu,  9 Mar 2023 17:48:28 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230309084825epsmtip18cbce813f46e6abc911beaebbba9431b~Ks-vB-hZa1043310433epsmtip1T;
        Thu,  9 Mar 2023 08:48:24 +0000 (GMT)
From:   "Aakarsh Jain" <aakarsh.jain@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     <m.szyprowski@samsung.com>, <andrzej.hajda@intel.com>,
        <mchehab@kernel.org>, <hverkuil-cisco@xs4all.nl>,
        <ezequiel@vanguardiasur.com.ar>, <jernej.skrabec@gmail.com>,
        <benjamin.gaignard@collabora.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <stanimir.varbanov@linaro.org>, <dillon.minfei@gmail.com>,
        <david.plowman@raspberrypi.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>, <andi@etezian.org>,
        <alim.akhtar@samsung.com>, <aswani.reddy@samsung.com>,
        <pankaj.dubey@samsung.com>
In-Reply-To: <81e78cf6-b8b3-0cab-d190-aa22abbc5c2d@linaro.org>
Subject: RE: [Patch v6] dt-bindings: media: s5p-mfc: convert bindings to
 json-schema
Date:   Thu, 9 Mar 2023 14:18:23 +0530
Message-ID: <001901d95263$eac4b460$c04e1d20$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHxIgKtygHqPU4mHAhqu15r4A65nwLsA7LZAklDK9wB4osi/QJmoqxPAoFahrkB+xU0e65SqsaA
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHPb1tb0tSvSKGs2Yz5brIQ4HWtXhYQPdQd6OyNVumU6d4pTcF
        6SttcZMlo2Q8HGM4CMRQETeLLIMC41EBKRtWGIMlCmJkbnQ8JxYUpiiPTXGlLRv/fc7vfL/n
        +/udk8PD/AtxIS9JY2T0GlpFcv3Yl6+FBocPT/spxPUPABoqvcxFlvlxFhq0zLCRo96Go4Zb
        5zD0bWcbB11ov85BjVdH2Kj2nnu3t9jJRuMXqgFymf/gorx7wxhqnXQ76kZvc1DflRIuyv3e
        xkFV7U4cXervZaHyuqcsdNH2GEeZre04yshqZ70WSFlLrYBqcpYBqr/sEUY1m504ZbG7WFRd
        xedcauC2nUvVl6VRmR1/s6m8hgpA5bT3c6mZug1U95MZXC44lByTyNAKRi9iNAlaRZJGGUvu
        fS/+zXhZlFgSLolG20iRhlYzseTOffLw3Ukq9/Sk6CStSnGX5LTBQEZuj9FrU4yMKFFrMMaS
        jE6h0kl1EQZabUjRKCM0jPFViVi8VeYWHktObF5w4DrXlo9tdzeZwGxwDuDzICGFppEcLAf4
        8fyJFgArK38G3sUjABcnnnK8i1kA+3Jd7GVL9mfP2N6NVgAL27p8/nEA52vH8SUVl4iEg925
        HnsA0QHgUMOwR4UR2WyYf9MEllR8YjucbKnElngdsR8O157mLjGbeBlOX7d78gRENLTZM3Av
        r4VdxWOeOkZshuXfTGLenkRw4c9yzhIHEIfcXdTiXk0g7FjI9QRDooUPa3se+gw7YWN9DcvL
        6+BEZwPuZSF0ncnycQIcvejy6VWwxl7ou4AdsO1WiZt57oBQWHMl0lt+CRZ1V7O8uavhl/+M
        +Y4XwKbSZd4ESwbmOV5+EV6rvAS+AqR5xWjmFaOZV4xg/j/ta8CuAC8wOoNayRhkuq0a5qP/
        njxBq64Dnu8RtqcJDA/9FeEALB5wAMjDyADBnJCn8Bco6FOpjF4br09RMQYHkLnvOx8Trk/Q
        uv+XxhgvkUaLpVFRUdLoV6IkZKAgOLYrwZ9Q0kYmmWF0jH7Zx+LxhSYWSZPzG7ekE0cirKsG
        d237Nf3wnCwv7s75L0KOWvvibhhn3+WbY0zyzvGDan5WD5+4oQxMD3peJM+dypZZ0uTPOoKO
        EG2TjaEBkScejx7+ceNqrmzDqt2LGXs/uR80GXfGuWDtOW0+Czb3lsnFjY0FUwMPkOROVcEB
        vvTEd82yXXLmw59MofGxO/KOP9ljEQcxpgmcWZO2q+H9t0bWFjk1uP6dkxGLrtTjNy0j3WZh
        x9nFxMVi6y+FFZ9WP/RPxQSjd48Zz73xW8XUvum8EKnug4OnbCPrq3CRWRq45u0DweoSV1rz
        /qtHQ7od93//IbNA2ZX/nJ7LMNnLx4pfTzlfpQ4j2YZEWhKG6Q30v0CdL3KnBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzHfX/Pd9vpp4u+l5bcZGGV87SvsVgzfksM81BpON3Peahz7vJQ
        SHSKStrabF1Ej3IiXV2h8nBOVkKJcuYi6cFCJqaaxN2N9d/783m93+/P948vg7v+IjyYXaoY
        XqOSR0kpIVH5QOrlF3FBoJidVyBA73IqKZQ/2IOht/kDBDKXm2hU8SIbR5cf3SPRRctTElXd
        f0+gst6/tDnLRqCei9cB+qhvp1B6bweOavv+JoydrSRquX2eQmk3TCS6ZrHRqLCtGUNFxl8Y
        yjN9p9HJWguNdEkWbKk7V5JTAribtgLAtRV8w7lbehvN5dd8xDij4TTFvWmtobjygmPcyYfD
        BJdeYQBciqWN4gaMXlzDjwF6jShcuFjBR+06wGsCArcJd74+FakulB6ymQvxBPBSkgIEDGTn
        weTEESIFCBlXthrA8iuppBN4wtGkOtqpxfDK7x7aaeoC8Pm3OswOKDYAvm1II+3Aja0H8Gyj
        zjHgbBYBX2bYXfZIAg5PVz8j7BEBGwj7qq/idi1m18PhBJPjHsFOg/1PaxweEbsQmmp0tFNP
        gPVZHxx7nJ0Fu6xd/3VRbh/ufJ83HOoqcvS4seFwsKyMdnrc4cOhNDwDiPVjqvRjqvRjqvRj
        IpcAYQASXq2NVkZrZWqZij/or5VHa/erlP6Re6ONwPFBZs64CaoMX/3NAGOAGUAGl7qJfnow
        CleRQh4bx2v2btXsj+K1ZjCZIaTuoqaU+q2urFIew+/heTWv+UcxRuCRgDXuK5J4Zi/NFv2c
        YY3zzU1uWdkYFOi9LxQLok3xWOmrZdawE73BG12aLmyeikQNTYnpc0KO8CW5On5tbJWqrnO4
        7hn5RNYZkTixuzg1hwpSSr0VzZPCzKpSl1Vwoa/P5KTKWC8id9GmRs66FrGLhBuCDk/383ZZ
        ccq2I3TT9k/k/bhyMnx2cF6o0uNMyyOfvpz5Eq2A2nK8+0imYon7lLh4okFDDrXfXfIhtbZf
        6mP9PNh9dE9P5teQu4+bWHXH8t0tU873rx4BrbKO6evEu8XyvJhaXcYDn6N+XxZMMGSOTy49
        Z7oa2TkyGt8/97mECy8e9/rWtDC956hgW3tA8B0pod0pl83ENVr5HzlpS16PAwAA
X-CMS-MailID: 20230309084828epcas5p414b1687d51abf484520820d9d6fe7582
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230301035153epcas5p40f576188a9a69835c1050135219a3720
References: <CGME20230301035153epcas5p40f576188a9a69835c1050135219a3720@epcas5p4.samsung.com>
        <20230301035144.8645-1-aakarsh.jain@samsung.com>
        <8b5bea40-6f7b-1d00-ac23-83a28c7dacbc@linaro.org>
        <046b01d94d1a$418146a0$c483d3e0$@samsung.com>
        <9b93849d-d4a4-67ba-e8a0-ee6c7209bd65@linaro.org>
        <000701d95257$e97ebd50$bc7c37f0$@samsung.com>
        <81e78cf6-b8b3-0cab-d190-aa22abbc5c2d@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
> Sent: 09 March 2023 13:41
> To: Aakarsh Jain <aakarsh.jain=40samsung.com>; linux-arm-
> kernel=40lists.infradead.org; linux-media=40vger.kernel.org; linux-
> kernel=40vger.kernel.org; devicetree=40vger.kernel.org
> Cc: m.szyprowski=40samsung.com; andrzej.hajda=40intel.com;
> mchehab=40kernel.org; hverkuil-cisco=40xs4all.nl;
> ezequiel=40vanguardiasur.com.ar; jernej.skrabec=40gmail.com;
> benjamin.gaignard=40collabora.com; krzysztof.kozlowski+dt=40linaro.org;
> stanimir.varbanov=40linaro.org; dillon.minfei=40gmail.com;
> david.plowman=40raspberrypi.com; mark.rutland=40arm.com;
> robh+dt=40kernel.org; krzk+dt=40kernel.org; andi=40etezian.org;
> alim.akhtar=40samsung.com; aswani.reddy=40samsung.com;
> pankaj.dubey=40samsung.com
> Subject: Re: =5BPatch v6=5D dt-bindings: media: s5p-mfc: convert bindings=
 to json-
> schema
>=20
> On 09/03/2023 08:22, Aakarsh Jain wrote:
> >
> >
> >> -----Original Message-----
> >> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=
=5D
> >> Sent: 09 March 2023 12:15
> >> To: Aakarsh Jain <aakarsh.jain=40samsung.com>; linux-arm-
> >> kernel=40lists.infradead.org; linux-media=40vger.kernel.org; linux-
> >> kernel=40vger.kernel.org; devicetree=40vger.kernel.org
> >> Cc: m.szyprowski=40samsung.com; andrzej.hajda=40intel.com;
> >> mchehab=40kernel.org; hverkuil-cisco=40xs4all.nl;
> >> ezequiel=40vanguardiasur.com.ar; jernej.skrabec=40gmail.com;
> >> benjamin.gaignard=40collabora.com; krzysztof.kozlowski+dt=40linaro.org=
;
> >> stanimir.varbanov=40linaro.org; dillon.minfei=40gmail.com;
> >> david.plowman=40raspberrypi.com; mark.rutland=40arm.com;
> >> robh+dt=40kernel.org; krzk+dt=40kernel.org; andi=40etezian.org;
> >> alim.akhtar=40samsung.com; aswani.reddy=40samsung.com;
> >> pankaj.dubey=40samsung.com
> >> Subject: Re: =5BPatch v6=5D dt-bindings: media: s5p-mfc: convert bindi=
ngs
> >> to json- schema
> >>
> >> On 02/03/2023 16:18, Aakarsh Jain wrote:
> >>>>
> >>>> iommus:
> >>>>   maxItems: 1
> >>>> iommu-names: false
> >>>>
> >>> I am getting compilation errors with above property set and its
> >>> breaking the
> >> bindings.
> >>> If we see these two nodes in dtsi files.
> >>>                mfc: codec=4013400000 =7B
> >>>                         compatible =3D =22samsung,mfc-v5=22; ..
> >>>                         iommus =3D <&sysmmu_mfc_l>, <&sysmmu_mfc_r>;
> >>>                         iommu-names =3D =22left=22, =22right=22; =7D =
And
> >>>               mfc: codec=4013400000 =7B
> >>>                         compatible =3D =22samsung,exynos3250-mfc=22, =
=22samsung,mfc-
> v7=22;
> >>>                         reg =3D <0x13400000 0x10000>; ...
> >>>                         iommus =3D <&sysmmu_mfc>;
> >>>                 =7D;
> >>> There is no iommu-names property for compatible
> =22samsung,exynos3250-
> >> mfc, samsung,mfc-v7=22, that=E2=80=99s=20why=20I=20kept=0D=0A>=20>>>=
=20=20=20=20=20=20=20=20=20iommus:=0D=0A>=20>>>=20=20=20=20=20=20=20=20=20=
=20=20minItems:=201=0D=0A>=20>>>=20=20=20=20=20=20=20=20=20=20=20maxItems:=
=202=0D=0A>=20>>>=20I=20would=20even=20go=20with=20below=20if=20you=20agree=
?=0D=0A>=20>>>=20=20=20=20=20=20=20=20=20iommus:=0D=0A>=20>>>=20=20=20=20=
=20=20=20=20=20=20=20minItems:=201=0D=0A>=20>>>=20=20=20=20=20=20=20=20=20=
=20=20maxItems:=202=0D=0A>=20>>>=20=20=20=20=20=20=20=20=20iommus-names:=20=
false=0D=0A>=20>>=0D=0A>=20>>=20No,=20I=20don't=20agree.=20Why=20do=20you=
=20need=20two=20IOMMUs=20for=20Exynos3250?=0D=0A>=20>>>=0D=0A>=20>=20Here=
=20IOMMUs=20minItems:1=20is=20meant=20for=20Exynos3250=20while=20IOMMUs=0D=
=0A>=20maxItems:2=20meant=20for=20samsung,mfc-v5(Exynos=204).=0D=0A>=20>=20=
As=20you=20suggested=0D=0A>=20>=20iommus:=0D=0A>=20>=20=20=20maxItems:=201=
=0D=0A>=20>=20iommu-names:=20false=0D=0A>=20>=0D=0A>=20>=20won't=20fit=20he=
re.=0D=0A>=20>=20Since=20IOMMUs=20maxItems=20is=202=20here=20for=20Exynos4.=
=20Giving=20maxItems:2=20alone=0D=0A>=20will=20also=20break=20the=20binding=
s.=20Thanks=20why=20suggested=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20iommu=
s:=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20=20minItems:=201=0D=0A>=20>=
=20=20=20=20=20=20=20=20=20=20=20=20maxItems:=202=0D=0A>=20=0D=0A>=20Are=20=
you=20sure=20you=20are=20putting=20this=20in=20correct=20place?=20This=20is=
=20if:then=20for=0D=0A>=20Exynos3250,=20isn't=20it?=0D=0A>=20=0D=0AIts=20no=
t=20only=20for=20Exynos3250,=20its=20along=20with=20Exynos4=20since=20their=
=20clock=20properties=20are=20same=0D=0AallOf:=0D=0A=20=20-=20if:=0D=0A=20=
=20=20=20=20=20properties:=0D=0A=20=20=20=20=20=20=20=20compatible:=0D=0A=
=20=20=20=20=20=20=20=20=20=20contains:=0D=0A=20=20=20=20=20=20=20=20=20=20=
=20=20enum:=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20-=20samsung,mfc-=
v5=20=20=20=20=20=20=20=20=23Exynos4=0D=0A=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20-=20samsung,exynos3250-mfc=0D=0A=20=20=20=20then:=0D=0A=20=20=20=
=20=20=20properties:=0D=0A=20=20=20=20=20=20=20=20clocks:=0D=0A=20=20=20=20=
=20=20=20=20=20=20maxItems:=202=0D=0A=20=20=20=20=20=20=20=20clock-names:=
=0D=0A=20=20=20=20=20=20=20=20=20=20items:=0D=0A=20=20=20=20=20=20=20=20=20=
=20=20=20-=20const:=20mfc=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20-=20cons=
t:=20sclk_mfc=0D=0A=20=20=20=20=20=20=20=20iommus:=0D=0A=20=20=20=20=20=20=
=20=20=20=20minItems:=201=0D=0A=20=20=20=20=20=20=20=20=20=20maxItems:=202=
=0D=0A=0D=0Aor=20do=20I=20keep=20different=20if:then=20condition=20for=20bo=
th=20Exynos3250=20and=20Exynos4=20for=20IOMMUs=20property=20?=0D=0A=0D=0A>=
=20Best=20regards,=0D=0A>=20Krzysztof=0D=0A=0D=0A=0D=0A
