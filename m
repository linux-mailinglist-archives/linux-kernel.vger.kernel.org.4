Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD802731CDD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 17:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240576AbjFOPm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 11:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238814AbjFOPmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 11:42:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712F6123;
        Thu, 15 Jun 2023 08:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686843744; x=1718379744;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1esU+W96PtNXw+8kc/bDUrIBmwX+Wv8g4LjSnrvzNiM=;
  b=DAtiTbCdFcr3Ha5tFNevmMnMClwecDlZciBepv2eEKubO6Ec2T6+4uzp
   c/6TIqxMXFwtrxZdJzdoJzhmnDdhlZl4nxabE5+L13j+kscwmumWF3ST1
   su2PNmpEhna/CX3ebYiJH9nWwwWkldwWfUOsQicy9M4DFmSZ4DgYHBI+Z
   d0g37ZQ2nw9mgUjgR4w3vdtqp4fd4g1kNP8G7Wj93aex9goaVlYQyinm1
   w0vZ5Swbn+cgPOCqtIvdjEdyhnGsN1GKcYlZW9WVzaKW8ufy1ke+NidVS
   LlQ5SbLJ7LtKeUVFJQyvVgV9V4YF3ffJK5aHecFapyDy3/X60q4WIeBwI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="361456083"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="361456083"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 08:28:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="959247177"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="959247177"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jun 2023 08:28:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q9otl-003yOe-0z;
        Thu, 15 Jun 2023 18:28:33 +0300
Date:   Thu, 15 Jun 2023 18:28:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
Subject: Re: [PATCH v4] pinctrl: intel: refine ->irq_set_type() hook
Message-ID: <ZIsuIQ1OUffgSfqP@smile.fi.intel.com>
References: <20230615125022.27421-1-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615125022.27421-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 06:20:22PM +0530, Raag Jadav wrote:
> Refine ->irq_set_type() hook and improve its readability by:
> 
> - Reducing scope of spinlock by moving unneeded operations out of it.
> - Dropping redundant PADCFG0_RXEVCFG_SHIFT and including it directly
>   into PADCFG0_RXEVCFG_* definitions.
> - Utilizing temporary variables for common operations.
> - Simplifying if-else-if chain.

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


