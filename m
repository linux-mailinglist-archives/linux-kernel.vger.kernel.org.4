Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B1C6A52D0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 07:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjB1GFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 01:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjB1GFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 01:05:20 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F0D233C0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 22:05:16 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230228060513epoutp024979d55fa170036672f2d9edcb87e26c~H59r96FvO0525305253epoutp02h
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 06:05:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230228060513epoutp024979d55fa170036672f2d9edcb87e26c~H59r96FvO0525305253epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677564314;
        bh=464YQvdb/XSIjOJYt9Ni/UD4zizTki95m9YVtDiqviA=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=ArPD8Tp3WQb44dQRV8w5S9+IWj9guSN/4dwaRN+8A/Ahap8bEbyoAmHcslC95/pnp
         iVBziW9frDhWdADWkt8lel5xMNsTFivW0+aVRayXpdbAfwl7TkaHLCRbLCFo+Oq4QW
         38iPbAp/36wE1s8lby6I8hMNEuKAnOqGuU3aRxjo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230228060513epcas5p4caae9543fd0365a4e4346337f5afe82a~H59rTsIiF2448424484epcas5p4_;
        Tue, 28 Feb 2023 06:05:13 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PQn071X4sz4x9QL; Tue, 28 Feb
        2023 06:05:11 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.47.55678.7999DF36; Tue, 28 Feb 2023 15:05:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230227113830epcas5p4a46a1faff7a35fb42ac4f55b1aa95022~Hq3YnVA4F0626306263epcas5p4x;
        Mon, 27 Feb 2023 11:38:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230227113830epsmtrp23c849389b6df30164dc0c246ef1648a2~Hq3YmM0GO1907919079epsmtrp2I;
        Mon, 27 Feb 2023 11:38:30 +0000 (GMT)
X-AuditID: b6c32a4a-6a3ff7000000d97e-fa-63fd999711b2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AD.94.05839.5369CF36; Mon, 27 Feb 2023 20:38:30 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230227113826epsmtip1a4635f1ff12826e2124cb7e90c7d8e79~Hq3VjxbVd0772607726epsmtip1k;
        Mon, 27 Feb 2023 11:38:26 +0000 (GMT)
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
In-Reply-To: <ef93fea2-e4db-7c28-b911-13b046352214@linaro.org>
Subject: RE: [Patch v5] dt-bindings: media: s5p-mfc: convert bindings to
 json-schema
Date:   Mon, 27 Feb 2023 17:08:25 +0530
Message-ID: <021c01d94aa0$03714d00$0a53e700$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQDV1Pt8NDWrXdQdIVLeYa8OJBqdcQLhSdg4Af7UlIywwpPw0A==
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xbZRjOd87pacFVj1zkW4ezOW4yMFzKCjudg13YzEExweEas0hqU46A
        9Ja26JgJQwdjEsZgMA1dZY5rQORSysa4JLWUIEw3kQpeYMCY47JBCJ3aFbbZUlD+Pe/zvk/e
        5/m+vBzUp5TN46QrdYxGKZWTuDd2tTc4KPTL8seyiHs3cGqy4ipOVTlmEGqiyo5RlrZ2NmWy
        XUKpun4zi7psvcmirn13B6NaZ13dofJxjJq53ASoOf1tnCqanUKpnvsuhXF6hEUNdxpwqrCl
        nUV9ax1nUzWjQwhVa1xFqMr2h2wqr8fKpnLPWJEDAXRjRSOgO8arAT1avYzS1/XjbLqqew6h
        jQ2f4/TYSDdOt1WfovP6nBhdZGoAdIF1FKftxu304F92diL3eMa+NEaawmj4jFKmSklXpsaQ
        byZJ4iRR0RGCUIGI2kPylVIFE0MeTkgMfT1d7kpP8j+SyjNdVKJUqyXDY/dpVJk6hp+m0upi
        SEadIlcL1WFaqUKbqUwNUzK6vYKIiMgo1+D7GWnDORVAbX7vxA+OFiQHrMQVAC8OJITQ0VUE
        3NiH6AKw6byiAHi78DKA7av3cE/xN4B1bc34hsL2y531Rg+AZ/NbEE8xA6D9gZHlnsKJcDgx
        WMhyN/yIPgAnTVOou0CJfAyW/JyzttGLiIWWiptsN/YlxPCLPDPixhixE86OO107OBwuIYLW
        07Fumks8DwfK72JujBKvwtor91GPJT589Gcty8MHwL5HhWu8H3EItub2rpmARK8XnL41j3kE
        h+HZ2/3rYl84329iezAP2hd71nPK4HTl3PqMHDZ3l61r90OzzYC5vaFEMGzuDPfQL8KLg02I
        x8Oz8NzKXcTDc2FHxQZ+BRrGHCwPDoS939SAYkDqN0XTb4qm3xRH//+2rwHWALYyaq0ildFG
        qSOVzMf//bhMpTCCtesIeaMDTE0uhVkAwgEWADko6ce98seqzIebIs06yWhUEk2mnNFaQJTr
        uUtQnr9M5TovpU4iEIoihNHR0ULR7mgBGcANihmQ+RCpUh2TwTBqRrOhQzhevBwk2zmpqt7d
        mlUaNNZVKf5gsYnDql8NdDQtqmQCnuhIf+myyXrjH/+lMtv+pw/9dr0mSErwL/7Umr/ndPzW
        XclJfFvywnx1o5N34dL5o9l4/LGU7dbUY4UvXB/ycfzKPbUiGEzfNt0Zpco2iGvOVQ3sCLlQ
        Utyb88D89oHhAjv43aY/Uf+WyPeTl8zlT7bkzV9bGXp6ZBD7XmhJ4C7mHmfif+S2fChpDJ1+
        ZzLuzDZSbH156aDktx0G/ojI/yLTbcwNXk70/sp5K3N0TIFtYRUmZ4nrV8fqFhZqExd3/kQP
        OcvSAiL18KjDa8XUEmgY/uyZ4ufefSy2OE8m6dqfBB/cO1FAYto0qSAE1Wil/wKxpFR8pgQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xSYRjG951zOOfook5I8dk9slo3zdblqzUzs3Zy67aKlmsrpmfqEjTo
        Zlt201pkdDErqLSCtNAuInbFFgg1XFoaYjWxtAgvrVrqhpaVyNr873l/z/s8e/94aVzQS4yi
        U+Q7OYVcmiomg4n7leJxs+af/50w++9ZgD7m3yeRzufF0AddJ4GsZeUUMjkv4ajoxTMeKrDV
        8NADSwuBSlv73VqNm0DegjsAtWmbSKRubcZRRUd/wvjJxUNvHl8mUc69ch66bXNT6EZDLYYK
        jb8xdL28i0LZFTYKZR21YdEitiS/BLAP3XrANuh/4uwjrZtideY2jDUajpNso8tMsmX6A2y2
        vZdg1SYDYFW2BpLtNI5jq7o7qbX8+ODFiVxqym5OERG1LTjZkzcl3RW/94b+Cn4QZMeoQBAN
        mbnQWd9CqkAwLWCeAGhv78MCxhj49+hzKqBD4K0/Xiqw5AGwuMAysEQyEfBDVQ7PbwgZB4Cn
        XmYNDDijIWD96edYIGIBsCyvCvgjQUwUtObX9HfRdAizAf7qnunHBDMZtrp7ST/mMwuh7UiU
        H/OZ4dCh+Uz4Nc7MgCebs8F/XXitAw9cNwH2eAp5AS6C9p6cAS5kYmBpViXvNAjRDqrSDqrS
        DqrSDopfBYQBhHLpSlmSTBmZHinn9oQrpTLlLnlSeEKazAgG3mP6tIfggeFHuBVgNLACSONi
        Ib/R4UsQ8BOlGfs4RdpWxa5UTmkFo2lCLOK/Vjm2Cpgk6U5uO8elc4r/LkYHjTqI1eAjIg8n
        zXO1576+8l191ZloOfN0wZqbZFM1vb87dY1kWlpNSsPyzsOrRr7DM0dcfP/xbvP4OxnrDMl/
        hpZUH5PfjFtfappQpImTqKYemtPX9e1adN0Sz5BL0evMMtGkC5n2PfYvLXmm+BN9ZZvxplNb
        GmO9hNmyVKAZOVES9rlurNYryLmstHo3Ni4wh0b5unYX184Ju/h2kTPCs9kQlKlW1Omr76a4
        V+qiq9eG9ZrI0LnCBMkO/vcLsXsr1c1cfPEy56bE0a5cXsZEYYXZ2RFjkrZ/8vYI2Hmri86G
        pcX5vsaKfj0blmmgdO8fye9RxyW+FSVk/XD8XFsucUjjeCUmlMnSyOm4Qin9B+cyaQONAwAA
X-CMS-MailID: 20230227113830epcas5p4a46a1faff7a35fb42ac4f55b1aa95022
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230227084748epcas5p2602a39017d3366bdfb5af95088ed89dc
References: <CGME20230227084748epcas5p2602a39017d3366bdfb5af95088ed89dc@epcas5p2.samsung.com>
        <20230227084736.89361-1-aakarsh.jain@samsung.com>
        <ef93fea2-e4db-7c28-b911-13b046352214@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
> Sent: 27 February 2023 15:21
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
> Subject: Re: =5BPatch v5=5D dt-bindings: media: s5p-mfc: convert bindings=
 to json-
> schema
>=20
> On 27/02/2023 09:47, Aakarsh Jain wrote:
> > Convert s5p-mfc bindings to DT schema format using json-schema.
> >
> > Signed-off-by: Aakarsh Jain <aakarsh.jain=40samsung.com>
> > ---
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
> >  .../bindings/media/samsung,s5p-mfc.yaml       =7C 148
> ++++++++++++++++++
> >  2 files changed, 148 insertions(+), 78 deletions(-)  create mode
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
> > index 000000000000..b4a289619db0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> > =40=40 -0,0 +1,148 =40=40
> > +=23 SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause %YAML 1.2
> > +---
> > +=24id:
> > +https://protect2.fireeye.com/v1/url?k=3D854d051c-e4c61026-854c8e53-
> 74fe
> > +4860008a-fcfe16271c217cbf&q=3D1&e=3D3cdd6dac-7b8e-46be-97b0-
> 8dcfc73fae2d&
> >
> +u=3Dhttp%3A%2F%2Fdevicetree.org%2Fschemas%2Fmedia%2Fsamsung%2Cs
> 5p-mfc.y
> > +aml%23
> > +=24schema:
> > +https://protect2.fireeye.com/v1/url?k=3Dc84eeb37-a9c5fe0d-c84f6078-74f=
e
> > +4860008a-c1bfcc6b2d35840d&q=3D1&e=3D3cdd6dac-7b8e-46be-97b0-
> 8dcfc73fae2d&
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
> > +          - samsung,mfc-v5              =23 Exynos4
> > +          - samsung,mfc-v6              =23 Exynos5
> > +      - items:
> > +          - enum:
> > +              - samsung,exynos3250-mfc  =23 Exynos3250
> > +          - const: samsung,mfc-v7       =23 Fall back for Exynos3250
> > +      - enum:
> > +          - samsung,mfc-v7              =23 Exynos5420
> > +          - samsung,mfc-v8              =23 Exynos5800
> > +          - samsung,exynos5433-mfc      =23 Exynos5433
> > +          - samsung,mfc-v10             =23 Exynos7880
>=20
> Why this and first enum are separate?  I didn't notice it before...
> Usually we have only one enum for one-compatible variants. Also, sort the=
m
> by compatible.
>=20
okay.
I will keep it in this way
properties:
  compatible:
    oneOf:
      - const: samsung,mfc-v5              =23 Exynos4
      - const: samsung,mfc-v6              =23 Exynos5
      - const: samsung,mfc-v7              =23 Exynos5420
      - const: samsung,mfc-v8              =23 Exynos5800
      - const: samsung,exynos5433-mfc      =23 Exynos5433
      - const: samsung,mfc-v10             =23 Exynos7880
      - items:
          - const: samsung,exynos3250-mfc  =23 Exynos3250
          - const: samsung,mfc-v7          =23 Fall back for Exynos3250

Will this be fine?
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
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  memory-region:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - interrupts
> > +
> > +additionalProperties: false
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - samsung,mfc-v5
> > +              - samsung,exynos3250-mfc
> > +    then:
> > +      properties:
> > +        clocks:
> > +          maxItems: 2
> > +        clock-names:
> > +          items:
> > +            - const: mfc
> > +            - const: sclk_mfc
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - samsung,mfc-v6
> > +              - samsung,mfc-v8
> > +    then:
> > +      properties:
> > +        clocks:
> > +          maxItems: 1
> > +        clock-names:
> > +          items:
> > +            - const: mfc
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - samsung,exynos5433-mfc
> > +    then:
> > +      properties:
> > +        clocks:
> > +          maxItems: 3
> > +        clock-names:
> > +          items:
> > +            - const: pclk
> > +            - const: aclk
> > +            - const: aclk_xiu
>=20
> What happened to iommus? You were requiring two items, but you dropped
> that requirement. Is it on purpose?
>=20
 Actually I thought I defined at top via items so it will cover all scenari=
os.
I will add it again iommus : maxItems as 2
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - samsung,mfc-v7
> > +    then:
> > +      properties:
> > +        clocks:
> > +          minItems: 1
> > +          maxItems: 2
> > +
> > +examples:
> > +  - =7C
> > +    =23include <dt-bindings/clock/exynos4.h>
> > +    =23include <dt-bindings/clock/exynos-audss-clk.h>
> > +    =23include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    =23include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    codec=4013400000 =7B
> > +          compatible =3D =22samsung,mfc-v5=22;
>=20
> You sill have here odd indentation. Use 4 spaces for DTS example.
>=20
okay will rearrange .

> > +          reg =3D <0x13400000 0x10000>;
> > +          interrupts =3D <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
> > +          power-domains =3D <&pd_mfc>;
> > +          clocks =3D <&clock CLK_MFC>, <&clock CLK_SCLK_MFC>;
> > +          clock-names =3D =22mfc=22, =22sclk_mfc=22;
> > +          iommus =3D <&sysmmu_mfc_l>, <&sysmmu_mfc_r>;
> > +          iommu-names =3D =22left=22, =22right=22;
> > +    =7D;
>=20
> Best regards,
> Krzysztof

Thanks for the review.

