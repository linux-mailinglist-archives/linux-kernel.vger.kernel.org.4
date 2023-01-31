Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B4F682988
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjAaJw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjAaJwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:52:20 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBB21A8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:52:19 -0800 (PST)
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 30V9qHPH088509;
        Tue, 31 Jan 2023 18:52:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Tue, 31 Jan 2023 18:52:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 30V9qHiS088504
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 31 Jan 2023 18:52:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c702647f-67c8-1981-c5c9-e9f6ce0e3bef@I-love.SAKURA.ne.jp>
Date:   Tue, 31 Jan 2023 18:52:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 (repost)] locking/lockdep: add
 debug_show_all_lock_holders()
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <41f43b27-d910-78e0-c0b3-f2885fe1cd22@I-love.SAKURA.ne.jp>
 <Y8J3gAXLf4yc0FcL@gmail.com>
 <e68b4c88-a278-90d0-0ce0-9d4e161366cc@I-love.SAKURA.ne.jp>
 <8cfce359-2b55-5158-3a7f-d83a7be212f4@redhat.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <8cfce359-2b55-5158-3a7f-d83a7be212f4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo, what do you think?

I want your tree to send this patch in the upcoming merge window.

On 2023/01/17 12:28, Waiman Long wrote:
>> Please talk with Waiman. I'm fine with either approach.
> 
> My original concern was that two functions are very similar with some minor difference. My suggestion was to use a common helper to reduce the code redundancy and future maintenance.
> 
> I do have some nits about the patch. The show_stack parameter isn't informative. Maybe you can use show_tasks as the parameter name since the major difference is the calling of sched_show_task().
> 
> Define a new helper like debug_show_all_locks_tasks(bool show_tasks), use it directly in check_hung_uninterruptible_tasks() and make debug_show_all_lock() call debug_show_all_locks_tasks().
> 
> Ingo, will that OK with you?
> 
> Cheers,
> Longman
> 

