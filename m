Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8BF706C07
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjEQPCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjEQPBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:01:51 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01B8A5F4
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:00:37 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-95fde138693so23131766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684335627; x=1686927627;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u1G2m3/V/8HwP4S0PilYqw+ntJ6wrr0IYdjxDwg97nI=;
        b=KGGwf+TgQE3MnRRbh8F9ZWrd7mAnUM8CGnhjLSRzEP7eBdZtDzGG8r9cH15QPidrTY
         yNGdaoRLij2m2vk4yF9wQ3wdwVDhXg4ZKccA5K6j9U3lRc/r/vfo+iflvGfjQCIfce0s
         SpLcDsgxsiGJL1KfSZWdYCfPprlt0QjnmOVxFI6UAmoWosvoa6scXeFec1MUvbqFhhA2
         QtoY0wUfTxjbVwxaZQ5TtE79S8Rbp+jvbwanrUIFKLrlpkjUwk3WshLMR+18gmvifTFs
         kNhjU1v1QwAba8Umv1KoaJRvXo2IZUYVBC11kMyEb/TjWc+uzI6MYel0w8b3ANUkt4pR
         foYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335627; x=1686927627;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u1G2m3/V/8HwP4S0PilYqw+ntJ6wrr0IYdjxDwg97nI=;
        b=TA2MLpk8xJkXFBf75byKcqe61+F6GQH2kkpc7VRFXq/ukUj1vLfcviwZ/nmYwlEd3Y
         IY6a9bRKBxvmLCmrqtZe7PvYA3JXHYtGnIblvdC6d8bdlKKTvBjBtPGJ5EfzxiEcKss/
         jleckXHpD+zOGH+2bY4Gt7J7OxOMWHXwMUZ8WwUXSXP64dylkbra8uXlKIamVry5WHIH
         67EZ27S7IA7uwmnE0yFs7ddbijIQtkptzt2KNZNd/0uU9FzyzH89qCQmK22kC+rfIxQr
         iXI3Jm6KPvxHbFjErJh8YE6y6zFhWObrtSZVGb/A1QPCTlZSSkOqhBc87vchplzo1BYh
         YwGQ==
X-Gm-Message-State: AC+VfDw2iUXdQAhkOd00RpFw4nyBqPwPU0+MdnfO5CDXbNjftM8zPcp0
        R7sAjDXe+NLldPk0Z5EymqN6KQ==
X-Google-Smtp-Source: ACHHUZ6wgsqOiRJf4xmcSwbV6QggqmsGx/cjJKJNST88Bdd9lOPCs5cSMTYn0pICtw84HRJnXKbqFA==
X-Received: by 2002:a17:907:d21:b0:94a:57d1:5539 with SMTP id gn33-20020a1709070d2100b0094a57d15539mr2566510ejc.5.1684335626891;
        Wed, 17 May 2023 08:00:26 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c9ff:4c84:dd21:568d? ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id bm11-20020a170906c04b00b00965ec1faf27sm12391114ejb.74.2023.05.17.08.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 08:00:26 -0700 (PDT)
Message-ID: <d3791702-4d41-0208-1346-34738a2883b6@linaro.org>
Date:   Wed, 17 May 2023 17:00:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 2/3] dt-bindings: soc: add loongson-2 pm
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Marc Zyngier <maz@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Baoqi Zhang <zhangbaoqi@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, Yun Liu <liuyun@loongson.cn>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230517073149.31980-1-zhuyinbo@loongson.cn>
 <20230517073149.31980-3-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230517073149.31980-3-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 09:31, Yinbo Zhu wrote:
> Add the Loongson-2 SoC Power Management Controller binding with DT
> schema format using json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>

...

> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - loongson,ls2k-pmc
> +      - const: syscon
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
> +      This option indicate this PM suspend address.

This tells me nothing. Drop "This option indicate this" and rephrase
everything to actually describe this property. Why would the address
differ on given, specific SoC? It looks like you just miss compatibles.
Anyway this needs much more explanation so we can judge whether it fits DT.

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
> +        compatible = "loongson,ls2k-pmc", "syscon";
> +        reg = <0x1fe27000 0x58>;
> +        interrupt-parent = <&liointc1>;
> +        interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> +        suspend-address = <0x1c000500>;


Best regards,
Krzysztof

