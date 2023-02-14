Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E7969622F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjBNLQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjBNLQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:16:43 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7598F524D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:16:42 -0800 (PST)
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 31EBGc13099961;
        Tue, 14 Feb 2023 20:16:38 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Tue, 14 Feb 2023 20:16:38 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 31EBGc3B099958
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 14 Feb 2023 20:16:38 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f8ab471e-433e-3a2e-fdaf-8c1eb43c073e@I-love.SAKURA.ne.jp>
Date:   Tue, 14 Feb 2023 20:16:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [syzbot] WARNING: locking bug in umh_complete
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+6cd18e123583550cf469@syzkaller.appspotmail.com>,
        Hillf Danton <hdanton@sina.com>
References: <20230127014137.4906-1-hdanton@sina.com>
 <9d9b9652-c1ac-58e9-2eab-9256c17b1da2@I-love.SAKURA.ne.jp>
 <7d1021f1-c88e-5a03-3b92-087f9be37491@I-love.SAKURA.ne.jp>
 <Y9z76ZLe4On96xIN@hirez.programming.kicks-ass.net>
 <Y9z+SerR8mlZYo16@hirez.programming.kicks-ass.net>
 <6c47dbcf-2a17-6bb2-719b-841d851c603b@I-love.SAKURA.ne.jp>
 <Y90ar35uKQoUrLEK@hirez.programming.kicks-ass.net>
 <caa13441-5f95-b7d6-dd5d-1cf49e709714@I-love.SAKURA.ne.jp>
 <Y+pYiUfKp32hbIEI@hirez.programming.kicks-ass.net>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <Y+pYiUfKp32hbIEI@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/02/14 0:34, Peter Zijlstra wrote:
> On Sat, Feb 04, 2023 at 09:48:39AM +0900, Tetsuo Handa wrote:
>> Please fold below diff,
> 
> Find final version below -- typing hard I suppose..
> 

Thanks for explanation and patch. Please proceed.

As per https://lkml.kernel.org/r/20221115140233.21981-1-schspa@gmail.com ,
I think Schspa Shi <schspa@gmail.com> can be added using Reported-by: tag.

