Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD5D5F45D8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJDOns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiJDOnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:43:39 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5801661DBD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 07:43:37 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id d17so8443537qko.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 07:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=gAnQvnOAYs7sJGHDL1xD9JPAjxdswwdRliZaaX3N61A=;
        b=eNIM37s9G1KcHbErzx8hnXTdahFTVCIdmbkryRNwIi2Vybl0yvjvtK1E04RkLg3boq
         aROA4/M0aH3D3OlVWU3Enyt0YsztvJrcpYhGZUpF1pdTvXcX9HD+6yP6T18pzRPBeuiv
         6prDySjo82TSJlv92yOtTil+Qny0pjq+lUzQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=gAnQvnOAYs7sJGHDL1xD9JPAjxdswwdRliZaaX3N61A=;
        b=sTjhe07t6cs+7ApaQZX1wzgVUF60r/K5mBz8iz6FwED3Vj4xmkVWnzTMIWkHKQO5v9
         8ozPDx74+av7zIuwoc3+SRvihxrbJZrPg5BZqEw3M07IU8JENglNn7oBiwYhWeHzCxlL
         FdsX6fcegAayD4A40BQYAUogEEad8MqzBpJYI+oQMYHJ6BZhHvcMQhpdmbOdPUpz4G1+
         b0M0KOCf+G1tBYVGrk8ZT9AK+86SJL+2BJu4vmR/dCa+F2uJKAgOyS9K86UrI0PTeJ2/
         04xyfUlTvhja5VyGaT27wQ030I7DSwP6TE8g1rEseaEZ85mlazHS8AY3a4Z3REzh2Oz/
         A2Yw==
X-Gm-Message-State: ACrzQf088eY4HP5I6T2eOKdazVeOEvxm2og4jcBEvGTCKR59FFgM9LwN
        HbnYYfPgzGY7dJjUGgqKVgu3nw==
X-Google-Smtp-Source: AMsMyM5DLp4MXrP1i2vrezilKzEDrR77ShFEFCjeDK+HKdW5fgY2ZuIKQncWWUkoFJ1p6zPHdwCTnw==
X-Received: by 2002:a05:620a:28c1:b0:6ce:b23c:dcac with SMTP id l1-20020a05620a28c100b006ceb23cdcacmr17062805qkp.123.1664894615630;
        Tue, 04 Oct 2022 07:43:35 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id br12-20020a05622a1e0c00b0035bb732ac93sm11707600qtb.88.2022.10.04.07.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 07:43:35 -0700 (PDT)
Message-ID: <f453e273-26b6-77c3-5511-6dc4fd5054db@joelfernandes.org>
Date:   Tue, 4 Oct 2022 10:43:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Sum of weights idea for CFS PI
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org,
        Youssef Esmat <youssefesmat@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, bristot@redhat.com,
        clark.williams@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
References: <cb6c406e-1431-fcfd-ef82-87259760ead9@joelfernandes.org>
 <20220930134931.mpopdvri4xuponw2@wubuntu>
 <00140e95-0fe2-1ce4-1433-a3211f9da20c@joelfernandes.org>
 <YzweGw5l3HxQVcGN@linutronix.de>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <YzweGw5l3HxQVcGN@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/2022 7:50 AM, Sebastian Andrzej Siewior wrote:
> On 2022-09-30 13:34:49 [-0400], Joel Fernandes wrote:
>> In this case, there is no lock involved yet you have a dependency. But I don't
>> mean to sound depressing, and just because there are cases like this does not
>> mean we should not solve the lock-based ones. When I looked at Android, I saw
>> that it uses futex directly from Android Runtime code instead of using pthread.
>> So perhaps this can be trivially converted to FUTEX_LOCK_PI and then what we do
>> in the kernel will JustWork(Tm) ?
> 
> The easy part is just to replace the lock/unlock functions with
> FUTEX_LOCK_PI/UNLOCK_PI syscalls. The slightly advanced part is where
> you use an atomic operation to replace 0 with threads's ID in the lock
> path to avoid going into the kernel for locking if the lock is not
> contended. If it is, then you need to use the syscall.
> 
> …
>>> Proxy execution seems to be the nice solution to all of these problems, but
>>> it's a long way away. I'm interested to learn how this inheritance will be
>>> implemented. And whether there are any userspace conversion issues. i.e: do
>>> we need to convert all locks to rt-mutex locks?
>>
>> I am not an expert on FUTEX_LOCK_PI and this could be a good time for tglx to
>> weigh in, but I think converting all userspace locks to use FUTEX_LOCK_PI sounds
>> reasonable to me.
> 
> Based on my understanding with proxy-execution, all in-kernel locks
> should be covered.
> Priority inheritance (PI) works only with FUTEX_LOCK_PI for userpace and
> rtmutex for the in-kernel locks. Regular FUTEX_LOCK does only wait/wake
> in userspace so there is no way for the kernel to "help". Ah and for PI
> to work you need priorities that you can inherit. With two threads
> running as SCHED_OTHER there will be just "normal" sleep+wake in the
> kernel. If the blocking thread is SCHED_FIFO then it will inherit its
> priority to the lock owner.

Hi Sebastian, I agree with your thoughts on this. Yes proxy execution idea
should cover this. Basically, any primitive that allows userspace to let the
kernel know is a dependency can use this AFAICS, FUTEX_LOCK_PI being a prime
example. Perhaps Android's binder being another where A sends a message to C and
blocks till C responds. Meanwhile medium prio B blocks C.

thanks,

- Joel
