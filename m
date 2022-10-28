Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847166107F9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 04:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiJ1C22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 22:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbiJ1C20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 22:28:26 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D43BC621
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 19:28:25 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id w10so3238554qvr.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 19:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bOA+bVn8OvkIk1DkOSyvlFEja2ERa4lqiJLWDfoSa14=;
        b=O7v8d8TuS9gfwFW6+u2MrdNqUUDxiF2K6Ysl8z4cX51ihSwPohbAbiNjo3ubadOZ93
         XryfVRMy9Hp/A/lr8mbynRfw8vmFuSuxE9hcKjCyb4rzTau7spR4RiinbOgW3b6Bjq60
         yrgJ4e5f9Ob9WdCOwY31Y10/lVJhYVJePAHa7nt2RKp54z5FF1xR84hGzGp1m6Z0zWly
         G4j3JxGe7jn/lGPBq8R/cmzNp3/oZRRF6cLd5HCFzGXDRzavEhgDJT1LruGCDnoq5lv2
         MCYozuf1eec+wv7tn6MiQGMown7gzuAJfOCK4eGYaeUsoq067InxjX7+11K/Q10KxBiK
         roTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bOA+bVn8OvkIk1DkOSyvlFEja2ERa4lqiJLWDfoSa14=;
        b=4/CQjRGJipy6L1dVTZoemppks//9cO+9X/BBSjUniY6M7xTywjQSPnB2KzW6H+GTRF
         QiF7Mf9lAi7ns5PII6oef5MiXwoIBMf5E8KK7ND/00fcaC8DjHPkiAg+WHc5m9WyRSO+
         M9XhCwxojWeypldXWL00RKHRjLQpm8BU9ScXcxh4PZK3i5bnkRXEDXHlnEhaIZvBclRy
         IGrL9H7uddtTLR4uw8HeQc4pmlx/Pa3H4HwRhS05zr3acJZMRUhHWRRO1hHGJ8/Kk+1O
         jC1A+/DRDUdVDpPLzvwk2rmXpPhRdlKlwVg8Q8WTzpaPd1VWaL79lkWrneVKvDnvkfvr
         RcWA==
X-Gm-Message-State: ACrzQf2jj1lh1TNjBDhKlYoLaOVjMnRa6THT3cMvdyyB7J9C11LVsd3O
        6J8RF+bX5GsgcZJTf3StJK51QBPjqOcQ0w==
X-Google-Smtp-Source: AMsMyM4WPrzp6zFHE5ps4PvSoUdMTx8E9XwnAIMTPA54sN4w8lZZ3eHwUi62u5a+f3wbuLCEsGIWcQ==
X-Received: by 2002:a0c:e34f:0:b0:4bb:5d3a:bd25 with SMTP id a15-20020a0ce34f000000b004bb5d3abd25mr26791757qvm.23.1666924104448;
        Thu, 27 Oct 2022 19:28:24 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id i6-20020ac85e46000000b0035cf0f50d7csm1758139qtx.52.2022.10.27.19.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 19:28:23 -0700 (PDT)
Message-ID: <0737d433-0379-8aba-0ffb-efa278908c22@linaro.org>
Date:   Thu, 27 Oct 2022 22:28:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH next v2 2/2] dt-bindings: gpio: add entry for
 hisilicon,ascend910-gpio
Content-Language: en-US
To:     Weilong Chen <chenweilong@huawei.com>, f.fangjian@huawei.com,
        linus.walleij@linaro.org, yangyicong@hisilicon.com,
        xuwei5@huawei.com, robh+dt@kernel.org, robh@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221028022453.163186-1-chenweilong@huawei.com>
 <20221028022453.163186-2-chenweilong@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221028022453.163186-2-chenweilong@huawei.com>
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

On 27/10/2022 22:24, Weilong Chen wrote:
> Add the new compatible for HiSilicon gpio controller driver.
> 
> Signed-off-by: Weilong Chen <chenweilong@huawei.com>
> ---
> Change since v1:

Thank you for your patch. There is something to discuss/improve.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/hisilicon,ascend910-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HiSilicon common GPIO controller
> +
> +maintainers:
> +  - Jay Fang <f.fangjian@huawei.com>
> +
> +description: |

No need for "|". Can be dropped.

> +  The HiSilicon common GPIO controller can be used for many different
> +  types of SoC such as Huawei Ascend AI series chips.
> +
> +properties:
> +  compatible:
> +    const: hisilicon,ascend910-gpio
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  ngpios:
> +    minimum: 1
> +    maximum: 32
> +
> +required:
> +  - compatible
> +  - gpio-controller
> +  - '#gpio-cells'

Please use the same style of quotes in entire file - either ' or ".

> +  - interrupts
> +  - ngpios
> +  - reg

The same order as appear in "properties:".

> +
> +additionalProperties: false
> +

Best regards,
Krzysztof

