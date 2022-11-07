Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C166200FC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbiKGVWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbiKGVVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:21:41 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB2EBCF;
        Mon,  7 Nov 2022 13:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667856089; x=1699392089;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5qdxNzZFFPxw/vRd+4fWoBOGKdBZw3qOat5DzlreYOA=;
  b=OGiZa9B6C+LumXSaGdaNvq1hBt+O0ub8zwpsf5VVyer7BDJFnBLDBDWX
   eSiyPJgFk7v7iyRX5chtg7R63L+fo1bMNnzzSwBT46ncq3hZ0n1qH+Sc3
   o2nRt0CHdX2H2oYXoIabmbL9BmXgdb/IPGVjrRKTPb3UgD9NNKBPujtR7
   zM8QXBg1gAAmBxwYSZeBUWP83QHaHzfac2CxMjJF3qHma8FdQCRk2kTIX
   8v9T6OQhRRA4WAH2GN1Kjr6cPvmGLLUn8fm/U2QGRS3ivXeu+6xa5AJfv
   wqTBNmaxlK6oSFczJbu9Fs18mHRwUYrAfpSFYpnd122h/LUZj6DsbBSv4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="298040827"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="298040827"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 13:21:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="669295787"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="669295787"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 07 Nov 2022 13:21:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1os9Ya-008q4G-2M;
        Mon, 07 Nov 2022 23:21:24 +0200
Date:   Mon, 7 Nov 2022 23:21:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH v1 4/5] rtc: rtc-cmos: Rename ACPI-related functions
Message-ID: <Y2l21CkXvm7mkONq@smile.fi.intel.com>
References: <2276401.ElGaqSPkdT@kreacher>
 <8155359.T7Z3S40VBb@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8155359.T7Z3S40VBb@kreacher>
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

On Mon, Nov 07, 2022 at 09:01:50PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The names of rtc_wake_setup() and cmos_wake_setup() don't indicate
> that these functions are ACPI-related, which is the case, and the
> former doesn't really reflect the role of the function.
> 
> Rename them to acpi_rtc_event_setup() and cmos_acpi_wake_setup(),
> respectively, to address this shortcoming.

Hmm... I'm not sure I understand why in one case acpi is a prefix and
in the other is kinda mid-suffix?

-- 
With Best Regards,
Andy Shevchenko


