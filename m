Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B288060CF88
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbiJYOtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiJYOte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:49:34 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A10388F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:49:31 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id z30so8157849qkz.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8YP5wWUEEBMY2PTNKrTu3Hh2pQmEm7huU1HOYVz0Rwk=;
        b=jwEJWV/zFdZ896Mkmss4/ajlWv6Os+0/UtK8gEBYdYtX5hvHY0/rI58TAvELkvqVsE
         YJargWbH5W1QyduIbf7U2FNwQcQvsAmEyafhApayU/O8VFZIDia/USrcnbhY0bouVtok
         2HwauXBFcJTpxlvgaY70ySmMsiDBUGAge285taKQC9lM07fL4/70Xr+lHmbgTxNOQybU
         q2hM+fHtSfR71pvx5/bB54JFwT/1RwiqtQ2mnzlAWHCDfRE2stpV6SvhOWjj35LMof4W
         NP1SxoAnNIAI/e+72XdoNM9mVuBXlyQYehDWrG0jwSTWdImJl5cP1bNpiQFnpplwjPKc
         Hb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8YP5wWUEEBMY2PTNKrTu3Hh2pQmEm7huU1HOYVz0Rwk=;
        b=yqeTwRp8JrDWDxbuaVmvx8+Fk2z1OnkRYK8Y3aAwfUZjm4LSOta1y49c7llScer7hR
         pJKoeUygi8DGsTttjzZLp8HF7AAXQ7o0ZvZ5aPy9ypuAzCADisFUeWbCbEvDvLZys/pC
         VYsgiOXOQpBu37QTvStctTPS0qVhmQZ1afSu7QCIOmZicy4HQgdQs56KWcuLZb6S8vkD
         KBQCKiS76Qu4EgYXZnQ/o5RbsyohVoC++j3yQ48CJevl8XZHa7KrDIPuHIvXKjd4uNps
         LNJCLeFgsNIEYI9UEKHOg9NGoKnBsumWzTIFrUbaO6GWk/FWdxI4a3lSgDgYvPpv6fa4
         NYsA==
X-Gm-Message-State: ACrzQf0ZAOmVGThqOIER82Pq2F1fDK8VKfuuVw2vi2coMPJub07pYzuh
        B0k6vx7ZWAtLCOSHWeWl9PaD/Q==
X-Google-Smtp-Source: AMsMyM6CxSbFXx8tIMJFyF8KEBlAnnnHYsyGOMTSwcPVWCGa6Me8gw8xFad19rxKtM7zhMtCSDY/FQ==
X-Received: by 2002:a05:620a:484c:b0:6ee:9acb:dfdc with SMTP id ec12-20020a05620a484c00b006ee9acbdfdcmr26735181qkb.594.1666709370859;
        Tue, 25 Oct 2022 07:49:30 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id m17-20020ae9e711000000b006ed61f18651sm2155611qka.16.2022.10.25.07.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 07:49:30 -0700 (PDT)
Message-ID: <d181924f-d87b-cad3-400a-dec22d3b29a6@linaro.org>
Date:   Tue, 25 Oct 2022 10:49:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 2/2] dt-bindings: hpet: add loongson2 hpet
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
References: <20221021010925.21604-1-zhuyinbo@loongson.cn>
 <20221021010925.21604-2-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021010925.21604-2-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2022 21:09, Yinbo Zhu wrote:
> Add the loongson2 High Precision Event Timer (HPET) binding
> with DT schema format using json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
> Change in v3:
> 		1. Update dts that base on common clock framework.
> 
>  .../bindings/timer/loongson,ls2k-hpet.yaml    | 50 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/loongson,ls2k-hpet.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/loongson,ls2k-hpet.yaml b/Documentation/devicetree/bindings/timer/loongson,ls2k-hpet.yaml
> new file mode 100644
> index 000000000000..01656048858a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/loongson,ls2k-hpet.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/loongson,ls2k-hpet.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson2 High Precision Event Timer (HPET)
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
> +  clocks:
> +    items:
> +      - description: SoC apb clock
> +
> +  clock-names:
> +    items:
> +      - const: apb_clk

Just: apb

> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/loongson,ls2k-clk.h>

Your patchset is now untestable/unapplicable because you have a
dependency. You need to explain the dependencies in the cover letter or
in the patch changelog (---).


Best regards,
Krzysztof

