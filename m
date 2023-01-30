Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7899680ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbjA3N17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236229AbjA3N1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:27:55 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C43C59CD
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:27:52 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230130132747euoutp01af243fc250bb842682afccd4c18be687~-GSzzZOTX2141521415euoutp01E
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:27:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230130132747euoutp01af243fc250bb842682afccd4c18be687~-GSzzZOTX2141521415euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1675085267;
        bh=PRNMdptOvhe9A/YXk7spA4E+ji1osNIwybIfgDUJoHw=;
        h=Date:Subject:To:From:In-Reply-To:References:From;
        b=cC0LeI3ct6ZyKadmF9TYowNA1F9ALt09zd4z7wO8I95NZs79Ga1UnponahO7ho9VE
         o6FH1zvBNZCNVK4e9turACsHTXV1RGQS9UoZ2ZK85RV8964bYy1Km+wdz/4340Zjj8
         aKMcfpxCbC5fyWwmR6QkFSeUrqYx2xJ3r5qc1Lvg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230130132746eucas1p240bc6829fbabfe22028249828256c5d2~-GSzZYHPb2538425384eucas1p2q;
        Mon, 30 Jan 2023 13:27:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 59.E2.01471.2D5C7D36; Mon, 30
        Jan 2023 13:27:46 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230130132746eucas1p2c33ed6937c045f29ee944a10c64c11cf~-GSy75V2s1436614366eucas1p26;
        Mon, 30 Jan 2023 13:27:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230130132746eusmtrp149c28ae0a22c93f3b6b5bc0d5153d198~-GSy6-Fr82447824478eusmtrp1t;
        Mon, 30 Jan 2023 13:27:46 +0000 (GMT)
X-AuditID: cbfec7f2-2b1ff700000105bf-7e-63d7c5d2d6d0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 95.4C.00518.2D5C7D36; Mon, 30
        Jan 2023 13:27:46 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230130132745eusmtip11d2470d97fe105089e51bfeddcee70b9~-GSyMPFFZ3037030370eusmtip1X;
        Mon, 30 Jan 2023 13:27:45 +0000 (GMT)
Message-ID: <ea699813-1aa6-710c-f1ca-be41a99f29aa@samsung.com>
Date:   Mon, 30 Jan 2023 14:27:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/2] ARM: dts: exynos: drop mshc aliases
Content-Language: en-US
To:     Henrik Grimler <henrik@grimler.se>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alim.akhtar@samsung.com,
        jenneron@protonmail.com, markuss.broks@gmail.com,
        martin.juecker@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230128133151.29471-2-henrik@grimler.se>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7djPc7qXjl5PNjj9VdviwbxtbBbzj5xj
        tXi7ZBejxY5LF1gt+l48ZLbY9Pgaq8XlXXPYLGac38dkce7AOmaLM/+mslgs+GNn0br3CLvF
        5u9/GR14PXbOusvucfTKPVaPTas62TzuXNvD5rF5Sb3H/ztr2T162jYxefRtWcXo8XmTXABn
        FJdNSmpOZllqkb5dAlfGq6VPWAu2CVWcf3KbrYHxAl8XIyeHhICJxPLv7UxdjFwcQgIrGCW2
        7rzHCuF8YZTYtWI9C4TzmVHiybm1TDAtl15/YAexhQSWM0rsvCoAUfSRUeLOzXeMIAleATuJ
        SyffgBWxCKhKLP71kA0iLihxcuYToKkcHKICKRKb/pSBhIUF7CWOHV0EVs4sIC5x68l8sJNE
        BCYzS2xdcYEZJMEmYCjR9bYLbA6ngLnEkYfrWCEa5CW2v53DDNIgITCbU2L78stsEJe6SEz4
        sZMZwhaWeHV8CzuELSNxenIPC0RDO6PEgt/3mSCcCYwSDc9vMUJUWUvcOfeLDeRUZgFNifW7
        9CHCjhLTT80G+0BCgE/ixltBiCP4JCZtm84MEeaV6GgTgqhWk5h1fB3c2oMXLkGd4yHRMuUr
        4wRGxVlIwTILyf+zkLw2C+GGBYwsqxjFU0uLc9NTiw3zUsv1ihNzi0vz0vWS83M3MQKT3Ol/
        xz/tYJz76qPeIUYmDsZDjBIczEoivPFm15KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ82rbnkwW
        EkhPLEnNTk0tSC2CyTJxcEo1MGVdfZcYcS5lc9TTzMINn9+3btkY3LKxUOy9kqYaU3HW3cIz
        +2dGcM3Qy+v1i0t/KpMgyFG49uJ9zX88zhsTbHhWXuKdWJH7j+foN62otw89L0nKPQtJ2eC9
        IWHxFnHpA3N6d4kKvHP109vad/Z906WCWa+FhN5Wa1fo58pGpMxTPqMqn57PEtpzqG9/kNb7
        JXsnGhXdtwnvZzq/PjnvQ63T72eHGz8+8HmtY1S1wYwvh9cgXGzLhsqZ0dvqT3EIrbq3clnx
        0xUX66/+uJq3Q3HCnd8/28JXztxj27H/PPuPJTvl+G7rub2af8KOZfMikemXjNZNqwk13ftt
        dsYKYxGv7JJbucHbJqVf6XmY4KnEUpyRaKjFXFScCABCQx7b4QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xu7qXjl5PNuhZwGXxYN42Nov5R86x
        WrxdsovRYselC6wWfS8eMltsenyN1eLyrjlsFjPO72OyOHdgHbPFmX9TWSwW/LGzaN17hN1i
        8/e/jA68Hjtn3WX3OHrlHqvHplWdbB53ru1h89i8pN7j/5217B49bZuYPPq2rGL0+LxJLoAz
        Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j1dIn
        rAXbhCrOP7nN1sB4ga+LkZNDQsBE4tLrD+xdjFwcQgJLGSXu7dnCCJGQkTg5rYEVwhaW+HOt
        iw2i6D2jxN5pz5lAErwCdhKXTr5hB7FZBFQlFv96yAYRF5Q4OfMJC4gtKpAi0fz8JNggYQF7
        iWNHF4HVMwuIS9x6Mp8JZKiIwGRmiZc7FjNDbNjOKLHp7DSwSWwChhJdb7vAbE4Bc4kjD9ex
        QnSbSXRt7WKEsOUltr+dwzyBUXAWkuWzkCyZhaRlFpKWBYwsqxhFUkuLc9Nzi430ihNzi0vz
        0vWS83M3MQIjeNuxn1t2MK589VHvECMTB+MhRgkOZiUR3niza8lCvCmJlVWpRfnxRaU5qcWH
        GE2BITCRWUo0OR+YQvJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODil
        GpgSyqJZutmb439JbRCQNs/kPrV9zn+ll5f+W1dtmNQXedhLmPdw4wO9nLXeu1l4fm1xn1Wz
        Tj2EcZHyiedc9UtDXqxTKPOaXXX57yvN6rplmlFfH06+zd/gZtClzDtXkk1obf/cgi69LRst
        MswX5Cu9vS32evPRkjs75mrMWe+svKr/Ee+inXGHxRt2abnb9P4qSmft8Dr3dtKWhtk7248v
        nvrZ1mhJc6texkbuU3/5Z/ty7ZBYYfjvXSSDoA/Xx4VulQtmHz3OqmWcPGf3yn9MM1/kP+SO
        DNp2OmHeRmGmhLcXpWdn1Xx+t+DsjF+v7KaeK5opFqB5cPuVbck37rQtZXddLVq4y3zR13mi
        uUmflFiKMxINtZiLihMB+WFUq2kDAAA=
X-CMS-MailID: 20230130132746eucas1p2c33ed6937c045f29ee944a10c64c11cf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230128133213eucas1p1c8ec5f908adaa8a43f18db4e49c188b8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230128133213eucas1p1c8ec5f908adaa8a43f18db4e49c188b8
References: <20230128133151.29471-1-henrik@grimler.se>
        <CGME20230128133213eucas1p1c8ec5f908adaa8a43f18db4e49c188b8@eucas1p1.samsung.com>
        <20230128133151.29471-2-henrik@grimler.se>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.01.2023 14:31, Henrik Grimler wrote:
> They are no longer needed after commit a13e8ef6008d ("mmc: dw_mmc:
> exynos: use common_caps").
>
> Signed-off-by: Henrik Grimler <henrik@grimler.se>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   arch/arm/boot/dts/exynos3250.dtsi | 3 ---
>   arch/arm/boot/dts/exynos4412.dtsi | 1 -
>   arch/arm/boot/dts/exynos5250.dtsi | 4 ----
>   arch/arm/boot/dts/exynos5420.dtsi | 3 ---
>   4 files changed, 11 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
> index 54bb323186e4..2d7771c1043b 100644
> --- a/arch/arm/boot/dts/exynos3250.dtsi
> +++ b/arch/arm/boot/dts/exynos3250.dtsi
> @@ -28,9 +28,6 @@ / {
>   	aliases {
>   		pinctrl0 = &pinctrl_0;
>   		pinctrl1 = &pinctrl_1;
> -		mshc0 = &mshc_0;
> -		mshc1 = &mshc_1;
> -		mshc2 = &mshc_2;
>   		spi0 = &spi_0;
>   		spi1 = &spi_1;
>   		i2c0 = &i2c_0;
> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
> index 7b4e2c442888..9e97b42638e9 100644
> --- a/arch/arm/boot/dts/exynos4412.dtsi
> +++ b/arch/arm/boot/dts/exynos4412.dtsi
> @@ -28,7 +28,6 @@ aliases {
>   		pinctrl3 = &pinctrl_3;
>   		fimc-lite0 = &fimc_lite_0;
>   		fimc-lite1 = &fimc_lite_1;
> -		mshc0 = &mshc_0;
>   	};
>   
>   	cpus {
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index 97e89859ba3d..6ea8a090f602 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -30,10 +30,6 @@ aliases {
>   		gsc1 = &gsc_1;
>   		gsc2 = &gsc_2;
>   		gsc3 = &gsc_3;
> -		mshc0 = &mmc_0;
> -		mshc1 = &mmc_1;
> -		mshc2 = &mmc_2;
> -		mshc3 = &mmc_3;
>   		i2c4 = &i2c_4;
>   		i2c5 = &i2c_5;
>   		i2c6 = &i2c_6;
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index b1051a7d07af..6862cbabc172 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -19,9 +19,6 @@ / {
>   	compatible = "samsung,exynos5420", "samsung,exynos5";
>   
>   	aliases {
> -		mshc0 = &mmc_0;
> -		mshc1 = &mmc_1;
> -		mshc2 = &mmc_2;
>   		pinctrl0 = &pinctrl_0;
>   		pinctrl1 = &pinctrl_1;
>   		pinctrl2 = &pinctrl_2;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

