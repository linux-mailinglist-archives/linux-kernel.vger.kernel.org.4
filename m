Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C67730347
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343649AbjFNPRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343675AbjFNPRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:17:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F21C3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686755802; x=1718291802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ji+I7IN8dAKMbYX1GKKqZYcqdgh0ESdxQ9z1DaZT2SA=;
  b=dltxq8orM9c1YdjTgXKo9SDadmQ+Hhg5reVlmBH5ivR3LUxBb03Dti4r
   BpGCCqmg6ZH2tpp2TCzlObwnJ1wageI3M/dnUgIsC/Gj0JwcE/wkr1ukS
   sIm5bVHUE6l45py+pXTWe7Q3YwcQkAAC0QpXcXR9342L93AsD5yW9chOv
   FHuL8Xj/LdPVO9ZkUaX4IGUjd0iVj5FeDnA89gBB/ElnMziSvsGxQIfLb
   aL/BezBXh9HINURwKiQkj5ZqmOLablb0f1yMv+j78aAmfGEhGpmtnslF7
   X8GOKh4CDGLZP66lAqfCGfkw+5dpqNUhPlj46LQjAK3Ghc1CXihavn2TY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="424525785"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="424525785"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 08:16:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="801948400"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="801948400"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jun 2023 08:16:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q9SEe-003j9E-3D;
        Wed, 14 Jun 2023 18:16:36 +0300
Date:   Wed, 14 Jun 2023 18:16:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     hexingwei001@208suo.com, pmladek@suse.com,
        senozhatsky@chromium.org, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH] lib/test_printf.c: space required after that ','
Message-ID: <ZInZ1BcHHQbok+wg@smile.fi.intel.com>
References: <20230614082523.63191-1-panzhiai@cdjrlc.com>
 <f2d8eb955890bc1db1b307db713d4a4a@208suo.com>
 <ZImzXhc7ZRbSvz7/@smile.fi.intel.com>
 <20230614110640.57817123@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614110640.57817123@gandalf.local.home>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 11:06:40AM -0400, Steven Rostedt wrote:
> On Wed, 14 Jun 2023 15:32:30 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Jun 14, 2023 at 04:30:55PM +0800, hexingwei001@208suo.com wrote:
> > > Add missing spaces to clear checkpatch errors:
> > > 
> > > lib/test_printf.c:562: ERROR: space required after that ',' (ctx:VxV).
> > > lib/test_printf.c:562: ERROR: space required after that ',' (ctx:VxV).
> > > lib/test_printf.c:562: ERROR: space required after that ',' (ctx:VxV).
> > > lib/test_printf.c:562: ERROR: space required after that ',' (ctx:VxV).
> > > lib/test_printf.c:562: ERROR: space required after that ',' (ctx:VxV).
> > > lib/test_printf.c:562: ERROR: space required after that ',' (ctx:VxV).  
> > 
> > Doesn't make any difference to the code, so let do this (unneeded) churn
> > to calm checkpatch down.
> > 
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> checkpatch is for patches (new code) and should not be run on existing code.

Why does it have -f option? What do you propose to prevent people from using it?

-- 
With Best Regards,
Andy Shevchenko


