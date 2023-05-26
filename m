Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E42712219
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 10:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242135AbjEZIVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 04:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236899AbjEZIVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 04:21:34 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DC5D9
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 01:21:12 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f6dfc4dffaso3198885e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 01:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685089270; x=1687681270;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7i/lcle1xBraF8w9eo+4SpWIOMjnDNDMCKcDvZQyHZM=;
        b=qvLicbbFFgmav5ajzEA+heiCWFT/AryRYI1wconzkNif7M9qSlQ7imMoD2UGJAkQNa
         Hqtx+HhtsXqX46t89c06rDmn32wl+ZK+oV/sGgOTUqaJ3X0dO7/yGrAdCVw2csExBj47
         uOKFILUgdFMqk9rOhfkxpSJ5mZHydHhhRu2IzU6xCK51f8QWSI3v2AF1tAreOLUqeqr9
         thrGoy384OaHNvlDpVkwIb6rbiyOarnD+qb1LkSt1qphqFqjoVaIrkNMHeILB5+7/KLo
         AefOOjeKsGKQI4GdHnznjAh/ijx8CKY7SrHv7Hm9B99fXXQ/rhkNVBRq52DRxBMf8LFL
         NiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685089270; x=1687681270;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7i/lcle1xBraF8w9eo+4SpWIOMjnDNDMCKcDvZQyHZM=;
        b=UrftaMlk1/6Yn194X2g7+TIvVrofwvrDwiyZDfGNi9Geoctn8EQ3vBMlHWcnibsAJt
         sKvNOcMrFiEjDOwyXcK89bo3R2hGbPyZBMX7GS4iSf6zaRUl2dHeWs9j3QOd8B+zMzLy
         I8V3zUI8X+wwWKBgIn3x+d6Ao/ujQn5DnyIwytq3PqxDIge8mMtjAoOH1Sb+6NOGLmrJ
         124ExQhwggzwFZcI7mDQPB+LjCv6ajUJa65fh+117oSeqGmljB073/0Fw4qiVdTy57oF
         +1HLonTZ1RFzi1GBJVQI5rH6CLXKUGDWRcCycH21VsMjxkZqQOg/nQoYGJyk/4xqT2Hz
         lUdQ==
X-Gm-Message-State: AC+VfDyyG7cQjrgfVRVt7vSL72AwzA9ghNg4yidcf0CT9PoiZkfbJw28
        YgBNGuVsnQnPSDOfMjfMrrPb8g==
X-Google-Smtp-Source: ACHHUZ6xLeRPM1v2q/+ZmYwU051OEHTFMfO/ANY42iSCar0Ce226EYQxB0NTVN5Xm8J3N5T0wYmTKw==
X-Received: by 2002:a05:600c:2193:b0:3f4:fd67:6d7c with SMTP id e19-20020a05600c219300b003f4fd676d7cmr873084wme.40.1685089270424;
        Fri, 26 May 2023 01:21:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:15d9:4dfb:95d6:f5a0? ([2a01:e0a:982:cbb0:15d9:4dfb:95d6:f5a0])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003f4248dcfcbsm8081540wmc.30.2023.05.26.01.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 01:21:09 -0700 (PDT)
Message-ID: <b8a3e7f0-d227-117f-443b-0f6b193e792b@linaro.org>
Date:   Fri, 26 May 2023 10:21:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] Revert "dt-bindings: bridge: samsung-dsim: Make some
 flags optional"
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230526-revert-bad-binding-v1-1-67329ad1bd80@linaro.org>
 <20230526-oppressor-cabbie-fd5332dbc2cc@wendy>
Organization: Linaro Developer Services
In-Reply-To: <20230526-oppressor-cabbie-fd5332dbc2cc@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2023 10:02, Conor Dooley wrote:
> On Fri, May 26, 2023 at 09:27:16AM +0200, Neil Armstrong wrote:
>> This reverts commit cfaf76d349837f695c8aa6d7077847fec4231fe5 which was applied
>> without review due to a bad tool manipulation.
> 
> Is it a dt-binding maintainer review that you are missing on that
> patch?

Exact

> 
> For this one:
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks, I'll apply this revert now and wait until the original
bindings patch gets properly reviewed.

Thanks,
Neil

> 
> Thanks,
> Conor.
> 
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   .../devicetree/bindings/display/bridge/samsung,mipi-dsim.yaml    | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/bridge/samsung,mipi-dsim.yaml b/Documentation/devicetree/bindings/display/bridge/samsung,mipi-dsim.yaml
>> index 360fea81f4b6..9f61ebdfefa8 100644
>> --- a/Documentation/devicetree/bindings/display/bridge/samsung,mipi-dsim.yaml
>> +++ b/Documentation/devicetree/bindings/display/bridge/samsung,mipi-dsim.yaml
>> @@ -70,9 +70,7 @@ properties:
>>     samsung,burst-clock-frequency:
>>       $ref: /schemas/types.yaml#/definitions/uint32
>>       description:
>> -      DSIM high speed burst mode frequency when connected to devices
>> -      that support burst mode. If absent, the driver will use the pixel
>> -      clock from the attached device or bridge.
>> +      DSIM high speed burst mode frequency.
>>   
>>     samsung,esc-clock-frequency:
>>       $ref: /schemas/types.yaml#/definitions/uint32
>> @@ -82,8 +80,7 @@ properties:
>>     samsung,pll-clock-frequency:
>>       $ref: /schemas/types.yaml#/definitions/uint32
>>       description:
>> -      DSIM oscillator clock frequency. If absent, the driver will
>> -      use the clock frequency of sclk_mipi.
>> +      DSIM oscillator clock frequency.
>>   
>>     phys:
>>       maxItems: 1
>> @@ -137,7 +134,9 @@ required:
>>     - compatible
>>     - interrupts
>>     - reg
>> +  - samsung,burst-clock-frequency
>>     - samsung,esc-clock-frequency
>> +  - samsung,pll-clock-frequency
>>   
>>   allOf:
>>     - $ref: ../dsi-controller.yaml#
>>
>> ---
>> base-commit: cfaf76d349837f695c8aa6d7077847fec4231fe5
>> change-id: 20230526-revert-bad-binding-f77a3ca96419
>>
>> Best regards,
>> -- 
>> Neil Armstrong <neil.armstrong@linaro.org>
>>

