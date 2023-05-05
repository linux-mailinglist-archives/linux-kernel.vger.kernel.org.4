Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6946F7AB8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 03:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjEEBkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 21:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEEBkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 21:40:00 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E80124B2
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 18:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683250800; x=1714786800;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=mUs6SrWvtEqYkpN2XSYwtFunvV4u/3h5gUfIe5pKJik=;
  b=A2K+RDDD+p8E6gkQic0KU5g/DzpxzVwZ/6uKi4KdLWJDB/1egZ9VQ15v
   3i04PQFSRCw+adJOC0bVIkY2paGBjI3b6DznKWQMFIAhFQ7IKUlaYt/Lw
   q911vpq2/SVrLDsNil++N5yVhOo5MydL5Kk3O5T9DVQjiTEOh0MRALAGi
   bWEDkbPMTNLELtj3jluQ6QSAGvJRRTEnWRi5NR8Kys2jx8vI9v1vzOaHa
   /MjDJ1E49Qhzpah+YCQiGlE1Z5WPxZSoyHhLo9rNmNfDay0ShimICQVjw
   puMng2HmRqUWeOA3vVxASNSVG3K7Q2rh7wofq0gfunTjnt9TICxy8eWkm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="329464445"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="329464445"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 18:39:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="762211564"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="762211564"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 18:39:58 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 4/4] llist.h: Fix parentheses around macro pointer
 parameter use
References: <20230504012914.1797355-1-mathieu.desnoyers@efficios.com>
        <20230504012914.1797355-4-mathieu.desnoyers@efficios.com>
        <87pm7gd4l5.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <8c28baa8-0945-fd77-3d1d-92c99c7bbbd1@efficios.com>
        <CAHk-=wjfgCa-u8h9z+8U7gaKK6PnRCpws1Md9wYSSXywUxoUSA@mail.gmail.com>
Date:   Fri, 05 May 2023 09:38:54 +0800
In-Reply-To: <CAHk-=wjfgCa-u8h9z+8U7gaKK6PnRCpws1Md9wYSSXywUxoUSA@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 4 May 2023 10:16:36 -0700")
Message-ID: <87354bd0b5.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, May 4, 2023 at 7:54=E2=80=AFAM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>> +#define list_prepare_entry(pos, head, member) \
>> +       ((pos) ? : list_entry(head, typeof(*pos), member))
>>
>> So even though the fact that "pos" is used as an lvalue specifically in
>> llist_for_each_entry_safe() makes it so that the parentheses are not
>> strictly required around "pos" in typeof(*pos), I argue that we should
>> still add those for consistency.
>
> Ack. It may not matter in reality because of how 'pos' is supposed to
> be just a local variable name, but I agree that for consistency our
> macros should still follow the usual pattern.
>
> Of course, *because* of how 'pos' is not some random expression, and
> is supposed to be that local variable, and because of how it is used,
> it must always violate the whole "only use once" usual pattern,.
>
> Exactly the same way the member name is also typically used multiple
> times because of how it's not an expression, but really a "part of the
> syntax".
>
> So an alternative might be that we should use a different syntax for
> those things and make it clear that they are not normal expressions.
> Some people use upper-case names for special things like that to make
> them stand out as "not normal" (kind of the same way upper-case macros
> themselves were a warning that they weren't normal and might evaluate
> arguments multiple times).

This sounds a good idea for me.

And with this, I think that we will use typeof(*POS) instead of
typeof(*(pos))?

Best Regards,
Huang, Ying
