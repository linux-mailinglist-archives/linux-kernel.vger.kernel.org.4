Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE83967F0D4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjA0WCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbjA0WCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:02:35 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A643D80020
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:02:23 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230127220222euoutp0279041ada3c1b4c76e7dd8638b7c408ba~_SYP3O6sz1471914719euoutp02R
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 22:02:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230127220222euoutp0279041ada3c1b4c76e7dd8638b7c408ba~_SYP3O6sz1471914719euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1674856942;
        bh=4/+IICDVxze4R+boTammad7oJB4qDwWiimXaU/Tj3Ts=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=CMNpTAiIIMcQd5vjH/3QsnmvJrsLwz2Ysj97euqyTsPedpAlwe6gb9PwRUt5S84+C
         f4GsO1JoH5PqzAwm7Oml17wucDbzZZBdEpQsOrFY07meulKn/KNqMYeRr3oz8807GJ
         9hVEK6G6PtVWZEdJXeCoCfvNI2foHI4XwHkecO00=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230127220221eucas1p138e31e7df0a5bf68011fa4c896847e2f~_SYPLtv092141421414eucas1p16;
        Fri, 27 Jan 2023 22:02:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F4.9E.13597.DE944D36; Fri, 27
        Jan 2023 22:02:21 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230127220221eucas1p1d2caad0ed56be4a43f15bff00a1d5ef5~_SYOiDtpu2139421394eucas1p1D;
        Fri, 27 Jan 2023 22:02:21 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230127220221eusmtrp2d712e07a4a3adbeac0fcd54ebab1331c~_SYOhaG1g3022330223eusmtrp2Z;
        Fri, 27 Jan 2023 22:02:21 +0000 (GMT)
X-AuditID: cbfec7f4-207ff7000000351d-7f-63d449ed7433
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 76.9F.02722.CE944D36; Fri, 27
        Jan 2023 22:02:20 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230127220220eusmtip1f3bcef7d420ef4a31e686a7e21c09546~_SYNsMne62478524785eusmtip1b;
        Fri, 27 Jan 2023 22:02:20 +0000 (GMT)
Message-ID: <c2094a98-1a99-14c6-40a6-0c671a6035db@samsung.com>
Date:   Fri, 27 Jan 2023 23:02:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [RFT PATCH v3 3/4] arm64: dts: exynos: add unit address to DWC3
 node wrapper in Exynos5433
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?Q?Martin_J=c3=bccker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230127212713.267014-3-krzysztof.kozlowski@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SYUxTZxT1e6/v9bVb8aOoXGXT2ESTSSzTMH2EQSRq9vxjHHH+IFm2Wl4q
        gQJrrUqjsUSpWkeDbA5oUJCBOMK6rViUIggMRlACDBmuUlEzTB2mC5VaqQiM8nDj3z3nnnvP
        uV8+hpR7qDVMRvZhXpetylLQUlHjb6G+zb49Q+oP+92x7OPLjTR773Ysez/gpdiKzj6K9VW7
        EGt99oRkW547xazjr2GKvecqp9nS/laC7Z29KGIr3ySz9vpItqClU8x6rfN0w6sZtANzTbaH
        Yq5raJTiHHXnaM4zfIvmGqpPcnOeH8Vc4NR5irNer0PcpGPtPkma9ON0PivjCK+LS/5Seqi9
        ZorIrVp9bMbyjDAhV5QFSRjA8WD+vpyyICkjx9cQ/O0pQwIIIChqekQLYBJBTf4Q+Xakudmy
        OFKLwH3tV1IAfgQhs40Kq2Q4GUavFovCtQhvAPOLUiTwkdBTNjbPM8xKnA6ON0fCdBTOgKqf
        zy7ISRwND8YqiPDOFbiLgJrS0AIgcSsBnb39CzFovAUsPgsdriV4N5TMmBan18ENX/lCIsA3
        JPC44jQVdgO8C4rOiIQTomC8+7pYqN+DuSbBDfAZBJXTjxZBEQKT9wESVIng6XtNhxeR+AP4
        yRUn0CngsZQjYX8E/OmLFDJEQHFjCSnQMjhrlgvqjWDrtv9n2z4wSBYhhW3Js9iW3G9bco3t
        f99KJKpD0bxBr9Xw+q3Z/FGlXqXVG7I1SnWO1oHmP+Dd2e7ATVQ77ld2IIJBHQgYUrFC5kwZ
        VMtl6ao8I6/L+UJnyOL1HSiGESmiZbFJPWo51qgO85k8n8vr3nYJRrLGRGSMbO5ldhT8s36f
        67ys/gCdNSJDezn/lP15d2oCNZDKdSagr4pbjMvcifbjF7TGtqe/xJkPFn56/+u0l8HSk3e+
        gWlH5g9kW0dr4bGPPlc2ZJ44MKx1fJuc305N5s2NM713Ji7qLQ+Nw2WfHL0ZYUzfcFcZarAn
        qltt/aelr9p2Dir81lP1F3YmjMw91V4pcOZ53j8R+/vVwdU526x797i3tWxPS4mPSXtnqPBS
        VbV8aldJwmd1Qe9xTXAMmXKdeG1SVP7+7wLT7cXLg6NlmmW1yj6NOBTpDE68uz3VXumvuOQe
        qOrazXtDBs3YRM9GPv6coTl61rBqPZEUw7zw/KEQ6Q+ptmwidXrVv9X9i+3vAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsVy+t/xu7pvPK8kG8xusrV4MG8bm8Xl/doW
        1788Z7WYf+Qcq8XbJbsYLfpePGS22Pt6K7vFpsfXWC0u75rDZjHj/D4mizP/prJYLPhjZ7Fu
        jaBF694j7BbP+4DCm7//ZXQQ8Ng56y67x9Er91g9Nq3qZPO4c20Pm8fmJfUe/++sZff40tzN
        6tG3ZRWjx+dNcgGcUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5
        mWWpRfp2CXoZB5f+YCpYJFnxt+sFUwPjLuEuRk4OCQETid27u1i7GLk4hASWMkrs/3CYGSIh
        I3FyWgMrhC0s8edaFxtE0XtGiSXTLjCBJHgF7CTuLZvEAmKzCKhKtH2awQgRF5Q4OfMJWFxU
        IEWi+flJsEHCApkSizZ0gMWZBcQlbj2ZzwQyVETgOJPEp0kLmEEcZoEDTBKT9v9hgVh3mVGi
        8dlKsHVsAoYSXW9B7uDk4BRwlZj+twFqlJlE19YuRghbXmL72znMExiFZiG5ZBaSjbOQtMxC
        0rKAkWUVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYNRvO/Zz8w7Gea8+6h1iZOJgPMQowcGs
        JMK71fFSshBvSmJlVWpRfnxRaU5q8SFGU2BwTGSWEk3OB6advJJ4QzMDU0MTM0sDU0szYyVx
        Xs+CjkQhgfTEktTs1NSC1CKYPiYOTqkGJkfrV+sN/sfHz5t4ymFyf7DFmnsmms8P8hYz7Ck7
        Ul2xenvuEm+f2cHpmmZztda8tb66+uptZ8Ub3+t31xh+OV6uNPd96eLgtrpFYsVLmIP9Pr7K
        cY++cCn2rHm6Q/77L/tS3J8cbLwy2WGng+RjT88llq+kG1TXnn6s1526xOrnIb0Fu1497b+w
        +XR7ff3qH6ea9vvX2T5wuFbF/TjObW/JVM0zNgsVGEoKvB9uVuGeJ2yyPqT2Q2zz9L6eiIR/
        8Vv6LyQtPVgo1lZv/aD/2YcL7HopCp+d//rU6ys/ZOsy2PDlUHerwMTgP9PME0sdY3Y7T5Fe
        N/27qF71Ea55/o+9nlglfv/yf5nYweQzb5RYijMSDbWYi4oTAfcLQaSDAwAA
X-CMS-MailID: 20230127220221eucas1p1d2caad0ed56be4a43f15bff00a1d5ef5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230127212730eucas1p1c7553326fe55355c303e2b79480f6a12
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230127212730eucas1p1c7553326fe55355c303e2b79480f6a12
References: <20230127212713.267014-1-krzysztof.kozlowski@linaro.org>
        <CGME20230127212730eucas1p1c7553326fe55355c303e2b79480f6a12@eucas1p1.samsung.com>
        <20230127212713.267014-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.01.2023 22:27, Krzysztof Kozlowski wrote:
> Neither simple-bus bindings nor dtc W=1 accept device nodes in soc@ node
> which do not have unit address.  Therefore usethe address space
> of child device (actual DWC3 Controller) as the wrapper's address to
> fix:
>
>    exynos5433-tm2e.dtb: soc@0: usbdrd: {'compatible': ['samsung,exynos5433-dwusb3'], ...
>      should not be valid under {'type': 'object'}
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>
> Changes since v2:
> 1. Fix typo/build error.
>
> Changes since v1:
> 1. New patch
> ---
>   arch/arm64/boot/dts/exynos/exynos5433.dtsi | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> index 9da24fe958a3..5519a80576c5 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> @@ -1742,7 +1742,7 @@ hsi2c_11: i2c@14df0000 {
>   			status = "disabled";
>   		};
>   
> -		usbdrd30: usbdrd {
> +		usbdrd30: usb@15400000 {
>   			compatible = "samsung,exynos5433-dwusb3";
>   			clocks = <&cmu_fsys CLK_ACLK_USBDRD30>,
>   				<&cmu_fsys CLK_SCLK_USBDRD30>,
> @@ -1751,16 +1751,16 @@ usbdrd30: usbdrd {
>   			clock-names = "aclk", "susp_clk", "phyclk", "pipe_pclk";
>   			#address-cells = <1>;
>   			#size-cells = <1>;
> -			ranges;
> +			ranges = <0x0 0x15400000 0x10000>;
>   			status = "disabled";
>   
> -			usbdrd_dwc3: usb@15400000 {
> +			usbdrd_dwc3: usb@0 {
>   				compatible = "snps,dwc3";
>   				clocks = <&cmu_fsys CLK_SCLK_USBDRD30>,
>   					<&cmu_fsys CLK_ACLK_USBDRD30>,
>   					<&cmu_fsys CLK_SCLK_USBDRD30>;
>   				clock-names = "ref", "bus_early", "suspend";
> -				reg = <0x15400000 0x10000>;
> +				reg = <0x0 0x10000>;
>   				interrupts = <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
>   				phys = <&usbdrd30_phy 0>, <&usbdrd30_phy 1>;
>   				phy-names = "usb2-phy", "usb3-phy";
> @@ -1795,7 +1795,7 @@ usbhost30_phy: phy@15580000 {
>   			status = "disabled";
>   		};
>   
> -		usbhost30: usbhost {
> +		usbhost30: usb@15a00000 {
>   			compatible = "samsung,exynos5433-dwusb3";
>   			clocks = <&cmu_fsys CLK_ACLK_USBHOST30>,
>   				<&cmu_fsys CLK_SCLK_USBHOST30>,
> @@ -1804,16 +1804,16 @@ usbhost30: usbhost {
>   			clock-names = "aclk", "susp_clk", "phyclk", "pipe_pclk";
>   			#address-cells = <1>;
>   			#size-cells = <1>;
> -			ranges;
> +			ranges = <0x0 0x15a00000 0x10000>;
>   			status = "disabled";
>   
> -			usbhost_dwc3: usb@15a00000 {
> +			usbhost_dwc3: usb@0 {
>   				compatible = "snps,dwc3";
>   				clocks = <&cmu_fsys CLK_SCLK_USBHOST30>,
>   					<&cmu_fsys CLK_ACLK_USBHOST30>,
>   					<&cmu_fsys CLK_SCLK_USBHOST30>;
>   				clock-names = "ref", "bus_early", "suspend";
> -				reg = <0x15a00000 0x10000>;
> +				reg = <0x0 0x10000>;
>   				interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>;
>   				phys = <&usbhost30_phy 0>, <&usbhost30_phy 1>;
>   				phy-names = "usb2-phy", "usb3-phy";

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

