Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D2866E18F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjAQPC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbjAQPBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:01:34 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E784340BE8;
        Tue, 17 Jan 2023 07:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673967623; x=1705503623;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q6LyA84WfayfkH44QikUzLCOFY2fAi8cD3SXnEWu+mo=;
  b=leVvwvIoLfv5yyZvNNEdcA/vV1v0j8GhnqebBNcQ3NrXgfQ/pqMH7D9N
   jku8ipOEI8tn1WCLXfz9LLLDy88hVc7+mk4G5rG7RZ86Ak8rFtPEGsERx
   2Q1/mnMuLj4gzQLbz2fPIVmOSnYUZz/kHj1iQqLAsv/shsz3R6NuVagG3
   IJhZUa93RepW12AxWWk++XL8DlmeKjrUgjUlyFL9nuKUnHYCPvFgzqag6
   l7YN0akux1or9DDG/qCF21BvBIqXLIPddvTCr2uVoporXnrpAJL56utr6
   wuJ173QEcU/JiJ+PPkewWL29rkOHTw3gAWuZs12fz92poUHq9YlFqcQDj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="305089292"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="305089292"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 07:00:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="661319869"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="661319869"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 17 Jan 2023 07:00:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pHnRk-00Aclr-1O;
        Tue, 17 Jan 2023 17:00:20 +0200
Date:   Tue, 17 Jan 2023 17:00:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 1/2] pinctrl: Proofreading and updating the
 documentation accordingly
Message-ID: <Y8a4BAotZAax9Zx4@smile.fi.intel.com>
References: <20230116153347.15786-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdbVa3XEDzcuy7iCqx0cvj4trzPe7N0B5PswA1mQ7O+GtA@mail.gmail.com>
 <Y8avtfifZpy89rS3@smile.fi.intel.com>
 <CACRpkdYTFDsU7xhu812Lh1mA1Hs9kGeid+akR84ervAsaxVYkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYTFDsU7xhu812Lh1mA1Hs9kGeid+akR84ervAsaxVYkg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 03:26:31PM +0100, Linus Walleij wrote:
> On Tue, Jan 17, 2023 at 3:24 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Actually I have missed the repetition of the comment I put in v1,
> > i.e.  that this would be good to be attached to my PR where the
> > struct pinfunction et al. have been introduced. Can I have your
> > Ack?
> 
> Sure go ahead,

So, which tag to use?

"Acked-by: Linus Walleij <linus.walleij@linaro.org>" ?

>	I can also take out the patches if you rather
> include them with a  pull request.

It would be the best, thanks!

-- 
With Best Regards,
Andy Shevchenko


