Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A18680DCE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbjA3MgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236284AbjA3Mf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:35:59 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95AA4EDF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675082158; x=1706618158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R8m8Daj8DLw7fbozGOxSYGqaZ1lMYeutU3qJd2Iks1Q=;
  b=XlvpcVzyuzQbjwN1vGHcW38c0MqEpi8kUw5LD6XxfYkJy9upPOnP8z/l
   n3pmuBynBCUT04G1J18KlQNagfGOCwlTNkiueWr8hAtWY3raCPP5hRpe8
   b4Yn5eK7pyZZHQ368hfrQRq6ed351zDZtky1wPbZxAzoXMjViOCcVP6TG
   VOQYTYt6cHW+dB70875oKeihXyj5WN4bvXxCKMQpvDXlDJLtrgPpaYYmK
   ftnMbfBrYgtZiiFsgnLu0JAvlPdZTO9E7Xb1ob3USBqHNF7bD7Fzy52lT
   zmtSSTb8v/qZu1xfmM+rlEp+SJ0MMM8mjJKTkMKQOicrX2OQG0G3+06VU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="392093336"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="392093336"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 04:35:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="732684302"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="732684302"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jan 2023 04:35:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pMTO4-00HLbR-30;
        Mon, 30 Jan 2023 14:35:52 +0200
Date:   Mon, 30 Jan 2023 14:35:52 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew WilCox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable v4 1/3] mmflags.h: use less error prone
 method to define pageflag_names
Message-ID: <Y9e5qD2whT3+xDMD@smile.fi.intel.com>
References: <20230130042514.2418-1-42.hyeyoo@gmail.com>
 <20230130042514.2418-2-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130042514.2418-2-42.hyeyoo@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 01:25:12PM +0900, Hyeonggon Yoo wrote:
> As suggested by Andy Shevchenko, use helper macro to decrease chances
> of typo when defining pageflag_names.

Suggested-by: ? :-)

> Link: https://lore.kernel.org/lkml/Y6AycLbpjVzXM5I9@smile.fi.intel.com
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

LGTM, thank you!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


