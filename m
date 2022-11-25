Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE4C6393E0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 05:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiKZEoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 23:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiKZEoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 23:44:34 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BF72CE0C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 20:44:30 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221126044426epoutp01cc1460123c1594546a6a708363399f50~rCOUVbayj2167121671epoutp01S
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 04:44:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221126044426epoutp01cc1460123c1594546a6a708363399f50~rCOUVbayj2167121671epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669437866;
        bh=cFY/FZsuTQhXnVttxIEMfH5qGn4SH4SVIrTdkDMQhkU=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=rv0CiVyOo0K1S5RyfeNNFLaJmUsxhT46EUyaMkU4GuL6MGx2/ozHe/zdgmPLokyod
         n+TuD7n+qM2K0X0DBZFfF//CxJux+0Lk451QL3cswT6UG3YRt2nwQUjj+nqQZBMJIM
         X6CTaUtdvJLi4Q1F4LPf+X16ySYfKR92lXugotpU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221126044425epcas5p138ec32494ca686d269f7e0b5d48fad09~rCOTX3SGI2045020450epcas5p12;
        Sat, 26 Nov 2022 04:44:25 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4NJzfJ1MbMz4x9Pr; Sat, 26 Nov
        2022 04:44:24 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EA.B5.39477.7A991836; Sat, 26 Nov 2022 13:44:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221125142945epcas5p186bad6e82d3a326f59cbcde0dcf1fa13~q2kEeOH5e1174911749epcas5p1I;
        Fri, 25 Nov 2022 14:29:45 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221125142945epsmtrp2eca28d8690192fd4fa069f5866178cf5~q2kEctY5-2179321793epsmtrp2S;
        Fri, 25 Nov 2022 14:29:45 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-0f-638199a73a45
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.1E.14392.851D0836; Fri, 25 Nov 2022 23:29:44 +0900 (KST)
Received: from FDSFTE302 (unknown [107.122.81.78]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221125142943epsmtip28d5778b7b5a6ea236bb7d9637c12cd45~q2kCw3UJD0153301533epsmtip2t;
        Fri, 25 Nov 2022 14:29:43 +0000 (GMT)
From:   "Sriranjani P" <sriranjani.p@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Lee Jones'" <lee@kernel.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>
Cc:     "'Chanho Park'" <chanho61.park@samsung.com>,
        "'Sam Protsenko'" <semen.protsenko@linaro.org>
In-Reply-To: <20221125112201.240178-1-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 1/4] arm64: dts: exynos: add dedicated SYSREG
 compatibles to Exynos5433
Date:   Fri, 25 Nov 2022 19:59:41 +0530
Message-ID: <016c01d900da$5cde8de0$169ba9a0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKBUIa/6G27KlCizF9/rwWtdMt9HwIt87tfrO2jG9A=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLJsWRmVeSWpSXmKPExsWy7bCmpu6KmY3JBr9WM1s8mLeNzeLyfm2L
        +UfOsVr0vXjIbLH39VZ2ix1tC1ksNj2+xmpxedccNosZ5/cxWbTuPcJu8bxvH5MDt8emVZ1s
        Hneu7WHz2Lyk3qNvyypGj8+b5AJYo7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0t
        zJUU8hJzU22VXHwCdN0yc4AOU1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBTo
        FSfmFpfmpevlpZZYGRoYGJkCFSZkZ3y8WlQwUaRi9+X3jA2MlwW6GDk5JARMJLYc2cncxcjF
        ISSwm1Hi8InTTBDOJ0aJGWvOMYFUCQl8Y5ToOZAG03G64w07RNFeRomtnV+gnOeMEpfXLwLr
        YBPQl3i9Yj4bSEJE4D+TxN9fbSwgCWaBRInTZ06AFXEKuEr0rlnDCmILC8RKtEztZAexWQRU
        Jfb3HAKr4RWwlJjys5cZwhaUODnzCdQceYntb+cwQ5ykIPHz6TKwOSICVhIXvy5hhKgRlzj6
        swfsOQmBLRwS05res0M0uEjcbT3JCGELS7w6vgUqLiXx+d1eNgg7XWLzkc2sEHaOREdTM9Qy
        e4kDV+YAHcEBtEBTYv0ufYiwrMTUU+uYIPbySfT+fsIEEeeV2DEPxlaTWPyoE8qWkVj76BPr
        BEalWUhem4XktVlIXpiFsG0BI8sqRsnUguLc9NRi0wKjvNRyeIQn5+duYgSnWy2vHYwPH3zQ
        O8TIxMF4iFGCg1lJhDfheEOyEG9KYmVValF+fFFpTmrxIUZTYHhPZJYSTc4HJvy8knhDE0sD
        EzMzMxNLYzNDJXHexTO0koUE0hNLUrNTUwtSi2D6mDg4pRqYlnPLK81zNTDcevr/hU+b6hku
        xpy8I3S58s6Cs/aPPyjmbXnTN0FY/ZmM9uTJURcsDm58r7c/UefY/5K81pMl3Gv3dqxsdTpo
        YRJnLaDmfVbJY9aKs9tZ56jZ9707KZi1xsrzZ+qpwnanp6/DLlq1Glz5xT0z6+KBPL7+uTvm
        GF/X+3pVuZn5yFrfzPh9exbcNOML/qnYtjJ9dZbTj8xcXqWL75/uOvR2+aHbSxyUZa/e+CCa
        +WC5WUVkrG38/zP95z7adKvIX+XcVndypsHsQ/Eu65X5BLcX75pz615ZffHnNUwPb51c9XXW
        92kmcr5JWX27zxycrHTp8Sa/hdbx6WES1/6E6px7K3XBef68XRlKLMUZiYZazEXFiQAQWwCd
        QAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsWy7bCSvG7ExYZkg93zrSwezNvGZnF5v7bF
        /CPnWC36Xjxkttj7eiu7xY62hSwWmx5fY7W4vGsOm8WM8/uYLFr3HmG3eN63j8mB22PTqk42
        jzvX9rB5bF5S79G3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZH68WFUwUqdh9+T1jA+NlgS5G
        Tg4JAROJ0x1v2LsYuTiEBHYzSqye8ZIdIiEjcfLBEmYIW1hi5b/nUEVPGSU+vJzBBpJgE9CX
        eL1iPhtIQkSglVni0dNbLCAJZoFEiUcn30N1TGOU2Ln5FyNIglPAVaJ3zRrWLkYODmGBaIlz
        N4VAwiwCqhL7ew4xgdi8ApYSU372MkPYghInZz6BmqknsX79HEYIW15i+9s5UNcpSPx8uowV
        xBYRsJK4+HUJVI24xNGfPcwTGIVnIRk1C8moWUhGzULSsoCRZRWjZGpBcW56brFhgWFearle
        cWJucWleul5yfu4mRnDMaWnuYNy+6oPeIUYmDsZDjBIczEoivAnHG5KFeFMSK6tSi/Lji0pz
        UosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYArI7xNviY9TP8Gi2SgdnGn9y1Xj
        v+iaeTN7r70UX3noUNGP/cuMaww+mKq5vL2od2pJ+/tn55bP9X469+Li9U//haU36jXzz111
        3nVnyfF3cxvW6O1cdPm6kn1/i5/T8spTK++WTP6w7ptktptb5+vH92aecIr0uW5h8iNevvJo
        qvWCC00NOwyfr9slrPYzapLCRQHlic93sESF3pZNeLBndnLjn0/ZaRKHI0NY+X8kKKi15Kaf
        /DVbWnrW/ed3wt2rTthP3yM186zBjTPJASf9rYtDDRb7LzN8v33WxhLHT4+Ud3eHewUEbfbV
        nzKPUdNyz6dNS1M6AnYuOfxwvVTGpoeTtKPzFDo2C8T/5H6vxFKckWioxVxUnAgA3/qAHCgD
        AAA=
X-CMS-MailID: 20221125142945epcas5p186bad6e82d3a326f59cbcde0dcf1fa13
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221125112237epcas5p42180c4d081cce89e14ac0975a94cdbc4
References: <CGME20221125112237epcas5p42180c4d081cce89e14ac0975a94cdbc4@epcas5p4.samsung.com>
        <20221125112201.240178-1-krzysztof.kozlowski@linaro.org>
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
> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
> Sent: 25 November 2022 16:52
> To: Lee Jones <lee@kernel.org>; Rob Herring <robh+dt@kernel.org>;
Krzysztof
> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Alim Akhtar
> <alim.akhtar@samsung.com>; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
linux-samsung-
> soc@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>; Sriranjani P
> <sriranjani.p@samsung.com>; Chanho Park <chanho61.park@samsung.com>;
> Sam Protsenko <semen.protsenko@linaro.org>
> Subject: [PATCH 1/4] arm64: dts: exynos: add dedicated SYSREG compatibles
> to Exynos5433
> 
> Exynos5433 has several different SYSREGs, so use dedicated compatibles for
> them.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Sriranjani P <sriranjani.p@samsung.com>
> Cc: Chanho Park <chanho61.park@samsung.com>
> Cc: Sam Protsenko <semen.protsenko@linaro.org>
> ---

Reviewed-by: Sriranjani P <sriranjani.p@samsung.com>

>  arch/arm64/boot/dts/exynos/exynos5433.dtsi | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> index bd6a354b9cb5..6976e45aa769 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> @@ -1118,22 +1118,26 @@ hdmiphy: hdmiphy@13af0000 {
>  		};
> 
>  		syscon_disp: syscon@13b80000 {
> -			compatible = "samsung,exynos5433-sysreg", "syscon";
> +			compatible = "samsung,exynos5433-disp-sysreg",
> +				     "samsung,exynos5433-sysreg", "syscon";
>  			reg = <0x13b80000 0x1010>;
>  		};
> 
>  		syscon_cam0: syscon@120f0000 {
> -			compatible = "samsung,exynos5433-sysreg", "syscon";
> +			compatible = "samsung,exynos5433-cam0-sysreg",
> +				     "samsung,exynos5433-sysreg", "syscon";
>  			reg = <0x120f0000 0x1020>;
>  		};
> 
>  		syscon_cam1: syscon@145f0000 {
> -			compatible = "samsung,exynos5433-sysreg", "syscon";
> +			compatible = "samsung,exynos5433-cam1-sysreg",
> +				     "samsung,exynos5433-sysreg", "syscon";
>  			reg = <0x145f0000 0x1038>;
>  		};
> 
>  		syscon_fsys: syscon@156f0000 {
> -			compatible = "samsung,exynos5433-sysreg", "syscon";
> +			compatible = "samsung,exynos5433-fsys-sysreg",
> +				     "samsung,exynos5433-sysreg", "syscon";
>  			reg = <0x156f0000 0x1044>;
>  		};
> 
> --
> 2.34.1


