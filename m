Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E74E5B893F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 15:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiINNgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 09:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiINNgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 09:36:38 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A766237E9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 06:36:33 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220914133630epoutp03687c2496566d82b93fa56a4f31211a9a~UvZCJSV961883518835epoutp03b
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 13:36:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220914133630epoutp03687c2496566d82b93fa56a4f31211a9a~UvZCJSV961883518835epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663162590;
        bh=jxdQn9sKNQMpQidlDXQKLu/i+Z/Yw0lTnHctr22NF88=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Zhl9kD/UrW0Ppm4XgIPUTflYi0iC0LVnh0dkdUgJ6r6vdRDM7pEAuBOyzDjQ6qqAK
         xZtVyaDDdbmmm/Mijn/lbv+LiEpdYLNejfjyy+Mda+kbZ7E4Sr7JKS8Z6xKlwp4BPC
         6Rcqg3yK+vu4MfeRX6hBqpas4viEu4DiwJZ7uFB8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220914133630epcas5p229133ad282c8b03f551bc85336168070~UvZBZnOv72014920149epcas5p2Y;
        Wed, 14 Sep 2022 13:36:30 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4MSLvv4gnsz4x9Pt; Wed, 14 Sep
        2022 13:36:27 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.DD.54060.BD8D1236; Wed, 14 Sep 2022 22:36:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220914124818epcas5p4bb7e56887102928c29b2f475cc7008a5~Uuu8AwyvI2316423164epcas5p4V;
        Wed, 14 Sep 2022 12:48:18 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220914124818epsmtrp26706a2683f35114d48bb5c5f17845889~Uuu7-lfPl2435224352epsmtrp2d;
        Wed, 14 Sep 2022 12:48:18 +0000 (GMT)
X-AuditID: b6c32a4b-e33fb7000000d32c-35-6321d8dbab05
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.18.18644.19DC1236; Wed, 14 Sep 2022 21:48:17 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220914124814epsmtip12f888ca94a1710628813e5181e042c14~Uuu4uiG3l0608306083epsmtip1k;
        Wed, 14 Sep 2022 12:48:14 +0000 (GMT)
From:   "Aakarsh Jain" <aakarsh.jain@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Smitha T Murthy'" <smitha.t@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     <m.szyprowski@samsung.com>, <andrzej.hajda@intel.com>,
        <mchehab@kernel.org>, <hverkuil-cisco@xs4all.nl>,
        <ezequiel@vanguardiasur.com.ar>, <jernej.skrabec@gmail.com>,
        <benjamin.gaignard@collabora.com>, <stanimir.varbanov@linaro.org>,
        <dillon.minfei@gmail.com>, <david.plowman@raspberrypi.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <andi@etezian.org>, <alim.akhtar@samsung.com>,
        <aswani.reddy@samsung.com>, <pankaj.dubey@samsung.com>,
        <linux-fsd@tesla.com>, <aakarsh.jain@samsung.com>
In-Reply-To: <7a164961-5b32-8d80-a6f6-8c9f64622085@linaro.org>
Subject: RE: [Patch v2 01/15] dt-bindings: media: s5p-mfc: Add new DT schema
 for MFC
Date:   Wed, 14 Sep 2022 18:18:13 +0530
Message-ID: <011f01d8c838$43234ba0$c969e2e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIwYET59QqMDNmfP0SYfUTdtmHMHgGIcczBAeDI2w8CVnGc/wIQr8+8ApxhNais3ElrcA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0zTVxTHc/v7tb/CrHbI4oWIq01kIim0o9QLA7dsuPwMLjTDbXEbYFN+
        AUJpuz6cThOB4WOIhClstkPeUAMORmmBIRCEMiJZ5pgdMLA8FFIoQpDHFDRzLS0b/33ueX3P
        OTeHifmUEf7MNLmGUsklMi7DG2/uCdrPGx3eK+U/ztqLplt1dDRR0sxAlc/sNDReuYyj7iYz
        gUzWHzBk6Ouio1LLb3TUcuchjhpnnN4BnQ1H9tJ6gGb1YwzUMecMNj4apKNJxyfoflsxA+X9
        ZKajHy02AlUPDdBQjfEFDVWYVwh0vsNCIFt7M0A5Fyy0d/zIWyW3ANlqqwLkUNUSRv6stxFk
        ZfssjTTWfsMgHwy2M8imqnPk+d51nMw31QLyn+wbBJlrGWKQy8Y9ZP/qMiHe/ml6VColSaZU
        HEouVSSnyVOiubHxSe8lhYv4Ap4gAh3kcuSSDCqaG3NUzHs/TebcBZdzUiLTOk1iiVrNDT0U
        pVJoNRQnVaHWRHMpZbJMKVSGqCUZaq08JUROaSIFfP6b4c7AE+mploa/MKWNd6r0+V0iE3wf
        mAu8mJAthNca6xku9mHfBrDhRXIu8HbyEoAXMw2E+7EM4JX1x7TNDIPhKnA72gCcKrrkibID
        eG+kaCOKwQ6F4/15dJfD15V+obF5w4Gxi3B4Z9DPxV7sQ9AwqdsQ38n+GN6cMWC5gMnE2fvg
        mp3pMrPYEfBaVi5w86vwrm4Kd5cJhjXlc5i7Iw5cm66hu9jXWWbWOuGR2gV71/IwVw+QPeIF
        Wyb7CHdCDKwtvgjcvBM6+kweuz9cXuhguFkKH1XMegRksKG9EHfz27DLWoy7+sTYQbChLdRt
        DoBF/fUe3e3wyvMpz7ZYsLVkkwNh8YNndDfvhj111aAAcPVbRtNvGU2/ZQT9/2plAK8FfpRS
        nZFCqcOVYXLqy/8+XKrIMIKNUzkQ2woeTiyGdAMaE3QDyMS4vqz8YxypDytZcvorSqVIUmll
        lLobhDvX/S3m/5pU4bw1uSZJIIzgC0UikTAiTCTg7mIVBgOpDztFoqHSKUpJqTbzaEwv/0za
        mfizvzgWCn2fFiyYo+Nymr8Y86dVZ7fw7doI69EB2Y4Eqz24vCaovLJeEHZ1/cZqgbqp8YM/
        grQf7Ut5Eju88i5nQlxKG2V9fvv+74nzndbDh0+P/Z2z+8zqPGIMhFn74nknTWRb1fzaXphz
        kDQfLy4J5B9bTKyNNl/S1ZCWl9rqnm3h84npRxx/9k5/d/PDbP0c4RMQsNJ+uezs/sgc8Vid
        b1ycqSv9cuzgnpHee+tvSBPKY0p5YlkU3YaW7X7jddenZkaHkoyvmxciJdueDC897aw4V677
        OkuUUOh4+daOfKFyLPWz652/eh+fO7WuMDQJXok5UTbsUCzajxj8TFFcXJ0qERzAVGrJv6Uz
        VRmzBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZdlhJTnfiWcVkg4MfrCye7pjJavFg3jY2
        i8U/njNZ3F/8mcXi0Oat7BZbrsxmtlh+/ACrxfwj51gtth98xGKx8QVQ9uLMuywWz+evY7R4
        Oesem8Xe10DFmx5fY7V4+Crc4vKuOWwWPRu2slqsPXKX3WLp9YtMFss2/WGyWLT1C7tF694j
        7BZ392xjtGhpO8LkIOmxZt4aRo8dd5cwelxf8onZY+esu+wei/e8ZPLYtKqTzePOtT1sHpuX
        1Hu0Hv3F4tG3ZRWjx7+mueweXUeus3l83iTncerrZ/YAvigum5TUnMyy1CJ9uwSujM9vcgq2
        6VR8PXCevYHxnUoXIyeHhICJxPLlkxi7GLk4hAR2MEp8eLmKBSIhI/G/7Rg7hC0ssfLfczBb
        SOApo8SGDl0Qm01AX+L+qR5WkGYRge+MEo3nbrCAOMwCK1kk7t7qYoEYe5pJ4v/9JWwgLZwC
        dhLLH84Es4UFQiROXF8AZHNwsAioSvx8zgES5hWwlJjc2MUIYQtKnJz5BOwiZgFtiac3n8LZ
        yxa+Zoa4TkHi59NlrCC2iECYxMsrD5ggasQljv7sYZ7AKDwLyahZSEbNQjJqFpKWBYwsqxgl
        UwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxghOLltYOxj2rPugdYmTiYDzEKMHBrCTC2xei
        kCzEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QDk0be/Av9
        WUb+B8rVrhY9bz7Sv0T5OO/5ulnP/fyMUg5c7Tt3Nbp6zxTeosWTDd/nK1s2BB3c6b7pa+Xq
        SKalZTzrmkw2P59uHK2wq850o73kVtkcEWeO2cK9UhfTV//mPF3y5dkxFY3LPi2Fa24X/yy6
        Lnk/0+FUYOaH2uif6exuFX9enOqtE5oTsz7pxl7L/abmVdKREbwp7etTm/lPT75rLbdE8tW9
        SoHEFZsnLbSwX3hf6vV/8/DdCttnRe2f88HhKfNWpbwrj32bp+kHNl5SjtIqKvQ7FVExlWmX
        +uHN3Tr/LuuueaTfUFgRGjaveHXpRRVjLqNUww1Hr5v/+165a861vt37TM/Pehp0RYmlOCPR
        UIu5qDgRAIExCsqbAwAA
X-CMS-MailID: 20220914124818epcas5p4bb7e56887102928c29b2f475cc7008a5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220907063313epcas5p114f793010fd0f2797e93bd83ed18a1d7
References: <20220907064715.55778-1-smitha.t@samsung.com>
        <CGME20220907063313epcas5p114f793010fd0f2797e93bd83ed18a1d7@epcas5p1.samsung.com>
        <20220907064715.55778-2-smitha.t@samsung.com>
        <08168057-853c-5b17-7d88-dc6c30e82f14@linaro.org>
        <000101d8c382$75750e00$605f2a00$@samsung.com>
        <7a164961-5b32-8d80-a6f6-8c9f64622085@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
> Sent: 08 September 2022 20:41
> To: Aakarsh Jain <aakarsh.jain=40samsung.com>; 'Krzysztof Kozlowski'
> <krzysztof.kozlowski=40linaro.org>; 'Smitha T Murthy'
> <smitha.t=40samsung.com>; linux-arm-kernel=40lists.infradead.org; linux-
> media=40vger.kernel.org; linux-kernel=40vger.kernel.org;
> devicetree=40vger.kernel.org
> Cc: m.szyprowski=40samsung.com; andrzej.hajda=40intel.com;
> mchehab=40kernel.org; hverkuil-cisco=40xs4all.nl;
> ezequiel=40vanguardiasur.com.ar; jernej.skrabec=40gmail.com;
> benjamin.gaignard=40collabora.com; stanimir.varbanov=40linaro.org;
> dillon.minfei=40gmail.com; david.plowman=40raspberrypi.com;
> mark.rutland=40arm.com; robh+dt=40kernel.org; krzk+dt=40kernel.org;
> andi=40etezian.org; alim.akhtar=40samsung.com; aswani.reddy=40samsung.com=
;
> pankaj.dubey=40samsung.com; linux-fsd=40tesla.com
> Subject: Re: =5BPatch v2 01/15=5D dt-bindings: media: s5p-mfc: Add new DT
> schema for MFC
>=20
> On 08/09/2022 14:56, Aakarsh Jain wrote:
> >
> >
> >> -----Original Message-----
> >> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=
=5D
> >> Sent: 07 September 2022 16:52
> >> To: Smitha T Murthy <smitha.t=40samsung.com>; linux-arm-
> >> kernel=40lists.infradead.org; linux-media=40vger.kernel.org; linux-
> >> kernel=40vger.kernel.org; devicetree=40vger.kernel.org
> >> Cc: m.szyprowski=40samsung.com; andrzej.hajda=40intel.com;
> >> mchehab=40kernel.org; hverkuil-cisco=40xs4all.nl;
> >> ezequiel=40vanguardiasur.com.ar; jernej.skrabec=40gmail.com;
> >> benjamin.gaignard=40collabora.com; stanimir.varbanov=40linaro.org;
> >> dillon.minfei=40gmail.com; david.plowman=40raspberrypi.com;
> >> mark.rutland=40arm.com; robh+dt=40kernel.org; krzk+dt=40kernel.org;
> >> andi=40etezian.org; alim.akhtar=40samsung.com;
> aswani.reddy=40samsung.com;
> >> pankaj.dubey=40samsung.com; linux-fsd=40tesla.com;
> >> aakarsh.jain=40samsung.com
> >> Subject: Re: =5BPatch v2 01/15=5D dt-bindings: media: s5p-mfc: Add new=
 DT
> >> schema for MFC
> >>
> >> On 07/09/2022 08:47, Smitha T Murthy wrote:
> >>> Adds DT schema for s5p-mfc in yaml format
> >>
> >> s/Adds/Convert/
> >> (as convert to DT schema)
> >>
> > ok, I will change.
> >
> >> Please mention here changes to original binding (I see at least
> >> adding iommus and dropping some properties).
> >>
> > ok. I will make this changes.
> >>>
> >>> Signed-off-by: Aakarsh Jain <aakarsh.jain=40samsung.com>
> >>> Signed-off-by: Smitha T Murthy <smitha.t=40samsung.com>
> >>> ---
> >>>  .../devicetree/bindings/media/s5p-mfc.txt     =7C  77 +------------
> >>>  .../bindings/media/samsung,s5p-mfc.yaml       =7C 109
> >> ++++++++++++++++++
> >>>  2 files changed, 110 insertions(+), 76 deletions(-)  create mode
> >>> 100644 Documentation/devicetree/bindings/media/samsung,s5p-
> mfc.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.txt
> >>> b/Documentation/devicetree/bindings/media/s5p-mfc.txt
> >>> index aa54c8159d9f..0b7c4dd40095 100644
> >>> --- a/Documentation/devicetree/bindings/media/s5p-mfc.txt
> >>> +++ b/Documentation/devicetree/bindings/media/s5p-mfc.txt
> >>> =40=40 -1,76 +1 =40=40
> >>> -* Samsung Multi Format Codec (MFC)
> >>> -
> >>> -Multi Format Codec (MFC) is the IP present in Samsung SoCs which
> >>> -supports high resolution decoding and encoding functionalities.
> >>> -The MFC device driver is a v4l2 driver which can encode/decode
> >>> -video raw/elementary streams and has support for all popular -video
> codecs.
> >>> -
> >>> -Required properties:
> >>> -  - compatible : value should be either one among the following
> >>> -	(a) =22samsung,mfc-v5=22 for MFC v5 present in Exynos4 SoCs
> >>> -	(b) =22samsung,mfc-v6=22 for MFC v6 present in Exynos5 SoCs
> >>> -	(c) =22samsung,mfc-v7=22 for MFC v7 present in Exynos5420 SoC
> >>> -	(d) =22samsung,mfc-v8=22 for MFC v8 present in Exynos5800 SoC
> >>> -	(e) =22samsung,exynos5433-mfc=22 for MFC v8 present in Exynos5433
> >> SoC
> >>> -	(f) =22samsung,mfc-v10=22 for MFC v10 present in Exynos7880 SoC
> >>> -
> >>> -  - reg : Physical base address of the IP registers and length of me=
mory
> >>> -	  mapped region.
> >>> -
> >>> -  - interrupts : MFC interrupt number to the CPU.
> >>> -  - clocks : from common clock binding: handle to mfc clock.
> >>> -  - clock-names : from common clock binding: must contain =22mfc=22,
> >>> -		  corresponding to entry in the clocks property.
> >>> -
> >>> -Optional properties:
> >>> -  - power-domains : power-domain property defined with a phandle
> >>> -			   to respective power domain.
> >>> -  - memory-region : from reserved memory binding: phandles to two
> >> reserved
> >>> -	memory regions, first is for =22left=22 mfc memory bus interfaces,
> >>> -	second if for the =22right=22 mfc memory bus, used when no SYSMMU
> >>> -	support is available; used only by MFC v5 present in Exynos4 SoCs
> >>> -
> >>> -Obsolete properties:
> >>> -  - samsung,mfc-r, samsung,mfc-l : support removed, please use
> >>> memory-
> >> region
> >>> -	property instead
> >>
> >> When did they become obsolete? Is it enough of time to remove them?
> >
> > these properties were there earlier, we didn't added them in obsolete
> properties.
>=20
> This is not the answer to my question. Is it enough of time to remove
> deprecated properties?
>=20
sorry I misunderstood. These two mfc-l and mfc-r are still used in mfcv5 ve=
rsion as they use MFC_NUM_PORTS as 2, so we cannot make them obsolete yet. =
In next patch series we will add allOf: if: else: conditions for all the pr=
operties of each compatible string.
Thanks for the review.
>=20
>=20
> Best regards,
> Krzysztof

