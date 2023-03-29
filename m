Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014406CDAB8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjC2NZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjC2NZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:25:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3855469E;
        Wed, 29 Mar 2023 06:25:46 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 85C9D6602173;
        Wed, 29 Mar 2023 14:25:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680096345;
        bh=NiiGpi4sFbjpxV4imTL2ZIq/xcV+jbx+PGJrCD8dAhU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GazyfMUi4MueJq3SALhwwitUIeR6BSuqHHEekLxk7+rEw/MCtl3s6SaENDzfzNOKv
         qjduEaU/vDP7a/sUSLreyhGqc88FoYmZ6cljNJj55xVQk02Cq3v/XNRfYgYUtVg6s5
         4QrwfXjKLIX64id2Up7zbp5Cp2ED9Meul5EbigW+/y6LmAEGilDtq/cy2083+xbTLF
         m1wp9h7jTOYwqXUCZnSvQ+euZaEXH14It/1u8VCtuhbsu0eehneAzzHilf0qVLiHbt
         G23T/vYVZpf3Y4LPEtmzjdSDoWnwt1sMwUNEPAiav+MGAICPGIMk+Z6bNJCqb8frxA
         ssKCdGW8zbH6Q==
Message-ID: <7b6be990-9e90-8e44-7c5e-f8b7a2701ce7@collabora.com>
Date:   Wed, 29 Mar 2023 15:25:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 10/17] arm64: dts: mediatek: set vmc regulator as
 always on
Content-Language: en-US
To:     amergnat@baylibre.com, Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
References: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
 <20230203-evk-board-support-v3-10-0003e80e0095@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230203-evk-board-support-v3-10-0003e80e0095@baylibre.com>
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

Il 29/03/23 10:54, amergnat@baylibre.com ha scritto:
> From: Fabien Parent <fparent@baylibre.com>
> 
> MSDC1 IP block is powered by VMC. Make sure it is always on.

Why always on?
Can't you just set mt6357_vmc_reg as VIN of mt6357_vmch_reg? :-)

Regards,
Angelo

> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> index b5d018686cbe..22ec332fe9c9 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> @@ -140,6 +140,11 @@ &mt6357_pmic {
>   	#interrupt-cells = <2>;
>   };
>   
> +/* Needed by MSDC1 */
> +&mt6357_vmc_reg {
> +	regulator-always-on;
> +};
> +
>   &pio {
>   	gpio_keys: gpio-keys-pins {
>   		pins {
> 

