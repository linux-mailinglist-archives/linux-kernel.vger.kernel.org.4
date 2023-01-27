Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1895967E18E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjA0KZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjA0KZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:25:23 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D475222ED
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674815123; x=1706351123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hdVVHjMgGHjQbEVmb1sxvdkTviUVd9ZjYc0zyiaLVCQ=;
  b=hAQwCBk9aGVWXosxiU91//lsX+N1r+un/u0D44jQZrLRm530qC4Ce3af
   rsNvG4qy/GDgHNrYVq/H44mZ5nVXYty7LbeIFoBJaEths2ZusGBrzG0u7
   YhxewEPQ64BuIcjd8fKdBPTgkWQ43MtC1EcKYFwjlpmMH9hbmJMuY5HP+
   hqrEFYiK0ynX5M6EAXYbrRtbjAuJmMpDYu+nbx12yYJI96NFbDYW2Myw7
   rJXVGAl5JX/pyv1sQscTdG7nk2pbybIQCFNN16fRuP23co/ZxSKAxUQr6
   J0aiaX2xnSk6iSGCRxfmGRtoOPOC2EBW8RX2WXnPAIx3jTSbys9t02t4K
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="413282302"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="413282302"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 02:24:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="693666438"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="693666438"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 27 Jan 2023 02:24:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pLLuZ-00Fuhb-2j;
        Fri, 27 Jan 2023 12:24:47 +0200
Date:   Fri, 27 Jan 2023 12:24:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] vdso/bits.h: Add BIT_ULL() for the sake of
 consistency
Message-ID: <Y9Omb/OG4zjp/Xqq@smile.fi.intel.com>
References: <20221128141003.77929-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128141003.77929-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 04:10:03PM +0200, Andy Shevchenko wrote:
> While the minimization is a good thing, the split added some
> inconsistency since BIT() and BIT_ULL() defined in the different
> files and confuses unprepared reader. Let's move BIT_ULL()
> to vdso/bits.h, so they will go together (as UL(), ULL() and
> so on).

Any comments on this?

-- 
With Best Regards,
Andy Shevchenko


