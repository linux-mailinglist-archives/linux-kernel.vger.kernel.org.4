Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFBC747EFD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbjGEIHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGEIHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:07:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FF5133;
        Wed,  5 Jul 2023 01:07:02 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0D8066606FAA;
        Wed,  5 Jul 2023 09:07:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688544421;
        bh=wMIKtLWmpmEk0JFOIuuWIoQ/SSS33L2o6nCQXzsNE/8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=c6MQQP04ioq4F48xkOrOY+vudDg5jja/t8+Z5fiKf1Q/214F84m37Nd0PeKNSmeKD
         YEa5J11zjHOrSep+OGX9yvgP3ZSje+9GpeYwqRtNFPG+rGQP4bicVV3m6VwLC0J/p6
         iHm41/NLdq3jmQCA7RurRfypVbWRvH1r+Q5Hsk78iYfh2aiQbjeWkyNMD4L3SJEvDu
         xMLhDyo0nDvBn54dmAuD+siAI0XJcQcysPcQ+hYDYu2IJmKnvD7JJG5AMPgpSTzMPI
         goM8xhWJyrn6qVkr+DL7+F12e3eknEGduUmsRBz1+zE8KWCcqj9o8MKGDOsBvuW1YE
         1Mmg7fRzbqyGg==
Message-ID: <7e4a3d1e-ae48-77b6-fe24-0a165c137fbb@collabora.com>
Date:   Wed, 5 Jul 2023 10:06:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/3] dt-bindings: arm: mediatek: Add mt8188 pericfg
 compatible
Content-Language: en-US
To:     Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230705065744.25848-1-jason-ch.chen@mediatek.com>
 <20230705065744.25848-3-jason-ch.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230705065744.25848-3-jason-ch.chen@mediatek.com>
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

Il 05/07/23 08:57, Jason-ch Chen ha scritto:
> From: jason-ch chen <Jason-ch.Chen@mediatek.com>
> 
> Add mt8188 pericfg compatible to binding document.
> 
> Signed-off-by: jason-ch chen <Jason-ch.Chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   .../devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml       | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
> index 26158d0d72f3..33c94c491828 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
> @@ -28,6 +28,7 @@ properties:
>                 - mediatek,mt8173-pericfg
>                 - mediatek,mt8183-pericfg
>                 - mediatek,mt8186-pericfg
> +              - mediatek,mt8188-pericfg
>                 - mediatek,mt8195-pericfg
>                 - mediatek,mt8516-pericfg
>             - const: syscon


