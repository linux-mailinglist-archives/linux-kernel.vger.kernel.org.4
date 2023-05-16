Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FBD705903
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjEPUml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEPUmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:42:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417661AE
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684269759; x=1715805759;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/E7gUklL5bA43Tj50V90p5FleCakaQxx5h7vB4YWpfU=;
  b=FEhrcNr7cu8iwEO0cgQ4a0+yJZR8vIbO7f8fBFnhQFJPCRkYpGYAHvQI
   GD78lzfbtN3QiHS8GQkQw4Z5+TPz7olnVTPB4UyGkWcMqyPXB/2QueRyl
   0kYyWMoTh786UcS9mwJW+UU5KLxcFXCo1UTCzsdqiTMLUuWL7uKobyxil
   ZmOWPQyEPHz8aiH63X41pZSLNfb5yCd7tB+UXOrr0ethilhpzQF5vCToH
   YHQgNhyAHgy2zqLHRjC/N8ts3ItYJAzkMkk8lXVLy05IUqNp3+5mI76Jg
   Ccq864EwliibaMfLMoBxvuiUBaCZKufdnouhzFV8at+F6Qm2Eoa9+LTNd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="331948406"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="331948406"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 13:42:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="695604567"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="695604567"
Received: from mtpanu-mobl1.amr.corp.intel.com (HELO [10.212.203.6]) ([10.212.203.6])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 13:42:38 -0700
Message-ID: <025f7715-536e-bca0-3e44-7bddd8668b35@intel.com>
Date:   Tue, 16 May 2023 13:42:38 -0700
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
 <93ae88a4-1dac-77bf-37f6-f8708a6d83b7@intel.com>
 <CAHk-=wgZvH9KZPVbeTeLKwnv+bO4x15JVjeqWX68-+pmbsxJCQ@mail.gmail.com>
 <CAHk-=wg6TWSvb8Lk5uEu=QKQRFj7vewMsqLhuah4_7r2S=dXWA@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAHk-=wg6TWSvb8Lk5uEu=QKQRFj7vewMsqLhuah4_7r2S=dXWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/23 13:38, Linus Torvalds wrote:
> On Mon, May 15, 2023 at 3:40 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> So I *think* fork() could do something like this:
>>
>>   struct fork_cookie; // dummy type purely for type checking
>>   static struct fork_cookie *is_singe_threaded(void)
>>   {
>>         struct mm_struct *mm = current->mm;
>>         mutex_lock(&mm->fork_lock);
> Actually, let's not even bother with a new fork_lock.
> 
> I for some reason thought that fork only took the mmap_lock for
> reading (because it kind of does just read the old VM data), but when
> I actually look at dup_mmap() I notice that what it does is actually
> just
> 
>         if (mmap_write_lock_killable(oldmm)) ..
> 
> and so I think we can just use that as the lock.
> 
> So then all we'd need is to use mmap_read_lock(mm) in kthread_use_mm()
> around the mmgrab.
> 
> I don't think we even need it in kthread_unuse_mm(), because
> *decrementing* the mm counters isn't even something we need to worry
> about.
> 
> How does that sound?

Sounds promising.  I was really hesitant to bring a new lock into the world.

I need to digest what you write yesterday and convince myself a little
more that doing it at kthread_unuse_mm() is sufficient, but that's my
problem. ;)
