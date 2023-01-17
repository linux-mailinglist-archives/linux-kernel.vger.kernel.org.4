Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2FE66DB74
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 11:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbjAQKrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 05:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbjAQKrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 05:47:36 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E05B2D16C
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 02:47:35 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id g10so21880746wmo.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 02:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dvIcZpPr71LAli4Ctw18NaK663H1wXEFiZ1hnSUC9M0=;
        b=Y+86NVomNfbZJj3bNQA99LzfKbWS1gl9P3M2xDVt54IbzeIw1atZ9k256jeY4iqz1k
         GrzlzHfeZdOytZpecBqdel9sXmGpRdXrrHWqBVg8e4PoCKfkpYkqnQhqfBbOlfzi0uIK
         35DWzJIHZb82vq36jduj5kDx8Cq70WWP10NAkap5YlurQQ/CNeXezt/FU2Du/fUszMsn
         EYhZE1ePjBR+HWxLlX6txelo8DfG9wI6f8D0UIkQlFwpdE9cTNHrkIn1MvDAGppQfJcz
         wblJjHentHrITYgSlMEyYnpCTqqybAfZljFRRc4VOMO+OvvbquMbwywO/VQH/yFFcewu
         zuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dvIcZpPr71LAli4Ctw18NaK663H1wXEFiZ1hnSUC9M0=;
        b=dKpT4mXI7woShJijdACQZV3mfuPKKUP9QKE4wYQeK1CJ0xIio7Gg3Nh4zAlqXSOdfc
         ACqQgMDJapaQjmbapXlmvgC1GB+XiUzRwZxXsWwGseQsCiHSYyZjtYzkED1erTiuZJyt
         nYN65Gs6gHzN8TTQjgKwHkyI1MbLZ9DhC2MaY+kX+yAohR6ZVJ6hqGwyjB4Bi6jYjNuR
         w+lCEG/YdZfVwWpdt78PMEm/2sXrP6TxsLSfLpqRbtjSwGScFdiKWhLCcHB7Pz6Wus8D
         k2deR0lYs2Q+Gzjnnd9cmcTZJgVpN7Qiv+tzu9L3gV3B1RkdqyGRTe4MilYGO24KQ4n3
         Z61w==
X-Gm-Message-State: AFqh2kqMrUr8zPmumSRlh3gyHXWuqODsjR4Zef2o/JhGwniCDSBXygE1
        PrtJeZOSicF5opjkZODt3K5ZjA==
X-Google-Smtp-Source: AMrXdXsUfsCQI3brlhkYMF0HmGM1NDMYajoVu/4uY4pbIRkMs5bSGZzmtTCq2ZDO/aOjIEuDbOFsPg==
X-Received: by 2002:a05:600c:538c:b0:3cf:6f4d:c259 with SMTP id hg12-20020a05600c538c00b003cf6f4dc259mr2514487wmb.39.1673952453939;
        Tue, 17 Jan 2023 02:47:33 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r126-20020a1c2b84000000b003d35c845cbbsm40262609wmr.21.2023.01.17.02.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 02:47:33 -0800 (PST)
Message-ID: <4f56e6b3-c698-0909-17a0-ec8c39b6c25d@linaro.org>
Date:   Tue, 17 Jan 2023 11:47:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] dt-bindings: clock: Add binding for Loongson-1 clock
 driver
Content-Language: en-US
To:     Kelvin Cheung <keguang.zhang@gmail.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230113110738.1505973-1-keguang.zhang@gmail.com>
 <20230113110738.1505973-2-keguang.zhang@gmail.com>
 <63fdd223-c5e1-302d-ffef-9e582874e938@linaro.org>
 <CAJhJPsV5wC_fNgP9iSi1bUp+HFY=dgyh4-x0OueZ8fQO=p7r8w@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJhJPsV5wC_fNgP9iSi1bUp+HFY=dgyh4-x0OueZ8fQO=p7r8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2023 11:31, Kelvin Cheung wrote:
>>> +  "#clock-cells":
>>> +    const: 0
>>> +
>>> +  compatible:
>>> +    enum:
>>> +      - loongson,ls1b-clk-pll
>>> +      - loongson,ls1b-clk-cpu
>>> +      - loongson,ls1b-clk-ahb
>>> +      - loongson,ls1c-clk-pll
>>> +      - loongson,ls1c-clk-cpu
>>> +      - loongson,ls1c-clk-ahb
>>
>> Are you registering single clocks? It looks like. No, make a proper
>> clock controller.
> 
> This binding contains two types of clock, pll-clk and div-clk.
> Should I split the binding to two bindings files?

No, you should register rather one clock controller. Why this have to be
3 separate clock controllers?

>>
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>> +required:
>>> +  - "#clock-cells"
>>> +  - compatible
>>> +  - clocks
>>> +  - reg
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    clocks {
>>
>> No, not really related to the binding.
> 
> Should I remove the "clocks" section?

Yes.

>>
>>> +        #address-cells = <1>;
>>> +        #size-cells = <1>;
>>> +        ranges;
>>> +
>>> +        xtal: xtal {
>>
>> Incorrect in this context. Missing unit address.
> 
> XTAL doesn't have reg property.

Yeah, but DTS is not correct now, is it? If you doubt, build your DTB
with W=1.

>>
>>> +            compatible = "fixed-clock";
>>> +            #clock-cells = <0>;
>>> +            clock-frequency = <33000000>;
>>> +        };
>>> +

Best regards,
Krzysztof

