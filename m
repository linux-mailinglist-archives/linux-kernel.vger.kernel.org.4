Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2177D616131
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 11:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiKBKsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 06:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKBKsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 06:48:02 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DAF205C4;
        Wed,  2 Nov 2022 03:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667386081; x=1698922081;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5HpjhhA0R1oJOP96S1an4MPyb9380u4PF3dy8awj8RQ=;
  b=ijiW8mxVW5SzORUdMCLasCsFV2RDkeBgm5LnbBxXMeQ1yj+ngA8Pt8cA
   iBz8UoCyMCUp4Oqlb9Hl21Anv/lPB0iC3/mZndMXO5r0hEDsFXzbrGtR7
   N6M2GABvhITprO1G8r3Er3KZHteYECexNrfchZcqVIUM13+DZIZg4xKDL
   mSGjO2XxcOrdqzlCGQuhlgKHWUQ8BAeLLMBgyjF/Av5/UKr1pciPxrIm8
   MNOixaJvljvbkOhJ5AwuHEeGOPbUuWddyhjzb89e1kKjLpO7AcQWk6Wr7
   5KxWSA5nTL2HecgekYFHizSJ45vwlcH0VuZN5eRHHkC4va4lEQ3gflKKv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="371464162"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="371464162"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 03:46:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="809236359"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="809236359"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 02 Nov 2022 03:46:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oqBGl-0068SS-2s;
        Wed, 02 Nov 2022 12:46:51 +0200
Date:   Wed, 2 Nov 2022 12:46:51 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        srinivas.pandruvada@intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] platform/x86/intel/sdsi: Add meter certificate
 support
Message-ID: <Y2JKm/TPgVAku93M@smile.fi.intel.com>
References: <20221101191023.4150315-1-david.e.box@linux.intel.com>
 <20221101191023.4150315-5-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101191023.4150315-5-david.e.box@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 12:10:18PM -0700, David E. Box wrote:
> Add support for reading the meter certificate from Intel On Demand
> hardware.  The meter certificate [1] is used to access the utilization
> metrics of enabled features in support of the Intel On Demand consumption
> model. Similar to the state certificate, the meter certificate is read by
> mailbox command.
> 
> [1] https://github.com/intel-sandbox/debox1.intel_sdsi/blob/gnr-review/meter-certificate.rst

Link: tag?

...

>  static BIN_ATTR(state_certificate, 0400, state_certificate_read, NULL, SDSI_SIZE_READ_MSG);

BIN_ATTR_ADMiN_RO() ?

...

> +static BIN_ATTR(meter_certificate, 0400, meter_certificate_read, NULL, SDSI_SIZE_READ_MSG);

Ditto.

-- 
With Best Regards,
Andy Shevchenko


