Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1304870475E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjEPIHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjEPIHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:07:52 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131563C12
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:07:51 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96aae59bbd6so889411166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684224469; x=1686816469;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BGVHVtrJ1UKArOxL4QLZMf28fxPQFEoR2CUGleXHsCE=;
        b=JYKeiv25q8zcMTfIUxyjYba4uvXfSoqkHDtJ77yG0ETwlKFEKJjqoelz9b636iC43q
         NwEMGuL3OUF3SzHNkliudf9CiKYc6qoMpeWTKyembWNoR5IqXIwHlNiQI/Awpc3OhoJO
         zCZW6yrcE+nJ9fRDAxpuiEHuKdTaSIFd2AV//rWLqyTKlckm1sCblj2Z1pSieKU3zPOD
         iGT+3eB1+IgAlVjDXoSKiSeBb4xpMSUtOX/nWUY6QNb6u/8/0/UHnmQKMnon8fKW2sRl
         f04iL/5jEudZbK48jxYkajqRY1IfgMD+bUg21v3KlV2XH4+TsSACN7BmBDahKz8ZRdW/
         hKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684224469; x=1686816469;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGVHVtrJ1UKArOxL4QLZMf28fxPQFEoR2CUGleXHsCE=;
        b=dbeq9WxJlBFN4RY1J4ftkk3ffKFdiZIfmSH9f/f1Nl3ixxh46dmqxtJxCpOKTkG5oy
         FNIzwo8gb0uCGa53CpznTxL8xl9ieI3EwpFDZzIOPaXAqedvXXH/LUXbUye3iqvLYixz
         nDgEBKZ8GfZgnwPdqQlot5ice87Q82GxkuqV6EOjfDrYGZ0qJANPWwDWQo4eEVdYcHg4
         482k8aa23TTVc/qVqPjZNt/JlcYwsSvbbWs62z1R3/Uqu7B2ytbc0KrKYEBKWrBYPXZb
         zcDwDjBjJEAtfexb7C9jyyOG3V2jQIyrTfD1yoenwSYGAr8m8dNcUWSxTUxJcBlPp96I
         pLmA==
X-Gm-Message-State: AC+VfDyoBOaww1F/hJPnIEiiWYgvZvtvuQ+66/P3x/0ggYZfSqaBG3Pv
        T2XhsjrkemTSjWVHwl2I+6ZGaA==
X-Google-Smtp-Source: ACHHUZ4yMXV4Sz3Qo41nq8QUnvqctZ1ziGdHs/WBNjiVR1F3sVaDjIntrsJJsddU6GfMFbs1vxI0IQ==
X-Received: by 2002:a17:907:360d:b0:94a:7979:41f5 with SMTP id bk13-20020a170907360d00b0094a797941f5mr30753341ejc.71.1684224469553;
        Tue, 16 May 2023 01:07:49 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:4d4a:9b97:62e:1439? ([2a02:810d:15c0:828:4d4a:9b97:62e:1439])
        by smtp.gmail.com with ESMTPSA id i8-20020a056402054800b0050bd59fd0efsm7767851edx.49.2023.05.16.01.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 01:07:49 -0700 (PDT)
Message-ID: <ab9aa30f-82d7-1d14-5561-e19ff10af0b0@linaro.org>
Date:   Tue, 16 May 2023 10:07:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: add mediatek mipi csi driver v
 0.5
Content-Language: en-US
To:     Julien Stephan <jstephan@baylibre.com>
Cc:     robh@kernel.org, chunkuang.hu@kernel.org,
        linux-mediatek@lists.infradead.org,
        Florian Sylvestre <fsylvestre@baylibre.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "moderated list:ARM/Mediatek USB3 PHY DRIVER" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230515090551.1251389-1-jstephan@baylibre.com>
 <20230515090551.1251389-2-jstephan@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230515090551.1251389-2-jstephan@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 11:05, Julien Stephan wrote:
> From: Florian Sylvestre <fsylvestre@baylibre.com>
> 
> This adds the bindings, for the MIPI CD-PHY module v 0.5 embedded in
> some Mediatek soc, such as the mt8365
> 
> Signed-off-by: Florian Sylvestre <fsylvestre@baylibre.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>

What are the changes? IOW: changelog here or in cover letter.

Subject: you have some multiple spaces.

Subject: drop driver. Bindings are not for drivers.

> ---
>  .../phy/mediatek,phy-mipi-csi-0-5.yaml        | 62 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/mediatek,phy-mipi-csi-0-5.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,phy-mipi-csi-0-5.yaml b/Documentation/devicetree/bindings/phy/mediatek,phy-mipi-csi-0-5.yaml
> new file mode 100644
> index 000000000000..5aa8c0b41cdf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/mediatek,phy-mipi-csi-0-5.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-Only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/mediatek,phy-mipi-csi-0-5.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek Sensor Interface MIPI CSI CD-PHY
> +
> +maintainers:
> +  - Julien Stephan <jstephan@baylibre.com>
> +  - Andy Hsieh <andy.hsieh@mediatek.com>
> +
> +description:
> +  The SENINF CD-PHY is a set of CD-PHY connected to the SENINF CSI-2
> +  receivers. The number of PHYs depends on the SoC model.
> +  Depending on the soc model, each PHYs can support CDPHY or DPHY only
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,phy-mipi-csi-0-5

SoC based compatibles. 0-5 is odd.

> +
> +  reg:
> +    maxItems: 1
> +
> +  '#phy-cells':
> +    const: 0
> +
> +  mediatek,is_cdphy:

No underscores in node names.

> +    description:
> +      Specify if the current phy support CDPHY configuration

Why this cannot be implied from compatible? Add specific compatibles.


> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#phy-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      mipi_rx_csi0: mipi_rx_csi0@11c10000 {

No underscores in node names. How this is v2?

> +        compatible = "mediatek,phy-mipi-csi-0-5";
> +        reg = <0 0x11C10000 0 0x2000>;
> +        status = "okay";

Drop

> +        mediatek,is_cdphy;
> +        #phy-cells = <0>;
> +      };
> +
> +      mipi_rx_csi1: mipi-rx-csi1@11c12000 {
> +        compatible = "mediatek,phy-mipi-csi-0-5";
> +        reg = <0 0x11C12000 0 0x2000>;
> +        status = "disabled";

???


Best regards,
Krzysztof

