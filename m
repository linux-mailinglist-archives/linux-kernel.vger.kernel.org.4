Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CD872FD24
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbjFNLlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235690AbjFNLlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:41:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADECD1BF7;
        Wed, 14 Jun 2023 04:41:24 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AFC1A6606F13;
        Wed, 14 Jun 2023 12:41:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686742883;
        bh=dUugWV7IWoeoJZsSQONhbTYmpA4aJFlKz1F7SU/YV/w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YmC6Y4ASwH/8zTV/2jFEztyB8i0369EVylifkxoCZcxgvHVAlLSwNQp1CCMVuqIWP
         glHaOy9CbVkoqgz346MrgeP6ejKaznvkJDG4xOp8EGYHY6oDRQT8irtLexRlxfCLUG
         tlkLS3CllVdoJzBgPzrRZF7dLf6V6Po4I8aKxtBTasa2cZOd8l9OCD2uvGrCDGlBKX
         o9z8cHVJq09kfHAqkltNZLlZhgVkZ+DtXXyBS+W2+aDIHJLZEtxIBt8awpck/l49/b
         aPaEHpf767vh6UXpNcsKRgk2OxGUZFjnlShO7W9+9bBhc3oQX7mTXI0r14kK6ENaEa
         AeVzFlIhTgvrg==
Message-ID: <1f044902-0726-34ed-3eea-7224e5750e22@collabora.com>
Date:   Wed, 14 Jun 2023 13:41:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 01/15] dt-bindings: display: mediatek: ethdr: Add
 compatible for MT8188
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>
References: <20230614073125.17958-1-shawn.sung@mediatek.com>
 <20230614073125.17958-2-shawn.sung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230614073125.17958-2-shawn.sung@mediatek.com>
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

Il 14/06/23 09:31, Hsiao Chien Sung ha scritto:
> Add compatible name for MediaTek MT8188 ETHDR.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>   .../bindings/display/mediatek/mediatek,ethdr.yaml           | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml
> index 801fa66ae615..677882348ede 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml
> @@ -23,7 +23,11 @@ description:
> 
>   properties:
>     compatible:
> -    const: mediatek,mt8195-disp-ethdr
> +    oneOf:
> +      - const: mediatek,mt8195-disp-ethdr
> +      - items:
> +          - const: mediatek,mt8188-disp-ethdr
> +          - const: mediatek,mt8195-disp-ethdr
> 

Is MT8188's ETHDR fully compatible with MT8195's ETHDR?

If it is, you're not adding a mt8188 specific compatible string in the driver and
this means that the devicetree will look like:

	compatible = "mediatek,mt8195-disp-ethdr", "mediatek,mt8188-disp-ethdr"

...so the proposed doc change works.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

>     reg:
>       maxItems: 7
> --
> 2.18.0
> 


