Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539E6642A3E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 15:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbiLEOVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 09:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiLEOVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 09:21:34 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701EB164A4;
        Mon,  5 Dec 2022 06:21:33 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3E50B66015ED;
        Mon,  5 Dec 2022 14:21:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670250092;
        bh=mnxLu/tXcx277n6UaG7yuqLm+MmpmXrgJBPdScyuDDA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RDw8dpdr+DNEFZWeFbg6PD8YW7pwIN5uwEgicztcHkAGwzUjMkT3zC7iUi2PXcaJM
         FsVV5/rzI82+ugszSL8ttpuznBBGC8poRQFdIx4PLrxSV8Ac7H9f2MMoRnFnzYMBUt
         WS14pk25hOh81aNHgn4FBvAP1ErGQ0DnUZO4cyMVXpyCynzJWp5W3wAY767zuq89wj
         15gs30LW3co2cxOZdafHVL2Tj1k+qae9zOgkRr3jhA1hFqXOulKGdS98RzcxnFqGgV
         6KudDZN0KjTvbe1a12U0jZrersbh/FEenrTuVtxgHh0/q7tjSFpo7RORa8ISO2rki1
         IT8+X1EH7tZdw==
Message-ID: <ce449a0c-efcc-0ac1-fb8e-c2b4148a5bc1@collabora.com>
Date:   Mon, 5 Dec 2022 15:21:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 7/9] dt-bindings: spi: mtk-snfi: Add read latch latency
 property
Content-Language: en-US
To:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, benliang.zhao@mediatek.com,
        bin.zhang@mediatek.com
References: <20221205065756.26875-1-xiangsheng.hou@mediatek.com>
 <20221205065756.26875-8-xiangsheng.hou@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221205065756.26875-8-xiangsheng.hou@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 05/12/22 07:57, Xiangsheng Hou ha scritto:
> Add mediatek,rx-latch-latency property which adjust read delay in the
> unit of clock cycle.
> 
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml     | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
> index bab23f1b11fd..6e6ff8d73fcd 100644
> --- a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
> @@ -45,6 +45,13 @@ properties:
>       description: device-tree node of the accompanying ECC engine.
>       $ref: /schemas/types.yaml#/definitions/phandle
>   
> +  mediatek,rx-latch-latency:
> +    description: Rx delay to sample data with this value, the value
> +                 unit is clock cycle.

Can't we use nanoseconds or microseconds as a unit here, instead of clock cycles?

Regards,
Angelo



