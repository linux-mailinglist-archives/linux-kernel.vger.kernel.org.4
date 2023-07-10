Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EEC74D2CE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjGJKFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjGJKEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:04:31 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40BD185
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688983287; x=1720519287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=luSbHsx5d1FecnumIWJGPoVnuKwT7pnZ0idb4x+0LEI=;
  b=ezC2eUZ/Xvvvslm1/+lsizfg777CVEpv0yCWpnW70yny3HfXLkveAiS5
   Ez2rdBp6P7U6DIw4Mp5b5aa6Im7j9GYR8kJzfj2SfEeaNoeOMdKduV5qQ
   XcU9Fpe3cmunigfttbiRMTN2mxYmgdqJEhg4bKxyHNeyYI7/chfrQfR8h
   QjIqDXiRMsjIXIei2N9ZB0aLrQgHnaoP3OQFhGolNqfLsAhjt8YGfSGK/
   MGqkJ8+EDt8PXLm3MKXjKPyHkjyemXM9n/NHsu+3ozy6Wj9ENeC8NCM4N
   ehXV7vC6+jQn1z/NyjhFKSUKOmtPazIQy2awoA3KhYFRlZjVkeVtRLWal
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="363169642"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="363169642"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 03:00:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="790736520"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="790736520"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 10 Jul 2023 03:00:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qInhL-001WM3-2h;
        Mon, 10 Jul 2023 13:00:51 +0300
Date:   Mon, 10 Jul 2023 13:00:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        JaimeLiao <jaimeliao.tw@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v1 1/1] mtd: rawnand: Remove unused of_gpio.h inclusion
Message-ID: <ZKvW0yzxU1ktDALd@smile.fi.intel.com>
References: <20230615164210.25515-1-andriy.shevchenko@linux.intel.com>
 <CAFBinCAJ5m+NTVry56=0AYMYr9xiM9KS7F837Hqb=ptOG_u54g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCAJ5m+NTVry56=0AYMYr9xiM9KS7F837Hqb=ptOG_u54g@mail.gmail.com>
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

On Fri, Jun 16, 2023 at 12:10:52AM +0200, Martin Blumenstingl wrote:
> On Thu, Jun 15, 2023 at 6:42 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > The of_gpio.h is not and shouldn't be used in the drivers. Remove it.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Thank you!

Can it be applied now?

-- 
With Best Regards,
Andy Shevchenko


