Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAAF6A914D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 07:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjCCG5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 01:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjCCG5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 01:57:18 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1129E241D4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 22:57:13 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230303065711epoutp02a424555f3e98133c30a26f43bdd03779~I1m50i1x-2877828778epoutp02m
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 06:57:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230303065711epoutp02a424555f3e98133c30a26f43bdd03779~I1m50i1x-2877828778epoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677826631;
        bh=OzCLQkmjrZXPNZemecRxifP1D52YdU29Dr/WUBWtLSc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Y18VVlS7kq5Ye2pCBxD6sxsdbRQ3Rty9CojDoy77uKgnkWk3pLLA5n1k52Jeofu3a
         V1pQROSj/9hF8xh/WSpehQxA2pdzTHcwNOtYU9yFjrPXmUdzoQ+s3Uu8heRtoy6wdm
         SWgKSOeP4cprAgSQNttn53cJor2quZw5HJB/+/+M=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230303065710epcas5p1592a12f05fe16d46a49117cd260a9984~I1m5J-vzu0169801698epcas5p1d;
        Fri,  3 Mar 2023 06:57:10 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PSf0h1R7Yz4x9Pw; Fri,  3 Mar
        2023 06:57:08 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3A.4C.10528.44A91046; Fri,  3 Mar 2023 15:57:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230302151835epcas5p142e2fc60df73b926a1be1455975b5755~IozZkHRNP2145221452epcas5p1S;
        Thu,  2 Mar 2023 15:18:35 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230302151835epsmtrp18931461fdfa8497175c3b300d9a34f12~IozZjFo891997819978epsmtrp1Y;
        Thu,  2 Mar 2023 15:18:35 +0000 (GMT)
X-AuditID: b6c32a49-c17ff70000012920-d1-64019a447202
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.58.31821.B4EB0046; Fri,  3 Mar 2023 00:18:35 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230302151831epsmtip29d910af96e24e054b0531028007242af~IozWfThvo0220602206epsmtip2i;
        Thu,  2 Mar 2023 15:18:31 +0000 (GMT)
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
In-Reply-To: <8b5bea40-6f7b-1d00-ac23-83a28c7dacbc@linaro.org>
Subject: RE: [Patch v6] dt-bindings: media: s5p-mfc: convert bindings to
 json-schema
Date:   Thu, 2 Mar 2023 20:48:30 +0530
Message-ID: <046b01d94d1a$418146a0$c483d3e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQHxIgKtygHqPU4mHAhqu15r4A65nwLsA7LZAklDK9yujjyZkA==
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTZxT3u/f2xdbl8jB8EGdYRTZBaKuFfV14TYm7DhNJ5pYIJtC1dy2j
        tLW3jMmWjWQDEYGJipNKYAplGQ+BWhgC8mx9FOLmg8eUDhgyQLOFwB4yH1nLhY3/fud3fud8
        53e+HD7uU8oL5KfrTLRRp9CKuF5E28C218ITzEAlefIFD01WtnFR9eNZDE1ULxGo/1IrD9nu
        nsPRt9d6OajKfpODvu/7hUAtc+7srXIXgWarLgI0b/6Zi0rmpnB05ZG7wjo9wkF3Oiq4qKi5
        lYMa7S4esozewlCt9SmGLrT+wUN5V+w89GW+HYv3pxoqGwDV7qoB1GjNIk5dNrt4VHXXPEZZ
        645xqfGRLi51qeZzKs/xD0GV2OoAVWgf5VJL1s2U888lXpIwOSNaQytUtDGI1in1qnSdOkaU
        +E7q7tTIKIk0XCpHr4uCdIpMOkaUsC8pfE+61u1eFPSRQpvlppIUDCMSx0Yb9VkmOkijZ0wx
        Itqg0hpkhghGkclk6dQROtr0hlQi2RHpFqZlaCbydxuWsj/uGH+I5YIiTSEQ8CEpg2XPFniF
        wIvvQ3YC2HivG2ODRQAtY5cBGywBOPxTM2etZGzxKodNdAB4v6QHZ4NZAE/9vQA8Ki4phhPO
        ohWVH+kAcNI2taLCyaMELL2du6ISkLGwteA514N9yffgVEuBG/P5BBkMfx2We2ghKYeVJ29i
        LPaGN8ofEB6Mk2Gw9vwjnB0pCC7P1HJY3h86lotWeD9yFxy1nVnVOAXQVYN72kMyAVZfVbO0
        L3x4zcZjcSCc/yp/FSvh9IX51VItbOo6TbA4DvberSA8bXByG2zqELP0y7DMeRFjJ3gJFj95
        gLG8ELZXruEQWDH+eHWJm+BAvQWcACLzOmPmdcbM68yY/3/tG0DUgQDawGSqaSbSINXR2f/9
        t1KfaQUrtxG6tx24Jhci+gHGB/0A8nGRn/CT3A0qH6FKcSSHNupTjVlamukHke5ll+KBG5V6
        93HpTKlSmVwii4qKksl3RklF/sJXY24ofUi1wkRn0LSBNq7VYXxBYC4WcrKv64f4sIGNz+sD
        +tIcs1u8xb6j2or9v72YfUDzVv3E4vZ0ZfykaU/PK1bvXYcLytuij8o7Es4c37c3z1SX5NiQ
        kj67/OOp7YeOvW2rTXGaI77zPTLYmeFszvb9dFOD885OC5NzP7m4tsnil/N7z9mDcXWOxIa8
        hIgZ8bxBfG9/sP7w8cCkyBdO2DTTW4Ycb0Z/Fpu8S1ePYWkBsCSxZLhzWi/tLi/7i048RMxI
        2rx6i0cE15M/3EF5NQYEmws2+wya3+UUXX+mnHtf2JoT091VddDODB3IHVJWx50VD+YTsnFl
        i/9URsq5D+LagtXnpVuXGzqp5d6xsNCvn1q23g4RiAhGo5CG4kZG8S8Sg7FgpAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsWy7bCSvK73PoYUg1ubWCwezNvGZrH4x3Mm
        i/uLP7NYHNq8ld1iy5XZzBbLjx9gtZh/5ByrxfaDj1gsNr4Ayl6ceZfF4vn8dYwWL2fdY7Po
        e/GQ2WLva6COTY+vsVpc3jWHzaJnw1ZWi7VH7rJbLL1+kcli2aY/TBaLtn5ht2jde4TdoqXt
        CJODuMeaeWsYPXbcXcLocX3JJ2aPnbPusnss3vOSyWPTqk42jzvX9rB5bF5S79F69BeLR9+W
        VYweXUeus3l83iTncerrZ/YA3igum5TUnMyy1CJ9uwSujF3Lu9gKtsRWbJtwla2BcYVzFyMn
        h4SAicSNT8dYuxi5OIQEdjBKnL7wnBUiISPxv+0YO4QtLLHy33MwW0jgKaPEl9NZIDabgL7E
        /VM9YM0iAicZJfrPtIA5zAIzWSSuTjjGBDH2AKPE58+nmUBaOAXsJLZ2/GMDsYUFQiR+NWwF
        6uDgYBFQkXh21RIkzCtgKTFv0jkmCFtQ4uTMJywgNrOAtkTvw1ZGGHvZwtfMENcpSPx8uowV
        Ii4ucfRnD1hcRMBJ4vqWacwTGIVnIRk1C8moWUhGzULSvoCRZRWjZGpBcW56brFhgVFearle
        cWJucWleul5yfu4mRnD60NLawbhn1Qe9Q4xMHIyHGCU4mJVEeKsbGFKEeFMSK6tSi/Lji0pz
        UosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYNps+/7a1unBD16ZPvDflqj+4ocV
        A5vF62VzKpwX6n1q9Zy/pc1pStKS1f3GX2/vXsu+rlBZ/9RtVi+R9XwXsqTOW97bczdgueak
        o5UmzkLpn584sKjP9dwosGrHju9Sn6J13PNu3gtnqdA5W1nR6DD5B8eiL4WMivJPvJWuJD+7
        UvWm1lI1VaraW6i9UaPhz53EBxuvnMtbckdvCnehsK9MhuLsXR0fz2+s157r9OzNz7W/n2xp
        XBF7IX6GWcCJLVNYLiY/io45OLEiKd0hprlauOvenqU/suse+2ZWXn5kdtnp7xrbp1myOapb
        5qe+02A12xSxPmdOBfffDVd7mc9PaZ463Uzln8aXxHdJFcJKLMUZiYZazEXFiQBgmPuEjgMA
        AA==
X-CMS-MailID: 20230302151835epcas5p142e2fc60df73b926a1be1455975b5755
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
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
> Sent: 02 March 2023 14:07
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
> On 01/03/2023 04:51, Aakarsh Jain wrote:
> > Convert s5p-mfc bindings to DT schema format using json-schema.
> >
> > Signed-off-by: Aakarsh Jain <aakarsh.jain=40samsung.com>
> > ---
> > changes since v5:
> > kept compatible strings under enum
> > sorted compatible strings
> > added iommu maxItems:2
> > Added indentation with 4 spaces in dts example
> >
> > changes since v4:
> > Removed items from oneOf section
> > dropped black line
> > defined the iommus names items as
> > items:
> > -const left
> > -const right
> >
> > changes since v3:
> > fixed dt-schema warnings and errors while running make dtbs_check and
> > make dt_binding_check for ARMv7 Since, obsolete properties are not part
> of dt-node so we are not including these properties in dt-schema.
> >
> > changes since v2:
> > changed Commit message from Adds to Convert Removed text =22This file
> > has moved to samsung,s5p-mfc.yaml=22 from s5p-mfc.txt fixed dt-schema
> > warnings and errors while running make dtbs_check and make
> > dt_binding_check
> >
> > changes since v1:
> > fixed dt-schema warnings and errors while running make dtbs_check and
> > make dt_binding_check Removed description.
> > Listed items.
> > Added allOf:if:then for restricting two items to specific compatible
> >
> > This patch is independent from the previous MFC v12 patch series for HW=
3
> support.
> >
> >  .../devicetree/bindings/media/s5p-mfc.txt     =7C  78 ---------
> >  .../bindings/media/samsung,s5p-mfc.yaml       =7C 151
> ++++++++++++++++++
> >  2 files changed, 151 insertions(+), 78 deletions(-)  create mode
> > 100644 Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.txt
> > b/Documentation/devicetree/bindings/media/s5p-mfc.txt
> > index 8eb90c043d5d..e69de29bb2d1 100644
> > --- a/Documentation/devicetree/bindings/media/s5p-mfc.txt
> > +++ b/Documentation/devicetree/bindings/media/s5p-mfc.txt
> > =40=40 -1,78 +0,0 =40=40
> > -* Samsung Multi Format Codec (MFC)
> > -
> > -Multi Format Codec (MFC) is the IP present in Samsung SoCs which
> > -supports high resolution decoding and encoding functionalities.
> > -The MFC device driver is a v4l2 driver which can encode/decode -video
> > raw/elementary streams and has support for all popular -video codecs.
> > -
> > -Required properties:
> > -  - compatible : value should be either one among the following
> > -	(a) =22samsung,mfc-v5=22 for MFC v5 present in Exynos4 SoCs
> > -	(b) =22samsung,mfc-v6=22 for MFC v6 present in Exynos5 SoCs
> > -	(c) =22samsung,exynos3250-mfc=22, =22samsung,mfc-v7=22 for MFC v7
> > -	     present in Exynos3250 SoC
> > -	(d) =22samsung,mfc-v7=22 for MFC v7 present in Exynos5420 SoC
> > -	(e) =22samsung,mfc-v8=22 for MFC v8 present in Exynos5800 SoC
> > -	(f) =22samsung,exynos5433-mfc=22 for MFC v8 present in Exynos5433 SoC
> > -	(g) =22samsung,mfc-v10=22 for MFC v10 present in Exynos7880 SoC
> > -
> > -  - reg : Physical base address of the IP registers and length of memo=
ry
> > -	  mapped region.
> > -
> > -  - interrupts : MFC interrupt number to the CPU.
> > -  - clocks : from common clock binding: handle to mfc clock.
> > -  - clock-names : from common clock binding: must contain =22mfc=22,
> > -		  corresponding to entry in the clocks property.
> > -
> > -Optional properties:
> > -  - power-domains : power-domain property defined with a phandle
> > -			   to respective power domain.
> > -  - memory-region : from reserved memory binding: phandles to two
> reserved
> > -	memory regions, first is for =22left=22 mfc memory bus interfaces,
> > -	second if for the =22right=22 mfc memory bus, used when no SYSMMU
> > -	support is available; used only by MFC v5 present in Exynos4 SoCs
> > -
> > -Obsolete properties:
> > -  - samsung,mfc-r, samsung,mfc-l : support removed, please use memory-
> region
> > -	property instead
> > -
> > -
> > -Example:
> > -SoC specific DT entry:
> > -
> > -mfc: codec=4013400000 =7B
> > -	compatible =3D =22samsung,mfc-v5=22;
> > -	reg =3D <0x13400000 0x10000>;
> > -	interrupts =3D <0 94 0>;
> > -	power-domains =3D <&pd_mfc>;
> > -	clocks =3D <&clock 273>;
> > -	clock-names =3D =22mfc=22;
> > -=7D;
> > -
> > -Reserved memory specific DT entry for given board (see reserved
> > memory binding -for more information):
> > -
> > -reserved-memory =7B
> > -	=23address-cells =3D <1>;
> > -	=23size-cells =3D <1>;
> > -	ranges;
> > -
> > -	mfc_left: region=4051000000 =7B
> > -		compatible =3D =22shared-dma-pool=22;
> > -		no-map;
> > -		reg =3D <0x51000000 0x800000>;
> > -	=7D;
> > -
> > -	mfc_right: region=4043000000 =7B
> > -		compatible =3D =22shared-dma-pool=22;
> > -		no-map;
> > -		reg =3D <0x43000000 0x800000>;
> > -	=7D;
> > -=7D;
> > -
> > -Board specific DT entry:
> > -
> > -codec=4013400000 =7B
> > -	memory-region =3D <&mfc_left>, <&mfc_right>;
> > -=7D;
> > diff --git
> > a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> > b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> > index 000000000000..da48d0493cdd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> > =40=40 -0,0 +1,151 =40=40
> > +=23 SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause %YAML 1.2
> > +---
> > +=24id:
> > +https://protect2.fireeye.com/v1/url?k=3Dd24ef7e4-8dd5cefd-d24f7cab-
> 000b
> > +abff3793-d3511b88da8176a3&q=3D1&e=3D3ebd99e2-81bd-4303-988b-
> 085ab2449cc1&
> >
> +u=3Dhttp%3A%2F%2Fdevicetree.org%2Fschemas%2Fmedia%2Fsamsung%2Cs
> 5p-mfc.y
> > +aml%23
> > +=24schema:
> > +https://protect2.fireeye.com/v1/url?k=3D5aeac908-0571f011-5aeb4247-
> 000b
> > +abff3793-01e9fec8ce4d48cc&q=3D1&e=3D3ebd99e2-81bd-4303-988b-
> 085ab2449cc1&
> > +u=3Dhttp%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
> > +
> > +title: Samsung Exynos Multi Format Codec (MFC)
> > +
> > +maintainers:
> > +  - Marek Szyprowski <m.szyprowski=40samsung.com>
> > +  - Aakarsh Jain <aakarsh.jain=40samsung.com>
> > +
> > +description:
> > +  Multi Format Codec (MFC) is the IP present in Samsung SoCs which
> > +  supports high resolution decoding and encoding functionalities.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - enum:
> > +          - samsung,exynos5433-mfc        =23 Exynos5433
> > +          - samsung,mfc-v5                =23 Exynos4
> > +          - samsung,mfc-v6                =23 Exynos5
> > +          - samsung,mfc-v7                =23 Exynos5420
> > +          - samsung,mfc-v8                =23 Exynos5800
> > +          - samsung,mfc-v10               =23 Exynos7880
> > +      - items:
> > +          - enum:
> > +              - samsung,exynos3250-mfc    =23 Exynos3250
> > +          - const: samsung,mfc-v7         =23 Fall back for Exynos3250
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 3
> > +
> > +  clock-names:
> > +    minItems: 1
> > +    maxItems: 3
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  iommus:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  iommu-names:
> > +    items:
> > +      - const: left
> > +      - const: right
>=20
> That's confusing now... The iommu-names above says it requires two
> iommus, but your iommus property says one item is enough. You need here
> minItems: 1... but then why one IOMMU (for such variants) is always =22le=
ft=22?
> Probably then the meaning of first IOMMU changes, right? If that's correc=
t,
> then I propose to leave it as minItems:1/maxItems:2 without defining the
> items here and...
>=20
Agreed. That=E2=80=99s=20why=20I=20initially=20kept=20=20as=20minItems:1/ma=
xItems:2.=20=20Will=20keep=20it=20now=20as=20it=20is.=0D=0A=20=20iommu-name=
s:=0D=0A=20=20=20=20minItems:=201=0D=0A=20=20=20=20maxItems:=202=0D=0A>=20>=
=20+=0D=0A>=20>=20+=20=20power-domains:=0D=0A>=20>=20+=20=20=20=20maxItems:=
=201=0D=0A>=20>=20+=0D=0A>=20>=20+=20=20memory-region:=0D=0A>=20>=20+=20=20=
=20=20minItems:=201=0D=0A>=20>=20+=20=20=20=20maxItems:=202=0D=0A>=20>=20+=
=0D=0A>=20>=20+required:=0D=0A>=20>=20+=20=20-=20compatible=0D=0A>=20>=20+=
=20=20-=20reg=0D=0A>=20>=20+=20=20-=20clocks=0D=0A>=20>=20+=20=20-=20clock-=
names=0D=0A>=20>=20+=20=20-=20interrupts=0D=0A>=20>=20+=0D=0A>=20>=20+addit=
ionalProperties:=20false=0D=0A>=20>=20+=0D=0A>=20>=20+allOf:=0D=0A>=20>=20+=
=20=20-=20if:=0D=0A>=20>=20+=20=20=20=20=20=20properties:=0D=0A>=20>=20+=20=
=20=20=20=20=20=20=20compatible:=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=
=20contains:=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20enum:=0D=0A>=
=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20=20=20-=20samsung,mfc-v5=0D=0A>=
=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20=20=20-=20samsung,exynos3250-mf=
c=0D=0A>=20>=20+=20=20=20=20then:=0D=0A>=20>=20+=20=20=20=20=20=20propertie=
s:=0D=0A>=20>=20+=20=20=20=20=20=20=20=20clocks:=0D=0A>=20>=20+=20=20=20=20=
=20=20=20=20=20=20maxItems:=202=0D=0A>=20>=20+=20=20=20=20=20=20=20=20clock=
-names:=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20items:=0D=0A>=20>=20+=
=20=20=20=20=20=20=20=20=20=20=20=20-=20const:=20mfc=0D=0A>=20>=20+=20=20=
=20=20=20=20=20=20=20=20=20=20-=20const:=20sclk_mfc=0D=0A>=20=0D=0A>=20iomm=
us:=0D=0A>=20=20=20maxItems:=201=0D=0A>=20iommu-names:=20false=0D=0A>=20=0D=
=0AI=20am=20getting=20compilation=20errors=20with=20above=20property=20set=
=20and=20its=20breaking=20the=20bindings.=0D=0AIf=20we=20see=20these=20two=
=20nodes=20in=20dtsi=20files.=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20mfc:=20codec=4013400000=20=7B=0D=0A=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20compatible=20=3D=20=22samsung,mfc-v5=
=22;=0D=0A..=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20iommus=20=3D=20<&sysmmu_mfc_l>,=20<&sysmmu_mfc_r>;=0D=0A=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20iommu-=
names=20=3D=20=22left=22,=20=22right=22;=0D=0A=7D=0D=0AAnd=20=0D=0A=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20mfc:=20codec=4013400000=20=7B=0D=0A=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20compat=
ible=20=3D=20=22samsung,exynos3250-mfc=22,=20=22samsung,mfc-v7=22;=0D=0A=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20reg=20=
=3D=20<0x13400000=200x10000>;=0D=0A...=0D=0A=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20iommus=20=3D=20<&sysmmu_mfc>;=0D=
=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7D;=0D=0AThere=20is=20n=
o=20iommu-names=20property=20for=20compatible=20=22samsung,exynos3250-mfc,=
=20samsung,mfc-v7=22,=20that=E2=80=99s=20why=20I=20kept=0D=0A=20=20=20=20=
=20=20=20=20iommus:=0D=0A=20=20=20=20=20=20=20=20=20=20minItems:=201=0D=0A=
=20=20=20=20=20=20=20=20=20=20maxItems:=202=0D=0AI=20would=20even=20go=20wi=
th=20below=20if=20you=20agree?=0D=0A=20=20=20=20=20=20=20=20iommus:=0D=0A=
=20=20=20=20=20=20=20=20=20=20minItems:=201=0D=0A=20=20=20=20=20=20=20=20=
=20=20maxItems:=202=0D=0A=20=20=20=20=20=20=20=20iommus-names:=20false=0D=
=0A=0D=0A>=20>=20+=0D=0A>=20>=20+=20=20-=20if:=0D=0A>=20>=20+=20=20=20=20=
=20=20properties:=0D=0A>=20>=20+=20=20=20=20=20=20=20=20compatible:=0D=0A>=
=20>=20+=20=20=20=20=20=20=20=20=20=20contains:=0D=0A>=20>=20+=20=20=20=20=
=20=20=20=20=20=20=20=20enum:=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20-=20samsung,mfc-v6=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20-=20samsung,mfc-v8=0D=0A>=20>=20+=20=20=20=20then:=0D=0A>=20>=
=20+=20=20=20=20=20=20properties:=0D=0A>=20>=20+=20=20=20=20=20=20=20=20clo=
cks:=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20maxItems:=201=0D=0A>=20>=
=20+=20=20=20=20=20=20=20=20clock-names:=0D=0A>=20>=20+=20=20=20=20=20=20=
=20=20=20=20items:=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20-=20co=
nst:=20mfc=0D=0A>=20>=20+=20=20=20=20=20=20=20=20iommus:=0D=0A>=20>=20+=20=
=20=20=20=20=20=20=20=20=20maxItems:=202=0D=0A>=20=0D=0A>=20...=20and=20her=
e:=0D=0A>=20iommu-names:=0D=0A>=20=20=20items:=0D=0A>=20=20=20=20=20-=20con=
st:=20left=0D=0A>=20=20=20=20=20-=20const:=20right=0D=0A>=20=0D=0AAgreed.=
=0D=0A>=20>=20+=0D=0A>=20>=20+=20=20-=20if:=0D=0A>=20>=20+=20=20=20=20=20=
=20properties:=0D=0A>=20>=20+=20=20=20=20=20=20=20=20compatible:=0D=0A>=20>=
=20+=20=20=20=20=20=20=20=20=20=20contains:=0D=0A>=20>=20+=20=20=20=20=20=
=20=20=20=20=20=20=20enum:=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20-=20samsung,exynos5433-mfc=0D=0A>=20>=20+=20=20=20=20then:=0D=0A>=
=20>=20+=20=20=20=20=20=20properties:=0D=0A>=20>=20+=20=20=20=20=20=20=20=
=20clocks:=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20maxItems:=203=0D=0A>=
=20>=20+=20=20=20=20=20=20=20=20clock-names:=0D=0A>=20>=20+=20=20=20=20=20=
=20=20=20=20=20items:=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20-=
=20const:=20pclk=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20-=20cons=
t:=20aclk=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20-=20const:=20ac=
lk_xiu=0D=0A>=20>=20+=20=20=20=20=20=20=20=20iommus:=0D=0A>=20>=20+=20=20=
=20=20=20=20=20=20=20=20maxItems:=202=0D=0A>=20=0D=0A>=20the=20same=20here=
=0D=0A>=20=0D=0AAgreed.=0D=0A>=20>=20+=0D=0A>=20>=20+=20=20-=20if:=0D=0A>=
=20>=20+=20=20=20=20=20=20properties:=0D=0A>=20>=20+=20=20=20=20=20=20=20=
=20compatible:=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20contains:=0D=0A>=
=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20enum:=0D=0A>=20>=20+=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20-=20samsung,mfc-v7=0D=0A>=20>=20+=20=20=20=
=20then:=0D=0A>=20>=20+=20=20=20=20=20=20properties:=0D=0A>=20>=20+=20=20=
=20=20=20=20=20=20clocks:=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20minIt=
ems:=201=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20maxItems:=202=0D=0A>=
=20=0D=0A>=20iommus:=0D=0A>=20=20=20maxItems:=201=0D=0A>=20iommu-names:=20f=
alse=0D=0Asame=20explanation=20as=20above.=20Would=20prefer=20to=20go=20wit=
h=0D=0A=20=20=20=20=20=20=20=20iommus:=0D=0A=20=20=20=20=20=20=20=20=20=20m=
inItems:=201=0D=0A=20=20=20=20=20=20=20=20=20=20maxItems:=202=0D=0A=20=20=
=20=20=20=20=20=20iommus-names:=20false=0D=0A>=20=0D=0A>=20=0D=0A>=20Best=
=20regards,=0D=0A>=20Krzysztof=0D=0A=0D=0AThanks=20for=20the=20review.=0D=
=0A=0D=0A
