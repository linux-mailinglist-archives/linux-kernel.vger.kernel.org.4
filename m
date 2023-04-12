Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586416DEDEF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjDLIiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjDLIhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:37:55 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FE06A6D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:36:43 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id j17so17173554ejs.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681288508;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yoGluq/J5303QEsfmSr2iQw9kmdWUed7sT0pHVPfXtg=;
        b=I3dy17S7m2Vab1t0U+AGdFNZsDwDtgsJFXI5Jlt8+Fq3CCTOSOk9aw+7wV4OLzQVE4
         DSTZOLwPrSBUZOYzFkbXMKLUGC45las/eApfBkCzJUZ46gJITnmIbD5vKp2llVNKaWOD
         LBZRzQCcPUG7/fRCEPBFHIedYZ+nfCHf4/2bJ/QAgVXi8GwaCoj8d9hury4TUpGzM0eQ
         LD9XbLgPpHAgwDMv701nn5YDVckB5mXBZBlCvXDUSfBDrR8sugEegXnfO+cFlT7oEhd3
         ZpbejePdOv5lU6rNSCeaozsMu50LVV9y5tSweiLThhzSwXkHrR/4sdrkalzk0D191TsK
         Q9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681288508;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yoGluq/J5303QEsfmSr2iQw9kmdWUed7sT0pHVPfXtg=;
        b=Lrr0oyesTkE6MHFtwbqL0Mph2b1w1GYFHXJbVRcql17Mr/MgfbnUSy4n97/62JCynm
         t4tYB/pZzace2TnIzdNUUhyKxGgFbWzOuytZELenSZmxWp4999RiDcp64FSr/fMzoljS
         wZmrxvTLDs1qosp9lCN5M/yZoEjbzKMtNmV97iTOUEi4nle+PLkp8QYZHmSBExq+ZWWW
         BWs6OGOZjupZJhLbPIJGBOrk0GAFsOXEQjg1mAmwpYoYpX+JPl9/CpPGdnEC7vjQruMX
         pfa81BFht6RPPNaByGbspyAaAMmT2JX46mFqAqQkwILhnH3qLwljegUxk/JqPPVTHnO1
         OF4Q==
X-Gm-Message-State: AAQBX9c5j6mShoca9aIOOWROB5cCtOJO2nK2/BbKf7n1KJ8t29RiAF42
        gUXEAzvaPLNy4fWCRaNIfCD9ZA==
X-Google-Smtp-Source: AKy350ZF0tWwKgLIPhrVEdP4KEaeMRw0Kd5VxKsy15GudE93E4tkyqAIy7bUV5T2axpZPp5BerwaLw==
X-Received: by 2002:a17:906:e2c6:b0:947:a6d7:e2b4 with SMTP id gr6-20020a170906e2c600b00947a6d7e2b4mr5434302ejb.8.1681288508144;
        Wed, 12 Apr 2023 01:35:08 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8fa0:9989:3f72:b14f? ([2a02:810d:15c0:828:8fa0:9989:3f72:b14f])
        by smtp.gmail.com with ESMTPSA id tg12-20020a1709078dcc00b0094a473988b9sm4173113ejc.27.2023.04.12.01.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 01:35:07 -0700 (PDT)
Message-ID: <cb97cf01-2dfd-7f93-2048-e05a806d468f@linaro.org>
Date:   Wed, 12 Apr 2023 10:35:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1 1/7] dt-bindings: power: Constrain properties for
 JH7110 PMU
Content-Language: en-US
To:     Changhuang Liang <changhuang.liang@starfivetech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Walker Chen <walker.chen@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20230411064743.273388-1-changhuang.liang@starfivetech.com>
 <20230411064743.273388-2-changhuang.liang@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230411064743.273388-2-changhuang.liang@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2023 08:47, Changhuang Liang wrote:
> When use "starfive,jh7110-pmu-dphy" compatible, do not need the reg and
> interrupts properties.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  .../bindings/power/starfive,jh7110-pmu.yaml        | 14 ++++++++++++--
>  include/dt-bindings/power/starfive,jh7110-pmu.h    |  3 +++
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/starfive,jh7110-pmu.yaml b/Documentation/devicetree/bindings/power/starfive,jh7110-pmu.yaml
> index 98eb8b4110e7..ffb4406c2e56 100644
> --- a/Documentation/devicetree/bindings/power/starfive,jh7110-pmu.yaml
> +++ b/Documentation/devicetree/bindings/power/starfive,jh7110-pmu.yaml
> @@ -8,6 +8,7 @@ title: StarFive JH7110 Power Management Unit
>  
>  maintainers:
>    - Walker Chen <walker.chen@starfivetech.com>
> +  - Changhuang Liang <changhuang.liang@starfivetech.com>
>  
>  description: |
>    StarFive JH7110 SoC includes support for multiple power domains which can be
> @@ -17,6 +18,7 @@ properties:
>    compatible:
>      enum:
>        - starfive,jh7110-pmu
> +      - starfive,jh7110-pmu-dphy

You do here much more than commit msg says.

Isn'y DPHY a phy? Why is it in power?

>  
>    reg:
>      maxItems: 1
> @@ -29,10 +31,18 @@ properties:
>  
>  required:
>    - compatible
> -  - reg
> -  - interrupts
>    - "#power-domain-cells"
>  
> +if:

Put it under allOf (in this place). Will save you one re-indentation later.

> +  properties:
> +    compatible:
> +      contains:
> +        const: starfive,jh7110-pmu
> +then:
> +  required:
> +    - reg
> +    - interrupts
> +
>  additionalProperties: false
>  
>  examples:
> diff --git a/include/dt-bindings/power/starfive,jh7110-pmu.h b/include/dt-bindings/power/starfive,jh7110-pmu.h
> index 132bfe401fc8..0bfd6700c144 100644
> --- a/include/dt-bindings/power/starfive,jh7110-pmu.h
> +++ b/include/dt-bindings/power/starfive,jh7110-pmu.h
> @@ -14,4 +14,7 @@
>  #define JH7110_PD_ISP		5
>  #define JH7110_PD_VENC		6
>  
> +#define JH7110_PD_DPHY_TX	0
> +#define JH7110_PD_DPHY_RX	1
> +
>  #endif

Best regards,
Krzysztof

