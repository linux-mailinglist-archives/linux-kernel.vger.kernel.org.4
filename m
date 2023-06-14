Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603807304CC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjFNQVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjFNQVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:21:03 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3393FED;
        Wed, 14 Jun 2023 09:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686759662; x=1718295662;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ujj+LC2NWuOH1ScXla01RImuDgdOMSBH6AvYcKggIWE=;
  b=TR+7oV96K6i7ScVAAEzqSHWlL23hRx931+VISi7azfopfyj3/WgLBg4d
   ZsUO+V1st1ReVI2sPng9c6XJxiuMh+oBq6+TZXeZQD0yfjIL+EBiB4EC5
   H/C6QOx/wSZTFZgNvC5OqJMApB7Zs+ydFDZ5va0Odu/zmjYwFe1b9p+Ne
   Lpc04ArbaeyeZjvl8vhN00WAu49WeBnQOekz5FiOO+nIFc55aNV47Z4Fu
   mHZCmY7sIFB3wmq+dbWR5KbJIjz38vHvCW1Bokj4kORv+bpenlrsFrznI
   N7PNW1vwkddwcdswiabgSbK5cYlMVstmi9AfEln32OSBsJPz5nNjVcAUn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="362035606"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="362035606"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 09:20:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="712117456"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="712117456"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 14 Jun 2023 09:20:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q9TEO-003jnU-05;
        Wed, 14 Jun 2023 19:20:24 +0300
Date:   Wed, 14 Jun 2023 19:20:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
Subject: Re: [PATCH v3 1/3] pinctrl: intel: refine ->set_mux() hook
Message-ID: <ZInox22WohL8GW8B@smile.fi.intel.com>
References: <20230613085054.10976-1-raag.jadav@intel.com>
 <20230613085054.10976-2-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613085054.10976-2-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 02:20:52PM +0530, Raag Jadav wrote:
> Utilize a temporary variable for common shift operation in
> ->set_mux() hook and improve readability while saving a few bytes.
> 
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-3 (-3)
> Function                                     old     new   delta
> intel_pinmux_set_mux                         245     242      -3
> Total: Before=10472, After=10469, chg -0.03%

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


