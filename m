Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F136F6943D9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjBMLG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjBMLGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:06:48 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB54F18177
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:06:38 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id k3so4117268wrv.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E1kDvgegzp8HWEVBLAzdwEfk/Chnh0ftRbXNmWsD8bo=;
        b=jOJiSmkmlAxMHR9ru/D7S60yONeX2jqwTsk0E8f9Y0JLDobSdLnNTVoz5yM4pzYvtH
         VSJS7AiseXZJGTo1RKr2M6VDP0/4QEFXCahPPyQJY/pLaURrO3RKCTxRfxXIGEWxPoVd
         7Yeo0HFE/uJ4Q0xMpXGl5nGaYQNBlewpkscThoMr2muEjUIYHnd6H1/adHNSPbOdU8ia
         u5Lv/uAAB0+NfGIRVOlxPxfbHCBmuZlo6xreNhVWT1GJgSaMYpl3dBr4gSZAbI0d0tkM
         FrnTDJ7xxal3f8GpHjv3qhl0DOtVg/fnGyyCg9u0Ng41JELx8N8VBC5DqYveIyEvIbZA
         TOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E1kDvgegzp8HWEVBLAzdwEfk/Chnh0ftRbXNmWsD8bo=;
        b=hwTlC2aAmjn67ObIBYgy510q7bln0EkpHXQcbSMfiPPmXsIYuqf24+mPRvVSnfs3ug
         P6KV/dTEzcV/5+BXTNQ6yg6PGxLKrds4ItuNOIgYfCk9oSemty1jqbfvVKXA1dV9e/Sr
         oNouXqFuywfdkpCMsSt2q6jFSgaYXQVFdF+IS+dCkC4CKqpS34lFoFEtfePJ+pIc8HYR
         1D/cwCd0Br2BWvBkH6iFOnObXqSS3NCfny3tlgaII6SqGJ6428SqHpahKiPbapHhJwpY
         eZI/yHcPAmIBbuu/y3dyQ/QK/fj10oPPrYilHsVU56DZ9p4NyQRvwH3JrBiivQ9QlAFP
         kgKQ==
X-Gm-Message-State: AO0yUKVhEwxrl8mJ8oPCRcg+46hAwAo6ko7UUOXGraHQTnigm3NzwkIR
        lcbxq4LJtcBF2k5c0Sf+IhYZ1A==
X-Google-Smtp-Source: AK7set/w9dCD3bxFSNonkfKDpD4T2DRe0uU35pPoh3abEZ0xxxlBew9+lTJCPWJGeRsvZUh6Kx49DQ==
X-Received: by 2002:a5d:5545:0:b0:2c5:3cfa:f7dc with SMTP id g5-20020a5d5545000000b002c53cfaf7dcmr10443422wrw.7.1676286397447;
        Mon, 13 Feb 2023 03:06:37 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d6551000000b002c54c8e70b1sm7211342wrv.9.2023.02.13.03.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 03:06:37 -0800 (PST)
Message-ID: <5d6ca298-19c2-3fcf-b025-dd72fa0784eb@linaro.org>
Date:   Mon, 13 Feb 2023 12:06:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 6/6] dt-bindings: soc: amlogic: update sysctrl
 clock-controller subnode type
Content-Language: en-US
To:     neil.armstrong@linaro.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20230209-b4-amlogic-bindings-convert-take2-v1-0-c4fe9049def9@linaro.org>
 <20230209-b4-amlogic-bindings-convert-take2-v1-6-c4fe9049def9@linaro.org>
 <f18230c9-7c9b-9e59-993f-24d40b74ba9d@linaro.org>
 <039e9f93-5b97-bb5e-e3c0-b8bf2c52a2a3@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <039e9f93-5b97-bb5e-e3c0-b8bf2c52a2a3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 12:03, Neil Armstrong wrote:
> Hi,
> 
> On 13/02/2023 12:00, Krzysztof Kozlowski wrote:
>> On 09/02/2023 14:41, Neil Armstrong wrote:
>>> Since the clock controllers are now documented define the right ref
>>> for the clock-controller subnodes and fill up the example node.
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>>   .../soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml         | 15 ++++++++++++++-
>>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
>>> index 672eabd90c09..57eae355f1b9 100644
>>> --- a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
>>> +++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
>>> @@ -43,6 +43,10 @@ allOf:
>>>               - amlogic,meson-gx-hhi-sysctrl
>>>               - amlogic,meson-axg-hhi-sysctrl
>>>       then:
>>> +      properties:
>>> +        clock-controller:
>>> +          $ref: /schemas/clock/amlogic,gxbb-clkc.yaml#
>>
>> You just added this binding. I don't understand the split.
> 
> It's a chicken and egg problem, the clock controller bindings (patches 4 & 6)
> I've added the system-controller top node in the DT example, but this
> example won't be valid until I add the system-controller bindings.

Just drop the parent node or even entire example.



Best regards,
Krzysztof

