Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD27627B62
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbiKNLCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236297AbiKNLCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:02:37 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2AD20999;
        Mon, 14 Nov 2022 03:02:35 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2F8A26601E4C;
        Mon, 14 Nov 2022 11:02:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668423753;
        bh=Vdfc8dY/vI6TMkcQxnexuBFAvBXuoQ1lTIkgbdeds7Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SOzYkjV4PcS+7Fp5HVYXPg5UfEmPi5X/LU0D7bnQqtw8C05Bxa5hoojhVeu+6buoO
         lbV+ff1Oc0eAyBYzSbYYGo32GimqE5r1AdKNOLi9H80htfVqhfGCds6nsIUkJpw1d5
         AMG4HzseXAZovbHUWS2fNr8+wVcR9biVT1ZxawcZ6l97/ov9H1m+LEt0MK7GR3IsLh
         1CP2etsIE5oLM+jIvK5sD1oc3MttCb/hDd+UMbNeSeo5S4Cosox/K7JXHR1vaM3Dw0
         HESmvu3OhtOaXQVcdh4+7xza1vaGPSyPFxH9SGyo5dlHRikq0KfZoJPq/ySMIZr4gB
         QAZJvHQUSzoCw==
Message-ID: <1683603c-8486-b7a7-e9d7-bddd28c1cd8c@collabora.com>
Date:   Mon, 14 Nov 2022 12:02:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] arm64: dts: mediatek: mt7986: Add SoC compatible
Content-Language: en-US
To:     matthias.bgg@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        frank-w@public-files.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <mbrugger@suse.com>
References: <20221111113635.4603-1-matthias.bgg@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221111113635.4603-1-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/11/22 12:36, matthias.bgg@kernel.org ha scritto:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> Missing SoC compatible in the board file causes dt bindings check.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts | 2 +-
>   arch/arm64/boot/dts/mediatek/mt7986a.dtsi    | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> index afe37b702eef9..0e3b603159477 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> @@ -9,7 +9,7 @@
>   
>   / {
>   	model = "MediaTek MT7986a RFB";
> -	compatible = "mediatek,mt7986a-rfb";
> +	compatible = "mediatek,mt7986a-rfb", "mediatek,mt7986a";
>   
>   	aliases {
>   		serial0 = &uart0;
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> index 72e0d9722e07a..1191ecf345a7d 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> @@ -14,6 +14,8 @@ / {
>   	#address-cells = <2>;
>   	#size-cells = <2>;
>   
> +	compatible = "mediatek,mt7986a";
> +

It's DTS that shall declare the machine compatible and it's expected that they
all declare their own, so please drop this one.

Also, while at it, the same should happen with mt7986b-rfb.dts: can you fix that
one too?

	compatible = "mediatek,mt7986b-rfb", "mediatek,mt7986b";

Cheers,
Angelo


