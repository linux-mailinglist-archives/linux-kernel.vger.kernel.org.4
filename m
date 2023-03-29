Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262066CDAF2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjC2NgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjC2NgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:36:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230C03C11;
        Wed, 29 Mar 2023 06:36:19 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 42D566602EDC;
        Wed, 29 Mar 2023 14:36:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680096977;
        bh=Y8uVgfvu6kCHISPvrNsx5nPyPbgp5npqxM91mbiZwuo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BA7xxyfVqs6dIwXZR1CMYcsLEq1DeIjKMzQrCpcZy0bsY9sAW+8u7Zvj0IJBJ+BlF
         1GMG1g07xK4H+kZA04R72ptDrXDXlz9G9JrBO6XcKHox2I6FzIAK9t5C+R4Bl1pOeP
         hhLxKi5HD89CbIndTFpYiL/gqCTjgN0TBDsihKVy1KOz0cLT5M04cOJH/PSJ7zkxL5
         vhbgeI6wF+rZP0IRtsOMNnIXrma1rULejCxVOxvuf6nOqfyu5WZ1nOYTqz31r+fSYy
         Rh8J2j4XXoRQ3Vvg+pHxrUxHPIpn7fWqaBpdTzLF8a2r5MoBntWGjdsxCfM0i2ZMNL
         BMhij/fJSbVXg==
Message-ID: <5e0a8592-9d50-d6cf-8899-b842c84e380f@collabora.com>
Date:   Wed, 29 Mar 2023 15:36:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH RESEND 3/6] arm64: dts: mediatek: add power domain support
 for mt8365 SoC
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230207-iommu-support-v1-0-4a902f9aa412@baylibre.com>
 <20230207-iommu-support-v1-3-4a902f9aa412@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230207-iommu-support-v1-3-4a902f9aa412@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/03/23 11:52, Alexandre Mergnat ha scritto:
> The following power domain are added to the SoC dts:
> - MM (MultiMedia)
> - CONN (Connectivity)
> - MFG (MFlexGraphics)
> - Audio
> - Cam (Camera)
> - DSP (Digital Signal Processor)
> - Vdec (Video decoder)
> - Venc (Video encoder)
> - APU (AI Processor Unit)
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8365.dtsi | 129 +++++++++++++++++++++++++++++++
>   1 file changed, 129 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> index b5f5c77f7f84..67b375fe2020 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> @@ -9,6 +9,7 @@

..snip..

> +
>   		watchdog: watchdog@10007000 {
>   			compatible = "mediatek,mt8365-wdt",
>   				     "mediatek,mt6589-wdt";
> @@ -592,6 +702,25 @@ u2port1: usb-phy@1000 {
>   				#phy-cells = <1>;
>   			};
>   		};
> +
> +		mmsys: syscon@14000000 {

These are not power domains... either introduce them in a different commit
or at least please mention the addition in the commit title/description.

Personally, I would split that addition in a different commit, explaining
what mmsys, camsys and apu clocks are ;-)

Regards,
Angelo

