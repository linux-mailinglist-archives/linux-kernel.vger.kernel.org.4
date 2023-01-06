Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B334F660540
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 18:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbjAFRFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 12:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbjAFREx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 12:04:53 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5735041667
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 09:04:49 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id b192so957969iof.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 09:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=quPb6FVlAQ5qiBruUpr9V9WIKVosqVSNcVojhNKEkNY=;
        b=8RNzul8Mjh/EP7FyNx/2tAqK2KIUVWx3qBIdSAwdiiCqrez2XOpSck/0S9ziTyCC3h
         7LUW+DgZhYb9RsT/XRqhgLGybl5eyQ1YMhgkAfvpQG6ykvZn0tX382yYeOH6dRq8D+8p
         cgOxp+HHEadexLX9EueZXCB09i5csnAsMtyjeGlZ7Ca+ctnrGqotgf2f5G0W47Up4vVH
         I8P58H90EwscFKpVUaI4H1KouYTruNQOfhUdriVUesqdTk7E7DGSI2lt+JpdNLRNOX3G
         Jvp6K0cAaEVnDxkl+Cj05GiZTQNdpq+hvwyrSaI92XlFxXfGwG/eExRpn7OdGXFTXZWv
         lKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=quPb6FVlAQ5qiBruUpr9V9WIKVosqVSNcVojhNKEkNY=;
        b=xatgZMauTUzU1JDu20qthZFDZUgBAXZADoNwMvtWjLoMYczyGdgx0A5uF7YLfmoYsp
         QrjdD3OnTLuKblZgSB3+ZFUYIkewZG2kqqGMZkL/qZsjLy+sWBesuWmaQTcK5fixfJEu
         IvT80nNVL4hyagdQyJdbF7GynBJxJOsFdfcChLalx94X9WCCn6xFX8Jsh1xkq4E/X+PH
         MY/jDs+GfDyAKANp5/NioFRlnJu0e1wje9LCCY6QVPZdcon7ddKvQEm/zHmDwXEP5evg
         tbayjUpApAf5a/RTmZalTXRzfciVagbeRAxGB++megbhUQKyIR2TCzZgzG9HcOcAFmdP
         mC2Q==
X-Gm-Message-State: AFqh2koVikWyh3BvuedwzHZvgLZoPKXtG7lHHCL4uHf2nqoCQT2eU5sp
        mCATpph/YldCLh2/c3HLK9uhjg==
X-Google-Smtp-Source: AMrXdXsy+XxLv5SZyYbIYdMqvie8Hwq48qfj1ffop+bv0Yopp0D7QW+9gD5PK4Rvir9ktILtm2jyLQ==
X-Received: by 2002:a6b:7d46:0:b0:6ed:1ad7:56bc with SMTP id d6-20020a6b7d46000000b006ed1ad756bcmr8029354ioq.0.1673024688577;
        Fri, 06 Jan 2023 09:04:48 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id d65-20020a0285c7000000b0038a0eff63d0sm435208jai.155.2023.01.06.09.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 09:04:47 -0800 (PST)
Message-ID: <fd143218-d8ba-e6c5-9225-b8e2aee09979@kernel.dk>
Date:   Fri, 6 Jan 2023 10:04:47 -0700
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
References: <CAHk-=wh1x-gbmE72xBPcEnchvmPn=13mU--+7Cfay0dNHCxxuw@mail.gmail.com>
 <20230104205640.o2uy2jk4v6yfm4w3@pali>
 <CAHk-=wiDdw8tRzzx=ZBzUftC1TOiOO+kxv0s8HS342BC-jzkLQ@mail.gmail.com>
 <90eb90da-2679-cac0-979d-6ba0cc8ccbb8@kernel.dk>
 <20230105174210.jbjoqelllcrd57q6@pali>
 <58d3649f-3c8c-8b12-1930-f06f59837ad5@kernel.dk>
 <CAHk-=wiKUWm3VoYHK-oKixc9nF5Qdwp598MPSoh=jdxKAU1bOw@mail.gmail.com>
 <1933bddd-42d7-d92b-974f-f26c46c01547@kernel.dk>
 <CAHk-=wjJ=wD5D80hkWNCjJqS+djckAL+nXhXaHaiFzMAMve3rA@mail.gmail.com>
 <182bc0ee-51e3-b8c4-59f7-dcf702865a95@kernel.dk>
 <20230106165809.vkz7lr7gi3xce22e@pali>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230106165809.vkz7lr7gi3xce22e@pali>
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

On 1/6/23 9:58?AM, Pali Roh?r wrote:
> On Thursday 05 January 2023 13:33:11 Jens Axboe wrote:
>> On 1/5/23 1:03?PM, Linus Torvalds wrote:
>>> So nobody is going to be motivated to do any development in this area,
>>> and the best we can do is probably to just keep it limping along.
>>
>> Indeed...
> ...
>>> There's probably other cruft in pktcdvd that could be removed without
>>> removing the whole driver, but I do get the feeling that it's just
>>> less pain to keep the status quo, and that there isn't really much
>>> motivation for anybody to do anything else.
>>
>> I'm reluctant to touch it outside of changes that are driven by core
>> changes, and of course the motivation to remove it was driven by not
>> wanting to do that either. Any kind of re-architecting of how it works I
>> would not advocate for. It supposedly works well enough that none of the
>> (few) users are reporting issues with it, best to just let it remain
>> like that imho.
> 
> Yea, I agree. This code is in state when it is _used_ and not developed
> anymore. Nobody is really motivated to re-architecture or rewrite this
> code. Such work has big probability to break something which currently
> works fine. And because lot of users are on stable/LTS kernel versions,
> it is possible that we would not notice breakage earlier than (lets say)
> in 5 years.

I did sent out the revert this morning, would be great if you can test
6.2-rc3 when it is out. I'm a bit skeptical on the whole devnode front,
and suspect we might need to convert that to disk_name manipulation.
Which would be fine, as we can then drop the devnode reinstate revert as
well going forward. But I need to find a bit of time to look closer at
this part.

-- 
Jens Axboe

