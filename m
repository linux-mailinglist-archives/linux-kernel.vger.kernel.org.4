Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0517E6F8D67
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 03:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjEFBN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 21:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjEFBNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 21:13:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA9B72A0
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 18:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683335633; x=1714871633;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=u3kMk/1UQfRYCfJGDmk7KWFB7Gj0IW4ttMD4+zwdcWc=;
  b=MmF6cYoV9bQUmSXknGbv6YmgLAqrvyAyIi5AjXmp7fFATr1cKynljbm5
   pIv0uMz3+ohJGt7j8QgBs7mWNdhWMhqN55XPkkKvkpM7S4eiE4+QOA6bY
   Chc/CKup4k+6dyNuB7zwQxqBsYhIuoshvC41NOLo8vwI4guSd2XxWqvW+
   sQ9pTwUwZ2mmNPkaDl8oTosYBrHoCdbuQc/bUrUWnNwGvLBge0mFB4I3X
   Lu3qN8iDz8llxdyAFEmjN41koeXC6igTPaU5GVEizo0X4wFj6zuPiktDn
   P7jC3ma8X5sSmaXtzB9MJYIXcSYj+/6k6yqjtvjn8Oqk6UFXcTMDtSd2G
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="338532596"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="338532596"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 18:13:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="821939019"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="821939019"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 18:13:51 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 4/4] llist.h: Fix parentheses around macro pointer
 parameter use
References: <20230504012914.1797355-1-mathieu.desnoyers@efficios.com>
        <20230504012914.1797355-4-mathieu.desnoyers@efficios.com>
        <87pm7gd4l5.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <8c28baa8-0945-fd77-3d1d-92c99c7bbbd1@efficios.com>
        <CAHk-=wjfgCa-u8h9z+8U7gaKK6PnRCpws1Md9wYSSXywUxoUSA@mail.gmail.com>
        <190e5f92-f386-77a4-21c3-7f07b15ac4a3@efficios.com>
Date:   Sat, 06 May 2023 09:12:47 +0800
In-Reply-To: <190e5f92-f386-77a4-21c3-7f07b15ac4a3@efficios.com> (Mathieu
        Desnoyers's message of "Fri, 5 May 2023 10:23:57 -0400")
Message-ID: <878re2b6uo.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:

> On 2023-05-04 13:16, Linus Torvalds wrote:
>> On Thu, May 4, 2023 at 7:54/AM Mathieu Desnoyers
>> <mathieu.desnoyers@efficios.com> wrote:
>>> +#define list_prepare_entry(pos, head, member) \
>>> +       ((pos) ? : list_entry(head, typeof(*pos), member))
>>>
>>> So even though the fact that "pos" is used as an lvalue specifically in
>>> llist_for_each_entry_safe() makes it so that the parentheses are not
>>> strictly required around "pos" in typeof(*pos), I argue that we should
>>> still add those for consistency.
>> Ack. It may not matter in reality because of how 'pos' is supposed
>> to
>> be just a local variable name, but I agree that for consistency our
>> macros should still follow the usual pattern.
>> Of course, *because* of how 'pos' is not some random expression, and
>> is supposed to be that local variable, and because of how it is used,
>> it must always violate the whole "only use once" usual pattern,.
>> Exactly the same way the member name is also typically used multiple
>> times because of how it's not an expression, but really a "part of the
>> syntax".
>> So an alternative might be that we should use a different syntax for
>> those things and make it clear that they are not normal expressions.
>> Some people use upper-case names for special things like that to make
>> them stand out as "not normal" (kind of the same way upper-case macros
>> themselves were a warning that they weren't normal and might evaluate
>> arguments multiple times).
>
> Is a list iteration position absolutely required to be a local variable,
> or can it be a dereferenced pointer ?
>
> Let's say we take "list_for_each()" as example:
>
> #define list_for_each(pos, head) \
>         for (pos = (head)->next; !list_is_head(pos, head); pos = pos->next)
>
> and turn "pos" into "POS" to make it clearer that it is used as an lvalue:
>
> #define list_for_each(POS, head) \
>         for (POS = (head)->next; !list_is_head(POS, head); pos = POS->next)
>
> The following usage pattern is still broken:
>
> struct list_head list;
>
> void f(struct list_head **ppos)
> {
>   list_for_each(*ppos, &list) {
>     //...
>   }
> }
>
> Because ->next has higher operator precedence than "*", which is unexpected.
>
> I would argue that even if we choose to capitalize the macro special arguments used
> as lvalues and as member names so they stand out, it does not eliminate the need to
> be careful about proper use of parentheses around those parameters when they are also
> used as rvalues.

Yes.  The special parameter isn't necessary a variable name (except the
member name).  So special parameters

- are lvalue or member name
- may be "evaluated" multiple times

This makes them special enough from other macro parameters.  And we
still need to be careful about them (for example, when used as rvalue)
as other macro parameters.

Best Regards,
Huang, Ying
