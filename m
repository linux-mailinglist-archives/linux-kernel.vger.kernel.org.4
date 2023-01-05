Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D80565F4BD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbjAETlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235963AbjAETlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:41:04 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BA45FEF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:40:27 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id g2so18353467ila.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 11:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ndPvaTsaoTE5SC6/Vqr4zHTHR4/XN4QmcAkvyfGtPCA=;
        b=JXTHp7UKxikNU0TyJBzceAg+eUBNrJI8R4gih1Yi9agyHc5B2nG4Yeb0rMfEEuiG1P
         lKfMcan/x2GiOfdYFWrc0KJcJTmaiCpDsms3zgXHJOhByB/ohy7MD3Hw85mUDgfiE3m+
         7jv2JF47A6/ek7tQFxw6EBE7xF23+VraJ0kLAVRhhqg3JJ+DebJDAyn5OoAMI2sZyDus
         mIRoZrGDyZE8Y/K2LNHTksJSsvwZy8C+chbUvMHZ8GJBkyvmgSyYzj3wgfLL7ifN+8lM
         kv3jITnNDXDEEqyWJ+xaA/nysaupOI9PZInQrpkzsavsQXnx1KZETHixlGKU0ZHv4Zft
         Oq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ndPvaTsaoTE5SC6/Vqr4zHTHR4/XN4QmcAkvyfGtPCA=;
        b=B70NrMAiUMna99G2U596K+/Rug0hkHa/EYZnSHpBFxId0pT7x4RJX8uUlBmswDbPSf
         E68q7FZNEyKoyUVkS0QXd2lkHRA49omHWjvOptfx3lUMR5MQ/piaG2g8j+xNF9PEkmpx
         CD4AvyF0SO+3T26vXGod0JfQZMmv43YBFDuaWD+y2r0EnRmV+yT/V5mFHJhoIuDrJATj
         m5IfpzttdHAOt0FWn9MlpSVRBPzvY0kSrYzDso3UfUlkHQSpqsM36Kbl9xFtAkKXyZsP
         OlWKFeqF54DvSyq0Ix+l+USQtyqYWOfXoeSxFtdyNHhJbCJRtvQltKWfltHZKfXXojnd
         2t3A==
X-Gm-Message-State: AFqh2kovoj8cr/1SdjTG00FAai/TDwTeu9ASqJWpaNPot/dxglI5uEIY
        l3dpnb2+AfUsO/G6MyYnNHEa9RJLO9L4//JH
X-Google-Smtp-Source: AMrXdXsNc8yOiNzcttZT0gEpjlxVV/aqz7DjAGMuF7wyiw4rC+fTXvfVWjyPhxNvi85R4YaLa/Regg==
X-Received: by 2002:a05:6e02:12af:b0:30b:fe91:35ed with SMTP id f15-20020a056e0212af00b0030bfe9135edmr4994264ilr.1.1672947626781;
        Thu, 05 Jan 2023 11:40:26 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x2-20020a92d642000000b0030c053fb7ccsm9142797ilp.47.2023.01.05.11.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 11:40:26 -0800 (PST)
Message-ID: <1933bddd-42d7-d92b-974f-f26c46c01547@kernel.dk>
Date:   Thu, 5 Jan 2023 12:40:25 -0700
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
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wiKUWm3VoYHK-oKixc9nF5Qdwp598MPSoh=jdxKAU1bOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/23 12:06 PM, Linus Torvalds wrote:
> On Thu, Jan 5, 2023 at 9:45 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Not quite sure what that refers to, as I'm pretty sure I did all of that
>> work. But maybe Linus can refresh my memory here :-)
> 
> I was definitely there, part of making it actually work for *every*
> block device.
> 
> Long long ago, it used to be limited to the sg_io() interface, and
> only worked for SCSI devices.
> 
> So you couldn't actually burn CD's with the regular IDE/ATA CD ROM
> drivers directly, but had to use a shim driver, kind of like pktcdvd.
> Except I think it was just /dev/cdrom.
> 
> See
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=90df68e70b
> 
> for some of it (exposing SG_IO to all the block ioctls), and the "make
> it more usable" parts that made it do sane permission checking in
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=a75aaa84276
> 
> and the commits preceding it for that part of the work.
> 
> But yes, you were very much involved too.

I knew that'd get you digging into the archives ;-)

Fair point, I was mostly thinking of the block infrastructure for doing
non-fs commands.

>> As mentioned, I don't think this kind of code belongs in the kernel. sr
>> or cdrom could easily be modified to support the necessary bits to
>> handle a writeable open, but the grunt of the pktcdvd code deals with
>> retrieving and writing out bigger chunks of data. And that part really
>> does belong in userspace imho.
> 
> Well, it's the UDF write support that is the issue.. I didn't even
> realize people did that.
> 
> You'd presumably have to re-do it as a FUSE thing.

Or even implement it in UDF itself somehow. But yes, ideally we'd punt all
of this data gathering to userspace and just leave the trivial init/stop
atapi/scsi commands to cdrom/sr.

-- 
Jens Axboe


