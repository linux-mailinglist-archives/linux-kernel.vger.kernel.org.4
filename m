Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA4F750D15
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjGLPvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjGLPu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:50:57 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6831BD5;
        Wed, 12 Jul 2023 08:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689177057; x=1720713057;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DO1jx8gq45K+lI5vmJb/SxuQtrYbjySZEsUCQY2iMPc=;
  b=DSJxK5a6tJ0u/44UChisUcAEnXPL5KddIm+DLw/rNaZGlAkPUghrehkr
   LxCWW+xNC9r0ajQN4Q3JsKwBIpxMsY8tYk4PLc0I1utL2IGrcd9csZtvX
   Hd+yYT7M/+eV25AzMaCiSgOFqVzZ+Iua8idSBlUhbRGAGMA4sxTJak96W
   3F0uRoz4Hi3VYwWrYBm8EZKO5MVo6k1eXEmZ1rkVlMcqHYjaC2LU3Gbgo
   r5XjYI7KMb8m80D91ZsxMVFEGl/9p9vYEsSlS80GWWW2BJ5OknNz3gOvD
   095+z7WkgEL1BzQgb0WnKb8L1e3Incn2kuaVplcebOnyCco/3TqlgPxfC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="345238299"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="345238299"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 08:50:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="845703363"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="845703363"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 12 Jul 2023 08:50:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJc7B-002AXE-0V;
        Wed, 12 Jul 2023 18:50:53 +0300
Date:   Wed, 12 Jul 2023 18:50:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpio: sim: fix a typo in comment
Message-ID: <ZK7L3P+U/Q9kWnA9@smile.fi.intel.com>
References: <20230712100105.105889-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712100105.105889-1-brgl@bgdev.pl>
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

On Wed, Jul 12, 2023 at 12:01:05PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> It was supposed to say 'for' not 'fo'.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Perhaps you can you run codespell and fix all problematic places at once?

-- 
With Best Regards,
Andy Shevchenko


