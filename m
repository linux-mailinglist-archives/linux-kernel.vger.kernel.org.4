Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4106677629
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjAWINt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 03:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjAWINr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:13:47 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB581717C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:13:44 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id b7so9977052wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SBM3bwQWzykO2B1JQ+ipvskwHKEQ4WdxVib/Qyi51ug=;
        b=AT9Iq0xSCEqZpmKDW/Ox7GmeyX5AuNSRJunHvXTae3PtaTzXAaVeLJiUNCqlOyzZPw
         33iOZHMkSml012eGVJ/IICOryeb3/C3pOsn3g1PIhUPamMcb4uBeWg9efJVUXjxl+bFp
         0zW+bAj0q6l1Gj2h+11m2yuUu0cuj22N/4GRjtmdTOPLeMUNixJ7BsuSeM7+xQ1PijzC
         GLqz/JxaSPW1s+RVlRp0DnWuxcQ3xeON8gI1oYo374UIcxoaNTFJ1q2hEzgNcEZzaFEi
         564qfpA2fPIkm25jO5xQ6Obq7Kvks5lEJy0N0yf7xANOgqqn2qRJM07bm+JBKp265V+M
         HqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBM3bwQWzykO2B1JQ+ipvskwHKEQ4WdxVib/Qyi51ug=;
        b=Xsmwmlx+sfEGJOIewnJ2kY8ncrOC1GyC6A2sQV6wweN18gdeVyHnNXGyUZbLc3+D6H
         NJ12VsEsqUWOcV1PxiWcmBX0U6UVhMNQr4Wr+45LY+33WHNMHyBv6OZ3nMZTB8ftePjV
         OYkEw2C7RbgreHLRb0Gm/1xOQud1mP/E8LqhRm59gW1DsY3xIzgxK1HHWTJ5pgjK0EK1
         4WBmzgalFc2txxybmrfsXoxksg2pNrUiNsau65acGSzj12zu2UfMvPgxk+VTweml7gpI
         H+LBuHMjeMj46CCjGX8H+QNXAa4a0LeqykpAbBify4I8JjDqY9KwhDNkOttLOT8sOkdc
         ntJg==
X-Gm-Message-State: AFqh2kqRP987YLn6WCacvfByNCqxU4ZNSVUcwFZcC32hrDHh55KUdk3T
        Z5CGuUEQDssPLrKqbL8UBrvSqQ==
X-Google-Smtp-Source: AMrXdXvEE2+iNOHYDBXMmjnnlnEeh6QweQ/hJDMmk245CtGSpc/zmfvz+73u+L3+2RYwpIRt3IDSbQ==
X-Received: by 2002:adf:fa08:0:b0:2bc:aa57:7f35 with SMTP id m8-20020adffa08000000b002bcaa577f35mr20792170wrr.52.1674461623286;
        Mon, 23 Jan 2023 00:13:43 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b9-20020adff909000000b002be5401ef5fsm7588216wrr.39.2023.01.23.00.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 00:13:42 -0800 (PST)
Message-ID: <c317762c-4471-36c1-24fc-0982eee9192d@linaro.org>
Date:   Mon, 23 Jan 2023 09:13:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 13/15] dt-bindings: pinctrl: add support for Ambarella
Content-Language: en-US
To:     Li Chen <lchen@ambarella.com>, Li Chen <me@linux.beauty>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "moderated list:ARM/Ambarella SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230123073305.149940-1-lchen@ambarella.com>
 <20230123073305.149940-14-lchen@ambarella.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230123073305.149940-14-lchen@ambarella.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 08:32, Li Chen wrote:
> Add a Ambarella compatible.
> 
> Signed-off-by: Li Chen <lchen@ambarella.com>
> Change-Id: I8bcab3b763bdc7e400a04cc46589f0f694028a66
> ---
>  .../bindings/pinctrl/ambarella,pinctrl.yaml   | 160 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 161 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/ambarella,pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/ambarella,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ambarella,pinctrl.yaml
> new file mode 100644
> index 000000000000..51f5a9cc4714
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/ambarella,pinctrl.yaml
> @@ -0,0 +1,160 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/ambarella,pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ambarella PIN controller
> +
> +maintainers:
> +  - Li Chen <lchen@ambarella.org>
> +
> +description: |
> +  The pins controlled by Ambarella SoC chip are organized in banks, each bank
> +  has 32 pins.  Each pin has at least 2 multiplexing functions, and generally,
> +  the first function is GPIO.
> +
> +  The PINCTRL node acts as a container for an arbitrary number of subnodes. And
> +  these subnodes will fall into two categories.
> +
> +  One is for GPIO, please see the "GPIO node" section for detail, and another one
> +  is to set up a group of pins for a function, both pin configurations and mux
> +  selection, and it's called group node in the binding document.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: ambarella,pinctrl
> +
> +  reg:
> +    minItems: 4
> +    maxItems: 4
> +

Same problems as with other patches. You need to fix all of my previous
comments.

Best regards,
Krzysztof

