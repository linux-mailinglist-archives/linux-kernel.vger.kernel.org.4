Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22D069E1BB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 14:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbjBUNxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 08:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbjBUNxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 08:53:12 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0E9E8;
        Tue, 21 Feb 2023 05:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676987583; x=1708523583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2xPlTavFfZ97MjWSJqsZMA+1oMZ5WzJsq+Zpa6ySKRo=;
  b=C1Vuv6k5WORtX1kcGYbLQLfITI8Aj8tm5H8Jpnx5cTBvXo4UjG9EhSPg
   kvh43BYK5hnxYqwTtFvY/CkAQjv61PcOUEcO/6zW4jVyB+92Fgc8v0Fgn
   WuWoODjpeQm9xOGsNOUMLdaHHU04y96XhkX5sk9BgyynCVWplIQXAd0wl
   TjK7ShzIDph0GsW79xqyhFgn4HH4/WCLmZRX1Hy027O7pimnizewBgYp/
   vs59Qvgd/IVwOfShGz26fugC4PQuPf1JOSQQqhN7nanO98+jxEqlHp3vC
   jHUftiNaQKju/2EmcQ6b6HyDOYlgdTrXRDcwgyIKddlwOmIy79SifoFhv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="397320948"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="397320948"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 05:52:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="702013401"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="702013401"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 21 Feb 2023 05:52:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pUT4f-009ySF-0c;
        Tue, 21 Feb 2023 15:52:53 +0200
Date:   Tue, 21 Feb 2023 15:52:52 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 3/3] leds: simatic-ipc-leds-gpio: introduce more Kconfig
 switches
Message-ID: <Y/TMtA2l+HWHwaEb@smile.fi.intel.com>
References: <20230221122414.24874-1-henning.schild@siemens.com>
 <20230221122414.24874-4-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221122414.24874-4-henning.schild@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 01:24:14PM +0100, Henning Schild wrote:
> To describe the dependency chain better and allow for potential
> fine-grained config tuning, introduce Kconfig switch for the individual
> gpio based drivers.

GPIO

...

> +	tristate "LED driver for Siemens Simatic IPCs based on Intel apollolake GPIO"

Apollo Lake

-- 
With Best Regards,
Andy Shevchenko


