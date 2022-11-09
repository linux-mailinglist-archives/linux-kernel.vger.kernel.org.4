Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6E7622ED6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiKIPPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiKIPPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:15:07 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379051182F;
        Wed,  9 Nov 2022 07:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668006907; x=1699542907;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AtLFMj9+I707KU6lYrOSbKupHLsyPcnR/D7Vg2lkyrk=;
  b=nGk0oFNVwA/1YuZkr/X1CYgSwHM2SaaKJZ4G2qWOtjyD2D2d9CYTiFEQ
   RLBoADmP18rD5cAY7Go8xtazKNkAOXD1WfsFc4fb8moXz0gvpXbq+oVF1
   BmP+f7d/IPR6PLc+/4o7vbyaTmy6LPK++ziV+FdGrqdfhVZDepQv4WUt3
   S168NlAzOElNOkMlMumYwjGN3DP0T8XeGpFeWCDyyyCNRJ35y2z2C002z
   oknh98k8IrbW6/2LjKWME0A6vfPsoqwhWPGZ6FBIyyiC1v26QgoP39QIW
   p82u567hmQLL/7dWph/bEi4bOy3nv2vJGBDMqqSefekI/+TJYX/rRXo/n
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="375276914"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="375276914"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 07:15:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="705739820"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="705739820"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 09 Nov 2022 07:15:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1osmn8-009ngu-1k;
        Wed, 09 Nov 2022 17:15:02 +0200
Date:   Wed, 9 Nov 2022 17:15:02 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raul E Rangel <rrangel@chromium.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 2/2] gpiolib: Get rid of not used of_node member
Message-ID: <Y2vD9l+K5k4Lny6R@smile.fi.intel.com>
References: <20221109150706.38823-1-andriy.shevchenko@linux.intel.com>
 <20221109150706.38823-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109150706.38823-2-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 05:07:06PM +0200, Andy Shevchenko wrote:
> All new drivers should use fwnode and / or parent to provide the
> necessary information to the GPIO library.

Please, ignore this series, it was wrong offset to send the patches from.

-- 
With Best Regards,
Andy Shevchenko


