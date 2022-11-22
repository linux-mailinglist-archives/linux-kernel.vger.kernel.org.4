Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DA463381D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiKVJPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbiKVJOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:14:54 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8AF4877A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669108493; x=1700644493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qs695M20SACMNQ8Nvm1So139w1MUMoFvGAK9Nu/eb4w=;
  b=bbv7j1VHiyMqj2IwBIyYjp6S1/YcTfSOgQUkmHN4MF+HaM3IrJ42vbTT
   iDcWgxtNf27yxNxvi1BpX3/t/dT3iUHqNAT2m8Gq82BAbb2CypEqO8jr/
   TWZO7JN8RH4zCOkoglFHwddfMDp+ethSOe2v2UuBZQiZZDPHP9bx7kQA9
   4KXRIewXRUkQY/5ozWJiVtzc1o6KltRTVTCe28yO5elOl5uyZqZ/ERaOt
   862qPczi0JnKSwNVao1BfaykTDAJR1bBIcC3kSJ8ArLlH3x5p3QNekcUs
   lKZsCyQdGNiAxsqiM0D8fEngqLPVX/lKTyT5/MG1o7KEKur92yRq6frf1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="378030579"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="378030579"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 01:14:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="710129962"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="710129962"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 22 Nov 2022 01:14:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxPMe-00Fgsy-0i;
        Tue, 22 Nov 2022 11:14:48 +0200
Date:   Tue, 22 Nov 2022 11:14:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>
Cc:     bigeasy@linutronix.de, robh@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-lgm-soc@maxlinear.com
Subject: Re: [PATCH v3 3/4] x86/of: Replace printk(KERN_LVL) with pr_lvl()
Message-ID: <Y3yTB7mGOPm3rFfb@smile.fi.intel.com>
References: <cover.1669100394.git.rtanwar@maxlinear.com>
 <64a905649accf1b68f03c31a9b6ce205b03c6703.1669100394.git.rtanwar@maxlinear.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64a905649accf1b68f03c31a9b6ce205b03c6703.1669100394.git.rtanwar@maxlinear.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 03:39:09PM +0800, Rahul Tanwar wrote:
> Use latest available pr_lvl() instead of older printk(KERN_LVL)
> Just a upgrade of print utilities usage no functional changes.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
> ---
>  arch/x86/kernel/devicetree.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
> index 5cd51f25f446..fcc6f1b7818f 100644
> --- a/arch/x86/kernel/devicetree.c
> +++ b/arch/x86/kernel/devicetree.c
> @@ -248,7 +248,7 @@ static void __init dtb_add_ioapic(struct device_node *dn)
>  
>  	ret = of_address_to_resource(dn, 0, &r);
>  	if (ret) {
> -		printk(KERN_ERR "Can't obtain address from device node %pOF.\n", dn);
> +		pr_err("Can't obtain address from device node %pOF.\n", dn);
>  		return;
>  	}
>  	mp_register_ioapic(++ioapic_id, r.start, gsi_top, &cfg);
> @@ -265,7 +265,7 @@ static void __init dtb_ioapic_setup(void)
>  		of_ioapic = 1;
>  		return;
>  	}
> -	printk(KERN_ERR "Error: No information about IO-APIC in OF.\n");
> +	pr_err("Error: No information about IO-APIC in OF.\n");
>  }
>  #else
>  static void __init dtb_ioapic_setup(void) {}
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


