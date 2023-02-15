Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E8F697D6D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjBONbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjBONbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:31:08 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD12392BF;
        Wed, 15 Feb 2023 05:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676467858; x=1708003858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SC842wn42nkR0dYnRKqNWRp+buYOMeHzKeTEg6aEzbQ=;
  b=YRo1ERCDpQHo14k0mV2s/915Njzhb+qivOB8ZB5mrwsSffSbSKlHhaDT
   jwAyPszHFwIs+zXoXJXns1IthqlM1egfpolZuXndJ9B45Qld+2SmCsetb
   Aq1UAlAVc+Wr6znMR8jA8TGk2BSl1QsnSWM/OQ/zF/1hKjWI3sdIhPI7W
   3zO1cpmlrTmX8+c20xKuxa1IIGhiTECKvLye94siy4Ytz8A/WTdApWblD
   l829UBXUbRcYk8DHY7UMVnXP59yOzihzBZFubCVheo30tDHvv78NZcbyQ
   /qb6Mypcujjoy8VUopuEzJ0Fp7UFDEiLn0dJQnyp6iLLmzuaX+1JaJRRP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="315080815"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="315080815"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 05:30:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="758405223"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="758405223"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Feb 2023 05:30:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pSHs5-007GuX-0X;
        Wed, 15 Feb 2023 15:30:53 +0200
Date:   Wed, 15 Feb 2023 15:30:52 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Raag Jadav <raag.jadav@intel.com>, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
Subject: Re: [PATCH] gpiolib: acpi: remove redundant declaration
Message-ID: <Y+zejChw4u/L1MLR@smile.fi.intel.com>
References: <20230215120004.9693-1-raag.jadav@intel.com>
 <Y+zLXZsiZljl0z5t@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+zLXZsiZljl0z5t@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 02:09:01PM +0200, Mika Westerberg wrote:
> On Wed, Feb 15, 2023 at 05:30:04PM +0530, Raag Jadav wrote:
> > Remove acpi_device declaration, as it is no longer needed.
> > 
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed for fixes, thanks!

-- 
With Best Regards,
Andy Shevchenko


