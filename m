Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C682A74542C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 05:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjGCDd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 23:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjGCDdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 23:33:54 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168781B2
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 20:33:53 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230703033351epoutp0344802027cfec66ff9de8a9e13ab36443~uPiNLvq8s1966719667epoutp03P
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 03:33:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230703033351epoutp0344802027cfec66ff9de8a9e13ab36443~uPiNLvq8s1966719667epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1688355231;
        bh=xG1B/XFqycWqNRStLpdthwsFK3uGUP9E3BzT60FmBSs=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=K6b8r7qgCv0b7eylgz/14MEcTUFaKt0mtURkxqtBjiKYC+p6y6ABR/3BXnYd37KW2
         aYhXsI/BMaVO/cDesMSidijAxHO6loJkbr38EpWPu2JzaWApCSoMTFZgDuKqQxZe7r
         6HDYYTbZMxCOadlpB/1jsRQP0mMITJ2lqsy1AvZs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230703033350epcas5p1d3d50edac0d5cb373fc843dcb488be30~uPiMImx_N2777427774epcas5p1I;
        Mon,  3 Jul 2023 03:33:50 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QvWjn1qkBz4x9Pt; Mon,  3 Jul
        2023 03:33:49 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.D8.44250.A9142A46; Mon,  3 Jul 2023 12:33:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230703033346epcas5p409b0a9b13226f11ba6f59de08156f4b3~uPiIRjzwR1501015010epcas5p4Y;
        Mon,  3 Jul 2023 03:33:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230703033346epsmtrp2c7ebfe8d4263447ffc8161ec128d8803~uPiIQxXV81249712497epsmtrp2L;
        Mon,  3 Jul 2023 03:33:46 +0000 (GMT)
X-AuditID: b6c32a4a-ec1fd7000000acda-75-64a2419a8038
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.53.34491.A9142A46; Mon,  3 Jul 2023 12:33:46 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230703033343epsmtip1d2937f39de4269900f199d33510828c2~uPiFq4ISP2187221872epsmtip1E;
        Mon,  3 Jul 2023 03:33:42 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Conor Dooley'" <conor+dt@kernel.org>, <linux-fsd@tesla.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20230702185012.43699-2-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 2/4] arm64: dts: fsd: minor whitespace cleanup around
 '='
Date:   Mon, 3 Jul 2023 09:03:38 +0530
Message-ID: <014d01d9ad5f$2c426f30$84c74d90$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJK0TCEOAUhA3bp3DdQU92USEW3oQIlO/22AvQGI7munFGnsA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmuu4sx0UpBjf/mFqs2XuOyWL+kXOs
        Fn0vHjJb7H29ld1i0+NrrBYPX4VbXN41h81ixvl9TBate4+wO3B6bFrVyeZx59oeNo/NS+o9
        /jXNZff4vEkugDUq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnF
        J0DXLTMH6BwlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5q
        iZWhgYGRKVBhQnbG5IPPWQs6eCvObvrK0sD4gquLkZNDQsBEovHAMdYuRi4OIYHdjBKvX2xi
        h3A+MUp83fCOEcL5xijR93sRG0zL+tXfmUFsIYG9jBJv/3JDFL1klFiybgM7SIJNQFdix+I2
        NpCEiMBnJomTjTfBEpwCLhLvX+1jArGFBfwlLs38xwhiswioSFyZcwAszitgKTHp5EMoW1Di
        5MwnLCA2s4C8xPa3c5ghrlCQ+Pl0GdDhHEALnCRuXAmHKBGXeHn0CNgLEgIzOSS+Np5gBqmR
        ANr76rAyRKuwxKvjW9ghbCmJz+/2skGUeEgs+iMFEc6QeLt8PSOEbS9x4MocFpASZgFNifW7
        9CE28Un0/n7CBNHJK9HRJgRRrSrR/O4qC4QtLTGxu5sVZviyr9mQgLrIKPH97ne2CYwKs5C8
        OAvJi7OQ/DILYfECRpZVjJKpBcW56anFpgVGeanl8NhOzs/dxAhOqlpeOxgfPvigd4iRiYPx
        EKMEB7OSCG/zw/kpQrwpiZVVqUX58UWlOanFhxhNgeE+kVlKNDkfmNbzSuINTSwNTMzMzEws
        jc0MlcR5X7fOTRESSE8sSc1OTS1ILYLpY+LglGpg8o5/cj326MuAli9zgvP+B2Zv3C+o9qT1
        tIiA3eUfZtsKDG+fOLTwQdGkN3lfGYRn+7sfLtS2kd/17bOvX+v5urgNIuqBfxYEBDxKjnNn
        11a6a3Piz7Wdj9rOV9xbkbn2caW1FXd2qMGMcMcXzfla59nnOj0UVkqbWFSybE/Qof6ZPi0H
        Tlrlbffy5T5laHyhTPLap6vnJ7Z7tn56P+ffyZT6g+kXvC582uS36uveC6YfdIRq/Mpc337L
        exMzXThxtsy6gIKQxSZz5i4R53mjFzj1Wc/FrYl//DZwH36zc8Z9LSXXLf+CU487Tbv8jSXF
        5vC1m2Es343c1bRDdgZX/S0+7FLOurNA9pDCRy9NSSWW4oxEQy3mouJEAI33tL0zBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSnO4sx0UpBrtX81us2XuOyWL+kXOs
        Fn0vHjJb7H29ld1i0+NrrBYPX4VbXN41h81ixvl9TBate4+wO3B6bFrVyeZx59oeNo/NS+o9
        /jXNZff4vEkugDWKyyYlNSezLLVI3y6BK2PyweesBR28FWc3fWVpYHzB1cXIySEhYCKxfvV3
        5i5GLg4hgd2MEnsnHGKBSEhLXN84gR3CFpZY+e85O0TRc0aJ/hsbGUESbAK6EjsWt7GBJEQE
        fjJJ3O2czwZRdZZRYuKsjWwgVZwCLhLvX+1j6mLk4BAW8JV49M0SJMwioCJxZc4BJhCbV8BS
        YtLJh1C2oMTJmU9YQMqZBfQk2iB2MQvIS2x/O4cZ4iAFiZ9Pl7GClIgIOEncuBIOUSIu8fLo
        EfYJjEKzkAyahTBoFpJBs5B0LGBkWcUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERxD
        Wpo7GLev+qB3iJGJg/EQowQHs5IIb/PD+SlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEecVf9KYI
        CaQnlqRmp6YWpBbBZJk4OKUamDbGSjQey6ncX2/38E3arMdX3j+a8P+p21+XptcmvxmzPD0/
        33twel/9d8Y9eYtm7b/02/X5/QdHZHWv/ZvkvGxldS+3xAKdMpUdZT+bFj3b5+3OXSFsE7fY
        anXW7RiFFSwntNvy13lbcgvoCt7NmBHGtehTs6TS9a8LDrTLM7REXj0i/sC/nbNF7EYXw23N
        C3a/m5JLGnc/2yKuvDiplvVN37S1LwN3uasozV/lkO5jfkQ09fUG7RvNgv+VH7tyss5Tjbuy
        4WJQ78OiSBOhx7pvLB59lrS9/lSIY7G20APPr0s/3OcMOJvbEuwUsD9QS3sa34FtesxC7V7F
        b3v/XPYKuKCTJVp353T/txsaVkosxRmJhlrMRcWJAO+lK7gQAwAA
X-CMS-MailID: 20230703033346epcas5p409b0a9b13226f11ba6f59de08156f4b3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230702185022epcas5p4e799239c075f4360eba760aef76865cd
References: <20230702185012.43699-1-krzysztof.kozlowski@linaro.org>
        <CGME20230702185022epcas5p4e799239c075f4360eba760aef76865cd@epcas5p4.samsung.com>
        <20230702185012.43699-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Monday, July 3, 2023 12:20 AM
> To: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; Alim Akhtar <alim.akhtar@samsung.com>; linux-
> fsd@tesla.com; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Subject: [PATCH 2/4] arm64: dts: fsd: minor whitespace cleanup around '='
> 
> The DTS code coding style expects exactly one space before and after '='
> sign.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Thanks!
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>  arch/arm64/boot/dts/tesla/fsd.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi
> b/arch/arm64/boot/dts/tesla/fsd.dtsi
> index 1c53c68efd53..bb50a9f7db4a 100644
> --- a/arch/arm64/boot/dts/tesla/fsd.dtsi
> +++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
> @@ -353,8 +353,8 @@ gic: interrupt-controller@10400000 {
>  			compatible = "arm,gic-v3";
>  			#interrupt-cells = <3>;
>  			interrupt-controller;
> -			reg =	<0x0 0x10400000 0x0 0x10000>, /* GICD */
> -				<0x0 0x10600000 0x0 0x200000>; /*
> GICR_RD+GICR_SGI */
> +			reg = <0x0 0x10400000 0x0 0x10000>, /* GICD */
> +			      <0x0 0x10600000 0x0 0x200000>; /*
> GICR_RD+GICR_SGI */
>  			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>  		};
> 
> --
> 2.34.1


