Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56F66BCCD6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjCPKcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjCPKcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:32:12 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7FE132DC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:32:07 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230316103204euoutp02e66e5e30aa4449bfaf31786be3a26db2~M37PGreHE1085910859euoutp027
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:32:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230316103204euoutp02e66e5e30aa4449bfaf31786be3a26db2~M37PGreHE1085910859euoutp027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678962724;
        bh=RMjrJyTwtzr03vsG7RrGU7iTtezv0HO8dRVEwqfEyzc=;
        h=Date:Subject:To:From:In-Reply-To:References:From;
        b=k00Oswv0DOrHXdWvUUzqt6H+EMzVeZVdgAc8QUJTHfuSpwC10cPnFT62VSRHwNZTZ
         PRLzgIFVrTNJjS6OUkGafLPnG91Z/ZFxInXePnJHNdQxobinHIVCzy0qI9xbnAMjWj
         rheE4y7JwIC6pQl6tCNr0tivALlGbyrjZgNBxYqk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230316103204eucas1p2d41d0c4cdcfc010e79523152b09ff783~M37O0TBFd3193731937eucas1p2C;
        Thu, 16 Mar 2023 10:32:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 98.D2.10014.320F2146; Thu, 16
        Mar 2023 10:32:03 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230316103203eucas1p2adc02a5104f496cf1cbb69040bb9bb9e~M37Oay6243234432344eucas1p2S;
        Thu, 16 Mar 2023 10:32:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230316103203eusmtrp29622781fdbd5274f4b9be33a3bb3ff1f~M37OZ9lfa3232132321eusmtrp2a;
        Thu, 16 Mar 2023 10:32:03 +0000 (GMT)
X-AuditID: cbfec7f5-ba1ff7000000271e-f4-6412f0230c31
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 86.BD.08862.320F2146; Thu, 16
        Mar 2023 10:32:03 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230316103202eusmtip11c0f6e6b0d611898e76192da6302a9a7~M37Nk1kkE1710117101eusmtip14;
        Thu, 16 Mar 2023 10:32:02 +0000 (GMT)
Message-ID: <b9d3a220-e7a1-73d0-56bf-af1291cd58ee@samsung.com>
Date:   Thu, 16 Mar 2023 11:32:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 1/2] ARM: dts: exynos: replace mshc0 alias with
 mmc-ddr-1_8v property
Content-Language: en-US
To:     Henrik Grimler <henrik@grimler.se>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alim.akhtar@samsung.com,
        jenneron@protonmail.com, markuss.broks@gmail.com,
        martin.juecker@gmail.com, virag.david003@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230315212644.15764-2-henrik@grimler.se>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCKsWRmVeSWpSXmKPExsWy7djPc7rKH4RSDM63WFo8mLeNzWL+kXOs
        Fm+X7GK02HHpAqtF34uHzBabHl9jtbi8aw6bxYzz+5gszh1Yx2xx5t9UFosFf+wsWvceYbc4
        /v4xo8Xm738ZHfg8ds66y+5x9Mo9Vo9NqzrZPO5c28PmsXlJvcf/O2vZPXraNjF59G1Zxejx
        eZNcAGcUl01Kak5mWWqRvl0CV0bv8p0sBV9UKxat/s3awHhCtouRk0NCwETibsMj5i5GLg4h
        gRWMEi+2f2eDcL4wSnx8v5YJwvnMKLF5x0RWmJajM3uhEssZJXZ9XMQC4XxklPjVtJARpIpX
        wE7i/5sNbCA2i4CqRNOjNhaIuKDEyZlPwGxRgRSJHed3s4PYwgJxEs2X28HqmQXEJW49mQ+2
        QURgPbPE09NPwIrYBAwlut52gRVxCphL/Nh6iAmiQV5i+9s5YF9ICMznlGi4vpcZ4lYXiXdr
        njBB2MISr45vYYewZST+74TYICHQziix4Pd9KGcCo0TD81uMEFXWEnfO/QJaxwG0QlNi/S59
        iLCjxNF5p8HCEgJ8EjfeCkIcwScxadt0Zogwr0RHmxBEtZrErOPr4NYevHAJqsRDYsbhlAmM
        irOQgmUWkvdnIflsFsIJCxhZVjGKp5YW56anFhvnpZbrFSfmFpfmpesl5+duYgQmvNP/jn/d
        wbji1Ue9Q4xMHIyHGCU4mJVEeMNZBFKEeFMSK6tSi/Lji0pzUosPMUpzsCiJ82rbnkwWEkhP
        LEnNTk0tSC2CyTJxcEo1MDV87v/81fK+c6Nxg0PntO69h1dPXSIyd1VW6BmruZIWzFuDEiq8
        5f8ERM8Nbm2+tvbppLwE35jNqxkPXFpyf+fmkhdfPv8Im7H4zyS2PbsvJ51+tr5zguKfXsu0
        q/nnBCbdNbiXt7/f8ETl7aONmx2Sf7RUb97fbTot4PKEZdn3uScnLdG6YMxy5NfidVc1FUTD
        f254xW5/eaJb4kXJtSUvo4WUPfnazNl8FG9HrQnQ1n7ssPur6+bF7y8cll2WZhDOe69q3y5d
        ObFUnt92VdPFix/y3xb6py4iH94UF/JcgPlN9US+g7MMxe+uXe3B7mJvJaWk9rwx7e6DS1P0
        DE/nplRvz1/baMTabCabuFSJpTgj0VCLuag4EQAU9GQh5wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsVy+t/xu7rKH4RSDB41SVk8mLeNzWL+kXOs
        Fm+X7GK02HHpAqtF34uHzBabHl9jtbi8aw6bxYzz+5gszh1Yx2xx5t9UFosFf+wsWvceYbc4
        /v4xo8Xm738ZHfg8ds66y+5x9Mo9Vo9NqzrZPO5c28PmsXlJvcf/O2vZPXraNjF59G1Zxejx
        eZNcAGeUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2C
        Xkbv8p0sBV9UKxat/s3awHhCtouRk0NCwETi6MxeJhBbSGApo8SFxYYQcRmJk9MaWCFsYYk/
        17rYuhi5gGreM0rsOX6EESTBK2An8f/NBjYQm0VAVaLpURsLRFxQ4uTMJ0A2B4eoQIrE7C4d
        kLCwQJxE8+V2sHJmAXGJW0/mM4HMFBFYzyyxanI3O8SC7YwS57qXgl3EJmAo0fW2C6yDU8Bc
        4sfWQ0wQ3WYSXVu7GCFseYntb+cwT2AUnIVk9ywkS2YhaZmFpGUBI8sqRpHU0uLc9NxiQ73i
        xNzi0rx0veT83E2MwDjeduzn5h2M81591DvEyMTBeIhRgoNZSYQ3nEUgRYg3JbGyKrUoP76o
        NCe1+BCjKTAAJjJLiSbnAxNJXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFM
        HxMHp1QDU6Mbj0PB4ugVkdOOcexhvV2UezJAa0n70iMrTTUmPw64mf6xxCeQaf6EGyk/jr1/
        UTK1uKz55wert7OMSlO2Rlm15eQ/uZPx7ceufY9yP7176rJFbkrNKf7N/GxBSTMblHXSrkic
        U+Z53dHzser/9TZL0x9nBMPvvi9f3blil3nhQROvGSGTc+/9qr9psDNP1iFw22aOS5JBnY6y
        7ZxKc1l5dtm+T2njk2W3uxgxr83ULMXlnK+U/5812yfK3ePzmrD37qGHB6Tsg2/V8D2aHD7b
        JfweT97a+vO2clacQsHJW0O9YzU5rrAc0RQROHCglJ09/K9qSyTjdgmbsx0yL8rNP7qIOF69
        t16tju2+EktxRqKhFnNRcSIAbL5+cWwDAAA=
X-CMS-MailID: 20230316103203eucas1p2adc02a5104f496cf1cbb69040bb9bb9e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230315212730eucas1p1bf80678add8f33024c3655e129157adb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230315212730eucas1p1bf80678add8f33024c3655e129157adb
References: <20230315212644.15764-1-henrik@grimler.se>
        <CGME20230315212730eucas1p1bf80678add8f33024c3655e129157adb@eucas1p1.samsung.com>
        <20230315212644.15764-2-henrik@grimler.se>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Henrik

On 15.03.2023 22:26, Henrik Grimler wrote:
> Previously, the mshc0 alias has been necessary so that
> MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA are set for mshc_0/mmc_0.
> However, these capabilities should be described in the device tree so
> that we do not have to rely on the alias.
>
> The property mmc-ddr-1_8v replaces MMC_CAP_1_8V_DDR, while bus_width =
> <8>, which is already set for all the mshc0/mmc0 nodes, replaces
> MMC_CAP_8_BIT_DATA.
>
> Also drop other mshc aliases as they are not needed.
>
> Signed-off-by: Henrik Grimler <henrik@grimler.se>
> ---
>
> Changes since v3:
> * Drop attempt at node sorting/cleaning
> * Move two mmc alias additions to the other patch
> * Update commit message
>
> Changes since v2:
> * Set mmc-ddr-1_8v in device trees for mshc_0/mmc_0
>
>   arch/arm/boot/dts/exynos3250-artik5.dtsi            | 1 +
>   arch/arm/boot/dts/exynos3250-monk.dts               | 1 +
>   arch/arm/boot/dts/exynos3250-rinato.dts             | 1 +
>   arch/arm/boot/dts/exynos4210-i9100.dts              | 1 +
>   arch/arm/boot/dts/exynos4210-origen.dts             | 1 +
>   arch/arm/boot/dts/exynos4210-trats.dts              | 1 +
>   arch/arm/boot/dts/exynos4210-universal_c210.dts     | 1 +
>   arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi     | 1 +
>   arch/arm/boot/dts/exynos4412-midas.dtsi             | 1 +
>   arch/arm/boot/dts/exynos4412-odroid-common.dtsi     | 1 +
>   arch/arm/boot/dts/exynos4412-origen.dts             | 1 +
>   arch/arm/boot/dts/exynos4412-p4note.dtsi            | 1 +
>   arch/arm/boot/dts/exynos4412.dtsi                   | 1 -
>   arch/arm/boot/dts/exynos5250-arndale.dts            | 1 +
>   arch/arm/boot/dts/exynos5250-smdk5250.dts           | 1 +
>   arch/arm/boot/dts/exynos5250-snow-common.dtsi       | 1 +
>   arch/arm/boot/dts/exynos5250-spring.dts             | 1 +
>   arch/arm/boot/dts/exynos5250.dtsi                   | 4 ----
>   arch/arm/boot/dts/exynos5260-xyref5260.dts          | 1 +
>   arch/arm/boot/dts/exynos5410-odroidxu.dts           | 1 +
>   arch/arm/boot/dts/exynos5410-smdk5410.dts           | 1 +
>   arch/arm/boot/dts/exynos5420-arndale-octa.dts       | 1 +
>   arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi | 1 +
>   arch/arm/boot/dts/exynos5420-peach-pit.dts          | 1 +
>   arch/arm/boot/dts/exynos5420-smdk5420.dts           | 1 +
>   arch/arm/boot/dts/exynos5420.dtsi                   | 3 ---
>   arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi  | 1 +
>   arch/arm/boot/dts/exynos5422-samsung-k3g.dts        | 1 +
>   arch/arm/boot/dts/exynos5800-peach-pi.dts           | 1 +
>   29 files changed, 26 insertions(+), 8 deletions(-)
>

> ...

> diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exynos4210-i9100.dts
> index bba85011ecc9..a370a5fa20d8 100644
> --- a/arch/arm/boot/dts/exynos4210-i9100.dts
> +++ b/arch/arm/boot/dts/exynos4210-i9100.dts
> @@ -776,6 +776,7 @@ &sdhci_0 {
>   	status = "okay";
>   
>   	bus-width = <8>;
> +	mmc-ddr-1_8v;
>   	non-removable;
>   	vmmc-supply = <&vemmc_reg>;
>   
> diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
> index 1103e7f92b57..d8dd13ce29e1 100644
> --- a/arch/arm/boot/dts/exynos4210-origen.dts
> +++ b/arch/arm/boot/dts/exynos4210-origen.dts
> @@ -326,6 +326,7 @@ max8997_irq: max8997-irq-pins {
>   
>   &sdhci_0 {
>   	bus-width = <4>;
> +	mmc-ddr-1_8v;
>   	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_cd>;
>   	pinctrl-names = "default";
>   	vmmc-supply = <&mmc_reg>;
> diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
> index b8e9dd23fc51..d757228a5676 100644
> --- a/arch/arm/boot/dts/exynos4210-trats.dts
> +++ b/arch/arm/boot/dts/exynos4210-trats.dts
> @@ -491,6 +491,7 @@ &rtc {
>   
>   &sdhci_0 {
>   	bus-width = <8>;
> +	mmc-ddr-1_8v;
>   	non-removable;
>   	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus8>;
>   	pinctrl-names = "default";
> diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> index 140abfb38e1d..57dbed908131 100644
> --- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> +++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> @@ -584,6 +584,7 @@ &rtc {
>   
>   &sdhci_0 {
>   	bus-width = <8>;
> +	mmc-ddr-1_8v;
>   	non-removable;
>   	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus8>;
>   	pinctrl-names = "default";

SDHCI is a different MMC controller than MSHC (DW-MMC), so please drop 
the above changes as they break SDHCI based MMC device operation (tested 
on Exynos4210 based Trats). With that fixed, feel free to add:

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

