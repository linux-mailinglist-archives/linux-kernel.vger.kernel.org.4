Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B127E6F7796
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjEDU7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjEDU67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:58:59 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D601E12096
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 13:58:37 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6439e53ed82so2988b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 13:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683233863; x=1685825863;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/gHEhMKT9GBaN9OxubZFLqV6RzaUkfxxEP2gzqQjTJo=;
        b=eoGSUJZgKlY6q6N/ltf5XTgWHBMLJ5FmWs7h6XpoF0sqcN6YvSYeDyjqyEOiG9ZbDL
         Sag92+3xedTLYRMFOztCZjikDC7tHNzbDPrb9OlRwJqh8+HHK4QGlkrdNjLHVjukb4n4
         u1NE9b2XMDFDko0ibcqedwpbI0MsKxqi59blmg2mpZ6JRpwYGtRpQSbHhLFZuEnB1xGm
         DXXNnKYAaD+5D+c6gM4ZASZukeC+E3GFyUxyIxp7yEkvHAkuRXb4SndkXQVwtttTPoqQ
         81tQ/wkhIYiBriJ8PhvUO2ZYTta0Mqe0bYHLHN6+5rU3mDJ5JHfdFt0xcPHzBq08B37q
         Ia1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683233863; x=1685825863;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/gHEhMKT9GBaN9OxubZFLqV6RzaUkfxxEP2gzqQjTJo=;
        b=gZwTdNZNCgtS6g2jM6xepRuZMEJ7qwd5xE6KHLelb1WDabLZ4/Ne3pz6EZcZTvyBWs
         oh7ScyYlMMKMh7iw49MYKg7FNVndmNkd69NmoA9x0oWQEeY6CTNHHZV0nyyt/zlAfASX
         hbjEv/4QXnHTDCQ2FwdrzTueTRJ4BZrYeRkQgmLc787C0/0ykINh6+r3w81XYLtoVQGI
         JxjML1s5tzRHWOet4R0Yd39Dd98CV5lN9CLs3US0KS4Vvy6ME+PGU2StEzBJkfqdo8NZ
         DqCSU+ptOZbBl21cUZhIkrm3kGqNLNLT/ozG80wsFRcvR0zCMxV4xp4hTqvK9whhwPYg
         VaPg==
X-Gm-Message-State: AC+VfDy6U9BXO3U3gF8+vx0XR8ffdJ78L8zK/Pb4UqkrEiwmGenlfL43
        lMekJ6K/V/Bq6KpFFa1g+Dk04xWa2d+EArJMshQ=
X-Google-Smtp-Source: ACHHUZ7cSRKGSnvkFB0S4zZLqTu1C+ROgHFBUfU+QKoNjODu/ChiksCC/9eWmF7IDIxRWC1tOOWE+g==
X-Received: by 2002:a05:6602:493:b0:763:86b1:6111 with SMTP id y19-20020a056602049300b0076386b16111mr8372024iov.2.1683231778063;
        Thu, 04 May 2023 13:22:58 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c4-20020a5d9a84000000b00763601c4bfesm9164423iom.55.2023.05.04.13.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 13:22:57 -0700 (PDT)
Message-ID: <80ed2c0e-54db-777a-175b-1aa3ff776724@kernel.dk>
Date:   Thu, 4 May 2023 14:22:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 00/11] Rust null block driver
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Andreas Hindborg <nmi@metaspace.dk>,
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
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com,
        Daniel Vetter <daniel@ffwll.ch>
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <da7b815d-3da8-38e5-9b25-b9cfb6878293@acm.org> <87jzxot0jk.fsf@metaspace.dk>
 <b9a1c1b2-3baa-2cad-31ae-8b14e4ee5709@acm.org>
 <ZFP+8apHunCCMmOZ@kbusch-mbp.dhcp.thefacebook.com>
 <e7bc2155-613b-8904-9942-2e9615b0dc63@kernel.dk>
 <CANiq72nAMH1SfGmPTEjGHfevbb9tMLN4W7gJ3nBpJcvkCEsZ4g@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CANiq72nAMH1SfGmPTEjGHfevbb9tMLN4W7gJ3nBpJcvkCEsZ4g@mail.gmail.com>
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

On 5/4/23 2:11?PM, Miguel Ojeda wrote:
> On Thu, May 4, 2023 at 9:02?PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> But back to the real question... This is obviously extra burden on
>> maintainers, and that needs to be sorted out first. Block drivers in
> 
> Regarding maintenance, something we have suggested in similar cases to
> other subsystems is that the author gets involved as a maintainer of,
> at least, the Rust abstractions/driver (possibly with a different
> `MAINTAINERS` entry).

Right, but that doesn't really solve the problem when the rust bindings
get in the way of changes that you are currently making. Or if you break
them inadvertently. I do see benefits to that approach, but it's no
panacea.

> Of course, that is still work for the existing maintainer(s), i.e.
> you, since coordination takes time. However, it can also be a nice way
> to learn Rust on the side, meanwhile things are getting upstreamed and
> discussed (I think Daniel, in Cc, is taking that approach).

This seems to assume that time is plentiful and we can just add more to
our plate, which isn't always true. While I'd love to do more rust and
get more familiar with it, the time still has to be there for that. I'm
actually typing this on a laptop with a rust gpu driver :-)

And this isn't just on me, there are other regular contributors and
reviewers that would need to be onboard with this.

> And it may also be a way for you to get an extra
> maintainer/reviewer/... later on for the C parts, too, even if Rust
> does not succeed.

That is certainly a win!

>> general are not super security sensitive, as it's mostly privileged code
>> and there's not a whole lot of user visibile API. And the stuff we do
>> have is reasonably basic. So what's the long term win of having rust
>> bindings? This is a legitimate question. I can see a lot of other more
>> user exposed subsystems being of higher interest here.
> 
> From the experience of other kernel maintainers/developers that are
> making the move, the advantages seem to be well worth it, even
> disregarding the security aspect, i.e. on the language side alone.

Each case is different though, different people and different schedules
and priorities. So while the above is promising, it's also just
annecdotal and doesn't necessarily apply to our case.

-- 
Jens Axboe

