Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B73D6D4142
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjDCJvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbjDCJu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:50:59 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDE412CD3
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:50:01 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id t10so114708577edd.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 02:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680515399;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=njOb8FD8MR7p9DAF345Hq+aO222nfpoaV4wgzEQORsE=;
        b=WSssOdY3Y7QQMxZhOv5ODIMftu2oa1cARN3R7zrYwN6qDd6mcfPp0HUo/WyzzybZlN
         3qwP+204tyHqCd89ElO0Un0gBC2UIThCIsdF8Wh/CBy8virxgKXDJtFh1XborA+iWUVN
         N+k+CKu0zYPFcAkS+mnT2g9RVJMtq7eNyt79cJLa8P4RS1PxHLGb/b7N1pBhEeKbG1Qm
         LGpaI5X9aSyIR2xYFIwwx9XQ4Gj6fpkg2+cHarWPeBftyNzNpFft3vIc7cCjppZFNv/p
         3/6LW4Lb4OWiTvgVMYFxPbkeOohPQ5OSTAM32IKGLEYhEID6mAHSm4CilJTNYK3Svc6b
         RrnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680515399;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=njOb8FD8MR7p9DAF345Hq+aO222nfpoaV4wgzEQORsE=;
        b=6n4nJifu906z0ZYPdJ9k6zkLmFFpYWh2qsUx+bvxJZ/6zl5ivfAvm8OnVbewmF7PL6
         koSQa7l99aKH16vCD0VVxZIZqLrxP4Fy1cMKe5YMebBOsQtWz4mO/Y/P5tf4yAixSuiE
         muOmDH5+2Lyp1DJ2OtgS1akLvwpRBzAZXkrwa64mOuOIO9JLNzZCLUzgtDqmZ42kHYh9
         VrLpJouHUm3uyjgjbGkMFJv6cRQX2eEidl/v/k/+/DTMRKxXowC2fUukw/wwI3ikPabb
         5iZeLL/PE2fs/OLeWCClcBRSe78KloUpLBxG21d1Rk0SJJ7c9u4OjUkBdJMi8vE7Ho4k
         qkag==
X-Gm-Message-State: AAQBX9do3PftOyPLDLbFMyMUY9WFYK7nu3PBh518wGVep+VOlpQybEn4
        CwI7p27LEKWJ4bWTBRjZJuK3Kg==
X-Google-Smtp-Source: AKy350axDXzqltQsMGrbEq+s6HAPPXokx38cO/zKLAuZvJShm+5OuEGsdQduEWPjjJl9tW5ESCenGg==
X-Received: by 2002:a17:907:7f0d:b0:946:fa88:5901 with SMTP id qf13-20020a1709077f0d00b00946fa885901mr19111746ejc.63.1680515399082;
        Mon, 03 Apr 2023 02:49:59 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ae90:d80:1069:4805? ([2a02:810d:15c0:828:ae90:d80:1069:4805])
        by smtp.gmail.com with ESMTPSA id hz15-20020a1709072cef00b0093ebc654f78sm4290447ejc.25.2023.04.03.02.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 02:49:58 -0700 (PDT)
Message-ID: <4837c3e0-60ed-601b-8512-30fda2176619@linaro.org>
Date:   Mon, 3 Apr 2023 11:49:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: phy: add mtk-mipi-csi driver
Content-Language: en-US
To:     Julien Stephan <jstephan@baylibre.com>
Cc:     Florian Sylvestre <fsylvestre@baylibre.com>,
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
        "moderated list:ARM/Mediatek USB3 PHY DRIVER" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230403071929.360911-1-jstephan@baylibre.com>
 <20230403071929.360911-2-jstephan@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230403071929.360911-2-jstephan@baylibre.com>
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
> From: Florian Sylvestre <fsylvestre@baylibre.com>
> 

There is no commit msg.

> Signed-off-by: Florian Sylvestre <fsylvestre@baylibre.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  .../bindings/phy/mediatek,csi-phy.yaml        | 41 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/mediatek,csi-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,csi-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,csi-phy.yaml
> new file mode 100644
> index 000000000000..c026e43f35fd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/mediatek,csi-phy.yaml

Filename like compatible.

> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-Only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/mediatek,csi-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek Sensor Interface MIPI CSI CD-PHY
> +
> +maintainers:
> +  - Julien Stephan <jstephan@baylibre.com>
> +  - Andy Hsieh <andy.hsieh@mediatek.com>
> +
> +description: |

Do not need '|'.

> +  The SENINF CD-PHY is a set of CD-PHY connected to the SENINF CSI-2
> +  receivers. The number of PHYs depends on the SoC model.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt8365-mipi-csi
> +
> +  reg:
> +    minItems: 1

maxItems instead
(from where did you get such example?)

> +
> +  '#phy-cells':
> +    const: 1
> +


Best regards,
Krzysztof

