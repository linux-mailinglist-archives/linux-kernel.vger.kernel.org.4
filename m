Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58256B1C6A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 08:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjCIHeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 02:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjCIHdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 02:33:55 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769D0498AB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 23:33:13 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230309073311epoutp04f4d5ea4bdf63a1c3f24df18196ffe982~Kr_Djh9zc1086510865epoutp04G
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 07:33:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230309073311epoutp04f4d5ea4bdf63a1c3f24df18196ffe982~Kr_Djh9zc1086510865epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678347191;
        bh=CtX1yiOu3XJuX2wdFvQpBWpk8V9CFVnbZFtPd7hs3UI=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=aLWFdakzCrz+FBleJBbkM+lQVhEWW8grMNvg6FL1h/Y0OE2mcPQO9pXo/D1oTgYj7
         bCLAYf1+2+XVNiC2Jh8om8whEUB/3QPuabXgoiyXPNIbDdSEY5AVwi0e2JB/sXj62T
         9MYvERF3JrcOIeex1YAoDyRwDU5jK8GLFy/CEm5w=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230309073310epcas5p3a8b1cedee1fe5ccabbea4db094c34d69~Kr_C6l90B2180721807epcas5p3X;
        Thu,  9 Mar 2023 07:33:10 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PXLWT1d1qz4x9QF; Thu,  9 Mar
        2023 07:33:09 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.B8.06765.5BB89046; Thu,  9 Mar 2023 16:33:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230309072232epcas5p4d2515cb78391464cfbb220e6ebb7d7e8~Kr0wHVZ5E0354903549epcas5p4K;
        Thu,  9 Mar 2023 07:22:32 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230309072232epsmtrp19a4defce70625e908648e9d8ca9036ed~Kr0wFJj202691026910epsmtrp1g;
        Thu,  9 Mar 2023 07:22:32 +0000 (GMT)
X-AuditID: b6c32a4b-46dfa70000011a6d-34-64098bb54476
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.05.31821.73989046; Thu,  9 Mar 2023 16:22:32 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230309072228epsmtip26321a5768aaaf27db7e58ddcf427a105~Kr0tCN05L0207602076epsmtip2f;
        Thu,  9 Mar 2023 07:22:28 +0000 (GMT)
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
In-Reply-To: <9b93849d-d4a4-67ba-e8a0-ee6c7209bd65@linaro.org>
Subject: RE: [Patch v6] dt-bindings: media: s5p-mfc: convert bindings to
 json-schema
Date:   Thu, 9 Mar 2023 12:52:27 +0530
Message-ID: <000701d95257$e97ebd50$bc7c37f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHxIgKtygHqPU4mHAhqu15r4A65nwLsA7LZAklDK9wB4osi/QJmoqxPrnZwD0A=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUxTVxjGc+69vW1N6u4QwqHbWNctbOqAdpTusgAukZhr0FFHZsgWwY7e
        0YbSdv1wSIZjQZABuknUjdIhA8QMQaVQYECjFIgDFjZEPtxAi+DKh0xT1iiIbC0XNv77vc95
        nvPmfU8OB/UrYfM5Ko2R1mvkaiG+BWvu2v5GqK2IqxC1O9mks7wZJ6ueuBDybtUiRjoabWyy
        6VYZSl68cZ1Fnu8eYJEtnfcwsmHGezpYOoGRrvOXATlrvoOTp2YmUdI+701Yp0ZY5FCbBSeL
        r9pYZH33BJu8MDqIkDXWFYSstP3NJvPs3WzyeH438m4gVVdeB6jWiWpAjVa7Ueon8wSbquqY
        RShr7Vc4NT7SgVON1V9QeT3LGHWqqRZQhd2jOLVoDab6PItsGe/D9GglLVfQegGtSdUqVJq0
        GGF8YsrulEipSBwqjiLfFgo08gw6Rhi3Txa6R6X2Ti8UHJGrTV5JJjcYhOGx0XqtyUgLlFqD
        MUZI6xRqnUQXZpBnGEyatDANbXxHLBK9Fek1Hk5X3lkYwnVjMPPPvDI0B5QEFAIOBxIS6HEE
        FoItHD+iHcD7C8dZTOEGcLziMc4UiwDa5h3oRmLJGc/obQDa3cMIU7gAdA32YoWAy8GJcHi3
        r3jtKn+iB0Bn0yTqK1DiBAZP38wBPheXiIV/NXoQH28jDsLJhgLcxxjxGqz4owT1MY+IgnO1
        RSyGn4e9pdNrHVBiJ6z5YX7NAwkBXLpfs+bxJ96D89fqccYTCHuWitc9XVxY+lDJcBx82vOA
        zfA2OHejaZ35cPbr/HVOhVOVs+tZNbzScQZjeBe8fsuC+VaBEtvhlbZwRn4Jnu27jDBtt8KT
        T6cRRufB1vINDoGW8Scshl+EXZcugG+A0LxpMvOmycybJjD/360CYLUgiNYZMtJoQ6QuQkN/
        9t+Dp2ozrGDtc+yIbwX3nI/CHADhAAeAHFToz3vM5yj8eAr50Sxar03Rm9S0wQEives+jfID
        UrXe36UxpoglUSKJVCqVREVIxcJA3usxval+RJrcSKfTtI7Wb+QQDpefgyT3nOynSxzHfrf+
        fPD7pEfXCv3+iXslhPvpCalR8P6h0X5FZNi5hdXgA2huZ8Gc/rfl5MrPlQv5wwGYRK/6mEok
        j40YY38tbnS0PxzzJKyMLdtDc1pWpTtj5Xzby8vfNlSG1L/6wsB+V5baMhnBfa75WbKHt3uv
        LbtNLws5l+zOzH5gPJRjUYeoho4KPthalrCX0/nJydtCfqv75kr4bXvWjGwyNyOzZqK/zCKN
        cpUflqYf2WWX5XYaOwPcw6opp+FN6BlYqVgd6L/6LGks/5fAXAMW/GMj1S+q22NqmCv4MmiI
        e/FAQvRH00VlStP+hKSi5rNBQ/tGEy+FVmW3rH7XJMQMSrl4B6o3yP8F4dRdv6UEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsWy7bCSvK5FJ2eKwaWpzBYP5m1js1j84zmT
        xf3Fn1ksDm3eym6x5cpsZovlxw+wWsw/co7VYvvBRywWG18AZS/OvMti8Xz+OkaLl7PusVn0
        vXjIbLH3NVDHpsfXWC0u75rDZtGzYSurxdojd9ktll6/yGSxbNMfJotFW7+wW7TuPcJu0dJ2
        hMlB3GPNvDWMHjvuLmH0uL7kE7PHzll32T0W73nJ5LFpVSebx51re9g8Ni+p92g9+ovFo2/L
        KkaPriPX2Tw+b5LzOPX1M3sAbxSXTUpqTmZZapG+XQJXxsIHh5kK3gpXHP79gamB8TpfFyMH
        h4SAicTPB95djFwcQgI7GCWuf9zM3MXICRSXkfjfdowdwhaWWPnvOTtE0VNGiRevdjKBJNgE
        9CXun+phBUmICJxklOg/0wLmMAvMZJG4OuEYE0TLAiaJ+y1LwOZyCthJvNv8FaxdWCBE4lfD
        VlYQm0VARWLB7UlgNbwClhKvVnWzQtiCEidnPmEBsZkFtCWe3nwKZy9b+BrqVgWJn0+XgdWL
        CPhJvN6/lg2iRlzi6M8e5gmMwrOQjJqFZNQsJKNmIWlZwMiyilEytaA4Nz232LDAKC+1XK84
        Mbe4NC9dLzk/dxMjOIFoae1g3LPqg94hRiYOxkOMEhzMSiK836U4UoR4UxIrq1KL8uOLSnNS
        iw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpg0pS+8/plZsZ+6+w/h+UK1v4/czZ5
        jvP53/d0BLU31WXNPmNf/zqEacEVtVNmszza/XanHrTul6pVePhe0v7nLBuVLzz57lM8BCZe
        4Vxqa/5TxLqpwkJ2+aUFJp5rnCyWSy5m+SVSlmJWfGfmtDz1qx0vw+wyewVstW9UzT26jVWR
        UWDGvQKt3PNnHhwODOA44dfbOXNV+5RM3u3vpt1m3/eqNOGCrbTntsbAjSxPz/T5ZGW26v81
        6vrR37/wXeezu+sMIx42RWROKRfcsfn8vOeaST6bLr6Oz7rYMqnpR/Ay4+g5PpxCaSo2vw63
        1nuKRwTtz2T6vUo/d6FeVFeZabfYuYPn/LX8Xj6UENqnxFKckWioxVxUnAgAvb7cBo8DAAA=
X-CMS-MailID: 20230309072232epcas5p4d2515cb78391464cfbb220e6ebb7d7e8
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
> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
> Sent: 09 March 2023 12:15
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
> On 02/03/2023 16:18, Aakarsh Jain wrote:
> >>
> >> iommus:
> >>   maxItems: 1
> >> iommu-names: false
> >>
> > I am getting compilation errors with above property set and its breakin=
g the
> bindings.
> > If we see these two nodes in dtsi files.
> >                mfc: codec=4013400000 =7B
> >                         compatible =3D =22samsung,mfc-v5=22; ..
> >                         iommus =3D <&sysmmu_mfc_l>, <&sysmmu_mfc_r>;
> >                         iommu-names =3D =22left=22, =22right=22; =7D An=
d
> >               mfc: codec=4013400000 =7B
> >                         compatible =3D =22samsung,exynos3250-mfc=22, =
=22samsung,mfc-v7=22;
> >                         reg =3D <0x13400000 0x10000>; ...
> >                         iommus =3D <&sysmmu_mfc>;
> >                 =7D;
> > There is no iommu-names property for compatible =22samsung,exynos3250-
> mfc, samsung,mfc-v7=22, that=E2=80=99s=20why=20I=20kept=0D=0A>=20>=20=20=
=20=20=20=20=20=20=20iommus:=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20min=
Items:=201=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20maxItems:=202=0D=0A>=
=20>=20I=20would=20even=20go=20with=20below=20if=20you=20agree?=0D=0A>=20>=
=20=20=20=20=20=20=20=20=20iommus:=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=
=20minItems:=201=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20maxItems:=202=
=0D=0A>=20>=20=20=20=20=20=20=20=20=20iommus-names:=20false=0D=0A>=20=0D=0A=
>=20No,=20I=20don't=20agree.=20Why=20do=20you=20need=20two=20IOMMUs=20for=
=20Exynos3250?=0D=0A>=20>=0D=0AHere=20IOMMUs=20minItems:1=20is=20meant=20fo=
r=20Exynos3250=20while=20IOMMUs=20maxItems:2=20meant=20for=20samsung,mfc-v5=
(Exynos=204).=0D=0AAs=20you=20suggested=20=0D=0Aiommus:=0D=0A=20=20maxItems=
:=201=0D=0Aiommu-names:=20false=0D=0A=0D=0Awon't=20fit=20here.=0D=0ASince=
=20IOMMUs=20maxItems=20is=202=20here=20for=20Exynos4.=20Giving=20maxItems:2=
=20alone=20will=20also=20break=20the=20bindings.=20Thanks=20why=20suggested=
=0D=0A=20=20=20=20=20=20=20=20=20iommus:=0D=0A=20=20=20=20=20=20=20=20=20=
=20=20minItems:=201=0D=0A=20=20=20=20=20=20=20=20=20=20=20maxItems:=202=0D=
=0A>=20=0D=0A>=20Best=20regards,=0D=0A>=20Krzysztof=0D=0A=0D=0A=0D=0A
