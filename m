Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78774749896
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 11:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjGFJeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 05:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjGFJeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 05:34:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EA4110;
        Thu,  6 Jul 2023 02:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688636056; x=1720172056;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dvfmZXtYFApI5inomsqgP7DCRJAHRNZIFblj9dnAczU=;
  b=mE13QT2gk2GRAcStfLZyAAxs2sJMJGWesZ1Io79o3nuvi+gAbXrej3Sx
   QL8x445OQDpZrUti1/rshmDpj47kZqdN6ZdR97BQRllcYhVBudM45rlRt
   dY0qKesJrR4PfDTZt7NV25yK1BzemAPxzTT6YHJ76U3oKxGFS6qnU7aK8
   Or9gV0c87dF2wJO94foCbqz/ReUmkQCMqc5+VRZBhk1Tt7kZJVhlotDxi
   VdHTG9jmm3Ml9a47B0UH41OgHsFKH7g2F9CmToA6kjxfE0nDH3WjnhGGn
   EWPxFDXkCOhpaBz7ERxpyCdr+MWvq5+V3yA2DQGIJnzRo6a83HkJLlH1K
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="367044694"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="367044694"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 02:34:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="713493753"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="713493753"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 06 Jul 2023 02:34:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qHLNM-000TyZ-2C;
        Thu, 06 Jul 2023 12:34:12 +0300
Date:   Thu, 6 Jul 2023 12:34:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpiolib: add missing include
Message-ID: <ZKaKlABvtGGA/K2V@smile.fi.intel.com>
References: <20230705074219.8321-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705074219.8321-1-brgl@bgdev.pl>
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

On Wed, Jul 05, 2023 at 09:42:19AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> gpiolib.h uses notifiers but doesn't include <linux/notifier.h>.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpiolib.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
> index cca81375f127..1409d52487c0 100644
> --- a/drivers/gpio/gpiolib.h
> +++ b/drivers/gpio/gpiolib.h
> @@ -14,6 +14,7 @@
>  #include <linux/err.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
> +#include <linux/notifier.h>
>  #include <linux/cdev.h>
>  #include <linux/rwsem.h>

Can you also sort them (maybe in a separate change)?

-- 
With Best Regards,
Andy Shevchenko


