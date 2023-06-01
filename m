Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD2771EFCA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjFAQzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjFAQyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:54:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA035184;
        Thu,  1 Jun 2023 09:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685638476; x=1717174476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y3OXikTBBtZHE3RPTvUzqE43nGv8HkEr6v9IPew24JA=;
  b=jbpQakByfstQ0qhSE+0jLN6kejzT999ty8xXmTLb0ZDHiyaZnAicARb9
   OJDpwylkCj7vdSLg/l+V0vYQphlMr1uCjk/LrgIU1gwcKEZbTH10ZH62b
   C0x8a/595lSbmKtpeCwBda2X70UEucf56rG/EuMzPiNsdNVIG79/s5Ag5
   UiKW4mbsP/JHz5lkQg1frHWmhb8PLkajOY4iIAB84fz1s0s5UXGMrojs2
   wL5KrXA6zG707CmqAi64TI6lkDoUT4LIw0BeDlOuipSviNfHVDKNmDn2A
   qYqHNSHu27ReySPg7rXzV57UDKNYai+TVCgw4XDvRexSwR0Iy1mOJXjGr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="421427874"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="421427874"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 09:54:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="777283806"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="777283806"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 01 Jun 2023 09:54:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q4lZI-000Sql-04;
        Thu, 01 Jun 2023 19:54:32 +0300
Date:   Thu, 1 Jun 2023 19:54:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 28/43] input: keypad: ep93xx: add DT support for
 Cirrus EP93xx
Message-ID: <ZHjNR1n6tZbTAJWS@smile.fi.intel.com>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601054549.10843-10-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601054549.10843-10-nikita.shubin@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 08:45:33AM +0300, Nikita Shubin wrote:
> - get keymap from the device tree
> - find register range from the device tree
> - get interrupts from device tree

...

> +/* flags for the ep93xx_keypad driver */
> +#define EP93XX_KEYPAD_DISABLE_3_KEY	(1<<0)	/* disable 3-key reset */
> +#define EP93XX_KEYPAD_DIAG_MODE		(1<<1)	/* diagnostic mode */
> +#define EP93XX_KEYPAD_BACK_DRIVE	(1<<2)	/* back driving mode */
> +#define EP93XX_KEYPAD_TEST_MODE		(1<<3)	/* scan only column 0 */
> +#define EP93XX_KEYPAD_AUTOREPEAT	(1<<4)	/* enable key autorepeat */

> +static int ep93xx_keypad_flags;
> +module_param(ep93xx_keypad_flags, int, 0);
> +MODULE_PARM_DESC(ep93xx_keypad_flags, "EP93XX keypad flags.");

Why? This pretty much looks like missing DT description.

Please, write your commit message better, so we can understand the point of
such decisions w/o asking.

-- 
With Best Regards,
Andy Shevchenko


