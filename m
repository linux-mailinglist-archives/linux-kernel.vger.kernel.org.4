Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B3E67CE08
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjAZO0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjAZO0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:26:40 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651AA62784;
        Thu, 26 Jan 2023 06:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674743183; x=1706279183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ats/w2v7iUqynBc3bvPPgI3lbFwHlI3K3sYsULum8gk=;
  b=H+acwJvpxuyGBU/RL6kSHJDKnTCPJdOx+j7QJDgTGNav4JyqshOD5U42
   e3UGTVjDDc10/30dUxiQtCNRIScN2Xizhs4VZUHKdlXgtiIYdr+rG633j
   aEFYHLKFocSq7p+35L57fPTQRrW6Hv+FNBYT2/En/GBXCWaLZKLWOxbT5
   v52VWgRgRofjAHXpENBbWa95AZHD8+fV0JA8Xpy5Zsjx0bi2hkWrl9qjD
   a6hjuS4RpT2nIlenq6fA8MD00eCIzbPplUA2V5cbdhCIM5ezaqq2afVFM
   whwakS6lu3t8gRqLKdNUkVO39bNKiEjTaJ/C7NkqJ5w70ZbHpgX5Hi3Jz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="391339129"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="391339129"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 06:09:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="664855792"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="664855792"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jan 2023 06:09:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pL2wf-00FQrN-10;
        Thu, 26 Jan 2023 16:09:41 +0200
Date:   Thu, 26 Jan 2023 16:09:41 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] gpiolib: move of_gpio_flags into gpiolib-of.c
Message-ID: <Y9KJpU4rynmTdQMj@smile.fi.intel.com>
References: <20230126132801.2042371-1-arnd@kernel.org>
 <20230126132801.2042371-9-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126132801.2042371-9-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 02:28:01PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There is no need for this in the header any more, it's just
> an implementation detail now.

I have published
https://lore.kernel.org/r/20230112145140.67573-1-andriy.shevchenko@linux.intel.com
Can it be used?

-- 
With Best Regards,
Andy Shevchenko


