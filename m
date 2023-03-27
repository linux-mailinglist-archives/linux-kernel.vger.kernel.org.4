Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38416CA531
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjC0NHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0NHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:07:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA5FCD;
        Mon, 27 Mar 2023 06:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679922473; x=1711458473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xEhSDxvMVUikwKT6OOXXJ0JooLf8U/9nqWd8K7Tx3NA=;
  b=Mxkpou81NujpZaLERV5HwO6FK+YcthQDrTymhN5fQ2nFEhackd7aQae2
   oHdIGH4wYb3N08ur6zWndrxEV3uP4LAowmJh1Df6etri/P0xQ5FGpMX9O
   jMmmzJoDrr38T7DxdlWEr6n+u+CQM5ci0mKnQ9A3ZRFkigYOZz9hwpYVB
   0/+fzTC29XgZ6+V4klGTjPvxb70vOH7EDYFxJWaQDfu/S9vnXWHPVu1on
   9Bly3DlXWTvnoMZPEQ7V3hrpYHvjUNtz1OQS03yoqMmkiOTatakZNFi6P
   pp+6UQk9RcS5sEanKbfNAHJzxNRHl2b9VXjqzFd9339kLh8Y0/0QKXkSk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="402852982"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="402852982"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 06:07:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="772695912"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="772695912"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Mar 2023 06:07:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pgmZg-009Exk-1J;
        Mon, 27 Mar 2023 16:07:48 +0300
Date:   Mon, 27 Mar 2023 16:07:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     jic23@kernel.org, lars@metafoo.de, nathan@kernel.org,
        ndesaulniers@google.com, u.kleine-koenig@pengutronix.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] iio: tsl2772: remove unused prox_diode_mask variable
Message-ID: <ZCGVJOSBjKO3FKD6@smile.fi.intel.com>
References: <20230327120823.1369700-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327120823.1369700-1-trix@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 08:08:23AM -0400, Tom Rix wrote:
> clang with W=1 reports
> drivers/iio/light/tsl2772.c:576:24: error: variable
>   'prox_diode_mask' set but not used [-Werror,-Wunused-but-set-variable]
>         int i, ret, num_leds, prox_diode_mask;
>                               ^
> This variable is not used so remove it.

While from the compilation point of view this is a correct fix, I think
we need to hear from the author (or interested stakeholders) about this
feature. Perhaps it should be enabled / fixed differently.

-- 
With Best Regards,
Andy Shevchenko


