Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF47370F34D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjEXJpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjEXJpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:45:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BEB93;
        Wed, 24 May 2023 02:45:38 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C396C6602B7B;
        Wed, 24 May 2023 10:45:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684921536;
        bh=NgFF9iqT6kPQvm3wY+PBo4aRBr+03YgdIiWeIRgjHvg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GSrile/9avxzPu7s2ZVGls7W4GSonWmKTja3br+cV7b+vsPa6KjfPvwMlUrbY61X9
         2VPgBLMrffDz9sLs3qX+S9qBd2Aj9Y31n3pMWvFBYQjM6bwW13iVYdaOzOm84dAIAS
         E6OmyJ2NOF2RzWqddsyPxQR5NM8oKf4+55Q+zydG6P3XAnLwErSCBLr8Z1Xcv6lobg
         MU65apKhhv4hAkYYw5p+lvr0hdVmcc0SJLW8ykiu3EsT2Fu/MsQee0F2hpeEPMlKD1
         SYqOZSabLBN4LbX8BVZ7ps4V9XhmjAyKHRkIvd4VlxSLUK3OYx6OSWa4RFKLVZDMlc
         5+ijNFud02dCA==
Message-ID: <2b5e0d60-7084-2039-e6aa-747517eb1977@collabora.com>
Date:   Wed, 24 May 2023 11:45:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 1/3] dt-bindings: phy: add PHY_TYPE_CDPHY definition
Content-Language: en-US
To:     Julien Stephan <jstephan@baylibre.com>
Cc:     mkorpershoek@baylibre.com, khilman@baylibre.com,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
References: <20230524083033.486490-1-jstephan@baylibre.com>
 <20230524083033.486490-2-jstephan@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230524083033.486490-2-jstephan@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/05/23 10:30, Julien Stephan ha scritto:
> Add definition for CDPHY phy type that can be configured in either D-PHY
> mode or C-PHY mode
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   include/dt-bindings/phy/phy.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/dt-bindings/phy/phy.h b/include/dt-bindings/phy/phy.h
> index 6b901b342348..a19d85dbbf16 100644
> --- a/include/dt-bindings/phy/phy.h
> +++ b/include/dt-bindings/phy/phy.h
> @@ -23,5 +23,6 @@
>   #define PHY_TYPE_DPHY		10
>   #define PHY_TYPE_CPHY		11
>   #define PHY_TYPE_USXGMII	12
> +#define PHY_TYPE_CDPHY		13
>   
>   #endif /* _DT_BINDINGS_PHY */

