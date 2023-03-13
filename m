Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132F76B6E45
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 04:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjCMD7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 23:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjCMD7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 23:59:19 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F2A25E29
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 20:59:17 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230313035912epoutp038945baa328ce4c4e5170a87ae1353c65~L3oXFNEJT0411604116epoutp03f
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:59:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230313035912epoutp038945baa328ce4c4e5170a87ae1353c65~L3oXFNEJT0411604116epoutp03f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678679952;
        bh=wTC+0pDKDgwOW3WmAt1VSg7GlSnQVMD9S3MrTsQ+BZo=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=UxMtP3akwuVmgCOBhYdRUJ+BS7lF3xKFzOGIvU6KB81mQ8O4N/iifMc4WT6PiEkR6
         C9Kw5J5Nt36PdUdTB00JXLhOBpTN56er+ktJOxpbza+HyzCYPS7NXQG63D3Z6wQAIz
         nBGHC5brsaZkX7aYUa/C/BPIF+MlX7q55URvml44=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230313035911epcas5p4083df4308aa7997ee70bc2043968b419~L3oWAtcd-2088220882epcas5p4b;
        Mon, 13 Mar 2023 03:59:11 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PZjZj200xz4x9Q7; Mon, 13 Mar
        2023 03:59:09 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        99.D0.10528.D8F9E046; Mon, 13 Mar 2023 12:59:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230313035608epcas5p2d53d26c0e8b82d698fe8c4b8a139afbd~L3lr6LTgL1215112151epcas5p2F;
        Mon, 13 Mar 2023 03:56:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230313035608epsmtrp17d3e2edd61560a05f4a7e727ad4b9786~L3lr4feuF1767017670epsmtrp1X;
        Mon, 13 Mar 2023 03:56:08 +0000 (GMT)
X-AuditID: b6c32a49-e75fa70000012920-21-640e9f8d1200
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.04.18071.8DE9E046; Mon, 13 Mar 2023 12:56:08 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230313035604epsmtip2b1633f1acdd41c45b5e8369c5756aeb3~L3loo7f7U0289602896epsmtip2w;
        Mon, 13 Mar 2023 03:56:04 +0000 (GMT)
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
In-Reply-To: <49106943-450a-11c0-99ce-159d40471bf2@linaro.org>
Subject: RE: [Patch v6] dt-bindings: media: s5p-mfc: convert bindings to
 json-schema
Date:   Mon, 13 Mar 2023 09:26:03 +0530
Message-ID: <010601d9555f$bde202a0$39a607e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHxIgKtygHqPU4mHAhqu15r4A65nwLsA7LZAklDK9wB4osi/QJmoqxPAoFahrkB+xU0ewI/Pkh+AQklyQeuPlux0A==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf1CTdRzH++559myAg6eBx1c0DmeUaPxYDXpW/Kg0eww98Sq6PAt27AmI
        se32A5S4AgJ0/Cakk4VAwKCA+CUg0iCEEScBHaaSxhggBBO9jB+B2FXbHiz+e31+vu/9+d6X
        jXCLWG7sWKmKUkhFEh5mj3b0e+31zi13FPuV3XUgpso6MKJqfZ5BmKqWUaLvYjuLaLv+JULU
        DvYyiXLDKJO4dGUGJVoWLNWxEiNKzJc3AsKsncSIvIVphOhetEy03rnJJH7uKsWInOZ2JvGt
        wcgidONjDKKm9S8GUdm+wiIyug0sIj3TwHjFlWwoawBkp7EakOPVSwh5WWtkkVV6M4NsrdNg
        5MRNPUZerP6UzBjYQMm8tjpAZhnGMXK51Z0cWl1mhXFOxAXGUCIxpfCgpFEycaw0OogX+lbE
        gQj/AD++N19IvMjzkIriqSDewSNh3odiJRb3PI8EkURtSYWJlEqeb3CgQqZWUR4xMqUqiEfJ
        xRK5QO6jFMUr1dJoHymleonv5/e8v6UxMi4m48ZthvzyzlOG9jQsBVRxs4AdG+ICOKYrZlmZ
        i38H4IBGkAXsLbwE4HzB5wgd/AngsLkHywJs28S1pW10vhvAOlMmSgfzAG7cGLKtwnBfaBrK
        YVoLLvgAgFNt07ZVCH4GhYXXUoC1yw4PhsP9nUwrO+PhcLrlLGZlFPeEmrkc2yYOLoTpM0uA
        5ifh1ZJZ1MoIvh/WfLWI0CY84MO5GtseF/wjuDiSitE9rnDgYY5NGOL9drB5fhSjBw7CjB8X
        mDQ7w7uDbSya3aA5P3OTo+CdSvOmgAQ26c+hNIfA3uulqPUWCO4Fm7p86fRTsHiokUHrOsLc
        R7MMOs+BnWWP+RlYOrG+KbsL9tfrQAHgabdY026xpt1iQfu/WgVA68AOSq6Mj6aU/nK+lEr8
        78WjZPGtwPY79h3uBMapBz59gMEGfQCyEZ4Lp81pm5jLEYtOJ1EKWYRCLaGUfcDfcu9CxG17
        lMzyvaSqCL5A6CcICAgQCF8I4PNcOc8GXY3i4tEiFRVHUXJK8XiOwbZzS2EUOL7r3nXM+0CH
        wsXQuOcbDSP8uffbN8i0S46VFeebZl5Tt2SrT74uSz658mr9avo7Ti0TmdwSD3HuWq3J/IEv
        JdYGnv7bf7vmaNIvIQ099feL3yt+uyhvMe/oSJKP0VMfWbR3LmzkSugXnzgEer4pf1kp1gjX
        7quOFCaEP3Fhx9eDq2eKu0vXUkw7V+6d45w6PuR0VvcTfnjt2CST26ubHN5dKWzU/LreOFt1
        z5R8/sKDVKGem5X+m84+sedRRu1i5K1DCTFjn6EffjzztBf+T37HAvP3HxyMwdn5u3u+P+48
        /cbtP+r11aP4rv3pTT63kpNlic1dpJOkIjt1yj0k9ETacNKeJB6qjBHx9yEKpehfIe9ZKqYE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsWy7bCSvO6NeXwpBouf8Fs8mLeNzWLxj+dM
        FvcXf2axOLR5K7vFliuzmS2WHz/AajH/yDlWi+0HH7FYbHwBlL048y6LxfP56xgtXs66x2bR
        9+Ihs8Xe10Admx5fY7W4vGsOm0XPhq2sFmuP3GW3WHr9IpPFsk1/mCwWbf3CbtG69wi7RUvb
        ESYHcY8189Yweuy4u4TR4/qST8weO2fdZfdYvOclk8emVZ1sHneu7WHz2Lyk3qP16C8Wj74t
        qxg9uo5cZ/P4vEnO49TXz+wBvFFcNimpOZllqUX6dglcGZ+bIwoapSvOtMxkbGB8LtjFyMEh
        IWAicekTTxcjF4eQwG5Gif0XD7F3MXICxWUk/rcdg7KFJVb+e84OUfSUUeJrSxMrSIJNQF/i
        /qkeVpCEiMBJRon+My1gDrPATBaJqxOOMUG0PGCWODF9FiNIC6eAncSZwzvA2oUFQiR+NWwF
        s1kEVCU6n/aA7eMVsJRoefSJEcIWlDg58wkLiM0soC3x9OZTOHvZwtfMEPcpSPx8ugxsjohA
        lsTrs41sEDXiEkd/9jBPYBSehWTULCSjZiEZNQtJywJGllWMkqkFxbnpucWGBYZ5qeV6xYm5
        xaV56XrJ+bmbGMHpQ0tzB+P2VR/0DjEycTAeYpTgYFYS4d3Cz5MixJuSWFmVWpQfX1Sak1p8
        iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA9MJqQ+63MXT7jH+UDyxqdCUI6M98Jje
        63kTHx5fcfXY+clrjyV5pskvv/vbvPnoR99Mz6nHF6WvuGQmmegcL8zYqcQ4o/Tyyx/7ipvz
        9/NrJ/x7p7CYh0skYGvZ080Xfjv/L/H8IraTO++StcPNdCPx/ukMQg+uFr8ya1h245uJ5/fd
        zSqaQTV9FTzrxGvyJA5NSP9c12PpV1lnsMFnLr9LTNL86syVR5YvvBYqM+dob5L3QtVavR77
        64/mG/urPnsTsur1zLebXWWyW7+I9+h5x316dOntyfch8bPP7tiQava/00piSfZcrkeHO7RV
        g9QyL3Mt+fZgoSKbiMbzt38XrmbradNJ5s6xfsrM1q7EUpyRaKjFXFScCABK65LhjgMAAA==
X-CMS-MailID: 20230313035608epcas5p2d53d26c0e8b82d698fe8c4b8a139afbd
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
        <001901d95263$eac4b460$c04e1d20$@samsung.com>
        <49106943-450a-11c0-99ce-159d40471bf2@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PDS_BAD_THREAD_QP_64,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
> Sent: 10 March 2023 14:38
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
> On 09/03/2023 09:48, Aakarsh Jain wrote:
> >>> won't fit here.
> >>> Since IOMMUs maxItems is 2 here for Exynos4. Giving maxItems:2 alone
> >> will also break the bindings. Thanks why suggested
> >>>          iommus:
> >>>            minItems: 1
> >>>            maxItems: 2
> >>
> >> Are you sure you are putting this in correct place? This is if:then
> >> for Exynos3250, isn't it?
> >>
> > Its not only for Exynos3250, its along with Exynos4 since their clock
> > properties are same
> > allOf:
> >   - if:
> >       properties:
> >         compatible:
> >           contains:
> >             enum:
> >               - samsung,mfc-v5        =23Exynos4
> >               - samsung,exynos3250-mfc
> >     then:
> >       properties:
> >         clocks:
> >           maxItems: 2
> >         clock-names:
> >           items:
> >             - const: mfc
> >             - const: sclk_mfc
> >         iommus:
> >           minItems: 1
> >           maxItems: 2
> >
> > or do I keep different if:then condition for both Exynos3250 and Exynos=
4
> for IOMMUs property ?
>=20
> Yes, they should be split into two if-then.
>=20
okay will keep it in this way.
  - if:
      properties:
        compatible:
          contains:
            enum:
              - samsung,mfc-v5
    then:
      properties:
        clocks:
          maxItems: 2
        clock-names:
          items:
            - const: mfc
            - const: sclk_mfc
        iommus:
          maxItems: 2
        iommu-names:
          items:
            - const: left
            - const: right

  - if:
      properties:
        compatible:
          contains:
            enum:
              - samsung,exynos3250-mfc
    then:
      properties:
        clocks:
          maxItems: 2
        clock-names:
          items:
            - const: mfc
            - const: sclk_mfc
        iommus:
          maxItems: 1
        iommus-names: false

Also, =22samsung,mfc-v7=22 compatible is used for both SOCs Exynos 5420 & E=
xynos 3250.
And for both SOCs, clock and IOMMUs properties are different. So in order t=
o differentiate that, will keep it in this way.
  - if:
      properties:
        compatible:
          contains:
            enum:
              - samsung,mfc-v7
    then:
      properties:
        clocks:
          minItems: 1
          maxItems: 2
        iommus:
          minItems: 1
          maxItems: 2

I hope that will be fine?
>=20
> Best regards,
> Krzysztof


