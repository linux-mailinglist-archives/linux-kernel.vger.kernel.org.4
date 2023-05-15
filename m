Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1F2703FE4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245596AbjEOVg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244780AbjEOVg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:36:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B9459F0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 14:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684186615; x=1715722615;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=okg4qHsni/PY/1YuKzsck2gzkBAG4CiQF0UDeudg5Ts=;
  b=cclaETLRdj2gtEw01HAzOtspEhmXzshX4ecRl3T5/zbVvT5zSn6JAUHZ
   lO+WwNdjZW5iZ/jM9VHulSvleVn3u309hqad942rPe+X66loQoKDmtb1Y
   CmArCPQILghGewJrZ7iYjSiw80B96RcifUNFifaKXL5ZOiC44biXISptA
   W2vqd406j52o2f+1TalSxSSHgKuojtnX5ehEDDzX1WJV93aAl9eUZvmlX
   R9ciIDJ76psk943VWhpBtgpsxdf03V+Ut2sYsO31GRjSOYdJ/bOo0QQjA
   o3GjkY9FoPSyRYEneirWJLqY9TG8sMcLVAWe7PvoB+gS6TMAqojchVDiw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="351350572"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="351350572"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 14:36:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="695183462"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="695183462"
Received: from satwikja-mobl.amr.corp.intel.com (HELO [10.212.213.112]) ([10.212.213.112])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 14:36:54 -0700
Message-ID: <93ae88a4-1dac-77bf-37f6-f8708a6d83b7@intel.com>
Date:   Mon, 15 May 2023 14:36:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [GIT PULL] x86/shstk for 6.4
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230424212130.590684-1-dave.hansen@linux.intel.com>
 <CAHk-=whn3F1k263SZNUVQK195tcCMAo5E_WbmjUE0qFC5rWg=w@mail.gmail.com>
 <4433c3595db23f7c779b69b222958151b69ddd70.camel@intel.com>
 <148b3edb-b056-11a0-1684-6273a4a2d39a@intel.com>
 <CAHk-=wiuVXTfgapmjYQvrEDzn3naF2oYnHuky+feEJSj_G_yFQ@mail.gmail.com>
 <CAHk-=wiB0wy6oXOsPtYU4DSbqJAY8z5iNBKdjdOp2LP23khUoA@mail.gmail.com>
 <4171c4b0-e24b-a7e2-9928-030cc14f1d8d@intel.com>
 <CAHk-=wiVLvz3RdZiSjLNGKKgR3s-=2goRPnNWg6cbrcwMVvndQ@mail.gmail.com>
 <CAHk-=wg4vpYz+xRtd+PsdmQ9gtNGbXrFKW3ndvXcrLEEDN0hyw@mail.gmail.com>
 <95c2e669-bce9-3dd5-e197-3faf816c4b45@intel.com>
 <CAHk-=wjzEA_TO0wWNir0HzAFJ5_tMoQnrL_-8+igqmCZGVGdcw@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAHk-=wjzEA_TO0wWNir0HzAFJ5_tMoQnrL_-8+igqmCZGVGdcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/23 14:55, Linus Torvalds wrote:
>> There's always a race there because mm->mm_users can always get bumped
>> after the fork()er checks it.
> Ugh. I was assuming that if they don't already have a reference to the
> mm, they can't get one (becasue the '1' comes from 'current->mm', and
> nobody else has that mm).
> 
> But maybe that's just not true. Looking around, we have things like
> 
>         pages->source_mm = current->mm;
>         mmgrab(pages->source_mm);
> 
> that creates a ref to the mm with a grab, and then later it gets used.
> 
> So maybe the "no races can happen" is limited to *both* mm_users and
> mm_count being 1. What would increment it in that case, when 'current'
> is obviously busy forking?
> 
> That "both are one" might still be the common case for fork(). Hmm?

get_task_mm() is the devil here.  It goes right from having a
task_struct to bumping ->mm_users, no ->mm_count needed.  It also bumps
->mm_users while holding task_lock(), which means we can't do something
simple like take mmap_lock in there to avoid racing with fork().

I did hack something together that seems to work for fork() and
get_task_mm().  Basically, we let get_task_mm()'s legacy behavior to be
the fast path.  But it diverts over to a slow path if get_task_mm()
notices that an mm's refcounts and mmap_lock are consistent with a
fork() happening elsewhere.

The slow path releases the task_lock() and acquires mmap_lock so it can
sleep until the (potential) fork() is finished.

On the other side, the fork() code checks ->mm_users and ->mm_count.  It
can now depend on them being stable because it holds mmap_lock and it
diverts the get_task_mm() callers over to the slow path.

This works for two important cases:

1. get_task_mm() callers since they now conditionally use mmap_lock
2. mmgrab() -> mmget_not_zero() users that later take the mmap_lock

I'm also fairly sure it misses some cases outside of those two.  The
patch is also quite ugly.  The "->task_doing_fast_fork" mechanism is
pure hackery, for instance.

This seems to stay on the fast paths pretty well, even with 'top' or
some other /proc poking going on.  In the end, this is balancing the
extra cost of the get_task_mm() slow path with reduced atomic cost in
the fork() path.  It looks promising so far.

Is this worth pursuing?
