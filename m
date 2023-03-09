Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528206B1B66
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjCIGY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjCIGYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:24:21 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8682A992
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 22:24:11 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230309062408epoutp04f41124f13e798d8a43a682a093dcc387~KrBwj3dbG0750307503epoutp04N
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:24:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230309062408epoutp04f41124f13e798d8a43a682a093dcc387~KrBwj3dbG0750307503epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678343048;
        bh=oMuRtMBZbu6QIcFTGQXIfADnC5XOdXd13TOG3B6PnEA=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Df6YscW+nzTSRb0+FZ1JCMIpPbsS158Ctn7VRiJAnIyAlnEaGhnCX9Dw1Lo6Vl1NH
         F9Hd8jQ3EkhoB6sM6Gq/+1+owVYxfuBlfRlWmtU5AM5yYTioRykgIZw1Ed8U63XI0v
         0LJkG3zVE6zXVoNPjvxj+7Mc0d7pRYr4Ot5LzitI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230309062407epcas5p22deb6ea6bbc9a80216d636aeaa12f02a~KrBv9VqaT1110211102epcas5p2K;
        Thu,  9 Mar 2023 06:24:07 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PXJzn2m9Pz4x9QJ; Thu,  9 Mar
        2023 06:24:05 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.D0.06765.58B79046; Thu,  9 Mar 2023 15:24:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230309053806epcas5p2c3f51b51bac1cc20e2795034ea1ea627~KqZkYNW450609006090epcas5p2V;
        Thu,  9 Mar 2023 05:38:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230309053806epsmtrp1d21d28b206dde8032c5dc0f81017417b~KqZkXGp6j3015230152epsmtrp1O;
        Thu,  9 Mar 2023 05:38:06 +0000 (GMT)
X-AuditID: b6c32a4b-20fff70000011a6d-62-64097b85ffd6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.1B.18071.DB079046; Thu,  9 Mar 2023 14:38:06 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230309053802epsmtip1e5d259b2f2790633e77cef70041c582f~KqZhVdUxE2761227612epsmtip11;
        Thu,  9 Mar 2023 05:38:02 +0000 (GMT)
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
In-Reply-To: 
Subject: RE: [Patch v6] dt-bindings: media: s5p-mfc: convert bindings to
 json-schema
Date:   Thu, 9 Mar 2023 11:08:01 +0530
Message-ID: <000001d95249$52adea80$f809bf80$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHxIgKtygHqPU4mHAhqu15r4A65nwLsA7LZAklDK9yujjyZkIAKYsUQ
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxbVRjOuff2tix0XgHHkemCV5QPBVqh5fIpZmTebMMQF4wuLNi0N4VQ
        2q4tY4KOYixfgwHZlK3DgnyLjG2FAk5AbMvmGFnChuAUxreAGFlAZzfQ2dKi/Hve532f85zn
        nLwc1OMs24eTLtcwKrlIRuK7sC5LoH+wLtdNwusfcqemDV04VW9bRKip+nWMMneY2FTn6EWU
        ar4xwKJqrLdZVPd3sxh1dcneHbkwiVGLNe2AWtbfx6kzSzMo1bdiVxjnxljU3WvVOFV6xcSi
        Llkn2VTj+AhCNRk3EarO9Aeb0vVZ2dQnBVYk3ptuM7QBumeyAdDjDWso/bV+kk3X9y4jtLG1
        GKcnxnpxuqMhj9YNPsboM52tgC6xjuP0unEfPfTnOjuJezQjJo0RSRiVLyMXKyTpcmkseehI
        6v5UgZDHD+ZHUhGkr1yUycSSCYeTgg+ky+zpSd8TIlmWnUoSqdVkaFyMSpGlYXzTFGpNLMko
        JTJluDJELcpUZ8mlIXJGE8Xn8V4T2Affz0ibMtgw5UIZOLky3IxowVxOCXDjQCIcXtKa8BKw
        i+NBfAPg6mdLbGexBmBNzeeuzkMAp8ZXkW1JSdV511QfgNfvDCHOYhHAx+YqlmMKJ0Lh1FAp
        y9HwIgYBnO6cQR0FShRisPKOFpQADseN4MKKf6IdAk/iHThztQh30BjhB1ueCBw0l4iE5T/3
        Yk78NLx5YX4Lo8QrsOmLFdR5I1/4aKGJ5ZB6EQfgzHqYc8QbDj4q3XKFhMUN6nS1rgQJsOqc
        GTixJ/z1RifbiX3gcnmBC4vhXN2y63wZvNx7DnPi1+HAaDXm8EKJQHj5WqiTfh5+OtSOOH13
        w7KNeZcVF/YYtvHLsHrCxnLi56Dlq0ZQAUj9jmT6Hcn0OyLo/3erBVgreJZRqjOljFqgDJMz
        2f/9uFiRaQRb2xF0qAfMTj8IMQOEA8wAclDSi/uXD0fiwZWIPshhVIpUVZaMUZuBwP7alajP
        M2KFfb3kmlR+eCQvXCgUhkeGCfmkN9c/9qbYg5CKNEwGwygZ1bYO4bj5aJFK7Xl3+bx+42hi
        YeQva8l4tnoipCiiqDU/+v7wwBwSZztlSvktaunB7O29Zq6lujERS5z9sMvEsu2JyPsWHit8
        u288iHxhb3FuROiTt9r36RORluvte5IvykoLjsTc+uhe8bH4ZnlGtp8nkW/MkwYsvQjou+7D
        L/1Q9jAh5yBzUJgj8Oso331Fa+nK6B0TmQvAUyP5RE9d95zBEvhmxahuYjPej/4b/0naeryn
        rj6uZiAl9NWz/HeP80Js/SmbGwHZK93d99pyKz4WY+n9glVJ7WHFe50T/qcXTgtucVqE1gYd
        T5hceupLK877PiggulDz40l32QmzZ/Ybvy83aQKiSEydJuIHoSq16F97HlW4pgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsWy7bCSnO6+As4Ug39bmSwezNvGZrH4x3Mm
        i/uLP7NYHNq8ld1iy5XZzBbLjx9gtZh/5ByrxfaDj1gsNr4Ayl6ceZfF4vn8dYwWL2fdY7Po
        e/GQ2WLva6COTY+vsVpc3jWHzaJnw1ZWi7VH7rJbLL1+kcli2aY/TBaLtn5ht2jde4TdoqXt
        CJODuMeaeWsYPXbcXcLocX3JJ2aPnbPusnss3vOSyWPTqk42jzvX9rB5bF5S79F69BeLR9+W
        VYweXUeus3l83iTncerrZ/YA3igum5TUnMyy1CJ9uwSujGXnfrMXtBdUTPmyk72B8VFgFyMn
        h4SAiUTX9BnsXYxcHEICuxkl9jb2MUIkZCT+tx1jh7CFJVb+ew5V9JRR4u6SfawgCTYBfYn7
        p3pYQRIiAicZJfrPtIA5zAIzWSSuTjjGBNFykFHi4eqbzF2MHBycArwSE/5Zg3QLC4RI/GrY
        ygoSZhFQkVjx3xQkzCtgKdF/ew8LhC0ocXLmEzCbWUBb4unNp3D2soWvmSGuU5D4+XQZ2BgR
        ATeJh5+NIUrEJY7+7GGewCg8C8mkWUgmzUIyaRaSlgWMLKsYJVMLinPTc4sNCwzzUsv1ihNz
        i0vz0vWS83M3MYKTh5bmDsbtqz7oHWJk4mA8xCjBwawkwvtdiiNFiDclsbIqtSg/vqg0J7X4
        EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBiaJevv8K65b+0KKX/kzrZh/ZsvcafIT
        9BQYHd8vltUWNHwv99kncELBZ60Y9jzFGcyHE4qnWxovUa5YKeb8bXXFmbOpf051Zna+u9KR
        cfJB2OO4e4z/efze/7R5nnlksU3KC6EDbf872dZMedK0/uWSpZ45346sWuCWVy/4KCVui6cP
        +6eTauyhCUVV/9Oijp8W7unP2BLU7b3fpPDHygzVK48UJU8sucJ4ZPmWufw8T6edi76ktlRh
        6UmTF3u9SvTcf4vzqwboSdak1n3nfqg499//ihepE9rWbehczKWaLCaYdaNcZqGJqfOT/7f3
        mhlMOR3z+PS68MwHymFX9j6XStrnqHt9ce9VHSePV1+UWIozEg21mIuKEwH1QrgHjQMAAA==
X-CMS-MailID: 20230309053806epcas5p2c3f51b51bac1cc20e2795034ea1ea627
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
> From: Aakarsh Jain =5Bmailto:aakarsh.jain=40samsung.com=5D
> Sent: 02 March 2023 20:49
> To: 'Krzysztof Kozlowski' <krzysztof.kozlowski=40linaro.org>; 'linux-arm-
> kernel=40lists.infradead.org' <linux-arm-kernel=40lists.infradead.org>; '=
linux-
> media=40vger.kernel.org' <linux-media=40vger.kernel.org>; 'linux-
> kernel=40vger.kernel.org' <linux-kernel=40vger.kernel.org>;
> 'devicetree=40vger.kernel.org' <devicetree=40vger.kernel.org>
> Cc: 'm.szyprowski=40samsung.com' <m.szyprowski=40samsung.com>;
> 'andrzej.hajda=40intel.com' <andrzej.hajda=40intel.com>;
> 'mchehab=40kernel.org' <mchehab=40kernel.org>; 'hverkuil-cisco=40xs4all.n=
l'
> <hverkuil-cisco=40xs4all.nl>; 'ezequiel=40vanguardiasur.com.ar'
> <ezequiel=40vanguardiasur.com.ar>; 'jernej.skrabec=40gmail.com'
> <jernej.skrabec=40gmail.com>; 'benjamin.gaignard=40collabora.com'
> <benjamin.gaignard=40collabora.com>; 'krzysztof.kozlowski+dt=40linaro.org=
'
> <krzysztof.kozlowski+dt=40linaro.org>; 'stanimir.varbanov=40linaro.org'
> <stanimir.varbanov=40linaro.org>; 'dillon.minfei=40gmail.com'
> <dillon.minfei=40gmail.com>; 'david.plowman=40raspberrypi.com'
> <david.plowman=40raspberrypi.com>; 'mark.rutland=40arm.com'
> <mark.rutland=40arm.com>; 'robh+dt=40kernel.org' <robh+dt=40kernel.org>;
> 'krzk+dt=40kernel.org' <krzk+dt=40kernel.org>; 'andi=40etezian.org'
> <andi=40etezian.org>; 'alim.akhtar=40samsung.com'
> <alim.akhtar=40samsung.com>; 'aswani.reddy=40samsung.com'
> <aswani.reddy=40samsung.com>; 'pankaj.dubey=40samsung.com'
> <pankaj.dubey=40samsung.com>
> Subject: RE: =5BPatch v6=5D dt-bindings: media: s5p-mfc: convert bindings=
 to json-
> schema
>=20
>=20
>=20
> > -----Original Message-----
> > From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
> > Sent: 02 March 2023 14:07
> > To: Aakarsh Jain <aakarsh.jain=40samsung.com>; linux-arm-
> > kernel=40lists.infradead.org; linux-media=40vger.kernel.org; linux-
> > kernel=40vger.kernel.org; devicetree=40vger.kernel.org
> > Cc: m.szyprowski=40samsung.com; andrzej.hajda=40intel.com;
> > mchehab=40kernel.org; hverkuil-cisco=40xs4all.nl;
> > ezequiel=40vanguardiasur.com.ar; jernej.skrabec=40gmail.com;
> > benjamin.gaignard=40collabora.com; krzysztof.kozlowski+dt=40linaro.org;
> > stanimir.varbanov=40linaro.org; dillon.minfei=40gmail.com;
> > david.plowman=40raspberrypi.com; mark.rutland=40arm.com;
> > robh+dt=40kernel.org; krzk+dt=40kernel.org; andi=40etezian.org;
> > alim.akhtar=40samsung.com; aswani.reddy=40samsung.com;
> > pankaj.dubey=40samsung.com
> > Subject: Re: =5BPatch v6=5D dt-bindings: media: s5p-mfc: convert bindin=
gs
> > to json- schema
> >
> > On 01/03/2023 04:51, Aakarsh Jain wrote:
> > > Convert s5p-mfc bindings to DT schema format using json-schema.
> > >
> > > Signed-off-by: Aakarsh Jain <aakarsh.jain=40samsung.com>
> > > ---
> > > changes since v5:
> > > kept compatible strings under enum
> > > sorted compatible strings
> > > added iommu maxItems:2
> > > Added indentation with 4 spaces in dts example
> > >
> > > changes since v4:
> > > Removed items from oneOf section
> > > dropped black line
> > > defined the iommus names items as
> > > items:
> > > -const left
> > > -const right
> > >
> > > changes since v3:
> > > fixed dt-schema warnings and errors while running make dtbs_check
> > > and make dt_binding_check for ARMv7 Since, obsolete properties are
> > > not part
> > of dt-node so we are not including these properties in dt-schema.
> > >
> > > changes since v2:
> > > changed Commit message from Adds to Convert Removed text =22This file
> > > has moved to samsung,s5p-mfc.yaml=22 from s5p-mfc.txt fixed dt-schema
> > > warnings and errors while running make dtbs_check and make
> > > dt_binding_check
> > >
> > > changes since v1:
> > > fixed dt-schema warnings and errors while running make dtbs_check
> > > and make dt_binding_check Removed description.
> > > Listed items.
> > > Added allOf:if:then for restricting two items to specific compatible
> > >
> > > This patch is independent from the previous MFC v12 patch series for
> > > HW3
> > support.
> > >
> > >  .../devicetree/bindings/media/s5p-mfc.txt     =7C  78 ---------
> > >  .../bindings/media/samsung,s5p-mfc.yaml       =7C 151
> > ++++++++++++++++++
> > >  2 files changed, 151 insertions(+), 78 deletions(-)  create mode
> > > 100644 Documentation/devicetree/bindings/media/samsung,s5p-
> mfc.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.txt
> > > b/Documentation/devicetree/bindings/media/s5p-mfc.txt
> > > index 8eb90c043d5d..e69de29bb2d1 100644
> > > --- a/Documentation/devicetree/bindings/media/s5p-mfc.txt
> > > +++ b/Documentation/devicetree/bindings/media/s5p-mfc.txt
> > > =40=40 -1,78 +0,0 =40=40
> > > -* Samsung Multi Format Codec (MFC)
> > > -
> > > -Multi Format Codec (MFC) is the IP present in Samsung SoCs which
> > > -supports high resolution decoding and encoding functionalities.
> > > -The MFC device driver is a v4l2 driver which can encode/decode
> > > -video raw/elementary streams and has support for all popular -video
> codecs.
> > > -
> > > -Required properties:
> > > -  - compatible : value should be either one among the following
> > > -	(a) =22samsung,mfc-v5=22 for MFC v5 present in Exynos4 SoCs
> > > -	(b) =22samsung,mfc-v6=22 for MFC v6 present in Exynos5 SoCs
> > > -	(c) =22samsung,exynos3250-mfc=22, =22samsung,mfc-v7=22 for MFC v7
> > > -	     present in Exynos3250 SoC
> > > -	(d) =22samsung,mfc-v7=22 for MFC v7 present in Exynos5420 SoC
> > > -	(e) =22samsung,mfc-v8=22 for MFC v8 present in Exynos5800 SoC
> > > -	(f) =22samsung,exynos5433-mfc=22 for MFC v8 present in Exynos5433 S=
oC
> > > -	(g) =22samsung,mfc-v10=22 for MFC v10 present in Exynos7880 SoC
> > > -
> > > -  - reg : Physical base address of the IP registers and length of me=
mory
> > > -	  mapped region.
> > > -
> > > -  - interrupts : MFC interrupt number to the CPU.
> > > -  - clocks : from common clock binding: handle to mfc clock.
> > > -  - clock-names : from common clock binding: must contain =22mfc=22,
> > > -		  corresponding to entry in the clocks property.
> > > -
> > > -Optional properties:
> > > -  - power-domains : power-domain property defined with a phandle
> > > -			   to respective power domain.
> > > -  - memory-region : from reserved memory binding: phandles to two
> > reserved
> > > -	memory regions, first is for =22left=22 mfc memory bus interfaces,
> > > -	second if for the =22right=22 mfc memory bus, used when no SYSMMU
> > > -	support is available; used only by MFC v5 present in Exynos4 SoCs
> > > -
> > > -Obsolete properties:
> > > -  - samsung,mfc-r, samsung,mfc-l : support removed, please use
> > > memory-
> > region
> > > -	property instead
> > > -
> > > -
> > > -Example:
> > > -SoC specific DT entry:
> > > -
> > > -mfc: codec=4013400000 =7B
> > > -	compatible =3D =22samsung,mfc-v5=22;
> > > -	reg =3D <0x13400000 0x10000>;
> > > -	interrupts =3D <0 94 0>;
> > > -	power-domains =3D <&pd_mfc>;
> > > -	clocks =3D <&clock 273>;
> > > -	clock-names =3D =22mfc=22;
> > > -=7D;
> > > -
> > > -Reserved memory specific DT entry for given board (see reserved
> > > memory binding -for more information):
> > > -
> > > -reserved-memory =7B
> > > -	=23address-cells =3D <1>;
> > > -	=23size-cells =3D <1>;
> > > -	ranges;
> > > -
> > > -	mfc_left: region=4051000000 =7B
> > > -		compatible =3D =22shared-dma-pool=22;
> > > -		no-map;
> > > -		reg =3D <0x51000000 0x800000>;
> > > -	=7D;
> > > -
> > > -	mfc_right: region=4043000000 =7B
> > > -		compatible =3D =22shared-dma-pool=22;
> > > -		no-map;
> > > -		reg =3D <0x43000000 0x800000>;
> > > -	=7D;
> > > -=7D;
> > > -
> > > -Board specific DT entry:
> > > -
> > > -codec=4013400000 =7B
> > > -	memory-region =3D <&mfc_left>, <&mfc_right>;
> > > -=7D;
> > > diff --git
> > > a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> > > b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> > > index 000000000000..da48d0493cdd
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/media/samsung,s5p-
> mfc.yaml
> > > =40=40 -0,0 +1,151 =40=40
> > > +=23 SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause %YAML 1.2
> > > +---
> > > +=24id:
> > > +https://protect2.fireeye.com/v1/url?k=3Dd24ef7e4-8dd5cefd-d24f7cab-
> > 000b
> > > +abff3793-d3511b88da8176a3&q=3D1&e=3D3ebd99e2-81bd-4303-988b-
> > 085ab2449cc1&
> > >
> >
> +u=3Dhttp%3A%2F%2Fdevicetree.org%2Fschemas%2Fmedia%2Fsamsung%2Cs
> > 5p-mfc.y
> > > +aml%23
> > > +=24schema:
> > > +https://protect2.fireeye.com/v1/url?k=3D5aeac908-0571f011-5aeb4247-
> > 000b
> > > +abff3793-01e9fec8ce4d48cc&q=3D1&e=3D3ebd99e2-81bd-4303-988b-
> > 085ab2449cc1&
> > > +u=3Dhttp%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
> > > +
> > > +title: Samsung Exynos Multi Format Codec (MFC)
> > > +
> > > +maintainers:
> > > +  - Marek Szyprowski <m.szyprowski=40samsung.com>
> > > +  - Aakarsh Jain <aakarsh.jain=40samsung.com>
> > > +
> > > +description:
> > > +  Multi Format Codec (MFC) is the IP present in Samsung SoCs which
> > > +  supports high resolution decoding and encoding functionalities.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - enum:
> > > +          - samsung,exynos5433-mfc        =23 Exynos5433
> > > +          - samsung,mfc-v5                =23 Exynos4
> > > +          - samsung,mfc-v6                =23 Exynos5
> > > +          - samsung,mfc-v7                =23 Exynos5420
> > > +          - samsung,mfc-v8                =23 Exynos5800
> > > +          - samsung,mfc-v10               =23 Exynos7880
> > > +      - items:
> > > +          - enum:
> > > +              - samsung,exynos3250-mfc    =23 Exynos3250
> > > +          - const: samsung,mfc-v7         =23 Fall back for Exynos32=
50
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    minItems: 1
> > > +    maxItems: 3
> > > +
> > > +  clock-names:
> > > +    minItems: 1
> > > +    maxItems: 3
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  iommus:
> > > +    minItems: 1
> > > +    maxItems: 2
> > > +
> > > +  iommu-names:
> > > +    items:
> > > +      - const: left
> > > +      - const: right
> >
> > That's confusing now... The iommu-names above says it requires two
> > iommus, but your iommus property says one item is enough. You need
> > here
> > minItems: 1... but then why one IOMMU (for such variants) is always
> =22left=22?
> > Probably then the meaning of first IOMMU changes, right? If that's
> > correct, then I propose to leave it as minItems:1/maxItems:2 without
> > defining the items here and...
> >
> Agreed. That=E2=80=99s=20why=20I=20initially=20kept=20=20as=20minItems:1/=
maxItems:2.=20=20Will=20keep=20it=0D=0A>=20now=20as=20it=20is.=0D=0A>=20=20=
=20iommu-names:=0D=0A>=20=20=20=20=20minItems:=201=0D=0A>=20=20=20=20=20max=
Items:=202=0D=0A>=20>=20>=20+=0D=0A>=20>=20>=20+=20=20power-domains:=0D=0A>=
=20>=20>=20+=20=20=20=20maxItems:=201=0D=0A>=20>=20>=20+=0D=0A>=20>=20>=20+=
=20=20memory-region:=0D=0A>=20>=20>=20+=20=20=20=20minItems:=201=0D=0A>=20>=
=20>=20+=20=20=20=20maxItems:=202=0D=0A>=20>=20>=20+=0D=0A>=20>=20>=20+requ=
ired:=0D=0A>=20>=20>=20+=20=20-=20compatible=0D=0A>=20>=20>=20+=20=20-=20re=
g=0D=0A>=20>=20>=20+=20=20-=20clocks=0D=0A>=20>=20>=20+=20=20-=20clock-name=
s=0D=0A>=20>=20>=20+=20=20-=20interrupts=0D=0A>=20>=20>=20+=0D=0A>=20>=20>=
=20+additionalProperties:=20false=0D=0A>=20>=20>=20+=0D=0A>=20>=20>=20+allO=
f:=0D=0A>=20>=20>=20+=20=20-=20if:=0D=0A>=20>=20>=20+=20=20=20=20=20=20prop=
erties:=0D=0A>=20>=20>=20+=20=20=20=20=20=20=20=20compatible:=0D=0A>=20>=20=
>=20+=20=20=20=20=20=20=20=20=20=20contains:=0D=0A>=20>=20>=20+=20=20=20=20=
=20=20=20=20=20=20=20=20enum:=0D=0A>=20>=20>=20+=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20-=20samsung,mfc-v5=0D=0A>=20>=20>=20+=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20-=20samsung,exynos3250-mfc=0D=0A>=20>=20>=20+=20=20=20=
=20then:=0D=0A>=20>=20>=20+=20=20=20=20=20=20properties:=0D=0A>=20>=20>=20+=
=20=20=20=20=20=20=20=20clocks:=0D=0A>=20>=20>=20+=20=20=20=20=20=20=20=20=
=20=20maxItems:=202=0D=0A>=20>=20>=20+=20=20=20=20=20=20=20=20clock-names:=
=0D=0A>=20>=20>=20+=20=20=20=20=20=20=20=20=20=20items:=0D=0A>=20>=20>=20+=
=20=20=20=20=20=20=20=20=20=20=20=20-=20const:=20mfc=0D=0A>=20>=20>=20+=20=
=20=20=20=20=20=20=20=20=20=20=20-=20const:=20sclk_mfc=0D=0A>=20>=0D=0A>=20=
>=20iommus:=0D=0A>=20>=20=20=20maxItems:=201=0D=0A>=20>=20iommu-names:=20fa=
lse=0D=0A>=20>=0D=0A>=20I=20am=20getting=20compilation=20errors=20with=20ab=
ove=20property=20set=20and=20its=20breaking=20the=0D=0A>=20bindings.=0D=0A>=
=20If=20we=20see=20these=20two=20nodes=20in=20dtsi=20files.=0D=0A>=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20mfc:=20codec=4013400000=20=7B=0D=0A>=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
compatible=20=3D=20=22samsung,mfc-v5=22;=20..=0D=0A>=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20iommus=20=3D=20<&sysm=
mu_mfc_l>,=20<&sysmmu_mfc_r>;=0D=0A>=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20iommu-names=20=3D=20=22left=22,=20=22ri=
ght=22;=20=7D=20And=0D=0A>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20mfc:=
=20codec=4013400000=20=7B=0D=0A>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20compatible=20=3D=20=22samsung,exynos3250-m=
fc=22,=20=22samsung,mfc-v7=22;=0D=0A>=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20reg=20=3D=20<0x13400000=200x10000>;=
=20...=0D=0A>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20iommus=20=3D=20<&sysmmu_mfc>;=0D=0A>=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=7D;=0D=0A>=20There=20is=20no=20iommu-names=20pr=
operty=20for=20compatible=20=22samsung,exynos3250-=0D=0A>=20mfc,=20samsung,=
mfc-v7=22,=20that=E2=80=99s=20why=20I=20kept=0D=0A>=20=20=20=20=20=20=20=20=
=20iommus:=0D=0A>=20=20=20=20=20=20=20=20=20=20=20minItems:=201=0D=0A>=20=
=20=20=20=20=20=20=20=20=20=20maxItems:=202=0D=0A>=20I=20would=20even=20go=
=20with=20below=20if=20you=20agree?=0D=0A>=20=20=20=20=20=20=20=20=20iommus=
:=0D=0A>=20=20=20=20=20=20=20=20=20=20=20minItems:=201=0D=0A>=20=20=20=20=
=20=20=20=20=20=20=20maxItems:=202=0D=0A>=20=20=20=20=20=20=20=20=20iommus-=
names:=20false=0D=0A>=20=0D=0AHi=20Krzysztof,=0D=0AAny=20suggestions=20here=
?=0D=0A>=20>=20>=20+=0D=0A>=20>=20>=20+=20=20-=20if:=0D=0A>=20>=20>=20+=20=
=20=20=20=20=20properties:=0D=0A>=20>=20>=20+=20=20=20=20=20=20=20=20compat=
ible:=0D=0A>=20>=20>=20+=20=20=20=20=20=20=20=20=20=20contains:=0D=0A>=20>=
=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20enum:=0D=0A>=20>=20>=20+=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20-=20samsung,mfc-v6=0D=0A>=20>=20>=20+=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20-=20samsung,mfc-v8=0D=0A>=20>=20>=
=20+=20=20=20=20then:=0D=0A>=20>=20>=20+=20=20=20=20=20=20properties:=0D=0A=
>=20>=20>=20+=20=20=20=20=20=20=20=20clocks:=0D=0A>=20>=20>=20+=20=20=20=20=
=20=20=20=20=20=20maxItems:=201=0D=0A>=20>=20>=20+=20=20=20=20=20=20=20=20c=
lock-names:=0D=0A>=20>=20>=20+=20=20=20=20=20=20=20=20=20=20items:=0D=0A>=
=20>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20-=20const:=20mfc=0D=0A>=20>=
=20>=20+=20=20=20=20=20=20=20=20iommus:=0D=0A>=20>=20>=20+=20=20=20=20=20=
=20=20=20=20=20maxItems:=202=0D=0A>=20>=0D=0A>=20>=20...=20and=20here:=0D=
=0A>=20>=20iommu-names:=0D=0A>=20>=20=20=20items:=0D=0A>=20>=20=20=20=20=20=
-=20const:=20left=0D=0A>=20>=20=20=20=20=20-=20const:=20right=0D=0A>=20>=0D=
=0A>=20Agreed.=0D=0A>=20>=20>=20+=0D=0A>=20>=20>=20+=20=20-=20if:=0D=0A>=20=
>=20>=20+=20=20=20=20=20=20properties:=0D=0A>=20>=20>=20+=20=20=20=20=20=20=
=20=20compatible:=0D=0A>=20>=20>=20+=20=20=20=20=20=20=20=20=20=20contains:=
=0D=0A>=20>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20enum:=0D=0A>=20>=20>=
=20+=20=20=20=20=20=20=20=20=20=20=20=20=20=20-=20samsung,exynos5433-mfc=0D=
=0A>=20>=20>=20+=20=20=20=20then:=0D=0A>=20>=20>=20+=20=20=20=20=20=20prope=
rties:=0D=0A>=20>=20>=20+=20=20=20=20=20=20=20=20clocks:=0D=0A>=20>=20>=20+=
=20=20=20=20=20=20=20=20=20=20maxItems:=203=0D=0A>=20>=20>=20+=20=20=20=20=
=20=20=20=20clock-names:=0D=0A>=20>=20>=20+=20=20=20=20=20=20=20=20=20=20it=
ems:=0D=0A>=20>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20-=20const:=20pcl=
k=0D=0A>=20>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20-=20const:=20aclk=
=0D=0A>=20>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20-=20const:=20aclk_xi=
u=0D=0A>=20>=20>=20+=20=20=20=20=20=20=20=20iommus:=0D=0A>=20>=20>=20+=20=
=20=20=20=20=20=20=20=20=20maxItems:=202=0D=0A>=20>=0D=0A>=20>=20the=20same=
=20here=0D=0A>=20>=0D=0A>=20Agreed.=0D=0A>=20>=20>=20+=0D=0A>=20>=20>=20+=
=20=20-=20if:=0D=0A>=20>=20>=20+=20=20=20=20=20=20properties:=0D=0A>=20>=20=
>=20+=20=20=20=20=20=20=20=20compatible:=0D=0A>=20>=20>=20+=20=20=20=20=20=
=20=20=20=20=20contains:=0D=0A>=20>=20>=20+=20=20=20=20=20=20=20=20=20=20=
=20=20enum:=0D=0A>=20>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20=20=20-=
=20samsung,mfc-v7=0D=0A>=20>=20>=20+=20=20=20=20then:=0D=0A>=20>=20>=20+=20=
=20=20=20=20=20properties:=0D=0A>=20>=20>=20+=20=20=20=20=20=20=20=20clocks=
:=0D=0A>=20>=20>=20+=20=20=20=20=20=20=20=20=20=20minItems:=201=0D=0A>=20>=
=20>=20+=20=20=20=20=20=20=20=20=20=20maxItems:=202=0D=0A>=20>=0D=0A>=20>=
=20iommus:=0D=0A>=20>=20=20=20maxItems:=201=0D=0A>=20>=20iommu-names:=20fal=
se=0D=0A>=20same=20explanation=20as=20above.=20Would=20prefer=20to=20go=20w=
ith=0D=0A>=20=20=20=20=20=20=20=20=20iommus:=0D=0A>=20=20=20=20=20=20=20=20=
=20=20=20minItems:=201=0D=0A>=20=20=20=20=20=20=20=20=20=20=20maxItems:=202=
=0D=0A>=20=20=20=20=20=20=20=20=20iommus-names:=20false=0D=0A>=20>=0D=0A>=
=20>=0D=0A>=20>=20Best=20regards,=0D=0A>=20>=20Krzysztof=0D=0A>=20=0D=0A>=
=20Thanks=20for=20the=20review.=0D=0A=0D=0A
