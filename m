Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BD4642397
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 08:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiLEHbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 02:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiLEHa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 02:30:59 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E723510064
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 23:30:57 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bp15so17130891lfb.13
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 23:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ic6F8QFCJK13ebf9asWvu6VyveRvaroZzcFBrpHB3Nc=;
        b=Qq4IFm0i4P/LFoDZKUn2+/rtTIoRv5thuIbrz0XBnAyu3AEn7V2FNqZoUTfzaGV+gy
         BY72zOHlUP/wv1LSN/dyZJLQkhGOu5n6q43ypzUObe4hAGjjiGuyhxa8JPWr8ZzNQZZe
         ytN3Dhh4aPVxiitji9JQse26dzXnYQnRfN6ZeYJSKyz9wP8+513YDHI5sX/ds5IDb10E
         V8at/+WnV1FgKjbfkOjpB1GewQys8cDF0mWGh1S/QNBz7p94cNvD/K/l/15R4U8gV+3T
         f8DYACT+Jj/X22clRfhvJGMTjcKKc16vfMmPQ2XGo5W7u5LvORxeyRcngkImmvm0MBbE
         LBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ic6F8QFCJK13ebf9asWvu6VyveRvaroZzcFBrpHB3Nc=;
        b=dNOKMtZ+rZBxOk5PJgaEhwTFVjXN2XqCLl/I3B8A4rPMx6VptXPOzIqJXKpaxFjdhS
         e03Nf3ARR5UkY7B1pym9krC4q6MJTihVO9Vh3DjayLqnIzxe/l3eou6s51H6V9n/lKJ5
         m961PymYAq910tmjAK4OTGPbBDwieERQnlxX8mSj277le6TwADh+qpvNt3w6k3VJhGFK
         IF3Ku56GpbK2MtLzY30s4hpGkB2Z/YvhRemLVGYuxzNltXFTF8MNyE6mcw1tBuSx8M1K
         U81GpU2I2BLPpNSilJ3AJmyfE5eOCBOAcWAJta0Uy51ftcKXAbBYMVi07Ei61YRutS8W
         rrZg==
X-Gm-Message-State: ANoB5pl8wJKXljdGZGg9ggooMo+qpRMFRB3qMNVXhr/nvVNV7PnkxRxX
        eVz7x3lxgGk14BxFDdi+dJZ339FnJrUu2+FPhNQ=
X-Google-Smtp-Source: AA0mqf4PVweKhUkPQ+6ewoxxuSwatBKT8xqhq+m8lOVYNmSqJASY6f8sMB6+9CprV3sdvonxsW9kEA==
X-Received: by 2002:ac2:50c9:0:b0:4b5:7dd6:4df5 with SMTP id h9-20020ac250c9000000b004b57dd64df5mr138521lfm.410.1670225456216;
        Sun, 04 Dec 2022 23:30:56 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id t26-20020a056512031a00b004a03fd4476esm2027492lfp.287.2022.12.04.23.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Dec 2022 23:30:55 -0800 (PST)
Message-ID: <d6f3d8ac-4fbe-40ca-299b-046973cd0b25@linaro.org>
Date:   Mon, 5 Dec 2022 08:30:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v1 1/3] dt-bindings: watchdog: Add watchdog for StarFive
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
References: <20221202093943.149674-1-xingyu.wu@starfivetech.com>
 <20221202093943.149674-2-xingyu.wu@starfivetech.com>
 <cb8deb55-902a-0058-4764-a5f391f8de6d@linaro.org>
 <e0551ed7-2208-6d08-235b-993702f0d89b@starfivetech.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e0551ed7-2208-6d08-235b-993702f0d89b@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2022 04:49, Xingyu Wu wrote:
> On 2022/12/2 18:46, Krzysztof Kozlowski wrote:
>> On 02/12/2022 10:39, xingu.wu wrote:
>>> From: Xingyu Wu <xingyu.wu@starfivetech.com>
>>>
>>> Add bindings to describe the watchdog for the StarFive SoCs.
>>>
>>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>>> ---
>>>  .../bindings/watchdog/starfive,wdt.yaml       | 77 +++++++++++++++++++
>>>  1 file changed, 77 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/watchdog/starfive,wdt.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/watchdog/starfive,wdt.yaml b/Documentation/devicetree/bindings/watchdog/starfive,wdt.yaml
>>> new file mode 100644
>>> index 000000000000..ece3e80153a0
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/watchdog/starfive,wdt.yaml
>>
>> Filename should be based on compatible. You do not allow here any other
>> models... If you intent and you are 100% sure you will grow with new
>> models, make it maybe a family-based name.
> 
> First, thank you for your reply. We have some other SoCs like JH7100 would use
> this watchdog driver, but we now use JH7110 as our main release chip.
> As you say, should we use "starfive,jh71xx-wdt.yaml" as filename?

starfive,jh7110-wdt.yaml
I would say because you do not expect any other models (const for
compatible, not enum)

Best regards,
Krzysztof

