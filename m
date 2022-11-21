Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18318632441
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiKUNtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiKUNtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:49:03 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B05624B;
        Mon, 21 Nov 2022 05:49:03 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 219306600371;
        Mon, 21 Nov 2022 13:49:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669038541;
        bh=AeKWzGXHbjRKpMaS+ztWcfZ+DeI78CJ083tMt3FLtes=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bvComeICZ+p7rb1lgdPClfoyO/gA+D0VTz/zn47MaRosJ+vsGqguHKWSYUZZXlp+4
         ApbqaD01wloyg1n/LrsQ8BRaImqS0tFmCnBDVPb5DG+4fQdRQsZE0NwabIqlUxiqJA
         6dbt0E6jgQkxX1i+Upu+iKAWrvod1wn4ljKNv8Rv2whVNckIJFFrgOCpEsccQDpFSJ
         u06xUkNp0QYwa7+gXDXhxsEtE6lMTAZVStCXqz38UpUYTMJTtnR+CwdPLa/qsUFl0R
         jN8Ek/4YiZNsFcb58074RKzFx3sAbpZH0Gt2J4qNwywvaz2OvCWr/LbatB4/LTGRAC
         545gIjRkAST9A==
Message-ID: <1d27a496-b49c-94d5-e9e6-68c81195a69a@collabora.com>
Date:   Mon, 21 Nov 2022 14:48:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 6/7] dt-bindings: pinctrl: mediatek,mt6779-pinctrl:
 Document MT6735 pin controller
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
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <20221118113028.145348-1-y.oudjana@protonmail.com>
 <20221118113028.145348-7-y.oudjana@protonmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221118113028.145348-7-y.oudjana@protonmail.com>
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

Il 18/11/22 12:30, Yassine Oudjana ha scritto:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add bindings for the pin controller found on MediaTek MT6735 and
> MT6735M SoCs, including describing a method to manually specify
> a pin and function in the pinmux property making defining bindings
> for each pin/function combination unnecessary. The pin controllers
> on those SoCs are generally identical, with the only difference
> being the lack of MSDC2 pins (198-203) on MT6735M.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>   .../pinctrl/mediatek,mt6779-pinctrl.yaml      | 55 ++++++++++++++++++-
>   MAINTAINERS                                   |  6 ++
>   2 files changed, 60 insertions(+), 1 deletion(-)
> 

..snip..

> @@ -352,18 +391,32 @@ examples:
>               };
>   
>               /* GPIO0 set as multifunction GPIO0 */
> -            gpio-pins {
> +            gpio0-pins {
>                   pins {
>                       pinmux = <PINMUX_GPIO0__FUNC_GPIO0>;
>                   };
>               };
>   
> +            /* GPIO1 set to function 0 (GPIO) */
> +            gpio1-pins {
> +                pins {
> +                    pinmux = <(MTK_PIN_NO(1) | 0)>;

Please follow the same format that you can find in all of the
mtXXXX-pinfunc.h.

What you wrote here (MTK_PIN_NO(x) | func) is defined in there for the purpose
of providing a definition name that actually means something (for both readability
and documentation purposes).

This means that your GPIO1 set to function 0 (gpio) should be

			pinmux = <PINMUX_GPIO1__FUNC_GPIO1>;

> +                };
> +            };
> +
>               /* GPIO52 set as multifunction SDA0 */
>               i2c0-pins {
>                   pins {
>                     pinmux = <PINMUX_GPIO52__FUNC_SDA0>;
>                   };
>               };
> +
> +            /* GPIO62 set to function 1 (primary function) */
> +            i2c1-pins {
> +                pins {
> +                    pinmux = <(MTK_PIN_NO(62) | 1)>;

pinmux = <PINMUX_GPIO62__FUNC_SDA1>; (is it sda1??)

This means that you should as well add a mediatek,mt6735-pinfunc.h binding...

Regards,
Angelo


