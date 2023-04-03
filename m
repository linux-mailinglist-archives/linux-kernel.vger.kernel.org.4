Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580486D4330
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 13:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjDCLQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 07:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjDCLQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 07:16:02 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00AF1B35B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 04:15:36 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230403111522euoutp01096907cf8aa4eb3a5c4d9f0874705d64~SaIL9PM220487404874euoutp01D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:15:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230403111522euoutp01096907cf8aa4eb3a5c4d9f0874705d64~SaIL9PM220487404874euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680520522;
        bh=mV1O9n9GK06OveRmvW06O5aatXhPi6hx66LPctF7HEM=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=oQuIyrNBO1Tp5YFc6m19nVaDniWQAX12v+lac6RvZb80F4K8MfouNuYQiD+EOtzJk
         huS+xvSA4XxhXxxGLZ2zCxOsA1j4AH9wzxAf7V2kEGcU5qJL0jD5yPR5L3hm7QLljX
         gAIhEJq1fxjdc4VYmXLNbUKVPHdRIc4A6ENuV/4o=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230403111522eucas1p12bdd884b1dcdb2045cea66bd75389702~SaILkDJte2061820618eucas1p1Y;
        Mon,  3 Apr 2023 11:15:22 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 5B.25.09966.A45BA246; Mon,  3
        Apr 2023 12:15:22 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230403111521eucas1p22da8911e85c82f4660dfb24bf873fc52~SaILEBd6q1381513815eucas1p26;
        Mon,  3 Apr 2023 11:15:21 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230403111521eusmtrp174344959d10a9289c381cb6c2b9de0f2~SaILDLfkZ0154001540eusmtrp1Q;
        Mon,  3 Apr 2023 11:15:21 +0000 (GMT)
X-AuditID: cbfec7f4-d39ff700000026ee-3c-642ab54a2fa4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E5.D0.08862.945BA246; Mon,  3
        Apr 2023 12:15:21 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230403111520eusmtip14b1250355467b0e5aa24c105db04e08f~SaIKLmay80928309283eusmtip1m;
        Mon,  3 Apr 2023 11:15:20 +0000 (GMT)
Message-ID: <74b5be33-d679-7938-15c5-4fb7b1d17692@samsung.com>
Date:   Mon, 3 Apr 2023 13:15:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH v7 2/2] ARM: dts: exynos: add mmc aliases
Content-Language: en-US
To:     Henrik Grimler <henrik@grimler.se>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alim.akhtar@samsung.com,
        jenneron@protonmail.com, markuss.broks@gmail.com,
        martin.juecker@gmail.com, virag.david003@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        replicant@osuosl.org
Cc:     Valentine Iourine <iourine@iourine.msk.su>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230402144724.17839-3-henrik@grimler.se>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7djPc7peW7VSDHrvcFo8mLeNzWL+kXOs
        Fm+X7GK0mProGJPFjksXWC36Xjxkttj0+BqrxeVdc9gsZpzfx2Rx7sA6Zosz/6ayWCz4Y2ex
        bo2gReveI+wWx98/ZrTY/P0vo4OAx85Zd9k9jl65x+qxcPc/No9NqzrZPO5c28PmsXlJvcf/
        O2vZPb40d7N69LRtYvLo27KK0ePzJrkA7igum5TUnMyy1CJ9uwSujCUdX9kLXk9jrJj2zayB
        8WxFFyMnh4SAicT2Tf2sXYwcHEICKxglTop2MXIBmV8YJZ5u+8IM4XxmlFj8fRMbTMPSvwdZ
        QGwhgeWMEle/OUMUfWSUWDX3FTvIJF4BO4lXRxxAalgEVCTuPe5kBLF5BQQlTs58AtYrKpAi
        sfvkU3YQW1jAVmL2sctgNcwC4hK3nsxnArFFBI4yS6yZlwcR15OY8XYxWD2bgKFE19susHs4
        Bcwlll6+zARRIy+x/e0cZog7L3FKLN+QCmG7SCxsmMsKYQtLvDq+hR3ClpE4PbmHBeR+CYF2
        RokFv+8zQTgTGCUant9ihKiylrhz7hcbyGPMApoS63fpQ4QdJW4/6AULSwjwSdx4KwhxA5/E
        pG3TmSHCvBIdbUIQ1WoSs46vg1t78MIl5gmMSrOQQmUWku9nIflmFsLeBYwsqxjFU0uLc9NT
        i43yUsv1ihNzi0vz0vWS83M3MQKT4el/x7/sYFz+6qPeIUYmDsZDjBIczEoivKpdWilCvCmJ
        lVWpRfnxRaU5qcWHGKU5WJTEebVtTyYLCaQnlqRmp6YWpBbBZJk4OKUamFisGI3ERRm/PTt7
        2exCgJ/0gv/VM5Ut7qqYTJCYGV277HBwsumU2DWP5S5cyvtgkCD6XbPA/fGj6Vev311dlioT
        fuvYDh5D3ulrug+2Rx8433Rc3pzhkFPKz9o8ActKr4c1Ty1Uji5Jms/sK3/3gfLTey0brnx8
        zXTK8rrjZimbJtE5/i8q1i78Nf/zLN0JMz69P9R7X8Br447Lt+XiTiYxGTmfbU/hbSp/vsfW
        9fzunNWCbLJFRqFHXy8xUH6yo91CRPi0yIkVPGyBPdaz3fqPh9gFFJiVee2cVB4vdnjh0YCu
        g6kBKv3aLe/mTu46bn5714l5IosvbrqidlbAuLBonvuTyA0uKR/quI4HKSqxFGckGmoxFxUn
        AgB+WOVo9QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsVy+t/xu7qeW7VSDCZM1LB4MG8bm8X8I+dY
        Ld4u2cVoMfXRMSaLHZcusFr0vXjIbLHp8TVWi8u75rBZzDi/j8ni3IF1zBZn/k1lsVjwx85i
        3RpBi9a9R9gtjr9/zGix+ftfRgcBj52z7rJ7HL1yj9Vj4e5/bB6bVnWyedy5tofNY/OSeo//
        d9aye3xp7mb16GnbxOTRt2UVo8fnTXIB3FF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqG
        xuaxVkamSvp2NimpOZllqUX6dgl6GUs6vrIXvJ7GWDHtm1kD49mKLkZODgkBE4mlfw+ydDFy
        cQgJLGWUaL3dxAyRkJE4Oa2BFcIWlvhzrYsNoug9o8TfWa1MXYwcHLwCdhKvjjiA1LAIqEjc
        e9zJCGLzCghKnJz5hAXEFhVIkdg1YSkTiC0sYCsx+9hlsBpmAXGJW0/mM4HMFBE4yiyx+eQt
        FoiEnsSMt4vZIZZtZ5S4/246WAebgKFE11uQKzg5OAXMJZZevswE0WAm0bW1C2qqvMT2t3OY
        JzAKzUJyyCwkC2chaZmFpGUBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwDSw7djPzTsY
        5736qHeIkYmD8RCjBAezkgivapdWihBvSmJlVWpRfnxRaU5q8SFGU2BoTGSWEk3OByaivJJ4
        QzMDU0MTM0sDU0szYyVxXs+CjkQhgfTEktTs1NSC1CKYPiYOTqkGpt4Gn9CGSz+uz31x823g
        P6WNwWslEwQS3bzmT9xTvrpi04NngbPndz8Q4xFc1T/deI3R+/VxNxb9WbukZNqb0zoLsiae
        XO6fJ/Fg48QPvDuZb1jmXRdOWBn/Wtxwg+nHfoW8d/rPTDZ6XmTRvNWRx6j2M/rm7DkVFiKP
        ta3LlxpnWQm+PXdHXOj7X2eTX/XLgpc/nBChF/fV9eecmg3rd3Usumank7U/9krK/4UCfVnK
        bTPkOhpjnhf5trFwzuW8GTDfIffwWR4jvmtVnjqTagIP3tNPmz9D+PasjZxmye7vXR+/m/3x
        nMij76f8Xhp2ddy+ln6k760wy4QrJRue79y04HiMgFOS0Lq9a1nE4iWVWIozEg21mIuKEwGz
        m4WbjAMAAA==
X-CMS-MailID: 20230403111521eucas1p22da8911e85c82f4660dfb24bf873fc52
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230402144744eucas1p2a884f604d7e307e23ed79212f76c2d98
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230402144744eucas1p2a884f604d7e307e23ed79212f76c2d98
References: <20230402144724.17839-1-henrik@grimler.se>
        <CGME20230402144744eucas1p2a884f604d7e307e23ed79212f76c2d98@eucas1p2.samsung.com>
        <20230402144724.17839-3-henrik@grimler.se>
X-Spam-Status: No, score=-6.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.04.2023 16:47, Henrik Grimler wrote:
> Add aliases for eMMC, SD card and WiFi where applicable, so that
> assigned mmc indeces are always the same.
>
> Co-developed-by: Anton Bambura <jenneron@protonmail.com>
> Signed-off-by: Anton Bambura <jenneron@protonmail.com>
> [ Tested on exynos5800-peach-pi ]
> Tested-by: Valentine Iourine <iourine@iourine.msk.su>
> Signed-off-by: Henrik Grimler <henrik@grimler.se>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>
> Changes since v6:
> * Fix syntax error in exynos5422-samsung-k3g.dts
>
> Changes since v5:
> * Make index numbering linear per default (that is, always use 0, 1, 2
>    instead of for example 0, 2, 3) for devices where no documentation
>    or schematics are available that use other numbering.
> * Drop Marek's test tag since numbering has been updated
> * Add mmc0 alias to exynos5422-samsung-k3g, was accidentally dropped in v5
>
> Changes since v4:
> * Do not set mmc-ddr-1_8v for sdhci_0 on Exynos 4210,
>    following Marek's tests
>
> Changes since v3:
> * Drop attempt at node sorting/cleaning
> * Move two mmc alias additions to the other patch
> * Update commit message
>
> Changes since v2:
> * Set mmc-ddr-1_8v in device trees for mshc_0/mmc_0
>
>   arch/arm/boot/dts/exynos3250-artik5-eval.dts        | 4 ++++
>   arch/arm/boot/dts/exynos3250-artik5.dtsi            | 5 +++++
>   arch/arm/boot/dts/exynos3250-monk.dts               | 1 +
>   arch/arm/boot/dts/exynos3250-rinato.dts             | 2 ++
>   arch/arm/boot/dts/exynos4210-i9100.dts              | 6 ++++++
>   arch/arm/boot/dts/exynos4210-origen.dts             | 5 +++++
>   arch/arm/boot/dts/exynos4210-smdkv310.dts           | 4 ++++
>   arch/arm/boot/dts/exynos4210-trats.dts              | 6 ++++++
>   arch/arm/boot/dts/exynos4210-universal_c210.dts     | 6 ++++++
>   arch/arm/boot/dts/exynos4412-itop-elite.dts         | 4 ++++
>   arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi     | 4 ++++
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
>   arch/arm/boot/dts/exynos5422-odroid-core.dtsi       | 4 ++++
>   arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi  | 4 ++++
>   arch/arm/boot/dts/exynos5422-samsung-k3g.dts        | 4 ++++
>   arch/arm/boot/dts/exynos5800-peach-pi.dts           | 3 +++
>   32 files changed, 134 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos3250-artik5-eval.dts b/arch/arm/boot/dts/exynos3250-artik5-eval.dts
> index a1e22f630638..660cc7fac4db 100644
> --- a/arch/arm/boot/dts/exynos3250-artik5-eval.dts
> +++ b/arch/arm/boot/dts/exynos3250-artik5-eval.dts
> @@ -16,6 +16,10 @@ / {
>   	model = "Samsung ARTIK5 evaluation board";
>   	compatible = "samsung,artik5-eval", "samsung,artik5",
>   			"samsung,exynos3250", "samsung,exynos3";
> +
> +	aliases {
> +		mmc0 = &mshc_2;
> +	};
>   };
>   
>   &mshc_2 {
> diff --git a/arch/arm/boot/dts/exynos3250-artik5.dtsi b/arch/arm/boot/dts/exynos3250-artik5.dtsi
> index b81e1a9df126..3fdd922e635c 100644
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
> index 861c26824d4f..2de877d4ccc5 100644
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
> index a252a5f667eb..88fb3e68ff02 100644
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
> index bba85011ecc9..37cd4dde53e4 100644
> --- a/arch/arm/boot/dts/exynos4210-i9100.dts
> +++ b/arch/arm/boot/dts/exynos4210-i9100.dts
> @@ -25,6 +25,12 @@ memory@40000000 {
>   		reg = <0x40000000 0x40000000>;
>   	};
>   
> +	aliases {
> +		mmc0 = &sdhci_0;
> +		mmc1 = &sdhci_2;
> +		mmc2 = &sdhci_3;
> +	};
> +
>   	chosen {
>   		stdout-path = "serial2:115200n8";
>   	};
> diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
> index 1103e7f92b57..f1927ca15e08 100644
> --- a/arch/arm/boot/dts/exynos4210-origen.dts
> +++ b/arch/arm/boot/dts/exynos4210-origen.dts
> @@ -30,6 +30,11 @@ memory@40000000 {
>   		       0x70000000 0x10000000>;
>   	};
>   
> +	aliases {
> +		mmc0 = &sdhci_0;
> +		mmc1 = &sdhci_2;
> +	};
> +
>   	chosen {
>   		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M init=/linuxrc";
>   		stdout-path = "serial2:115200n8";
> diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
> index 181c99eca675..b566f878ed84 100644
> --- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
> +++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
> @@ -25,6 +25,10 @@ memory@40000000 {
>   		reg = <0x40000000 0x80000000>;
>   	};
>   
> +	aliases {
> +		mmc0 = &sdhci_2;
> +	};
> +
>   	chosen {
>   		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M init=/linuxrc";
>   		stdout-path = "serial1:115200n8";
> diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
> index b8e9dd23fc51..ff6ee4b2c31b 100644
> --- a/arch/arm/boot/dts/exynos4210-trats.dts
> +++ b/arch/arm/boot/dts/exynos4210-trats.dts
> @@ -26,6 +26,12 @@ memory@40000000 {
>   			0x70000000 0x10000000>;
>   	};
>   
> +	aliases {
> +		mmc0 = &sdhci_0;
> +		mmc1 = &sdhci_2;
> +		mmc2 = &sdhci_3;
> +	};
> +
>   	chosen {
>   		bootargs = "root=/dev/mmcblk0p5 rootwait earlyprintk panic=5";
>   		stdout-path = "serial2:115200n8";
> diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> index 140abfb38e1d..8fe0d5d2be2d 100644
> --- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> +++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> @@ -24,6 +24,12 @@ memory@40000000 {
>   			0x50000000 0x10000000>;
>   	};
>   
> +	aliases {
> +		mmc0 = &sdhci_0;
> +		mmc1 = &sdhci_2;
> +		mmc2 = &sdhci_3;
> +	};
> +
>   	chosen {
>   		bootargs = "root=/dev/mmcblk0p5 rw rootwait earlyprintk panic=5 maxcpus=1";
>   		stdout-path = "serial2:115200n8";
> diff --git a/arch/arm/boot/dts/exynos4412-itop-elite.dts b/arch/arm/boot/dts/exynos4412-itop-elite.dts
> index 6260da187e92..ded232b04e0d 100644
> --- a/arch/arm/boot/dts/exynos4412-itop-elite.dts
> +++ b/arch/arm/boot/dts/exynos4412-itop-elite.dts
> @@ -20,6 +20,10 @@ / {
>   	model = "TOPEET iTop 4412 Elite board based on Exynos4412";
>   	compatible = "topeet,itop4412-elite", "samsung,exynos4412", "samsung,exynos4";
>   
> +	aliases {
> +		mmc1 = &sdhci_2;
> +	};
> +
>   	chosen {
>   		bootargs = "root=/dev/mmcblk0p2 rw rootfstype=ext4 rootdelay=1 rootwait";
>   		stdout-path = "serial2:115200n8";
> diff --git a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
> index ca8d42b2ce3b..7bc6968af9c3 100644
> --- a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
> @@ -23,6 +23,10 @@ memory@40000000 {
>   		reg = <0x40000000 0x40000000>;
>   	};
>   
> +	aliases {
> +		mmc0 = &mshc_0;
> +	};
> +
>   	firmware@203f000 {
>   		compatible = "samsung,secure-firmware";
>   		reg = <0x0203f000 0x1000>;
> diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
> index 82aed59cba7c..e6b949c1a00f 100644
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
> index 25e082fda955..45ef7b7ba7e0 100644
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
> index f6cebf73b839..23b151645d66 100644
> --- a/arch/arm/boot/dts/exynos4412-origen.dts
> +++ b/arch/arm/boot/dts/exynos4412-origen.dts
> @@ -25,6 +25,11 @@ memory@40000000 {
>   		reg = <0x40000000 0x40000000>;
>   	};
>   
> +	aliases {
> +		mmc0 = &mshc_0;
> +		mmc1 = &sdhci_2;
> +	};
> +
>   	chosen {
>   		stdout-path = "serial2:115200n8";
>   	};
> diff --git a/arch/arm/boot/dts/exynos4412-p4note.dtsi b/arch/arm/boot/dts/exynos4412-p4note.dtsi
> index 9052b3ebb3e8..0b89d5682f85 100644
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
> index a40ff394977c..715dfcba1417 100644
> --- a/arch/arm/boot/dts/exynos4412-smdk4412.dts
> +++ b/arch/arm/boot/dts/exynos4412-smdk4412.dts
> @@ -22,6 +22,10 @@ memory@40000000 {
>   		reg = <0x40000000 0x40000000>;
>   	};
>   
> +	aliases {
> +		mmc0 = &sdhci_2;
> +	};
> +
>   	chosen {
>   		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M init=/linuxrc";
>   		stdout-path = "serial1:115200n8";
> diff --git a/arch/arm/boot/dts/exynos4412-tiny4412.dts b/arch/arm/boot/dts/exynos4412-tiny4412.dts
> index e0b6162d2e2a..5a2dcdc5c28b 100644
> --- a/arch/arm/boot/dts/exynos4412-tiny4412.dts
> +++ b/arch/arm/boot/dts/exynos4412-tiny4412.dts
> @@ -17,6 +17,10 @@ / {
>   	model = "FriendlyARM TINY4412 board based on Exynos4412";
>   	compatible = "friendlyarm,tiny4412", "samsung,exynos4412", "samsung,exynos4";
>   
> +	aliases {
> +		mmc0 = &sdhci_2;
> +	};
> +
>   	chosen {
>   		stdout-path = &serial_0;
>   	};
> diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
> index 8f01337bb291..d586189966da 100644
> --- a/arch/arm/boot/dts/exynos5250-arndale.dts
> +++ b/arch/arm/boot/dts/exynos5250-arndale.dts
> @@ -23,6 +23,11 @@ memory@40000000 {
>   		reg = <0x40000000 0x80000000>;
>   	};
>   
> +	aliases {
> +		mmc0 = &mmc_0;
> +		mmc1 = &mmc_2;
> +	};
> +
>   	chosen {
>   		stdout-path = "serial2:115200n8";
>   	};
> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> index f7d4017e1ede..bb623726ef1e 100644
> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> @@ -17,6 +17,8 @@ / {
>   	compatible = "samsung,smdk5250", "samsung,exynos5250", "samsung,exynos5";
>   
>   	aliases {
> +		mmc0 = &mmc_0;
> +		mmc1 = &mmc_2;
>   	};
>   
>   	memory@40000000 {
> diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
> index dea2dc818578..59b2cc35c37b 100644
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
> index 8980cdbdcb3b..c12bb17631b7 100644
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
> index 0fd728bc0b75..d072a7398866 100644
> --- a/arch/arm/boot/dts/exynos5260-xyref5260.dts
> +++ b/arch/arm/boot/dts/exynos5260-xyref5260.dts
> @@ -18,6 +18,11 @@ memory@20000000 {
>   		reg = <0x20000000 0x80000000>;
>   	};
>   
> +	aliases {
> +		mmc0 = &mmc_0;
> +		mmc1 = &mmc_2;
> +	};
> +
>   	chosen {
>   		stdout-path = "serial2:115200n8";
>   	};
> diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
> index 1ed73f3b4ac0..882fc77c4bc4 100644
> --- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
> +++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
> @@ -21,6 +21,8 @@ / {
>   
>   	aliases {
>   		ethernet = &ethernet;
> +		mmc0 = &mmc_0;
> +		mmc1 = &mmc_2;
>   	};
>   
>   	memory@40000000 {
> diff --git a/arch/arm/boot/dts/exynos5410-smdk5410.dts b/arch/arm/boot/dts/exynos5410-smdk5410.dts
> index b4a74f9cf319..bb29b76f6f6a 100644
> --- a/arch/arm/boot/dts/exynos5410-smdk5410.dts
> +++ b/arch/arm/boot/dts/exynos5410-smdk5410.dts
> @@ -18,6 +18,11 @@ memory@40000000 {
>   		reg = <0x40000000 0x80000000>;
>   	};
>   
> +	aliases {
> +		mmc0 = &mmc_0;
> +		mmc1 = &mmc_2;
> +	};
> +
>   	chosen {
>   		stdout-path = "serial2:115200n8";
>   	};
> diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
> index 5ed55a5b0c67..809ddda02e53 100644
> --- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
> +++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
> @@ -23,6 +23,11 @@ memory@20000000 {
>   		reg = <0x20000000 0x80000000>;
>   	};
>   
> +	aliases {
> +		mmc0 = &mmc_0;
> +		mmc1 = &mmc_2;
> +	};
> +
>   	chosen {
>   		stdout-path = "serial3:115200n8";
>   	};
> diff --git a/arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi b/arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi
> index 6a51cb14b58a..f525b2f5e4e0 100644
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
> index df863b909ff7..7a48f2b32819 100644
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
> index 0a9371bec3e0..e299344e427a 100644
> --- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
> +++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> @@ -21,6 +21,11 @@ memory@20000000 {
>   		reg = <0x20000000 0x80000000>;
>   	};
>   
> +	aliases {
> +		mmc0 = &mmc_0;
> +		mmc1 = &mmc_2;
> +	};
> +
>   	chosen {
>   		bootargs = "init=/linuxrc";
>   		stdout-path = "serial2:115200n8";
> diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> index 30fc677d8bac..2f5b8602e020 100644
> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> @@ -19,6 +19,10 @@ memory@40000000 {
>   		reg = <0x40000000 0x7ea00000>;
>   	};
>   
> +	aliases {
> +		mmc2 = &mmc_2;
> +	};
> +
>   	chosen {
>   		stdout-path = "serial2:115200n8";
>   	};
> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> index d1b8e59e2daf..b4a851aa8881 100644
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
> index 13134592c199..c35261a338ff 100644
> --- a/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
> +++ b/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
> @@ -19,6 +19,10 @@ / {
>   
>   	chassis-type = "handset";
>   
> +	aliases {
> +		mmc0 = &mmc_0;
> +	};
> +
>   	memory@20000000 {
>   		device_type = "memory";
>   		reg = <0x20000000 0x80000000>; /* 2 GiB */
> diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> index 37af8fbd215c..1f544f12da6c 100644
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

