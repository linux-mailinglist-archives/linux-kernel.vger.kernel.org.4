Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48150750BC1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjGLPFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjGLPF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:05:27 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666A51BFF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:05:22 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7748ca56133so55726639f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689174321; x=1691766321;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yobxh9isPU2AKgTKMngGO2IWKlW9bT21S+wyBx0/pKg=;
        b=an0UQ4eOCAgJGJKOHjZ4mmJt/OXKetlsBfMnGqzi1MGxb/rgOZE6vzDPX4qPYV5qEk
         yPxI68SJySr05VBgeTgWb62CJE7rOUm+oyH64QXu3obrFZQyzrq/CxkbGDWMVXcoH0QG
         nYw4D/LdVCwA2dcUxv9eSornWBmZc3cTpWNZwRjbg3HCnYSB2PBXjgpMIK+4GnPetPgS
         UbPrSvaAjZPSa995AMqRdyR38E2tkFewKqUIOTtZDBEoUIMLwKPa9A45hFFkcOgg5HVD
         eV9eDVQWfQtYyGI5VvYU7v2DGLepa6zt5Nj5VPSutt5xdNPRVKnXvGmAkohugceXQGBR
         HXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689174321; x=1691766321;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yobxh9isPU2AKgTKMngGO2IWKlW9bT21S+wyBx0/pKg=;
        b=HtTk/Te4fLyCl/TM7fLSCDrnM2Ja+RlJbGQz0b6BaNXoJzAMxeKJjuKRHI++IKious
         wmzSpeP8Cgf8jOgIe7XcQQKLw3Z5WxxHbEzCMzr+1ALInlhhbRT5g05sjA97NbE76TMm
         V74lQD7pfPD89Vicza7Ayy5U5dV4MB4ejp4Xngbv2GL0MEgspgwvTfj7cI5WhzEQh+xo
         6Y1NVyElkafo2/GYTFqffU5SpRiIk9FJmqt+HcC65G5EJNIi135KoXWFFAtii/v86rVF
         Rl8jjgeKINsFs4JWeOlEN5RC6874wNaH/ZtGLVYjQNIGz4mKEvC/FIuPXLqhSlYD5py+
         7nUw==
X-Gm-Message-State: ABy/qLYAaxEJSXDyOlihmunULCIezC3GNyS0sIZII5HPV0OCSWgsqm/+
        4g2rF2l1DVvCszGsGU/6CnVolw==
X-Google-Smtp-Source: APBJJlEVZ7U9ranaRQbfulGOm4aZwd9aUzqgCzwekTQSKPCFu7pBNX7e1cnSRGyab/561dCcwQWZ/Q==
X-Received: by 2002:a92:c688:0:b0:346:3173:2374 with SMTP id o8-20020a92c688000000b0034631732374mr18214874ilg.0.1689174321548;
        Wed, 12 Jul 2023 08:05:21 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e16-20020a92d750000000b003459d60aaeasm1346425ilq.45.2023.07.12.08.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 08:05:20 -0700 (PDT)
Message-ID: <85be94ca-3ecd-a054-1b6c-a7561bde93ba@kernel.dk>
Date:   Wed, 12 Jul 2023 09:05:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/7] io_uring: add support for futex wake and wait
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com
References: <20230712004705.316157-1-axboe@kernel.dk>
 <20230712004705.316157-4-axboe@kernel.dk>
 <20230712085116.GC3100107@hirez.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230712085116.GC3100107@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/23 2:51?AM, Peter Zijlstra wrote:
> On Tue, Jul 11, 2023 at 06:47:01PM -0600, Jens Axboe wrote:
>> Add support for FUTEX_WAKE/WAIT primitives.
>>
>> IORING_OP_FUTEX_WAKE is mix of FUTEX_WAKE and FUTEX_WAKE_BITSET, as
>> it does support passing in a bitset.
>>
>> Similary, IORING_OP_FUTEX_WAIT is a mix of FUTEX_WAIT and
>> FUTEX_WAIT_BITSET.
>>
>> FUTEX_WAKE is straight forward, as we can always just do those inline.
>> FUTEX_WAIT will queue the futex with an appropriate callback, and
>> that callback will in turn post a CQE when it has triggered.
>>
>> Cancelations are supported, both from the application point-of-view,
>> but also to be able to cancel pending waits if the ring exits before
>> all events have occurred.
>>
>> This is just the barebones wait/wake support. PI or REQUEUE support is
>> not added at this point, unclear if we might look into that later.
>>
>> Likewise, explicit timeouts are not supported either. It is expected
>> that users that need timeouts would do so via the usual io_uring
>> mechanism to do that using linked timeouts.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> I'm not sure I'm qualified to review this :/ I really don't know
> anything about how io-uring works. And the above doesn't really begin to
> explain things.

It's definitely catered to someone who knows how that works already, I
feel like it'd be a bit beyond the scope of a commit message like that
to explain io_uring internals. Then we'd have to do that every time we
add a new request type.

But I can certainly expand it a bit and hopefully make it a bit clearer.
I'll do that.

>> +static void io_futex_wake_fn(struct wake_q_head *wake_q, struct futex_q *q)
>> +{
>> +	struct io_futex_data *ifd = container_of(q, struct io_futex_data, q);
>> +	struct io_kiocb *req = ifd->req;
>> +
>> +	__futex_unqueue(q);
>> +	smp_store_release(&q->lock_ptr, NULL);
>> +
>> +	io_req_set_res(req, 0, 0);
>> +	req->io_task_work.func = io_futex_complete;
>> +	io_req_task_work_add(req);
>> +}
> 
> I'm noting the WARN from futex_wake_mark() went walk-about.

True.

> Perhaps something like so?

I like that, sharing more code is always better. Should be a separate
patch though I think, or folded into patch 2. Which would you prefer?
I'll do a separate patch for now.

-- 
Jens Axboe

