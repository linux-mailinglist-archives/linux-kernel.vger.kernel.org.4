Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39CB639667
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 15:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiKZOY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 09:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKZOY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 09:24:57 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1164118E1F
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 06:24:55 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id d3so8183738ljl.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 06:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6vLna4taitqPmXLIIkapuDDCcusBIaRbdtMepRsT1Lk=;
        b=bI/p49EaYjuVNxAB0YHtI/ULp6a34ypk7UGk8rPTjXj/5EGsGX9EIKYdE7ktAR7y/5
         HyDXWltCIJFyUhUilDAEmCLBbazUzVMG+7a0FbLVh21BRg0xE64M+3WJUlngnejDx0Td
         dTw6sqoCTcC4Bu4EV7ix1Sq2ffm9B5Mht+EWCubU1CD/NQ1G7UMMErff8PCKZ0jTAsGN
         jp4FTrDEblJ0SE0GlRxk37Jj+puqMl+N/yxMlxj6O/oryZsq5no3XMJ4RltHJwCHV+iX
         5tx/HfJYdaB/O8X9WPPPtI9e/bhe746amcH0JupCys9/jrWctaPYQNGCs/vu0UCVfuJ6
         d1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6vLna4taitqPmXLIIkapuDDCcusBIaRbdtMepRsT1Lk=;
        b=AbY7vUtCcaFqwkFeGcl3qGsNpLMpC62gJo+zM3HyRwNHD2VSOKwRAtjVPsrF8vRef4
         b+MVIfm2GJGpDQV7Hrtfw6IJ29vuRBMwBO4Hf1aMfiBE8Dr4fw2ixcRE/SlX52bdzJhT
         CQ5JyNhjuZHgm3cncqZnVBgv1zmWS8wKvkzdriFSvz0pO4F+Zf9GeIiHx4l9ImLjuRxs
         PZWnYBklfje/Kb8DOCtSTWH5x8FH3xAskA5VUKxFezi/NDbQxLiVkPmuEImBj6/i4wVJ
         CmjUU4w3LRkRraklIy4xh1OSxNPm8+xZC2VyHQkAdUjjMez+3RQqhCSSNPHrgok7wvye
         Gu9g==
X-Gm-Message-State: ANoB5pmkqHRSoIKwl3OFJhYxJLNw+dQI6eqv+vu0iyadwDvsIwWXhChu
        +qxUHARXw7Ei+2kafcdXHnAq4A==
X-Google-Smtp-Source: AA0mqf6bMS826cl9TH4JOInpUf9DZmNCB4YgAJ67hHhc1az7C1ec/rGdofviQdcKs36HpKCtZBLcgA==
X-Received: by 2002:a2e:9194:0:b0:279:7ffa:15aa with SMTP id f20-20020a2e9194000000b002797ffa15aamr4788408ljg.307.1669472693437;
        Sat, 26 Nov 2022 06:24:53 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f13-20020a0565123b0d00b004b0b131453csm956821lfv.49.2022.11.26.06.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Nov 2022 06:24:53 -0800 (PST)
Message-ID: <54f500cb-d7d0-8af1-eb58-99fbe71791a5@linaro.org>
Date:   Sat, 26 Nov 2022 15:24:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] arm64: dts: amlogic: align LED node names with dtschema
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     neil.armstrong@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221125144141.477253-1-krzysztof.kozlowski@linaro.org>
 <3719828c-0ac5-34c9-a04b-251cbeb5f6ef@linaro.org>
 <a135f93a-235a-27b8-f649-69d62f6ebd30@linaro.org>
In-Reply-To: <a135f93a-235a-27b8-f649-69d62f6ebd30@linaro.org>
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

On 26/11/2022 15:16, Krzysztof Kozlowski wrote:
> On 25/11/2022 18:16, Neil Armstrong wrote:
>> On 25/11/2022 15:41, Krzysztof Kozlowski wrote:
>>> The node names should be generic and DT schema expects certain pattern:
>>>
>>>    amlogic/meson-sm1-bananapi-m5.dtb: leds: 'blue' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>   arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>
>>
>> <snip>
>>
>>
>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Aren't you maintainer of the platform? This means I should take care of
> this patch?

Ah, this will be picked up by Kevin or Jerome? So this tag means only
Reviewer's statement of oversight, right?

Best regards,
Krzysztof

