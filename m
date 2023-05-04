Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B235B6F7794
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjEDU4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjEDU4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:56:11 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A95120B7
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 13:55:49 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-769a4e76f30so6098539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 13:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683233703; x=1685825703;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bThyd74S2N2oDbSREWHnOPdDMJwRG45ERj16N72kBRg=;
        b=l2MTxWxNlVB/WH2xrF+MJxUilczB+f0fvA8IBB+e0MLl8sHDt+x4/HFy0JufcYeNUx
         +BMWjNk0rbbSE4J/vY8xZM0pMwGgIPawCARddCAvotHyy0zv3ybrLKNy9MjZ0vYq6jlJ
         16SC8312n4xRHBq6G17UdTuhXNKLW/SMaJ786ff4tzsWybuEH669rsf2hfoF2gZoDtQH
         JCfEjt28J93UJByu4Gmt1Hr6sdW98GSR068ASK4qxZZ4axoW5ahi7wf9jqIYTbvevt92
         UX0oyVeBIMqz5OyKynfZqxPT29aa4yzDM8Z0lm0ASD6WhylXP+/UunRN8nVByLIimbcV
         notA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683233703; x=1685825703;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bThyd74S2N2oDbSREWHnOPdDMJwRG45ERj16N72kBRg=;
        b=LJ/I4W2a7YHCBDk5XIXxC046ZLX2XDSCD/dE3+fawPAqj7qHNbOeK1fijtlzpZvV+Z
         s+3O/uvahHqLJbbHtQeDaIo+MsfHMeBdoHTkWKzPy6Vs92D+7/GNd5GfMV13aEkrskA8
         iSTnTka89p9L2Gied/j4odx1fAYBzY8/w00Q0dnPuPudNm8+ZHDCIMLE60cGenMBNYRV
         mAYgOJ4+pnlAIQsTWIkv14wNNl/+P/8bwGbCdIPDU0HJSg1VOz7PkoLtgYGacPag775I
         HBtp2mZQjBSMRI14dCPys3B7TFKHyEq6RU9alPC1KAnJKwzGoWAznoFnZmVWR6ZGbTNF
         MT5g==
X-Gm-Message-State: AC+VfDzDWmNU+maxRIX9pfGKYSOfih4Yrm6D3jhgqAaITIOTQOu9/Rj+
        XdogebOFYPVrxtGP68OzGH48wA==
X-Google-Smtp-Source: ACHHUZ7u7Z7zBx8+bpJiQvwVPo4kxTVGqAu7lbDiXlxkNkLQGAk8ObS2SwEGUuw9qE6EXFWmlyZu1g==
X-Received: by 2002:a92:c246:0:b0:32f:1232:f5d5 with SMTP id k6-20020a92c246000000b0032f1232f5d5mr13163499ilo.2.1683233703530;
        Thu, 04 May 2023 13:55:03 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t11-20020a92c90b000000b0032aef6b60adsm13757ilp.34.2023.05.04.13.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 13:55:02 -0700 (PDT)
Message-ID: <0adf4086-c624-1587-d490-9e6bb517afe0@kernel.dk>
Date:   Thu, 4 May 2023 14:55:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 00/11] Rust null block driver
Content-Language: en-US
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <da7b815d-3da8-38e5-9b25-b9cfb6878293@acm.org> <87jzxot0jk.fsf@metaspace.dk>
 <b9a1c1b2-3baa-2cad-31ae-8b14e4ee5709@acm.org>
 <ZFP+8apHunCCMmOZ@kbusch-mbp.dhcp.thefacebook.com>
 <e7bc2155-613b-8904-9942-2e9615b0dc63@kernel.dk>
 <875y97u92z.fsf@metaspace.dk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <875y97u92z.fsf@metaspace.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/23 1:59?PM, Andreas Hindborg wrote:
> 
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 5/4/23 12:52?PM, Keith Busch wrote:
>>> On Thu, May 04, 2023 at 11:36:01AM -0700, Bart Van Assche wrote:
>>>> On 5/4/23 11:15, Andreas Hindborg wrote:
>>>>> If it is still unclear to you why this effort was started, please do let
>>>>> me know and I shall try to clarify further :)
>>>>
>>>> It seems like I was too polite in my previous email. What I meant is that
>>>> rewriting code is useful if it provides a clear advantage to the users of
>>>> a driver. For null_blk, the users are kernel developers. The code that has
>>>> been posted is the start of a rewrite of the null_blk driver. The benefits
>>>> of this rewrite (making low-level memory errors less likely) do not outweigh
>>>> the risks that this effort will introduce functional or performance regressions.
>>>
>>> Instead of replacing, would co-existing be okay? Of course as long as
>>> there's no requirement to maintain feature parity between the two.
>>> Actually, just call it "rust_blk" and declare it has no relationship to
>>> null_blk, despite their functional similarities: it's a developer
>>> reference implementation for a rust block driver.
>>
>> To me, the big discussion point isn't really whether we're doing
>> null_blk or not, it's more if we want to go down this path of
>> maintaining rust bindings for the block code in general. If the answer
>> to that is yes, then doing null_blk seems like a great choice as it's
>> not a critical piece of infrastructure. It might even be a good idea to
>> be able to run both, for performance purposes, as the bindings or core
>> changes.
>>
>> But back to the real question... This is obviously extra burden on
>> maintainers, and that needs to be sorted out first. Block drivers in
>> general are not super security sensitive, as it's mostly privileged code
>> and there's not a whole lot of user visibile API. And the stuff we do
>> have is reasonably basic. So what's the long term win of having rust
>> bindings? This is a legitimate question. I can see a lot of other more
>> user exposed subsystems being of higher interest here.
> 
> Even though the block layer is not usually exposed in the same way
> that something like the USB stack is, absence of memory safety bugs is
> a very useful property. If this is attainable without sacrificing
> performance, it seems like a nice option to offer future block device
> driver developers. Some would argue that it is worth offering even in
> the face of performance regression.
> 
> While memory safety is the primary feature that Rust brings to the
> table, it does come with other nice features as well. The type system,
> language support stackless coroutines and error handling language
> support are all very useful.

We're in violent agreement on this part, I don't think anyone sane would
argue that memory safety with the same performance [1] isn't something
you'd want. And the error handling with rust is so much better than the
C stuff drivers do now that I can't see anyone disagreeing on that being
a great thing as well.

The discussion point here is the price being paid in terms of people
time.

> Regarding maintenance of the bindings, it _is_ an amount extra work. But
> there is more than one way to structure that work. If Rust is accepted
> into the block layer at some point, maintenance could be structured in
> such a way that it does not get in the way of existing C maintenance
> work. A "rust keeps up or it breaks" model. That could work for a while.

That potentially works for null_blk, but it would not work for anything
that people actually depend on. In other words, anything that isn't
null_blk. And I don't believe we'd be actively discussing these bindings
if just doing null_blk is the end goal, because that isn't useful by
itself, and at that point we'd all just be wasting our time. In the real
world, once we have just one actual driver using it, then we'd be
looking at "this driver regressed because of change X/Y/Z and that needs
to get sorted before the next release". And THAT is the real issue for
me. So a "rust keeps up or it breaks" model is a bit naive in my
opinion, it's just not a viable approach. In fact, even for null_blk,
this doesn't really fly as we rely on blktests to continually vet the
sanity of the IO stack, and null_blk is an integral part of that.

So I really don't think there's much to debate between "rust people vs
jens" here, as we agree on the benefits, but my end of the table has to
stomach the cons. And like I mentioned in an earlier email, that's not
just on me, there are other regular contributors and reviewers that are
relevant to this discussion. This is something we need to discuss.

[1] We obviously need to do real numbers here, the ones posted I don't
consider stable enough to be useful in saying "yeah it's fully on part".
If you have an updated rust nvme driver that uses these bindings I'd
be happy to run some testing that will definitively tell us if there's a
performance win, loss, or parity, and how much.

-- 
Jens Axboe

