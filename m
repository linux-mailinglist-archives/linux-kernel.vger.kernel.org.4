Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB3160C949
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbiJYKCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiJYKB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:01:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C68A44554;
        Tue, 25 Oct 2022 02:54:47 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 80C206600011;
        Tue, 25 Oct 2022 10:54:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666691686;
        bh=1q4rZfObRZxO8+JHR7vaDLdjMed/BUEslgXYYLFJykc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hm8OPB+RilErmyhlGdxknvLlSohESk35wtrkkQOALlxFYD20WUCcfVZZ9C++ZvaN9
         6tmUBRnDhdDqy1mZW9napuSWZ4ZbOBSFcG3TzFIb/FsY8tlJsgJRjy6wZxY4VLN86+
         Mn2oxMBaryRVJK/Ioyf2I859SLpYqNwCrt51d6wg4KxevvcIDNVZJoiOs5P5MerB5P
         ozZCc202zdiGCF5MzCHO+j8tnWx31gbqZe/epuk58LIVH4pExX6++UF1fb71BpOODx
         1/GukLWmSm+6S77XUYAzTPlXv+GZ3jnqyMHZrsukDhrqtj6JEyP8kPJ4Cxd4tV8moC
         TgnA0QmTjHnzg==
Message-ID: <2a771db2-5570-73a4-e16e-3bfa29deb8f8@collabora.com>
Date:   Tue, 25 Oct 2022 11:54:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 1/3] dt-bindings: soc: mediatek: pwrap: add MT8365 SoC
 bindings
Content-Language: en-US
To:     Fadwa CHIBY <fchiby@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        "Zhiyong . Tao" <zhiyong.tao@mediatek.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Sen Chu <sen.chu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20221024131544.31219-1-fchiby@baylibre.com>
 <20221024131544.31219-2-fchiby@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221024131544.31219-2-fchiby@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/10/22 15:15, Fadwa CHIBY ha scritto:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add pwrap binding documentation for
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Fadwa CHIBY <fchiby@baylibre.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>   Documentation/devicetree/bindings/soc/mediatek/pwrap.txt | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> index d24e2bc444be..8424b93c432e 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> +++ b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> @@ -30,6 +30,7 @@ Required properties in pwrap device node.
>   	"mediatek,mt8186-pwrap" for MT8186 SoCs
>   	"mediatek,mt8188-pwrap", "mediatek,mt8195-pwrap" for MT8188 SoCs
>   	"mediatek,mt8195-pwrap" for MT8195 SoCs
> +	"mediatek,mt8365-pwrap" for MT8365 SoCs
>   	"mediatek,mt8516-pwrap" for MT8516 SoCs
>   - interrupts: IRQ for pwrap in SOC
>   - reg-names: "pwrap" is required; "pwrap-bridge" is optional.
> @@ -39,6 +40,8 @@ Required properties in pwrap device node.
>   - clock-names: Must include the following entries:
>     "spi": SPI bus clock
>     "wrap": Main module clock
> +  "sys": System module clock (for MT8365 SoC)

"sys": Optional system module clock
"tmr": Optional timer module clock

....as it's not granted that MT8365 is and will always be the only user.

Cheers,
Angelo

> +  "tmr": Timer module clock (for MT8365 SoC)
>   - clocks: Must contain an entry for each entry in clock-names.
>   
>   Optional properities:
