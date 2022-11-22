Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E49E6342B0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 18:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbiKVRmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 12:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbiKVRm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 12:42:29 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEDC2BE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 09:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FGKDqY1T60A3C7N/lcT49zMO33CwSJOhROd+ZwakGpk=; b=if1eLeRkpYxJ2qkgSCt/OuJZs+
        h3Snk0XxHXgJ/Jah6Jxi9P4E+MsyaTJ4cVBTGKdBygawHKk1b4yBV8FY5Ne3wILKlLiNC5bSYpKUE
        imEgahBg8luSbFnYoAkApFNCFu+0OwjRbYY/V96CfdvwvXw4LAnNTX+/J9CuwSrm/psXIPxLNIw9d
        xqhZYsLHos+hVpcY1pxE7u8cmCwClPuGDSaW4tCHyDwQywKjmFZuoKz7amSCCOahlXxXkN48qQtnJ
        h3QUAnwUUZjI8EQN4wHZn8mmb57ZpT/ZSYegryDZ1/SCO7Nkf0WqD9MczBc7wIQzlG3k58GHRwSCj
        xU9iM/WQ==;
Received: from [2a01:799:95e:1700:6395:ccbd:d000:d42b] (port=55405)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1oxXHq-0004Ma-E3; Tue, 22 Nov 2022 18:42:22 +0100
Message-ID: <3b06dfd5-0eb4-dbfc-6ba8-077b1a92865b@tronnes.org>
Date:   Tue, 22 Nov 2022 18:42:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: git send-email friendly smtp provider anyone?
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Maxime Ripard <maxime@cerno.tech>, dri-devel@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <1bc45775-0667-01f8-36e1-9f65d3081092@tronnes.org>
 <20221121151922.jaal6ym7z2ejju4q@houat>
 <de12952f-8346-8995-236d-69dcb70f19f6@tronnes.org>
 <20221122155122.edxtmsqpjxgj4dsj@meerkat.local>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20221122155122.edxtmsqpjxgj4dsj@meerkat.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 22.11.2022 16.51, skrev Konstantin Ryabitsev:
> On Mon, Nov 21, 2022 at 07:13:28PM +0100, Noralf Trønnes wrote:
>>> Otherwise, you might consider using:
>>> https://b4.docs.kernel.org/en/latest/contributor/send.html#authenticating-with-the-web-submission-endpoint
>>>
>>
>> That's an interesting option. I did briefly look at b4 a few months back
>> but it looked like it was under heavy development so I figured I'd wait
>> before trying it out. I think I'll give b4 a spin to see how it works, I
>> wonder how it handles patch changelogs.
> 
> I'd be happy to help set this up for you -- to date, this service hasn't been
> used beyond a few test posts.
> 

Ok, I'll give it a try.

I have now prepared the patchset, generated a key and can now do:
b4 send -o

The first thing that strikes me is that everyone mentioned in one of the
patches get the entire patchset, even stable@vger.kernel.org (cc'ed in a
fixes patch). The first patch touches a core file and as a result a few
drivers, so I've cc'ed the driver maintainers in that patch, but now
they get the entire patchset where 5 of 6 patches is about a driver that
I maintain. So from their point of view, they see a patchset about a
driver they don't care about and a patch touching a core file, but from
the subject it's not apparent that it touches their driver. I'm afraid
that this might result in none of them looking at that patch. In this
particular case it's not that important, but in another case it might be.

As for the setting up the web endpoint, should I just follow the b4 docs
on that?

I use b4 version 0.10.1, is that recent enough?

Noralf.
