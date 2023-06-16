Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B11732F27
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345529AbjFPKxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345531AbjFPKxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:53:18 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA79765AB
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 03:45:14 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-982ae93386aso78920866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 03:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686912313; x=1689504313;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CCG5A6ajXLTLE10xD/EwQtRbiFYAr92BjqbfBvbs0JM=;
        b=Cx8hqyXEUK5n/F62ME4CFIQWOYqMOsvyeK757+STYBi0A9mA22sCgVtbAKNgMDmWMD
         KfEynGMuCfXSlNJ5DV0IEagQ91+r8zLn6dzyd2769QJ+lagubdNtu65uUeLDN3IGtDNN
         oDxDctQHR+auluwdqh/kIlGLiCuUzRViTl6TIdAwZ4a3JM+XMHgM5942iMj+dssyMhKb
         NKqNJ80dcdIidj+M5FgoCPqQPN96kKGGaUNu5hwKdmzn5awhUAdZJHZG5WE1a6+J2Izm
         8vssm2rgCrbFScEW9FraY2Ehl/1CKjarUvOEuXRLRYDq+9GG3E5jENuuNFSPj7FuuN/p
         XsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686912313; x=1689504313;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCG5A6ajXLTLE10xD/EwQtRbiFYAr92BjqbfBvbs0JM=;
        b=F2e/62zFeXwW7qouFu8yX5pAAM3Karp0Jz6FXjVZ+ZVQDfhGHWoaVZHNTBxUqCQo3+
         Sa9KF0Wu/ycNP9TiVpUAkBLq6c05AyZk27X86VSnSzU/S4iBAkInA9JokhonI9jPS7HG
         cU4VV78/ap28yziUgDyPB7V37eN6ZFk1swa0Jqsgoce8UowCTeYBznXnc6EzxYKt9ZXT
         521alJksyv8NEpr4botCCUXs4A1QXYq2iVavic7DABIiaG3Hlyv+zJPEbq37r3u7OUw3
         dw7F5YV9EuKMpI39zTUyVqvhreGFQ7gN3G6xCbfdddlgGo7oIIAol/cxpIMrxbYBv3Gz
         9ySQ==
X-Gm-Message-State: AC+VfDy2hguF9D41KhkYyDC7EoQaFErzsdVnZZYg3wsKTyu1S5EmiCsF
        5tRfT7L+SwKfK61lZvH8zN2BVg==
X-Google-Smtp-Source: ACHHUZ5pBhc4PkJsgZKTk6SpG5tqfoPODaHd3C6shKQL67g4PPNJz+2J9HtBtcwGuo+hUVy5k5aKlQ==
X-Received: by 2002:a17:906:974a:b0:982:7735:436d with SMTP id o10-20020a170906974a00b009827735436dmr1948610ejy.7.1686912313065;
        Fri, 16 Jun 2023 03:45:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id k10-20020a17090646ca00b009827b97c89csm3130806ejs.102.2023.06.16.03.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 03:45:12 -0700 (PDT)
Message-ID: <2437bda9-bbdb-ad80-7201-1e16e1388890@linaro.org>
Date:   Fri, 16 Jun 2023 12:45:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] dt-bindings: riscv: sifive: Add SiFive Private L2
 cache controller
Content-Language: en-US
To:     Eric Lin <eric.lin@sifive.com>, conor@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, maz@kernel.org, chenhuacai@kernel.org,
        baolu.lu@linux.intel.com, will@kernel.org,
        kan.liang@linux.intel.com, nnac123@linux.ibm.com,
        pierre.gondois@arm.com, huangguangbin2@huawei.com, jgross@suse.com,
        chao.gao@intel.com, maobibo@loongson.cn,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dslin1010@gmail.com
Cc:     Zong Li <zong.li@sifive.com>, Nick Hu <nick.hu@sifive.com>
References: <20230616063210.19063-1-eric.lin@sifive.com>
 <20230616063210.19063-4-eric.lin@sifive.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230616063210.19063-4-eric.lin@sifive.com>
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

On 16/06/2023 08:32, Eric Lin wrote:
> This add YAML DT binding documentation for SiFive Private L2
> cache controller
> 
> Signed-off-by: Eric Lin <eric.lin@sifive.com>
> Reviewed-by: Zong Li <zong.li@sifive.com>
> Reviewed-by: Nick Hu <nick.hu@sifive.com>
> ---
>  .../bindings/riscv/sifive,pL2Cache0.yaml      | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/sifive,pL2Cache0.yaml
> 
> diff --git a/Documentation/devicetree/bindings/riscv/sifive,pL2Cache0.yaml b/Documentation/devicetree/bindings/riscv/sifive,pL2Cache0.yaml
> new file mode 100644
> index 000000000000..b5d8d4a39dde
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/riscv/sifive,pL2Cache0.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2023 SiFive, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/riscv/sifive,pL2Cache0.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiFive Private L2 Cache Controller
> +
> +maintainers:
> +  - Greentime Hu  <greentime.hu@sifive.com>
> +  - Eric Lin      <eric.lin@sifive.com>
> +
> +description:
> +  The SiFive Private L2 Cache Controller is per hart and communicates with both the upstream
> +  L1 caches and downstream L3 cache or memory, enabling a high-performance cache subsystem.
> +  All the properties in ePAPR/DeviceTree specification applies for this platform.

Drop the last sentence. Why specification would not apply?

> +
> +allOf:
> +  - $ref: /schemas/cache-controller.yaml#
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - sifive,pL2Cache0
> +          - sifive,pL2Cache
> +
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    items:


You have only one item, so no need for items... unless you just missed
proper fallback.

> +      - enum:
> +          - sifive,pL2Cache0
> +          - sifive,pL2Cache1

What is "0" and "1" here? What do these compatibles represent? Why they
do not have any SoC related part?

> +
> +  cache-block-size:
> +    const: 64
> +
> +  cache-level:
> +    const: 2
> +
> +  cache-sets:
> +    const: 512
> +
> +  cache-size:
> +    const: 262144

Are you sure? So all private L2 cache controllers will have fixed size
of cache?

> +
> +  cache-unified: true
> +
> +  reg:
> +    maxItems: 1
> +
> +  next-level-cache: true
> +
> +additionalProperties: false
> +
> +required:

required: goes before additionalProperties:.


Best regards,
Krzysztof

