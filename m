Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0644E605069
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 21:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiJSTaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 15:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiJSTaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 15:30:25 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D433E102DED
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:30:19 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id az22-20020a05600c601600b003c6b72797fdso723016wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VWTVUzZSPgyErG0K1bIQIObQY5FrTpMGy0tgMmfzvHA=;
        b=VVud+TV38lIgoqq/7ycSuPRBEPJDbIelERT4/Duhq9o8XCgVHoeQkxqwz6xeBZIfWo
         fJI2+GI/PxnUtnJiDh0HprF3YjF5Bte1njeUdEKgUpSCZLMu2K4mz8qDVBBaP45cIAZj
         QvTuDQnlPMGFIKDYv27XQEuLQ/bkbk35EmD/AKGYpQzmqxLVZ7xSeVp2u6Jt/fJ207PR
         ocAlO+jdjGVF5XI8o4DKlh3gWxaHYO8VAKvpTikfGWvlrY4Hf2uzHPeq04l1ud7XC9+h
         vde3NivYT2Jjd6O9tlTYYNN/S30wMqjfLs4cFrmV+jutMN5cnKYziSq0RL5ZKyIKJ0n7
         IbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VWTVUzZSPgyErG0K1bIQIObQY5FrTpMGy0tgMmfzvHA=;
        b=W7+pPVEuYftwvsjDu8f+tDuoZR/XPgM1lBFP+mVjDnuoOphrgOtd9EHem9FzFpPpnX
         6iKkWzfonTjnFVy4KSmsRtUitMOqwvaw9Qi4Tz2IchIXPLm36PLQ4EJLzt3mbo2jre1P
         vdcmBwKcfJbZWFz3eUjToZ2I0POW2RDrBkDL0lE5HgfxanuDcpuyECshpFnfFhOQw5iB
         F+Bhj71I/Ps96FS8ENANIapcqSxDOq2bS3gyneaT61OL8uHzwgWNFAB0UAaKrZheZGQt
         HpR2qF+K1FMBNmg+KV7NrqHDtAnk4WvYffjCj8+rAah9pAyBaA+AqdNsyTNVflkiR5h1
         VkuA==
X-Gm-Message-State: ACrzQf0VZs8k4GfS+pJYIZpU+QZUXUL3Wb6NsxdfL11pLLWtcw82DLLM
        PavZgYGlEnisb3CO7BTtitxhpw==
X-Google-Smtp-Source: AMsMyM4gXEyT7PPAdzVlOlZDOa2vq7xKmCCi8QdAtB6lGe/e3eDZ59R1HXzm8Jo1ag25EgUk2QXHcw==
X-Received: by 2002:a05:600c:5127:b0:3c6:47ff:5d33 with SMTP id o39-20020a05600c512700b003c647ff5d33mr7324420wms.68.1666207818247;
        Wed, 19 Oct 2022 12:30:18 -0700 (PDT)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id s15-20020adfeb0f000000b0022cdeba3f83sm13959023wrn.84.2022.10.19.12.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 12:30:17 -0700 (PDT)
Date:   Wed, 19 Oct 2022 20:30:15 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Connor O'Brien <connoro@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        John Stultz <jstultz@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH 00/11] Reviving the Proxy Execution Series
Message-ID: <20221019193015.mczb4ew2m4h2qjjy@airbuntu>
References: <20221019114357.yipijpetxz7ns5aq@airbuntu>
 <F9BCD313-15BA-429C-B50C-1391DDC1239B@joelfernandes.org>
 <Y0/+ieCymugrjheC@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y0/+ieCymugrjheC@localhost.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/22 15:41, Juri Lelli wrote:
> On 19/10/22 08:23, Joel Fernandes wrote:
> > 
> > 
> > > On Oct 19, 2022, at 7:43 AM, Qais Yousef <qyousef@layalina.io> wrote:
> > > 
> > > ﻿On 10/17/22 02:23, Joel Fernandes wrote:
> > > 
> > >> I ran a test to check CFS time sharing. The accounting on top is confusing,
> > >> but ftrace confirms the proxying happening.
> > >> 
> > >> Task A - pid 122
> > >> Task B - pid 123
> > >> Task C - pid 121
> > >> Task D - pid 124
> > >> 
> > >> Here D and B just spin all the time. C is lock owner (in-kernel mutex) and
> > >> spins all the time, while A blocks on the same in-kernel mutex and remains
> > >> blocked.
> > >> 
> > >> Then I did "top -H" while the test was running which gives below output.
> > >> The first column is PID, and the third-last column is CPU percentage.
> > >> 
> > >> Without PE:
> > >>  121 root      20   0   99496   4   0 R  33.6   0.0   0:02.76 t  (task C)
> > >>  123 root      20   0   99496   4   0 R  33.2   0.0   0:02.75 t  (task B)
> > >>  124 root      20   0   99496   4   0 R  33.2   0.0   0:02.75 t  (task D)
> > >> 
> > >> With PE:
> > >>  PID
> > >>  122 root      20   0   99496   4   0 D  25.3   0.0   0:22.21 t  (task A)
> > >>  121 root      20   0   99496   4   0 R  25.0   0.0   0:22.20 t  (task C)
> > >>  123 root      20   0   99496   4   0 R  25.0   0.0   0:22.20 t  (task B)
> > >>  124 root      20   0   99496   4   0 R  25.0   0.0   0:22.20 t  (task D)
> > >> 
> > >> With PE, I was expecting 2 threads with 25% and 1 thread with 50%. Instead I
> > >> get 4 threads with 25% in the top. Ftrace confirms that the D-state task is
> > >> in fact not running and proxying to the owner task so everything seems
> > >> working correctly, but the accounting seems confusing, as in, it is confusing
> > >> to see the D-state task task taking 25% CPU when it is obviously "sleeping".
> > >> 
> > >> Yeah, yeah, I know D is proxying for C (while being in the uninterruptible
> > >> sleep state), so may be it is OK then, but I did want to bring this up :-)
> > > 
> > > I seem to remember Valentin raised similar issue about how userspace view can
> > > get confusing/misleading:
> > > 
> > >    https://www.youtube.com/watch?v=UQNOT20aCEg&t=3h21m41s
> > 
> > Thanks for the pointer! Glad to see the consensus was that this is not
> > acceptable.
> > 
> > I think we ought to write a patch to fix the accounting, for this
> > series. I propose adding 2 new entries to proc/pid/stat which I think
> > Juri was also sort of was alluding to:
> > 
> > 1. Donated time.
> > 2. Proxied time.
> 
> Sounds like a useful addition, at least from a debugging point of view.

They look useful addition to me too.

> 
> > User space can then add or subtract this, to calculate things
> > correctly. Or just display them in new columns. I think it will also
> > actually show how much the proxying is happening for a use case.
> 
> Guess we'll however need to be backward compatible with old userspace?
> Probably reporting the owner as running while proxied (as in the
> comparison case vs. rtmutexes Valentin showed).
> 

Or invent a new task_state? Doesn't have to be a real one, just report a new
letter for tasks in PE state. We could use 'r' to indicate running BUT..


Cheers

--
Qais Yousef
