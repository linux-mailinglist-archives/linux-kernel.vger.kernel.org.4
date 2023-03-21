Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A945C6C3817
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjCURVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCURVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:21:41 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715E735EF6;
        Tue, 21 Mar 2023 10:21:40 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id y4so62695691edo.2;
        Tue, 21 Mar 2023 10:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679419298;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jxmCUAnp9e9FziFUWiKv4WUL7FHpKVhvxafFLIRPWmc=;
        b=c62x5reMTPanZkCCPANuaXEaxIEyzsh0RKiD00s2hy0xfXAr+FBUD5BG/5gM8dNm3L
         f4E5WBEP5g74zwMO/XmpRHprR2+o+dWQyxqmABDB2n6BsPSSxFCK0ycS9YmiXMAKATZn
         JqmLJ+7M+pg13EbhQZmPlzEI4W+NZHVkRnKAu3uePjJApqGNFGNw04C/DcEMWV9nBkXR
         WRkI1OuvPJzHP5XVhOAx7d9PHaBKhfHm6Z1549JRXLGg56zDGUlZSJhiw9pP94KtfbJm
         GJwqkrFHe61zId8DqDuGw9IqDh4tu+zbmPoosqVQWXjg9HJ4CBHo41OD8SnGsI09JhIE
         WUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679419298;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jxmCUAnp9e9FziFUWiKv4WUL7FHpKVhvxafFLIRPWmc=;
        b=TwzF2WUjD+2pqkFG64u4w6bk5ZVxhRoR12Vyk23S2nXG2u8kd/gzBgRe9ajJcSM2Vf
         dZa5imXbT1qhWqgBo/HNa+K6+Uo/PU+vWHMNBkW5zXPjGmzcCnNEzMee2HwSTD6Lvj4+
         Ybhaehc22Vb3QrNXfPwEdH0FH8op5LkGqIpGAB8VES14Z51s7XNUwT+z3+UrneJYVCeZ
         zVLghdju9xEJu1jvx9G6tUVsYQyFhxvHVKUt/2aYzeGTZxVRclIz+urERO+i5xLJr64f
         E6DBsFcbsx5EBaxXsFNSa0A0aROi1rhUZ2x+h2HsWZaSrYeb47roU+crB4GrbVGxQA2u
         YIsA==
X-Gm-Message-State: AO0yUKXm2NxetLLx9njhm8V1sm1Bnh3NSfX3V3vpPYiCtcLvKfx8hsVm
        Gcq1M7FoIiCpEFhUkfLTsj4=
X-Google-Smtp-Source: AK7set+GyPA3GhnNulm5Xntay49mJMSUxdjIDittGmVP3VNedwmLoL/FJm4jkjZos6vPlQlMdVf0qw==
X-Received: by 2002:a17:906:46d7:b0:930:7164:e8e5 with SMTP id k23-20020a17090646d700b009307164e8e5mr3095278ejs.38.1679419298063;
        Tue, 21 Mar 2023 10:21:38 -0700 (PDT)
Received: from [192.168.1.16] ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id m27-20020a170906259b00b0093a3a663ebdsm900446ejb.154.2023.03.21.10.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 10:21:37 -0700 (PDT)
Message-ID: <330d5dd2-c382-4149-07b4-fec23d6611b1@gmail.com>
Date:   Tue, 21 Mar 2023 19:21:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/3] staging: greybus: use inline function for macros
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, vireshk@kernel.org,
        thierry.reding@gmail.com, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-pwm@vger.kernel.org, Julia Lawall <julia.lawall@inria.fr>
References: <cover.1679352669.git.eng.mennamahmoud.mm@gmail.com>
 <1274302b52ae905dab6f75377d625598facbbdf1.1679352669.git.eng.mennamahmoud.mm@gmail.com>
 <20230321154728.3r7ut3rl2pccmo2e@pengutronix.de>
 <7c883bac-382c-b429-ab21-4675dce02474@gmail.com>
 <20230321164259.nt6varbc6v6bavrz@pengutronix.de>
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
In-Reply-To: <20230321164259.nt6varbc6v6bavrz@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On ٢١‏/٣‏/٢٠٢٣ ١٨:٤٢, Uwe Kleine-König wrote:
> On Tue, Mar 21, 2023 at 06:25:29PM +0200, Menna Mahmoud wrote:
>> On ٢١‏/٣‏/٢٠٢٣ ١٧:٤٧, Uwe Kleine-König wrote:
>>> Hello,
>>>
>>> just some nitpicks:
>>>
>>> On Tue, Mar 21, 2023 at 01:04:33AM +0200, Menna Mahmoud wrote:
>>>> Convert `to_gbphy_dev` and `to_gbphy_driver` macros into a
>>>> static inline function.
>>>>
>>>> it is not great to have macro that use `container_of` macro,
>>> s/it/It/; s/macro/macros/; s/use/use the/;
>> Okay, I will fix it.
>>>> because from looking at the definition one cannot tell what type
>>>> it applies to.
>>>> [...]
>>>> -#define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
>>>> +static inline struct gbphy_device *to_gbphy_dev(const struct device *d)
>>> drivers/staging/greybus/gbphy.c always passes a variable named
>>> "dev" to this macro. So I'd call the parameter "dev", too, instead of
>>> "d". This is also a more typical name for variables of that type.
>>>
>>>> +{
>>>> +	return container_of(d, struct gbphy_device, dev);
>>>> +}
>>>> [...]
>>>>    };
>>>> -#define to_gbphy_driver(d) container_of(d, struct gbphy_driver, driver)
>>>> +static inline struct gbphy_driver *to_gbphy_driver(struct device_driver *d)
>>>> +{
>>>> +	return container_of(d, struct gbphy_driver, driver);
>>>> +}
>>> With a similar reasoning (and also to not have "d"s that are either
>>> device or device_driver) I'd recommend "drv" here.
>>
>> please check this with Julia, because she said they should different.
> At least use "_dev" instead of "d" which seems to be a common idiom,
> too:
>
> 	$ git grep -P 'container_of\(_(?<ident>[A-Za-z_0-9-]*)\s*,[^,]*,\s*\g{ident}\s*\)' | wc -l
> 	570
>
> ("drv" should be fine, because the third argument is "driver" there.)

Okay, I will do that.

Thanks,

Menna

>
> Best regards
> Uwe
>
