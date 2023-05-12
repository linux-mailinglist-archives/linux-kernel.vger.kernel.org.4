Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E597A700DEC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 19:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237182AbjELReu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 13:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjELRer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 13:34:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7921B8
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 10:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683912885; x=1715448885;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X6PrQLh97GJM1/yvM4EvcbXGQcLYtbEvKbYtw8xZHHg=;
  b=VaUl620neakE/BJM8ETxbFPlnjOu/9TMKM9DHRF6Zl+ZHcNh1itZc2Td
   3z+H3tJ8cwVBcFfZP36p5JO233LcAh23M9C5aCjl2nzA1+ILDiRKWfqjt
   8fa2NJ2H4IDYkf195d5dgqjtbyN/zZ84UeWXThsKY57z+O1orCAGnd1/b
   UdEn5TezFOX1B+lp+l08+N7KqhibkyOERfAx/vF09Ou6NN7pWAanrHL8J
   k2F/R0M55/B2dB/mrnGclqmuhMCq0CDFnowXZJgDPf+EEUmRlDVQNh0Uo
   GPc1/k7ccIq+wc/r9j3VYwWXGIBF7O3WdSpRlyfR0+BFNEhiHfhVqbh0o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="353096932"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="353096932"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 10:34:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="874467402"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="874467402"
Received: from ohibbert-mobl1.amr.corp.intel.com (HELO [10.209.120.219]) ([10.209.120.219])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 10:34:17 -0700
Message-ID: <95c2e669-bce9-3dd5-e197-3faf816c4b45@intel.com>
Date:   Fri, 12 May 2023 10:34:17 -0700
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
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <20230424212130.590684-1-dave.hansen@linux.intel.com>
 <CAHk-=whn3F1k263SZNUVQK195tcCMAo5E_WbmjUE0qFC5rWg=w@mail.gmail.com>
 <4433c3595db23f7c779b69b222958151b69ddd70.camel@intel.com>
 <148b3edb-b056-11a0-1684-6273a4a2d39a@intel.com>
 <CAHk-=wiuVXTfgapmjYQvrEDzn3naF2oYnHuky+feEJSj_G_yFQ@mail.gmail.com>
 <CAHk-=wiB0wy6oXOsPtYU4DSbqJAY8z5iNBKdjdOp2LP23khUoA@mail.gmail.com>
 <4171c4b0-e24b-a7e2-9928-030cc14f1d8d@intel.com>
 <CAHk-=wiVLvz3RdZiSjLNGKKgR3s-=2goRPnNWg6cbrcwMVvndQ@mail.gmail.com>
 <CAHk-=wg4vpYz+xRtd+PsdmQ9gtNGbXrFKW3ndvXcrLEEDN0hyw@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAHk-=wg4vpYz+xRtd+PsdmQ9gtNGbXrFKW3ndvXcrLEEDN0hyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/23 16:47, Linus Torvalds wrote:
>  - we would probably be *much* better off with a "if (mm->count == 1)"
> test that goes off and does *not* do the atomic case (which also
> doesn't have any worries about dirty bits). I'll take a well-predicted
> conditional branch over an atomic op any day of the week

Were you really thinking of mm->count==1, or did you mean
mm->mm_users==1?  I _think_ the only clue that things like ptrace() and
kthread_use_mm() are poking around in the page tables is when
mm->mm_users>1.  They don't bump mm->count.

Most mmget() (or get_task_mm()->atomic_inc(&mm->mm_users)) callers are
obviously harmless for our purposes, like proc_pid_statm().

There are others like idxd_copy_cr()->copy_to_user() that are less
obviously OK.  They're OK if they fault during a fork() because the
fault will end up stuck on mmap_read(mm) waiting for fork() to release
its write.

But the worry is if those kthread_use_mm() users *don't* fault:

	CPU-1			CPU-2
	fork()
	// mm->mm_users==1
	ptep_set_wrprotect()
	  ^ non-atomic
				kthread_use_mm()
				// mm->mm_users==2
				copy_to_user()
				// page walker sets Dirty=1

There's always a race there because mm->mm_users can always get bumped
after the fork()er checks it.

Is there something that fixes this race that I'm missing?

We can probably do something more comprehensive to make sure that
mm->mm_users isn't bumped during fork(), but it'll be a bit more
complicated than just checking mm->mm_users in fork().
