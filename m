Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C74622ED9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiKIPQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbiKIPQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:16:37 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFED1B9D6;
        Wed,  9 Nov 2022 07:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668006997; x=1699542997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KY4b7NsDoGsL4SL3fvQGjKv30lEJ6m9IU4VcQT450oQ=;
  b=DBPXyWSTBf6FH6FY5+vucJ+pi4o26kfXbRSfWAF8aXDzA4BXjlnN1zNw
   hxpTZSoVup3hBpgw0ajFbCEWXMbIC4kzLuNT9wf7M/6cjckCGbCZVf5LR
   Zrk9+CIOpa71t/xJSa61PJ0qLQ/93wkJfJec7ben2FUCxdh2WNH4MnnHr
   vh14GjRooQcDNO0i+O1lg0H3GOYVZDlqOXKnoRqaLqrp8FTb5OSgxjon5
   95omgE+EE9HtZvKV5XxBzVP1outtg4NHPe9LFC3sskXKNo0kYN5JVA3Hp
   KoilHAVuV8ZIJAItthGUZkiFmvb8kIhtv4PBDIeaqgV5LSFmlx4KVBrhD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="312162763"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="312162763"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 07:16:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="811663069"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="811663069"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 09 Nov 2022 07:16:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1osmob-009nj3-16;
        Wed, 09 Nov 2022 17:16:33 +0200
Date:   Wed, 9 Nov 2022 17:16:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/2] gpiolib: of: Prepare of_mm_gpiochip_add_data()
 for fwnode
Message-ID: <Y2vEUflUsama81aF@smile.fi.intel.com>
References: <20221109150734.38874-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109150734.38874-1-andriy.shevchenko@linux.intel.com>
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

On Wed, Nov 09, 2022 at 05:07:33PM +0200, Andy Shevchenko wrote:
> GPIO library is getting rid of of_node, fwnode should be utilized instead.
> Prepare of_mm_gpiochip_add_data() for fwnode.

I believe this is the last preparatory patch to get rid of of_node from
GPIO chip data structure.

After rc1 I will send that clean up and it would be nice to start next cycle
of_node free.

-- 
With Best Regards,
Andy Shevchenko


