Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6866A7213
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjCAR3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjCAR3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:29:49 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C533D920;
        Wed,  1 Mar 2023 09:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677691785; x=1709227785;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rcWc02jW/z64c8QF1O3k/i76JZRguQUWSwOkDVaInZE=;
  b=cBO7hsEwoYMREaE3RjjQtGJ44BlKgAimtpChmCIaMU8TXb3+9czHeCbv
   laRYzK0mj/llXXBeoXb9RL7dQJVUuP0qpLyvHV2WEsG0JQ4Ky1GelUwlj
   hXnZs1dtut9sKByBymbnouZWTlsV1aDWq9s+ttqSD3jKk7MaYsSjnbwEm
   nNRU9JPpNvsiqsxo13CfpXbAjtDBFRdYQRzhnsl5hnolXHwYSrPY0Jlqe
   sxI0GGjQJb+3xgY1Iknh9DGgL/bVmpaqc+Cazp/bx9ZTVEAygcPSsSyrX
   eEdtn6QZD/9GJ9zs7znz8/JgHQRWpaNtZKgoUDWDlBt/BtEKc1BsZR4YT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="399258860"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="399258860"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 09:29:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="784423946"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="784423946"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 01 Mar 2023 09:29:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pXQGq-00Dr7s-2u;
        Wed, 01 Mar 2023 19:29:40 +0200
Date:   Wed, 1 Mar 2023 19:29:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 3/3] leds: simatic-ipc-leds-gpio: introduce more
 Kconfig switches
Message-ID: <Y/+LhLH9Vm3WClU5@smile.fi.intel.com>
References: <20230301170215.23382-1-henning.schild@siemens.com>
 <20230301170215.23382-4-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301170215.23382-4-henning.schild@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 06:02:15PM +0100, Henning Schild wrote:
> To describe the dependency chain better and allow for potential
> fine-grained config tuning, introduce Kconfig switch for the individual
> GPIO based drivers.

...

> +obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)			+= simatic-ipc-leds.o
> +obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_APOLLOLAKE)	+= simatic-ipc-leds-gpio-core.o simatic-ipc-leds-gpio-apollolake.o
> +obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_F7188X)		+= simatic-ipc-leds-gpio-core.o simatic-ipc-leds-gpio-f7188x.o

Have you tried the configuration where all three are Y?

-- 
With Best Regards,
Andy Shevchenko


