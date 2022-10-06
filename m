Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB15A5F6373
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiJFJQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiJFJQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:16:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D8C9835D;
        Thu,  6 Oct 2022 02:16:09 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ADB3566022F9;
        Thu,  6 Oct 2022 10:16:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665047768;
        bh=GDGLsYsj0D/nebPVYIooIdcVZbO93mCgP/BtLTyCxqo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ISYCMpZUlkUQQHPE6fJGNrMrqTWoUe8kPaqYs/+I+MBK3dVUI0emcqqogWe1BmQUZ
         3BWV/hDTLBd9Zf94zq8ZR1wrRAixEorbnKgojILa7Xqb/SlZx+eebxWO05l/qT0Gic
         vjZG+dzOb0tX0JnVQuAPtNkwiDFId7UeDrvV/081dHdub00+mQgJkYSWCEK5B780C9
         24B71rgmUrOwUwB2HzpvJVlfW+zZwi8eYYqXkOZo+T3ltRA9DvsY4rC56N+7AlG7mp
         cYZFaqrL6fWcfb8orl6492aUztpC5VIquLhofLFUc1Q+wtEUe3OA0V8BtpgZmR3uhg
         4HoaTcSf9RgiQ==
Message-ID: <b1140018-8787-4365-14ab-16d21716a162@collabora.com>
Date:   Thu, 6 Oct 2022 11:16:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 01/10] arm64: dts: mediatek: mt6779: Remove syscon
 compatible from pin controller
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221005174343.24240-1-y.oudjana@protonmail.com>
 <20221005174343.24240-2-y.oudjana@protonmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221005174343.24240-2-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 05/10/22 19:43, Yassine Oudjana ha scritto:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Remove syscon compatible string from pin controller to follow
> DT bindings and pass checks. Adding the syscon compatible to
> the DT bindings documentation instead causes a different check
> error due to the syscon document specifying a maximum of 1 item
> in the reg property, while this has 9.

Please change this part of the description...

> Nothing is using the pin
> controller as a syscon at the moment so it should be a safe
> thing to do.

...to:

This pin controller has never been, and will never be, used as a
syscon, hence it is safe to drop this compatible.

After which, you get my

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt6779.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt6779.dtsi b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
> index 9bdf5145966c..a6fa5212da4e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6779.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
> @@ -160,7 +160,7 @@ infracfg_ao: clock-controller@10001000 {
>   		};
>   
>   		pio: pinctrl@10005000 {
> -			compatible = "mediatek,mt6779-pinctrl", "syscon";
> +			compatible = "mediatek,mt6779-pinctrl";
>   			reg = <0 0x10005000 0 0x1000>,
>   			      <0 0x11c20000 0 0x1000>,
>   			      <0 0x11d10000 0 0x1000>,

