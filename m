Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6712968DE31
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjBGQtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjBGQtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:49:04 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A7039BB6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 08:49:03 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so13639013wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 08:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gQ6efCB61TIYLPpmHdBk+1/LSUB0gQyc/JjMU48i42c=;
        b=bgfak1jDvCOVHQQGElWmnD2lEOMEwTBINLogn9Eq0pKQvrNoRAXz8j0EjilZ4k4JYP
         Vmw1eHnC760O26q7ev3uIE0BV6+vlXEgBj9WZuAF5e66h3wBo485l/vcuMKvan2wuHS9
         uIuDOePMn2u7AxdEg1LCq6cSzyJdVmnweP3F/9KzJzC72dHF+4vH+mX10ivzZVBVOho6
         JkVdG1kEid5uJS9lG3OqmKHUgTw4VWggv5Y3fp+saqbVXt7SMQPYQ1sclQWTrrzEHYht
         9Q0FUICTHFi4DO3gHhDSKvWkENjBFuJPlokc1Z8D9JP89mJyHhZl60+6O7RwwyyQhirs
         ml5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gQ6efCB61TIYLPpmHdBk+1/LSUB0gQyc/JjMU48i42c=;
        b=vsxFzg5/b5RqWOondH19scphm8K+iknr7JlM11mFfxMflN3pAxsExlc5Nhrpgeljt1
         gLsK95bHRyEI83C5kmo1B8ynRtxyMXQIxsTc8gGtKgzEKoBMNM8kGpOQQXluIrijZsGU
         2vm7y5pWNcgNhp08Zs7LdOVnlH73j/S+17Ci0mbXs5PjiipMc02cDXU/oqLkbbMM/JXQ
         s7sVzGni5RveAhnkaqKzPAqPAkthvhCpz0v0kWR8WSGPQ0NTpT30FDgAk6u3plsKxYaA
         dMCvd7xzvnXvOJCSDjXprd1xq78b6EXivXw0E3AdBYpyCEJcHkJK+YuMwQkm/UVX4iFd
         e5Qw==
X-Gm-Message-State: AO0yUKXXVQycq53k3rnvSGLHuDuvZPZ0ggOSPdu6ZgTMSOAoIaBNh9//
        fCP5hVmoMpP5r9LLIFJUDmtn/A==
X-Google-Smtp-Source: AK7set/wpe72cljXd1fwohTpF1E1pBpcSt320AhZrTM3txhgwmGemUE2cxJ3yvXcCkWxTecsGoIF1w==
X-Received: by 2002:a05:600c:1d8b:b0:3dc:198c:dde with SMTP id p11-20020a05600c1d8b00b003dc198c0ddemr3515818wms.41.1675788541619;
        Tue, 07 Feb 2023 08:49:01 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p10-20020a05600c468a00b003e0015c8618sm7074580wmo.6.2023.02.07.08.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 08:49:01 -0800 (PST)
Message-ID: <56ce2617-4fd1-d597-a4dc-918654cdd3f6@linaro.org>
Date:   Tue, 7 Feb 2023 17:48:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] Documentation: cs35l41: Shared boost properties
Content-Language: en-US
To:     Lucas Tanure <lucas.tanure@collabora.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230207104021.2842-1-lucas.tanure@collabora.com>
 <20230207104021.2842-3-lucas.tanure@collabora.com>
 <44faeca1-94c9-4423-d87a-03d80e286812@linaro.org>
 <e7257f9a-86c5-74e8-c538-6f6d2ba13274@collabora.com>
 <44c7274f-8a5e-0235-413a-6c3260018601@linaro.org>
 <4efe9796-6d3e-09d1-d5f7-cfb25a439061@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4efe9796-6d3e-09d1-d5f7-cfb25a439061@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2023 17:34, Lucas Tanure wrote:
> On 07-02-2023 16:13, Krzysztof Kozlowski wrote:
>> On 07/02/2023 16:46, Lucas Tanure wrote:
>>>>> +      Shared boost allows two amplifiers to share a single boost circuit by
>>>>> +      communicating on the MDSYNC bus. The passive amplifier does not control
>>>>> +      the boost and receives data from the active amplifier. GPIO1 should be
>>>>> +      configured for Sync when shared boost is used. Shared boost is not
>>>>> +      compatible with External boost. Active amplifier requires
>>>>> +      boost-peak-milliamp, boost-ind-nanohenry and boost-cap-microfarad.
>>>>>          0 = Internal Boost
>>>>>          1 = External Boost
>>>>> +      2 = Reserved
>>>>
>>>> How binding can be reserved? For what and why? Drop. 2 is shared active,
>>>> 3 is shared passive.
>>> 2 Is shared boost without VSPK switch, a mode not supported for new
>>> system designs. But there is laptops using it, so we need to keep
>>> supporting in the driver.
>>
>> That's not the answer. 2 is nothing here, so it cannot be reserved.
>> Aren't you mixing now some register value with bindings?
>>
>> Best regards,
>> Krzysztof
>>
>>
> I have added a new patch with propper documentation.
> And I would like to use 3 and 4 for shared boost as 
> CS35L41_EXT_BOOST_NO_VSPK_SWITCH already exist as 2 and is used in the 
> current driver.

I don't see CS35L41_EXT_BOOST_NO_VSPK_SWITCH in the bindings.

> The laptop that uses CS35L41_EXT_BOOST_NO_VSPK_SWITCH doesn't have the 
> property "cirrus,boost-type", but to make everything consistent I would 
> prefer to use 3 and 4 for the new boost types.
> Is that ok with you?

I don't see how it is related. The value does not exist, so whether
laptop has that property or not, is not really related, right?

Best regards,
Krzysztof

