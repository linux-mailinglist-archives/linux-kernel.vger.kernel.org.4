Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F56568DDB3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjBGQOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjBGQNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:13:55 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61396193
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 08:13:53 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id m14so14039627wrg.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 08:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pNxhydrTd34r+uTCjdy7LmWbFpsf5f3sYLA3FNJZQww=;
        b=OOpf1czEbZTuwyeGOmOGKz7pMXyILFbVPQEgNdrukQw9ebAQtZ3Ph0X+OSqHKXxqiI
         N/SGx8WbJPHja+jDqLqkhzRlhZVgV3TSBRFNY9avBRQkE4q5JqiTiRq8U1/z8StFEDVZ
         eqKd8NsJYe4t04WB+x036wWk0qas+WL7GhPpXxtGK9fDJUsBm7KI8hVn8WaReFG3e3w/
         Zho6lpZ+7bnaGPY1JZTqJTQhAmNJFYItPWl4OXygL23p2f9QfN7IaCrvnfW8TJJtjIMf
         JWkhcWKGuzVREDAvhRJ2MWMMTCHw/kQw0lj7PLi8vQiTz/qVnDIgk8o3sEO7rTIwlKCd
         eQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pNxhydrTd34r+uTCjdy7LmWbFpsf5f3sYLA3FNJZQww=;
        b=JieCFA0fGqF0TrsIUhDhtYhLrk283hfGk8tFPgFB4RGM+rzSofYkidra84HJjGXHgU
         xigkXx0B2pLLlXK8dWaFin3Vmu5B+K98BFTDcVCenFS8cWHgw6jFSdP8MXFCIU8IAh60
         T1bdLsg9c52V1ZfD0nkW+uBWg/mXsUnD0KlJgMU0sL7vLZY70jZn3opM+YSw55zHr83A
         F62p4SvIOCoM8i9nIabKC2rxixsUznL7aw6wj9xxv/rBugdDjRIt+7PjwldQGdQM4s7m
         SB8m5c8kr6mw0QEUIQGmCT1tnACvk09/ECNBicaGIIW5ie8b+ihc4+m826RmgCR3EDdE
         4AVg==
X-Gm-Message-State: AO0yUKXMp0//NwWDdNU2o8MXzr5viZisiALsqsV+PcPL1m2N5jSCwe7k
        N03cbn8B9ReLBTceMZGhzjPBZE17DNOSvlkv
X-Google-Smtp-Source: AK7set/sTDamrm6lwZ2cQEH8kqJYkVmh9E/4XDzymL4dbTYXYvGyWqJKRMfRHh0fjqGQykDjRGMPmg==
X-Received: by 2002:adf:fe09:0:b0:2bf:bc0a:361d with SMTP id n9-20020adffe09000000b002bfbc0a361dmr3139814wrr.31.1675786432534;
        Tue, 07 Feb 2023 08:13:52 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f7-20020a056000128700b002c3df9279f5sm8450225wrx.48.2023.02.07.08.13.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 08:13:52 -0800 (PST)
Message-ID: <44c7274f-8a5e-0235-413a-6c3260018601@linaro.org>
Date:   Tue, 7 Feb 2023 17:13:50 +0100
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e7257f9a-86c5-74e8-c538-6f6d2ba13274@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2023 16:46, Lucas Tanure wrote:
>>> +      Shared boost allows two amplifiers to share a single boost circuit by
>>> +      communicating on the MDSYNC bus. The passive amplifier does not control
>>> +      the boost and receives data from the active amplifier. GPIO1 should be
>>> +      configured for Sync when shared boost is used. Shared boost is not
>>> +      compatible with External boost. Active amplifier requires
>>> +      boost-peak-milliamp, boost-ind-nanohenry and boost-cap-microfarad.
>>>         0 = Internal Boost
>>>         1 = External Boost
>>> +      2 = Reserved
>>
>> How binding can be reserved? For what and why? Drop. 2 is shared active,
>> 3 is shared passive.
> 2 Is shared boost without VSPK switch, a mode not supported for new 
> system designs. But there is laptops using it, so we need to keep 
> supporting in the driver.

That's not the answer. 2 is nothing here, so it cannot be reserved.
Aren't you mixing now some register value with bindings?

Best regards,
Krzysztof

