Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4766728CE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjART53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjART51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:57:27 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551A24FADA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:57:26 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id w14so187129edi.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/9kGDKs+LJ1m0NhXt2p2+PQyQ/aF+MUPAS3OTNaw5w=;
        b=K6g0YuhvcoVicMo27123amhxBA+tOtGuP1TX10MvfJEI7xA3cYQq/XfBAoQyUuvQbo
         pAtG3fgN48nV5plCDIFPfRcOIXYhrM23NHpFGGHE9GWs3sxdDLGRf149X4XQMKqqoISB
         DUaZzeyNYdV9TfZHt1mrM+IYwb2zDnmEOK2rx59qjB51gJ2Bh5yxw7hzZ3eOeYIhEJrE
         jXLkuAhKTDVX7UrcR71sLq+Mad0TsGUSMkkBwcfKqUpns4A43wUDYUVVRZVXdd5HtEif
         rNYsmBTDzNZBtQaW8BJwwJ+2eS86uyiBiC3naOcyefh4zLtRg1M8o533DSnjz+BIGia7
         xYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t/9kGDKs+LJ1m0NhXt2p2+PQyQ/aF+MUPAS3OTNaw5w=;
        b=CwyEuzCBTvzBZFMO8LJcoyVVixg8wE+1Qx8UxmBGY9irLD0XhwxvE2eq3E4DhHNuQG
         ef3TQfP2ydVD3XfCABfQDEXcK/8eDZf34TvLUb5uAU/CDnv3TKXMCQbOfZ85Wp3/t+PL
         i+qZzD4evjXk9ICjHriWCEZyMm1m5KqLn4b0QAMhuu1Xr/4FwAw6FI3ptM3Lutsa1Kiu
         QnzuwwbeROmJoghGfh6wBsFNni1e7Ns2itFIHAlCCGyxYEEjZcVChw3hbmTE5Bv+R90E
         DamjIrkP9Zze6efgkZiYXIfoGzvDQjtf84fxrB3Fwhk05R/jSL1ssd+16+BATWse54cp
         TUXA==
X-Gm-Message-State: AFqh2kq0p0d5FV7RXn1jvVPJHAa28cENPsrtpn9RezMUxI577fOZyq6t
        EYv64pngh0r2Xv7kAPDM/bw=
X-Google-Smtp-Source: AMrXdXtK0Y+1qT9+qNNdxiqyrlDoz6OS1OtQQafWG5FcH9qhcqwx9WJ6ZGIbmWqwNpj+GCOguyQO2w==
X-Received: by 2002:a05:6402:3786:b0:499:8849:5fac with SMTP id et6-20020a056402378600b0049988495facmr9121374edb.40.1674071844709;
        Wed, 18 Jan 2023 11:57:24 -0800 (PST)
Received: from [192.168.1.13] (dynamic-078-054-168-106.78.54.pool.telefonica.de. [78.54.168.106])
        by smtp.gmail.com with ESMTPSA id v18-20020aa7dbd2000000b0049ac6f53e6asm3916436edt.80.2023.01.18.11.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 11:57:24 -0800 (PST)
Message-ID: <73ff21ef-44fa-2dbf-cae0-f74077875502@gmail.com>
Date:   Wed, 18 Jan 2023 20:57:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
To:     paulmck@kernel.org, Alan Stern <stern@rowland.harvard.edu>
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
References: <20230116042329.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8WTXS73qTBpUzcI@rowland.harvard.edu>
 <20230116190652.GZ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8WjmTFnqbAnS1Pz@rowland.harvard.edu>
 <20230116221357.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8aKlNY4Z0z2Yqs0@andrea>
 <20230117151416.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8bFMgDSUZymXUsS@rowland.harvard.edu>
 <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8cBypKx4gM3wBJa@rowland.harvard.edu>
 <20230118035041.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Jonas Oberhauser <s9joober@gmail.com>
In-Reply-To: <20230118035041.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
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



On 1/18/2023 4:50 AM, Paul E. McKenney wrote:
> On Tue, Jan 17, 2023 at 03:15:06PM -0500, Alan Stern wrote:
>> On Tue, Jan 17, 2023 at 09:43:08AM -0800, Paul E. McKenney wrote:
>>> On Tue, Jan 17, 2023 at 10:56:34AM -0500, Alan Stern wrote:
>>>> Isn't it true that the current code will flag srcu-bad-nesting if a
>>>> litmus test has non-nested overlapping SRCU read-side critical sections?
>>> Now that you mention it, it does indeed, flagging srcu-bad-nesting.
>>>
>>> Just to see if I understand, different-values yields true if the set
>>> contains multiple elements with the same value mapping to different
>>> values.  Or, to put it another way, if the relation does not correspond
>>> to a function.
>> As I understand it, given a relation r (i.e., a set of pairs of events),
>> different-values(r) returns the sub-relation consisting of those pairs
>> in r for which the value associated with the first event of the pair is
>> different from the value associated with the second event of the pair.
> OK, so different-values(r) is different than (r \ id) because the
> former operates on values and the latter on events?

I think you can say that (if you allow yourself to be a little bit loose 
with words, as I allow myself to be, much to the chagrin of Alan :) :( :)).

If you had a .value functional relation that relates every event to the 
value of that event, then
    different-values(r) = r \ .value ; .value^-1
i.e., it relates events x and y iff: 1) r relates x and y, and 2) the 
value of x is not equal to the value of y.

You could write this as
    different-values(r) = r \ .value ; value-id ; .value^-1
where value-id is like id but for values, i.e., relates every value v to 
itself.

You could say that this difference operates on the values of the events, 
rather than on the events itself.
In contrast,
     r \ id
works directly on the events and relates x and y iff: 1) r relates x and 
y, and 2) the event x is not equal to the event y.

In this sense I think your characterization is appropriate.



