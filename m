Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C163745428
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 05:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjGCDdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 23:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjGCDcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 23:32:52 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814541B2
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 20:32:49 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230703033244epoutp038f5bd763f874647e4ecb9fe40a074a3a~uPhOO3zoU1673316733epoutp03I
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 03:32:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230703033244epoutp038f5bd763f874647e4ecb9fe40a074a3a~uPhOO3zoU1673316733epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1688355164;
        bh=6j5u+YVs2DtO6p0WuHgRsABHtWsxAI5R5PcqRPli/Uo=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=H1ZqF7QmsDmOycF0/OV33qbBtrYAUeLM5GmVc4KXfYsPU+ZjJ5uGkVjM1R4sLBR4L
         TRW2MFTWVKvd6WgGECQm3PPbK3XSyBLO9wiUwMKAba9VIh9CUoJXrr/bETr+ZeaRUE
         Ke9PQuAszg8wCs0ajyCDC6cFvOW9qbVW4uAWWPVM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230703033243epcas5p2c7f2789eb8519c230f636396511dfa08~uPhNW7M4D0103101031epcas5p2p;
        Mon,  3 Jul 2023 03:32:43 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QvWhT64qkz4x9Px; Mon,  3 Jul
        2023 03:32:41 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.B7.57354.95142A46; Mon,  3 Jul 2023 12:32:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230703033241epcas5p3995a601470963c4188bf64f19fbaaa46~uPhLivcpg0527505275epcas5p39;
        Mon,  3 Jul 2023 03:32:41 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230703033241epsmtrp26f29626498322dfc40be6855e7b9c979~uPhLhxmBl1193111931epsmtrp2T;
        Mon,  3 Jul 2023 03:32:41 +0000 (GMT)
X-AuditID: b6c32a44-269fb7000001e00a-5f-64a241598a6f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.61.30535.95142A46; Mon,  3 Jul 2023 12:32:41 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230703033238epsmtip1fe27246c1b21f1768daec5c6b2bf00f1~uPhJTh2or2191721917epsmtip1P;
        Mon,  3 Jul 2023 03:32:38 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Conor Dooley'" <conor+dt@kernel.org>, <linux-fsd@tesla.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20230702185012.43699-1-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 1/4] arm64: dts: exynos: minor whitespace cleanup around
 '='
Date:   Mon, 3 Jul 2023 09:02:37 +0530
Message-ID: <014001d9ad5f$0567fe20$1037fa60$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKwhnx/v/8mWsPcW4tPl+zG+voOzgJK0TCEredaDBA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmhm6k46IUgytHDCzW7D3HZDH/yDlW
        i74XD5kt9r7eym6x6fE1VouHr8ItLu+aw2Yx4/w+JovWvUfYHTg9Nq3qZPO4c20Pm8fmJfUe
        /5rmsnt83iQXwBqVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+Ti
        E6DrlpkDdI6SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1
        xMrQwMDIFKgwITtjY9N5xoLlvBXHbj1iamD8xtXFyM4hIWAi8cami5GLQ0hgN6PElGd/mSGc
        T4wSd15tY4FwvjFKfJh9kKmLkROsYc/lr2wgtpDAXkaJ3zPlIYpeMkpc+NYLlmAT0JXYsbiN
        DSQhIvCZSeJk4012kASngItE54cTrF2MHBzCAkESjY9jQcIsAioSv/qfsYDYvAKWEv1rZjNB
        2IISJ2c+AYszC8hLbH87hxniCAWJn0+XsYLYIgJWEnt/vWSCqBGXeHn0CDvIXgmBmRwSB/+c
        grraReLfz4XsELawxKvjW6BsKYnP7/aygdwjIeAhseiPFEQ4Q+Lt8vWMELa9xIErc1hASpgF
        NCXW79KHWMUn0fv7CRNEJ69ER5sQRLWqRPO7qywQtrTExO5uVgjbQ2L/5Z2skGCbzijRslFv
        AqPCLCRPzkLy5Cwkz8xCWLyAkWUVo2RqQXFuemqyaYFhXmo5PLKT83M3MYJTqpbLDsYb8//p
        HWJk4mA8xCjBwawkwtv8cH6KEG9KYmVValF+fFFpTmrxIUZTYMhPZJYSTc4HJvW8knhDE0sD
        EzMzMxNLYzNDJXHe161zU4QE0hNLUrNTUwtSi2D6mDg4pRqYjJP95xk3qmt8mMs7d9b1dWzH
        fdxOL3343aCSreZ4x5bme6z6hytF+Rykd7Qq2810vPosKfRH5E6b6pyLy/ZzHrp+81NO7v7D
        8r/YLGf4Nz770tbXeLXfqlKc//rSPyeKtNVzu16rrAkPOxM0f+pKS+11jzdzvXwS9/28oPVD
        1qcT/J96ZbMdrdl/Wy8hP7ynutL/+rnwF9Vs4idlBeK3Mrpf/fxx9mSPPoNd026n+2xvW2oZ
        5OVyMH/qb2GWSrPbetU8lgXVFW/m3XN4+0UzI0njh9XCdWuOevzlMPRnKbujuIM1sffOtsqL
        U3OiDJaXrhOdeKIs6XOhUIXTjZC3KSfm3Pj64nPkbRVdw/j9SizFGYmGWsxFxYkA5Qb+IDIE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsWy7bCSnG6k46IUg0/NLBZr9p5jsph/5Byr
        Rd+Lh8wWe19vZbfY9Pgaq8XDV+EWl3fNYbOYcX4fk0Xr3iPsDpwem1Z1snncubaHzWPzknqP
        f01z2T0+b5ILYI3isklJzcksSy3St0vgytjYdJ6xYDlvxbFbj5gaGL9xdTFyckgImEjsufyV
        rYuRi0NIYDejxM+HJ5khEtIS1zdOYIewhSVW/nsOZgsJPGeUaH5SDGKzCehK7FjcBtYsIvCT
        SeJu53yoSVMZJW6s+s8EUsUp4CLR+eEEK4gtLBAg8fTRF7A4i4CKxK/+ZywgNq+ApUT/mtlM
        ELagxMmZT4DiHBzMAnoSbRsZQcLMAvIS29/OgTpOQeLn02VgI0UErCT2/nrJBFEjLvHy6BH2
        CYxCs5BMmoUwaRaSSbOQdCxgZFnFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcRVpa
        Oxj3rPqgd4iRiYPxEKMEB7OSCG/zw/kpQrwpiZVVqUX58UWlOanFhxilOViUxHm/ve5NERJI
        TyxJzU5NLUgtgskycXBKNTBdrJ2z8cfnHcXJhn3cNu+2Hjariqqty1Sfxn+93EpfoufzNEfT
        k6HXH9tO/J+7zMHqw91JJiKVN1c4ezwMWZRb9qFq+y7TGrOH7LWPn8VKbVi7Psp44yHnvEuH
        9TgmrxdMt0z7YnWAxeF6iOF+Ha3lMWwzvT4evfN/je4dceEpy8/N7826IhmV8Lkmar2kIotz
        q3WVwL7757ksFl3O27va5OHDOwctg5qvT3U2+591MUKckaO13emqVGHJqqSEsLJusesiBz6e
        vxTQui3ksOvq5W9O5lsWbJjtkRZW+erptY8bebxzCvIvrJRzmu9tcPvI+sMCeqEnrt0SczKR
        3mo+v5uhmF3We9bRLw94dbmVWIozEg21mIuKEwH4RhBVEQMAAA==
X-CMS-MailID: 20230703033241epcas5p3995a601470963c4188bf64f19fbaaa46
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230702185021epcas5p31e65022f806974a45125c9fb02c4150e
References: <CGME20230702185021epcas5p31e65022f806974a45125c9fb02c4150e@epcas5p3.samsung.com>
        <20230702185012.43699-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

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
> Subject: [PATCH 1/4] arm64: dts: exynos: minor whitespace cleanup around
> '='
> 
> The DTS code coding style expects exactly one space before and after '='
> sign.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Thanks!

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>  arch/arm64/boot/dts/exynos/exynos7.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi
> b/arch/arm64/boot/dts/exynos/exynos7.dtsi
> index 5ea8bda2bfa6..54ed5167d0f6 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
> @@ -138,10 +138,10 @@ gic: interrupt-controller@11001000 {
>  			#interrupt-cells = <3>;
>  			#address-cells = <0>;
>  			interrupt-controller;
> -			reg =	<0x11001000 0x1000>,
> -				<0x11002000 0x2000>,
> -				<0x11004000 0x2000>,
> -				<0x11006000 0x2000>;
> +			reg = <0x11001000 0x1000>,
> +			      <0x11002000 0x2000>,
> +			      <0x11004000 0x2000>,
> +			      <0x11006000 0x2000>;
>  		};
> 
>  		pdma0: dma-controller@10e10000 {
> --
> 2.34.1


