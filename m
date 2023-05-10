Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA566FE0CF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237355AbjEJOvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237281AbjEJOvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:51:04 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D372729D
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:51:03 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-965a68abfd4so1379143966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683730261; x=1686322261;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=634QqYCO4e6YYkg9HogXcpMtMk+Nqei671dupMxD3uU=;
        b=CpQE9gcU+nOsxso1W8WnW0sBuBszcV5bm98RKhg3mQCCf8eXyc1+M76/bUNrX25MV1
         mjGgjoZTxLCRLZpAcfxGDlG09OjkVFfMol0RuQDpQ+Vp8xfepP78up43AQf0dcSclvlh
         GZUIiB7z6nN2khwM7CX99SSDulayzIfoJrg9KuwnykbzZhjxMUnu8bvlzlZLAGM5Jgv4
         AOK1Hy4hWfgUg0gl8PivfB1Ppx6naSp3dR00UIoNLHptCJVF2MrDvRMf8KPC9bq+aeiT
         pbqaw7h5G4bWYzyuVSyXhGe6yJQZ7LVucbo0VWwcOM/ftnJfg59X7pgDQvaFhQD20kuJ
         Huaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683730261; x=1686322261;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=634QqYCO4e6YYkg9HogXcpMtMk+Nqei671dupMxD3uU=;
        b=LonyBkEN+iJCVEmrEL05/MsKOL3o5YxHxpnA3Qy/22BZmMnntGYhJZ99SQ0uCLYIaF
         3ry4/R7ebIFfTvBLcWHQ/AWw/5mYQ3bct6oeJJRlbm9/loSeQYTObwtKFEjMT7Qci4c8
         OXyTVqFUtRNZWgT6CyUxeR0O5KAEp7HVPs7JrRj0MQtL2aHHHz3wxXyXOgY7bZKlcAiI
         6fo3a2pNnWdPeF2ajoUl557YqsgVq6qhNLUAv8XHLEf99icZGLMpfZv3FbUQAg5EGuxA
         4sw0pR1EvsI4OWyx+oZ1KvFBedaWGkcHUl0NtAuFGqqdN0BbkoK6MVcM+eC0hU2ozUzg
         WANQ==
X-Gm-Message-State: AC+VfDzZ0jOE2bSDWC+Nyz+VOuDtK8Tarnvp02jeex0uS8aCunCkj705
        sXfApnBGZWnq6RmG/VoKOvgNWw==
X-Google-Smtp-Source: ACHHUZ57l5b3kNlo9y2XGG6tHhsx/v2ViJ/oCrgPAj474IZCIVQl7t5hfSOajPXOPXUzUmyQERnmkA==
X-Received: by 2002:a17:907:3686:b0:94a:56ec:7f12 with SMTP id bi6-20020a170907368600b0094a56ec7f12mr16731180ejc.30.1683730261473;
        Wed, 10 May 2023 07:51:01 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c175:a0f9:6928:8c9d? ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id l19-20020a170906939300b0094e7d196aa4sm2709662ejx.160.2023.05.10.07.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 07:51:00 -0700 (PDT)
Message-ID: <ec0a3553-2c11-301e-d838-f0bc70353b17@linaro.org>
Date:   Wed, 10 May 2023 16:50:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 5/5] dt-bindings: net: ftgmac100: convert to yaml
 version from txt
Content-Language: en-US
To:     Ivan Mikhaylov <fr0st61te@gmail.com>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
References: <20230509143504.30382-1-fr0st61te@gmail.com>
 <20230509143504.30382-6-fr0st61te@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230509143504.30382-6-fr0st61te@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2023 16:35, Ivan Mikhaylov wrote:
> Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>

Need some commit msg.


> ---
>  .../bindings/net/faraday,ftgmac100.yaml       | 110 ++++++++++++++++++

Missing actual conversion (removal).

>  1 file changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> new file mode 100644
> index 000000000000..98cd142f74bb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> @@ -0,0 +1,110 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual-license, unless you copied some chunks of old binding... but was
there old binding?

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Faraday Technology FTGMAC100 gigabit ethernet controller
> +
> +allOf:
> +  - $ref: "ethernet-controller.yaml#"

Drop quotes.


> +
> +maintainers:
> +  - Po-Yu Chuang <ratbert@faraday-tech.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: faraday,ftgmac100
> +      - items:
> +          - enum:
> +              - aspeed,ast2400-mac
> +              - aspeed,ast2500-mac
> +              - aspeed,ast2600-mac
> +          - const: faraday,ftgmac100
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    description: |
> +      In accordance with the generic clock bindings.

Drop this part. Obvious.

>  Must describe the MAC
> +      IP clock, and optionally an RMII RCLK gate for the AST2500/AST2600. The
> +      required MAC clock must be the first cell.

The cells depend on clock provider. Do you mean something else?

> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - enum:
> +          - MACCLK
> +          - RCLK

This does not allow two clocks... List all the items and add minItems: 1.


> +
> +  phy-mode:
> +    enum:
> +      - rgmii
> +      - rmii
> +
> +  phy-handle: true
> +
> +  use-ncsi:
> +    description: |

Do not need '|' unless you need to preserve formatting.

I will stop review, because it depends whether this is true conversion
or new binding.

Best regards,
Krzysztof

