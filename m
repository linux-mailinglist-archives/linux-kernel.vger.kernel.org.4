Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663AF669910
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241163AbjAMNwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238573AbjAMNwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:52:16 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA438791E
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:48:50 -0800 (PST)
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 30DDmmnc050939;
        Fri, 13 Jan 2023 22:48:48 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Fri, 13 Jan 2023 22:48:48 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.20] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 30DDmmta050936
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 13 Jan 2023 22:48:48 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a557d6e4-8354-f39b-32e1-b10e8a6fc04a@I-love.SAKURA.ne.jp>
Date:   Fri, 13 Jan 2023 22:48:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [GIT PULL] tomoyo update and hung task update for v6.2
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <bc4f8b87-101b-381e-debf-6ed87bfec9f3@I-love.SAKURA.ne.jp>
 <CAHk-=wjbu9USn=hVWQ9v9t1H+8R6qXj8REkm36==w10zM0cM6g@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHk-=wjbu9USn=hVWQ9v9t1H+8R6qXj8REkm36==w10zM0cM6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/01/13 22:28, Linus Torvalds wrote:
> On Tue, Jan 10, 2023 at 5:07 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> A Makefile update for making it possible to remove scripts/bin2c program, and
>> an improvement for making it easier to understand syzbot's hung task reports.
> 
> That hungtask change I'd _really_ like to get from the locking people,
> not from a random - and completely unrelated tree.
> 

OK. Then, please ignore this request.

Peter or Ingo, will you send
"[PATCH v2 (repost)] locking/lockdep: add debug_show_all_lock_holders()" at
https://lkml.kernel.org/r/41f43b27-d910-78e0-c0b3-f2885fe1cd22@I-love.SAKURA.ne.jp
via your locking tree?

