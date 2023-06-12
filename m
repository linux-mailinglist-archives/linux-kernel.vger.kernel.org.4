Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124EC72CCE7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbjFLRaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236825AbjFLR33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:29:29 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E8610B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:29:27 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-777a9ca9112so45574939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686590967; x=1689182967;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TFWZn0n6OGSV4kVBbYftRZo2ty8H3Bci18vHV3tC0Uw=;
        b=G8JD84g8f9Aeee5HTb3j/7SgOJh5Qn/aixcR5+GacNDkyxtuggQHLsYFnC6bEXjPzX
         CFDBvYGcEzc1Ttl+IUa85nXJaOctQM+3Wy8xIs72fL9U/EZpbxXE0eJqLOsg7VKrMIC5
         weokx/JiqIENqjn+LXa6+yAoNSa4c/vJ0Jsnyuao7rqrJ9O5YfZGoHB+GpSAFFK7rf5t
         e3cgg3kcuwmy9bn41z6Fh0yOgs9hNIUGeYIWRQdX3YWh0zxo6BeyQp86i/LzYL50hqt3
         RK/B1dfYGtQYx6zG0W9kb866p34EKPfBVuRjPGLhqy6GqZBIlr+JvIP15dv+x4wcQyQ9
         QDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686590967; x=1689182967;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TFWZn0n6OGSV4kVBbYftRZo2ty8H3Bci18vHV3tC0Uw=;
        b=aOpR6+qHQ085iy/SwiSP6V/EIRZtbU+I7c5af2vOacc2FiRzZBNSJdUdLFgzvy1RyV
         surFD0KaeUcGmzOH1KA4Bq7EsAUNwfjRXm5e8Jd9jAeovyLD2Oh8C9syK5xhu5f4u1d7
         PxFJVT7eycNa8xZfNrh/L3cQdpUx8htxYPKPERvRV3E/n1pNxntnlW3KLwPi3KtZB4nI
         Pz2jIHCJAqF1FhrluIA9pHenQsvmO7vLxxDoxidfFClIG5hE02Pvty4gi+YFpKdr7up9
         SiZdb1EGEMi5mtQs1bYgoNgbQIGmgpozFqRudYQLkyPfHI64+LjPUdlITS0JAhLgbv8X
         AChw==
X-Gm-Message-State: AC+VfDyi6/wvg7Us17ebt5WJbvUHV9SsVtDMxsSLWsIWCWBtt1BZBZVN
        e6f8ix8TeEaIwNZ2Gwb4aOzA3w==
X-Google-Smtp-Source: ACHHUZ5bDIcReS9+YhyEZIK2CCIqFlbV7Kvzlpd9NEY+7ScY3yUVxP60SWtqVvazxqpp+hgdcN0Nww==
X-Received: by 2002:a92:440e:0:b0:33b:e24b:ca46 with SMTP id r14-20020a92440e000000b0033be24bca46mr5234504ila.3.1686590967286;
        Mon, 12 Jun 2023 10:29:27 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t11-20020a92d14b000000b0033d2d6620b0sm3295648ilg.2.2023.06.12.10.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 10:29:26 -0700 (PDT)
Message-ID: <ff34a007-fdd0-8575-8482-919ead39fc88@kernel.dk>
Date:   Mon, 12 Jun 2023 11:29:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [6.5-rc5 regression] core dump hangs (was Re: [Bug report]
 fstests generic/051 (on xfs) hang on latest linux v6.5-rc5+)
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Zorro Lang <zlang@redhat.com>, linux-xfs@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mike Christie <michael.christie@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
References: <20230611124836.whfktwaumnefm5z5@zlang-mailbox>
 <ZIZSPyzReZkGBEFy@dread.disaster.area>
 <20230612015145.GA11441@frogsfrogsfrogs>
 <ZIaBQnCKJ6NsqGhd@dread.disaster.area>
 <CAHk-=whJqZLKPR-cpX-V4wJTXVX-_tG5Vjuj2q9knvKGCPdfkg@mail.gmail.com>
 <20230612153629.GA11427@frogsfrogsfrogs>
 <CAHk-=wiN-JcUh4uhDNmA4hp26Mg+c2DTuzgWY2fZ6hytDtOMCg@mail.gmail.com>
 <af31cadf-8c15-8d88-79fb-066dc87f0324@kernel.dk>
 <13d9e4f2-17c5-0709-0cc0-6f92bfe9f30d@kernel.dk>
 <CAHk-=wgdBfqyNHk0iNyYpEuBUdVgq1KMzHMuEqn=ADtfyK_pkQ@mail.gmail.com>
 <212a190c-f81e-2876-cf14-6d1e37d47192@kernel.dk>
 <CAHk-=wh0hrFjcU5C8uHvLBThrT5vQsFHb7Jk6HRP3LAJqdNx1A@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wh0hrFjcU5C8uHvLBThrT5vQsFHb7Jk6HRP3LAJqdNx1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/23 10:57 AM, Linus Torvalds wrote:
> On Mon, Jun 12, 2023 at 9:45 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> You snipped the suspicion in my reply on why that exists, to avoid
>> io_wq_worker_sleeping() triggering.
> 
> I'm not seeing why triggering io_wq_worker_sleeping() should even be a
> problem in the first place.
> 
> I suspect that is entirely historical too, and has to do with how it
> used to do that
> 
>         struct io_worker *worker = kthread_data(tsk);
>         struct io_wqe *wqe = worker->wqe;
> 
> back in the bad old days of kthreads.
> 
> But yeah, I don't know that code.

Looks fine to me to just kill it indeed, whatever we did need this
for is definitely no longer the case. I _think_ we used to have
something in the worker exit that would potentially sleep which
is why we killed it before doing that, now it just looks like dead
code.

-- 
Jens Axboe


