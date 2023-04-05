Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660B66D7695
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbjDEINZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237408AbjDEINW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:13:22 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80275266
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 01:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680682392; x=1712218392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mq68ZNcfWlwRVPi9xcnXlQ/r2Y4aVx4IrxzoW4tm+Do=;
  b=b/C1sWthN8pqGUZYC68UshdHVNz847E/mrbeJX6kCGrrNf7Xkygloc5u
   NZViEtziI045xFRdBq1V6GEvLYFQanPMfA+w6fmhiizNAcsXhZIl6/sHK
   2CAFtsMZijvrBynoqZXZSAMvCMgxe8sDkgmoFE0L4O7eRSVC6wTI97ory
   ThZ+RNGfteZ4fCSKLUdMWmE0zEQNmgtS33sXRKefKKwTmN/Va0ln4g5Dc
   GQajb8L/e6ha1OnCrlxWQX3PEP2Xb++ODVF7bepSlsmVVBeAdQCja9ieg
   AW9RjoO58bwYwnrVWymu7DV6C3kvnvpYv3SAt6z/yNo8OcCNC6CbuS2mM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="326431323"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="326431323"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 01:12:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="797825638"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="797825638"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 05 Apr 2023 01:12:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pjyFi-00CkHi-1O;
        Wed, 05 Apr 2023 11:12:22 +0300
Date:   Wed, 5 Apr 2023 11:12:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Bumwoo Lee <bw365.lee@samsung.com>, linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v1 00/14] extcon: Core cleanups and documentation fixes
Message-ID: <ZC0tZt2nyc83AI6j@smile.fi.intel.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
 <60b019dc-ea62-0c63-983e-cc1918bfe419@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60b019dc-ea62-0c63-983e-cc1918bfe419@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 10:58:20PM +0900, Chanwoo Choi wrote:
> Hi,
> 
> I recommend that use the "./scripts/get_maintainer.pl" script
> to get the accurate maintainer list to send the patches.

That's what I'm using. What's wrong in your opinion with the Cc and/or To
lists?

> On 23. 3. 22. 23:39, Andy Shevchenko wrote:
> > A few fixes to the documentation and some cleanups against extcon core
> > module.
> > 
> > Andy Shevchenko (14):
> >   extcon: Fix kernel doc of property fields to avoid warnings
> >   extcon: Fix kernel doc of property capability fields to avoid warnings
> >   extcon: Use DECLARE_BITMAP() to declare bit arrays
> >   extcon: use sysfs_emit() to instead of sprintf()
> >   extcon: Amend kernel documentation of struct extcon_dev
> >   extcon: Allow name to be assigned outside of the framework
> >   extcon: Use unique number for the extcon device ID
> >   extcon: Switch to use kasprintf_strarray()
> >   extcon: Use device_match_of_node() helper
> >   extcon: use dev_of_node(dev) instead of dev->of_node
> >   extcon: Remove dup device name in the message and unneeded error check
> >   extcon: Use sizeof(*pointer) instead of sizeof(type)
> >   extcon: Drop unneeded assignments
> >   extcon: Use positive conditional in ternary operator

-- 
With Best Regards,
Andy Shevchenko


