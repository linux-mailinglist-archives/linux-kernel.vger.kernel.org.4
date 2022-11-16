Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5A062B4AB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238647AbiKPIJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238635AbiKPIIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:08:40 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E02B11A1D;
        Wed, 16 Nov 2022 00:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668586086; x=1700122086;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GS5XsrDAkh8voevUSAcZDi09BVLJyVOCPRVqWQvdY/g=;
  b=H3VUE3s1HDTSyDfQwJoT2y0FWLjqsvFbE1U+OKdbXjOO8UjxPDzhZ5kj
   UzGgtD3p1+D2uPA8U8sFGjIcggjRMEQoKqKBc+gdRlIWnsOtt5rzpv8pt
   7+ZfMZPWWftzzspPQladsdZH+Xcy9GNAvF29nnsgceGCBQzyXYz6sgaSr
   nfvqURCL8yP5VTqC2C3JdE9CJqymeGCAGC8s45Pz0ma8ByEYT8nZVxtmn
   dzgR3HKc3JJKD3hHb8eHWP33VxC4vHAGlkcAo69oYhudfmOQYeMN8z22C
   F1i8gNkL4ed6tYi946bYzloNf8tVvT3qE8+mw9LrmwCyjXo36PnCkUAs2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="374615108"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="374615108"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 00:08:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="708064866"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="708064866"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 16 Nov 2022 00:08:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ovDSk-00D2HB-2e;
        Wed, 16 Nov 2022 10:08:02 +0200
Date:   Wed, 16 Nov 2022 10:08:02 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 0/6] Add support for software nodes to gpiolib
Message-ID: <Y3SaYsepJ2sEt2CD@smile.fi.intel.com>
References: <20221031-gpiolib-swnode-v4-0-6c1671890027@gmail.com>
 <CAMRc=Mf+FFyx7Mkw-nLMaoayJUjZbkEHDkVCsa_L+XkX6sEQDQ@mail.gmail.com>
 <Y3QedBxErvjc+YHi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3QedBxErvjc+YHi@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 03:19:16PM -0800, Dmitry Torokhov wrote:
> On Tue, Nov 15, 2022 at 11:28:17AM +0100, Bartosz Golaszewski wrote:
> > On Fri, Nov 11, 2022 at 11:19 PM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:

...

> > I still had some fuzz when applying, can you for the future rebase on
> > top of the GPIO for-next branch?
> 
> OK, I will, but I thought it is feeding into the next tree?

It has ~2-3 days latency usually.

-- 
With Best Regards,
Andy Shevchenko


