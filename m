Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4219065DF36
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 22:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240344AbjADVoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 16:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240316AbjADVnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:43:51 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A5332183
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 13:43:18 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id p9so1910467iod.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 13:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=De2KyfyaLkXfGIWsuy0j26Xyb6UuEGvIk8lAUL6BYxQ=;
        b=mmBC8/1yOQMGUAVIi9g8mQR/Fb42TpXJW+315tHoB4/nUrGGHoJiJninkAw7SIuh0g
         7l6tkToSC6SF7Sbt7LFj25OS8Km5yZumMCGs4GccDH7S+zs2QUrsgQfgcn2Z1O9vuGDG
         e4td0IDWxgGu2kMMG42NfeXe0FWg8OTdrXr8YMlM+fA0RM9kVv07Zd20Q9aAFuCNhoP6
         CpOrDJUVz2mBr0bws2eXF36/UzkK8nHsqgA0fRdh0tlBU0izKdl1R56Vyr78sCcoUSFH
         6TGpQ/SuK0zsR5+Rg+TAyXPE6V5x59i5MXiPs8NkILiXpixDfOel/p4KAX27wwcnYijl
         RQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=De2KyfyaLkXfGIWsuy0j26Xyb6UuEGvIk8lAUL6BYxQ=;
        b=vcSZ6WyYp2ulTNGRL5F4Y6XlkQhXcq2rgfiQVfvv3TuU5ybCEv1U6dP7eKYSfpYw5A
         Lw3rgYL6yzAzBEMZo4E1RrQ4HnYRdSSFBdUqvV4QCg8rHAjySWYIIcV4Znt22AHgT7NI
         aU1sZMWFz93UK9Hk4t29v/99JDB5YYPwZS6NXTRD+Vch3fvP2LCxmRaJjthfm0GZBmgh
         UejgoBInG9b99ZYUmykxYYIJK+QcBViy2qKHNFcsELXMyBPdKd6j8Tc4ZNjcad5ZWjEH
         EB8ZAGd/ZgHVjlZnz7Z45axgYWEZ1UtJEh1RuNPtC7BZilgVl4vl/avOd5p223EXsJYY
         vk0w==
X-Gm-Message-State: AFqh2kqFyPOEFXujYXO5dgumYQS8hny3VdA4sWdlPbBx2uzhQKt2b9fq
        qhQl9aW98rJpgGPk1PHzXW6PRA==
X-Google-Smtp-Source: AMrXdXvHGzhVxBKdjyddv2IcUblMcwy9CA7jssWP24cTVqGbqEvhaSbkEOkGhV1WcRggUW1/A2aflA==
X-Received: by 2002:a6b:d107:0:b0:6e2:d939:4f30 with SMTP id l7-20020a6bd107000000b006e2d9394f30mr6258295iob.0.1672868597476;
        Wed, 04 Jan 2023 13:43:17 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id l43-20020a02666b000000b00389e9e6112csm10727559jaf.70.2023.01.04.13.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 13:43:16 -0800 (PST)
Message-ID: <90eb90da-2679-cac0-979d-6ba0cc8ccbb8@kernel.dk>
Date:   Wed, 4 Jan 2023 14:43:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Linux 6.2-rc1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20230104190115.ceglfefco475ev6c@pali>
 <CAHk-=wh1x-gbmE72xBPcEnchvmPn=13mU--+7Cfay0dNHCxxuw@mail.gmail.com>
 <20230104205640.o2uy2jk4v6yfm4w3@pali>
 <CAHk-=wiDdw8tRzzx=ZBzUftC1TOiOO+kxv0s8HS342BC-jzkLQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wiDdw8tRzzx=ZBzUftC1TOiOO+kxv0s8HS342BC-jzkLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/23 2:32?PM, Linus Torvalds wrote:
>> But here it is CD-RW media in read-write mode with kernel udf
>> filesystem driver without any userspace involved (after proper
>> formatting).
> 
> ... but I'm not sure about direct writeable mount support.
> 
> That may indeed be an area that only pktcdvd ended up doing. I've
> never used it myself, even historically.
> 
> Let's bring in more people. Because they may not have thought about
> some RW UDF case.

We did think about it, since that's the only reason for pktcdvd to
exist. Basically what the driver does is ensure that any write is 32K in
size, which is the size which can be written to media. It'll gather data
as needed to make that happen. Thats it. Outside of that, it's just some
setup and closing code.

This obviously would be better to handle in userspace, all of it. Back
when I wrote this driver, we didn't have a lot of the fancier stuff we
have today. It could be done via ublk, for example, or something like
that.

The surprising bit here is:

1) Someone is still using this driver, and
2) It actually works!

While I'd love to nudge folks in other directions for this use case, and
I strongly think that we should, it also doesn't seem fair to just yank
it while folks are using it... But I'd like to VERY strongly encourage
folks to come up with a new solution for this use case. It really isn't
a solution that belongs in the kernel today.

> The removal seems to revert cleanly, although it does require
> reverting a few subsequent commits too (that removed code that only
> pktcdvd used):
> 
>     git revert db1c7d779767 85d6ce58e493 f40eb99897af
> 
> where we have
> 
>     db1c7d779767 block: bio_copy_data_iter
>     85d6ce58e493 block: remove devnode callback from struct
> block_device_operations
>     f40eb99897af pktcdvd: remove driver.

I'll queue this up - and unless I hear valid complaints to why we should
not just reinstate the driver for now, it'll go out with the next pull
request.

-- 
Jens Axboe

