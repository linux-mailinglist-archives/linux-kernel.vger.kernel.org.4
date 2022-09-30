Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7C25F0813
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiI3J61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiI3J6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:58:23 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7C917F546
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:58:21 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bu25so6109194lfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=mQNFTbjJsZ/QtD20aKuSgSzhrP5iLEWPqw7+b4Gc6Hk=;
        b=vzX4Kdna3ulAbcywBUMwTPKBg4bCYSp+BihKJye2sQaculetoFPs7N927IKxjGAjUF
         znfUuRNC6AMRkoBjuPgraGYEb5EXSDXHNMg6e+D8AQ4am8qurtJb5PSaRPVRbSM99cz8
         P0aiTTQ690T9ZITTuhQYRIAVzkanyuPuHy2bCMBf+mIRNbFr0aOOWakeCrsSOERxQneQ
         6iv8UgQRJZnVFcOx3qDorPZLHPIzGsXwEDDN8N4XliKBi7OZ0u55Ji3XkhrPerzIVaB4
         TrIsqzRkTb4Ifyzlqg/eUINkI7wICim9PsGxwORaBV5ys6OhD4mvLQZDicJOAoRDEm1q
         sfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=mQNFTbjJsZ/QtD20aKuSgSzhrP5iLEWPqw7+b4Gc6Hk=;
        b=CRx0vFPP3r8eeYzFqz7nS7LAhAX29rokPB0dw1kCJVIQVxsn957yU1Vo0+6nvXJ9hu
         t1f4vjc2oNCXC83ToFQJNZvv9lM/+gHj6k4yP21Guf6wpCq0NC7TGANjz+5UaYXIsbdM
         V3m1cyxj4OQr/V0gagBcg7BBNCk1bFphhmXeJL2LfmfK4Ec7JJRqiVvN2SADptKki317
         AIVxuygqj1cktUFp9Qu+Rkc9h8AJLVGnLNOxPEFgSc05UcpyjJrqUlC/Y2gVUo14rGBS
         p9t7XEmgQEbNdYLtPYeu/LVL5MFN50K89wP0gEZswG1nE+/0hlN6XQKP2ZCng2MPUccX
         3SLw==
X-Gm-Message-State: ACrzQf0UT9GIqHFBszxW6aH/nlM50uDFFdMB3rMOVxt/eMk8uGSWxY+X
        T876ZAm9YF3uNRJyqDjnU/TLaw==
X-Google-Smtp-Source: AMsMyM5gVssvdT8h4eN24kleMRIVAAQ4ECAC1Zk0BmlTwjnKzDA7m/P19Hsb/xFjblvC0ZT/L799UQ==
X-Received: by 2002:a05:6512:2211:b0:496:7767:28b with SMTP id h17-20020a056512221100b004967767028bmr3270118lfu.433.1664531900257;
        Fri, 30 Sep 2022 02:58:20 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u24-20020ac24c38000000b0048a934168c0sm249234lfq.35.2022.09.30.02.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 02:58:19 -0700 (PDT)
Message-ID: <ba5873fa-83fc-2d16-b8c0-715ae8bf630a@linaro.org>
Date:   Fri, 30 Sep 2022 11:58:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 2/2] dt-bindings: hpet: add loongson2k hpet binding
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yun Liu <liuyun@loongson.cn>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        loongarch@lists.linux.dev
References: <20220930093510.10781-1-zhuyinbo@loongson.cn>
 <20220930093510.10781-2-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220930093510.10781-2-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2022 11:35, Yinbo Zhu wrote:
> Add the loongson2k High Precision Event Timer (HPET) binding
> with DT schema format using json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  .../bindings/timer/loongson,ls2k-hpet.yaml    | 41 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/loongson,ls2k-hpet.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/loongson,ls2k-hpet.yaml b/Documentation/devicetree/bindings/timer/loongson,ls2k-hpet.yaml
> new file mode 100644
> index 000000000000..1a8785076228
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/loongson,ls2k-hpet.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/loongson,ls2k-hpet.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson2k High Precision Event Timer (HPET)
> +
> +maintainers:
> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
> +
> +properties:
> +  compatible:
> +    const: loongson,ls2k-hpet
> +
> +  reg:
> +    maxItems: 1
> +
> +  clock-frequency: true

clock frequency of what? I assume it's too early to use common clock
framework and just get the clock?

> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clock-frequency
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    hpet0: hpet@1fe24000 {

Node name: timer
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

You can drop the  "hpet0" label.


Best regards,
Krzysztof

