Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043EB6252A7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 05:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbiKKEer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 23:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbiKKEec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 23:34:32 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA386AEF5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:34:26 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221111043424epoutp014c6338a1c5a9b8859b10369547dc9cc9~mbaRflq910048400484epoutp01b
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 04:34:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221111043424epoutp014c6338a1c5a9b8859b10369547dc9cc9~mbaRflq910048400484epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1668141264;
        bh=Qm6Hsyoo5+8owZI5VR7z6vxtrQ5z2rbz8wKRmb8IT00=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=UL52olZ/cYevSY6NNAPPI0a8JhZmyClBqdVSN/8LR+Z9AmwPXBCniXOdqKbaj5637
         39TNsJJel6z06CxfJpQEgWW2IiogsEknfNihCpM5bRn0zh5ur5RUMmGyIDlWtpR3Ii
         ILDXZxVRSNB1ssze20OsopwY9NcKW/UDPdXjjwVs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221111043423epcas5p4eeaaa23b499d6862c0c632cb1c6af87f~mbaP7rfLB3045630456epcas5p4L;
        Fri, 11 Nov 2022 04:34:23 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4N7m7d0q0hz4x9QF; Fri, 11 Nov
        2022 04:34:21 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.F8.56352.CC0DD636; Fri, 11 Nov 2022 13:34:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221111031930epcas5p46b0cab85f2bdfe50eb9e431e86461ae5~maY4Ger6k0952909529epcas5p4f;
        Fri, 11 Nov 2022 03:19:30 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221111031930epsmtrp2ddfe12e08d7b280b50b1472f1b91cd74~maY4FEYBz1811618116epsmtrp2e;
        Fri, 11 Nov 2022 03:19:30 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-78-636dd0cc3cbc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.4C.18644.24FBD636; Fri, 11 Nov 2022 12:19:30 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221111031927epsmtip2690d34e5f17005a059707d9d9cb395ec~maY04NDEL0519405194epsmtip2H;
        Fri, 11 Nov 2022 03:19:27 +0000 (GMT)
From:   "Aakarsh Jain" <aakarsh.jain@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzk@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
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
        <pankaj.dubey@samsung.com>, <smitha.t@samsung.com>
In-Reply-To: <1126f2ec-10ec-852c-b002-119781b91b58@kernel.org>
Subject: RE: [Patch v2 1/3] arm: exynos: Add new compatible string for
 Exynos3250 SoC.
Date:   Fri, 11 Nov 2022 08:49:25 +0530
Message-ID: <00e901d8f57c$6996a5e0$3cc3f1a0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH93wRx5mB7au8KVEFSf1YZqxrmqQIInJ4oAoPuhXEBxQwNNgG+QjDlra670LA=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xbZRTP13vbW2gqV2Djo1Fg18wN5Olo94GALizb1aqQLAY2dVjLTcGW
        tvahbKJOxmZgpZmG6SgMtvESxAHlzUA3HhsQNsZgYJDy3AQUJwLOIhptKSj//c45v9/5fed8
        OVzMNZ8QcJOVOkajlCgojjPe0OHrG3DrToo0uGAHmixo4KAi6ywLTRQt46i9tp5AdUN5GCq7
        eY2NCjtvs1Hj9Wkc1czZqgO5FhzNFl4BaN40zkH9/dUEMs5NYajtZ5vMPDPMRoMt+RxkqK5n
        o286LQQqGRlgoVLzXyx0uX6FQKfaOglkaW0AKON0J+sFT7qyoBLQTZZiQI8UL2F0s8lC0EWt
        8yzaXJHJoceGWzl0bfHH9KmuP3HaWFcB6KzOEQ69bPaie39fJmL5R+QRSYwkkdH4MEqpKjFZ
        KYukxIcSohOEouCQgJAwtJfyUUpSmEhq/8uxAQeSFbY1UD7vSRR6WypWotVSQVERGpVex/gk
        qbS6SIpRJyrUoepArSRFq1fKApWMLjwkOPhZoY34ljzpYtMQUA94pY7+0cA5AdY8s4ATF5Kh
        8MGdDpAFnLmu5FUAH35ZSjiCJQCHzy3jjmAZwO6rtzibkr5vH7EdhRYAK0/f29DPAth8Nx2z
        szhkEJzoNayz3O29WqyV6yyMLMThcPriei8nMgqe6emwYS7XjYyHhrXt9jRO7oS5Q+XAjvlk
        GPxu6kfMgR+HPbn3cTvGSG/Y+Es+5niSD1x9UMq2t3EnX4WGFaGD4gG7Vg2Y3RaSo05w1mhg
        Ofj7YevCyIbWDf50s45wYAFcfti2MaYUzlye3+AoYFVrDu7Az8NrQ/m43QsjfWFVS5Aj/SQ8
        13uF5fB9DGav3d+w4sOmgk38NMwfs7Id+AnY8XUJOAso05bJTFsmM20ZwfS/20WAVwBPRq1N
        kTFaoXqPknn/vx+XqlLMYP1M/MRNYHpyMbAdsLigHUAuRrnzebvlUld+ouTYcUajStDoFYy2
        HQht6/4ME2yTqmx3ptQlhISGBYeKRKLQsD2iEMqDX3TeT+pKyiQ6Rs4wakazqWNxnQQnWLh3
        G+n1RVH2+Pf5o0biw4PeSYGMS2mFPI2RW468Ej0f5ZyG9pr/tp58yisjxt+b948sbkC87TmB
        3uOjxRxx4/Wx4+PKmqiRt9/sFyzuWFQl3+gzplMHRn99x5q2fdB/V/ZLU/vK9QdlhPHuXNDC
        +clw67HMsrhdg7+JP4joWIo+XNXAbg8wipxerzo8ZZ4e48eenGcJ6pVnck09vEtusr5mTpxT
        Obuwu6Q4xjun2dVZiOXx1iZmMgW1C3kvutTwCjOOxru/8WjnIXP66qe6Z/a5nB1yfm24bCXq
        hwvvJt/wENzu7hL6f05Ep6TuXosPT7xQYDLpL/XeO+oXI5bzqj9J/YrCtUmSED9Mo5X8C/zI
        DHuvBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZdlhJXtdpf26ywcGlyhYP5m1js1j84zmT
        xf3Fn1ksDm3eym6x5cpsZovlxw+wWsw/co7VYvvBRywWG18AZS/OvMti8Xz+OkaLl7PusVmc
        P7+B3aLvxUNmi72vgdo2Pb7GanF51xw2i54NW1kt1h65y26x9PpFJotlm/4wWSza+oXdonXv
        EXaLu3u2MVq0tB1hcpD0WDNvDaPHjrtLGD2uL/nE7LFz1l12j8V7XjJ5bFrVyeZx59oeNo/N
        S+o9Wo/+YvHo27KK0aPryHU2j8+b5DxOff3MHsAbxWWTkpqTWZZapG+XwJWxYMcVxoKLchW3
        vm9ja2D8LdnFyMkhIWAicWbfN9YuRi4OIYEdjBK/Jn1mhUjISPxvO8YOYQtLrPz3nB2i6Cmj
        xOdXN1hAEmwC+hL3T/WANYgIfGOUmPirGqSIWWAzi8Ta1j0sEB0LmSQmbJsL1sEpYCfRffIw
        G4gtLBAm8exnNyOIzSKgKjHzykowm1fAUmL/w2fMELagxMmZT8B6mQW0JZ7efAply0tsfzuH
        GeI8BYmfT5cBXcEBdIWfRM8XU4gScYmjP3uYJzAKz0IyaRaSSbOQTJqFpGUBI8sqRsnUguLc
        9NxiwwKjvNRyveLE3OLSvHS95PzcTYzglKKltYNxz6oPeocYmTgYDzFKcDArifBya2QnC/Gm
        JFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cA0sea2kmbdIZG/
        8y7M7AwOLz6wSCbfM+kdg/oXQ5kz3y/3sltkxZosfKW4e2GMR7pNwyn+pdOnmZ196Zs3w/WG
        973gy/vfn6pnncX6YtnDr2pMX/bfXML+sJ9B90bT3qbrQWcLp13a8VfmRhz33DTZZxkLTURP
        +t4KePN3k5Cy+HGpnWf2ulpc/ePqOuHiA55lP7Id/7xY/kmgyDmlV2rdc8l1lQnznJktLjyS
        fhDrLl8vrHNPn+fP5slGe5IvB88PiUn8pjvnQWrlm6lO99kllR/PX6E2leHTvfPHuVjvsJ/Y
        PXXfg2Teb4/Pv48viDik3Plw303pR658KyWdf59ll1ZelCvyqvSJTczDH7NOVSuxFGckGmox
        FxUnAgAWTBQwmAMAAA==
X-CMS-MailID: 20221111031930epcas5p46b0cab85f2bdfe50eb9e431e86461ae5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221109034803epcas5p26644fa402ff1837754b61c1a307b2bb8
References: <CGME20221109034803epcas5p26644fa402ff1837754b61c1a307b2bb8@epcas5p2.samsung.com>
        <20221109035507.69086-1-aakarsh.jain@samsung.com>
        <5741e444-00b3-16f6-d012-f2b77cf8b0b2@linaro.org>
        <001101d8f449$c78f8010$56ae8030$@samsung.com>
        <1126f2ec-10ec-852c-b002-119781b91b58@kernel.org>
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
> From: Krzysztof Kozlowski [mailto:krzk@kernel.org]
> Sent: 10 November 2022 13:56
> To: Aakarsh Jain <aakarsh.jain@samsung.com>; 'Krzysztof Kozlowski'
> <krzysztof.kozlowski@linaro.org>; linux-arm-kernel@lists.infradead.org;
> linux-media@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org
> Cc: m.szyprowski@samsung.com; andrzej.hajda@intel.com;
> mchehab@kernel.org; hverkuil-cisco@xs4all.nl;
> ezequiel@vanguardiasur.com.ar; jernej.skrabec@gmail.com;
> benjamin.gaignard@collabora.com; krzysztof.kozlowski+dt@linaro.org;
> stanimir.varbanov@linaro.org; dillon.minfei@gmail.com;
> david.plowman@raspberrypi.com; mark.rutland@arm.com;
> robh+dt@kernel.org; krzk+dt@kernel.org; andi@etezian.org;
> alim.akhtar@samsung.com; aswani.reddy@samsung.com;
> pankaj.dubey@samsung.com; smitha.t@samsung.com
> Subject: Re: [Patch v2 1/3] arm: exynos: Add new compatible string for
> Exynos3250 SoC.
> 
> On 09/11/2022 15:44, Aakarsh Jain wrote:
> >
> >
> >> -----Original Message-----
> >> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
> >> Sent: 09 November 2022 14:31
> >> To: Aakarsh Jain <aakarsh.jain@samsung.com>; linux-arm-
> >> kernel@lists.infradead.org; linux-media@vger.kernel.org; linux-
> >> kernel@vger.kernel.org; devicetree@vger.kernel.org
> >> Cc: m.szyprowski@samsung.com; andrzej.hajda@intel.com;
> >> mchehab@kernel.org; hverkuil-cisco@xs4all.nl;
> >> ezequiel@vanguardiasur.com.ar; jernej.skrabec@gmail.com;
> >> benjamin.gaignard@collabora.com; krzysztof.kozlowski+dt@linaro.org;
> >> stanimir.varbanov@linaro.org; dillon.minfei@gmail.com;
> >> david.plowman@raspberrypi.com; mark.rutland@arm.com;
> >> robh+dt@kernel.org; krzk+dt@kernel.org; andi@etezian.org;
> >> alim.akhtar@samsung.com; aswani.reddy@samsung.com;
> >> pankaj.dubey@samsung.com; smitha.t@samsung.com
> >> Subject: Re: [Patch v2 1/3] arm: exynos: Add new compatible string
> >> for
> >> Exynos3250 SoC.
> >>
> >> On 09/11/2022 04:55, Aakarsh Jain wrote:
> >>> Since,MFC v7 support was added for Exynos5420 and Exynos
> >>> 3250 SoC with same compatible string "samsung,mfc-v7".As both SoCs
> >>> having different hardware properties and having same compatible
> >>> string for both SoCs doesn't seems to be correct.
> >>> New compatible is added for Exynos3250 SOC which will differentiate
> >>> the node properties for both SoCs which support MFC v7.
> >>>
> >>> Reviewed-by: Tommaso Merciai
> >> <tommaso.merciai@amarulasolutions.com>
> >>> Suggested-by: Alim Akhtar <alim.akhtar@samsung.com>
> >>> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/media/s5p-mfc.txt | 9 +++++----
> >>
> >> Use subject prefixes matching the subsystem (git log --oneline -- ...).
> >>
> > As with recent commits on
> Documentation/devicetree/bindings/media/s5p-mfc.txt with git log --
> oneline --  ,  subject prefix doesn't seems to be consistent.
> >
> > b1394dc151cb media: s5p-mfc: Adding initial support for MFC v10.10
> > 60641e22599a [media] s5p-mfc: Use preallocated block allocator always
> > for MFC v6+
> > 003611334d55 [media] s5p-mfc: Add support for MFC v8 available in
> > Exynos 5433 SoCs
> > 0da658704136 ARM: dts: convert to generic power domain bindings for
> > exynos DT 77634289286a ARM: dts: Update clocks entry in MFC binding
> > documentation
> > 2eae613b95a7 ARM: EXYNOS: Add MFC device tree support
> 
> s5p-mfc is not a subsystem.
> 
> git log --oneline  -- Documentation/devicetree/bindings/media/
> 
> media: dt-bindings: NAME_OF_FILE:
> 
Thanks for clarification.
> 
> >
> > Closest is ARM: dts.
> 
> This is not ARM subsystem and not a DTS file.
> 
> > so what is your suggestion on this?
> >
> > Anyway we are in a process of converting this txt file to yaml .
> >
> 
> Best regards,
> Krzysztof


