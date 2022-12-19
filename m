Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E35650D89
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbiLSOlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiLSOlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:41:40 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AED198;
        Mon, 19 Dec 2022 06:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671460899; x=1702996899;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c/Fey/5u4JdaJ7bzLoCFW1aE1G+HV8ZJD7FJfRPS4A4=;
  b=TABdhEL+iu41oFoHC9Wj4vueMsamxAI4QBGg2SrvKzRjDM54aTwhoq4B
   0yZK06Rj33DEn9IRJtWRQT8p4FU4w2Bx7PRwSu9SZu3vyOkJDZ4NZ0rZt
   4P+tO7YdYbj1vu0cqJq4IANm1xc9Alc7GFJg1b6nE6yaxUwex5cJQtLG/
   G74dZBS6pyn7kNvB+Z/crqNYeJ5e/foBbZ2loeYb1lZ2Zgg+C3dU/gsHJ
   g+FXj+mUwy60U6fb7GB5y9uL7JywrzgLC22IxrXdscEpFRHlYQGorfWdi
   jO+aYx/DVdtY2gcz/4s3cedBWetDmT0kChiN4h1vNW5VD1YIyhjiKTzFl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="299694658"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="299694658"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 06:41:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="644025449"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="644025449"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 19 Dec 2022 06:41:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p7HKh-00CKMx-0J;
        Mon, 19 Dec 2022 16:41:35 +0200
Date:   Mon, 19 Dec 2022 16:41:34 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/4] pinctrl: intel: Add default case to
 intel_config_set_pull()
Message-ID: <Y6B4HrOXNPXGBDWZ@smile.fi.intel.com>
References: <20221219123208.5505-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219123208.5505-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 02:32:05PM +0200, Andy Shevchenko wrote:
> For the sake of symmetry with intel_config_get_pull(), add
> a default case to the outer switch.

The stats for the entire series:

 drivers/pinctrl/intel/pinctrl-intel.c | 45 +++++++++++++++++++++++++++------------------
  1 file changed, 27 insertions(+), 18 deletions(-)

-- 
With Best Regards,
Andy Shevchenko


