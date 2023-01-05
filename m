Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7956A65F53F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 21:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbjAEUdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 15:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjAEUdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 15:33:17 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4790B63D2A
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 12:33:13 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id r72so20121643iod.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 12:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oWK2+LLnEEkZxuCUep1sREpc2yMexGKInZH9UGn1wUs=;
        b=keFu6AWqGbKqmjzWAPYIGm7rqVuxQmO3o/WPZxlSAQgQ86slUKhtRuvKgwzCNUjRLx
         7JYR1gYiEde27yz3Kupun0Md0YTOeIidhYmbDeLb2RiLUGXwotuYlWseCFNewHNTrpE0
         +MHte3JRFEuVIW9IAlbF8IO3xSt762/bpfrnHPkXBl1sQ9td4qVHntmOF7ZbNkrdta5z
         vSEv2EIB8ufpKwOxvHPHjv/cPlWogXctThbKc7muVHEsZ+hGrlpLx+ss/u5duSQ8nUVC
         B48Y5jDSK4XMKJolIyeMCnKF3gPoR/jqXjoe5v/FtYlaerD1LG/AILNKQI6CPGv59YoX
         5KXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oWK2+LLnEEkZxuCUep1sREpc2yMexGKInZH9UGn1wUs=;
        b=A0abrT/fNi0aauh/4YQMHYlcn5c+hB6S/wicjpqv60j6riV/vA5vh63xJEIB6U/b5k
         8UG/yAXPN9jRhDyBH91AKFm5Q4AKi4MNa9UmDKzmQKE+cZ7pPZfLAlYqHwLDvWU6qV/k
         T6HlgsuhpPHaEDus6Pf7BT0JNSmyooH7++dZgR+QOZuXO7n/e7cuuSZDnrds5g2n1JbT
         qe7Rzi+TlFAE7OyPimkcB2vUVhZH4W0eSV2oxnHM77qwfLXHggoWCRsAjfrhAkV3FlMK
         VqB31AtmUWLoVXdfBH/mSXyvTo7hdNnCs8JAgKdRHh9ghJU/Y/qXMdDHOUz35NjLcSJh
         rRGA==
X-Gm-Message-State: AFqh2kodXzpe1/zBm0H8j+sJH3tOs8vaA2mTKNTTOnoSnOqt/TPhdX/T
        L/gdnLJCs0EEQ5pWBmpuT5AleQ==
X-Google-Smtp-Source: AMrXdXs9yi0hb5zO5K5aKPvuP0NwAoUpU9XAzSkNQvQuKKZ3Tw7FQMBC5SjP1tjLuaOkjJcK4eW4cg==
X-Received: by 2002:a05:6602:2439:b0:6dd:7096:d9bc with SMTP id g25-20020a056602243900b006dd7096d9bcmr7038389iob.2.1672950793244;
        Thu, 05 Jan 2023 12:33:13 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id l15-20020a0566022dcf00b006eba8966048sm13520336iow.54.2023.01.05.12.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 12:33:12 -0800 (PST)
Message-ID: <182bc0ee-51e3-b8c4-59f7-dcf702865a95@kernel.dk>
Date:   Thu, 5 Jan 2023 13:33:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Linux 6.2-rc1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20230104190115.ceglfefco475ev6c@pali>
 <CAHk-=wh1x-gbmE72xBPcEnchvmPn=13mU--+7Cfay0dNHCxxuw@mail.gmail.com>
 <20230104205640.o2uy2jk4v6yfm4w3@pali>
 <CAHk-=wiDdw8tRzzx=ZBzUftC1TOiOO+kxv0s8HS342BC-jzkLQ@mail.gmail.com>
 <90eb90da-2679-cac0-979d-6ba0cc8ccbb8@kernel.dk>
 <20230105174210.jbjoqelllcrd57q6@pali>
 <58d3649f-3c8c-8b12-1930-f06f59837ad5@kernel.dk>
 <CAHk-=wiKUWm3VoYHK-oKixc9nF5Qdwp598MPSoh=jdxKAU1bOw@mail.gmail.com>
 <1933bddd-42d7-d92b-974f-f26c46c01547@kernel.dk>
 <CAHk-=wjJ=wD5D80hkWNCjJqS+djckAL+nXhXaHaiFzMAMve3rA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wjJ=wD5D80hkWNCjJqS+djckAL+nXhXaHaiFzMAMve3rA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/23 1:03?PM, Linus Torvalds wrote:
> On Thu, Jan 5, 2023 at 11:40 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Or even implement it in UDF itself somehow. But yes, ideally we'd punt all
>> of this data gathering to userspace and just leave the trivial init/stop
>> atapi/scsi commands to cdrom/sr.
> 
> I wonder how much of that could be done by just having a different
> elevator algorithm for cdrw devices..
> 
> Anyway, realistically I suspect the real answer is that "nobody cares
> enough any more". I suspect most people haven't used RW optical media
> in over a decade, and we're talking about an increasingly dwindling
> niche use.

While there's some overlap with IO scheduling, I don't think that'd be a
good layer to solve it at. And since this isn't exactly up-and-coming
technology that we expect to proliferate, that makes me especially
hesitant to invest any time in that particular direction.

I still think that doing something with ublk would be the best approach,
and push the data gathering and fixed sized write bits in userspace.
That would still allow arbitrary filesystem usage for these kinds of
devices.

> Optical media may still make sense for backup, but probably not the
> "filesystem" kind.

I don't think it ever made sense, except from a convenience point of
view. And that's most likely what drove the adoption there. It is way
easier to mount a cdrw read/write and copy files there, even if it's
slower than burning an iso image...

> So nobody is going to be motivated to do any development in this area,
> and the best we can do is probably to just keep it limping along.

Indeed...

> Now, it's a bit sad how pktcdvd is the only user of that 'struct
> block_device_operations' devnode thing, and I liked how that went away
> after the removal of this driver.
> 
> And I'm not sure why pktcdvd needs it, everybody else seems to be
> happy with gendisk->disk_name.

Let me look into that, I actually don't know. Would be nice if we could
fix that up and re-instate that particular patch.

> There's probably other cruft in pktcdvd that could be removed without
> removing the whole driver, but I do get the feeling that it's just
> less pain to keep the status quo, and that there isn't really much
> motivation for anybody to do anything else.

I'm reluctant to touch it outside of changes that are driven by core
changes, and of course the motivation to remove it was driven by not
wanting to do that either. Any kind of re-architecting of how it works I
would not advocate for. It supposedly works well enough that none of the
(few) users are reporting issues with it, best to just let it remain
like that imho.

-- 
Jens Axboe

