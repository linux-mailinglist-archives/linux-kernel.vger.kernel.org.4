Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0214680245
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 23:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbjA2WeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 17:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjA2WeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 17:34:08 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE9C15C84
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 14:34:06 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id o13so9515988pjg.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 14:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eiAKzTObW2tYrzXGCGEmznuaaub0POTx4TlR4DMA8o8=;
        b=EFMPnA8gXwf1aG/KIyynliuuuLxptAsyvrZylq3vOV5uHfGxOGqJ0W1PflnwXYLI10
         qdfrWeewrE4li8fMfGNd6dNkJWKs7MJGWEzcUZlQrhCN/uwz8tHjXxf+5fljFPhX9ZCt
         WFfaLmtx7g1ALvXqEN42/h9HYOINlL5ZtXbGGEcJUXBFzZmHiYybFH5Vu3Y4MHlTboos
         1nyTaPFa/a0EvdYReYy3I7XA6d5zYNgQ8GIzUegGDBG9X6xaM+PEqLBSVQCRs3fqyEUI
         3irdqxhnVMhBKV+gkcD2m6XVGdv/HoBAZeLEioUrHV5cLrjZfJsLAyooQ/NmNgHrjFec
         BjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eiAKzTObW2tYrzXGCGEmznuaaub0POTx4TlR4DMA8o8=;
        b=O1rnMNfDsZgfqPzx43LCYWYUqkvSPCC6dHL75CR3sydpBGO0NuhasXHGSJ3TwO8tHN
         s+WpBYZc0giRmMEd4jw/mN18g2ubDRicmhZ9N1izbkljEBapsc3Uw8iQyNx9azMF+B9/
         GIrw+Z5nan+0iUxipvJnm1jfarz1uPFQzOC7HkeTmbI3bPuSWR2Fq8Chsj4bZ0x/QFhS
         hRTwzM5UkqaRjaad3ZlEZJMiNBkGW0C5Les8z06t5PQkTXf0r1f6dJcrxYv0AlLMcSyy
         3UYY+n4fKtEoZ0Y639sqS1kCq1a7vaH+f3+Grv3EiXjAh8MIiPb0YrvUN40cBtZsTRaM
         JzZQ==
X-Gm-Message-State: AO0yUKW8dNQZFoKpcHaXg/fhRlREGmWJvvk0kwY/4r2A+XJdOZ5cihII
        Xp0BeSgeTr0SezzOvVb97QjR8Q==
X-Google-Smtp-Source: AK7set8TpIzst3Ac4xYYXEWog41MtwP17qlKHNd1Jv5WZkGL1ToEmMEmMgQiaaxyfrnOggF/dm+Usg==
X-Received: by 2002:a17:902:e744:b0:196:86c2:ee89 with SMTP id p4-20020a170902e74400b0019686c2ee89mr322884plf.3.1675031645937;
        Sun, 29 Jan 2023 14:34:05 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id jj4-20020a170903048400b00189743ed3b6sm6376306plb.64.2023.01.29.14.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jan 2023 14:34:05 -0800 (PST)
Message-ID: <1dea09ad-73b8-8f9f-c0d1-5637413349b5@kernel.dk>
Date:   Sun, 29 Jan 2023 15:34:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: pktcdvd
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230105174210.jbjoqelllcrd57q6@pali>
 <58d3649f-3c8c-8b12-1930-f06f59837ad5@kernel.dk>
 <CAHk-=wiKUWm3VoYHK-oKixc9nF5Qdwp598MPSoh=jdxKAU1bOw@mail.gmail.com>
 <1933bddd-42d7-d92b-974f-f26c46c01547@kernel.dk>
 <CAHk-=wjJ=wD5D80hkWNCjJqS+djckAL+nXhXaHaiFzMAMve3rA@mail.gmail.com>
 <182bc0ee-51e3-b8c4-59f7-dcf702865a95@kernel.dk>
 <20230106165809.vkz7lr7gi3xce22e@pali>
 <fd143218-d8ba-e6c5-9225-b8e2aee09979@kernel.dk>
 <20230128193458.ukl35ev4mwbjmu6b@pali>
 <8a22d187-57b4-7a2a-b564-f88bde4ac7ce@kernel.dk>
 <20230129222121.tjfxgzfqvwj3sotp@pali>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230129222121.tjfxgzfqvwj3sotp@pali>
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

On 1/29/23 3:21 PM, Pali Rohár wrote:
> On Sunday 29 January 2023 14:55:27 Jens Axboe wrote:
>> This does not look like a new issue (eg related to this series), and
>> this is exactly one of the reasons we wanted to get rid of this code -
>> basically nobody tests it, as nobody has the ability to. That means it's
>> very time consuming to debug issues with it.
> 
> I understand. I could try to look at it. The main issue for me is that I
> have not looked at this low level block device kernel area and I do not
> understand what is the code around doing...

I'll be happy to answer questions if you want to dive in... Looking at
the oops, it's clear that a bio arrived (or was split) that didn't end
up on a packet size alignment. We didn't error on the full size
alignment, so the total size of the write is a multiple of the packet
size. The bio_split() is pretty straightforward, so perhaps the starting
sector wasn't a multiple of the packet size to begin with?

>> What is the newest kernel you've run the pktcdvd driver on?
> 
> 4.19 from Debian 10. I'm not sure if I used newer version as most stuff
> is still on Debian 10 as I have not find a time to do upgrade of
> everything.

Ok, yeah that's pretty old...

-- 
Jens Axboe


