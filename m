Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DD96F8062
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjEEJuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjEEJuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:50:14 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6A019D71
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 02:49:57 -0700 (PDT)
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3459neom016438;
        Fri, 5 May 2023 18:49:40 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Fri, 05 May 2023 18:49:40 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3459ndQF016434
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 5 May 2023 18:49:40 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <fd2f89d9-73a5-c155-48a5-ccc6e93310b2@I-love.SAKURA.ne.jp>
Date:   Fri, 5 May 2023 18:49:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [syzbot] [fs?] INFO: task hung in synchronize_rcu (4)
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+222aa26d0a5dbc2e84fe@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <20230504061613.3901-1-hdanton@sina.com>
 <7ea26a76-5c8c-a0d2-5b5e-63e370cdcb99@I-love.SAKURA.ne.jp>
 <20230505083549.GB1770668@hirez.programming.kicks-ass.net>
 <c8ce113e-423f-9109-94a1-631583e2ad8e@I-love.SAKURA.ne.jp>
In-Reply-To: <c8ce113e-423f-9109-94a1-631583e2ad8e@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/05/05 18:46, Tetsuo Handa wrote:
> On 2023/05/05 17:35, Peter Zijlstra wrote:
>>> Linus, I think that "[PATCH v3 (repost)] locking/lockdep: add debug_show_all_lock_holders()"
>>> helps here, but I can't wake up locking people. What can we do?
>>
>> How is that not also racy ?
> 
> Nobody can make this code racy.

Oops, nobody can make this code race-free.

Capturing vmcore is not an option.

> 
>>
>> I think I've seen that patch, and it had a some 'blurb' Changelog that
>> leaves me wondering wtf the actual problem is and how it attempts to
>> solve it and I went on with looking at regressions because more
>> important than random weird patch.
> 
> Please respond to
> https://lkml.kernel.org/393a440f-5f82-432c-bc24-e8de33e29d75@I-love.SAKURA.ne.jp .
> 

I am waiting for your response.
But since you don't respond, I have to repeat re-posting.

