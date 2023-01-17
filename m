Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1C766E2A8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjAQPqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbjAQPqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:46:09 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EAF27D74;
        Tue, 17 Jan 2023 07:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673970253; x=1705506253;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GG5BwYt5PVPYxx6sAHKdfDO8GiFSj+dmo4JKzIxwxnk=;
  b=FQKq3PO0c0zP4qN8vIM/soOpiHekFCwU0iKlEe4nAg/YUdiWFAeARA7Y
   Vkm1Gv6GIwxfmNJtEuh+TTI5quacQX3IyYJCXxJmCnLQRk4RtC4NsjAd1
   hvjllxF2HOc7+qRiuYaPYHeBENgLv8h/yb2fRre1OO0KDcQ70vgVx2hIV
   /9M4dz2tejITi1ETt/TAzwMeNRalydqGNo4YWNwsTmDiMaxSA5Ci0d6d9
   nq734aceF5PRRAIuMmO7dTyxfoOq0KSUXOW+ezEnxeNLXvwme7sMQ2zhs
   fzTH4GjsHeXIUb6TcazbNlxQxc9w3HVeasAvLLt+Jat/mzoCoE9FlIu6C
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="305103017"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="305103017"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 07:44:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="659428148"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="659428148"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 17 Jan 2023 07:44:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pHo83-00AdrD-3C;
        Tue, 17 Jan 2023 17:44:03 +0200
Date:   Tue, 17 Jan 2023 17:44:03 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 1/2] pinctrl: Proofreading and updating the
 documentation accordingly
Message-ID: <Y8bCQ9QlhMpFdTiC@smile.fi.intel.com>
References: <20230116153347.15786-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdbVa3XEDzcuy7iCqx0cvj4trzPe7N0B5PswA1mQ7O+GtA@mail.gmail.com>
 <Y8avtfifZpy89rS3@smile.fi.intel.com>
 <CACRpkdYTFDsU7xhu812Lh1mA1Hs9kGeid+akR84ervAsaxVYkg@mail.gmail.com>
 <Y8a4BAotZAax9Zx4@smile.fi.intel.com>
 <Y8bCBMoeNHlBG97a@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8bCBMoeNHlBG97a@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 05:43:00PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 17, 2023 at 05:00:20PM +0200, Andy Shevchenko wrote:
> > On Tue, Jan 17, 2023 at 03:26:31PM +0100, Linus Walleij wrote:
> > > On Tue, Jan 17, 2023 at 3:24 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:

...

> > > > Actually I have missed the repetition of the comment I put in v1,
> > > > i.e.  that this would be good to be attached to my PR where the
> > > > struct pinfunction et al. have been introduced. Can I have your
> > > > Ack?
> > > 
> > > Sure go ahead,
> > 
> > So, which tag to use?
> > 
> > "Acked-by: Linus Walleij <linus.walleij@linaro.org>" ?
> 
> Added this tag and pushed to my tree, thanks!
> 
> P.S. Tell me if I should do somehow else.

Note, I have slightly amended couple of lines, and if you keep the patches
in your tree as well it may be a minor conflict.

-- 
With Best Regards,
Andy Shevchenko


