Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E9462BF96
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbiKPNfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKPNey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:34:54 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B8A26EB;
        Wed, 16 Nov 2022 05:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668605693; x=1700141693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bDwfiIoW46Y69I+N7oRir9xgK3fMB6RiBojfGSjGnL4=;
  b=WY3i9XUH4wbnX4DDznspt/MLutuFiAh3nY8wny2+9oiTDoNM8UrHxJQJ
   P8fK6LYmL6MOwO/WHpKu/EUlgqDpH/LjxbXMYlg3y+6kd9Er3fyElvj1U
   EOg4M/Dmc+V6lBj73fIoxU6PBLOCcwGKBuYDqXp2/2EY+vk7aR8hAQZb9
   7gXJlI4iwJO+sgybpafV65GI9ieKP9n7g1bSD/+pOIJke0b5lE1W1+pL7
   w7SdM2zcROHhoCvPug0ptRkPV8nYWr3OFl6ZlNaS3JZDVs0I0pGGs9seu
   H6ryBfDTf80o30MEDUvkntr1WJ3Bae5xnLXbSleNCdbqOIoSQ59fA06Zn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="374675386"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="374675386"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 05:34:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="670501944"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="670501944"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 16 Nov 2022 05:34:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ovIYx-00D8yV-0A;
        Wed, 16 Nov 2022 15:34:47 +0200
Date:   Wed, 16 Nov 2022 15:34:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>,
        "dirk.brandewie@gmail.com" <dirk.brandewie@gmail.com>,
        "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>,
        "sodaville@linutronix.de" <sodaville@linutronix.de>,
        "devicetree-discuss@lists.ozlabs.org" 
        <devicetree-discuss@lists.ozlabs.org>,
        linux-lgm-soc <linux-lgm-soc@maxlinear.com>
Subject: Re: [PATCH v2 1/2] x86/of: Add support for boot time interrupt
 delivery mode configuration
Message-ID: <Y3Tm9htYb1fwyRXH@smile.fi.intel.com>
References: <cover.1668589253.git.rtanwar@maxlinear.com>
 <9114810c7af7fbaf9d0b2823752afcef865bdda0.1668589253.git.rtanwar@maxlinear.com>
 <Y3S+lLzcmytKHLRq@smile.fi.intel.com>
 <7efa66ec-8aa7-d44f-fae3-ee4f82d8f157@maxlinear.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7efa66ec-8aa7-d44f-fae3-ee4f82d8f157@maxlinear.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 11:25:47AM +0000, Rahul Tanwar wrote:
> On 16/11/2022 6:42 pm, Andy Shevchenko wrote:
> > On Wed, Nov 16, 2022 at 06:28:20PM +0800, Rahul Tanwar wrote:

...

> > Why not pr_notice() in both cases?
> 
> Reset of the file uses printk(KERN_xxx ""). In v1, i used pr_notice() 
> but on reviewing again found it to be odd one out in the file. So 
> switched to printk(KERN_xxx ""). I can revert back to using pr_notice() 
> if you think that's a better fit. Thanks.

I don;t know why we should use antique style of printing APIs in new patches.
Even if the old code uses that, you can create a followup that can do two
things:
- uses pr_lvl() instead of printk(KERN_LVL)
- keeps string literals unbroken between the lines (if any
  of such breakage exists)

-- 
With Best Regards,
Andy Shevchenko


