Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1075E8A08
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 10:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbiIXISr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 04:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbiIXISK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 04:18:10 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB610115C
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:16:54 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z6so3158708wrq.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=8GifTQpufEs54QBDY2QjRoLxAtLfrQ9yFBESAjAvqEk=;
        b=h/AwTcB8RNdgxSnuBMHtYHGPzYnQiaTUTro3fTmKcqsqCNShPhhIqHus7fL08MOTFn
         5uE/x6RMgo8e4HduYiGCEoMhwQN9gdO0ygvFqdbiUwkUXofinJTYR6NQ4qFwKrEklaLi
         p/BImwKzsSlipbXk98O+PCMjB8Y9evuHRmzDZVO0Sqqlcs24wjPxiU2HI5fQP/73vYo4
         g7cDwt+1PXMABycZZ0JCjNhPLtN3kmvS/Y8nklzxMqkTdLAjzt08k58GmP8xSEyqhR65
         XsxWhPF9fp5eTf7S4B/BxJSoO3TiNdBcnuMuSNZWEihCIbO1CJ3qIlgL1VhNtr6EIBRL
         ZhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8GifTQpufEs54QBDY2QjRoLxAtLfrQ9yFBESAjAvqEk=;
        b=YyWYku5azr/0weCIGJvXG7gl+ID+wmfi7ts9AgQyIoB6mWTPXJzZvIsr0md9jxbGRS
         0XG9SI5bmAEOMSDXDu1fLY4D+j1m9rQi23RMHQJEUn+VJCrhyhBZd5/L868sFlvwIIcK
         Qd6GNLt6tBgOX3Ecpz8hxS6wfoJod8y1eZ7lQZIkNd8jQ6hY8f1G0QsOpre1/rFb3UpV
         9HxucXx58Cewx7YAEc8OZ6FOT/KBTq0FloMSic0Pu2jdiKwRx/m13p8WF1n4lGMaxOpz
         1iPaufFx/Mo4FXuURwuk+UfmwciZCztUdyiOGWLZ0t8zuwyZDges83E5ftouxxdfL1MW
         193w==
X-Gm-Message-State: ACrzQf3NdHiaLU2MC5TV6Uj86WnCX2Yph8Es1oGa1UYgLcaCrkamHWJI
        VtRT64tfU6PQMwuGiITIo9n6OA==
X-Google-Smtp-Source: AMsMyM5F0qUy/QeECubzkPRKLgAndKmjI3IYfKkwCm3Uj9Ho44uoMxaJ4kbx1IKywhv3NhYmZnzXnQ==
X-Received: by 2002:a05:6000:15c5:b0:22a:49be:8000 with SMTP id y5-20020a05600015c500b0022a49be8000mr7395090wry.664.1664007413262;
        Sat, 24 Sep 2022 01:16:53 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id iv14-20020a05600c548e00b003a6a3595edasm4763338wmb.27.2022.09.24.01.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Sep 2022 01:16:52 -0700 (PDT)
Message-ID: <607cab94-ca0b-c7ea-b603-12d933e42ced@linaro.org>
Date:   Sat, 24 Sep 2022 10:16:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: INFO: task systemd-udevd:94 blocked for more than 120 seconds.
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>, Borislav Petkov <bp@alien8.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <Yy4B+9yH8oT0F8nQ@zn.tnic>
 <Yy4GoMMwiBaq3oJf@dev-arch.thelio-3990X> <Yy4MNp6yiRTJxeXa@zn.tnic>
 <28d03f8d-ed70-cdc8-70d3-7b1723e5715@google.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <28d03f8d-ed70-cdc8-70d3-7b1723e5715@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Hugh,

On 24/09/2022 09:40, Hugh Dickins wrote:
> On Fri, 23 Sep 2022, Borislav Petkov wrote:
>> On Fri, Sep 23, 2022 at 12:18:56PM -0700, Nathan Chancellor wrote:
>>> I have not seen a stacktrace like this on my machines (although I
>>> suspect that is because I don't have CONFIG_DETECT_HUNG_TASK enabled in
>>> my configs) but my Honeycomb LX2 hangs while booting after commit
>>> 78ffa3e58d93 ("thermal/core: Add a generic thermal_zone_get_trip()
>>> function") according to my bisect, which certainly seems like it could
>>> be related to the trace you are seeing.
>>
>> Don't you just love how well our community works - one reports a bug and
>> someone else has already bisected it and thus saves one the work?!
>>
>> :-)))
>>
>> Thanks Nathan, I can confirm your bisection. The commit above doesn't
>> revert cleanly ontop of linux-next so I tried it and the patch before
>> it:
>>
>> 78ffa3e58d93 ("thermal/core: Add a generic thermal_zone_get_trip() function")	<- BAD
>> 62022c15f627 ("Merge branch 'pm-opp' into linux-next")				<- GOOD
>>
>> so it looks like that one is somehow b0rked.
> 
> Yes, Nathan was alert, and saved me too from bisecting failure to boot
> linux-next in another thread.
> 
> And I see from
> https://lore.kernel.org/lkml/c85a77a3-409b-3e83-08a7-ac7e1888790d@samsung.com/
> that Marek also found it: and tried to fix it, but found it goes too wide.
> 
> I made a patch of the offending series with
> git diff 78ffa3e58d93^ 2b109cffe683
> and then reverted that cleanly from next-20220923: works for me.

Thanks for investigating. I believe I found from where is coming the 
deadlock. I'll send a fix for that.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
