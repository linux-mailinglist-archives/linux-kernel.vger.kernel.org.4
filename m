Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5092963395B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbiKVKJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbiKVKJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:09:34 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E8613D15
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669111774; x=1700647774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C6A3naQJ/9uOmCHjvixZOXuGnRUet7Oh3pAlTp9/VS4=;
  b=Lysekyy8wrujr+UQ71iiFRtaXT/4x+JAZa/s9Ig+YCvgO2Bfhqt2m+XB
   FTTc5ZlcbX7n2rujHoFodHq1P3rgtoCfdkv06O1kh81Hr9aI10dzt/Zor
   /UhUlrkypOfDSRZmXqCzEeYCeN0ka8cvim4a/zntrEKmhjBYhlT5vJV0m
   0OUfSrimD9cjZ6/ZIyjU0ZyTTU2kZ0CkijjOAf4U2G6MZBhRgR/wJqsA6
   8MryvrbNZbnr56mv8TuR7WzLzamLamZ0k4EO3OXwItF9J/ZYMCV33kQRV
   IyvCAbQVxoWDb2blA/82uUh9vD/e9edlBByB9IEKDPD0y68xqqjXFBxl1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="293490488"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="293490488"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 02:09:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="766291334"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="766291334"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 22 Nov 2022 02:09:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxQDY-00FhoX-2E;
        Tue, 22 Nov 2022 12:09:28 +0200
Date:   Tue, 22 Nov 2022 12:09:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>
Cc:     "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "robh@kernel.org" <robh@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-lgm-soc <linux-lgm-soc@maxlinear.com>
Subject: Re: [PATCH v3 1/4] x86/of: Convert Intel's APIC bindings to YAML
 schema
Message-ID: <Y3yf2OWt6nE4xVVi@smile.fi.intel.com>
References: <cover.1669100394.git.rtanwar@maxlinear.com>
 <0cf089495a422b945ac4fc9c980ddb5429a711c3.1669100394.git.rtanwar@maxlinear.com>
 <Y3yR+Ouc7l9RvB8K@smile.fi.intel.com>
 <b790fa4b-e2d8-ad21-09a3-6b92c863343f@maxlinear.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b790fa4b-e2d8-ad21-09a3-6b92c863343f@maxlinear.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 09:43:12AM +0000, Rahul Tanwar wrote:
> On 22/11/2022 5:11 pm, Andy Shevchenko wrote:
> > On Tue, Nov 22, 2022 at 03:39:07PM +0800, Rahul Tanwar wrote:

...

> >  > + first appeared in CE4100 SoC. See bindings/x86/ce4100.txt for more
> > 
> > Shouldn't you change this?
> 
> Do you mean change compatibility property prefix from 
> "intel,ce4100-ioapic" to "intel,ioapic"? If yes, then i totally agree 
> and i will change it (including new file names & all other references to 
> ce4100). If not, please clarify more..

I specifically emphasized a single line (by putting blank lines around).
For your convenience I removed the unneeded parts of the context, so you can
see better what I meant.

...

> >  > + first appeared in CE4100 SoC. See bindings/x86/ce4100.txt for more


Ditto.

-- 
With Best Regards,
Andy Shevchenko


