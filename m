Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FDE67E35A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbjA0Lb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbjA0LbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:31:09 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B097C700;
        Fri, 27 Jan 2023 03:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674818983; x=1706354983;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rmwYl6qmr6ZgUlWhIMYLF75xQQfhdp7GeiJDmf9FXZg=;
  b=OlwmEjbAP+qhXTY+vopoaYgyyCvQJAA3qH6KInIqyyuqoLXX4AwTlfMH
   z4oJ575i5OoJv8IE66iuluegyNQGounA3a/tu93UErlsEWYqR68ld4ReP
   2jYIKGRQobTmKco+mFe8sykUkftgjnanvmWX+JFIHla1KuuG0UKRmkzlG
   4D38gSUTlhaKukxFYpJW0sL9Z8HJccNPKEVitiwxAupw0wR/agLT9HS7e
   f08wqyLNJCmxgPHb/gt3W/6//jSSozF/b9MbT7JprgFzEUg0SsHzirE6i
   Ogwg2LkQo8ZwqlxKGEZCaAwGdfrK2Qu9LGXltc7x982UU7unjC8hLw92f
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="315020703"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="315020703"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 03:29:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="665216343"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="665216343"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jan 2023 03:29:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pLMvI-00Fw7Z-16;
        Fri, 27 Jan 2023 13:29:36 +0200
Date:   Fri, 27 Jan 2023 13:29:36 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] gpiolib cleanups
Message-ID: <Y9O1oA2KKUUvOcnP@smile.fi.intel.com>
References: <20230127101149.3475929-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127101149.3475929-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 11:11:42AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> These are some older patches I did last year, rebased to linux-next-20230127.
> 
> The main goal is to remove some of the legacy bits of the gpiolib
> interfaces, where the corner cases are easily avoided or replaced
> with gpio descriptor based interfaces.

Thank you!

I guess we may go with this via GPIO tree.

-- 
With Best Regards,
Andy Shevchenko


