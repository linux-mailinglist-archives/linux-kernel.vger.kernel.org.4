Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D9760F57C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 12:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbiJ0KkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 06:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbiJ0KkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:40:11 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA223ECE5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 03:40:06 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221027104004epoutp0365a2939e56dbe65e0342d9538c48797e~h5uQKPAXA0159601596epoutp03t
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 10:40:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221027104004epoutp0365a2939e56dbe65e0342d9538c48797e~h5uQKPAXA0159601596epoutp03t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1666867204;
        bh=KGo+tOpbb4n3LFOEfYO+4hVHarfxzdyUIzeEpR48OkY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Hf3tY6RsWz1G6HEknV7U9aEze3LXLyW06R+LLyXdAkYYrHYAStIdMBBc/n0pJkfOK
         KZCEMSfrB4g9/m6is1hH9AlkWp72EmT6iF/o9cSuEgvi9DTSmdnt71KltmK4z0Q7y3
         AqWLmxocL1Uv1Kp3A8t8N0XeX+EkW9RkA21IlcYg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221027104003epcas5p4fb4634be9828874a67e2dd8439577b2c~h5uPM1Y4-2002920029epcas5p4B;
        Thu, 27 Oct 2022 10:40:03 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4MyhyS0ss0z4x9Pp; Thu, 27 Oct
        2022 10:40:00 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.D2.39477.FFF5A536; Thu, 27 Oct 2022 19:40:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221027103959epcas5p1a68a2b507484b04f74028b874c36c518~h5uL8ZUei2760827608epcas5p1Y;
        Thu, 27 Oct 2022 10:39:59 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221027103959epsmtrp1a8112de402a109499ef619b7d25b7696~h5uL7KAOx0280802808epsmtrp1f;
        Thu, 27 Oct 2022 10:39:59 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-8f-635a5fffed60
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C5.88.18644.FFF5A536; Thu, 27 Oct 2022 19:39:59 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221027103956epsmtip173e3b7a484ca28856c670ebbf2ad1da9~h5uI7endy0990409904epsmtip1f;
        Thu, 27 Oct 2022 10:39:56 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'aakarsh jain'" <aakarsh.jain@samsung.com>,
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
In-Reply-To: <20221011122516.32135-2-aakarsh.jain@samsung.com>
Subject: RE: [Patch v3 01/15] dt-bindings: media: s5p-mfc: Add new DT schema
 for MFC
Date:   Thu, 27 Oct 2022 16:09:55 +0530
Message-ID: <000c01d8e9f0$764e5ea0$62eb1be0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIjXZOHgvokXGuofbg3rWbxTFZEMQGGfBLcASb/h3mtd6qi4A==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHPb3tbXFC7wqGI0uwNHMMNh6FgocJKo6xG10yFsh0bgbvyk1h
        lLa2ZUOjEZWHAxQww8FFRSgPRxjypiuQAasiRtkYIM5ZNwGFglscoMJgspaLG/99f+f3+eb3
        OPkJMFEB302QoNLTWhWllOBruS0/eL3us2b/Xrn/+CkOemAs4iHD3DgH/WaY4aLuxmY+ahos
        xlBVTycPlZj7eKi1a4SL6ids2f4iCxeNl9QCZGXu4ahh9BYP3Z/cjQZM53CUU9fMQ9+aLXxU
        MdzPQZUNixxU1jzLR+kdZj6ytLcAlJZh5mx3JWsu1ADSaCkH5HD5NEZ+x1j4pKHdyiEbqr/E
        ybu32nGysfwomX7lby55uqkakM+Pn+eTWeZhnJxpcCevP5nhRzntTQyNp6k4WiumVXJ1XIJK
        ESbZFR37dmxQsL/URxqCNkvEKiqJDpNEvBflE5mgtG1AIv6cUibbnqIonU7itzVUq07W0+J4
        tU4fJqE1cUqNTOOro5J0ySqFr4rWvyX19w8IsoH7E+Onvu/CNG0fpDS3P8JSgXV7FnAQQEIG
        +++NcbLAWoGIaAOwNDufzwbTAJoqJnhsMANg3txDzgtLVnH9CmUCMLN8EGcDK4DTTA/XTuGE
        DzQaMpYTLoQRwF8n54E9wIhZDJ5JK7H5BQIHYiscNsntBmfiQ5hmnuPZNZfYBGsLOnC7diRC
        YFbBz1xWvwx7i8aWNUa8AStLpzC2JTGcf1C57HUhdsCF2RacZVyh9YqZzzJ9DrDq2WusjoDf
        nGkDrHaGkz1NK4wbtOZmLLcGCRKWLbqxz/Hwj6rLK/g22Dl4jmtHMMILXjb5sZWc4KkF+x7t
        Tkd4MkPE0pvgiT+HuKx+BeZnZ/NYTcLs3EksD3gwq+ZiVs3FrOqf+b/YRcCtBhtojS5JQeuC
        NAEq+ov//luuTmoAy/fhvdMI7v/+2LcbcASgG0ABJnFxvHl7t1zkGEcdPERr1bHaZCWt6wZB
        tmXnY27r5Wrbgan0sVJZiL8sODhYFhIYLJW4OhoKveUiQkHp6USa1tDaFz6OwMEtlaPIvcTI
        Go/U4SkTG/GvPqmNXndIFfrOwb8kdQu6nvmN6oH+mMOCLR5Spy3R188u9lVE5v3yWaCHn+f6
        qhutqeiYsHPX/LGb7ulUdXhqqfIl4449gfkLptGaNYUbFMpIz3eX8KVSvFtZXLjPvU5Y/Yj5
        KHKkdOk4uFC8c/OdFM+paK/FfY87rs3ffRLebHi1sExfdjhAxPRFSHsDc64dOEk1ha5Jvtra
        XrgU81RcMaqkRD89vf2mMMZpj9fDj5/fMV+c4teffvb19IHegYkjTWfX/VhQ5JN4CX3aNVJf
        npnGvP/PiaEZP+R8Y1AY7tcW4bEtIkiodnURWo6ez8wZI0KHrjICCVcXT0m9Ma2O+hf2MCig
        qAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsWy7bCSnO7/+Khkgzl7FCye7pjJarH4x3Mm
        i/uLP7NYHNq8ld1iy5XZzBbLjx9gtZh/5ByrxfaDj1gsNr4Ayl6ceZfF4vn8dYwWL2fdY7PY
        9Pgaq8XDV+EWl3fNYbPo2bCV1WLtkbvsFkuvX2SyWLbpD5PFoq1f2C1a9x5ht7i7ZxujRUvb
        ESYHcY8189Yweuy4u4TR4/qST8weO2fdZfdYvOclk8emVZ1sHneu7WHz2Lyk3qP16C8Wj74t
        qxg9/jXNZffoOnKdzePzJjmPU18/swfwRXHZpKTmZJalFunbJXBlHNyxjbXghFfF9jebGBsY
        /5p3MXJySAiYSHTN3sjexcjFISSwg1GiadsHdoiEtMT1jROgbGGJlf+eQxU9Z5S4ceQQK0iC
        TUBXYsfiNjaQhIjAHkaJ5qNnmEAcZoEOFonZU2ewQbQcZJRY/ugAcxcjBwengJ3E9V3JIKaw
        QIjE7m91IINYBFQl1k3dywZi8wpYSnRNvcQCYQtKnJz5BMxmFtCW6H3YyghjL1v4mhniOgWJ
        n0+XgR0kIuAk8fvLNjaIGnGJl0ePsE9gFJ6FZNQsJKNmIRk1C0nLAkaWVYySqQXFuem5xYYF
        Rnmp5XrFibnFpXnpesn5uZsYwWlES2sH455VH/QOMTJxMB5ilOBgVhLhPXsjPFmINyWxsiq1
        KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGJpP4vE2yhrWaNr6H42tZ
        81i+LFtblH2mxi3wyyb7v/Hh/7JFKk41/76kc71lrsnMH1/etb2Y4ZI7M+6mcO/SySJ83wwe
        Ja5M2R7ae/uYfUeWbuXjOb88/7zVN1rkLbvW88BGk7c7rdOVMqevcWrzy19TFCZy65vTT61t
        YsqRHj/yPn2d5bEvoXWedIlZiuSn9J8fOyS6ZMvMahKNZ0255fLoaVPdoWaVDVWL/tSb7Vx2
        2TS3SDMxpivk13+PxScnx8xaWdOjcrexOfqFrc1Xu1fP1Q7tN3zM5f3YYNmhhKIl8m/16lhu
        nO1LErgU45Y9m4/PS6CI7bhX+Jm3VqY2Bmuv6SZ/Pu54798qk2PKSizFGYmGWsxFxYkApB9M
        7pIDAAA=
X-CMS-MailID: 20221027103959epcas5p1a68a2b507484b04f74028b874c36c518
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221011125142epcas5p13c858a5f27830fb1de50fa51e9730eca
References: <20221011122516.32135-1-aakarsh.jain@samsung.com>
        <CGME20221011125142epcas5p13c858a5f27830fb1de50fa51e9730eca@epcas5p1.samsung.com>
        <20221011122516.32135-2-aakarsh.jain@samsung.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aakarsh
Thanks for the patch.

>-----Original Message-----
>From: aakarsh jain =5Bmailto:aakarsh.jain=40samsung.com=5D
>Sent: Tuesday, October 11, 2022 5:55 PM
>To: linux-arm-kernel=40lists.infradead.org; linux-media=40vger.kernel.org;=
 linux-
>kernel=40vger.kernel.org; devicetree=40vger.kernel.org
>Cc: m.szyprowski=40samsung.com; andrzej.hajda=40intel.com;
>mchehab=40kernel.org; hverkuil-cisco=40xs4all.nl;
>ezequiel=40vanguardiasur.com.ar; jernej.skrabec=40gmail.com;
>benjamin.gaignard=40collabora.com; stanimir.varbanov=40linaro.org;
>dillon.minfei=40gmail.com; david.plowman=40raspberrypi.com;
>mark.rutland=40arm.com; robh+dt=40kernel.org; krzk+dt=40kernel.org;
>andi=40etezian.org; alim.akhtar=40samsung.com; aswani.reddy=40samsung.com;
>pankaj.dubey=40samsung.com; linux-fsd=40tesla.com; smitha.t=40samsung.com;
>aakarsh.jain=40samsung.com
>Subject: =5BPatch v3 01/15=5D dt-bindings: media: s5p-mfc: Add new DT sche=
ma for
>MFC
>
>From: Smitha T Murthy <smitha.t=40samsung.com>
>
>Convert DT schema for s5p-mfc in yaml format
>
>Cc: linux-fsd=40tesla.com
>Signed-off-by: Smitha T Murthy <smitha.t=40samsung.com>
>Signed-off-by: Aakarsh Jain <aakarsh.jain=40samsung.com>
>---
> .../devicetree/bindings/media/s5p-mfc.txt     =7C  75 --------
> .../bindings/media/samsung,s5p-mfc.yaml       =7C 163 ++++++++++++++++++
> 2 files changed, 163 insertions(+), 75 deletions(-)  create mode 100644
>Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
>
>diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.txt
>b/Documentation/devicetree/bindings/media/s5p-mfc.txt
>index aa54c8159d9f..8b137891791f 100644
>--- a/Documentation/devicetree/bindings/media/s5p-mfc.txt
>+++ b/Documentation/devicetree/bindings/media/s5p-mfc.txt
>=40=40 -1,76 +1 =40=40
>-* Samsung Multi Format Codec (MFC)
>
>-Multi Format Codec (MFC) is the IP present in Samsung SoCs which -support=
s
>high resolution decoding and encoding functionalities.
>-The MFC device driver is a v4l2 driver which can encode/decode -video
>raw/elementary streams and has support for all popular -video codecs.
>-
>-Required properties:
>-  - compatible : value should be either one among the following
>-	(a) =22samsung,mfc-v5=22 for MFC v5 present in Exynos4 SoCs
>-	(b) =22samsung,mfc-v6=22 for MFC v6 present in Exynos5 SoCs
>-	(c) =22samsung,mfc-v7=22 for MFC v7 present in Exynos5420 SoC
>-	(d) =22samsung,mfc-v8=22 for MFC v8 present in Exynos5800 SoC
>-	(e) =22samsung,exynos5433-mfc=22 for MFC v8 present in Exynos5433 SoC
>-	(f) =22samsung,mfc-v10=22 for MFC v10 present in Exynos7880 SoC
>-
>-  - reg : Physical base address of the IP registers and length of memory
>-	  mapped region.
>-
>-  - interrupts : MFC interrupt number to the CPU.
>-  - clocks : from common clock binding: handle to mfc clock.
>-  - clock-names : from common clock binding: must contain =22mfc=22,
>-		  corresponding to entry in the clocks property.
>-
>-Optional properties:
>-  - power-domains : power-domain property defined with a phandle
>-			   to respective power domain.
>-  - memory-region : from reserved memory binding: phandles to two
>reserved
>-	memory regions, first is for =22left=22 mfc memory bus interfaces,
>-	second if for the =22right=22 mfc memory bus, used when no SYSMMU
>-	support is available; used only by MFC v5 present in Exynos4 SoCs
>-
>-Obsolete properties:
>-  - samsung,mfc-r, samsung,mfc-l : support removed, please use memory-
>region
>-	property instead
>-
>-
>-Example:
>-SoC specific DT entry:
>-
>-mfc: codec=4013400000 =7B
>-	compatible =3D =22samsung,mfc-v5=22;
>-	reg =3D <0x13400000 0x10000>;
>-	interrupts =3D <0 94 0>;
>-	power-domains =3D <&pd_mfc>;
>-	clocks =3D <&clock 273>;
>-	clock-names =3D =22mfc=22;
>-=7D;
>-
>-Reserved memory specific DT entry for given board (see reserved memory
>binding -for more information):
>-
>-reserved-memory =7B
>-	=23address-cells =3D <1>;
>-	=23size-cells =3D <1>;
>-	ranges;
>-
>-	mfc_left: region=4051000000 =7B
>-		compatible =3D =22shared-dma-pool=22;
>-		no-map;
>-		reg =3D <0x51000000 0x800000>;
>-	=7D;
>-
>-	mfc_right: region=4043000000 =7B
>-		compatible =3D =22shared-dma-pool=22;
>-		no-map;
>-		reg =3D <0x43000000 0x800000>;
>-	=7D;
>-=7D;
>-
>-Board specific DT entry:
>-
>-codec=4013400000 =7B
>-	memory-region =3D <&mfc_left>, <&mfc_right>;
>-=7D;
>diff --git a/Documentation/devicetree/bindings/media/samsung,s5p-
>mfc.yaml b/Documentation/devicetree/bindings/media/samsung,s5p-
>mfc.yaml
>new file mode 100644
>index 000000000000..ad61b509846f
>--- /dev/null
>+++ b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
>=40=40 -0,0 +1,163 =40=40
>+=23 SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause %YAML 1.2
>+---
>+=24id: http://devicetree.org/schemas/media/samsung,s5p-mfc.yaml=23
>+=24schema: http://devicetree.org/meta-schemas/core.yaml=23
>+
>+title: Samsung Exynos Multi Format Codec (MFC)
>+
>+maintainers:
>+  - Marek Szyprowski <m.szyprowski=40samsung.com>
>+  - Smitha T Murthy <smitha.t=40samsung.com>
>+  - Aakarsh Jain <aakarsh.jain=40samsung.com>
>+
>+description:
>+  Multi Format Codec (MFC) is the IP present in Samsung SoCs which
>+  supports high resolution decoding and encoding functionalities.
>+
>+properties:
>+  compatible:
>+    enum:
>+      - samsung,mfc-v5                  =23 Exynos4
>+      - samsung,mfc-v6                  =23 Exynos5
>+      - samsung,mfc-v7                  =23 Exynos5420
>+      - samsung,mfc-v8                  =23 Exynos5800
>+      - samsung,exynos5433-mfc          =23 Exynos5433
>+      - samsung,mfc-v10                 =23 Exynos7880
>+
>+  reg:
>+    maxItems: 1
>+
>+  clocks:
>+    minItems: 1
>+    maxItems: 3
>+
>+  clock-names:
>+    minItems: 1
>+    maxItems: 3
>+
>+  interrupts:
>+    maxItems: 1
>+
>+  iommus:
>+    maxItems: 2
>+
>+  iommu-names:
>+    maxItems: 2
>+
>+  power-domains:
>+    maxItems: 1
>+
>+  memory-region:
>+    maxItems: 1
>+
>+required:
>+  - compatible
>+  - reg
>+  - clocks
>+  - clock-names
>+  - interrupts
>+
>+allOf:
>+  - if:
>+      properties:
>+        compatible:
>+          contains:
>+            enum:
>+              - samsung,mfc-v6
>+              - samsung,mfc-v7
>+              - samsung,mfc-v8
>+              - tesla,fsd-mfc
You have not introduce =22tesla,fsd-mfc=22 compatible yet, so this should b=
e part of the patch which adds fsd-mfc compatible

>+    then:
>+      properties:
>+        clocks:
>+          maxItems: 1
>+        clock-names:
>+          items:
>+            - const: mfc
>+
>+  - if:
>+      properties:
>+        compatible:
>+          contains:
>+            enum:
>+              - samsung,mfc-v5
>+    then:
>+      properties:
>+        clocks:
>+          minItems: 2
>+          maxItems: 2
>+        clock-names:
>+          items:
>+            - const: mfc
>+            - const: sclk_mfc
>+
>+  - if:
>+      properties:
>+        compatible:
>+          contains:
>+            enum:
>+              - samsung,exynos5433-mfc
>+    then:
>+      properties:
>+        clocks:
>+          minItems: 3
>+          maxItems: 3
>+        clock-names:
>+          items:
>+            - const: pclk
>+            - const: aclk
>+            - const: aclk_xiu
>+
>+  - if:
>+      properties:
>+        compatible:
>+          contains:
>+            enum:
>+              - samsung,mfc-v5
>+              - samsung,mfc-v6
>+              - samsung,mfc-v7
>+              - samsung,mfc-v8
>+              - samsung,exynos5433-mfc
>+
>+    then:
>+      properties:
>+        iommus:
>+          minItems: 2
>+          maxItems: 2
>+        iommu-names:
>+          items:
>+            - const: left
>+            - const: right
>+
>+  - if:
>+      properties:
>+        compatible:
>+          contains:
>+            enum:
>+              - tesla,fsd-mfc

Same comments as above.

My suggestion, first just convert the current s5p-mfc.txt to yaml format an=
d then add fsd-mfc support.
That way it will be easy for reviewer to understand the changes.

While reviewing and code walk through, I also noticed that exynos3250.dtsi =
and exynos5420.dtsi
are using same compatible as =22samsung,mfc-v7=22 but there =22clocks=22 pr=
operty is different. That doesn't look correct.
This will cause issues when you convert s5p-mfc.txt to schema format.
I don=E2=80=99t=20know=20why=20that=20was=20done=20that=20way,=20but=20sure=
ly=20this=20need=20to=20be=20_fixed_=20first=20as=20h/w=20itself=20are=20di=
fferent.=0D=0A=0D=0ASo=20my=20suggestion=20is=20to=20fix=20exynos3250.dtsi=
=20and=20exynos5420.dtsi=20compatible=20and=20mfc=20driver=20for=20it=20fir=
st=20(as=20a=20separate=20patch=20series).=0D=0AYou=20can=20use=20the=20sam=
e=20approach=20what=20was=20done=20for=20mfc-v8=20and=20mfc-v8-5433.=20=0D=
=0A=0D=0A=0D=0A>+=20=20=20=20then:=0D=0A>+=20=20=20=20=20=20properties:=0D=
=0A>+=20=20=20=20=20=20=20=20memory-region:=0D=0A>+=20=20=20=20=20=20=20=20=
=20=20maxItems:=201=0D=0A>+=0D=0A>+additionalProperties:=20false=0D=0A>+=0D=
=0A>+examples:=0D=0A>+=20=20-=20=7C=0D=0A>+=20=20=20=20=23include=20<dt-bin=
dings/clock/exynos4.h>=0D=0A>+=20=20=20=20=23include=20<dt-bindings/clock/e=
xynos-audss-clk.h>=0D=0A>+=20=20=20=20=23include=20<dt-bindings/interrupt-c=
ontroller/arm-gic.h>=0D=0A>+=20=20=20=20=23include=20<dt-bindings/interrupt=
-controller/irq.h>=0D=0A>+=0D=0A>+=20=20=20=20codec=4013400000=20=7B=0D=0A>=
+=20=20=20=20=20=20=20=20=20=20compatible=20=3D=20=22samsung,mfc-v5=22;=0D=
=0A>+=20=20=20=20=20=20=20=20=20=20reg=20=3D=20<0x13400000=200x10000>;=0D=
=0A>+=20=20=20=20=20=20=20=20=20=20interrupts=20=3D=20<GIC_SPI=2094=20IRQ_T=
YPE_LEVEL_HIGH>;=0D=0A>+=20=20=20=20=20=20=20=20=20=20power-domains=20=3D=
=20<&pd_mfc>;=0D=0A>+=20=20=20=20=20=20=20=20=20=20clocks=20=3D=20<&clock=
=20CLK_MFC>,=20<&clock=20CLK_SCLK_MFC>;=0D=0A>+=20=20=20=20=20=20=20=20=20=
=20clock-names=20=3D=20=22mfc=22,=20=22sclk_mfc=22;=0D=0A>+=20=20=20=20=20=
=20=20=20=20=20iommus=20=3D=20<&sysmmu_mfc_l>,=20<&sysmmu_mfc_r>;=0D=0A>+=
=20=20=20=20=20=20=20=20=20=20iommu-names=20=3D=20=22left=22,=20=22right=22=
;=0D=0A>+=0D=0A>+=20=20=20=20=7D;=0D=0A>--=0D=0A>2.17.1=0D=0A=0D=0A=0D=0A
