Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261DA6045CF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbiJSMuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiJSMtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:49:10 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2548A127BD2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:32:11 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id w3so11500240qtv.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=whlykbQsNRDmBUFhZqH43vmu3PG1yI/9OA5fIpYLMqI=;
        b=qNV4e3eA/V25xQDFfA53+l3QpBYZ4hKhtUdH4C2TCUXYtZUJv1WoLDiQtRweDm9KwA
         GDuxKtKUYvRSWkZmN+Qv1Hjx2cRuHBRZJDkmJiySsa43OQBtwlznBctHWmzUeulQ0I43
         hfQDS21yFxMeZWGtCGpsjLPh1BADnewcVXX7uhtEOomWZpPsZVjcTZXoykB9OcxdeGp/
         zZHRvksJn5SYp++R+TLj1PrPd52JoulzvzNxxyvKJk2Lt+eqTA6pNH0mZzy5c4FnzYy8
         t3n5IB4dXC6cauJXazobwnH2cenhVPsKfnpLPU1TSUTkGF2pYf6/v+I84sQqiGYRxPZl
         InCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=whlykbQsNRDmBUFhZqH43vmu3PG1yI/9OA5fIpYLMqI=;
        b=tA6zvJyPWvpkMbkJ3H9fn4fjrfPFRjlMgZuclJjkuqFB/61gHpqkNfRBRVqQpFTkm1
         mI6HJlpz9mMGMa7wgL6SBH/BsIkXKDZ8bkVjmESE/v4MBDl7+WRV5wKiewyAcWwnVlXh
         +qEq6h+bidZKip0lN86R90eRki8c32GTI9dKy+XsXwp+9QGu2ervyVkqw4x3JDwlPAJk
         XxEzMtJAv2whB4T1WiLdFOC9sq4dWJ2jOp6yz3ZivFpwCKnKh2Qt0hHNQ6ojHQ4zNGoJ
         W+VBaU2xtpm+zkSIgicHxjXZOZXj+hiHKZ3dGjc9ZcRsAWQgRs0tAxhvLFHtQNW2C/8p
         yHGQ==
X-Gm-Message-State: ACrzQf3E7mdCekNIpxSG6KAihyYpMX28xBhK3wLZbK8hBF7XczzM6Erc
        hWtmu/0aiaLv4ESvRdhdVzIZeQ==
X-Google-Smtp-Source: AMsMyM7bUSOzzZ6K0iuspDrCqy2b1YagSH5wAqYiNXw/7EInOLjCDS1oLVxV6rMmh9ZpGER8tXYtrg==
X-Received: by 2002:a05:622a:15d1:b0:39c:f1da:fe0e with SMTP id d17-20020a05622a15d100b0039cf1dafe0emr6113062qty.662.1666182672542;
        Wed, 19 Oct 2022 05:31:12 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id h3-20020ac87763000000b0035d5e5660cbsm3899065qtu.59.2022.10.19.05.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 05:31:11 -0700 (PDT)
Message-ID: <9e3fb6b4-c929-66b9-a1de-d39f2893c37d@linaro.org>
Date:   Wed, 19 Oct 2022 08:31:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 3/3] dt-bindings: clock: add loongson2 clock binding
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
References: <20221019062912.3463-1-zhuyinbo@loongson.cn>
 <20221019062912.3463-3-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221019062912.3463-3-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2022 02:29, Yinbo Zhu wrote:
> Add the loongson2 clock binding with DT schema format using
> json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>

Drop redundant (last) binding from the title.


> ---
> Change in v2:
> 		1. Drop "Binding" string in the title.
> 		2. Drop entire allOf and move the contents to top level.
> 		3. Change string "refclk_100m" to "ref_100m". 
> 
>  .../bindings/clock/loongson,ls2k-clk.yaml     | 64 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yaml b/Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yaml
> new file mode 100644
> index 000000000000..104e38a618e2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/loongson,ls2k-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson2 SoC Clock Control Module
> +
> +maintainers:
> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
> +
> +description: |
> +  Loongson2 SoC clock control module is an integrated clock controller, which
> +  generates and supplies to all modules.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - loongson,ls2k-clk
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: 100m ref
> +
> +  clock-names:
> +    items:
> +      - const: ref_100m
> +
> +  '#clock-cells':
> +    const: 1
> +    description:
> +      The clock consumer should specify the desired clock by having the clock
> +      ID in its "clocks" phandle cell. See include/dt-bindings/clock/loongson,ls2k-clk.h
> +      for the full list of loongson2 SoC clock IDs.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ref_100m: clock-ref-100m {
> +        compatible = "fixed-clock";
> +        #clock-cells = <0>;
> +        clock-frequency = <100000000>;
> +        clock-output-names = "ref_100m";
> +    };
> +
> +  - |

Drop this. This splits examples into two separate ones, but you have
here only one example.

> +    clk: clock-controller@1fe00480 {
> +        compatible = "loongson,ls2k-clk";
> +        reg = <0x1fe00480 0x58>;
> +        #clock-cells = <1>;
> +        clocks = <&ref_100m>;
> +        clock-names = "ref_100m";
> +    };

Best regards,
Krzysztof

