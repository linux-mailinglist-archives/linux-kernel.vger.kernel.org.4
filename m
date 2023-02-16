Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3FA699146
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjBPKby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjBPKbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:31:50 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA9346D47
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:31:48 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id qw12so4084592ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ix4RsbCrDFK7MIuT9pOLARGn8u4bBU4cosvDF8Y/JA8=;
        b=feD5D45mQMyuejZs5iuOhsBp99NaR5hgAQ8+z4JZ2lO5/EYInsZCZn0Ou3fyEUNpnW
         qTJqzSUUZ1+GMmO8W0VerVKTxOTTzaCCMfPwu053PybDXJZkpuTIIMSL3ReXaYTPdPlA
         krB/xjONxBwP5XJg+pPB/rYv3m2cJwmOP2IlsPm7FEAIM2xaOys0XQbSeIDhEoDBAgsV
         gTvglcWD/UMFWeW/aHDamQBNu/LJmquL7Dg908NUVnrqgE5IACTjKjpyzCUvXZSz20a7
         1cxiZIY/3sM6SNamSq79tg1NqbVQq28ZOUxmv+Li5xt8hEv1uPxpSXSCVWyqcoCKiQpK
         L8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ix4RsbCrDFK7MIuT9pOLARGn8u4bBU4cosvDF8Y/JA8=;
        b=hng09wQhBMHLy6VUv5foMUiOgtzIe0jwPZUVwlnzWCU1im9KRJErzp+M1JHusdROCW
         hyTw4c2Q3Wh3nMB94m0wKRAAagoVzffr8Ockh7bIdZSHCuQMDza3Ey3zU6SrvYAe8tg3
         QVNMXuNvM4ijAI5nEG8mqy7Ewbm7ktBlq44gBzUgtnVSb3Ki9N2evwS3ZT5Q3PoQ/ia3
         zDpz4WsmXTD9wUxBG53sHZWoQoUAP4MRlRFF+NJwW//gd1jflnVheqb/p1iRmDq0Y99X
         3zgvtJFoZeXnoqs6rxVXE/A0BOijVcCm3bX8wfYDja2m2qP73JnZXDn9xu9UkunjNDRQ
         frkA==
X-Gm-Message-State: AO0yUKUPqYoi6uB6s3uGMfGD6u8MthgNrdkP2RNAIkaOLjhVOAvcpfYY
        7K+gZcyqMEdmm0Tcxa+ascn3aQmIRfBw/GHw
X-Google-Smtp-Source: AK7set/2E+cbvHdhmkKFbg9OvPtxyGjHcWKjb4JdXvmp5/HA2el/r2zqC/sHNFvf3bGj2LLdFGImig==
X-Received: by 2002:a17:907:764f:b0:88a:7037:855e with SMTP id kj15-20020a170907764f00b0088a7037855emr6326555ejc.9.1676543507189;
        Thu, 16 Feb 2023 02:31:47 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id pj21-20020a170906d79500b008b1268476dcsm622935ejb.108.2023.02.16.02.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:31:46 -0800 (PST)
Message-ID: <8388695b-98f9-223b-1e15-86aaefec2d6f@linaro.org>
Date:   Thu, 16 Feb 2023 11:31:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 4/4] dt-bindings: syscon: Add StarFive syscon doc
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     William Qiu <william.qiu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <20230215113249.47727-5-william.qiu@starfivetech.com>
 <41bcc545-6eda-6c30-c600-d97ef009abf2@linaro.org> <Y+4Fbrz8EYIGyjVj@wendy>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y+4Fbrz8EYIGyjVj@wendy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2023 11:29, Conor Dooley wrote:
> On Thu, Feb 16, 2023 at 11:23:00AM +0100, Krzysztof Kozlowski wrote:
>> On 15/02/2023 12:32, William Qiu wrote:
>>> Add documentation to describe StarFive System Controller Registers.
>>>
>>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>>> ---
>>
>> Thank you for your patch. There is something to discuss/improve.
>>
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - starfive,jh7110-stg-syscon
>>> +          - starfive,jh7110-sys-syscon
>>> +          - starfive,jh7110-aon-syscon
>>
>> Maybe keep them ordered alphabetically?
>>
>>> +      - const: syscon
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    syscon@10240000 {
>>> +        compatible = "starfive,jh7110-stg-syscon", "syscon";
>>> +        reg = <0x10240000 0x1000>;
>>> +    };
>>
>> Keep only one example. All others are the same.
> 
> With these fixed:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> @Krzysztof, I assume the location of the binding is okay with you since
> you didn't object to it & I suppose this one is up to me to apply if so.

Yeah, generic sysreg devices go to soc. If their primary functions were
different (e.g. clock controller which also is syscon), then they should
go to respective directories, but it's not the case here, I think.

Best regards,
Krzysztof

