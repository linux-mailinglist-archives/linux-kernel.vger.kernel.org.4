Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C6C6109EE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 07:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJ1FzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 01:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJ1FzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 01:55:10 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569D24361D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 22:55:08 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221028055505epoutp02391ffc9694490194f4c6d2820155383d~iJet9bW6N1407514075epoutp02l
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 05:55:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221028055505epoutp02391ffc9694490194f4c6d2820155383d~iJet9bW6N1407514075epoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1666936505;
        bh=bs6Fi9y3vLm3UnBEo12wgY2EJ5s6terAkHbpUuhYef0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=sQC3LTk/vjW0l6zwTW9Cffehvh7LJF/Wk8FqUFENXPPsHqvd4hASxpQoS27+nDY7N
         fVVX4t4V4bNPArluoCnLLClpPSjUEvBkdsInz5oHZthbBw7KbQoZi2sLheEkurTcz+
         xglmviCM1TOMPw48xClgudEH4+Ktp6mYj7ZiGnIo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221028055504epcas5p4b2bc70d767029a4a5979ec5eca3bfcf6~iJesytC1U2520925209epcas5p4t;
        Fri, 28 Oct 2022 05:55:04 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4MzBb60dv0z4x9Q1; Fri, 28 Oct
        2022 05:54:58 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        32.14.01710.BAE6B536; Fri, 28 Oct 2022 14:54:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221028043739epcas5p24172f567184e6f50142ad5b3cd8fef89~iIbGonLg10889808898epcas5p2Y;
        Fri, 28 Oct 2022 04:37:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221028043738epsmtrp1fd2c68051ebfe2ae69ae6de33111264c~iIbGmjxW12804928049epsmtrp19;
        Fri, 28 Oct 2022 04:37:38 +0000 (GMT)
X-AuditID: b6c32a49-a41ff700000006ae-9a-635b6eab1c00
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.06.14392.29C5B536; Fri, 28 Oct 2022 13:37:38 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221028043735epsmtip2f2654f687251735502b819e7a86ba2b1~iIbDieOXd2225022250epsmtip2u;
        Fri, 28 Oct 2022 04:37:35 +0000 (GMT)
From:   "Aakarsh Jain" <aakarsh.jain@samsung.com>
To:     "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     <m.szyprowski@samsung.com>, <andrzej.hajda@intel.com>,
        <mchehab@kernel.org>, <hverkuil-cisco@xs4all.nl>,
        <ezequiel@vanguardiasur.com.ar>, <jernej.skrabec@gmail.com>,
        <benjamin.gaignard@collabora.com>, <stanimir.varbanov@linaro.org>,
        <dillon.minfei@gmail.com>, <david.plowman@raspberrypi.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <andi@etezian.org>, <aswani.reddy@samsung.com>,
        <pankaj.dubey@samsung.com>, <linux-fsd@tesla.com>,
        <smitha.t@samsung.com>
In-Reply-To: <000c01d8e9f0$764e5ea0$62eb1be0$@samsung.com>
Subject: RE: [Patch v3 01/15] dt-bindings: media: s5p-mfc: Add new DT schema
 for MFC
Date:   Fri, 28 Oct 2022 10:07:33 +0530
Message-ID: <026501d8ea87$024d1400$06e73c00$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIjXZOHgvokXGuofbg3rWbxTFZEMQGGfBLcASb/h3kBiXArEK1smYlQ
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf1CTdRzH+z7Psx9Qw0dA+boDj1YgzgM2g/lAzOpm6yGsKE+9qAPmeAKO
        se32DDOKog5Rd6Rg5skYTAQhAUXGQFLoYIzQ3WHBCKJcID8kwLuMXydoXvuBxX+vz+f7ed/7
        +/5878tGfc+wuOxMpZbSKGUKHtMba+3eHhbeoPxALuirQ4mxilYmUfVwGiFGqxYwwtLcwiLM
        g2UoUdvbySCM1tsM4lrXOEY0/ek87S91YMS08QogZvR/MAnTxBCDuDt7kLBfNzCJoqstDOKy
        1cEiLg73I0SN6TFCXGhZZBFHO6wswtHeCoiCQivyagDZUNEAyDZHNSCHq+dR8nu9g0VWtc8g
        pKnuBJO8M9TOJJurvyCP9qxi5ElzHSCffFXOInXWYSa5YNpK2pYWWIk+SVlxGZQsjdIEU0q5
        Ki1TmS7mJexLkaREiwTCcGEMsYsXrJRlU2Lenr2J4dJMhXMDvODDMkWOs5Uoo2le5O44jSpH
        SwVnqGitmEep0xTqKHUELcumc5TpEUpKGysUCHZGOwdTszIG+8pQtSHlyF8D2/LBQIIOeLEh
        HgWnuiZYLvbFbwDY0vWhDng7eR7Ax10nUE+xDGD/pXJEB9huRVulxtPvALC37SrmUU8D2Din
        dTETj4SjtiKGa8gfbwWw/fhtzFWg+CIKTxcY3X5eeCycGrjPdLEffgAWWB8yXIzhIXDk3qrb
        jYPHwGVjsqvNwTfCW6WTbjMU3wFrKudQT4RguDJV45b641LYZL+xNhMAe1aK3AkgPuAFzSUz
        iEewBy5XXsM87Adne80sD3PhzKnCNZbDiQszawYK2Nh+Zm3+Fdg5aMBcd0Px7bDxeqSnHQS/
        tV1BPL4+8OtHk2tWHNhW8ZRDoeGOJyLEA2F3/UVQDHj6ddH066Lp10XQ/+92HmB1YAulprPT
        KTpaLVRSH//33HJVtgm4vwc/vg04xh5EWADCBhYA2SjPn9P360G5LydN9kkupVGlaHIUFG0B
        0c51l6DcTXKV838ptSnCqBhBlEgkiop5SSTkBXCqzvHlvni6TEtlUZSa0jzVIWwvbj5SLvZ7
        tG/SPnh8a+dsCSKR1j5z8lbYC4feKeBfZjT75FZ+s38kL7AECaWDdqQ+BwLvnp1IzI2/NzKt
        yR1O5q4sSec2H8kb/T3OftyeGaR7I+x5u1+XKeC3wh9DzxVLK3R5n/rFGw8YOGk/SG9+lIC+
        dZ4lDL455b06b+Nv+Oc7/uLburBAG7Wh4/Be23hvkyjZOAbZXz5Ld1vMWUllGz8r2nnswbug
        nWug6Y43i+8rBEMhu2fzxZ+vlr137NL8fnu9WLy6bYskevwX0ftJqrLspKWGvyUh5ac2bT79
        +s9hPeaMsxJ9ffOhgtKsn17MbYptrQiMS3oSMiOslaRmvmbEXrY07eJhdIZMyEc1tOxfObC3
        XqcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsWy7bCSvO6kmOhkg5VHTC0ezNvGZrH4x3Mm
        i/uLP7NYHNq8ld1iy5XZzBbLjx9gtZh/5ByrxfaDj1gsNr4Ayl6ceZfF4vn8dYwWL2fdY7PY
        9Pgaq8XDV+EWl3fNYbPo2bCV1WLtkbvsFkuvX2SyWLbpD5PFoq1f2C1a9x5ht7i7ZxujRUvb
        ESYHcY8189Yweuy4u4TR4/qST8weO2fdZfdYvOclk8emVZ1sHneu7WHz2Lyk3qP16C8Wj74t
        qxg9/jXNZffoOnKdzePzJjmPU18/swfwRXHZpKTmZJalFunbJXBlbFonWNAYXnFt3TvGBsZe
        xy5GDg4JAROJHQuLuhi5OIQEdjNKzD98g7GLkRMoLiPxv+0YO4QtLLHy33N2iKKnjBL9l4+x
        gCTYBPQl7p/qYQVJiAjsYpQ4+uowC4jDLNDBIjF76gw2iJb3jBILTq5jBWnhFLCSeHrpDRvI
        bmGBEInd3+pAwiwCqhI3n/1iAgnzClhKfJsfBxLmFRCUODnzCdgyZgFtiac3n8LZyxa+Zoa4
        TkHi59NlYNNFBNwkNl7eDVUjLnH0Zw/zBEbhWUhGzUIyahaSUbOQtCxgZFnFKJlaUJybnlts
        WGCYl1quV5yYW1yal66XnJ+7iRGcQrQ0dzBuX/VB7xAjEwfjIUYJDmYlEd6zN8KThXhTEiur
        Uovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamBiX37PWe3/DobMLVMW
        3DtiNCfvfW0AN4OmN9Nxk5pPTBaGio4ykc/uzlVzLTCT+/7IKeFr13QBlzlnbyxb+pVjTpra
        ujsHPK6WdT41Xu1113Wl7ao/OnXpmXNmJWw/FBggdNLthkW5gVjG0RybWVvYlvTsZDXZGbz5
        /c+trsuXSj50FLfZH3Z0b+DscvPGOyvKD4fF/3miull6dYbc5UAWmYzb/xdPFpUr/TZ7QakJ
        Y+ctOdP/X5wfPizblPRKef7spsRHPZa/L8XO4fdVbZ3EEntbtuKycbDOQn1uu/xMYfVq95aT
        t95fOGrQZCa+yLZNh0dIMKQw/ZbpcfdNa5Yck3JyCP7YGW7+/Wv6zY9KLMUZiYZazEXFiQB7
        gZ3AkAMAAA==
X-CMS-MailID: 20221028043739epcas5p24172f567184e6f50142ad5b3cd8fef89
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221011125142epcas5p13c858a5f27830fb1de50fa51e9730eca
References: <20221011122516.32135-1-aakarsh.jain@samsung.com>
        <CGME20221011125142epcas5p13c858a5f27830fb1de50fa51e9730eca@epcas5p1.samsung.com>
        <20221011122516.32135-2-aakarsh.jain@samsung.com>
        <000c01d8e9f0$764e5ea0$62eb1be0$@samsung.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Alim Akhtar =5Bmailto:alim.akhtar=40samsung.com=5D
> Sent: 27 October 2022 16:10
> To: 'aakarsh jain' <aakarsh.jain=40samsung.com>; linux-arm-
> kernel=40lists.infradead.org; linux-media=40vger.kernel.org; linux-
> kernel=40vger.kernel.org; devicetree=40vger.kernel.org
> Cc: m.szyprowski=40samsung.com; andrzej.hajda=40intel.com;
> mchehab=40kernel.org; hverkuil-cisco=40xs4all.nl;
> ezequiel=40vanguardiasur.com.ar; jernej.skrabec=40gmail.com;
> benjamin.gaignard=40collabora.com; stanimir.varbanov=40linaro.org;
> dillon.minfei=40gmail.com; david.plowman=40raspberrypi.com;
> mark.rutland=40arm.com; robh+dt=40kernel.org; krzk+dt=40kernel.org;
> andi=40etezian.org; aswani.reddy=40samsung.com;
> pankaj.dubey=40samsung.com; linux-fsd=40tesla.com; smitha.t=40samsung.com
> Subject: RE: =5BPatch v3 01/15=5D dt-bindings: media: s5p-mfc: Add new DT
> schema for MFC
>=20
> Hi Aakarsh
> Thanks for the patch.
>=20
> >-----Original Message-----
> >From: aakarsh jain =5Bmailto:aakarsh.jain=40samsung.com=5D
> >Sent: Tuesday, October 11, 2022 5:55 PM
> >To: linux-arm-kernel=40lists.infradead.org; linux-media=40vger.kernel.or=
g;
> >linux- kernel=40vger.kernel.org; devicetree=40vger.kernel.org
> >Cc: m.szyprowski=40samsung.com; andrzej.hajda=40intel.com;
> >mchehab=40kernel.org; hverkuil-cisco=40xs4all.nl;
> >ezequiel=40vanguardiasur.com.ar; jernej.skrabec=40gmail.com;
> >benjamin.gaignard=40collabora.com; stanimir.varbanov=40linaro.org;
> >dillon.minfei=40gmail.com; david.plowman=40raspberrypi.com;
> >mark.rutland=40arm.com; robh+dt=40kernel.org; krzk+dt=40kernel.org;
> >andi=40etezian.org; alim.akhtar=40samsung.com;
> aswani.reddy=40samsung.com;
> >pankaj.dubey=40samsung.com; linux-fsd=40tesla.com;
> smitha.t=40samsung.com;
> >aakarsh.jain=40samsung.com
> >Subject: =5BPatch v3 01/15=5D dt-bindings: media: s5p-mfc: Add new DT
> >schema for MFC
> >
> >From: Smitha T Murthy <smitha.t=40samsung.com>
> >
> >Convert DT schema for s5p-mfc in yaml format
> >
> >Cc: linux-fsd=40tesla.com
> >Signed-off-by: Smitha T Murthy <smitha.t=40samsung.com>
> >Signed-off-by: Aakarsh Jain <aakarsh.jain=40samsung.com>
> >---
> > .../devicetree/bindings/media/s5p-mfc.txt     =7C  75 --------
> > .../bindings/media/samsung,s5p-mfc.yaml       =7C 163 +++++++++++++++++=
+
> > 2 files changed, 163 insertions(+), 75 deletions(-)  create mode
> >100644 Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> >
> >diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.txt
> >b/Documentation/devicetree/bindings/media/s5p-mfc.txt
> >index aa54c8159d9f..8b137891791f 100644
> >--- a/Documentation/devicetree/bindings/media/s5p-mfc.txt
> >+++ b/Documentation/devicetree/bindings/media/s5p-mfc.txt
> >=40=40 -1,76 +1 =40=40
> >-* Samsung Multi Format Codec (MFC)
> >
> >-Multi Format Codec (MFC) is the IP present in Samsung SoCs which
> >-supports high resolution decoding and encoding functionalities.
> >-The MFC device driver is a v4l2 driver which can encode/decode -video
> >raw/elementary streams and has support for all popular -video codecs.
> >-
> >-Required properties:
> >-  - compatible : value should be either one among the following
> >-	(a) =22samsung,mfc-v5=22 for MFC v5 present in Exynos4 SoCs
> >-	(b) =22samsung,mfc-v6=22 for MFC v6 present in Exynos5 SoCs
> >-	(c) =22samsung,mfc-v7=22 for MFC v7 present in Exynos5420 SoC
> >-	(d) =22samsung,mfc-v8=22 for MFC v8 present in Exynos5800 SoC
> >-	(e) =22samsung,exynos5433-mfc=22 for MFC v8 present in Exynos5433
> SoC
> >-	(f) =22samsung,mfc-v10=22 for MFC v10 present in Exynos7880 SoC
> >-
> >-  - reg : Physical base address of the IP registers and length of memor=
y
> >-	  mapped region.
> >-
> >-  - interrupts : MFC interrupt number to the CPU.
> >-  - clocks : from common clock binding: handle to mfc clock.
> >-  - clock-names : from common clock binding: must contain =22mfc=22,
> >-		  corresponding to entry in the clocks property.
> >-
> >-Optional properties:
> >-  - power-domains : power-domain property defined with a phandle
> >-			   to respective power domain.
> >-  - memory-region : from reserved memory binding: phandles to two
> >reserved
> >-	memory regions, first is for =22left=22 mfc memory bus interfaces,
> >-	second if for the =22right=22 mfc memory bus, used when no SYSMMU
> >-	support is available; used only by MFC v5 present in Exynos4 SoCs
> >-
> >-Obsolete properties:
> >-  - samsung,mfc-r, samsung,mfc-l : support removed, please use memory-
> >region
> >-	property instead
> >-
> >-
> >-Example:
> >-SoC specific DT entry:
> >-
> >-mfc: codec=4013400000 =7B
> >-	compatible =3D =22samsung,mfc-v5=22;
> >-	reg =3D <0x13400000 0x10000>;
> >-	interrupts =3D <0 94 0>;
> >-	power-domains =3D <&pd_mfc>;
> >-	clocks =3D <&clock 273>;
> >-	clock-names =3D =22mfc=22;
> >-=7D;
> >-
> >-Reserved memory specific DT entry for given board (see reserved memory
> >binding -for more information):
> >-
> >-reserved-memory =7B
> >-	=23address-cells =3D <1>;
> >-	=23size-cells =3D <1>;
> >-	ranges;
> >-
> >-	mfc_left: region=4051000000 =7B
> >-		compatible =3D =22shared-dma-pool=22;
> >-		no-map;
> >-		reg =3D <0x51000000 0x800000>;
> >-	=7D;
> >-
> >-	mfc_right: region=4043000000 =7B
> >-		compatible =3D =22shared-dma-pool=22;
> >-		no-map;
> >-		reg =3D <0x43000000 0x800000>;
> >-	=7D;
> >-=7D;
> >-
> >-Board specific DT entry:
> >-
> >-codec=4013400000 =7B
> >-	memory-region =3D <&mfc_left>, <&mfc_right>;
> >-=7D;
> >diff --git a/Documentation/devicetree/bindings/media/samsung,s5p-
> >mfc.yaml b/Documentation/devicetree/bindings/media/samsung,s5p-
> >mfc.yaml
> >new file mode 100644
> >index 000000000000..ad61b509846f
> >--- /dev/null
> >+++ b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> >=40=40 -0,0 +1,163 =40=40
> >+=23 SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause %YAML 1.2
> >+---
> >+=24id: http://devicetree.org/schemas/media/samsung,s5p-mfc.yaml=23
> >+=24schema: http://devicetree.org/meta-schemas/core.yaml=23
> >+
> >+title: Samsung Exynos Multi Format Codec (MFC)
> >+
> >+maintainers:
> >+  - Marek Szyprowski <m.szyprowski=40samsung.com>
> >+  - Smitha T Murthy <smitha.t=40samsung.com>
> >+  - Aakarsh Jain <aakarsh.jain=40samsung.com>
> >+
> >+description:
> >+  Multi Format Codec (MFC) is the IP present in Samsung SoCs which
> >+  supports high resolution decoding and encoding functionalities.
> >+
> >+properties:
> >+  compatible:
> >+    enum:
> >+      - samsung,mfc-v5                  =23 Exynos4
> >+      - samsung,mfc-v6                  =23 Exynos5
> >+      - samsung,mfc-v7                  =23 Exynos5420
> >+      - samsung,mfc-v8                  =23 Exynos5800
> >+      - samsung,exynos5433-mfc          =23 Exynos5433
> >+      - samsung,mfc-v10                 =23 Exynos7880
> >+
> >+  reg:
> >+    maxItems: 1
> >+
> >+  clocks:
> >+    minItems: 1
> >+    maxItems: 3
> >+
> >+  clock-names:
> >+    minItems: 1
> >+    maxItems: 3
> >+
> >+  interrupts:
> >+    maxItems: 1
> >+
> >+  iommus:
> >+    maxItems: 2
> >+
> >+  iommu-names:
> >+    maxItems: 2
> >+
> >+  power-domains:
> >+    maxItems: 1
> >+
> >+  memory-region:
> >+    maxItems: 1
> >+
> >+required:
> >+  - compatible
> >+  - reg
> >+  - clocks
> >+  - clock-names
> >+  - interrupts
> >+
> >+allOf:
> >+  - if:
> >+      properties:
> >+        compatible:
> >+          contains:
> >+            enum:
> >+              - samsung,mfc-v6
> >+              - samsung,mfc-v7
> >+              - samsung,mfc-v8
> >+              - tesla,fsd-mfc
> You have not introduce =22tesla,fsd-mfc=22 compatible yet, so this should=
 be part
> of the patch which adds fsd-mfc compatible
>=20
ok.
> >+    then:
> >+      properties:
> >+        clocks:
> >+          maxItems: 1
> >+        clock-names:
> >+          items:
> >+            - const: mfc
> >+
> >+  - if:
> >+      properties:
> >+        compatible:
> >+          contains:
> >+            enum:
> >+              - samsung,mfc-v5
> >+    then:
> >+      properties:
> >+        clocks:
> >+          minItems: 2
> >+          maxItems: 2
> >+        clock-names:
> >+          items:
> >+            - const: mfc
> >+            - const: sclk_mfc
> >+
> >+  - if:
> >+      properties:
> >+        compatible:
> >+          contains:
> >+            enum:
> >+              - samsung,exynos5433-mfc
> >+    then:
> >+      properties:
> >+        clocks:
> >+          minItems: 3
> >+          maxItems: 3
> >+        clock-names:
> >+          items:
> >+            - const: pclk
> >+            - const: aclk
> >+            - const: aclk_xiu
> >+
> >+  - if:
> >+      properties:
> >+        compatible:
> >+          contains:
> >+            enum:
> >+              - samsung,mfc-v5
> >+              - samsung,mfc-v6
> >+              - samsung,mfc-v7
> >+              - samsung,mfc-v8
> >+              - samsung,exynos5433-mfc
> >+
> >+    then:
> >+      properties:
> >+        iommus:
> >+          minItems: 2
> >+          maxItems: 2
> >+        iommu-names:
> >+          items:
> >+            - const: left
> >+            - const: right
> >+
> >+  - if:
> >+      properties:
> >+        compatible:
> >+          contains:
> >+            enum:
> >+              - tesla,fsd-mfc
>=20
> Same comments as above.
>=20
> My suggestion, first just convert the current s5p-mfc.txt to yaml format =
and
> then add fsd-mfc support.
> That way it will be easy for reviewer to understand the changes.
>=20
> While reviewing and code walk through, I also noticed that exynos3250.dts=
i
> and exynos5420.dtsi are using same compatible as =22samsung,mfc-v7=22 but
> there =22clocks=22 property is different. That doesn't look correct.
> This will cause issues when you convert s5p-mfc.txt to schema format.
> I don=E2=80=99t=20know=20why=20that=20was=20done=20that=20way,=20but=20su=
rely=20this=20need=20to=20be=20_fixed_=0D=0A>=20first=20as=20h/w=20itself=
=20are=20different.=0D=0A>=20=0D=0A>=20So=20my=20suggestion=20is=20to=20fix=
=20exynos3250.dtsi=20and=20exynos5420.dtsi=20compatible=0D=0A>=20and=20mfc=
=20driver=20for=20it=20first=20(as=20a=20separate=20patch=20series).=0D=0A>=
=20You=20can=20use=20the=20same=20approach=20what=20was=20done=20for=20mfc-=
v8=20and=20mfc-v8-5433.=0D=0A>=20=0D=0A>=20=0D=0Aok=20will=20fix=20this=20i=
ssue=20.=0D=0A=20=0D=0A>=20>+=20=20=20=20then:=0D=0A>=20>+=20=20=20=20=20=
=20properties:=0D=0A>=20>+=20=20=20=20=20=20=20=20memory-region:=0D=0A>=20>=
+=20=20=20=20=20=20=20=20=20=20maxItems:=201=0D=0A>=20>+=0D=0A>=20>+additio=
nalProperties:=20false=0D=0A>=20>+=0D=0A>=20>+examples:=0D=0A>=20>+=20=20-=
=20=7C=0D=0A>=20>+=20=20=20=20=23include=20<dt-bindings/clock/exynos4.h>=0D=
=0A>=20>+=20=20=20=20=23include=20<dt-bindings/clock/exynos-audss-clk.h>=0D=
=0A>=20>+=20=20=20=20=23include=20<dt-bindings/interrupt-controller/arm-gic=
.h>=0D=0A>=20>+=20=20=20=20=23include=20<dt-bindings/interrupt-controller/i=
rq.h>=0D=0A>=20>+=0D=0A>=20>+=20=20=20=20codec=4013400000=20=7B=0D=0A>=20>+=
=20=20=20=20=20=20=20=20=20=20compatible=20=3D=20=22samsung,mfc-v5=22;=0D=
=0A>=20>+=20=20=20=20=20=20=20=20=20=20reg=20=3D=20<0x13400000=200x10000>;=
=0D=0A>=20>+=20=20=20=20=20=20=20=20=20=20interrupts=20=3D=20<GIC_SPI=2094=
=20IRQ_TYPE_LEVEL_HIGH>;=0D=0A>=20>+=20=20=20=20=20=20=20=20=20=20power-dom=
ains=20=3D=20<&pd_mfc>;=0D=0A>=20>+=20=20=20=20=20=20=20=20=20=20clocks=20=
=3D=20<&clock=20CLK_MFC>,=20<&clock=20CLK_SCLK_MFC>;=0D=0A>=20>+=20=20=20=
=20=20=20=20=20=20=20clock-names=20=3D=20=22mfc=22,=20=22sclk_mfc=22;=0D=0A=
>=20>+=20=20=20=20=20=20=20=20=20=20iommus=20=3D=20<&sysmmu_mfc_l>,=20<&sys=
mmu_mfc_r>;=0D=0A>=20>+=20=20=20=20=20=20=20=20=20=20iommu-names=20=3D=20=
=22left=22,=20=22right=22;=0D=0A>=20>+=0D=0A>=20>+=20=20=20=20=7D;=0D=0A>=
=20>--=0D=0A>=20>2.17.1=0D=0A>=20=0D=0A>=20=0D=0A=0D=0AThanks=20for=20the=
=20review.=0D=0A=0D=0A=0D=0A
