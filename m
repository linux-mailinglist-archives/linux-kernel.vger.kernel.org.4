Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D17673D0A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 16:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjASPFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 10:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjASPFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:05:34 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAF749563;
        Thu, 19 Jan 2023 07:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674140733; x=1705676733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2XzCvvvcgRU14LYR/jiEydPULCw8Bq1F4wFkrSrQlZ8=;
  b=ZWxOG+tAaiplyt8NwNYMIMYDRe52VefcjqYB7c1CWJ0/rUoPp1mVhI7D
   uFIWcp3K8WNQuW0L/lfwoguAQM8r8UMWhdKQPazuFmbAfoGXGHoLQ4sQT
   pRujWOjxc/5npMu9zbXSoTqIDBq+PuskzyKWArf4RrbmGahfSQ6AZMtPi
   YX/pEoy4Lqi+HqKOfExTlaFQ6PeKdKFul+rCmRSXR8DmuOCwDhwVyYRCA
   hWy84vbR7kEWJwCPQdZvfMG4GUArrvvRBSbj5DYUhpHU1vIMf7C+mCP9j
   cfOFNSY79+dl3izE4sdajz4ezBeAPLagp2qs2TtCblp1Up+eBECIB8TCN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="313195305"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="313195305"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 06:37:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="723512781"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="723512781"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jan 2023 06:37:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pIW2S-00BhyK-1D;
        Thu, 19 Jan 2023 16:37:12 +0200
Date:   Thu, 19 Jan 2023 16:37:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] usb: acpi: Switch to use acpi_evaluate_dsm_typed()
Message-ID: <Y8lVmOL5T2EUVkgr@smile.fi.intel.com>
References: <20230118080419.20880-1-andriy.shevchenko@linux.intel.com>
 <Y8lBczJAXR4Hjl93@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8lBczJAXR4Hjl93@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 02:11:15PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Jan 18, 2023 at 10:04:19AM +0200, Andy Shevchenko wrote:
> > The acpi_evaluate_dsm_typed() provides a way to check the type of the
> > object evaluated by _DSM call. Use it instead of open coded variant.

...

> Fails to apply to my tree :(

It seems it's against usb-linus as Mathias' original patch is there.

-- 
With Best Regards,
Andy Shevchenko


