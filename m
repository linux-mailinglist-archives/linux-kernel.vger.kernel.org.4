Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF3B6480CF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 11:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiLIKTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 05:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiLIKSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 05:18:51 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7DB69306
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 02:18:48 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id c1so6307366lfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 02:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x00HNX5290w6ocB8BzuOCSV57L/qluq8fXghF2f6Urk=;
        b=i3pJ5Zl8a1/s05t+pot30xPJdKFR8X7DbUHQqO2fWpR3NS7IV9xMH7yPs/PvXLeXj1
         YsliKZrWIZ9SHauCdh+2/SMnHGrvhA6Hes4DZesF9nM5hAR3JjyoWQlRX8l8H7Sctiza
         H1oS0rJMvlteo49XLIaiR+pCt8scMj7srITdJDpVyfITifbrTK/gvqpGZoMa9JOVTJvE
         MsYhaoNDvxe/O57eIcZV6GorlescZblOMkiDtCa3cyhCOs4UtA8DdGlxSwT2RDuKcO5v
         0ovORGCdPRLBmwJFViw5nZ6TLWcO5gaoTmR6EfdW22S2Y2UJ0Siww/THZdiuFh72msGx
         Hl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x00HNX5290w6ocB8BzuOCSV57L/qluq8fXghF2f6Urk=;
        b=CsEqZjsTZoTfz1qfLHfVX+hfrVUhbKcIgSIl0F40vKvwHKDE7MCzPA3k3WYxJFSsxY
         uKf+CMcXV4PusvqZ1HwTANNK88b1WAnliZS5gX49eIZBrfalBCxqfT2+PdBOYICe238D
         h1Irgs3clSmbAuqMGXWNM4/+Yo8DdOYKHO3C1kqn1K050fUMzRbYl8eYPRvCxFflG9aT
         zqI2Nk6yvxA1OsKNOe4Qf4HUx7leyNLQfWTwFseuRndq4SL3rcBvqcusFxQbgZgde13h
         6aQwTem0LUUlv9PC7+gRJM5gQLrAInUUWhD7xLB/clXfmqjM2M3VI6xkL629beuYctho
         c3eg==
X-Gm-Message-State: ANoB5pl1YnVJ7dgFjX4Y2c/74+TBQ4bytZ/g3eM6lKb23GXZ8GNxIvGT
        rn4lZDuzExEF1txHRmFoPnU6Uw==
X-Google-Smtp-Source: AA0mqf57GDeyjbTzizTDvwgHZIWKGjktE97SxwOAvab3vKYoBljLv+Jv7y6GOFoRNsx0ysHmTjUQTA==
X-Received: by 2002:a05:6512:224e:b0:4a4:68b8:c2de with SMTP id i14-20020a056512224e00b004a468b8c2demr1789569lfu.53.1670581127329;
        Fri, 09 Dec 2022 02:18:47 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a26-20020a056512201a00b004b5aa1c4d10sm197829lfb.118.2022.12.09.02.18.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 02:18:46 -0800 (PST)
Message-ID: <6350def8-bb1f-8aeb-4c98-4d02a4c59aed@linaro.org>
Date:   Fri, 9 Dec 2022 11:18:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 12/12] dt-bindings: mediatek: mt8188: add mt8188-mt6359
 document
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de
Cc:     angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221208033148.21866-1-trevor.wu@mediatek.com>
 <20221208033148.21866-13-trevor.wu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221208033148.21866-13-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2022 04:31, Trevor Wu wrote:
> Add document for mt8188 board with mt6359.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
>  .../bindings/sound/mt8188-mt6359.yaml         | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mt8188-mt6359.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/mt8188-mt6359.yaml b/Documentation/devicetree/bindings/sound/mt8188-mt6359.yaml
> new file mode 100644
> index 000000000000..eac1c87b693a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mt8188-mt6359.yaml

Missing vendor prefix. You got comments for it already.

> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/mt8188-mt6359.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT8188 ASoC sound card
> +
> +maintainers:
> +  - Trevor Wu <trevor.wu@mediatek.com>
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt8188-mt6359-evb
> +
> +  model:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: User specified audio sound card name
> +
> +  audio-routing:
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    description:
> +      A list of the connections between audio components. Each entry is a
> +      sink/source pair of strings. Valid names could be the input or output
> +      widgets of audio components, power supplies, MicBias of codec and the
> +      software switch.
> +
> +  mediatek,platform:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of MT8188 ASoC platform.
> +
> +  mediatek,dptx-codec:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of MT8188 Display Port Tx codec node.
> +
> +  mediatek,hdmi-codec:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of MT8188 HDMI codec node.

Why you do not use DAI links for all these?

> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - mediatek,platform
> +
> +examples:
> +  - |
> +

Drop blank line.

> +    sound: mt8188-sound {

Drop label, not used. Use generic node names, so just "sound".

> +        compatible = "mediatek,mt8188-mt6359-evb";

Best regards,
Krzysztof

