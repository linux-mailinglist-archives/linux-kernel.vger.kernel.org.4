Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173596E39C3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 17:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjDPPUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 11:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjDPPUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 11:20:10 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA951FEF
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 08:20:08 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id dm2so57970535ejc.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 08:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681658406; x=1684250406;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rbAN5WU56B4VEiB1VFsqC9Gu1Swjc+C/BnQGH/MXxU8=;
        b=vFZZkIacIl8160Edsrq6FQgdswWD0NbURlNL8AaHAfXEcNIcP6KSIWDgMY4FSOloem
         XT/l6aZi+ZuEmbaliOaA/5H0K+gifvsizmgsSc0BW60VXrVuvNCvf6ojgqPq7NJx9muA
         Dsr9+aIDlAqdhe9X7ca1vD4gfVi2qIFSR4x1HreKcoyuZETpLrczwLOD1DpP/ecie4mS
         7strxWiKY+PzJbXnsZ+xGK3pckrJZNbSvKSyG+R6U+cQhM8WOdBDLK418/n0Adr90jIq
         Q7rxJGhyHH1R+uwWq60OzhS4BYwlgEkWDPNTdZ4AL/sGQUYIu3N0caiv3B3Ft1FSkoCa
         DBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681658406; x=1684250406;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rbAN5WU56B4VEiB1VFsqC9Gu1Swjc+C/BnQGH/MXxU8=;
        b=EYyYSuPBrTUTcRlzKasJbZtyeUYxDVeMNJ05I46FmHXoi3tyMKpGQNmvBpKvhCF2YS
         Jr3dT9eWcsxtZdSekozOl2Pbcip/gWb5yNoTUj0D8lxHAf2/O/UacQwypV/JD5uPADv4
         BUJXCJPGBwa2QptmMBPyVQnzxhowAlKZ6xjgUvg8B6NYcrtIQuhQDWDnphsl7obqDwRH
         crpuZ2ojwNAF7a5yPItOrqpEc1OK2hwIoJ5oDT4h9ZanUr5RIrW7Zv2dqjHZdojcKRwC
         YEIV6PhH5VKr48JW7n+t6MzUhqPxBBCxRr5Ml/+SbecI6JqfoZaloR4DyMskJNgouOh9
         tl0A==
X-Gm-Message-State: AAQBX9e9jCdwop8kZV8Ny27hxEEk/0qSwFDYKSt4zKjOASKLEi1LBFgt
        zcJNhs61m17DcE+SddUsScSvhg==
X-Google-Smtp-Source: AKy350ajHtRg1Jzq0HB8HI0deyaXSVS4/EcdAvXZXdc0qq6IDelZKY32JGmq5Y7NUAuRGGimi3ZFBQ==
X-Received: by 2002:a17:906:bc42:b0:94f:5e17:e80d with SMTP id s2-20020a170906bc4200b0094f5e17e80dmr1786236ejv.45.1681658406502;
        Sun, 16 Apr 2023 08:20:06 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ba4d:301c:484d:5c9? ([2a02:810d:15c0:828:ba4d:301c:484d:5c9])
        by smtp.gmail.com with ESMTPSA id d9-20020a17090648c900b0094f4f2db7e0sm1049358ejt.143.2023.04.16.08.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 08:20:06 -0700 (PDT)
Message-ID: <df5377a3-4bdb-0f74-b536-528b9d225580@linaro.org>
Date:   Sun, 16 Apr 2023 17:20:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/4] dt-bindings: power: reset: convert nvmem-reboot-mode
 bindings to YAML
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230413131705.3073911-1-brgl@bgdev.pl>
 <20230413131705.3073911-4-brgl@bgdev.pl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230413131705.3073911-4-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2023 15:17, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Convert the DT binding document for nvmem-reboot-mode from .txt to YAML.

Thank you for your patch. There is something to discuss/improve.

> diff --git a/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
> new file mode 100644
> index 000000000000..64a7d224c7dd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/nvmem-reboot-mode.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic NVMEM reboot mode driver

Drop "driver".
> +
> +maintainers:
> +  - Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  This driver gets the reboot mode magic value from the reboot-mode driver
> +  and stores it in the NVMEM cell named "reboot-mode". The bootloader can
> +  then read it and take different action according to the value.
> +
> +properties:
> +  compatible:
> +    const: nvmem-reboot-mode
> +
> +  nvmem-cells:
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      A phandle pointing to the nvmem-cells node where the vendor-specific
> +      magic value representing the reboot mode is stored.
> +    maxItems: 1
> +
> +  nvmem-cell-names:
> +    items:
> +      - const: reboot-mode
> +
> +patternProperties:
> +  "^mode-.+":
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Vendor-specific mode value written to the mode register
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - nvmem-cells
> +  - nvmem-cell-names

put required: before additionalProperties

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

