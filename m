Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A1171559B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 08:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjE3GjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 02:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjE3GjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 02:39:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C06CE5;
        Mon, 29 May 2023 23:38:49 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7856C66058F8;
        Tue, 30 May 2023 07:38:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685428728;
        bh=KtqmldD7s3ro7nqM1YsEAzRtJDAnNiaXuCYtFORMGg8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kNACF24Vz7zJ2EWyJ0AiOpyRsD3xYzcvJOcSVrqe/Kgikz/7Nv1BhKuuxGp2ICKvy
         jX2feCqQCer7AOJWZI+oEPp4J5HCFFyXBaJRqUY88UfHsuwb9Lj3ylRlfK3ErfnTPX
         Uw4G8DWG0Tz+W8dRJnmZNDu7rO52w/yZaAPOl4cXwu05onowIrf4y+8gkaRXdETaA/
         ks1FeOZTNBA/kOFKUsk/uUPJX9MUPyRkOy6KX0TURY4opfjpOXgpZAsEjc1QCCjXvW
         bVAVsTV14GmeedX/+nsvKhc73rFDuQRe6b0kgkoPQFhwAqAmR8+jRHUOVHIP3PP5U6
         WayJj+K+CZTog==
Message-ID: <8d4d21d9-4f2c-8895-36e6-19de498d6e4a@collabora.com>
Date:   Tue, 30 May 2023 08:38:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 2/4] arm64: dts: mt7986: add thermal and efuse
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "Hui.Liu" <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Lala Lin <lala.lin@mediatek.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Golle <daniel@makrotopia.org>
References: <20230529204258.65238-1-linux@fw-web.de>
 <20230529204258.65238-3-linux@fw-web.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230529204258.65238-3-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/05/23 22:42, Frank Wunderlich ha scritto:
> From: Daniel Golle <daniel@makrotopia.org>
> 
> Add thermal related nodes to mt7986 devicetree.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>   arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 37 ++++++++++++++++++++++-
>   1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> index aa9e679b78e2..a409d5e845c2 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> @@ -337,6 +337,15 @@ spi1: spi@1100b000 {
>   			status = "disabled";
>   		};
>   
> +		auxadc: adc@1100d000 {
> +			compatible = "mediatek,mt7986-auxadc";
> +			reg = <0 0x1100d000 0 0x1000>;
> +			clocks = <&infracfg CLK_INFRA_ADC_26M_CK>;
> +			clock-names = "main";
> +			#io-channel-cells = <1>;
> +			status = "disabled";
> +		};
> +
>   		ssusb: usb@11200000 {
>   			compatible = "mediatek,mt7986-xhci",
>   				     "mediatek,mtk-xhci";
> @@ -375,6 +384,21 @@ mmc0: mmc@11230000 {
>   			status = "disabled";
>   		};
>   
> +		thermal: thermal@1100c800 {
> +			#thermal-sensor-cells = <1>;
> +			compatible = "mediatek,mt7986-thermal";
> +			reg = <0 0x1100c800 0 0x800>;
> +			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&infracfg CLK_INFRA_THERM_CK>,
> +				 <&infracfg CLK_INFRA_ADC_26M_CK>,
> +				 <&infracfg CLK_INFRA_ADC_FRC_CK>;
> +			clock-names = "therm", "auxadc", "adc_32k";
> +			mediatek,auxadc = <&auxadc>;
> +			mediatek,apmixedsys = <&apmixedsys>;
> +			nvmem-cells = <&thermal_calibration>;
> +			nvmem-cell-names = "calibration-data";
> +		};
> +
>   		pcie: pcie@11280000 {
>   			compatible = "mediatek,mt7986-pcie",
>   				     "mediatek,mt8192-pcie";
> @@ -426,6 +450,18 @@ pcie_port: pcie-phy@11c00000 {
>   			};
>   		};
>   
> +		efuse: efuse@11d00000 {
> +			compatible = "mediatek,mt7986-efuse",
> +				     "mediatek,efuse";

Fits in one single line. After which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


