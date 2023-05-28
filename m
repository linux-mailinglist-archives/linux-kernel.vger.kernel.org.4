Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0666971391C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 13:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjE1LAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 07:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1LAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 07:00:22 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD21A4;
        Sun, 28 May 2023 04:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685271621; x=1716807621;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g6CoUCTMZtyvKD2xXLW4r5j8Ly+rx8jj6t/ryWbIQPc=;
  b=Txn7sH3AA1NdqCXwd9xCanrHxLla6MXswlKQ1mgCjtr3Pkj/LzrE7u9/
   FDh1qCkZq8qZDIpjanNr3mGSrYm1zkAYL27k3ZAdA4rvUOA8EicmxUOZQ
   ltonAKzZO9cM0fbH5XuiZpcgUs2je3YvDoZ5UIHZ8r8MhiCwL/Vk2m2zu
   0YO8BYn41KyvsB7dThaLnCKNA87yejpsx8xYD5DdZJ6NP72q8rrdRZVCw
   oasvyl8Q5pqJv4H+IVy1pGrDrf/KfjsIYR0cmeAsuEBa9qeX1VUS/CQY7
   nx2WmeKkR76671f78ut77oxH5vDHeW4832Amb5EmCiCFp4Gp84n/Mws2I
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="334128585"
X-IronPort-AV: E=Sophos;i="6.00,198,1681196400"; 
   d="scan'208";a="334128585"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 04:00:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="952402178"
X-IronPort-AV: E=Sophos;i="6.00,198,1681196400"; 
   d="scan'208";a="952402178"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 28 May 2023 04:00:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q3E8E-000JkD-2R;
        Sun, 28 May 2023 14:00:14 +0300
Date:   Sun, 28 May 2023 14:00:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     George Stark <gnstark@sberdevices.ru>
Cc:     jic23@kernel.org, lars@metafoo.de, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v2] meson saradc: add iio device attrib to switch channel
 7 mux
Message-ID: <ZHM0Pheg047fYJXw@smile.fi.intel.com>
References: <20230527214854.126517-1-gnstark@sberdevices.ru>
 <ZHMxDHPBWQOJSuaZ@smile.fi.intel.com>
 <ZHMzGHsGEylDdgg7@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHMzGHsGEylDdgg7@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2023 at 01:55:20PM +0300, Andy Shevchenko wrote:
> On Sun, May 28, 2023 at 01:46:37PM +0300, Andy Shevchenko wrote:
> > On Sun, May 28, 2023 at 12:48:54AM +0300, George Stark wrote:

...

And last but not least (I just noticed how Cc and To is formed in your email),
you may utilize my "smart" script [1] or ideas from it for sending patches to
the Linux kernel related mailing lists. It will automatically provide Cc and
To with a good approximation.

For v3 the command line can be (assuming your patch is on the top of the
current branch and the script is in the one of the $PATH folders):

	ge2maintainer.sh -c 1 -v3 HEAD~0 --annotate

this will call for editor, so you would be able to add Changelog after cutter
'---' line.

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

-- 
With Best Regards,
Andy Shevchenko


