Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7B0606590
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiJTQS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiJTQSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:18:53 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0A210573;
        Thu, 20 Oct 2022 09:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666282732; x=1697818732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=um53HRrJ8LVVo6L7ZwNauAEB6I/IHREg0YMMB7JEA+I=;
  b=QvKIbbS7gfP3bna+LX7vJVPRFVq/zJ8U3vJiS+nBCCHWzFI6ViESwztb
   E58+QNUSSX0iO+3MdxjEBpXLmnMq4/c3jCiAC/8+f9rh5YHeciVbFFqYW
   oDIV/aJzDyWf0694TlHu3KFOyIUwaxQmhMQT4yWlXBn3uXKatoA+DL51V
   cA3CPS3KQ5mK8OBOpHZgaM1Yl8GiZiWROPHv0aqyyAkeNP+bu1rvEOYF4
   6bL3IUhZFpUcwnxa5e+ENHVjmET9MlBhJjpzNp0W7w7JFMnt1RpFTXOfE
   qVzyBFtqGK9FqPhCp4fcLTE8Vx8VSox5eTR8RnNjPHwxaVDmBm9fSOAgu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="304374540"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="304374540"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 09:18:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="772457862"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="772457862"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 20 Oct 2022 09:18:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1olYFT-00AdOh-2X;
        Thu, 20 Oct 2022 19:18:23 +0300
Date:   Thu, 20 Oct 2022 19:18:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 3/6] spi: pxa2xx: Remove no more needed PCI ID table
Message-ID: <Y1F0z5aP3MsqnMan@smile.fi.intel.com>
References: <20221017171243.57078-1-andriy.shevchenko@linux.intel.com>
 <20221017171243.57078-3-andriy.shevchenko@linux.intel.com>
 <Y02ObkYoUQlY9oG/@sirena.org.uk>
 <Y02SVH04iiu7Rj+8@smile.fi.intel.com>
 <Y02TR0UBseEKUjq8@sirena.org.uk>
 <Y02TxHp53XQo34ql@smile.fi.intel.com>
 <Y06RCxzwrPZwIETp@sirena.org.uk>
 <Y1ASXFOuc2uGXOlV@smile.fi.intel.com>
 <Y1AczgwCEQO2gvQ2@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1AczgwCEQO2gvQ2@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 04:50:38PM +0100, Mark Brown wrote:
> On Wed, Oct 19, 2022 at 06:06:04PM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 18, 2022 at 12:42:03PM +0100, Mark Brown wrote:
> 
> > > You should probably also restructure the code interpreting the device
> > > IDs so that it's very clear that unknown values are handled well, this
> > > would split things between multiple subsystems and right now the code is
> > > a bit fragile.
> 
> > I'm not sure how better to do this. Any example?
> 
> For example a check that the ID is one we know about.  IIRC that bit of
> context looked like a tree of if statements with no particular
> validation.

But isn't it guaranteed to be handled by device core, i.e. we won't get driver
even enumerated if ID is unknown to us.

-- 
With Best Regards,
Andy Shevchenko


