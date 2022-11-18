Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CFB62F521
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241870AbiKRMka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241857AbiKRMkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:40:23 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E5A41995
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:40:22 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id c25so6599172ljr.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/zLTYsXHR/2HWPYQijXGBO91u/5WmcoUCXMlBqcrLxE=;
        b=NqmKwrLbeZtYmWVypNV9cw9sVY8Uh0yA6ockCssS1ZW75SofXF8qdOtqUfQMry96sv
         leC+y7V2WvnDfbLwbzkDg7ztJnrcxoL4uCBqz+kxduqpJev0UsmRsmKTtJ9uTfZI9HXe
         6zoekzQEulbmlkQb6I2l43uKgmjdGK4lDzGm75xdRNxTrnernduIDMEE2W3BQy7JUDF4
         4KY2uWtn4Q7DhPosMCKq3qvVUYy5nzDYvyP/NkGaDRz9OcXUyjkWGey6hlmY4/nsv/3m
         EaV2eXIkvpidckVPkoycILrmEh/Xdsx10yTDgRgIYEAeYBmWToOrGwFcCFJZ2NvHTNrS
         v3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/zLTYsXHR/2HWPYQijXGBO91u/5WmcoUCXMlBqcrLxE=;
        b=RGhnkIkMKjxG7uILNuB8e957VS3meTKrDAoU2Ej6UfEL2KWBh8GB8Gefsc0skj0nCa
         D/VdvRUz56WIwFPvKxCvV9Y10mbGfpWPjboevHz749anRJFZgnIJ67foumXRxGUtIEvc
         sSQe2q+xH1tcVOZaHU/LG49/6z07lGCF9VjEo32uuXdYvZFmL6GCPki3sCvH0YK/bWZU
         2PqNDlzjs9gtUwKmgVSlIsWbEnj/N4OtPM0kKQQmo+LWSpHnXHJ+ULkuWC9ZcXscWkvV
         TMwOA1NSOP3c7mggs221KC3R7hnBPAcq4RaQEU1JhdXo4S3+a2kO0CqX0qi1DodXwvYB
         6wIg==
X-Gm-Message-State: ANoB5pmdP3FyMm9qTSZXks6hjHrADRAz8V4pusQ1cot0ZRwKcKhP7G+c
        b4SCGZCyT9I+sms8hx4jcxZcGA==
X-Google-Smtp-Source: AA0mqf6JHaqd3SdG/FMh7z7NgcZ5t7HsgeEP1/ln5CmlzAKzsWOfgilv2P8o79vy350QVlD7csdD3g==
X-Received: by 2002:a2e:b10c:0:b0:26f:bd6e:7f7f with SMTP id p12-20020a2eb10c000000b0026fbd6e7f7fmr2456769ljl.87.1668775219007;
        Fri, 18 Nov 2022 04:40:19 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k11-20020a05651c10ab00b002793cf0e9e8sm48983ljn.122.2022.11.18.04.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 04:40:18 -0800 (PST)
Message-ID: <13c5292b-4f04-0f85-98a2-bf4b5265b567@linaro.org>
Date:   Fri, 18 Nov 2022 13:40:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/2] dt-bindings: gpio: add loongson series gpio
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Juxin Gao <gaojuxin@loongson.cn>,
        Bibo Mao <maobibo@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        Arnaud Patard <apatard@mandriva.com>,
        Huacai Chen <chenhuacai@kernel.org>
References: <20221114095332.21079-1-zhuyinbo@loongson.cn>
 <20221114095332.21079-2-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221114095332.21079-2-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2022 10:53, Yinbo Zhu wrote:
> Add the Loongson series gpio binding with DT schema format using
> json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

