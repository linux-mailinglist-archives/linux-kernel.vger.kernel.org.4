Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14156D4151
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjDCJxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjDCJwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:52:46 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59ECC1284D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:52:03 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id eg48so114803972edb.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 02:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680515512;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9nr+uA+ZP2tbdI/0kq6sL0Hql+LVt1wSnJCPSdLceG0=;
        b=Cht9Y2vM9TnL6su8oK8fsrE+NlCl07kvCeH1Ss3sQEfVIz+3oASpya8J2AUWrJpxgM
         SCco5IOUvSki5XMqFCC4gafwpE/N2km04ZRJsINqM4MoK61Z0KdpyV7ITRhLu65xJutg
         BktbY7DuUBSmVmAV1DiTyvagSErGI7E1jJkNyHch88mu8hG5+LmfWFS7W0wDU6iX8Xd7
         jjoiZ2Mz9fTYaT4UfPLDTG2x0ZfE6p3iZJzIkx9/oqavMrZ21qiPc7GkYID+SHdq81lL
         jm0UAAvOfhbRjfUD/kgK0iiBMMKWc2qEJw7CNQuj2S4JYsZ6z0aZ69ArQqmr274p3o54
         lcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680515512;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9nr+uA+ZP2tbdI/0kq6sL0Hql+LVt1wSnJCPSdLceG0=;
        b=XfLRGvLOJi4KGM6ohHLc2yUzIazi+RlDQWbwoPLFxTq7xxlP7hG3VVOh4vB5tZOP2R
         2KGJSRwAduGUXoiDVstvf8LpIxq6EQpwuO7fEq76h7vJutoLFyUq+r33yNJwCDzmmZFt
         CK9GNyKGSC//X9jn92bEFZxo9BZBlVuHdnrPuh8Njo/AjwUxgnzlT3RliDQYkSuM2RJv
         FeUtkK2EBhY4nJICCqi0+d7i6+RCHb+TAB/QjBJ1zF9P1WPZ8bUC7kDeF/3NAnr6mcKI
         xeb8z/mGxuOjPQGcccrH52CRfviWgKIOdyw8oIv0euQBbvVD7Xch0yoTqIWghFG0QH1Z
         /1Eg==
X-Gm-Message-State: AAQBX9eicmZYIgBEbvyVtb9N6zhpVNe8pQnprjqOHEBu79KV3engLIAl
        wD76+r1Y1q3ZhfLk0AQXPGMhbQ==
X-Google-Smtp-Source: AKy350Z7S5nIBg15xObBEMjnFcgoXpWwPfgC871POYyYAMKORNyzeGXP8WOT94M+1eeV1eh2TBj2wA==
X-Received: by 2002:aa7:c587:0:b0:502:9296:a456 with SMTP id g7-20020aa7c587000000b005029296a456mr6634276edq.4.1680515512470;
        Mon, 03 Apr 2023 02:51:52 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ae90:d80:1069:4805? ([2a02:810d:15c0:828:ae90:d80:1069:4805])
        by smtp.gmail.com with ESMTPSA id o1-20020a50c281000000b00502b0b0d75csm314317edf.46.2023.04.03.02.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 02:51:51 -0700 (PDT)
Message-ID: <6c9c74ee-b9ed-815f-dd92-37eb4c8f802a@linaro.org>
Date:   Mon, 3 Apr 2023 11:51:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] phy: mtk-mipi-csi: add driver for CSI phy
Content-Language: en-US
To:     Julien Stephan <jstephan@baylibre.com>
Cc:     Phi-bang Nguyen <pnguyen@baylibre.com>,
        Louis Kuo <louis.kuo@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "moderated list:ARM/Mediatek USB3 PHY DRIVER" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek USB3 PHY DRIVER" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS FOR MEDIATEK" 
        <dri-devel@lists.freedesktop.org>
References: <20230403071929.360911-1-jstephan@baylibre.com>
 <20230403071929.360911-3-jstephan@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230403071929.360911-3-jstephan@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2023 09:19, Julien Stephan wrote:
> From: Phi-bang Nguyen <pnguyen@baylibre.com>
> 
> This is a new driver that supports the MIPI CSI CD-PHY for mediatek
> mt8365 soc
> 
> Signed-off-by: Louis Kuo <louis.kuo@mediatek.com>
> Signed-off-by: Phi-bang Nguyen <pnguyen@baylibre.com>
> [Julien Stephan: use regmap]
> [Julien Stephan: use GENMASK]
> Co-developed-by: Julien Stephan <jstephan@baylibre.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  .../bindings/phy/mediatek,csi-phy.yaml        |   9 +-
>  MAINTAINERS                                   |   1 +
>  drivers/phy/mediatek/Kconfig                  |   8 +
>  drivers/phy/mediatek/Makefile                 |   2 +
>  .../phy/mediatek/phy-mtk-mipi-csi-rx-reg.h    | 435 ++++++++++++++++++
>  drivers/phy/mediatek/phy-mtk-mipi-csi.c       | 392 ++++++++++++++++
>  6 files changed, 845 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/phy/mediatek/phy-mtk-mipi-csi-rx-reg.h
>  create mode 100644 drivers/phy/mediatek/phy-mtk-mipi-csi.c
> 
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,csi-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,csi-phy.yaml
> index c026e43f35fd..ad4ba1d93a68 100644
> --- a/Documentation/devicetree/bindings/phy/mediatek,csi-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/mediatek,csi-phy.yaml

NAK, bindings are always separate patches. It also does not make any
sense - you just added it.

> @@ -33,9 +33,14 @@ additionalProperties: false
>  
>  examples:
>    - |
> -    phy@10011800 {
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      phy@11c10000 {
>          compatible = "mediatek,mt8365-mipi-csi";
> -        reg = <0 0x10011800 0 0x60>;
> +        reg = <0 0x11c10000 0 0x4000>;
>          #phy-cells = <1>;
> +      };
>      };



k_mipi_dphy_of_match[] = {
> +	{.compatible = "mediatek,mt8365-mipi-csi"},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mtk_mipi_dphy_of_match);
> +
> +static struct platform_driver mipi_dphy_pdrv = {
> +	.probe = mtk_mipi_dphy_probe,
> +	.remove = mtk_mipi_dphy_remove,
> +	.driver	= {
> +		.name	= "mtk-mipi-csi",
> +		.of_match_table = of_match_ptr(mtk_mipi_dphy_of_match),

Drop of_match_ptr(). You should see W=1 warnings when compile testing.


Best regards,
Krzysztof

