Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24376D9FD9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240026AbjDFSaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 14:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240186AbjDFSaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:30:06 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF48E83FB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 11:30:03 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id sg7so3566636ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 11:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680805802;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H8xOnV6tCyOvs2gyhgdBhfMQe4yUXu7o2kH7bC3OOGM=;
        b=b5iOLOQnrmb7I5cMr9PLoh+DDsoWrJ+Ww372OHESD7omSrAJR3M++5RGQVCCpEMnqV
         +ZPdYWfc0xJRascTYU+atPwFyQEhrdeBEsknBfAgsySMLj6L20we/1yAjDE/6rLxYHjy
         yxaS6JvdEk90suKMGRKGt3PD4FqAGSu9UfmsZiI28Hx3I4nmZYoAqHNT8DiNjLh4gwDI
         DTwKATnpSPviipdh3ORflYJW9yZh3A8emn00RrbRuNwrBCAfT7kk2ru1o5Ofzzy526W3
         PpFKlhgOvB+XXmGcaOTYhvCtapYcaJae29qE4dUeYQc1+s4f5zfr2GdPetEtghIFTSEZ
         pejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680805802;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H8xOnV6tCyOvs2gyhgdBhfMQe4yUXu7o2kH7bC3OOGM=;
        b=OD8N3YhIbXwvOfjCdzBKZ1IrtF0d8YTWmWwEjJfDhRcJPUUdAHBVw3DV2tSKVom3T5
         VuA0VKJAWJUccZdtjNtJ7ZucfBH42aMfCijNQuMZEiRY39N+zgmGurEbaVXT6BWyUPg6
         birXPgMB6wOTgq74uwcyNsCFXsUasa8zYA8WRY0HLng9GRepuhKmXZza45VDG1WS/aES
         xxb62wXyzMSw98nT/ctnusTxYo6ncrEYNhtQeH96AKxEYfPcWnW2Dy2/v/pvTJI8m7fV
         EqKQZJt/ToZZjrywLiJp3C9+mgyYYDAcsp6lCifBnT1RttSabdZLUB3aZhqGXxZohHvG
         H6Bw==
X-Gm-Message-State: AAQBX9e22i5CjqZQBHCqKim2dWIaIBWZgIVSaTGSwBDAHHlvjNTzbrTJ
        C2mVeNANzLUvWS4MjcmOGFTbgA022wxcYtyhlB8=
X-Google-Smtp-Source: AKy350bJ8pSDWF8uwl4GVm21uI5EfXApiU2Dd5qO+ZXzcTAbihmplWOrQLDopnmNmkwgaLMJ391tAA==
X-Received: by 2002:a17:906:3b86:b0:8de:e66a:ece9 with SMTP id u6-20020a1709063b8600b008dee66aece9mr7792594ejf.24.1680805802128;
        Thu, 06 Apr 2023 11:30:02 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id fy29-20020a1709069f1d00b0093313f4fc3csm1124541ejc.70.2023.04.06.11.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 11:30:01 -0700 (PDT)
Message-ID: <833b68a5-263d-d293-4910-2ca50b43e60d@linaro.org>
Date:   Thu, 6 Apr 2023 20:30:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v7 1/2] dt-bindings: soc: starfive: Add StarFive syscon
 doc
Content-Language: en-US
To:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>
References: <20230406103308.1280860-1-william.qiu@starfivetech.com>
 <20230406103308.1280860-2-william.qiu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406103308.1280860-2-william.qiu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 12:33, William Qiu wrote:
> Add documentation to describe StarFive System Controller Registers.

Subject: drop second/last, redundant "doc". The "dt-bindings" prefix is
already stating that these are documentation files.

> 
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  .../soc/starfive/starfive,jh7110-syscon.yaml  | 56 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
> new file mode 100644
> index 000000000000..0d0319426b67
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/starfive/starfive,jh7110-syscon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 SoC system controller
> +
> +maintainers:
> +  - William Qiu <william.qiu@starfivetech.com>
> +
> +description: |
> +  The StarFive JH7110 SoC system controller provides register information such
> +  as offset, mask and shift to configure related modules such as MMC and PCIe.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - starfive,jh7110-aon-syscon
> +              - starfive,jh7110-sys-syscon
> +          - const: syscon
> +          - const: simple-mfd
> +      - items:
> +          - const: starfive,jh7110-stg-syscon
> +          - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  clock-controller:
> +    type: object

This should be rather specific schema, so $ref.

> +
> +  power-controller:
> +    type: object

Same problem.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    syscon@10240000 {
> +        compatible = "starfive,jh7110-stg-syscon", "syscon";
> +        reg = <0x10240000 0x1000>;
> +    };
> +
> +    syscon@13030000 {
> +        compatible = "starfive,jh7110-sys-syscon", "syscon", "simple-mfd";
> +        reg = <0x13030000 0x1000>;
> +    };
Best regards,
Krzysztof

