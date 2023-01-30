Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19800680ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjA3N2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjA3N2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:28:10 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB49034C3D
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:28:06 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230130132805euoutp01da1a41dc260d4ead94c3416bddac57a3~-GTErR9GD2141521415euoutp01P
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:28:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230130132805euoutp01da1a41dc260d4ead94c3416bddac57a3~-GTErR9GD2141521415euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1675085285;
        bh=RqQRs/QU7JnpcV+aGcASIwDZBDxV+VfqQqFrW0eUg6E=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=rX/+JYZztKoYRKOG0C8UKZzu2zYgxT6r4nYu3V9ktmOKBbp2J9K08GDDCxOKjm6jw
         0Ikux/VRwrkDJFRIKQYxAKdQYaystFi2wXRQy3SlB39txTIARkeesT6IcwuiZnygq0
         FHxQMXMrUhOOnDSEqYPZtBGWIC0M4yeWEjeTR/XY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230130132804eucas1p25c9335de720d548fe5309d973ffa10cb~-GTEOgFBG0836408364eucas1p2t;
        Mon, 30 Jan 2023 13:28:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id AE.F2.01471.4E5C7D36; Mon, 30
        Jan 2023 13:28:04 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230130132804eucas1p238de7009da3f4d53ff80ff2273c6d7f6~-GTDtC_z80836408364eucas1p2s;
        Mon, 30 Jan 2023 13:28:04 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230130132804eusmtrp204260b00a22acc8afc1aa9366276704b~-GTDsPsvh3270932709eusmtrp2A;
        Mon, 30 Jan 2023 13:28:04 +0000 (GMT)
X-AuditID: cbfec7f2-29bff700000105bf-c3-63d7c5e48297
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 82.5A.02722.4E5C7D36; Mon, 30
        Jan 2023 13:28:04 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230130132803eusmtip18d046482866b92e1a91be4951219eb36~-GTC_Ulxo3030030300eusmtip1A;
        Mon, 30 Jan 2023 13:28:03 +0000 (GMT)
Message-ID: <d7e0d375-f790-42c8-e615-67bbadd03e89@samsung.com>
Date:   Mon, 30 Jan 2023 14:28:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/2] ARM: dts: exynos: add mmc aliases
Content-Language: en-US
To:     Henrik Grimler <henrik@grimler.se>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alim.akhtar@samsung.com,
        jenneron@protonmail.com, markuss.broks@gmail.com,
        martin.juecker@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Cc:     Valentine Iourine <iourine@iourine.msk.su>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230128133151.29471-3-henrik@grimler.se>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7djP87pPjl5PNti8xsDiwbxtbBbzj5xj
        tXi7ZBejxdRHx5gsdly6wGrR9+Ihs8Wmx9dYLS7vmsNmMeP8PiaLcwfWMVuc+TeVxWLBHzuL
        1r1H2C02f//L6MDnsXPWXXaPo1fusXos3P2PzWPTqk42jzvX9rB5bF5S7/H/zlp2j562TUwe
        fVtWMXp83iQXwBXFZZOSmpNZllqkb5fAlbHizgmmgjM9jBXfmu4wNTBuKehi5OSQEDCReLnm
        MHsXIxeHkMAKRolFp1uZIZwvjBJn591mgnA+M0pcntPHBNPStn8LG0RiOaPExWunoPo/Mkoc
        3r2cDaSKV8BOYvm+rWAdLAKqEntXn2WHiAtKnJz5hKWLkYNDVCBFYtOfMpCwsICtxOWZN8HK
        mQXEJW49mQ+2WURgMrPE1hUXmCESehIz3i4Gm8MmYCjR9bYLbBengLnEv3lToGrkJba/nQP2
        g4TAek6JN08PskGc7SIxcc5lRghbWOLV8S3sELaMxP+dENskBNoZJRb8vg/lTGCUaHh+C6rD
        WuLOuV9sIGczC2hKrN+lDxF2lPhyci4zSFhCgE/ixltBiCP4JCZtmw4V5pXoaBOCqFaTmHV8
        HdzagxcuMU9gVJqFFCyzkPw/C8k7sxD2LmBkWcUonlpanJueWmyYl1quV5yYW1yal66XnJ+7
        iRGY/E7/O/5pB+PcVx/1DjEycTAeYpTgYFYS4Y03u5YsxJuSWFmVWpQfX1Sak1p8iFGag0VJ
        nFfb9mSykEB6YklqdmpqQWoRTJaJg1OqgUlNjN+kd044Q1JlkYC1km7T/saN4bzsn55NYa7X
        a86dMaU7eL9Rt0Bh0V7vC99uX5P5vtokWO11z/TUd/+3r+nd9eiKq4ieoc33jVc3pFWI1MVF
        a8XLGO/l/2rCZ3TyQbYk+0PZzX3zVPmfr//6/i/r6rk7T2U8criY8fXmhPUCt8tmVPxk/tr+
        W1uMzZbjBoen3JzTrzZsFX6VLsKr/THr+/IppZWcPYEq5Q8tpi5cc0LN+JEkB5uSZGfbGf/2
        tLCur78sFD1q6ooXRhmtjsl4K/f+7tel7R/CFosv/azrsnDlxpaP1w85neLLuK7HWW/IXLng
        2f4LF5oMO1Su6jCn714tW7yc5UPEktjTMUosxRmJhlrMRcWJAOwkWO3tAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsVy+t/xu7pPjl5PNtj9hd/iwbxtbBbzj5xj
        tXi7ZBejxdRHx5gsdly6wGrR9+Ihs8Wmx9dYLS7vmsNmMeP8PiaLcwfWMVuc+TeVxWLBHzuL
        1r1H2C02f//L6MDnsXPWXXaPo1fusXos3P2PzWPTqk42jzvX9rB5bF5S7/H/zlp2j562TUwe
        fVtWMXp83iQXwBWlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZ
        llqkb5egl7HizgmmgjM9jBXfmu4wNTBuKehi5OSQEDCRaNu/ha2LkYtDSGApo8TBZTdYIBIy
        EienNbBC2MISf651QRW9Z5SY2HoYLMErYCexfN9WJhCbRUBVYu/qs+wQcUGJkzOfgA0SFUiR
        aH5+EqxeWMBW4vLMm2D1zALiEreezGcCGSoiMJlZ4uWOxcwQCT2JGW8Xs0Ns2w607WI3WDeb
        gKFE11uQMzg5OAXMJf7NmwLVYCbRtbWLEcKWl9j+dg7zBEahWUgOmYVk4SwkLbOQtCxgZFnF
        KJJaWpybnltsqFecmFtcmpeul5yfu4kRGO/bjv3cvINx3quPeocYmTgYDzFKcDArifDGm11L
        FuJNSaysSi3Kjy8qzUktPsRoCgyNicxSosn5wISTVxJvaGZgamhiZmlgamlmrCTO61nQkSgk
        kJ5YkpqdmlqQWgTTx8TBKdXAxH7IU7VL/c2vhvYDFUc9jJJ3X3xV9PcLa9TKv2enOunzXsjM
        u3eXdfKuz9dzr1/bs0es97XzBxEGYfYJ1rfDNSd6BPa0L/FeZvvp+SeNySFzl3u6vv3071qg
        mGDV4d0OIeJKxursES/ZCzd83dM6IWh/6MVVxbb7mladPaRb89vovNXt6VLmwUtmpq8r/BT2
        yfD21NgGny3Z9+zcu7+oBvM/fdCWlObz2O7jjUM6jO9q0zx2NX3c/DrQWjKrc662cB6nw5ft
        8wtmlPN992rbsCfgVNf5mUmLlKc6eN9KMZ78/EWkoNHL1cf2Blx5V3hVv7Jiw7vkpj3Wd4J+
        lR9nK/BlkJhg1h4kYc26YvIEUyWW4oxEQy3mouJEAOrlDI+AAwAA
X-CMS-MailID: 20230130132804eucas1p238de7009da3f4d53ff80ff2273c6d7f6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230128133214eucas1p265db4e22108f3579300b2a3bdb428d1e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230128133214eucas1p265db4e22108f3579300b2a3bdb428d1e
References: <20230128133151.29471-1-henrik@grimler.se>
        <CGME20230128133214eucas1p265db4e22108f3579300b2a3bdb428d1e@eucas1p2.samsung.com>
        <20230128133151.29471-3-henrik@grimler.se>
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
> Add aliases for eMMC, SD card and WiFi where applicable, so that
> assigned mmcblk numbers are always the same.
>
> Co-developed-by: Anton Bambura <jenneron@protonmail.com>
> Signed-off-by: Anton Bambura <jenneron@protonmail.com>
> [ Tested on exynos5800-peach-pi ]
> Tested-by: Valentine Iourine <iourine@iourine.msk.su>
> Signed-off-by: Henrik Grimler <henrik@grimler.se>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   arch/arm/boot/dts/exynos3250-artik5-eval.dts        | 5 +++++
>   arch/arm/boot/dts/exynos3250-artik5.dtsi            | 5 +++++
>   arch/arm/boot/dts/exynos3250-monk.dts               | 1 +
>   arch/arm/boot/dts/exynos3250-rinato.dts             | 2 ++
>   arch/arm/boot/dts/exynos4210-i9100.dts              | 6 ++++++
>   arch/arm/boot/dts/exynos4210-origen.dts             | 5 +++++
>   arch/arm/boot/dts/exynos4210-smdkv310.dts           | 4 ++++
>   arch/arm/boot/dts/exynos4210-trats.dts              | 6 ++++++
>   arch/arm/boot/dts/exynos4210-universal_c210.dts     | 6 ++++++
>   arch/arm/boot/dts/exynos4412-itop-elite.dts         | 5 +++++
>   arch/arm/boot/dts/exynos4412-midas.dtsi             | 3 +++
>   arch/arm/boot/dts/exynos4412-odroid-common.dtsi     | 5 +++++
>   arch/arm/boot/dts/exynos4412-origen.dts             | 5 +++++
>   arch/arm/boot/dts/exynos4412-p4note.dtsi            | 6 ++++++
>   arch/arm/boot/dts/exynos4412-smdk4412.dts           | 4 ++++
>   arch/arm/boot/dts/exynos4412-tiny4412.dts           | 4 ++++
>   arch/arm/boot/dts/exynos5250-arndale.dts            | 5 +++++
>   arch/arm/boot/dts/exynos5250-smdk5250.dts           | 2 ++
>   arch/arm/boot/dts/exynos5250-snow-common.dtsi       | 3 +++
>   arch/arm/boot/dts/exynos5250-spring.dts             | 5 +++++
>   arch/arm/boot/dts/exynos5260-xyref5260.dts          | 5 +++++
>   arch/arm/boot/dts/exynos5410-odroidxu.dts           | 2 ++
>   arch/arm/boot/dts/exynos5410-smdk5410.dts           | 5 +++++
>   arch/arm/boot/dts/exynos5420-arndale-octa.dts       | 5 +++++
>   arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi | 5 +++++
>   arch/arm/boot/dts/exynos5420-peach-pit.dts          | 3 +++
>   arch/arm/boot/dts/exynos5420-smdk5420.dts           | 5 +++++
>   arch/arm/boot/dts/exynos5422-odroid-core.dtsi       | 5 +++++
>   arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi  | 4 ++++
>   arch/arm/boot/dts/exynos5422-samsung-k3g.dts        | 4 ++++
>   arch/arm/boot/dts/exynos5800-peach-pi.dts           | 3 +++
>   31 files changed, 133 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos3250-artik5-eval.dts b/arch/arm/boot/dts/exynos3250-artik5-eval.dts
> index a1e22f630638..83266a66124b 100644
> --- a/arch/arm/boot/dts/exynos3250-artik5-eval.dts
> +++ b/arch/arm/boot/dts/exynos3250-artik5-eval.dts
> @@ -16,6 +16,11 @@ / {
>   	model = "Samsung ARTIK5 evaluation board";
>   	compatible = "samsung,artik5-eval", "samsung,artik5",
>   			"samsung,exynos3250", "samsung,exynos3";
> +
> +	aliases {
> +		mmc2 = &mshc_2;
> +	};
> +
>   };
>   
>   &mshc_2 {
> diff --git a/arch/arm/boot/dts/exynos3250-artik5.dtsi b/arch/arm/boot/dts/exynos3250-artik5.dtsi
> index 0ac3f284fbb8..a6e2f46917a8 100644
> --- a/arch/arm/boot/dts/exynos3250-artik5.dtsi
> +++ b/arch/arm/boot/dts/exynos3250-artik5.dtsi
> @@ -17,6 +17,11 @@
>   / {
>   	compatible = "samsung,artik5", "samsung,exynos3250", "samsung,exynos3";
>   
> +	aliases {
> +		mmc0 = &mshc_0;
> +		mmc1 = &mshc_1;
> +	};
> +
>   	chosen {
>   		stdout-path = &serial_2;
>   	};
> diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/exynos3250-monk.dts
> index 80d90fe7fad1..a68e5f81404c 100644
> --- a/arch/arm/boot/dts/exynos3250-monk.dts
> +++ b/arch/arm/boot/dts/exynos3250-monk.dts
> @@ -22,6 +22,7 @@ / {
>   
>   	aliases {
>   		i2c7 = &i2c_max77836;
> +		mmc0 = &mshc_0;
>   	};
>   
>   	memory@40000000 {
> diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
> index 1f9cba0607e1..f0fb6890e4a8 100644
> --- a/arch/arm/boot/dts/exynos3250-rinato.dts
> +++ b/arch/arm/boot/dts/exynos3250-rinato.dts
> @@ -23,6 +23,8 @@ / {
>   
>   	aliases {
>   		i2c7 = &i2c_max77836;
> +		mmc0 = &mshc_0;
> +		mmc1 = &mshc_1;
>   	};
>   
>   	chosen {
> diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exynos4210-i9100.dts
> index bba85011ecc9..7051e2c4b391 100644
> --- a/arch/arm/boot/dts/exynos4210-i9100.dts
> +++ b/arch/arm/boot/dts/exynos4210-i9100.dts
> @@ -25,6 +25,12 @@ memory@40000000 {
>   		reg = <0x40000000 0x40000000>;
>   	};
>   
> +	aliases {
> +		mmc0 = &sdhci_0;
> +		mmc2 = &sdhci_2;
> +		mmc3 = &sdhci_3;
> +	};
> +
>   	chosen {
>   		stdout-path = "serial2:115200n8";
>   	};
> diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
> index 5f37b751f700..41c73ee0d556 100644
> --- a/arch/arm/boot/dts/exynos4210-origen.dts
> +++ b/arch/arm/boot/dts/exynos4210-origen.dts
> @@ -30,6 +30,11 @@ memory@40000000 {
>   		       0x70000000 0x10000000>;
>   	};
>   
> +	aliases {
> +		mmc0 = &sdhci_0;
> +		mmc2 = &sdhci_2;
> +	};
> +
>   	chosen {
>   		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M init=/linuxrc";
>   		stdout-path = "serial2:115200n8";
> diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
> index a5dfd7fd49b3..2b8141f2912e 100644
> --- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
> +++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
> @@ -25,6 +25,10 @@ memory@40000000 {
>   		reg = <0x40000000 0x80000000>;
>   	};
>   
> +	aliases {
> +		mmc2 = &sdhci_2;
> +	};
> +
>   	chosen {
>   		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M init=/linuxrc";
>   		stdout-path = "serial1:115200n8";
> diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
> index b8e9dd23fc51..b6b0c116016c 100644
> --- a/arch/arm/boot/dts/exynos4210-trats.dts
> +++ b/arch/arm/boot/dts/exynos4210-trats.dts
> @@ -26,6 +26,12 @@ memory@40000000 {
>   			0x70000000 0x10000000>;
>   	};
>   
> +	aliases {
> +		mmc0 = &sdhci_0;
> +		mmc2 = &sdhci_2;
> +		mmc3 = &sdhci_3;
> +	};
> +
>   	chosen {
>   		bootargs = "root=/dev/mmcblk0p5 rootwait earlyprintk panic=5";
>   		stdout-path = "serial2:115200n8";
> diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> index 62bf335d5bed..2135a6843511 100644
> --- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> +++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> @@ -24,6 +24,12 @@ memory@40000000 {
>   			0x50000000 0x10000000>;
>   	};
>   
> +	aliases {
> +		mmc0 = &sdhci_0;
> +		mmc2 = &sdhci_2;
> +		mmc3 = &sdhci_3;
> +	};
> +
>   	chosen {
>   		bootargs = "root=/dev/mmcblk0p5 rw rootwait earlyprintk panic=5 maxcpus=1";
>   		stdout-path = "serial2:115200n8";
> diff --git a/arch/arm/boot/dts/exynos4412-itop-elite.dts b/arch/arm/boot/dts/exynos4412-itop-elite.dts
> index b596e997e451..c0132e537663 100644
> --- a/arch/arm/boot/dts/exynos4412-itop-elite.dts
> +++ b/arch/arm/boot/dts/exynos4412-itop-elite.dts
> @@ -20,6 +20,11 @@ / {
>   	model = "TOPEET iTop 4412 Elite board based on Exynos4412";
>   	compatible = "topeet,itop4412-elite", "samsung,exynos4412", "samsung,exynos4";
>   
> +	aliases {
> +		mmc0 = &mshc_0;
> +		mmc2 = &sdhci_2;
> +	};
> +
>   	chosen {
>   		bootargs = "root=/dev/mmcblk0p2 rw rootfstype=ext4 rootdelay=1 rootwait";
>   		stdout-path = "serial2:115200n8";
> diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
> index d5074fa57142..56382bb07939 100644
> --- a/arch/arm/boot/dts/exynos4412-midas.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
> @@ -25,6 +25,9 @@ / {
>   	aliases {
>   		i2c11 = &i2c_max77693;
>   		i2c12 = &i2c_max77693_fuel;
> +		mmc0 = &mshc_0;
> +		mmc2 = &sdhci_2;
> +		mmc3 = &sdhci_3;
>   	};
>   
>   	chosen {
> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> index 7c2780d3e37c..4bfbe960be43 100644
> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> @@ -13,6 +13,11 @@
>   #include "exynos-mfc-reserved-memory.dtsi"
>   
>   / {
> +	aliases {
> +		mmc0 = &mshc_0;
> +		mmc2 = &sdhci_2;
> +	};
> +
>   	chosen {
>   		stdout-path = &serial_1;
>   	};
> diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
> index ea9fd284386d..2e25415aa2d4 100644
> --- a/arch/arm/boot/dts/exynos4412-origen.dts
> +++ b/arch/arm/boot/dts/exynos4412-origen.dts
> @@ -25,6 +25,11 @@ memory@40000000 {
>   		reg = <0x40000000 0x40000000>;
>   	};
>   
> +	aliases {
> +		mmc0 = &mshc_0;
> +		mmc2 = &sdhci_2;
> +	};
> +
>   	chosen {
>   		stdout-path = "serial2:115200n8";
>   	};
> diff --git a/arch/arm/boot/dts/exynos4412-p4note.dtsi b/arch/arm/boot/dts/exynos4412-p4note.dtsi
> index 3e05a49f29ff..a21440062b1e 100644
> --- a/arch/arm/boot/dts/exynos4412-p4note.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-p4note.dtsi
> @@ -26,6 +26,12 @@ memory@40000000 {
>   		reg = <0x40000000 0x80000000>;
>   	};
>   
> +	aliases {
> +		mmc0 = &mshc_0;
> +		mmc2 = &sdhci_2;
> +		mmc3 = &sdhci_3;
> +	};
> +
>   	chosen {
>   		stdout-path = &serial_2;
>   	};
> diff --git a/arch/arm/boot/dts/exynos4412-smdk4412.dts b/arch/arm/boot/dts/exynos4412-smdk4412.dts
> index a40ff394977c..6296a5a06630 100644
> --- a/arch/arm/boot/dts/exynos4412-smdk4412.dts
> +++ b/arch/arm/boot/dts/exynos4412-smdk4412.dts
> @@ -22,6 +22,10 @@ memory@40000000 {
>   		reg = <0x40000000 0x40000000>;
>   	};
>   
> +	aliases {
> +		mmc2 = &sdhci_2;
> +	};
> +
>   	chosen {
>   		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M init=/linuxrc";
>   		stdout-path = "serial1:115200n8";
> diff --git a/arch/arm/boot/dts/exynos4412-tiny4412.dts b/arch/arm/boot/dts/exynos4412-tiny4412.dts
> index e0b6162d2e2a..e010b75a9d49 100644
> --- a/arch/arm/boot/dts/exynos4412-tiny4412.dts
> +++ b/arch/arm/boot/dts/exynos4412-tiny4412.dts
> @@ -17,6 +17,10 @@ / {
>   	model = "FriendlyARM TINY4412 board based on Exynos4412";
>   	compatible = "friendlyarm,tiny4412", "samsung,exynos4412", "samsung,exynos4";
>   
> +	aliases {
> +		mmc2 = &sdhci_2;
> +	};
> +
>   	chosen {
>   		stdout-path = &serial_0;
>   	};
> diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
> index 71c0e87d3a1d..3ef04e59939e 100644
> --- a/arch/arm/boot/dts/exynos5250-arndale.dts
> +++ b/arch/arm/boot/dts/exynos5250-arndale.dts
> @@ -23,6 +23,11 @@ memory@40000000 {
>   		reg = <0x40000000 0x80000000>;
>   	};
>   
> +	aliases {
> +		mmc0 = &mmc_0;
> +		mmc2 = &mmc_2;
> +	};
> +
>   	chosen {
>   		stdout-path = "serial2:115200n8";
>   	};
> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> index 71293749ac48..e8087d7d6305 100644
> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> @@ -17,6 +17,8 @@ / {
>   	compatible = "samsung,smdk5250", "samsung,exynos5250", "samsung,exynos5";
>   
>   	aliases {
> +		mmc0 = &mmc_0;
> +		mmc2 = &mmc_2;
>   	};
>   
>   	memory@40000000 {
> diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
> index 3d84b9c6dea3..cdf1ebff11db 100644
> --- a/arch/arm/boot/dts/exynos5250-snow-common.dtsi
> +++ b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
> @@ -15,6 +15,9 @@
>   / {
>   	aliases {
>   		i2c104 = &i2c_104;
> +		mmc0 = &mmc_0; /* eMMC */
> +		mmc1 = &mmc_2; /* SD */
> +		mmc2 = &mmc_3; /* WiFi */
>   	};
>   
>   	memory@40000000 {
> diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/exynos5250-spring.dts
> index 5eca10ecd550..96050fea93f8 100644
> --- a/arch/arm/boot/dts/exynos5250-spring.dts
> +++ b/arch/arm/boot/dts/exynos5250-spring.dts
> @@ -23,6 +23,11 @@ memory@40000000 {
>   		reg = <0x40000000 0x80000000>;
>   	};
>   
> +	aliases {
> +		mmc0 = &mmc_0;
> +		mmc1 = &mmc_1;
> +	};
> +
>   	chosen {
>   		bootargs = "console=tty1";
>   		stdout-path = "serial3:115200n8";
> diff --git a/arch/arm/boot/dts/exynos5260-xyref5260.dts b/arch/arm/boot/dts/exynos5260-xyref5260.dts
> index 387b8494f18f..1e2f6af6d311 100644
> --- a/arch/arm/boot/dts/exynos5260-xyref5260.dts
> +++ b/arch/arm/boot/dts/exynos5260-xyref5260.dts
> @@ -18,6 +18,11 @@ memory@20000000 {
>   		reg = <0x20000000 0x80000000>;
>   	};
>   
> +	aliases {
> +		mmc0 = &mmc_0;
> +		mmc2 = &mmc_2;
> +	};
> +
>   	chosen {
>   		stdout-path = "serial2:115200n8";
>   	};
> diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
> index 232561620da2..f495514d88b3 100644
> --- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
> +++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
> @@ -21,6 +21,8 @@ / {
>   
>   	aliases {
>   		ethernet = &ethernet;
> +		mmc0 = &mmc_0;
> +		mmc2 = &mmc_2;
>   	};
>   
>   	memory@40000000 {
> diff --git a/arch/arm/boot/dts/exynos5410-smdk5410.dts b/arch/arm/boot/dts/exynos5410-smdk5410.dts
> index b8f953c41c73..1d3d220f3fcc 100644
> --- a/arch/arm/boot/dts/exynos5410-smdk5410.dts
> +++ b/arch/arm/boot/dts/exynos5410-smdk5410.dts
> @@ -18,6 +18,11 @@ memory@40000000 {
>   		reg = <0x40000000 0x80000000>;
>   	};
>   
> +	aliases {
> +		mmc0 = &mmc_0;
> +		mmc2 = &mmc_2;
> +	};
> +
>   	chosen {
>   		stdout-path = "serial2:115200n8";
>   	};
> diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
> index 55b7759682a9..54398db244ad 100644
> --- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
> +++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
> @@ -23,6 +23,11 @@ memory@20000000 {
>   		reg = <0x20000000 0x80000000>;
>   	};
>   
> +	aliases {
> +		mmc0 = &mmc_0;
> +		mmc2 = &mmc_2;
> +	};
> +
>   	chosen {
>   		stdout-path = "serial3:115200n8";
>   	};
> diff --git a/arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi b/arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi
> index 63675fe189cd..18874125ac64 100644
> --- a/arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi
> +++ b/arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi
> @@ -28,6 +28,11 @@ / {
>   	 * for more details.
>   	 */
>   
> +	aliases {
> +		mmc0 = &mmc_0;
> +		mmc2 = &mmc_2;
> +	};
> +
>   	chosen {
>   		stdout-path = "serial2:115200n8";
>   	};
> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> index 9e2123470cad..8b2bbeb7f64f 100644
> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> @@ -31,6 +31,9 @@ / {
>   	aliases {
>   		/* Assign 20 so we don't get confused w/ builtin ones */
>   		i2c20 = &i2c_tunnel;
> +		mmc0 = &mmc_0; /* eMMC */
> +		mmc1 = &mmc_2; /* uSD */
> +		mmc2 = &mmc_1; /* WiFi */
>   	};
>   
>   	backlight: backlight {
> diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> index 4d7b6d9008a7..134ed8931ba7 100644
> --- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
> +++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> @@ -21,6 +21,11 @@ memory@20000000 {
>   		reg = <0x20000000 0x80000000>;
>   	};
>   
> +	aliases {
> +		mmc0 = &mmc_0;
> +		mmc2 = &mmc_2;
> +	};
> +
>   	chosen {
>   		bootargs = "init=/linuxrc";
>   		stdout-path = "serial2:115200n8";
> diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> index 30fc677d8bac..9f2ec636436e 100644
> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> @@ -19,6 +19,11 @@ memory@40000000 {
>   		reg = <0x40000000 0x7ea00000>;
>   	};
>   
> +	aliases {
> +		mmc2 = &mmc_2;
> +	};
> +
> +
>   	chosen {
>   		stdout-path = "serial2:115200n8";
>   	};
> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> index a6961ff24030..55fd2b94be3f 100644
> --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> @@ -13,6 +13,10 @@
>   #include "exynos5422-odroid-core.dtsi"
>   
>   / {
> +	aliases {
> +		mmc0 = &mmc_0;
> +	};
> +
>   	gpio-keys {
>   		compatible = "gpio-keys";
>   		pinctrl-names = "default";
> diff --git a/arch/arm/boot/dts/exynos5422-samsung-k3g.dts b/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
> index df41723d56d4..4a0c8f29ccbc 100644
> --- a/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
> +++ b/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
> @@ -24,6 +24,10 @@ memory@20000000 {
>   		reg = <0x20000000 0x80000000>; /* 2 GiB */
>   	};
>   
> +	aliases {
> +		mmc0 = &mmc_0;
> +	};
> +
>   	fixed-rate-clocks {
>   		oscclk {
>   			compatible = "samsung,exynos5420-oscclk";
> diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> index 0ebcb66c6319..50e9e884c51f 100644
> --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
> +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> @@ -29,6 +29,9 @@ / {
>   	aliases {
>   		/* Assign 20 so we don't get confused w/ builtin ones */
>   		i2c20 = &i2c_tunnel;
> +		mmc0 = &mmc_0; /* eMMC */
> +		mmc1 = &mmc_2; /* SD */
> +		mmc2 = &mmc_1; /* WiFi */
>   	};
>   
>   	backlight: backlight {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

