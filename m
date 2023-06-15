Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F4F731230
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244433AbjFOIcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244467AbjFOIcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:32:12 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AAD172A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:32:08 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9745c5fed21so221953466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686817927; x=1689409927;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eDGmVxB8ASkcq8azv8Ho011acSqd10uZsawAwMEXTTE=;
        b=mDrCFUQW1a+IavKmw8gUmHekrqVIwlFTW2T/5uhutBiENJCG9EN1/sNI1we3RSPXcl
         GYUOQItrKEVF4T3xjM9CcoMuyZ+E9dHHx2Mkdn5O1UCdmabow894FhOOlYhubYdIGllg
         bWl8gqs4ytdJ79kVKIgXPEHxVrBkC+lqd2CcWABMOHZmqEgqQ9keqtYIo2jC3jHhcc5v
         XNGaPyvm9jLOJvlOWV1ljSUHcGZJBkNC9jiW2xr8cq6HJLFBG7rm40f7iSRe6OZ3UQPZ
         vMSvI55TPe3HtdtF2ncnVC0JVhU+ZXoS/Vhwy2F4/L4o89ik7a9sEtvLGDdN5WRZbuF+
         YBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686817927; x=1689409927;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eDGmVxB8ASkcq8azv8Ho011acSqd10uZsawAwMEXTTE=;
        b=lkVx9MRJhnlldTlrrVlY4HMtsUWAYQV6SovgzXT5qUpRKmZiawE4RvwakxcNl4Ljzk
         ZV4QfABzxUEWoHbBgkYQDTCo7Sng9WN0aERl9VRGuuxytFOSRYXyssd+JJO/zNQ5jYld
         cImZKElE0EZU/Lp8kcv+6RlcDvvLE6yjHJCUKnyffhQttsFMMsWj2Dw4ee7XJaEphe+/
         5o97aS8cI29tEPxujDJ0zLdEP/OW6w2ctVL+2b8P7Grhg8SiLfmDvf8dxDk/304HMhj2
         xSTAnrx19wZF89xGyOTU9qHo8Y2G3I+K7HXtlollp7cZ1RsD1w4uVWyYLuVKEFNdm5rV
         3fkA==
X-Gm-Message-State: AC+VfDxydRMdr3koHGLXHhG2x+kMDSiriNKwcKUDVRiUR2fBmtV3EkwT
        RggpXYY0mjYw1eVlfqiXqXPTSQ==
X-Google-Smtp-Source: ACHHUZ4CnizjcMXS8vu1oEAcv4W+CtwoOpFPcgzhdSqsZp0IDi7udHa8ciqtKXNib3pXkplHYbDnNA==
X-Received: by 2002:a17:906:9b92:b0:973:e349:43c9 with SMTP id dd18-20020a1709069b9200b00973e34943c9mr17034760ejc.77.1686817926723;
        Thu, 15 Jun 2023 01:32:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id d18-20020a170906371200b0098282bb8effsm1446763ejc.196.2023.06.15.01.32.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 01:32:06 -0700 (PDT)
Message-ID: <e720dd96-c77e-6914-873c-6e5b6b5c1ca7@linaro.org>
Date:   Thu, 15 Jun 2023 10:32:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 04/15] dt-bindings: display: mediatek: padding: Add
 documentation for MT8188
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
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
 <20230614073125.17958-5-shawn.sung@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230614073125.17958-5-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2023 09:31, Hsiao Chien Sung wrote:
> PADDING is a new hardware module on MediaTek MT8188,
> Add device tree bindings documentation for it.
> 

A nit, subject: drop second/last, redundant "documentation for". The
"dt-bindings" prefix is already stating that these are bindings and
documentation.

> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>  .../display/mediatek/mediatek,padding.yaml    | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,padding.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,padding.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,padding.yaml
> new file mode 100644
> index 000000000000..390a518fa2cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,padding.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/mediatek/mediatek,padding.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek PADDING

MediaTek Foo Bar Padding

Please explain what is this. PADDING does not look like acronym. If it
is, expand it.

> +
> +maintainers:
> +  - Chun-Kuang Hu <chunkuang.hu@kernel.org>
> +  - Philipp Zabel <p.zabel@pengutronix.de>
> +
> +description:
> +  MediaTek PADDING provides ability to VDOSYS1 to add pixels to width and height

Expand the acronym.

> +  of a layer with a specified color.
> +  Since MIXER in VDOSYS1 requires the width of a layer to be 2-pixel-align, or
> +  4-pixel-align when ETHDR is enabled, we need PADDING to deal with odd width.
> +  Please notice that even if the PADDING is in bypass mode, settings in the
> +  registers must be cleared to 0, or undefined behaviors could happen.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt8188-padding
> +
> +  reg:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: RDMA Clock
> +
> +  mediatek,gce-client-reg:
> +    description:
> +      GCE (Global Command Engine) is a multi-core micro processor that helps
> +      its clients to execute commands without interrupting CPU. This property
> +      describes GCE client's information that is composed by 4 fields.
> +      1. pHandle of the GCE (there may be several GCE processors)
> +      2. Sub-system ID defined in the dt-binding like a user ID
> +         (Please refer to include/dt-bindings/gce/<chip>-gce.h)
> +      3. Offset from base address of the subsys you are at
> +      4. Size of the register the client needs
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      items:
> +        - description: pHandle of the GCE

Phandle (if first in sentence) or phandle. It's not a pH unit. Fix it in
other places as well.


> +        - description: Subsys ID defined in the dt-binding
> +        - description: Offset from base address of the subsys
> +        - description: Size of register


Best regards,
Krzysztof

