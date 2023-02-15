Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BBF69845D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 20:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjBOTTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 14:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjBOTTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 14:19:50 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0AE3E612
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 11:19:46 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id m14so20209900wrg.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 11:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zVy/c+cEbMIt9TIoyvZusWRPHpRTQuTATF5cUQLqC4s=;
        b=fBnHeZPLzrGTJ+GWgxhoUQ9ZzA3Lc7rxkwystan7qPiLYpBrQCaL3fRgz6836TNTHz
         0iRj/kV9eAPZdwryApHfytig73xF31qAFfLDTc9kubaZor1EIr0Z4ie4gQz+lUrlq9C8
         AbzlsY2hrUPX/PGGF9aXLRqydd36ogYo8YFWgcqwHh9CH5w+DORJybeyaXgCoKbLChWy
         F27AGqX52xFaCy7uGk1ApL/r+Wq2TvTPkoGUqzLTpq5KcGP9D8E0rdPGmMBUSYI1XYIU
         Zdy/18FoRvtaQwRvwIhC7xEJ77Dz4Y2eLbj3Q2uT101HaqUzNKO3k9nWcsBtikrlkHf8
         pVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zVy/c+cEbMIt9TIoyvZusWRPHpRTQuTATF5cUQLqC4s=;
        b=4AaVwRIqlMcRI1toyMR/n/tTfLAOX2NcroL8vDQwVEp+WmsE5YFGpjrbMOCwurp0tJ
         Qm88Ejs8FLX/YHwAR5CgHNMkVbQArgzVi/BpCBSLAKbXWXdZ6oLI9Fi54iwlR3YUGt//
         WcxPx/LE4P/4EUcdpnghY8qSRrEpMZm/uQ9gqApFjKhhU8wZpJ8alHNLquUilhBM8Kx1
         FNbOCk9ql3Nir2Nng2ZaZ87EpHTOaLb9ofxHpLax4oUyxYfJflfzZeQRinnmDQ5nlsCC
         lUKt/A8d/IsHxXn6XHhkOsBN7SCmZBkMD+q/gcFGGqxKs/2wT+GtmAl3Iaqid7NWEY5t
         XdEg==
X-Gm-Message-State: AO0yUKVofqYUfYcGc0aeaL9VZWs4lnq+Dpc1iHgp5aZEW0A/OdpbKO3k
        Rr6jJoqsx9EZEO8qpNQQnLD6xQ==
X-Google-Smtp-Source: AK7set/9DsbtaIrsocf96fJaGpubiBoTK5aOjMvOd3HgsZ49/Uzn8dJY8QA23em2CaUqweOCX9YRDw==
X-Received: by 2002:a05:6000:1152:b0:2c5:52f5:c63b with SMTP id d18-20020a056000115200b002c552f5c63bmr2756520wrx.11.1676488784705;
        Wed, 15 Feb 2023 11:19:44 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t15-20020a5d534f000000b002c55306f6edsm10284549wrv.54.2023.02.15.11.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 11:19:44 -0800 (PST)
Message-ID: <2334035b-cc52-8dfb-9ba4-544081b98d6f@linaro.org>
Date:   Wed, 15 Feb 2023 20:19:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] dt-bindings: sound: ep93xx: Add I2S and AC'97
 descriptions
Content-Language: en-US
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        devicetree@vger.kernel.org
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20230212232137.299005-1-alexander.sverdlin@gmail.com>
 <46d5b6af-23e1-4178-83bc-b4a435b1426e@linaro.org>
 <109868b9492aecaca0a7170cba9fb51e62de7116.camel@gmail.com>
 <c4f5f733-ce22-2dfa-30f7-cde309eadaf9@linaro.org>
 <ba51ecefb814115e977d90062ca5fe99859cb327.camel@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ba51ecefb814115e977d90062ca5fe99859cb327.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 15:26, Alexander Sverdlin wrote:
> Hello Krzysztof!
> 
> On Tue, 2023-02-14 at 15:11 +0100, Krzysztof Kozlowski wrote:
>>>>> +  interrupts:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  clocks:
>>>>> +    minItems: 3
>>>>
>>>> maxItems instead
>>>
>>> reg and clocks are required, I suppose I should include both minItems
>>> and maxItems for both of them?
>>
>> No. minItems is implied.
> 
> I see. But I think minItems "3" should be included for clocks, right?

No, why? It is implied when you provide maxItems. Therefore why would
you need it to make it explicitly (although you can, but we avoid it for
smaller code)?

Best regards,
Krzysztof

