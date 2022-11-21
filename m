Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48741632058
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiKULWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiKULVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:21:43 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9962261
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:16:44 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id be13so18336358lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lrfG9YCdHt66hbYqu0OShiByN9Q+Ix/FBWGfahZIGTw=;
        b=xnbCMedvtEU3dsFJUuZuBxNphjIJrx2tlNtlRW2TMqS5/MONSHB7fRdDdxFWJ1gDpl
         m5o6YkZhUWqu9rutHH5jJfs9LVHB4SUAn/GbmeviiWK3HBkgddAs5HuXVg+qEU8SYinT
         yUIeYgaK7Tjscr9NpeismG0KbddLgiqsndWqlVVWhTXYhVC4ubWwHkGLZ1LmVlxIkG64
         Ykuv71VIOllchEaTsO8IxfEXLok/CN+JLWGaZ1ccv+NznR3EjfCc6aRH7PyisBmmqdK8
         UUF/LKRQ0HIaSRpq6bi11X4Z4FSM5twuSGj5RmZunG4XFm4k5p7vuKSQrWI1zwSvj9zQ
         WQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lrfG9YCdHt66hbYqu0OShiByN9Q+Ix/FBWGfahZIGTw=;
        b=oGByP2XcU2EuC2WyrSOA92IInKQxwogeKszE/PGX6vvSowqf4GKGxdDQE5SiubHQL5
         8HpNnkk14nJ/5FIWc8O2NwKrWOLbfMVlXHxjYchF8dQb35UEa9PbxK4sjsFwWeeDNVkv
         GEb0v4CeKg/CCWCyGGQnJR2Q62lx7jxanxf8tXL+RKMdse4jjxTy1hmlhzcku61LM0ft
         rxU6G0nbQhYBzTMqcQQjVcaA1/qQXS4eD3TDkAJsEUzp0XJYFTLUtJY/9B6NTZvRGJad
         TwqQitNveP8Otfo8Zk9dyR2gpLcoi77VLVx6esJ1wZEw7UOp8hvKjKRAYdoRgifF+vpG
         5q3Q==
X-Gm-Message-State: ANoB5pkie96/ao9ax+qywFXtYuHXQosmJQPFfOMoCXNWJEHPs2x+Ah97
        GeMGfVKpnkcW6rdNQFrX0LRsm+XRQQZav+D5
X-Google-Smtp-Source: AA0mqf7XTsi+DRaW0EjX/SWzCsh6OLHKxJQ5nOhQBp07hY+otYz+Pmy3TNDQk343ejimX6B5i8Je2A==
X-Received: by 2002:ac2:58f6:0:b0:4a2:7692:3a0a with SMTP id v22-20020ac258f6000000b004a276923a0amr5989466lfo.71.1669029403043;
        Mon, 21 Nov 2022 03:16:43 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id y22-20020a196416000000b004a25bb4494fsm2000785lfb.178.2022.11.21.03.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 03:16:42 -0800 (PST)
Message-ID: <9389201b-22d4-1229-7e26-5f046d18e15f@linaro.org>
Date:   Mon, 21 Nov 2022 12:16:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 02/14] dt-bindings: media: rkisp1: Add i.MX8MP ISP
 example
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        linux-media@vger.kernel.org, Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Helen Koike <helen.koike@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221118093931.1284465-1-paul.elder@ideasonboard.com>
 <20221118093931.1284465-3-paul.elder@ideasonboard.com>
 <ca8a6070-3888-8d42-5974-d7c2adc62417@linaro.org>
 <Y3h93cLdEvMzInXe@pyrite.rasen.tech>
 <238f7bf8-578c-5bb4-9f00-50f36334c5cf@linaro.org>
 <Y3sIAHqd8Kd/XBB/@pyrite.rasen.tech>
 <50024f2e-4820-ef78-d54d-5bfe53ccac7e@linaro.org>
 <Y3tVKOEfxdZ+Klnh@pendragon.ideasonboard.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y3tVKOEfxdZ+Klnh@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2022 11:38, Laurent Pinchart wrote:
> On Mon, Nov 21, 2022 at 09:04:29AM +0100, Krzysztof Kozlowski wrote:
>> On 21/11/2022 06:09, Paul Elder wrote:
>>> On Sun, Nov 20, 2022 at 11:36:31AM +0100, Krzysztof Kozlowski wrote:
>>>> On 19/11/2022 07:55, Paul Elder wrote:
>>>>> On Fri, Nov 18, 2022 at 02:06:14PM +0100, Krzysztof Kozlowski wrote:
>>>>>> On 18/11/2022 10:39, Paul Elder wrote:
>>>>>>> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>>>>>>
>>>>>>> Add an example to the rockchip-isp1 DT binding that showcases usage of
>>>>>>> the parallel input of the ISP, connected to the CSI-2 receiver internal
>>>>>>> to the i.MX8MP.
>>>>>>>
>>>>>>> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>>>>>
>>>>>> Missing SoB.
>>>>>
>>>>> I don't quite understand. I see an SoB right there.
>>>>
>>>> Laurent did not sent it. Did you run checkpatch before sending?
>>>
>>> That's why he's on the "From:" in the beginning. checkpatch says it's
>>> fine.
>>
>> Ah, indeed, checkpatch misses that feature (it's part of Greg's
>> verify_signedoff.sh). Anyway, your SoB is missing, as Laurent did not
>> send the patch.
> 
> I thought adding an SoB was only required either when making changes or
> when pushing commits through git, not when forwarding patches on mailing
> lists ?

Anyone touching the file should signed it off. You cannot send it
without touching (e.g. git format-patch).

https://elixir.bootlin.com/linux/v5.19-rc5/source/Documentation/process/submitting-patches.rst#L397

https://elixir.bootlin.com/linux/v5.19-rc5/source/Documentation/process/submitting-patches.rst#L420

Best regards,
Krzysztof

