Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25976997DA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjBPOvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBPOvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:51:46 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D7E3A0AC;
        Thu, 16 Feb 2023 06:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676559102; x=1708095102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x371ivh4xXBL5WHPoCYny9H2qed+c4NoN03Dsh6RNUM=;
  b=V3niWVjStF2MXEujrINr6URB/lJ0pxJ++okCsiyZ7VZHXp6r9NANJx72
   27/92BReNFhY23NqzvWZqGwZyA+BgVueQMKL4GbNj2AP9364T2YgRotAM
   s4U/oPyUw0qAkAO8XAgnwS1WkeUQK9W27Ppta+mZQuAhPxhM7Gy7dfbKC
   62bHBttTLn0ZsRrQiMQsVEs+SdTDXsmmPQjdIeD8eyqH1GzSbnUM3SCRo
   3D/A7kItoP7jG+6SlB88F6tl+wJdVJSNaoans2FCtnqEYAR4paoBecrwa
   HJA05K5ZgeVPq3j//X2xe01y0aLrAuG8YuEVvCLgwq7/l0xsreYar4ZOe
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="394160682"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="394160682"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 06:51:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="915682205"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="915682205"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 16 Feb 2023 06:51:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pSfbl-007pIR-2r;
        Thu, 16 Feb 2023 16:51:37 +0200
Date:   Thu, 16 Feb 2023 16:51:37 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
Subject: Re: [PATCH v1 2/3] gpio: merrifield: Adapt to tangier driver
Message-ID: <Y+5C+YeeQJsIHayU@smile.fi.intel.com>
References: <20230216132356.29922-1-raag.jadav@intel.com>
 <20230216132356.29922-3-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216132356.29922-3-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 06:53:55PM +0530, Raag Jadav wrote:
> From: Pandith N <pandith.n@intel.com>
> 
> Make use of Intel Tangier as a library driver for Merrifield.

...

> -MODULE_LICENSE("GPL v2");
> +MODULE_LICENSE("GPL");

Stray change.
No need to resend, it can be fixed when applying.

-- 
With Best Regards,
Andy Shevchenko


