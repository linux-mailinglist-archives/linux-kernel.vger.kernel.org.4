Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B635E6CDA68
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjC2NSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjC2NSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:18:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6081540D6;
        Wed, 29 Mar 2023 06:17:59 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 356376603175;
        Wed, 29 Mar 2023 14:17:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680095878;
        bh=oKI8cb71HUCIIbcHHSsapFUI42p4qPDafLN/sQSGIA8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PZZkdkh7KJ1k8IsYdXAG4EycxkmcOJxD7pDf1ykJQPuIL4IWcJpTswmusJxfdomBO
         B3rIkD9EmQDzkgO4llKqftlZSJOxeNPv6EVcbnuUuOjScVzV9YnNXyAvKG7ywaUnsE
         qQwXCPm1N+q5/GeZ/ph84kgDL9qq2UWpxm+puviEr11YgFi2jBTBhISeBA3t8Txcpc
         7Oc9JiU+FbpDpUKKPp6s/i5YDRnth/ZkJaJGC2+BB3tQqER31AN3ErW2Muif9ff+Qn
         YY6z+SXL1fa+jGx/2vZ5ZBKeFXId8Np7R/zNxAf9y+uu4abywIxQv0CXHezJvHyzma
         msg0O0RWrPf5Q==
Message-ID: <889be563-78d6-7148-f7d2-09ae21383ee4@collabora.com>
Date:   Wed, 29 Mar 2023 15:17:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 05/17] arm64: dts: mediatek: add mt6357 device-tree
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
 <20230203-evk-board-support-v3-5-0003e80e0095@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230203-evk-board-support-v3-5-0003e80e0095@baylibre.com>
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
> This new device-tree add the regulators, rtc and keys support
> for the MT6357 PMIC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt6357.dtsi | 282 +++++++++++++++++++++++++++++++
>   1 file changed, 282 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt6357.dtsi b/arch/arm64/boot/dts/mediatek/mt6357.dtsi
> new file mode 100644
> index 000000000000..3330a03c2f74
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt6357.dtsi
> @@ -0,0 +1,282 @@

..snip..

> +
> +		keys {
> +			compatible = "mediatek,mt6357-keys";
> +
> +			key-power {
> +				linux,keycodes = <KEY_POWER>;
> +				wakeup-source;
> +			};
> +
> +			key-home {
> +				linux,keycodes = <KEY_HOME>;
> +				wakeup-source;

KEY_HOME is a wakeup-source?! are you sure?!

(P.S.: I'm just checking if that was intended)

Regards,
Angelo
