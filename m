Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791146C2CAD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjCUIjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjCUIj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:39:29 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F382CE058
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:39:20 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x3so56509589edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679387959;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZWbwtUQKE/fZnvoPIaaq3aGw6N/sLGFIIiVct8M0Ufo=;
        b=uNXYUXetKd4hQlOg/9ui2OF4j/U1+6eiDn0BbP2w2pHBKZbqB4WDDoOW90d9tPAjcO
         sXpIAWSpUF4RgySkdOtcn+QUemGyrrm0gcj10fJTZSFjaX0ECOoay5Yh+Vkyl7sft4Gb
         +6WQOflOE08GiBi8YnNxbDR2EGTcwfVr175knTN9qmxmT1ccqzYYc+0giWKXrdk5nTHY
         NBFShMvrfYVcgKqNDNEd0alj8WImQXKxcsheUN9DBgmZhD7717We+sO9t/ybHSLuQuPt
         8K5GrSJo4hFTGDdL5NePycMBXL3s5bISpCsshTb4TfHnxh/uQKXjUAJ4BM6Qd5qlZ3ES
         e2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679387959;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWbwtUQKE/fZnvoPIaaq3aGw6N/sLGFIIiVct8M0Ufo=;
        b=PdrQBorZGCOChAFcWs56vp6IcdGR0IAislB2MlcBKapXDwDOCyvM55Tkj2iptOdXD2
         rTg08i0tXsAp7aYRiLaQaYm2z4JfLApFDMjaqZ7vcHsztOLUnI+OvQtwSFn1K5Jpx1vB
         tfPUnMrtdf/L1kbsQOC9ZZDxT71eDhCdoLI/vgJpyXBvcByD+HzwZQP6ephXGQq9Bulg
         9ngYqu4NqlE5Rzec86FXVc3IayohOeHi5mmVkEza+ExvAj8WEMo/kndfhbGt1EwF7vrp
         azG/RbHnhC8E88PB1bCoBhDtYEbdC4FNU0Ftdsc1Gkk2Jl8KOM4tdODCd0vWIq714eKC
         IZ0w==
X-Gm-Message-State: AO0yUKWIcJcsHkEbyMOo/TEw4Gi+wEXhNYV+AGtj1aNiQzAZKWzlzsZY
        YklJLPkJv95YDIheHeYMyZrc7Q==
X-Google-Smtp-Source: AK7set81lhh+0JxQFQAeNf7t8tyrtqQE9KqO4UM5dzdCcZL8BTq9UMDluvdjyO7K8ldQq81TaYVraQ==
X-Received: by 2002:a17:906:898:b0:930:9197:24d1 with SMTP id n24-20020a170906089800b00930919724d1mr12557193eje.6.1679387959370;
        Tue, 21 Mar 2023 01:39:19 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:2142:d8da:5ae4:d817? ([2a02:810d:15c0:828:2142:d8da:5ae4:d817])
        by smtp.gmail.com with ESMTPSA id qn17-20020a170907211100b0093048a8bd31sm5477796ejb.68.2023.03.21.01.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 01:39:19 -0700 (PDT)
Message-ID: <2150938b-5433-6f51-c404-2c0f6976f864@linaro.org>
Date:   Tue, 21 Mar 2023 09:39:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 01/10] dt: bindings: clock: add mtmips SoCs clock device
 tree binding documentation
Content-Language: en-US
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org
References: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
 <CAMhs-H8OQ9gJLsifLuHD2GN8rYwnY=Zmdb0kMEfX4UUHhjMUyQ@mail.gmail.com>
 <d0f74721-bf5a-62de-53dc-62e7e735e2dc@linaro.org>
 <bdc82b4a-f1a9-0372-5a57-200a422b1b70@arinc9.com>
 <21a90597-78c9-4d46-7b01-257702e7afca@linaro.org>
 <525a6388-a4b8-3052-fe81-5aa21d8f424a@arinc9.com>
 <507f79cf-acd8-5238-031a-fd71024e0c6a@linaro.org>
 <CAMhs-H8_S5eO7B+dZ7jeq7Jjnw71QBmSo4M+woe3U5sH7dCADg@mail.gmail.com>
 <39ba681e-5bab-cffc-edf7-4bf86387987c@linaro.org>
 <132de602-6467-536c-c66d-657f22a59bd5@arinc9.com>
 <40e3acac-b58a-7af8-b025-3678f84434da@linaro.org>
 <CAMhs-H9AWXvtbg=qz06HN3piUO0E5YF3RmrdRLC7qH2n6KjrSw@mail.gmail.com>
 <d598f5f8-f998-2a31-bb21-97e641793dda@linaro.org>
 <120663a9-aecf-4a43-d1fb-779cd52802c6@arinc9.com>
 <3d2b8a1a-99c9-f53e-4bb3-a8b938e2672f@linaro.org>
 <543ad00d-4171-ed02-0d31-676c6b003e54@arinc9.com>
 <82f517b5-6697-3379-8d71-163b0d17735d@linaro.org>
 <d640a929-b6a0-1552-e66a-3a7bbabbc69f@arinc9.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d640a929-b6a0-1552-e66a-3a7bbabbc69f@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2023 09:33, Arınç ÜNAL wrote:
> On 21.03.2023 11:27, Krzysztof Kozlowski wrote:
>> On 21/03/2023 09:24, Arınç ÜNAL wrote:
>>>>>
>>>>> If we take the calling new things mediatek route, we will never get to
>>>>> the bottom of fixing the naming inconsistency.
>>>>
>>>> All new things, so new SoCs, should be called mediatek, because there is
>>>> no ralink and mediatek is already used for them. So why some new
>>>> Mediatek SoCs are "mediatek" but some other also new SoCs are "ralink"?
>>>>
>>>> You can do nothing (and no actual need) about existing inconsistency...
>>>
>>> I couldn't change ralink -> mediatek because company acquisitions don't
>>> grant the change. I don't see any reason to prevent changing mediatek ->
>>> ralink without breaking the ABI on the existing schemas.
>>
>> You cannot change mediatek->ralink without breaking the ABI for the same
>> reasons.
> 
> Then this is where I ask for an exception.
> 
> The current solution only complicates things more.
> 
> https://github.com/paraka/linux/pull/1/files#diff-0ae6c456898d08536ce987c32f23f2eb6f4a0f7c38bff9a61bdf3d0daa3f6549R21

Sorry, I don't understand what's under this link and how some Github
repo pull helps in this discussion. I don't see there any text, which
could help.

I also do not understand why this pull proves that you can change
existing mediatek compatibles (we talk also about ARM, which is shipped
to million of devices) to ralink without breaking the ABI.

I do not see how choosing one variant for compatibles having two
variants of prefixes, complicates things. Following this argument
choosing "ralink" also complicates!



Best regards,
Krzysztof

