Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB55E70D001
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 03:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbjEWBDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 21:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbjEWBCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 21:02:42 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6512E5B
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 18:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684803686; x=1716339686;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=+9pQQnU8oW2SS9zfDiqS0+EStQ/0LzPauo3itGwf9oM=;
  b=l0OakPr+COUlumjqqC4fDbs6HALAJ6vaACqS1J+a/1GKK3CrwVc4jUOg
   3/Lfy073S3tpfpN9y5og/S6VivduuPFjD7QslIbiHvrjXO8lMcUDLWNgp
   OdxZ6OsTWfU1ieP6uJDyHqVC+z77/Vdugy3gyvcGCrBMMfPLaBbCZYh20
   phbb0avbqfwMkwnKK28btpIP0OFQj1L3eq5a4Dkq9SryIlh5NjKdk4ubG
   EHpy6QzMmW97MiS9ANpc5mI3r/2T3msMMXZX4f5VZX2B1KSXcPvfebQgr
   /uiekjxL4hB+zNRMD+UbibPpvIDyd/sCCoMP0aR/DbrmkVAyGFXKKLbKe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="356316326"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="356316326"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 18:01:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="815907679"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="815907679"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 18:01:23 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH -V2 5/5] swap: comments get_swap_device() with usage rule
References: <20230522070905.16773-1-ying.huang@intel.com>
        <20230522070905.16773-6-ying.huang@intel.com>
        <2ad811a6-899d-3be8-2bd3-29ebed3308a8@redhat.com>
Date:   Tue, 23 May 2023 09:00:20 +0800
In-Reply-To: <2ad811a6-899d-3be8-2bd3-29ebed3308a8@redhat.com> (David
        Hildenbrand's message of "Mon, 22 May 2023 14:07:07 +0200")
Message-ID: <87jzwzyi8r.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> On 22.05.23 09:09, Huang Ying wrote:
>> The general rule to use a swap entry is as follows.
>> When we get a swap entry, if there isn't some other way to prevent
>> swapoff, such as page lock for swap cache, page table lock, etc., the
>> swap entry may become invalid because of swapoff.  Then, we need to
>> enclose all swap related functions with get_swap_device() and
>> put_swap_device(), unless the swap functions call
>> get/put_swap_device() by themselves.
>> Add the rule as comments of get_swap_device().
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Minchan Kim <minchan@kernel.org>
>> Cc: Tim Chen <tim.c.chen@linux.intel.com>
>> Cc: Yang Shi <shy828301@gmail.com>
>> Cc: Yu Zhao <yuzhao@google.com>
>> ---
>>   mm/swapfile.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 4dbaea64635d..0c1cb935b2eb 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -1219,6 +1219,13 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
>>   }
>>     /*
>> + * When we get a swap entry, if there isn't some other way to prevent
>> + * swapoff, such as page lock for swap cache, page table lock, etc.,
>
> Again "page lock for swap cache" might be imprecise.

Sure.  Will revise this.

>> + * the swap entry may become invalid because of swapoff.  Then, we
>> + * need to enclose all swap related functions with get_swap_device()
>> + * and put_swap_device(), unless the swap functions call
>> + * get/put_swap_device() by themselves.
>> + *
>>    * Check whether swap entry is valid in the swap device.  If so,
>>    * return pointer to swap_info_struct, and keep the swap entry valid
>>    * via preventing the swap device from being swapoff, until
>> @@ -1227,9 +1234,8 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
>>    * Notice that swapoff or swapoff+swapon can still happen before the
>>    * percpu_ref_tryget_live() in get_swap_device() or after the
>>    * percpu_ref_put() in put_swap_device() if there isn't any other way
>> - * to prevent swapoff, such as page lock, page table lock, etc.  The
>> - * caller must be prepared for that.  For example, the following
>> - * situation is possible.
>> + * to prevent swapoff.  The caller must be prepared for that.  For
>> + * example, the following situation is possible.
>>    *
>>    *   CPU1				CPU2
>>    *   do_swap_page()
>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!

Best Regards,
Huang, Ying
