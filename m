Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C286728A6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjARTmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjARTmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:42:43 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4C35897A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:42:41 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id v6so42816637ejg.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iS6dE41UI7zPZrZ4uGb8Dlx2vRH+t+zmLwzsETz4WGI=;
        b=NwJkJz27xo+SSIXsXlrp3enH7f9XBbGFU60/8bZJpScEz39hrjwyMTXJhrQ/9uAAxg
         LJ8SFmZDI1pOqGdP+xhY8sErmup3yvL4EcQTZS/WFeHf40psZSQFV363C9wOdO1rF2on
         5+IxQfkJZe5W6HC47QA2XGLqmo19uk0l20mJGPFHZPglfMPGzxQWyBJiuP4pl4KK0lA+
         IBRkQvpOgFiRPfhMO1RbEhwUhJyOUjqeOEOoWeuXxZqrxkZHFUiZEH0piPG2UvxBJixN
         6wAdrRZt+fxE5Kcb8sAuynpAJrvCIVd8gXTGYoicxC1W3F1Ns9yz/eK7FueiADP8M9ok
         M0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iS6dE41UI7zPZrZ4uGb8Dlx2vRH+t+zmLwzsETz4WGI=;
        b=O5KYfCsTl6+8bvzWt2wOJ0HuSkzjoRfJH+bscEYChYnV0uAS7r8XGErk3iZAoM7KnE
         ykfDR1nghgfpT5Uzphuvn5bzW/Yd4AnTdV5Rwd1HH3mou4fv1JTfHW3oBHZkVE3zAFvW
         lTwLSB8IiE80mf3QE040mprsilrAc7WB2RVcsw44oC61J1WyUbxhIv6rjs1i8eF/5H85
         QSN7QKA4scnjOzqQlqQnSqjVkRofrNue2S+53/XBYPEGSEbGcOYZAcKrMVADJ1GGFSuO
         zvJ5E14GjOVaC/dVjm7DGRzreegPugspWzOmEeCUxTq2ccRhe60kg0RrNa1u3jkC0kyW
         4Odw==
X-Gm-Message-State: AFqh2kr0haYMjxo73hOWOMGyznLvAFGJ2PrfwBtvhhJTLGA04kFzD6q4
        L9xznOZggVQ4q1Ykwldiafg=
X-Google-Smtp-Source: AMrXdXszZPR583r/ybyriCtcAStYoirvGfHDbnDTLW+7UJjAYqI9/tspFrp5g8mLknrghZRuc1KYdQ==
X-Received: by 2002:a17:907:c606:b0:870:d9a:9ebb with SMTP id ud6-20020a170907c60600b008700d9a9ebbmr4697365ejc.38.1674070959768;
        Wed, 18 Jan 2023 11:42:39 -0800 (PST)
Received: from [192.168.1.13] (dynamic-078-054-168-106.78.54.pool.telefonica.de. [78.54.168.106])
        by smtp.gmail.com with ESMTPSA id sb25-20020a1709076d9900b0084c6581c16fsm15098557ejc.64.2023.01.18.11.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 11:42:38 -0800 (PST)
Message-ID: <3dabbcfb-858c-6aa0-6824-05b8cc8e9cdb@gmail.com>
Date:   Wed, 18 Jan 2023 20:42:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
To:     Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>, npiggin <npiggin@gmail.com>,
        dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        "luc.maranget" <luc.maranget@inria.fr>, akiyks <akiyks@gmail.com>,
        dlustig <dlustig@nvidia.com>, joel <joel@joelfernandes.org>,
        urezki <urezki@gmail.com>,
        quic_neeraju <quic_neeraju@quicinc.com>,
        frederic <frederic@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
References: <Y8WTXS73qTBpUzcI@rowland.harvard.edu>
 <20230116190652.GZ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8WjmTFnqbAnS1Pz@rowland.harvard.edu>
 <20230116221357.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8aKlNY4Z0z2Yqs0@andrea>
 <20230117151416.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8bFMgDSUZymXUsS@rowland.harvard.edu>
 <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8cBypKx4gM3wBJa@rowland.harvard.edu>
 <20230118035041.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8gjUKoHxqR9+7Hx@rowland.harvard.edu>
From:   Jonas Oberhauser <s9joober@gmail.com>
In-Reply-To: <Y8gjUKoHxqR9+7Hx@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/2023 5:50 PM, Alan Stern wrote:
> On Tue, Jan 17, 2023 at 07:50:41PM -0800, Paul E. McKenney wrote:
>> On Tue, Jan 17, 2023 at 03:15:06PM -0500, Alan Stern wrote:
>>> On Tue, Jan 17, 2023 at 09
>>>> Given an Srcu-down and an Srcu-up:
>>>>
>>>> let srcu-rscs = ( return_value(Srcu-lock) ; (dep | rfi)* ;
>>>> 		  parameter(Srcu-unlock, 2) ) |
>>>> 		( return_value(Srcu-down) ; (dep | rf)* ;
>>>> 		  parameter(Srcu-up, 2) )
>>>>
>>>> Seem reasonable, or am I missing yet something else?
>>> Not at all reasonable.
>>>
>>> For one thing, consider this question: Which statements lie inside a
>>> read-side critical section?
>> Here srcu_down_read() and srcu_up_read() are to srcu_read_lock() and
>> srcu_read_unlock() as down_read() and up_read() are to mutex_lock()
>> and mutex_unlock().  Not that this should be all that much comfort
>> given that I have no idea how one would go about modeling down_read()
>> and up_read() in LKMM.
> It might make sense to work on that first, before trying to do
> srcu_down_read() and srcu_up_read().
>
>>> With srcu_read_lock() and a matching srcu_read_unlock(), the answer is
>>> clear: All statements po-between the two.  With srcu_down_read() and
>>> srcu_up_read(), the answer is cloudy in the extreme.
>> And I agree that it must be clearly specified, and my that previous try
>> was completely lacking.  Here is a second attempt:
>>
>> let srcu-rscs = (([Srcu-lock] ; data ; [Srcu-unlock]) & loc) |
>> 		(([Srcu-down] ; (data | rf)* ; [Srcu-up]) & loc)
>>
>> (And I see your proposal and will try it.)
>>
>>> Also, bear in mind that the Fundamental Law of RCU is formulated in
>>> terms of stores propagating to a critical section's CPU.  What are we to
>>> make of this when a single critical section can belong to more than one
>>> CPU?
>> One way of answering this question is by analogy with down() and up()
>> when used as a cross-task mutex.  Another is by mechanically applying
>> some of current LKMM.  Let's start with this second option.
>>
>> LKMM works mostly with critical sections, but we also discussed ordering
>> based on the set of events po-after an srcu_read_lock() on the one hand
>> and the set of events po-before an srcu_read_unlock() on the other.
>> Starting here, the critical section is the intersection of these two sets.
>>
>> In the case of srcu_down_read() and srcu_up_read(), as you say, whatever
>> might be a critical section must span processes.  So what if instead of
>> po, we used (say) xbstar?  Then given a set of A such that ([Srcu-down ;
>> xbstar ; A) and B such that (B ; xbstar ; [Srcu-up]), then the critical
>> section is the intersection of A and B.
>>
>> One objection to this approach is that a bunch of unrelated events could
>> end up being defined as part of the critical section.  Except that this
>> happens already anyway in real critical sections in the Linux kernel.
>>
>> So what about down() and up() when used as cross-task mutexes?
>> These often do have conceptual critical sections that protect some
>> combination of resource, but these critical sections might span tasks
>> and/or workqueue handlers.  And any reasonable definition of these
>> critical sections would be just as likely to pull in unrelated accesses as
>> the above intersection approach for srcu_down_read() and srcu_up_read().
>>
>> But I am just now making all this up, so thoughts?
> Maybe we don't really need to talk about read-side critical sections at
> all.  Once again, here's what explanation.txt currently says:
>
> 	For any critical section C and any grace period G, at least
> 	one of the following statements must hold:
>
> (1)	C ends before G does, and in addition, every store that
> 	propagates to C's CPU before the end of C must propagate to
> 	every CPU before G ends.
>
> (2)	G starts before C does, and in addition, every store that
> 	propagates to G's CPU before the start of G must propagate
> 	to every CPU before C starts.
>
> Suppose we change this to:
>
> 	For any RCU lock operation L and matching unlock operation U,
> 	and any matching grace period G, at least one of the following
> 	statements must hold:
>
> (1)	U executes before G ends, and in addition, every store that
> 	propagates to U's CPU before U executes must propagate to
> 	every CPU before G ends.
>
> (2)	G starts before L executes, and in addition, every store that
> 	propagates to G's CPU before the start of G must propagate
> 	to every CPU before L executes.
>
> (For SRCU, G matches L and U if it operates on the same srcu structure.)

I think for the formalization, the definition of "critical section" is 
hidden inside the word "matching" here.
You will still need to define what matching means for up and down.
Can I understand down and up to create a large read-side critical 
section that is shared between multiple threads, analogously to a 
semaphore? With the restriction that for srcu, there are really multiple 
(two) such critical sections that can be open in parallel, which are 
indexed by the return value of down/the input of up?

If so I suspect that every down matches with every up within a "critical 
section"?
maybe you can define balancing along the co analous to the balancing 
along po currently used for matching rcu_lock() and rcu_unlock(). I.e.,

down ------------- up
    \down--------up/
        \down-up/
           \_/
where diagonal links are co links and the straight links are "balanced 
match" links.

Then everything that is enclosed within a pair of "balanced match" is 
linked:

match-down-up = co^-1?; balanced-srcu-updown ; co^-1?

Since multiple critical sections can be in-flight, maybe you can use co 
& same-value (or whatever the relation is) to define this?


let balanced-srcu-updown = let rec
         unmatched-locks = Srcu-down \ domain(matched)
     and unmatched-unlocks = Srcu-up \ range(matched)
     and unmatched = unmatched-locks | unmatched-unlocks
     and unmatched-co = [unmatched] ; co & same-value ; [unmatched]
     and unmatched-locks-to-unlocks =
         [unmatched-locks] ;  co & same-value ; [unmatched-unlocks]
     and matched = matched | (unmatched-locks-to-unlocks \
         (unmatched-co ; unmatched-co))
     in matched
let match-down-up = (co & same-value)^-1?; balanced-srcu-updown ; (co & 
same-value)^-1?



>
>>> Indeed, given:
>>>
>>> 	P0(int *x) {
>>> 		srcu_down_read(x);
>>> 	}
>>>
>>> 	P1(int *x) {
>>> 		srcu_up_read(x);
>>> 	}
>>>
>>> what are we to make of executions in which P1 executes before P0?
>> Indeed, there had better be something else forbidding such executions, or
>> this is an invalid use of srcu_down_read() and srcu_up_read().

Would it be sufficient to flag executions in which an up is not matched 
with any down event?

>>    This might
>> become more clear if the example is expanded to include the index returned
>> from srcu_down_read() that is to be passed to srcu_up_read():
>>
>> 	P0(int *x, int *i) {
>> 		WRITE_ONCE(i, srcu_down_read(x));
>> 	}
>>
>> 	P1(int *x, int *i) {
>> 		srcu_up_read(x, READ_ONCE(i));
>> 	}
> Hmmm.  What happens if you write:
>
> 	r1 = srcu_down_read(x);
> 	r2 = srcu_down_read(x);
> 	srcu_up_read(x, r1);
> 	srcu_up_read(x, r2);
>
> ?  I can't even tell what that would be _intended_ to do.

Is it correct that it creates one or two read-side critical sections 
depending on whether the two down() happen to return the same value, 
which either spans at least all four lines (plus perhaps more if other 
threads also do down()) or the first spans lines 1-3 and the second 
spans 2-4?

Is the implementation of srcu-lock and srcu-unlock still anything like 
the implementation in the 2009 paper?

best wishes and thanks for your patient explanations, jonas

