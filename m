Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D674B732973
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245371AbjFPIET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245318AbjFPIEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:04:11 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4802D77
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:03:56 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b1b06af50eso4657211fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686902634; x=1689494634;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hULyAVDg1y9tDeonTJB2nq2Om4nQ0EG3JOer8JbQBgk=;
        b=IjyyIjRvGJ6T59xW+C0BwtDhrkUtXVrPEBmitFdbVZj5r/FE6bMgxSecYi9QXghR2d
         V5y9FYiVW5wClSM4X+FYHojfR1F4PZnud/5OnHP2hV64TlSkGF39SpSsvJg+8WHw3hTm
         Sa0kqwuNfIa6AlNThBEBb0T8fv6aNXyVlbxcM1wiCiZ+Cj/c+I8UDVn+KdZ7aweQCoiY
         01xKnKQfj7qGmx9kRuxB9ahCcWLlpyPBf8FAic7GrefbQEPt7wV3EOr/bNi6NWxPy4rB
         Jb5D8yo/m9pfs674Zmtunm9tFzZIDDrbRLOvMOnaLQ5eTC6A9aipJQV8Wd6/OAZbBqeF
         yxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686902634; x=1689494634;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hULyAVDg1y9tDeonTJB2nq2Om4nQ0EG3JOer8JbQBgk=;
        b=Z610pcgvSfVmUls0EYw8/+KqiHAowVfFIY9wAPDUlAoXVf+Z8dglMTNG6UxQaF2YUz
         qAiIsRw93C5SmOaIfvwV4+kbvtuNsmoj4vtZ96dgKnVzdSVYGH4wL3UhbXosJV4lW/v5
         YiK+ls1eiOiR7ZPeLC8qSD2tuMotHjG/aoiD77UH1xsI8c2Pa1jlhp6c6YAquVuTOCDd
         UXozUR8ELa+w/pxz2q88ZUtyLUw8HzqK0r9LqCOwU13hTDIWMMVAay2vuKU9vvzxu29+
         xMGs9XOOASWA0tmXiPgyMcQHYPmZOsApwEgD1jEozee3vLlJs5My2UD77Hgi5t07xnTW
         hU2A==
X-Gm-Message-State: AC+VfDyCO9Hp+gLiJA7Y0lTYZ8yHrzAuM7weFi2gYk8XjJzc4iKTglfC
        VQq/64REB7IgT8lxrKlJQ5lYWA==
X-Google-Smtp-Source: ACHHUZ6I3r39l8aDjCeT+3PLWduhsdthB5fB5sV2c3c0A+8gjY/rggU6SYdfOnmk0HXZbGrejZLc0Q==
X-Received: by 2002:a2e:86d2:0:b0:2ad:9139:c871 with SMTP id n18-20020a2e86d2000000b002ad9139c871mr1103205ljj.19.1686902634418;
        Fri, 16 Jun 2023 01:03:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id u3-20020aa7d543000000b00514bddcb87csm9908991edr.31.2023.06.16.01.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 01:03:53 -0700 (PDT)
Message-ID: <efdd8e66-a8dc-1a7e-6ac3-fdbe0ba45204@linaro.org>
Date:   Fri, 16 Jun 2023 10:03:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 2/3] soc: dt-bindings: add loongson-2 pm
To:     Yinbo Zhu <zhuyinbo@loongson.cn>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230615091757.24686-1-zhuyinbo@loongson.cn>
 <20230615091757.24686-3-zhuyinbo@loongson.cn>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230615091757.24686-3-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2023 11:17, Yinbo Zhu wrote:
> Add the Loongson-2 SoC Power Management Controller binding with DT
> schema format using json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  .../soc/loongson/loongson,ls2k-pmc.yaml       | 53 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml
> new file mode 100644
> index 000000000000..32499bd10f8c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/loongson/loongson,ls2k-pmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson-2 Power Manager controller
> +
> +maintainers:
> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
> +
> +properties:
> +  compatible:
> +    oneOf:

Drop oneOf, you don't have here many choices.

> +      - items:
> +          - enum:
> +              - loongson,ls2k1000-pmc
> +              - loongson,ls2k0500-pmc
> +          - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  suspend-address:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      The "suspend-address" is a deep sleep state (Suspend To RAM)
> +      firmware entry address which was jumped from kernel and it's
> +      value was dependent on specific platform firmware code. In
> +      addition, the PM need according to it to indicate that current
> +      SoC whether support Suspend To RAM.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    pmc: pm@1fe27000 {

Node name: system-controller or power-pamanagement

With these two:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

