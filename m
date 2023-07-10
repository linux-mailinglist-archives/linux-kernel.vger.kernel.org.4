Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6339774D8D7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjGJOUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjGJOUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:20:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18FE90;
        Mon, 10 Jul 2023 07:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688998821; x=1720534821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T+ipmIGBmanZ1HNwwnrLFkQbzQzWcUpCwirt14pJwto=;
  b=LWqRyIVvtnDlGZrQ+B52sahWuiXr60lNkANZhGio/rNaVWz99mgzKQ2b
   1FoXSUGFffyiYioiDncCxwKT65Q4GpOM6BUayaLihLGft4rxZwYMal09E
   H5+XEcuFRB5/PR1/weZKMCln2xz3XiAFNmELBW4ULnuVytowutAmKOUui
   3t+zDJP6p0dbkDncfxYZYGXJppREGWVi4rixokeOg4TAT3j8oaiw7llfy
   ZPCHC8Jpz/CSCK1cOUtSJ51B4gScREiq6MHfZOA7UUtKqCMfiO53CwRf0
   4OoIWDNXRr65ss4HdNPxxYZ88qYJUnNVRhyRPElVrlqu9jAa5g0KalNnp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="430431159"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="430431159"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 07:20:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="698003669"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="698003669"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 10 Jul 2023 07:20:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qIrkN-001ZjY-1i;
        Mon, 10 Jul 2023 17:20:15 +0300
Date:   Mon, 10 Jul 2023 17:20:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        artem.bityutskiy@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, lenb@kernel.org,
        jgross@suse.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v4 4/9] acpi: Rename ACPI_PDC constants
Message-ID: <ZKwTn/cLwAM7uSUA@smile.fi.intel.com>
References: <20230710140337.1434060-1-michal.wilczynski@intel.com>
 <20230710140337.1434060-5-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710140337.1434060-5-michal.wilczynski@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 05:03:32PM +0300, Michal Wilczynski wrote:
> ACPI_PDC constants prefix suggest that those constants are only relevant
> in the context of the _PDC method. This is not true, as they can also be
> used in _OSC context. Change prefix to more generic ACPI_PROC_CAP, that
> better describe the purpose of those constants as they describe bits in
> processor capabilities buffer. Rename pdc_intel.h to proc_cap_intel.h to
> reflect the change in the prefix.

...

> -	/* Ask the Hypervisor whether to clear ACPI_PDC_C_C2C3_FFH. If so,
> +	/* Ask the Hypervisor whether to clear ACPI_PROC_CAP_C_C2C3_FFH. If so,
>  	 * don't expose MWAIT_LEAF and let ACPI pick the IOPORT version of C3.
>  	 */

/*
 * While at it, you can fix multi-line
 * comment style. It supposed to be
 * like in this example.
 */

I don't know if resend is required, I would wait for Rafael to comment on this.

-- 
With Best Regards,
Andy Shevchenko


