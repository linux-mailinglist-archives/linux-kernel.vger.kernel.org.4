Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50970702BE8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241093AbjEOLza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241309AbjEOLzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:55:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A35A2D63;
        Mon, 15 May 2023 04:44:29 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E0C8D66031D7;
        Mon, 15 May 2023 12:44:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684151067;
        bh=rDyvSJh2ELejvMz6JJ1HfRpjB8o4ib0qqoQwRrpvqj4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WTYBOhcjSLYsGnY9G9lV204YnWZ8jpu0eh800cs4me6vSP5bLI5SHZt+66bdNDhOa
         /affCIm0aFqN1v5KeAUt9br+lVC0fHsVVK4AS1KZOJ1wsEdjS3xVlBa+cyPQF1Fus4
         atY6l+7mqaa0blZL/RCDQWN971SUaym5vYyITXCIbxU/QdwfoFeGNEIcrJSv0mJGKG
         hUL18PnvqnezQRcOxHJhjJCuUf8W+r3uEhZoyJdgeSemWqtU4uGn77S7jHEWUQbk0+
         4cbyOB9fP3OawQyvm3KKDRxz7ynNvmkqeN27ouDTE90RU5VxOKy4fquXFdu9qf58YZ
         I50NfCyBgRTDg==
Message-ID: <ff7292f0-9055-1787-2543-e219fe30dddf@collabora.com>
Date:   Mon, 15 May 2023 13:44:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v7 06/11] arm64: dts: mediatek: set vmc regulator as
 always on
Content-Language: en-US
To:     amergnat@baylibre.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
References: <20230203-evk-board-support-v7-0-98cbdfac656e@baylibre.com>
 <20230203-evk-board-support-v7-6-98cbdfac656e@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230203-evk-board-support-v7-6-98cbdfac656e@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/05/23 18:29, amergnat@baylibre.com ha scritto:
> From: Fabien Parent <fparent@baylibre.com>
> 
> On downstream, we observe that the MSDC IP (used by the emmc, the micro
> SD card and the WiFi) isn't working properly if the VMC regulator is
> shutdown.
> 
> Make sure it is always on.

I don't understand the power tree of this board: if your VQMMC is VIO18 and
*not* VMC, why is that required?

The real question is if we're facing one more supply as requirement for newer
MediaTek SoCs and whether it would be a better idea to add that to the actual
driver (and/or as a power domain supply!!!) to both better represent the power
tree and to eventually allow deep power saving states.

Regards,
Angelo

> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> index 752007d0598e..5d69b39c8746 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> @@ -137,6 +137,11 @@ &mt6357_pmic {
>   	#interrupt-cells = <2>;
>   };
>   
> +/* Needed by MSDC IP */
> +&mt6357_vmc_reg {
> +	regulator-always-on;
> +};
> +
>   &pio {
>   	gpio_keys: gpio-keys-pins {
>   		pins {
> 


