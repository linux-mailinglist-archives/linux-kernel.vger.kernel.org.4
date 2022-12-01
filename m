Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E6563F222
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbiLAN7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbiLAN7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:59:18 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF75C9075A;
        Thu,  1 Dec 2022 05:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669903158; x=1701439158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4sRZObLUG5OaJjXdw1Z6NCwltClUP9Jbis/LQvdf6E4=;
  b=Q4k2VGbozfgIgef9y++XVsp0ceCwt+OR6pxBsP0XxG2AUQ483+Z8m6wQ
   /J2itZiWJqO1PzUioLKpDw9ivOp02h6xNFrMrdt2EQl5194pxf/jxpEj/
   B334fb30LJ8gVA8nurMgsMVHV2kOhT2dqbCtg1z5Cima4e2pNhpgnhZI5
   FK/6pQioAqQAO8qLSfqZAwsdYighDEO/EUQEuPPErTE8bDTBoUl22p4XM
   MUGfdz5+UB6W7zQ4FADttLgMX+C+eCq0ooUS9wC7tVOhLoQwHzV4yufhw
   IWLQNlhSt+oY4QI9WActTtwTyqzMY9IYjzN9Kq3Rp3IxXBWTGuPzsY3zc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="379977314"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="379977314"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 05:59:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="622309113"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="622309113"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 01 Dec 2022 05:59:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p0k5p-002oSK-20;
        Thu, 01 Dec 2022 15:59:13 +0200
Date:   Thu, 1 Dec 2022 15:59:13 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v6 0/2] gpiolib: don't allow user-space to crash the
 kernel with hot-unplugs
Message-ID: <Y4izMVZBhXGj1jbj@smile.fi.intel.com>
References: <20221201125928.3031325-1-brgl@bgdev.pl>
 <CAMRc=MfGi52s+LcTrBnBPDV91SbC4vf1prrLUpzQ_KZQQZGBuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MfGi52s+LcTrBnBPDV91SbC4vf1prrLUpzQ_KZQQZGBuQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 02:00:06PM +0100, Bartosz Golaszewski wrote:
> On Thu, Dec 1, 2022 at 1:59 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

...

> I know Kent and Linus left their review tags already, I will add them
> when applying.

I guess it's good enough, go ahead with it.

-- 
With Best Regards,
Andy Shevchenko


