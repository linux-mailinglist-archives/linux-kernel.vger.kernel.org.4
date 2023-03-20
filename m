Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F416C1D43
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbjCTRHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbjCTRGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:06:22 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D125337F0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:00:55 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id w9so49446399edc.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679331529;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kFJSUgHgBA6fVjFOsVCUCNBjQjOx28L2GR1TCgVlFOc=;
        b=W8As8Ll2/NNCTKQ9Q+jQVxl8E0yPpC9bLHIZeJ32/VvJ0cyu8AuJpn0Zqg2Q+M8/am
         eN5/n3mPZjyU9FzEq/YNSLL+FUexL42AZkq9CykB4ofEISml0GVXbisacjLlaUbVHiqR
         UlFWNTnhZ8jEHiQFB3Dwmhf1g21EfHl5iRA3Eu6htng/T+m9bYIrNbByNStUmibb4Yz+
         cpWwLSUpYIGSzv4VDEKbr8mSZW0xs2SAdWMsnO1tSDutKTbCGHjrbyqALZvPaN8qQZEU
         k4xiYcSOrzL+jXDkDYD6QDI1Hs3+BkzF7CU68xaJWDv+DN+OU6iYV1XRtUwzOb6HVVf0
         A8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679331529;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kFJSUgHgBA6fVjFOsVCUCNBjQjOx28L2GR1TCgVlFOc=;
        b=yi+g/yeJi0ZBI57WElZjIcZ5Z5xVPHYzuUfmG+BhWLbQTUfMJb3gs+US5gJZen1lOs
         0rkxhD5QN++bAJTDP7snhcvSyWCvU1vqhfym4joSXB3FOlajrtfB0NgFy8OQ/YfzNF+i
         r1hGwU4KppyddFQYsNYBcrjV6Wi9mc8eQSLYQU33MuatOdtU31NPo5y3dovtw9VQhL+M
         SzB9GbCo/WAOjwxQfuOfYdPseCSJ0JJ8V/WF1OJzj1cx6Zt7vGTGkfhCUYl9OkX1L4F9
         uZXaANofdnOlfVPHjw899XU2m388OE0JJGKN/0pKv7lHBmWU8ygN8uxFtzjJUum43d/3
         jrPg==
X-Gm-Message-State: AO0yUKXzd1nI1RxyNMjPZoGGSZdC6cSI4Xgi6Vq4RMlUmRnL1/Vxudfc
        mzMXwX2rS1OpAzobctKHOAJzUI0V0v2X2RhzgbU=
X-Google-Smtp-Source: AK7set8b9t2ZFlGF1WY07Zu3lWziOZGj1aKUfLhWe2QE7mDcO8rGB3IIiBBozLUDLT39ruGI1pOJeQ==
X-Received: by 2002:a05:6402:150e:b0:4fe:96a9:ab0a with SMTP id f14-20020a056402150e00b004fe96a9ab0amr207881edw.1.1679331022727;
        Mon, 20 Mar 2023 09:50:22 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:458e:64e7:8cf1:78b0? ([2a02:810d:15c0:828:458e:64e7:8cf1:78b0])
        by smtp.gmail.com with ESMTPSA id i20-20020a508714000000b004fc649481basm5185947edb.58.2023.03.20.09.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 09:50:22 -0700 (PDT)
Message-ID: <182d39e4-fa11-c914-7015-80bd68c91596@linaro.org>
Date:   Mon, 20 Mar 2023 17:50:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 01/10] dt: bindings: clock: add mtmips SoCs clock device
 tree binding documentation
Content-Language: en-US
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org
References: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
 <20230320161823.1424278-2-sergio.paracuellos@gmail.com>
 <1e2f67b4-3bfb-d394-4f60-e6f63ce6a2fd@linaro.org>
 <b98429b7-2932-6bd5-39bc-f82c747b4333@arinc9.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b98429b7-2932-6bd5-39bc-f82c747b4333@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2023 17:43, Arınç ÜNAL wrote:
> On 20.03.2023 19:36, Krzysztof Kozlowski wrote:
>> On 20/03/2023 17:18, Sergio Paracuellos wrote:
>>> Adds device tree binding documentation for clocks and resets in the
>>> Mediatek MIPS and Ralink SOCs. This covers RT2880, RT3050, RT3052, RT3350,
>>> RT3883, RT5350, MT7620, MT7628 and MT7688 SoCs.
>>
>> Use subject prefixes matching the subsystem (which you can get for
>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>> your patch is touching).
>>
>> Subject: drop second/last, redundant "device tree binding
>> documentation". The "dt-bindings" prefix is already stating that these
>> are bindings.
>> (BTW, that's the longest redundant component I ever saw)
>>
>>>
>>> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>>> ---
>>>   .../bindings/clock/mtmips-clock.yaml          | 68 +++++++++++++++++++
>>>   1 file changed, 68 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/clock/mtmips-clock.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/mtmips-clock.yaml b/Documentation/devicetree/bindings/clock/mtmips-clock.yaml
>>> new file mode 100644
>>> index 000000000000..c92969ce231d
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/mtmips-clock.yaml
>>
>> Filename matching compatible, so vendor prefix and device name (or
>> family of names).
> 
> I influenced Sergio to use MTMIPS here as I want to designate it the 
> family name for the MediaTek MIPS and Ralink SoCs.

I don't know how to respond to this. Is it argument for not using naming
style?

> We can't change the 
> compatible string as it's established from my pinctrl patch series we 
> don't do that.

The patch did not say it is documenting existing compatibles in the
kernel DTS. And if we are at this, ralink,rt2880-reset does not look
like single clock nor like clock controller.

Best regards,
Krzysztof

