Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AA6680204
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 22:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjA2VyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 16:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbjA2VyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 16:54:15 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388EB20066
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 13:53:46 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id o13so9461029pjg.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 13:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lenwfyt4XvzIUZ16HWWPBtIzQWvyhKceCQdZ0VuZO3w=;
        b=OyxU7MEdDXfM5wR/8pnckis9G5ty5kVpIn7hAEnXp7iykBN+p4R9cEOXnhnNHwYw0M
         v2VZ7Qr6z1hALdYw+v39XeYWAPawYFTkdmGaxlhjgIICJTT2CGemlA08MlLSkdfIH0NT
         hp2aNFHbOtwrn8PoTY+fbjBxlVNmzf4r/8iw64gIqA5OE4hNmac+CX+fHTRzOAToMZgz
         N1AlpEErNH9Rc16zzNdt25pD6M/KG53uqiO6XzjoEngADM1mkgFOtxukyS+yIQLFkkhP
         6zxCHSMk3549I65d5O+EZrznxgzIsOjxggKSCM4KIZ8YxXbQv0JxxL4BPLYXGxJY2fo+
         0TcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lenwfyt4XvzIUZ16HWWPBtIzQWvyhKceCQdZ0VuZO3w=;
        b=E0QeeifnMrfix4v3pg8x5V2LQX8wxYO3s9qYPgO3TNIY9p4S536Lm9uwmYcXMgQvu9
         FocURJLLNr2AFOSb9PN12sqLCnWZomSdgYoHYGDlA5QrgNZLoiT7p8USzvDjsvwyo/x4
         KL8G8KezSlG7bEGAz/3dRNfFXOFaTLDPcNPHqUf9AJXgfIc5Fl7mWxx4AisZiifdhT47
         sea7AZ+13dTn0yyudhklxm686n+vTw2fl4OokeY67LStwuiban68NXm9k8gRYt7eDlgM
         0v6Y/VbE5BsMM87RphSjzhpcHQW0paP3GSJYCnawhEv3YlDPPHk/qFRDg7HLPhiS24Wr
         1zSw==
X-Gm-Message-State: AFqh2kpBklTK04MBaaR282YeTUGYOKQV1KkAKCdhnpOSugNB0+xd5Jur
        0CH/LiIfzp44XzRU6PP+DoCFvQ==
X-Google-Smtp-Source: AMrXdXsC9PHeusSEQwGeQ+ecMmtSs5lMGKVkQ87Fn7ko54F9LOpD8ilOqAscMJPfGR49sqlX3l4RMw==
X-Received: by 2002:a05:6a21:33a6:b0:b6:7df3:4cb2 with SMTP id yy38-20020a056a2133a600b000b67df34cb2mr12177399pzb.4.1675029222950;
        Sun, 29 Jan 2023 13:53:42 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902a70400b0019619f27525sm6265711plq.302.2023.01.29.13.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jan 2023 13:53:42 -0800 (PST)
Message-ID: <f8bac3d8-4167-f9cc-5549-ff87a27f2155@kernel.dk>
Date:   Sun, 29 Jan 2023 14:53:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: pktcdvd
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wiDdw8tRzzx=ZBzUftC1TOiOO+kxv0s8HS342BC-jzkLQ@mail.gmail.com>
 <90eb90da-2679-cac0-979d-6ba0cc8ccbb8@kernel.dk>
 <20230105174210.jbjoqelllcrd57q6@pali>
 <58d3649f-3c8c-8b12-1930-f06f59837ad5@kernel.dk>
 <CAHk-=wiKUWm3VoYHK-oKixc9nF5Qdwp598MPSoh=jdxKAU1bOw@mail.gmail.com>
 <1933bddd-42d7-d92b-974f-f26c46c01547@kernel.dk>
 <CAHk-=wjJ=wD5D80hkWNCjJqS+djckAL+nXhXaHaiFzMAMve3rA@mail.gmail.com>
 <182bc0ee-51e3-b8c4-59f7-dcf702865a95@kernel.dk>
 <20230106165809.vkz7lr7gi3xce22e@pali>
 <fd143218-d8ba-e6c5-9225-b8e2aee09979@kernel.dk>
 <20230128193458.ukl35ev4mwbjmu6b@pali>
 <CAHk-=whfor49J0YTYi6zauiJ_MWwF-XwhSty+HvD4CzxFQ_ZGA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=whfor49J0YTYi6zauiJ_MWwF-XwhSty+HvD4CzxFQ_ZGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/23 12:43 PM, Linus Torvalds wrote:
> On Sat, Jan 28, 2023 at 11:35 AM Pali Rohár <pali@kernel.org> wrote:
>>
>> Hello! Sorry for a longer delay. Now I have started testing it with
>> Linux 6.2.0-rc5. Adding mapping works fine. Reading also works. Mounting
>> filesystem also works, reading mounted fs also. But after writing some
>> data to fs and calling sync cause kernel oops. Below is the dmesg log.
>> "sync" freezes and never finish.
>>
>> [ 1284.701497] pktcdvd: pktcdvd0: writer mapped to sr0
>> [ 1321.432589] pktcdvd: pktcdvd0: Fixed packets, 32 blocks, Mode-2 disc
>> [ 1321.437543] pktcdvd: pktcdvd0: maximum media speed: 10
>> [ 1321.437546] pktcdvd: pktcdvd0: write speed 10x
>> [ 1327.098955] pktcdvd: pktcdvd0: 590528kB available on disc
>> [ 1329.737263] UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2023/01/28 19:16 (103c)
>> [ 1435.627449] ------------[ cut here ]------------
>> [ 1435.627466] kernel BUG at drivers/block/pktcdvd.c:2434!
> 
> Well, this is very much an example of one of the BUG_ON() cases I
> absolutely hate - not only did it cause the traceback (which can be
> interesting), it also effectively killed the machine in the process.
> 
> So that BUG_ON() most definitely shouldn't be a BUG_ON().
> 
> Turning it into a WARN_ON() (possibly even of the "ONCE" variety)
> together with then finishing the IO with a bio_io_error() would have
> been a better option for debugging.
> 
> Of course, the real fix is to fix whatever causes it, and I don't know
> what that is.
> 
> So I'm just piping up to once more highlight my hatred of using
> BUG_ON() for "this shouldn't happen" debug code. It's basically never
> the right thing to do unless you are in core code that would kill the
> machine anyway.

To be fair, this code is 20 years old... It should not be using
BUG_ON(), totally agree, but that it was quite common back in those
days.

-- 
Jens Axboe


