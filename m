Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2235A63D592
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 13:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbiK3M1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 07:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbiK3M1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 07:27:13 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0535E74A94
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 04:27:12 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id s8so26697881lfc.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 04:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dI1rcDm2izo91a4xYpDxT/SLBcJ/F5Ad/wzzFCiV+VE=;
        b=Ji445Whez+WyQciiZuyiJmg9wIw+mMslsDzUx2Q5q+VuLSsSCaMsGA0band7jhsste
         q29kC52WC6Lp7l2/6ARvcEH8jbvM5DcbRpXbRSBIk9Opw8A2sc+WXtPpiLliXrwcPXvO
         tgXSLjgPugXRe9QR6oNwiDRVo2q2qjOXOkHLKl0suJTb3JBAIrYXn8KkzUl6tMRZDVGM
         DLwagTVcZvHr+0WmfdXdIGhID87hi+Q6SeDwEndVXX+P0K9MC2OU/MafUGxViYc36L0O
         l3164KBJPJSaxIsuocM6PQpz9UztAz5jqocXDSuz6gFg4ige6SQm5faDr8PAp41fqR4l
         Rq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dI1rcDm2izo91a4xYpDxT/SLBcJ/F5Ad/wzzFCiV+VE=;
        b=ChxLkUIUg1VoloYkjwhOpewlP22DSm6JNJHFBhZlft9dKK8TfiSS3kPIH02YH4bNYz
         96ZpjjrUpT5KNilIgfSvD09BI/UTRYzeOxBzi20bQwW+1w9soTbkrIqvHgjfoyGrHVnC
         Bnlc5oTF7vE2aId4QJszl7Nvw+Kvg8h2/j7kgPYmrTXno6AygxBkQQoeFBn4IunJlHYg
         luDyObIUl7eEA2YzWQknA5Y+Qbh847mXzbnsNzk2NEwT2t6lNVI3qJsSdJQ+8Ra54gys
         tCsPeEMymsjlS+WGejijoZ/SAhwIFBl5rHgF2m3DPJ1LNUla9fdDXrUQ6/I3hiHg0hhA
         DqjA==
X-Gm-Message-State: ANoB5pk7h3PjD2mfa39vfx7YWimpue+akCaU5DI+4tWOKw32EzH9CO9Z
        b/4+T6xUrSKuu6kQhM1AR6eDUw==
X-Google-Smtp-Source: AA0mqf60JfOxxNgy8P3VlfJbyaVrLdhiMyX6biwGhIsWg1ouQukE2tDQdlXo4sjBnFx/9AKPnNlHEA==
X-Received: by 2002:a05:6512:33c5:b0:4b5:237a:fb0d with SMTP id d5-20020a05651233c500b004b5237afb0dmr2459878lfg.658.1669811229479;
        Wed, 30 Nov 2022 04:27:09 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o15-20020ac24e8f000000b00497a61453a9sm234996lfr.243.2022.11.30.04.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 04:27:08 -0800 (PST)
Message-ID: <faa53c31-2642-7504-f04d-81bef2793399@linaro.org>
Date:   Wed, 30 Nov 2022 13:27:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/2] dt-bindings: thermal: mediatek: add compatible string
 for MT7986 SoC
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.or,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <136157bd1f94c64504f87ee2db6b3ed0a8dcc3de.1667254476.git.daniel@makrotopia.org>
 <1216e96b279d08230cb2aa61d536f44c1e9b800a.1667254476.git.daniel@makrotopia.org>
 <cdc79d9b-7afe-1aaf-3692-171370abaa3c@linaro.org>
 <Y4dIBW4Kped5klgD@makrotopia.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y4dIBW4Kped5klgD@makrotopia.org>
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

On 30/11/2022 13:09, Daniel Golle wrote:
> On Wed, Nov 02, 2022 at 04:43:35PM -0400, Krzysztof Kozlowski wrote:
>> On 31/10/2022 18:16, Daniel Golle wrote:
>>> Add compatible string 'mediatek,mt7986-thermal' for V3 thermal unit
>>> found in MT7981 and MT7986 SoCs.
>>>
>>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>>> ---
>>>  Documentation/devicetree/bindings/thermal/mediatek-thermal.txt | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
>>> index 5c7e7bdd029abf..efc16ab5b22b5d 100644
>>> --- a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
>>> +++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
>>> @@ -13,6 +13,7 @@ Required properties:
>>>    - "mediatek,mt2701-thermal" : For MT2701 family of SoCs
>>>    - "mediatek,mt2712-thermal" : For MT2712 family of SoCs
>>>    - "mediatek,mt7622-thermal" : For MT7622 SoC
>>> +  - "mediatek,mt7986-thermal" : For MT7981 and MT7986 SoC
>>
>> Then recommended is to have specific compatible followed by fallback (so
>> 7986 followed by 7981)
> 
> I'm a bit confused about the order you are suggesting. It may seem
> counter-intuitive, but MT7986 was released before MT7981, the thermal
> units found in both SoCs seems to be exactly identical.
> Or are you suggesting to list MT7981 first to maintain alphabetical
> order? Because in terms of precedence, MT7986 has been there first, and
> hence I'd list 7986 first, followed by 7981, ie. the opposite of the
> order you were suggesting.
> 

I have no clue which came first. Choose whatever is reasonable.

Best regards,
Krzysztof

