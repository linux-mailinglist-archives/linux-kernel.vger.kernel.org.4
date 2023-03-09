Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6162B6B267F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjCIOPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjCIOPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:15:00 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CFDE38C;
        Thu,  9 Mar 2023 06:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678371294; x=1709907294;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3wo4F1B6Ahe3oBt+iAXX6bg+LjItHYHDyzBMJv10cZI=;
  b=juRZHzy8DHSgQihK7Yf9OajwWFx1ddVW+PNIzqYM/FqBlNFpxaxYn0Pd
   vwh1yxefRs1gMnVDj9fFo/LAaRdzsYiKSpPQLNF7bi8JV8l35WorinYUF
   4GkPvMBM25Ev5uKJgoCRxatzAbIa4zeiRwRNwzJCOMrYh4oAwfKrcmSDv
   HyeGIFryN3fCADGIF+w/AiHezy8PRzC7momM5iBJ3/Fg/i19zjeDrXexx
   CmqndiZRjVgCspFHzmon91yehFtpVh0hpTSBS29bvqBKDAgPF9mJMQuGE
   2008Q0eEe337rFU51f9lfNMHQmR+hgOhXQ+H094jS8jxYBaSzf8UETkwH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="338791440"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="338791440"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 06:05:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="801181776"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="801181776"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 09 Mar 2023 06:05:53 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1paGu0-000Lrl-0Y;
        Thu, 09 Mar 2023 16:05:52 +0200
Date:   Thu, 9 Mar 2023 16:05:51 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: ar71: include linux/gpio/driver.h
Message-ID: <ZAnnv/1ETFTRH8Qi@smile.fi.intel.com>
References: <20230308145303.826942-1-arnd@kernel.org>
 <CACRpkdZAJJr5+f8wiEhnAAV8mLjzYCBMDC9GXwQOAmsQLfShoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZAJJr5+f8wiEhnAAV8mLjzYCBMDC9GXwQOAmsQLfShoA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 10:56:02PM +0100, Linus Walleij wrote:
> On Wed, Mar 8, 2023 at 3:53 PM Arnd Bergmann <arnd@kernel.org> wrote:
> 
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The change to remove the implicit gpio/driver.h include was done
> > after fixing all the other users, but the ar7 file still needs
> > the same change.
> >
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Fixes: 21d9526d13b5 ("gpiolib: Make the legacy <linux/gpio.h> consumer-only")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> If this is the only problem merging this set was amazingly painless.

Too early to celebrate. We have one more patch on the same matters.

That said, I will collect them and send a new PR to Bart.

-- 
With Best Regards,
Andy Shevchenko


