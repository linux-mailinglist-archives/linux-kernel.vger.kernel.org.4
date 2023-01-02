Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F266965B6D6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 20:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbjABTDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 14:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbjABTDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 14:03:41 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545DB2E8;
        Mon,  2 Jan 2023 11:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672686220; x=1704222220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pyI34WZWoEAvbem9Lowb4SJjy41nelaB3VNO5D7GCmg=;
  b=AqD4zJ98o8IyVqB3B5bZwclJplZa4L3KLGPzuGlR3kCjSOkddV/UoAD6
   kkqBu5QHMhNCxvSF+Ev9tqmJKBbeOmz/nCvF1gjA4TlWojxlVr0N7U63L
   QTh/LSgN/x+RIBBfmNzr4jjJkVh/6ruxa3H4NuzpPhLNTQuWDLY9xEBMW
   EUN7bPuX9ibATWwyuNZ+Xt9rdCTWFUkulAF0WKtAWg9DnQo8QPqUIuWCs
   PHcqjt9rFs2aFdUNB6b24PHZf3qHq1HzjTLnkGM9z35l3rsjlp2c3qPL4
   h6pAQblgu+DU2vHcYXzxi/piJr8ooZ6Hq2HQAMCLY2XqHdWdnkUMS6PO7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="305037897"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="305037897"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 11:03:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="778636086"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="778636086"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 02 Jan 2023 11:03:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pCQ5u-003Yl2-1g;
        Mon, 02 Jan 2023 21:03:34 +0200
Date:   Mon, 2 Jan 2023 21:03:34 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: add kernel-doc comment for u64_to_user_ptr
Message-ID: <Y7MqhtPMYI4e50dY@smile.fi.intel.com>
References: <20230102184349.10399-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230102184349.10399-1-federico.vaga@vaga.pv.it>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 07:43:49PM +0100, Federico Vaga wrote:
> Add a kernel-doc comment in kernel.h to document the macro
> `u64_to_user_ptr`.

We refer functions as func(), so `u64_to_user_ptr` --> u64_to_user_ptr().

> As of today, this macro is mentioned in the documentation in
> 'ioctl.rst' and 'botching-up-ioctls.rst'

Missing period at the end.

...

> +/**
> + * u64_to_user_ptr - convert an unsigned 64bit number into a user pointer

64-bit

> + * @x: the number to convert

Isn't 'number' is a bit misleading here?
It decodes the user pointer, that is encoded into unsigned 64-bit value.
Unfortunately I am not a native speaker, I can't propose anything better.
It might be that the 'number' is quite good choice, dunno.

> + */

-- 
With Best Regards,
Andy Shevchenko


