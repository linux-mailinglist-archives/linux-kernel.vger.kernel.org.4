Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D25F622ED7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbiKIPPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbiKIPPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:15:07 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043661115B;
        Wed,  9 Nov 2022 07:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668006907; x=1699542907;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1hotSbJr/nzsHTXdw6IvBY9ZABhKC6mYa3ikm0iprvY=;
  b=O+h8wNYOasqTmt4xXPzBt+fdKH2liZZwP6S+9Wt4Jbq1tAOPHlOwM/8w
   k+eHAuhbxt8MObRpPoD+NVAvxjqKsD6rwbVbBfdTpaE2Z0jtJPGi8g/9D
   uSEXagh3a6PT1KbokZYh7oh4NWngTiPtIh2yBGTTVJAySrJFMW3BSKMn+
   baLiu1mETabUyrX6xs5UNl5vneqIXpGYtIBTCy38rZrDN242QhcCOWRFx
   8VxsfD/YDfchmeNAyAOpcBEfqpKkwD40VXll+MFpFjFSQEZW5omPp0mhT
   /C6AmsymhlwPr7qJCLjlR8CyN/Psp03gplXAPKmTvaF+EG6nB1XIMOJlV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="310996457"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="310996457"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 07:15:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="587794946"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="587794946"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 09 Nov 2022 07:14:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1osmmq-009ngV-0V;
        Wed, 09 Nov 2022 17:14:44 +0200
Date:   Wed, 9 Nov 2022 17:14:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raul E Rangel <rrangel@chromium.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/2] gpiolib: of: Drop redundant check in
 of_mm_gpiochip_remove()
Message-ID: <Y2vD49wJkKFw72tS@smile.fi.intel.com>
References: <20221109150706.38823-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109150706.38823-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 05:07:05PM +0200, Andy Shevchenko wrote:
> The callers never call the function with invalid pointer.
> Moreover, compiler quite likely dropped that check anyway
> because we use that pointer before the check.

Please, ignore this series, it was wrong offset to send the patches from.

-- 
With Best Regards,
Andy Shevchenko


