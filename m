Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A330F67F0D1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjA0WCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjA0WCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:02:14 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59547E6B6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:02:12 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230127220211euoutp02557ec0a6ff8996404ffa0fca92ad2c66~_SYFng9lE2612926129euoutp02R
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 22:02:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230127220211euoutp02557ec0a6ff8996404ffa0fca92ad2c66~_SYFng9lE2612926129euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1674856931;
        bh=GtHOMbt1x+T7/SsXR+6a4k1idSFUP669cFJ9Of9wi5A=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=TCLEc5AZEgxc7Fyak/gTDe9W5t+plKDpdRcsND8hc7brFXYxNarZtrkKpSGhZwcnb
         poGF84SZ31WMaPIfmTS8gFTpWLAlwTh5PMftlQjaepYFEd8gZtE0hG8l3a2vRI9Kh+
         D9EkPhzQW0g4EElhkdLMCZD8CWeMllkKrZ0sWmWk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230127220210eucas1p139fb4da8a948106e635bae5ba47d7cac~_SYEjc7002141821418eucas1p1O;
        Fri, 27 Jan 2023 22:02:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 53.9E.13597.2E944D36; Fri, 27
        Jan 2023 22:02:10 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230127220210eucas1p19f18ee2162405bb0754a621b3e26f991~_SYEMZWYq2139321393eucas1p1G;
        Fri, 27 Jan 2023 22:02:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230127220210eusmtrp18c40e12feec7d9f7fd1bb4683a740a62~_SYELl4A71244412444eusmtrp1b;
        Fri, 27 Jan 2023 22:02:10 +0000 (GMT)
X-AuditID: cbfec7f4-1f1ff7000000351d-6e-63d449e26b33
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 65.9F.02722.1E944D36; Fri, 27
        Jan 2023 22:02:09 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230127220209eusmtip2ddecf800f7f5ef63d120b3a161cd48f4~_SYDWoPRW0088800888eusmtip2b;
        Fri, 27 Jan 2023 22:02:09 +0000 (GMT)
Message-ID: <92d08e49-2112-3360-0f0f-eba849000645@samsung.com>
Date:   Fri, 27 Jan 2023 23:02:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [RFT PATCH v3 2/4] ARM: dts: exynos: add unit address to DWC3
 node wrapper in Exynos54xx
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
In-Reply-To: <20230127212713.267014-2-krzysztof.kozlowski@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsWy7djP87qPPK8kG1yfJWrxYN42NovL+7Ut
        rn95zmox/8g5Vou3S3YxWvS9eMhssff1VnaLTY+vsVpc3jWHzWLG+X1MFmf+TWWxWPDHzmLd
        GkGL1r1H2C2e9wGFN3//y+gg4LFz1l12j6NX7rF6bFrVyeZx59oeNo/NS+o9/t9Zy+7xpbmb
        1aNvyypGj8+b5AI4o7hsUlJzMstSi/TtErgyjl1dwF6wTbji8pTTzA2MrfxdjJwcEgImElNv
        v2LtYuTiEBJYwSgxoeUiK0hCSOALo0TPLQmIxGdGiYMbzjN2MXKAdRy+WA8RX84oseXVcTYI
        5yOjxPYpx9hBunkF7CTmTOpmA7FZBFQl7v8/ChUXlDg58wkLyCBRgRSJTX/KQMLCAukSOy/c
        YgaxmQXEJW49mc8EMlNE4CiTxNIZP8EcZoF9TBJHzpwHq2ITMJToetsFtoBTwFXi06S1rBDd
        8hLb385hBmmQENjNKdF7+RQjxKMuEh9/PmKBsIUlXh3fwg5hy0icntzDAtHQziix4Pd9Jghn
        AqNEw/NbUN3WEnfO/WIDuZtZQFNi/S59iLCjxPsXm5gh4cInceOtIMQRfBKTtk2HCvNKdLQJ
        QVSrScw6vg5u7cELl5gnMCrNQgqXWUgBMAvJO7MQ9i5gZFnFKJ5aWpybnlpslJdarlecmFtc
        mpeul5yfu4kRmP5O/zv+ZQfj8lcf9Q4xMnEwHmKU4GBWEuHd6ngpWYg3JbGyKrUoP76oNCe1
        +BCjNAeLkjivtu3JZCGB9MSS1OzU1ILUIpgsEwenVANTw77/y35aP60Rvt456eainYXr+//P
        +LZlnvDpLxf2X4+ZNov1nKRTwrbuKKErV5ZJsDbKlR+VXvZu6f3XBvtWiklasotdr9nUWHf7
        VUS/m5fCnd7bXSeS74j//ijBE7M322b3xMud04IXT9x+kONOzsWXzi++yp3Yfnj98ftLkqec
        zGUsbdfWspirX2x8wHrCM0WJV64HeAI/Rz5dGZM9rdIgLkH3yscHBurtrR6nMt/2t83nfn/o
        qGGysNDSirgp7zS1t4XeM1k6+cby6pJgjvdb/zZoxjrOZ+Y45KlvXSK785xTYUGOVX/RIcGH
        23dx/u+o/madYPpBSr5QgOX5y18znv+4nd2j63Zqk+jXk0osxRmJhlrMRcWJABT3ktruAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsVy+t/xe7oPPa8kGxy8a2nxYN42NovL+7Ut
        rn95zmox/8g5Vou3S3YxWvS9eMhssff1VnaLTY+vsVpc3jWHzWLG+X1MFmf+TWWxWPDHzmLd
        GkGL1r1H2C2e9wGFN3//y+gg4LFz1l12j6NX7rF6bFrVyeZx59oeNo/NS+o9/t9Zy+7xpbmb
        1aNvyypGj8+b5AI4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJz
        MstSi/TtEvQyjl1dwF6wTbji8pTTzA2MrfxdjBwcEgImEocv1ncxcnEICSxllFj0aDljFyMn
        UFxG4uS0BlYIW1jiz7UuNoii94wSzzbeYAdJ8ArYScyZ1M0GYrMIqErc/38UKi4ocXLmExYQ
        W1QgRaL5+UmwQcIC6RI7L9xiBrGZBcQlbj2ZzwQyVETgOJPEp0kLmEEcZoEDTBKT9v9hgVh3
        mVGi4dJtsLFsAoYSXW+7wNZxCrgCdaxlhRhlJtG1tYsRwpaX2P52DvMERqFZSC6ZhWTjLCQt
        s5C0LGBkWcUoklpanJueW2yoV5yYW1yal66XnJ+7iREY89uO/dy8g3Heq496hxiZOBgPMUpw
        MCuJ8G51vJQsxJuSWFmVWpQfX1Sak1p8iNEUGBwTmaVEk/OBSSevJN7QzMDU0MTM0sDU0sxY
        SZzXs6AjUUggPbEkNTs1tSC1CKaPiYNTqoHJdalR0MuE9+fDIi9sLFdZojph5Xp7k+4Qh03/
        A738/3rzR973nheR/nWJdsDEuTVmCUX9nDOCZr4+ULro3cqPFjx7rEWMzr5pVWHQ2atey/tw
        Q0LlEqdkSaG5d1wNuY4taL+S4x2qNsf0nMSNZfs6lPjZnre9uZYyc3fo+dq1nh6sWVq3TIxP
        qp7asl+86cmfvl31nZtNhMLLL5/cvZNbdwuPkd1W9Tv9jZxGDbqBfjvSb21yfWrMJdm0ZtV6
        1tXrjyZZnY7aKaIv//RNyMlTx/0mBHguMp/18y1n6K2EBmkjCW2nJa4nRJZePaSfdH/DV9+G
        Up1f39f9S9jAHF3yXCBWXmqF2Y8fHpZbPHcosRRnJBpqMRcVJwIAmumkr4IDAAA=
X-CMS-MailID: 20230127220210eucas1p19f18ee2162405bb0754a621b3e26f991
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230127212730eucas1p1dd8fc493954402ab5360052f4bd9a5b2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230127212730eucas1p1dd8fc493954402ab5360052f4bd9a5b2
References: <20230127212713.267014-1-krzysztof.kozlowski@linaro.org>
        <CGME20230127212730eucas1p1dd8fc493954402ab5360052f4bd9a5b2@eucas1p1.samsung.com>
        <20230127212713.267014-2-krzysztof.kozlowski@linaro.org>
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
>    exynos5422-odroidhc1.dtb: soc: usb3-0: {'compatible': ['samsung,exynos5250-dwusb3'],
>      ... } should not be valid under {'type': 'object'}
>
>    exynos54xx.dtsi:145.21-159.5: Warning (simple_bus_reg): /soc/usb3-0: missing or empty reg/ranges property
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>
> Changes since v1:
> 1. Use ranges with values and drop reg from usb-wrapper node.
> 2. Keep "usb" as wrapper's node name.
> ---
>   arch/arm/boot/dts/exynos54xx.dtsi | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/exynos54xx.dtsi
> index 3ec43761d8b9..5c799886c275 100644
> --- a/arch/arm/boot/dts/exynos54xx.dtsi
> +++ b/arch/arm/boot/dts/exynos54xx.dtsi
> @@ -142,15 +142,15 @@ hsi2c_7: i2c@12cd0000 {
>   			status = "disabled";
>   		};
>   
> -		usbdrd3_0: usb3-0 {
> +		usbdrd3_0: usb@12000000 {
>   			compatible = "samsung,exynos5250-dwusb3";
>   			#address-cells = <1>;
>   			#size-cells = <1>;
> -			ranges;
> +			ranges = <0x0 0x12000000 0x10000>;
>   
> -			usbdrd_dwc3_0: usb@12000000 {
> +			usbdrd_dwc3_0: usb@0 {
>   				compatible = "snps,dwc3";
> -				reg = <0x12000000 0x10000>;
> +				reg = <0x0 0x10000>;
>   				interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
>   				phys = <&usbdrd_phy0 0>, <&usbdrd_phy0 1>;
>   				phy-names = "usb2-phy", "usb3-phy";
> @@ -164,15 +164,15 @@ usbdrd_phy0: phy@12100000 {
>   			#phy-cells = <1>;
>   		};
>   
> -		usbdrd3_1: usb3-1 {
> +		usbdrd3_1: usb@12400000 {
>   			compatible = "samsung,exynos5250-dwusb3";
>   			#address-cells = <1>;
>   			#size-cells = <1>;
> -			ranges;
> +			ranges = <0x0 0x12400000 0x10000>;
>   
> -			usbdrd_dwc3_1: usb@12400000 {
> +			usbdrd_dwc3_1: usb@0 {
>   				compatible = "snps,dwc3";
> -				reg = <0x12400000 0x10000>;
> +				reg = <0x0 0x10000>;
>   				phys = <&usbdrd_phy1 0>, <&usbdrd_phy1 1>;
>   				phy-names = "usb2-phy", "usb3-phy";
>   				snps,dis_u3_susphy_quirk;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

