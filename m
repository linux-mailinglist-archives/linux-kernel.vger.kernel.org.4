Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FE9690C2D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjBIOu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBIOu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:50:56 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FF85EA10
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 06:50:53 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230209145051euoutp02a42a0b135aa63d2cbff09e0d662d12ee~CL4L-VUiR0091300913euoutp02s
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 14:50:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230209145051euoutp02a42a0b135aa63d2cbff09e0d662d12ee~CL4L-VUiR0091300913euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1675954251;
        bh=4wy9Cw1bn512k5fOb5uL2pyzOxxFDcumM6+sn3nnWSY=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=YHgjirZR8qWwd7z2hjhPNrJcVVFX2ybcdw40tc5RP9EBjPxh0UGhlO1rPV44zpRf9
         TMiy/A0gVPfeQ70Q0IZiwXQ+Kj4E+2YNF234BCKnrg/xC1HXP1rCN6gx3QhXBTQUJS
         Y0DbbZEz+2+M7a4qYFAokOpDbLucgj5KX68/C4tg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230209145050eucas1p1dba02abef1a13eb8beec124cba67bbe2~CL4LJ7Fdd1902519025eucas1p17;
        Thu,  9 Feb 2023 14:50:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 0F.DC.01471.94805E36; Thu,  9
        Feb 2023 14:50:50 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230209145049eucas1p2f496c5d0a483abb74e93677a596b8753~CL4KtqOXD1060410604eucas1p24;
        Thu,  9 Feb 2023 14:50:49 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230209145049eusmtrp2ff874d4550d69f8fd7467dc225d57f4f~CL4Ks33gn0541905419eusmtrp2X;
        Thu,  9 Feb 2023 14:50:49 +0000 (GMT)
X-AuditID: cbfec7f2-2b1ff700000105bf-57-63e50849a5c2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 60.3B.02722.94805E36; Thu,  9
        Feb 2023 14:50:49 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230209145048eusmtip17067e7ff7fe306d8ca2258b7e65697c8~CL4J70yZw1771017710eusmtip1d;
        Thu,  9 Feb 2023 14:50:48 +0000 (GMT)
Message-ID: <8fd04935-0553-e04b-7d8c-470573816e6f@samsung.com>
Date:   Thu, 9 Feb 2023 15:50:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/2] ARM: dts: exynos: add mmc aliases
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Henrik Grimler <henrik@grimler.se>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alim.akhtar@samsung.com,
        jenneron@protonmail.com, markuss.broks@gmail.com,
        martin.juecker@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Cc:     Valentine Iourine <iourine@iourine.msk.su>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <99a17d21-2cf9-a573-29cb-827568c9709b@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7djPc7peHE+TDeY7WTyYt43NYv6Rc6wW
        b5fsYrSY+ugYk8WOSxdYLfpePGS22Pt6K7vFpsfXWC0u75rDZjHj/D4mi3MH1jFbnPk3lcVi
        wR87i9a9R9gtNn//y+jA77Fz1l12j6NX7rF6LNz9j81j06pONo871/aweWxeUu/x/85ado+e
        tk1MHn1bVjF6fN4kF8AVxWWTkpqTWZZapG+XwJWxfMlV9oJWvYrmr7NZGhiXqHQxcnJICJhI
        HG24zN7FyMUhJLCCUWL/ukWMEM4XRon1M06yQjifGSVaT35ih2l5cWc7VMtyRomVW+8xQzgf
        GSWuL3/CAlLFK2AnsWjDHqYuRg4OFgEVibXT5SHCghInZ0KUiAqkSEzvnMkKYgsL2EpcnnmT
        CcRmFhCXuPVkPhPITBGB08wS/6ZeZ4dI6EnMeLsYzGYTMJToetvFBmJzAu1asGEOM0SNvMT2
        t3PADpIQ2M0p0b/vKgvE2S4S0/b/ZoKwhSVeHd8C9Y6MxP+dENskBNoZJRb8vg/lTGCUaHh+
        ixGiylrizrlfbCDvMAtoSqzfpQ8RdpT4cbiZFSQsIcAnceOtIMQRfBKTtk1nhgjzSnS0CUFU
        q0nMOr4Obu3BC5eYJzAqzUIKl1lI/p+F5J1ZCHsXMLKsYhRPLS3OTU8tNsxLLdcrTswtLs1L
        10vOz93ECEyBp/8d/7SDce6rj3qHGJk4GA8xSnAwK4nwfp/4OFmINyWxsiq1KD++qDQntfgQ
        ozQHi5I4r7btyWQhgfTEktTs1NSC1CKYLBMHp1QDU7H/wu9GYVtmB3Nf+DzT8e6yR1EuxkEf
        E7uCBBuq121Ksyp8efBSwS3Piq/sveEChy7N8Vq/S83Kb8JStf/Kr04uP9NXZyGmfP7dni03
        rfZu03E40l211Wtamcnv5edup3WfbxHIbqtbInR9i/nOg8f9zxmZhm3gLgpd9HCbcpG01CK+
        iXkaa9td7vDMsGfb+W7aBu1gjtdRFTUMhtlrDr1QDV4fo8fFnrBYsWj+3YV7J6fbtbyffqfp
        xeLVPlNeq3+er7pRtqlxT2NTdpInZ/Ech8iMlpey026tZzr+zz76+tl/osWJC2rEfx1es7Cp
        4ka1a1HXNRuJh8v+P5wsonK75km1r+e/9veqP+YahCixFGckGmoxFxUnAgBKY49r8AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsVy+t/xu7qeHE+TDd5eVrR4MG8bm8X8I+dY
        Ld4u2cVoMfXRMSaLHZcusFr0vXjIbLH39VZ2i02Pr7FaXN41h81ixvl9TBbnDqxjtjjzbyqL
        xYI/dhate4+wW2z+/pfRgd9j56y77B5Hr9xj9Vi4+x+bx6ZVnWwed67tYfPYvKTe4/+dtewe
        PW2bmDz6tqxi9Pi8SS6AK0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/O
        JiU1J7MstUjfLkEvY/mSq+wFrXoVzV9nszQwLlHpYuTkkBAwkXhxZzs7iC0ksJRRYtV/I4i4
        jMTJaQ2sELawxJ9rXWxdjFxANe8ZJV7vXsgEkuAVsJNYtGEPkM3BwSKgIrF2ujxEWFDi5Mwn
        LCC2qECKxK51x8HmCAvYSlyeeROslVlAXOLWk/lMIDNFBE4zS3zf+Z8ZIqEnMePtYnaIZa8Z
        JZ53PgDrYBMwlOh6C3IFJwcn0OIFG+ZANZhJdG3tYoSw5SW2v53DPIFRaBaSQ2YhWTgLScss
        JC0LGFlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBMb8tmM/N+9gnPfqo94hRiYOxkOMEhzM
        SiK83yc+ThbiTUmsrEotyo8vKs1JLT7EaAoMjInMUqLJ+cCkk1cSb2hmYGpoYmZpYGppZqwk
        zutZ0JEoJJCeWJKanZpakFoE08fEwSnVwMT5ntNPzcOCZ56t+qWy6+VJ+3/cyJcLD2HZ+Lr8
        tY351m5p35k+my4e/P7v7OwvUTJ7GDx/SdiKVf5gON/sqRnM5LCa/fnNwD3MD+RYP1brybzI
        XynOvVluz3GlKIv17TPrzDbpFd7nY3+zqSZ1+tmdc9Zt/hpZ+vfAfAdVN36uu1tMJnR+28TQ
        4dT1L6Z32veMNcIrynZGp9Z+LVjydkPJ6iqHb7uELl4KKtm8pnK6aY3KMtuomxZLHn466i8R
        1y5VLsVsH6Wy92PDrv6G3QYPF5cc+KT6JDVisnbm6/iNwjNdLh6z3+716tKhyQqzddiPvLoR
        IMSY1hbo/03pv/uRTT2/bnTpMPnK7ulj81RiKc5INNRiLipOBAAVDNggggMAAA==
X-CMS-MailID: 20230209145049eucas1p2f496c5d0a483abb74e93677a596b8753
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230209142330eucas1p2d7ba56b6496bb90ed6af2054fe929c9d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230209142330eucas1p2d7ba56b6496bb90ed6af2054fe929c9d
References: <20230128133151.29471-1-henrik@grimler.se>
        <20230128133151.29471-3-henrik@grimler.se>
        <CGME20230209142330eucas1p2d7ba56b6496bb90ed6af2054fe929c9d@eucas1p2.samsung.com>
        <99a17d21-2cf9-a573-29cb-827568c9709b@linaro.org>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.02.2023 15:23, Krzysztof Kozlowski wrote:
> On 28/01/2023 14:31, Henrik Grimler wrote:
>> Add aliases for eMMC, SD card and WiFi where applicable, so that
>> assigned mmcblk numbers are always the same.
>>
>> Co-developed-by: Anton Bambura <jenneron@protonmail.com>
>> Signed-off-by: Anton Bambura <jenneron@protonmail.com>
>> [ Tested on exynos5800-peach-pi ]
>> Tested-by: Valentine Iourine <iourine@iourine.msk.su>
>> Signed-off-by: Henrik Grimler <henrik@grimler.se>
>> ---
>>   arch/arm/boot/dts/exynos3250-artik5-eval.dts        | 5 +++++
>>   arch/arm/boot/dts/exynos3250-artik5.dtsi            | 5 +++++
>>   arch/arm/boot/dts/exynos3250-monk.dts               | 1 +
>>   arch/arm/boot/dts/exynos3250-rinato.dts             | 2 ++
>>   arch/arm/boot/dts/exynos4210-i9100.dts              | 6 ++++++
>>   arch/arm/boot/dts/exynos4210-origen.dts             | 5 +++++
>>   arch/arm/boot/dts/exynos4210-smdkv310.dts           | 4 ++++
>>   arch/arm/boot/dts/exynos4210-trats.dts              | 6 ++++++
>>   arch/arm/boot/dts/exynos4210-universal_c210.dts     | 6 ++++++
>>   arch/arm/boot/dts/exynos4412-itop-elite.dts         | 5 +++++
>>   arch/arm/boot/dts/exynos4412-midas.dtsi             | 3 +++
>>   arch/arm/boot/dts/exynos4412-odroid-common.dtsi     | 5 +++++
>>   arch/arm/boot/dts/exynos4412-origen.dts             | 5 +++++
>>   arch/arm/boot/dts/exynos4412-p4note.dtsi            | 6 ++++++
>>   arch/arm/boot/dts/exynos4412-smdk4412.dts           | 4 ++++
>>   arch/arm/boot/dts/exynos4412-tiny4412.dts           | 4 ++++
>>   arch/arm/boot/dts/exynos5250-arndale.dts            | 5 +++++
>>   arch/arm/boot/dts/exynos5250-smdk5250.dts           | 2 ++
>>   arch/arm/boot/dts/exynos5250-snow-common.dtsi       | 3 +++
>>   arch/arm/boot/dts/exynos5250-spring.dts             | 5 +++++
>>   arch/arm/boot/dts/exynos5260-xyref5260.dts          | 5 +++++
>>   arch/arm/boot/dts/exynos5410-odroidxu.dts           | 2 ++
>>   arch/arm/boot/dts/exynos5410-smdk5410.dts           | 5 +++++
>>   arch/arm/boot/dts/exynos5420-arndale-octa.dts       | 5 +++++
>>   arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi | 5 +++++
>>   arch/arm/boot/dts/exynos5420-peach-pit.dts          | 3 +++
>>   arch/arm/boot/dts/exynos5420-smdk5420.dts           | 5 +++++
>>   arch/arm/boot/dts/exynos5422-odroid-core.dtsi       | 5 +++++
>>   arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi  | 4 ++++
>>   arch/arm/boot/dts/exynos5422-samsung-k3g.dts        | 4 ++++
>>   arch/arm/boot/dts/exynos5800-peach-pi.dts           | 3 +++
>>   31 files changed, 133 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos3250-artik5-eval.dts b/arch/arm/boot/dts/exynos3250-artik5-eval.dts
>> index a1e22f630638..83266a66124b 100644
>> --- a/arch/arm/boot/dts/exynos3250-artik5-eval.dts
>> +++ b/arch/arm/boot/dts/exynos3250-artik5-eval.dts
>> @@ -16,6 +16,11 @@ / {
>>   	model = "Samsung ARTIK5 evaluation board";
>>   	compatible = "samsung,artik5-eval", "samsung,artik5",
>>   			"samsung,exynos3250", "samsung,exynos3";
>> +
>> +	aliases {
>> +		mmc2 = &mshc_2;
>> +	};
>> +
>>   };
>>   
>>   &mshc_2 {
>> diff --git a/arch/arm/boot/dts/exynos3250-artik5.dtsi b/arch/arm/boot/dts/exynos3250-artik5.dtsi
>> index 0ac3f284fbb8..a6e2f46917a8 100644
>> --- a/arch/arm/boot/dts/exynos3250-artik5.dtsi
>> +++ b/arch/arm/boot/dts/exynos3250-artik5.dtsi
>> @@ -17,6 +17,11 @@
>>   / {
>>   	compatible = "samsung,artik5", "samsung,exynos3250", "samsung,exynos3";
>>   
>> +	aliases {
>> +		mmc0 = &mshc_0;
>> +		mmc1 = &mshc_1;
>> +	};
>> +
>>   	chosen {
>>   		stdout-path = &serial_2;
>>   	};
>> diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/exynos3250-monk.dts
>> index 80d90fe7fad1..a68e5f81404c 100644
>> --- a/arch/arm/boot/dts/exynos3250-monk.dts
>> +++ b/arch/arm/boot/dts/exynos3250-monk.dts
>> @@ -22,6 +22,7 @@ / {
>>   
>>   	aliases {
>>   		i2c7 = &i2c_max77836;
>> +		mmc0 = &mshc_0;
>>   	};
>>   
>>   	memory@40000000 {
>> diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
>> index 1f9cba0607e1..f0fb6890e4a8 100644
>> --- a/arch/arm/boot/dts/exynos3250-rinato.dts
>> +++ b/arch/arm/boot/dts/exynos3250-rinato.dts
>> @@ -23,6 +23,8 @@ / {
>>   
>>   	aliases {
>>   		i2c7 = &i2c_max77836;
>> +		mmc0 = &mshc_0;
>> +		mmc1 = &mshc_1;
>>   	};
>>   
>>   	chosen {
>> diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exynos4210-i9100.dts
>> index bba85011ecc9..7051e2c4b391 100644
>> --- a/arch/arm/boot/dts/exynos4210-i9100.dts
>> +++ b/arch/arm/boot/dts/exynos4210-i9100.dts
>> @@ -25,6 +25,12 @@ memory@40000000 {
>>   		reg = <0x40000000 0x40000000>;
>>   	};
>>   
>> +	aliases {
>> +		mmc0 = &sdhci_0;
>> +		mmc2 = &sdhci_2;
>> +		mmc3 = &sdhci_3;
> 1. Is this actually correct? Since mmc1 was disabled, sdhci_2 had mmc1
> index but now will have mmc2.
>
> 2. I tested Odroid U3 and the ID changed. emmc went from 1 to 0. Any
> idea why? Both patches should be transparent.

Nope, eMMC and SD order changed a few times in the past and now they get 
indices based on the probe time, so any order is possible depending on 
the presence of the sd card / eMMC module.

> 3. Patchset does not look bisectable, so both patches should be squashed.

Why? First patch removes obsolete mshc aliases, which don't determine 
the logical MMC device number in the system. The second one adds fixed 
indices to the local MMC devices created by the respective MMC host 
controllers.

> 4. Your patch has several whitespace issues:
> patch:264: trailing whitespace.
>
> patch:279: trailing whitespace.
>
> patch:461: trailing whitespace.
>
>
>
> Best regards,
> Krzysztof
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

