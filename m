Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65772722B10
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjFEPaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbjFEPaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:30:03 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1EC11C;
        Mon,  5 Jun 2023 08:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685978983; x=1717514983;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d9rVvy5CotAWYIHjMrNNPtd2nzg6OYMYLcPx+mqWw7o=;
  b=Qpe+DUs27+ymBQ7y8/MhEDOQgTEIgfmWZJDQBQKSkaBLMxdY59C0u6fz
   tpglFzTtFI+1IlweGYKbdtas5lzqctm3qQo20Ga6CgMgOPwdtX978M5uF
   xtd368/sM5SmKOeXi46cmC+bKAsR4NwbvZEdlSJYKhOJ0dbIMKESMwyRP
   XN4lSaEWHIGkf3ZZkhhBTDv0LyE1TqKsflHoHTq9QBFgeTjmdznrt/g8m
   3ih/APJyegPFxVzQPgi6cJeXANkF1zez6gw6903aLFElxkAKsRxtOCGQb
   3TKTVctjcj2GC8Kbyi6BgnDxcPXW57GL8dP7Gzx0zfixrUEPmGATYYnTm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="359708745"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="359708745"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 08:29:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="832847857"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="832847857"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 05 Jun 2023 08:29:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q6C9M-001PDX-25;
        Mon, 05 Jun 2023 18:29:40 +0300
Date:   Mon, 5 Jun 2023 18:29:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: add Andy Shevchenko as reviewer for the
 GPIO subsystem
Message-ID: <ZH3/ZBk8QJRUh9Hv@smile.fi.intel.com>
References: <20230605151015.564547-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605151015.564547-1-brgl@bgdev.pl>
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

On Mon, Jun 05, 2023 at 05:10:15PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Andy has been a de-facto reviewer for all things GPIO for a long time so
> let's make it official.

Please, use my kernel.org, with that addressed

Acked-by: Andy Shevchenko <andy@kernel.org>

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7e0b87d5aa2e..62e33c4da40a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8799,6 +8799,7 @@ F:	include/linux/gpio/regmap.h
>  GPIO SUBSYSTEM
>  M:	Linus Walleij <linus.walleij@linaro.org>
>  M:	Bartosz Golaszewski <brgl@bgdev.pl>
> +R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>  L:	linux-gpio@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
> -- 
> 2.39.2
> 

-- 
With Best Regards,
Andy Shevchenko


