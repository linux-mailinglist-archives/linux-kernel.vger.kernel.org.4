Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0304867F0CE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjA0WCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjA0WCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:02:05 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8BA7E066
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:02:02 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230127220159euoutp02ee3335cc77c2fccbb6cd70c73811e6ae~_SX6TYszH1472614726euoutp02N
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 22:01:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230127220159euoutp02ee3335cc77c2fccbb6cd70c73811e6ae~_SX6TYszH1472614726euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1674856919;
        bh=Kgy+IfaTKmg1cJRC43EDMce4Aibab6Zf8FTi6V5dFQc=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=qm8j4+XqFpUNW66LN8zN5G7XRHW7FNSNnbp1KdtAYFhNBDJUTOy/1mD47InbqSAC/
         j/Ho7vZDTstWtjKA4RDLOkAmjHAQNyZm0wGmtj+RQhFXwTAygpzwc93p3nCpVrt0p4
         57/g4E8HdoEEDLt/apnM+Qcp59ZLd1SyFx7Y0OTc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230127220158eucas1p206df4ebd15272ebc9b6b6d8cb7c931ff~_SX5HZq7r2064420644eucas1p2I;
        Fri, 27 Jan 2023 22:01:58 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 54.78.01471.5D944D36; Fri, 27
        Jan 2023 22:01:57 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230127220157eucas1p1cb928e375c14c99d151ee77986f1a4cb~_SX4phwQq2138521385eucas1p17;
        Fri, 27 Jan 2023 22:01:57 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230127220157eusmtrp25da4eb4f57d639d8062e119e0f71f1cc~_SX4o2Ul23022330223eusmtrp2Q;
        Fri, 27 Jan 2023 22:01:57 +0000 (GMT)
X-AuditID: cbfec7f2-2b1ff700000105bf-47-63d449d5c161
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B3.41.00518.5D944D36; Fri, 27
        Jan 2023 22:01:57 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230127220156eusmtip1ea104a2f69854d97444ac44e39b050c4~_SX3r2wID3074430744eusmtip1K;
        Fri, 27 Jan 2023 22:01:56 +0000 (GMT)
Message-ID: <5e2a7c3e-b2cc-746f-81b1-13adfddf1c62@samsung.com>
Date:   Fri, 27 Jan 2023 23:01:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [RFT PATCH v3 1/4] ARM: dts: exynos: add unit address to DWC3
 node wrapper in Exynos5250
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
In-Reply-To: <20230127212713.267014-1-krzysztof.kozlowski@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDKsWRmVeSWpSXmKPExsWy7djP87pXPa8kG/Sds7F4MG8bm8Xl/doW
        1788Z7WYf+Qcq8XbJbsYLfpePGS22Pt6K7vFpsfXWC0u75rDZjHj/D4mizP/prJYLPhjZ7Fu
        jaBF694j7BbP+4DCm7//ZXQQ8Ng56y67x9Er91g9Nq3qZPO4c20Pm8fmJfUe/++sZff40tzN
        6tG3ZRWjx+dNcgGcUVw2Kak5mWWpRfp2CVwZ++5PYC74xFdxefkp5gbGe9xdjJwcEgImEhPm
        bWDrYuTiEBJYwSjx/10DM4TzhVGib8o8KOczo8SEy9+YYVqe3loI1bKcUeL72WmsEM5HRome
        69+YQKp4BewkfpxqZgOxWQRUJc7+n8YIEReUODnzCUsXIweHqECKxKY/ZSBhYYF0iXUXT4O1
        MguIS9x6Mp8JZKaIwFEmiaUzfoI5zAL7mCSOnDkPdgabgKFE19suNpBBnAKuElN2sEE0y0ts
        fzsH7GwJgd2cEq+PLIY620Xi2qWdjBC2sMSr41vYIWwZif87IbZJCLQzSiz4fR/KmcAo0fD8
        FlSHtcSdc7/AtjELaEqs36UPEXaUmN28lB0kLCHAJ3HjrSDEEXwSk7ZNZ4YI80p0tAlBVKtJ
        zDq+Dm7twQuXmCcwKs1CCpZZSP6fheSdWQh7FzCyrGIUTy0tzk1PLTbMSy3XK07MLS7NS9dL
        zs/dxAhMgKf/Hf+0g3Huq496hxiZOBgPMUpwMCuJ8G51vJQsxJuSWFmVWpQfX1Sak1p8iFGa
        g0VJnFfb9mSykEB6YklqdmpqQWoRTJaJg1Oqgakt0HrO7+x9L+Q2WD/b03BsXvR32asl4k/a
        btnfFLjK1J2z7ng0W9Z2nfXiin2iyslVxkeCZE7eUTzdOv8Dt/+kMxcNDTn/HVCurfqlsV3x
        pfSGA7PD75j0hcr9Erlv926Xq3Hfw5ml+b33Nc6nbGSJc564Q3NxjMwJizd2J2Rr04MuTU47
        eZM385174oXChTs3is1zTlM269y30lTnyTNJ0SvHXYoCjlTPldlc3fdJ8fPKHdd2ab/hLYnv
        vlCRei18f9+zmcVeby+1VO2PE6lNjved8cziT1pb8eMtugpvtm3rzstbdLC7zbzzwv23tx3n
        eBhK/S0J/ae2Uy0o9K2nR8uBskd+UwSU5xeaTVdiKc5INNRiLipOBABF6tN07wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsVy+t/xu7pXPa8kGxzaL2fxYN42NovL+7Ut
        rn95zmox/8g5Vou3S3YxWvS9eMhssff1VnaLTY+vsVpc3jWHzWLG+X1MFmf+TWWxWPDHzmLd
        GkGL1r1H2C2e9wGFN3//y+gg4LFz1l12j6NX7rF6bFrVyeZx59oeNo/NS+o9/t9Zy+7xpbmb
        1aNvyypGj8+b5AI4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJz
        MstSi/TtEvQy9t2fwFzwia/i8vJTzA2M97i7GDk5JARMJJ7eWsjWxcjFISSwlFGi69VMRoiE
        jMTJaQ2sELawxJ9rXWwgtpDAe0aJWXvCQGxeATuJH6eaweIsAqoSZ/9PY4SIC0qcnPmEBcQW
        FUiRaH5+EmyOsEC6xLqLp5lAbGYBcYlbT+YzgSwWETjOJPFp0gJmEIdZ4ACTxKT9f1ggTprB
        KLH0+GqwFjYBQ4mutyBncHBwCrhKTNnBBjHJTKJraxcjhC0vsf3tHOYJjEKzkBwyC8nCWUha
        ZiFpWcDIsopRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMw4rcd+7llB+PKVx/1DjEycTAeYpTg
        YFYS4d3qeClZiDclsbIqtSg/vqg0J7X4EKMpMDQmMkuJJucDU05eSbyhmYGpoYmZpYGppZmx
        kjivZ0FHopBAemJJanZqakFqEUwfEwenVAOT+qElbutvWyVvnfmPvdOmbuaDv/dLp+VdTVbn
        bA5v32EduE6oanOqx5allz4uXHujuYGp8qGSoONrXs83U9a0a3Lx5Em4K70Oz0hJfarYmzfp
        lPDhcibHtplO8/bnnrvonylflH6Yp+NUT3yD5we+fz/d+TKTX6+u3xGu8Cmp7OUJSeMYVe0k
        5afa/p7ndfjmOC6fdE18TcDpo54Si9IZGllXBp87+NGRrVFr06Sq8k9H7ojtXXXtZsFVwZ4T
        i+sPbayboG7kc6R8VeKRCweUxKPDmjap//rzSPuTOceZ5f/f/GIo0led2LLgsf/ETjNpAduV
        6+arxt/zcEzre7l3+/JSo3XhQtymfz8y+XEosRRnJBpqMRcVJwIAEzxIsIEDAAA=
X-CMS-MailID: 20230127220157eucas1p1cb928e375c14c99d151ee77986f1a4cb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230127212728eucas1p124a7a0cdd785cfc7edd53b7a6fe1a2d0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230127212728eucas1p124a7a0cdd785cfc7edd53b7a6fe1a2d0
References: <CGME20230127212728eucas1p124a7a0cdd785cfc7edd53b7a6fe1a2d0@eucas1p1.samsung.com>
        <20230127212713.267014-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
>    exynos5250-smdk5250.dtb: soc: usb3: {'compatible': ['samsung,exynos5250-dwusb3'],
>      ... } should not be valid under {'type': 'object'}
>
>    exynos5250.dtsi:638.16-653.5: Warning (simple_bus_reg): /soc/usb3: missing or empty reg/ranges property
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>
> Changes since v1:
> 1. Use ranges with values and drop reg from usb-wrapper node.
> 2. Keep "usb" as wrapper's node name.
> ---
>   arch/arm/boot/dts/exynos5250.dtsi | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index 97e89859ba3d..a5db4ac213d5 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -635,17 +635,17 @@ i2s2: i2s@12d70000 {
>   			#sound-dai-cells = <1>;
>   		};
>   
> -		usbdrd: usb3 {
> +		usbdrd: usb@12000000 {
>   			compatible = "samsung,exynos5250-dwusb3";
>   			clocks = <&clock CLK_USB3>;
>   			clock-names = "usbdrd30";
>   			#address-cells = <1>;
>   			#size-cells = <1>;
> -			ranges;
> +			ranges = <0x0 0x12000000 0x10000>;
>   
> -			usbdrd_dwc3: usb@12000000 {
> +			usbdrd_dwc3: usb@0 {
>   				compatible = "snps,dwc3";
> -				reg = <0x12000000 0x10000>;
> +				reg = <0x0 0x10000>;
>   				interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
>   				phys = <&usbdrd_phy 0>, <&usbdrd_phy 1>;
>   				phy-names = "usb2-phy", "usb3-phy";

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

