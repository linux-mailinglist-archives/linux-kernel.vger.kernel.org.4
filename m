Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839CD6F9114
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 12:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjEFKD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 06:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjEFKDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 06:03:25 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481AFE7;
        Sat,  6 May 2023 03:03:24 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3078a3f3b5fso247383f8f.0;
        Sat, 06 May 2023 03:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683367403; x=1685959403;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ueELjeyb07hK7s0pC0O3S1xswXDm+l4FhQ/cLtbQFdY=;
        b=ijgf9H6u0z6xvbCdR6MZliCOCpcFyulCuDDqJbfsi5cRetTdQZNeeBzg9uVx7zd3R5
         dbKjGB2xKxR6anv7BwvUMbIX2VjKHp1q0qHsqu0H+9DvTBgP4kAcZBzeAF+tw/JJ0y5v
         8rLmf8jaJDC3rgrSSh/AOk9NzDB8JEa75yHn/VCAuutucEezZdDH4emw7Gh2WiKeLwDn
         61slkDJbr8YqcgSCmq1UZvwPgnK9Ug7HZeizlX2eqoUVvUUkO2/o0HpwDenct4Wh2xZb
         q7yoAQ/EwsW/WDTdEBWw1EMAGJ2OzoR5f27I+pc/zg8kXP/TG/Pdo/zWng8+6Y56Xg0q
         N7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683367403; x=1685959403;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ueELjeyb07hK7s0pC0O3S1xswXDm+l4FhQ/cLtbQFdY=;
        b=j++h3mQ1sqWW0dMSD0Ef7pY3ZV1Dd5eunOj+pmFvDfheIHcQHmo/hjmGs/w+e4z4+P
         rBfX6tHIKbeGspE7hbYKA8uut30mt0RS3k+gsNiY1TCCgTgoOc1LAQOihRSSzVWlJnua
         dqVag/R24eZ7WbENHZS8VVN5wIAvY3WELB7HEOBknJpkZvlfiPI5SEhtts7+k0rPp3p2
         x18noYNR2sY/GKfOSGk9otiyoZ+jsW09GmJdLUkmhjHcnK15Evn1bZfzzkGUltaPG7aT
         mKB240NPb+YzcziuGD+EZOnp94K/oiOd8S3nSOPtQDUdQaS8gVGzNOzBgptUTS+64j0y
         +NKw==
X-Gm-Message-State: AC+VfDzW2H/KGiAQXyl6LscF4qN3RJePeRUYq6LA8w4JIs/TPtBDMBH+
        W0nl6sAYXeFplHHVWGtaGW8=
X-Google-Smtp-Source: ACHHUZ4exEZlHERpphG3smZebUsKKHHZB3izbZ3aFCuxqcJ6NrJnviwY90uDJOlr70D+IwhHZyoV2w==
X-Received: by 2002:a5d:4a86:0:b0:306:2aea:3dff with SMTP id o6-20020a5d4a86000000b003062aea3dffmr3587169wrq.31.1683367402553;
        Sat, 06 May 2023 03:03:22 -0700 (PDT)
Received: from [192.168.1.10] (95f1f744.skybroadband.com. [149.241.247.68])
        by smtp.googlemail.com with ESMTPSA id h14-20020a5d6e0e000000b0030631dcbea6sm4935067wrz.77.2023.05.06.03.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 03:03:21 -0700 (PDT)
Message-ID: <8f00f1a8-5f5a-44f2-088a-6f7d5c595d18@googlemail.com>
Date:   Sat, 6 May 2023 11:03:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: Linux 6.3.1
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        jslaby@suse.cz
References: <2023050123-resubmit-silica-ac32@gregkh>
 <c2ac55a4-aaf5-2f49-be08-d326fe0c17f8@googlemail.com>
 <2023050202-slouchy-princess-e7dd@gregkh>
 <2023050225-brutishly-enlarging-c54e@gregkh>
 <2023050201-bluish-habitable-474a@gregkh>
 <c7842e46-fc41-c989-b5e7-ec504cd0c8f2@googlemail.com>
 <2023050612-failing-headset-0d9c@gregkh>
Content-Language: en-GB
From:   Chris Clayton <chris2553@googlemail.com>
In-Reply-To: <2023050612-failing-headset-0d9c@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/05/2023 01:52, Greg Kroah-Hartman wrote:
> On Tue, May 02, 2023 at 02:12:58PM +0100, Chris Clayton wrote:
>> Hi Greg
>>
>> On 02/05/2023 08:31, Greg Kroah-Hartman wrote:
>>> On Tue, May 02, 2023 at 08:43:47AM +0900, Greg Kroah-Hartman wrote:
>>>> On Tue, May 02, 2023 at 06:40:03AM +0900, Greg Kroah-Hartman wrote:
>>>>> On Mon, May 01, 2023 at 07:22:56AM +0100, Chris Clayton wrote:
>>>>>> 6.3.1 FTBFS thusly:
>>>>>
>>>>> What is "FTBFS"?
>>>>>
>>>>>> drivers/net/wireguard/timers.c: In function 'wg_expired_retransmit_handshake':
>>>>>> <command-line>: error: format '%d' expects argument of type 'int', but argument 6 has type 'long unsigned int'
>>>>>> [-Werror=format=]
>>>>>> <command-line>: note: in expansion of macro 'KBUILD_MODNAME'
>>>>>> ./include/linux/dynamic_debug.h:223:29: note: in expansion of macro 'pr_fmt'
>>>>>>   223 |                 func(&id, ##__VA_ARGS__);                       \
>>>>>>       |                             ^~~~~~~~~~~
>>>>>
>>>>> <snip>
>>>>>
>>>>>> There's a patch to drivers/net/wireguard/timers.c that fixes these errors and you can find it at
>>>>>> 2d4ee16d969c97996e80e4c9cb6de0acaff22c9f in Linus' tree.
>>>>>
>>>>> Thanks for this report, we'll queue it up soon.
>>>>
>>>> Odd, that commit is in 6.2 already, so how are you applying this to
>>>> 6.3.y?
>>>
>>> And this is only a gcc13 issue, right?  So it's not a regression, it's
>>> always been there, nothing new caused it in this release from what I can
>>> tell.
>>>
>>> Actually I don't see how this is an issue in 6.3.1 anyway, as again, the
>>> proposed fix you gave is in 6.2, so what really is happening here?
>>
>> You seem not to have seen the email I sent shortly after my original report. In that email I apologised for the noise
>> because, due to a caffeine deficiency, I had reported the problem against the wrong kernel version and that it actually
>> occurs 6.1.27. gcc13 spits it out as a warning, but kernel build system is setbup to treat warnings as errors, so the
>> build fails.
> 
> Ok, but this is not a new issue, right?  6.1.26 should have had the same
> problem from what I can tell.
> 

I don't know. I haven't tried to build 6.1.26 with gcc13. The commit message for the patch in Linus' tree says that this
is a new warning in gcc13.  The kernel build system configures gcc to treat warnings as errors so, with gcc13, the build
failed and I reported the failure in the initial email of this thread. Looking at that patch submission
(https://lore.kernel.org/all/20221213225208.3343692-2-Jason@zx2c4.com/), it appears not to have been tagged for or
copied to stable.

Once I'd realised that I had reported the problem against the wrong kernel version, I sent my apologetic email and sent
a new email reporting the problem against 6.1.27. In response to that (I assume), you've queued the patch for 6.1 stable
and for 5.15 and 5.10, so everything seems to be in order.

Chris


> greg k-h
