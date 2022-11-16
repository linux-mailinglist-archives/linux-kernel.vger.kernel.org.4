Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD34462B511
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238810AbiKPIZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238662AbiKPIYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:24:35 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17441CB08;
        Wed, 16 Nov 2022 00:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668586951; x=1700122951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HfeyAADZ6rcwXAyeUnjnXiy8T7DimbpkKEowfqLK5Aw=;
  b=dlPoyWfm1GAbq6g4j0dB82VuWkub8QOCwbv/NQXpuUZ03IL5Y/LrVqn5
   xcrMIg/LlYbVoxqBshMcC9y7rHR/nlCKHiaNSBC61XDZ9ZTgpTUJNIflu
   j8aF69cOPhHG8+w/v+fo/1jwsTjJco934kP2ffm6SyWrVcYIYKtptHkVG
   EKpX/iCnDwb3Ht1lLlHEGHd9hntm6P78eC0J6t93ikDoCiIcqIIl4ijpV
   s0awMtgSpUNANlS5vGcHKaEixHeWjdmiqJCSOXoLxKW0A2ms/OWyvKEIU
   dT/J612Gw6tvsqtcHR9nwyjkxCx1Eqhgk96vU6XGGOp7F9SQiyf3qTqGR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="376754178"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="376754178"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 00:22:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="744955572"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="744955572"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 16 Nov 2022 00:22:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ovDgY-00D2XR-1E;
        Wed, 16 Nov 2022 10:22:18 +0200
Date:   Wed, 16 Nov 2022 10:22:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/4] pwm: Document variables protected by pwm_lock
Message-ID: <Y3SdumZ7HP2Rf20u@smile.fi.intel.com>
References: <20221115211515.3750209-1-u.kleine-koenig@pengutronix.de>
 <20221115211515.3750209-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221115211515.3750209-2-u.kleine-koenig@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 10:15:12PM +0100, Uwe Kleine-König wrote:
> To simplify validation of the used locking, document for the global pwm
> mutex what it actually protects against concurrent access. Also note for
> two functions modifying these that pwm_lock is held by the caller.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index d333e7422f4a..ebe06efe9de5 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -27,7 +27,10 @@
>  
>  static DEFINE_MUTEX(pwm_lookup_lock);
>  static LIST_HEAD(pwm_lookup_list);
> +
> +/* protects access to pwm_chips, allocated_pwms, and pwm_tree */
>  static DEFINE_MUTEX(pwm_lock);
> +
>  static LIST_HEAD(pwm_chips);
>  static DECLARE_BITMAP(allocated_pwms, MAX_PWMS);
>  static RADIX_TREE(pwm_tree, GFP_KERNEL);
> @@ -37,6 +40,7 @@ static struct pwm_device *pwm_to_device(unsigned int pwm)
>  	return radix_tree_lookup(&pwm_tree, pwm);
>  }
>  
> +/* Called with pwm_lock held */
>  static int alloc_pwms(unsigned int count)
>  {
>  	unsigned int start;
> @@ -50,6 +54,7 @@ static int alloc_pwms(unsigned int count)
>  	return start;
>  }
>  
> +/* Called with pwm_lock held */
>  static void free_pwms(struct pwm_chip *chip)
>  {
>  	unsigned int i;
> -- 
> 2.38.1
> 

-- 
With Best Regards,
Andy Shevchenko


