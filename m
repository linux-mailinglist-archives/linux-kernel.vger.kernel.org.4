Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E33365F312
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbjAERqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbjAERpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:45:54 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843FD1C128
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 09:45:51 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id a9so8983409ilk.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 09:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L5esNute0H14yGWbbCh4lVxggZui8WW0AVXyx8X1jQ0=;
        b=Hy7i6CIX6jT9iep1jaxltOlFnTqdzgsboXBHzZHD0CJWA1FmYKnHBudge4uCvrRUaf
         YqjSSXXDvAduWzXstLUmf0LC/P8IF2Wb8cIty9VHqIElT+PGqngwccEolHPxxYl1JLoq
         xFDDW1zwa/iSgiQT9nL6FA5BKgP6oBp9oW9ilhVvE1OQIOaNCxf2nmXMMIt2imSLnNjz
         yVFoAo3pKFI5l/tCfHyRl5GCPSGzr/tHRgb4W8DKxxaUCSsaGWGilv9L8HJ6D+x8pCxR
         f8enY5MypfRDja8yjtcvgQfCgmQ7e+TTsZXC4l6l8Be7EyNZ1qlcZIs+z2ZsD5zjHE36
         DtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L5esNute0H14yGWbbCh4lVxggZui8WW0AVXyx8X1jQ0=;
        b=sCvyb1wPOl+TQ/b7ROyJIkbhz1+xsm2w1c5G2NMVI9DS/rTVy16PzImeykpZ5/6In0
         pfTkGuI1UQqi/t+mDTGyXwycc9GAhLQ1m3UAMQImQWv9TedDr/0WJdNG2NIYf3b/rIBz
         k4MIX2eHKqau9VpXP8512D6vhkkXJH0cMdntFFd0KqKLz/QBHYauVUMp7aY/0loABTAN
         VRrheIk+TvgqiwwU+9qHNMbPrDz/4nNUxT5JVi4378xqcvZzfTDPURkFTTYDFl+n95WL
         ewfs9327mTc4/aZfv0MK9kOxVauHO0rjAUH+ERd2aR8vJHbhEK1nrM28WzCSlZ5PJUO7
         JH+g==
X-Gm-Message-State: AFqh2kriX/3OvF55ZLjl0X9KWl1iAcZ0mtCBidmT2s78t01jEc3cqREn
        U4EQy//rIyE/N3hCPnK8/ZF8gf139nYNz5IK
X-Google-Smtp-Source: AMrXdXumQK32bn9UDSky03TEaTYE6kwrohJXQp/8aqe2KJGOWDYRrGmTeBLtatPb57twROE822gN/w==
X-Received: by 2002:a92:d4ce:0:b0:30c:493e:ecf2 with SMTP id o14-20020a92d4ce000000b0030c493eecf2mr2254021ilm.0.1672940750771;
        Thu, 05 Jan 2023 09:45:50 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id q9-20020a05663810c900b0038437cba721sm11850112jad.7.2023.01.05.09.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 09:45:50 -0800 (PST)
Message-ID: <58d3649f-3c8c-8b12-1930-f06f59837ad5@kernel.dk>
Date:   Thu, 5 Jan 2023 10:45:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Linux 6.2-rc1
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230105174210.jbjoqelllcrd57q6@pali>
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

On 1/5/23 10:42?AM, Pali Roh?r wrote:
> On Wednesday 04 January 2023 14:43:16 Jens Axboe wrote:
>> On 1/4/23 2:32?PM, Linus Torvalds wrote:
>>>> But here it is CD-RW media in read-write mode with kernel udf
>>>> filesystem driver without any userspace involved (after proper
>>>> formatting).
>>>
>>> ... but I'm not sure about direct writeable mount support.
>>>
>>> That may indeed be an area that only pktcdvd ended up doing. I've
>>> never used it myself, even historically.
>>>
>>> Let's bring in more people. Because they may not have thought about
>>> some RW UDF case.
>>
>> We did think about it, since that's the only reason for pktcdvd to
>> exist. Basically what the driver does is ensure that any write is 32K in
>> size, which is the size which can be written to media. It'll gather data
>> as needed to make that happen. Thats it. Outside of that, it's just some
>> setup and closing code.
>>
>> This obviously would be better to handle in userspace, all of it. Back
>> when I wrote this driver, we didn't have a lot of the fancier stuff we
>> have today. It could be done via ublk, for example, or something like
>> that.
>>
>> The surprising bit here is:
>>
>> 1) Someone is still using this driver, and
>> 2) It actually works!
> 
> Yes, there are still users and userspace tools (cdrwtool / pktsetup) are
> still receiving either small patches or issue reports. I think that it
> was two years ago when cdrwtool received big fixups to support
> formatting CD-RW discs on new CD/DVD drives.
> 
>> While I'd love to nudge folks in other directions for this use case, and
>> I strongly think that we should, it also doesn't seem fair to just yank
>> it while folks are using it... But I'd like to VERY strongly encourage
>> folks to come up with a new solution for this use case. It really isn't
>> a solution that belongs in the kernel today.
> 
> Linus in previous email wrote that he did "make SCSI commands generic"
> work in past so direct usage of /dev/cdrom device works for CD-R burning
> and read-only mounting.

Not quite sure what that refers to, as I'm pretty sure I did all of that
work. But maybe Linus can refresh my memory here :-)

> So could not be (for example sr.c) driver extended to directly do
> pktcdvd's work? So when somebody opens /dev/cdrom device in O_RDWR mode
> and CD-RW medium is present then it would behave like pktcdvd device...
> To have /dev/cdrom generic also for CD-RW write access.

As mentioned, I don't think this kind of code belongs in the kernel. sr
or cdrom could easily be modified to support the necessary bits to
handle a writeable open, but the grunt of the pktcdvd code deals with
retrieving and writing out bigger chunks of data. And that part really
does belong in userspace imho.

-- 
Jens Axboe

