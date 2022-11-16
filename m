Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB87262BF84
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiKPNbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKPNbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:31:46 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEE763C0;
        Wed, 16 Nov 2022 05:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668605506; x=1700141506;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Huy2/K1NOJsBt3BQChhqwj4zaLZ9omkEC/MnaVHArno=;
  b=QbTjI/0sBHW4RqTrf9VcJrqnHAzEzhaW9FflZA2ufjTcjZffDCY/wBGq
   PCHusKOd9ZU9qB0BXbS2SeadH+rD1HzYZXxm7xkKw6VFPe+SlDTnVqRGN
   RzgtnfAsHfYpa1YLbaEd5vkzZLCr9KraBBF5MVPHf5Vcx0alvixt9Mmyz
   mUq7vPqsi/pCOj4zNzZsXT4IHi87c2tXFeWPUHHw7v1JvAmDBSqetGEze
   oXSsJPi04yrhshSb49XfhY3zdwx/Cg51Qyc+b0QACfyoQRE9XkSJ/+nle
   tDFvAGP68XaWZZ5+12RdT6SwI1hoYOHa6We8v+0oknXVJE+xAAFv2u8ax
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="339356815"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="339356815"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 05:31:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="633628292"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="633628292"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 16 Nov 2022 05:31:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ovIVu-00D8uj-1h;
        Wed, 16 Nov 2022 15:31:38 +0200
Date:   Wed, 16 Nov 2022 15:31:38 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>
Cc:     bigeasy@linutronix.de, devicetree@vger.kernel.org, robh@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        alan@lxorguk.ukuu.org.uk, dirk.brandewie@gmail.com,
        grant.likely@secretlab.ca, sodaville@linutronix.de,
        devicetree-discuss@lists.ozlabs.org, linux-lgm-soc@maxlinear.com
Subject: Re: [PATCH v2 0/2]  x86/of: Fix a bug in x86 arch OF support
Message-ID: <Y3TmOvnxnLF54K28@smile.fi.intel.com>
References: <cover.1668589253.git.rtanwar@maxlinear.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1668589253.git.rtanwar@maxlinear.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 06:41:00PM +0800, Rahul Tanwar wrote:
> [Resend] as i missed to include Sebastian who changes this patch
> modifies.

Now they will not see the ongoing discussion. Better was to just Cc them and
give a link to lore.kernel.org for the thread.

-- 
With Best Regards,
Andy Shevchenko


