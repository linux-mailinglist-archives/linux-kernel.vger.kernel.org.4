Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A36C6C45CF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjCVJKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjCVJKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:10:44 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE1513DCD;
        Wed, 22 Mar 2023 02:10:20 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id e11so9495588lji.8;
        Wed, 22 Mar 2023 02:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679476217;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AF22QWtPbI8hINiApqhTErR3ndgD6Cy9pQ4ZYgJ918g=;
        b=KOGMrzF069kGvgjRowcJfrvOsfMHK7XdV6sh1GiQ9Zk8X4rAVrlGE46hCRmy348sAx
         Zoy/6S/Il4cL8z+di7A8QAaJefXlnDx+iIt2yf/UqVJe3wYnsVyuftHwukNn6zVun5zc
         soDsoUH+QSNoEVpHqYl+b5Y6nLLj8TGfFWLa7woGPuEqw4GHhAfo22xxoku5L47+HBxx
         hjlmJ0/wBto3LfCPadSNTjPKm/+rP/qxfH9A/4OnXJ1jcR9tCcvikmf3sr+R5M35sq0f
         mnvpsl23C3H3vaJzW2Y0LD4Us4GdKQzQkjhn846iT16Yk0chJoqOuDBlKH/X6Sv0n30q
         SvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679476217;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AF22QWtPbI8hINiApqhTErR3ndgD6Cy9pQ4ZYgJ918g=;
        b=G3GV508uw+wKiSzlxRKMSTMKZFN18K9jPDCbpvXZujbTM+6a7zx7zX8yiwz4wV0KJe
         OBnmKBhWhGMPE/6wfuuQ+f7QQ+HrB157/HlvS7VSJEQXlnK+dei7hW8XGDNbfLly3dB7
         Ae10XITZ9KRkJ/kKKfcS4GnyGK36BOh1XXcntyDNdu1RpjSszH3363uW3oCSi8Gzazb/
         ydypXQA82HqDxpy7+xYDR+1AO+riJroAXgjBeV2zFBECKvjsMxdkwQuTye/7JThGN1KR
         gkK41j/gW5NacYp94H4Wxo+VgVHrxgmraRl1AB3WMmJdN4V/GSuEvt3ZvzwMsNDdYVYM
         vLWQ==
X-Gm-Message-State: AO0yUKV/7O52DXejpmdtreBGdwDfafNe4neH9cgR3RqamVh9RUyr6MDs
        jM6Hyhm+BgmzEuhq4DETllY=
X-Google-Smtp-Source: AK7set+3wn7STykeLRSK/EVhjKe0sVN8+qh/LxMrchI26llUaRCvlhy6QgxhgJwScru1r9jjqwewHg==
X-Received: by 2002:a2e:7407:0:b0:295:908d:f6c6 with SMTP id p7-20020a2e7407000000b00295908df6c6mr1892656ljc.9.1679476217418;
        Wed, 22 Mar 2023 02:10:17 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id k7-20020a2e2407000000b0029477417d80sm2517941ljk.85.2023.03.22.02.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 02:10:17 -0700 (PDT)
Message-ID: <4cbc8d6a-c8e0-68a0-e1a4-a552c3a968d7@gmail.com>
Date:   Wed, 22 Mar 2023 11:10:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v4 4/8] iio: light: Add gain-time-scale helpers
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1679062529.git.mazziesaccount@gmail.com>
 <e5b93a3d2424b16d842e847c98f05f1a9befb2e1.1679062529.git.mazziesaccount@gmail.com>
 <20230319180828.452a603c@jic23-huawei>
 <5ba4ab3d-90ab-113e-1b95-86118d3a7392@gmail.com>
Content-Language: en-US, en-GB
In-Reply-To: <5ba4ab3d-90ab-113e-1b95-86118d3a7392@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/23 14:01, Matti Vaittinen wrote:
> On 3/19/23 20:08, Jonathan Cameron wrote:
>> On Fri, 17 Mar 2023 16:43:23 +0200
>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>
>> I think a bit more care is need with storage of time (unsigned) + decide
>> whether to allow for negative gains.
> 
> My approach was just pretty simple "int is big enough for the times" 
> (2000+ seconds when using usec as time units felt like more than enough 
> for light sensors) and "gains are always positive".
> 
> I have not tested the negative gains at all - but I agree this should've 
> been documented. Currently there is no gts-helper users who need 
> negative gain (or large times for that matter) - so I was not handling 
> them.
> 
> I'll try to check what it would mean code-wise if we converted times to 
> unsigned. Negative times make no sense but allowing negative error 
> values is a simple way to go.
> 
> As for the negative gains - I have no problem of someone adding a 
> support for those if needed, but I don't currently see much point in 
> investing time in that...
> 
>> Whilst they happen I'm not that bothered
>> if that subtlety becomes a device driver problem when calling this.  
>> I'm not
>> sure I've seen a sensor that does both positive and negative gains for 
>> a single
>> channel.
> 
> I agree. If driver needs negative gains, then the driver needs to deal 
> with it. I have no objections if driver authors want to improve these 
> helpers by adding support for negative gains, but if they don't, then 
> they have the exactly same problem they would have without these helpers :)

Back at this. I started reworking things to use unsigned times / gains 
but I am not really happy about how it starts to look like. Using the 
int values but reserving negative values to denote errors keeps things 
cleaner. Also, I don't think we need the extra bit for extending the 
range of supported values - It's hard for me to think we would really 
need gains or times exceeding the maximum signed int. I think negative 
gains are actually more likely so keeping int as type may help one who 
wants to add support for negative gains.

(Although, I assume the integration time multiplying logic with negative 
gains would not work in a same way as with positive gains - so 
supporting negative gains would probably require more than that, or work 
only as a dummy selector <=> gain converter without the time tables).

So, the v5 will likely still use int as type for times and gain but also 
have a check in initialization enforcing this. I will also document this 
restriction in the gain/time struct and init function documentation.

I don't think the v5 is final version, especially because it will be the 
first version looping in the Kunit people. So we can keep iterating this 
for v6 if you still feel using ints is unacceptable :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


