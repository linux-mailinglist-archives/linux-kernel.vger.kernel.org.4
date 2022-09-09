Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB1C5B399D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiIINtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiIINs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:48:26 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA9F13FA60;
        Fri,  9 Sep 2022 06:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662731290; x=1694267290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gVCktcqq3A41wGPac5aRvOoq0o2bmTIW5G5cmGK/l78=;
  b=U9VeqX+QU2clmMw3rvCgWjhI8QzfSkSqldLPNTUDaBVRyC70QexawvtL
   nRFrz9MK6vHo/+dcYtsVPNBCKWx+h2/WCsZrwps0kgq6Oi7UgjnDNOr7F
   1T6WZOoh/7dqCsglz5p2k7I7YdWiEXBAqsiScxbYm6SeIFaKwVAnVQ9eX
   9fN2V1wCL5iavHs/U3rPA3DIVBL8YTGzIgiDwfocPROcG8cPjkCrONNHt
   gFzK4qbByCDFmJxUI6wu5D4vWazhuQA8w0Bs52gFVcmSS4t0qH6Mkf+iu
   4B9fLcVyhDOmHWc2MLfsIC2ONGzqHFUgpev0Uw9N7C+mer9AmlsgBbJRX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="277864920"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="277864920"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 06:48:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="566371587"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 06:48:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oWeMW-00AaAX-2Q;
        Fri, 09 Sep 2022 16:48:04 +0300
Date:   Fri, 9 Sep 2022 16:48:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kees Cook <keescook@chromium.org>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] gpiolib: cdev: export the consumer's PID
Message-ID: <YxtEFNdgzmpbN94s@smile.fi.intel.com>
References: <20220909121329.42004-1-brgl@bgdev.pl>
 <20220909121329.42004-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909121329.42004-3-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Kees

On Fri, Sep 09, 2022 at 02:13:29PM +0200, Bartosz Golaszewski wrote:
> It's useful for user-space to be able to know the PIDs of processes
> holding GPIO lines in case they have the permissions and need to kill
> them.
> 
> Extend the gpio_v2_line_info structure with the consumer_pid field
> that's set to the PID of the user-space process or 0 if the user lives
> in the kernel.

I'm wondering if there is any security implications and this PID
can be abused.

-- 
With Best Regards,
Andy Shevchenko


