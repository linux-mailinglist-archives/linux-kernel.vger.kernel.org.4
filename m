Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D036CD46C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjC2IVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjC2IV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:21:27 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD8844B0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:20:17 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l37so8372513wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680078016;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WvevLPkyczLsyt+0gtz8D9GannpbiOBakYnWLTwfesc=;
        b=Bni9ZHRAc38ZPg+EmrwbsRDu9WtLWVZ2xqHWMDG7wtee4IwFeIpbFUlSx/cCkg6HUH
         Xf1CNVf74sNr4fDhQ7k++YeMOTIztlACIfisxb8UvX1U35KOaNtUl0xVoamcG7Gg91dR
         cbC5tGfcwtdXDj3WIR1otn5Azy6NGyKrMARRPzPyRrTdCWhIWx7HkqbZ1dvWfBqKZRt2
         GU7NenbRpRDmlKBiq/uCJIjfK88RaayGYkJA1oa5QRHjs2cYxeiWbUxfoWolanSqdDBw
         Xg7A5VxZ1OWfvC7cWc7bJEWEJahnBIB5mSBZ+M/mixM7ueGYmQa12geIPt0EYnfNuB48
         l1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680078016;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WvevLPkyczLsyt+0gtz8D9GannpbiOBakYnWLTwfesc=;
        b=eafdhcedu4tVjASywEBJJHypsc66jCxr5PkbJZVXPGH650amCtYVGQAQyiD9IBQLBp
         aGincXcYae3gPZqxu7tg1tx+0pdkM06MBjXuXuigNJ0+ZmFa7KsXDGNDSiCOLukndAfB
         R75DuE1FzhuQ1fjpcWRadM9pJrsX8PzAUt/I7i/O558aw5Sy0u2o8I1O0PzQHgkBrsLq
         kPpT9kVLg5PVPr9mGrufcUrl+4d062VdKKO39v13YJL0Q7PTA75Eh0Do/jHDKrfQecZ0
         aznaiHkESy2EyqJON+QdTD/rHybJGc8Gu/XaKOsaXUqzUFYaAwINMBZek/jvcP3/o1XL
         FsDQ==
X-Gm-Message-State: AAQBX9c3WcrBZCrN+WOrl/EKNVGy5pxpt/rjgR51USLxkBpwZtdQIdU1
        TXAl7eKjEj7pGGCu0LWNLgKhBw==
X-Google-Smtp-Source: AKy350ZWoR/Y88UzmnTa/XtNhAyjFirNPw6uwmMQjtSuHbx5S4jniKWcHdT7mZv8stfMg9KPoqbQAQ==
X-Received: by 2002:a7b:cd8f:0:b0:3ef:6396:d9c8 with SMTP id y15-20020a7bcd8f000000b003ef6396d9c8mr10457044wmj.5.1680078016199;
        Wed, 29 Mar 2023 01:20:16 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.91])
        by smtp.gmail.com with ESMTPSA id fc11-20020a05600c524b00b003ebff290a52sm1415902wmb.28.2023.03.29.01.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 01:20:15 -0700 (PDT)
Message-ID: <9c7ef736-527b-1659-88d8-cedf56458c30@linaro.org>
Date:   Wed, 29 Mar 2023 09:20:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] mtd: rawnand: meson: fix bitmask for length in command
 word
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Arseniy Krasnov <avkrasnov@sberdevices.ru>,
        Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
References: <d4338bd5-125c-a9e7-cb46-6f5e1da05cfa@sberdevices.ru>
 <CAFBinCB3yuyNJD=7UJ7jzf45Masms_PD4sm42YNjO8M4cr+4wg@mail.gmail.com>
 <fe2ed378-cdac-dbb3-acd2-ff542bd7e887@sberdevices.ru>
 <81632eee-533e-5e44-1520-5321a06c6797@sberdevices.ru>
 <20230328185001.5661132b@xps-13>
 <e8edcbc8-5c72-b29e-21d7-6f4438391924@sberdevices.ru>
 <CAFBinCCCNYJV4RBbM78r3yGPnY4oNKySEFRkzBgUD3xYJGkJmw@mail.gmail.com>
 <2fed42ad-11cb-6199-6adb-d9272209f5e2@sberdevices.ru>
 <20230329093145.52790647@xps-13>
 <20230329081734.v2kl4okq3ewimvzh@CAB-WSD-L081021>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230329081734.v2kl4okq3ewimvzh@CAB-WSD-L081021>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/29/23 09:17, Dmitry Rokosov wrote:
> On Wed, Mar 29, 2023 at 09:31:45AM +0200, Miquel Raynal wrote:
>> Hello,
>>
>> avkrasnov@sberdevices.ru wrote on Wed, 29 Mar 2023 10:12:10 +0300:
>>
>>> On 28.03.2023 23:25, Martin Blumenstingl wrote:
>>>> Hi Arseniy,
>>>>
>>>> On Tue, Mar 28, 2023 at 8:39 PM Arseniy Krasnov
>>>> <avkrasnov@sberdevices.ru> wrote:
>>>> [...]  
>>>>>>
>>>>>> By the way any reason not to have Cc'ed stable?  
>>>>>
>>>>> Sorry, what do You mean? I've included linux-mtd mailing lists, there is
>>>>> one more list for mtd reviews? I will appreciate if You can point me  
>>>> "stable" typically refers to the stable tree where fixes for already
>>>> released kernel versions are maintained.
>>>> When Miquel applies the patch it will either land in the next -rc of
>>>> the current development cycle (typically applies to fixes - currently
>>>> 6.3-rc5) or -rc1 of the next kernel version (typically applies to new
>>>> features, cleanups, etc. - currently 6.4-rc1).
>>>>
>>>> Let's say you are fixing a bug now but want the fix to be included in
>>>> 6.1 LTS (long term stable) or other stable release.
>>>> In this case it's recommended to Cc the maintainers of the stable
>>>> trees as part of your patch, see [0].
>>>> That way once the commit with your fix hits Linus Torvalds linux tree
>>>> it will be backported by the stable team within a few days (assuming
>>>> of course that the patch applies cleanly to older versions, if not
>>>> they're notifying you).
>>>> Note: even without Cc'ing the stable maintainers your commit may be
>>>> backported (semi-automatically) if it has a Fixes tag and the stable
>>>> maintainers find your commit. But my understanding is that it's
>>>> easiest for them if they're explicitly Cc'ed on the patch.
>>>>
>>>> I hope this makes sense. If not: don't hesitate to ask.  
>>
>> That is an excellent summary, I should copy/paste it sometimes :)
>>
> 
> Finally I fully understand why 'Fixes' tag is so helpful!
> Thank you Martin!
> 

Here's the official documentation:
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
