Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE4C6A3E72
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjB0JeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjB0JeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:34:02 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3804C9EF7;
        Mon, 27 Feb 2023 01:34:01 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 75C83660230B;
        Mon, 27 Feb 2023 09:33:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677490440;
        bh=6bITMM3X7ops1Eqv9YJjvYqu6g9ES8OyVqIhPepYAyY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=A5tSYQzqp1GDoBnUX1PXYd9QDAOAx/1ctN2hVVeFbNZQ7XU//LUFDfVrUdQpfzWLP
         BZUT63p1GPQg44HZ/KLQhM857gs2jBn3uQVnmAieczl1Fk1oE7gvucRUha8eYdruIW
         dwHiLVnf0Kz+FL+KMFUa7k3+7uPuN+DAfytbrmNYVujgfD75jGjjQvIviK+xQK8TZw
         qH4fFVrVPgJx9GbPB1SqkhcOm6WOPqLsqA5FBlTOKsFn1WF5gbwp7p/nVUMzRBApzV
         WycZmIoR1Ht7VCiEUawY1lx/WQFgzAWW5d0y2679zL8J/wCEXhXDSxGGrx2U+G1aEe
         z1eQI5UkkpcLg==
Message-ID: <d7f02983-121d-b2f6-c208-9b55d7150c80@collabora.com>
Date:   Mon, 27 Feb 2023 10:33:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/3] dt-bindings: soc: mediatek: scpsys: Document MT6735
 SCPSYS compatible string
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230225101629.264206-1-y.oudjana@protonmail.com>
 <20230225101629.264206-3-y.oudjana@protonmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230225101629.264206-3-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/02/23 11:16, Yassine Oudjana ha scritto:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add a compatible string for MT6735 SCPSYS.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>   Documentation/devicetree/bindings/soc/mediatek/scpsys.txt | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> index 2bc367793aec..54ba2e06403a 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> +++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> @@ -10,6 +10,7 @@ domain control.
>   The driver implements the Generic PM domain bindings described in
>   power/power-domain.yaml. It provides the power domains defined in
>   - include/dt-bindings/power/mt8173-power.h
> +- include/dt-bindings/power/mediatek,mt6735-scpsys.h
>   - include/dt-bindings/power/mt6797-power.h
>   - include/dt-bindings/power/mt6765-power.h
>   - include/dt-bindings/power/mt2701-power.h
> @@ -20,6 +21,7 @@ Required properties:
>   - compatible: Should be one of:
>   	- "mediatek,mt2701-scpsys"
>   	- "mediatek,mt2712-scpsys"
> +	- "mediatek,mt6735-scpsys"

NACK. Please implement in mtk-pm-domains instead.

>   	- "mediatek,mt6765-scpsys"
>   	- "mediatek,mt6797-scpsys"
>   	- "mediatek,mt7622-scpsys"

