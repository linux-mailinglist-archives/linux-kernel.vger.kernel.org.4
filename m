Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1016A3BE8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 08:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjB0H7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 02:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjB0H7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 02:59:18 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E48903B
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 23:59:16 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id c23so5190702pjo.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 23:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=73aOGiz8kUebEgrIG9Manl7Y85S7NR6UJBsVd8RPeTE=;
        b=R0SiUsF3hxIhS69/19xwcismhVDBaKV9WqNM8Q+WbauV3SdHyEHpmwGUXEWChia8Tg
         FUqAYq2Gq6WdAEc80Gsn3Gj3D07p3dkJLHn4ncEOB1ljPnXdQ73Fu695uoJ+vbfbkNYt
         H0Sywgfv6PzuRKergfRVegYuAbNShiggqSISsP0FUm1G1hhRqBY7AfzgZ8hnilYc4rz6
         bMIDNqTxNAUo5enAJ7eBo0ZE2V2YXBvLWK+Uz3+Xo17Z/+H2FngYQsKtFKH44X7G+019
         gXJifx5UCt+gPnmdG0Ly81rSBmnn3L4Q2/UAYQrYYDYz2eVVDseFVXRLkMuyZazey796
         Lhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73aOGiz8kUebEgrIG9Manl7Y85S7NR6UJBsVd8RPeTE=;
        b=HRIi4odo4ObuE/QxL/6XxYVQacbQI7HUaglNSk+H/R85cJ3sKe2mT1WRtTZUhX+ZLB
         8+/sfOMf2abFXD2UVKP5Aosf6gGs7TAhlZaYUTwRNlm3Hd9C20nQEUCH/0CokN32Dyzj
         D/HI7MRPas9nebRlqJQM+1tqVL7muoXu3pr7ZNk6BreZItWqcSaXEpU9bLA1EVmYdSpq
         Rl6Zw+DYklcOXLzOHIvJO0P6XD1+5h+skqB5X1vNyVMbFGip1NHxXHzKCdxUtCxYHc/T
         aGtaPUAKN4sSW9XGL986T2vTU6V2gV3bh+Txn79mpOJo+ilw3foW3/BtkrFUgIqZ5idD
         GFlQ==
X-Gm-Message-State: AO0yUKXRXePm8Z5RRxJ9zSHwZuCzqeuHKy4tLN1r4Z+yCaGXAC6OwPKS
        WZ+z4Yk8VR+7e9AEbGaOohk=
X-Google-Smtp-Source: AK7set/nhXSYPnXhJ3mkC3x/IEpKoR0nhTNXTTN4dDw11+9UD2DCUa8gkZzFC2f2ij/KaWwLR5gcrw==
X-Received: by 2002:a17:903:1ce:b0:19d:20fe:c149 with SMTP id e14-20020a17090301ce00b0019d20fec149mr1037276plh.34.1677484755676;
        Sun, 26 Feb 2023 23:59:15 -0800 (PST)
Received: from MBP ([68.74.118.125])
        by smtp.gmail.com with ESMTPSA id i5-20020a170902eb4500b00198fc0a191bsm3921718pli.160.2023.02.26.23.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 23:59:15 -0800 (PST)
References: <9d9b9652-c1ac-58e9-2eab-9256c17b1da2@I-love.SAKURA.ne.jp>
 <7d1021f1-c88e-5a03-3b92-087f9be37491@I-love.SAKURA.ne.jp>
 <Y9z76ZLe4On96xIN@hirez.programming.kicks-ass.net>
 <Y9z+SerR8mlZYo16@hirez.programming.kicks-ass.net>
 <6c47dbcf-2a17-6bb2-719b-841d851c603b@I-love.SAKURA.ne.jp>
 <Y90ar35uKQoUrLEK@hirez.programming.kicks-ass.net>
 <caa13441-5f95-b7d6-dd5d-1cf49e709714@I-love.SAKURA.ne.jp>
 <Y+Eh9CFdTwwv+hot@bombadil.infradead.org>
 <Y+pWzult7UDgoilC@hirez.programming.kicks-ass.net>
 <m21qmkahoj.fsf@gmail.com>
 <Y/Xhsna3gfadzAAk@hirez.programming.kicks-ass.net>
User-agent: mu4e 1.8.10; emacs 29.0.60
From:   Schspa Shi <schspa@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+6cd18e123583550cf469@syzkaller.appspotmail.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [syzbot] WARNING: locking bug in umh_complete
Date:   Mon, 27 Feb 2023 15:57:36 +0800
In-reply-to: <Y/Xhsna3gfadzAAk@hirez.programming.kicks-ass.net>
Message-ID: <m2h6v7ilo6.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Peter Zijlstra <peterz@infradead.org> writes:

> On Tue, Feb 14, 2023 at 10:31:58AM +0800, Schspa Shi wrote:
>> Peter Zijlstra <peterz@infradead.org> writes:
>
>> > If so, perhaps the simplest rule would to be ensure there is an
>> > unconditional uninterruptible wait-for-completion() before going out of
>> > scope.
>> >
>> > This latter can be spelled like wait_for_completion() or
>> > wait_for_completion_state(TASK_UNINTERRUPTIBLE). More specifically,
>> > TASK_INTERRUPTIBLE and TASK_WAKEKILL must not be set in the state mask
>> > for the wait to be uninterruptible.
>> >
>> > If it cannot be proven, raise a warning and audit or somesuch.
>> 
>> This is a good suggestion. I have written a SmPL patch to complete this
>> check, and now I need to rule out the situation that the driver has
>> added an additional lock to protect it.
>> 
>> And I have found a lot of bad usage, should we consider adding a new
>> helper API to simplify the fix this?
>
> Please first share some of the locations where this would be applied.

Hi Peter:

I started a new thread to discuss the SmPL patch.

Link: https://lore.kernel.org/all/20230227075346.69658-1-schspa@gmail.com/

-- 
BRs
Schspa Shi
