Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F22562168F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbiKHO3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbiKHO2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:28:51 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698B15C776;
        Tue,  8 Nov 2022 06:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667917610; x=1699453610;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PF5aiFMvuJCck1QCgwE4v9546WvgeXFWsp175nRCSTU=;
  b=f7329ker/B7xWvQX4aX/MJteJ01apb9a3wCJ+n/KRvbq0KiB2+tiTTg5
   mimXHkFt9ygk4eXkpB/svsfYwNgqQ+wMst6TkcsCBJXXDTCdlnH+hr/Ri
   h99bQJTTtb5ZFZ3l4LmlQS6cccdCnCiYvTh1eJBgdVqA4sF8OpLkR+KCC
   3gHMRgeYeVxHRwbGZgXeYOVJQa9lMpz0fUjc5wyYWj0vYHYibOFHB6gWZ
   vG04xwRwwhFDAkT62hbL+xuqRFa/mlHp907Cbzh5j2HckYhbNH1TgfJkk
   5V7bqV5Moh11QqSCmsR8SQpqD7LqaBcC/mxYafPCWk8/fsAc5ME1ZUw/l
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="310701596"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="310701596"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 06:26:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="638804818"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="638804818"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 08 Nov 2022 06:26:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1osPYt-009ASc-0d;
        Tue, 08 Nov 2022 16:26:47 +0200
Date:   Tue, 8 Nov 2022 16:26:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: intel: Add Intel Moorefield pin
 controller support
Message-ID: <Y2pnJskyDcTMn8LL@smile.fi.intel.com>
References: <20221108140931.62910-1-andriy.shevchenko@linux.intel.com>
 <Y2pmYOKcVcMZ+lF1@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2pmYOKcVcMZ+lF1@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 04:23:28PM +0200, Mika Westerberg wrote:
> On Tue, Nov 08, 2022 at 04:09:31PM +0200, Andy Shevchenko wrote:
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Intel Moorefield SoC pinctrl driver
> > + *
> > + * Copyright (C) 2020, Intel Corporation
> 
> 2022
> 
> Otherwise looks nice to me,

Fixed and pushed into my reqiew and testing queue, thanks!

> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


