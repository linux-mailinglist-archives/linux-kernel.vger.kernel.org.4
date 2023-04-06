Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531F76DA06F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239605AbjDFS6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 14:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239799AbjDFS6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:58:11 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293E330C1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 11:58:09 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id qb20so3736687ejc.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 11:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680807487;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z4laVqvDzX6NVLaZ7/XvxDcJwyPyRVfzt8CESBHu0Is=;
        b=VAr8/ifN5KAg3loChJriSbYYFNzuy9HoEtWTu7+b37s0CEC9NvOyH1AYzOgS88W0A3
         blYZjuR1jHENqHvoxPy4bdy8DXQyPXzXLc86KcPBZJjDXtmEU1GsNS0RbwAUVTuce+l2
         wsISQDGSV0q37EjjhxOzblhH9T5MRYdY+9TAcYJhPWBmZiDV6eax0BazAd/OCayoVZ52
         IYpKMW86Mw1Cqm87jQTVv0yDjm/NKX3o+3cli66+/L6cZmuUAFuHWJs6PvMgdO02qOCp
         XBKBykeVGZsP+SlUh3NmtijtJycs8dVwyszLif+bjTtQIwekEk0F/KrhoJ6XBMwjVd80
         dcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680807487;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z4laVqvDzX6NVLaZ7/XvxDcJwyPyRVfzt8CESBHu0Is=;
        b=1Jwe+OL7qoxZbfowd7gVUXfb9S7C50pI65tSNifmvuMjeLOHkEBWGqc/7AikoHvdxQ
         V4jwM4AXSZx2BpDGl44breL2TiwpuHa09E8HnX6I5mAxgKpOP0ZpfXAuw8lnLCNcbYhF
         Q7yCKLMqSBQl4aiungIhP51wRigRJYnCfuUo/in16eG1Cpm4GIrXI2eCAH2hvJ6cguHm
         GcBMJIsS6tAXahVkBgQD4/cuhUvAngOvbXXSoK8Vhi9lg26mc+u5NaKCYk7JRZiBbYy1
         /67UYAl8hKrJ+gsIrsgDbeb2IKBZ6DhOTD8ed5pqiQIk0wRqJ013ROpTp2hW9MnndJv1
         2UJQ==
X-Gm-Message-State: AAQBX9fSpAHHYixxZZWenFhDaTw/KinXfHKi+OyhMQjVn8/oCGFceo1J
        qPTfi2pGAzjikMdMNVI95UeHCg==
X-Google-Smtp-Source: AKy350b+jnaYTB7EvEGGB3HZJ57CP7XCCDhy1CDUWipMsmKS+z/iO6WOJEDrDVeYp/cHH5uNjDZLag==
X-Received: by 2002:a17:906:828f:b0:931:462f:f141 with SMTP id h15-20020a170906828f00b00931462ff141mr6222885ejx.20.1680807487576;
        Thu, 06 Apr 2023 11:58:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id gv11-20020a1709072bcb00b009273859a9bdsm1129456ejc.122.2023.04.06.11.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 11:58:07 -0700 (PDT)
Message-ID: <df75afe8-0926-6725-f7aa-f26d6a6be79f@linaro.org>
Date:   Thu, 6 Apr 2023 20:58:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/4] dt-bindings: iio: dac: add mcp4822
Content-Language: en-US
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230405140114.99011-1-frattaroli.nicolas@gmail.com>
 <20230405140114.99011-4-frattaroli.nicolas@gmail.com>
 <748c4391-1c8c-8fc2-cef9-6091512c77ef@linaro.org>
 <4357039.nDxAD4yF8u@archbook>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4357039.nDxAD4yF8u@archbook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2023 16:17, Nicolas Frattaroli wrote:
> On Mittwoch, 5. April 2023 16:10:10 CEST Krzysztof Kozlowski wrote:
>> On 05/04/2023 16:01, Nicolas Frattaroli wrote:
>>> The MCP4801, MCP4802, MCP4811, MCP4812, MCP4821, and MCP4822 are
>>> SPI digital-to-analog converters by Microchip, which have an
>>> internal voltage reference, in contrast to the MCP49xx series
>>> of DACs which use an external voltage reference.
>>>
>>> Thus, these need a separate binding, as to not overcomplicate
>>> the mcp4922 binding.
>>
>> The difference is just one property which is very easy to handle - one
>> allOf:if:then: with
>>     vref-supply: false
>>
>> Are there any other differences?
>>
>> Best regards,
>> Krzysztof
>>
>>
> 
> In place of the external vref input, the MCP48XX series chips also
> have a "SHDN" input, which is an active-low pin to disable the whole
> chip and put it in a low power state. Future users of the bindings
> may want to model this as being tied to some GPIO, though I haven't
> done it here since I don't care about this feature.

OK to keep them separate, but then you should add here powerdown-gpios.
Bindings should be complete.

Best regards,
Krzysztof

