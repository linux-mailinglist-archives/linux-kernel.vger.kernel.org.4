Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E83E6F982D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 12:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjEGKRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 06:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjEGKRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 06:17:02 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589D812EA3;
        Sun,  7 May 2023 03:17:00 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2ac82c08542so33126711fa.2;
        Sun, 07 May 2023 03:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683454618; x=1686046618;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWrHMfhWkbOVxV5hh1K95mzN9Vs53T0qG92G4zHd32w=;
        b=XZ95+Z5IJQvNAkbBjgDIs9DeW4mp3lUGxHxMw2KNDOkNC5YbZ8KcMDkKwyuomkSLQf
         9xHcuI3wf/izWmkxFsBh8Ka14JdNqwwycebyRlGbNPDlozFsTn+q5mPUMoYKZsu8RzrQ
         gnrQt7sOAmS3o2xMB8q41CLD7pVXZydwE16y1svLA4Fd4mDDrey3ILM4JvKbqJJLUGMe
         Rl4jN5VdnGqaeXtLv+tbTYt8V69LyIfucO9UNaqPjgTbm9btAa2OI5EkwRAE0AzVGsuY
         UQhw7+Cb1qgCVpUCSqNjUtgNfxMCVyQatgCAbaaa+tJVIZUSYPEQ6EQunE1YT1uRo54w
         /0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683454618; x=1686046618;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AWrHMfhWkbOVxV5hh1K95mzN9Vs53T0qG92G4zHd32w=;
        b=g1dRMFEQn2un3QYsg2NzX+tqINZDlmlYZkP1zFQgnoD1VZStxqzxkjq+qq7n/zkXg/
         WQcnD/bUU2HhMTMCa9cxYZols9FHbQHSTSVAJIu/fsRKcKxlJz99ZIJDWc0t69jRB8jR
         DP8ApgPXSKzK5vMZDIDDKe99CwmieufLktbGUamDyNJMjWTr60hP63Mte1e3YbeWzrJB
         O9vQ8oG81ww/2pQjDEewTw12knvs8Uld8tWvvH643tnSENH7roeO8XFLrLHcb30x1b2p
         ThFgo/yU5tpqIepdOL0H2MBUQ6RCQeNaEz4mIoERRXDp6XywmH2HMQigDRXxRgmRme6n
         PtNg==
X-Gm-Message-State: AC+VfDzJQm7lnZIrcObY/4YdyTbHii6SHwRZy5HfKvKX5M2YtnLzwxtP
        aTb0U2NDifGL2Nld1jkrxUE=
X-Google-Smtp-Source: ACHHUZ5vienoHTAmuHiapLJNJUeIHu7JTT/dj9ij+/kodbsHgM0jbwAadquUhsFhK8pyz6gvj5GAcQ==
X-Received: by 2002:a2e:9ec5:0:b0:2a9:ebd4:1c45 with SMTP id h5-20020a2e9ec5000000b002a9ebd41c45mr1764929ljk.48.1683454618222;
        Sun, 07 May 2023 03:16:58 -0700 (PDT)
Received: from [192.168.1.111] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id n15-20020a2e904f000000b002a8bb20e534sm713225ljg.108.2023.05.07.03.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 03:16:57 -0700 (PDT)
Message-ID: <453da7af-8a83-f302-eea6-159e6222f430@gmail.com>
Date:   Sun, 7 May 2023 13:16:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZFM7lE4ZuDrUTspH@fedora> <20230506190738.0b6e4b45@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH] iio: bu27034: Reinit regmap cache after reset
In-Reply-To: <20230506190738.0b6e4b45@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/23 21:07, Jonathan Cameron wrote:
> On Thu, 4 May 2023 07:59:00 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> When BU27034 restores the default register values when SWRESET is
>> issued. This can cause register cache to be outdated.
>>
>> Rebuild register cache after SWRESET.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> Fixes: e52afbd61039 ("iio: light: ROHM BU27034 Ambient Light Sensor")
>>
>> ---
>> I noticed this was missing while writing driver for another light
>> sensor. The change is not tested in hardware as I don't have the BU27034
>> at my hands right now. Careful review would be highly appreciated.
>>
>> This change is built on top of the
>> https://lore.kernel.org/all/ZFIw%2FKdApZe1euN8@fedora/
>> and could probably be squashed with it. Unfortunately I spotted the
>> missing cache re-init only after sending the fix linked above.
>>
> 
> I'm not sure I follow what would be happening here or if this makes sense.
> 
> Partly the following is based on my mental image of how regmap caching works
> and could be completely wrong :)
> 
> I don't think it goes off an reads registers until they are actually accessed
> the first time.

I think this is not the absolute truth. AFAIR the regmap_init may lead 
to regcache_hw_init() - which can read the non volatile registers to the 
cache. I can't say if this is the case with current bu27034 
regmap-config without taking a good look at this with some thought :)

Nevertheless, we know that _if_ there is anything in cache when we do 
reset, the cache will most likely be invalid as HW will reset the 
registers. My thinking was that it is just safest to reinit the cache 
when this happens, then we do not need to care if regcache was populated 
when this is called.

>  In this case nothing has been accessed before this point
> other than the SYSTEM_CONTROL register and that happens to the one that
> is set to trigger the reset.
> 
> So at worst I think the only cache element that will potentially be wrong
> is the SYSTEM_CONTROL register as the cache will contain the reset bits as set.
> 
> That would be a problem if you read it again anywhere in the driver after that
> point, but you don't so not a 'bug' but perhaps prevention of potential future
> bugs as this behaviour is odd.  If you were to try setting some other bits
> then you'd probably accidentally reset the device :)
> 
> So, what's the ideal solution.  You could just bypass the regcache initially
> and turn it on later.

I think I've never temporarily bypassed the cache when I've used one :) 
I need to check how this is done :)

>  Thus it would never become wrong due to the reset (as nothing
> would be cached until after that).
> 
> Or just leave it as you have it here, but explain why it matters - as prevention
> of potential issues due to wrong value in that single register.

Hm. I'd not limit the potential problems to single register as probe may 
get changed - or error handling could be added and reset performed after 
probe. (I was actually thinking of this as the spec states that if VCC 
drops the sensor may go to undefined state and won't recover unless VCC 
is turned off for > 1mS. Didn't add this for now as it is not at all 
obvious the regulator would support detecting under-voltage - or that 
the sensor could really turn-off the regulator as it might be also 
supplying something else - so I didn't want to implement some overkill 
error handling when we might not have hardware which actually benefits 
from this).

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

