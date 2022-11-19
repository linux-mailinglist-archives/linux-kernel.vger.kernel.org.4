Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0EC630893
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 02:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbiKSBnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 20:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbiKSBms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:42:48 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553E0C6601
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 16:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668819047; x=1700355047;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r3Yz/qy7ar/9oMhU0tvrU2A6zET4kcyoWHUjLuusL3M=;
  b=VTTaUrjJJOsUmRCE3z9DDTVTOJmEUAjhqTUITPm9Kuw3W1lfDCiNAHOk
   1UiuxPpJZtJicyzyMP9Ao1IUDDrXnhXM8Nu9nkhmxH94w9aH63+yq11NS
   iwkt06T5oPbS1ZsfhyGcaiizbtDrznjNKtHBQXk82WsoTi1JtK+tBa14e
   H5L5yO+bKO/pdsK8gQ541NsWadRs5BxgVri/hNTBRjOnxhK7f2fqVuZ1x
   wYiUG0dTn4rQEIHFnXx8KfTr9z1OK2867GTEVdLm9SiBc9dKwN6RQ37sN
   gdi5BLLb8bkP5HWdmXx84+QrHQhXxja926EoYUAXvSzhoqQQjFwSOX62p
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="375418676"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="375418676"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 16:50:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="671508578"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="671508578"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.241.235.244]) ([10.241.235.244])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 16:50:46 -0800
Message-ID: <8d055277-1f55-fc93-87cb-7a8f0d8d2839@linux.intel.com>
Date:   Fri, 18 Nov 2022 16:50:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 18/46] entry, lto: Mark raw_irqentry_exit_cond_resched()
 as __visible
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
References: <20221114114344.18650-1-jirislaby@kernel.org>
 <20221114114344.18650-19-jirislaby@kernel.org> <87a64qo4th.ffs@tglx>
 <Y3XzkxNVTvdB4a/1@hirez.programming.kicks-ass.net>
 <289e03d2-be50-4249-343a-75dae302b0e5@linux.intel.com> <8735ahkq55.ffs@tglx>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <8735ahkq55.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Sure, they can play around with it but that does not require to merge
> all this nonsensical ballast for a half thought out compiler.


You are referring to __visible?

TBH I don't understand the problem. In general __visible is useful 
documentation,

so you know something is used from assembler or other strange contexts. 
Doing such things

explicitly marked instead of implicitly hidden and they just happen to 
work by accident

seems cleaner to me.


I can also see the __visible markings being useful for other purposes, 
e.g. static analysis tools or

dynamic instrumentation like the various sanitizers. Everything that is 
referenced outside

the normal code that the compiler sees may need some special handling.


That said I don't see the point of __visible_in_lto either, it should be 
just all __visible.


Similar argument applies to __noreorder, it's also useful documentation.


There are a few real workarounds in the patchkit that are a bit ugly, 
but __visible isn't it.


>
> If they want to do that they can apply the pile of patches as provided
> and play around.


It's very difficult to maintain out of tree, while in tree it's much 
simpler.

I think Linux should support its primary compiler well and not give up 
due to relatively small obstacles.


-Andi
