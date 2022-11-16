Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D3662BA29
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbiKPKxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238872AbiKPKwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:52:54 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8670B2DAB6;
        Wed, 16 Nov 2022 02:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668595321; x=1700131321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bROr3LdaZlpFN3+tkO+XZT8YnRqbjM/A14hFirvkKDk=;
  b=bP07pyWKEXqjfEPjgsKKxjcnynT6+Qya0Rt9BAKTXtknW4ajTm70VQne
   GcrMJRgja2r5vRaSiHk1KmM9PQ5YGfRdLPrECLIWiS8eC7JwwSYBtgKLn
   ElD5mon4td/IOgtZBOP79mlPmbF9YjeqZcqAJ/d24bEyNImbxRkqk+lE7
   hzyolE3vV/NDnfnY5XKIZhIBv6uGpJ3RE7VUsaT0g8JXhDgn6SYfIGmDe
   Akw3KGX6Wf7KROz7DPO5Obg1e5mTSkGtc3fLoo56LIQ+nMhEdf3xofowC
   7Q4+O4kSbSwHTaNHOsOAPQkcXT//7G8JdXaFN3K2CcZs+QW2b6vtHlX9c
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="398800268"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="398800268"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 02:42:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="617123904"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="617123904"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 16 Nov 2022 02:41:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ovFre-00D5iI-1h;
        Wed, 16 Nov 2022 12:41:54 +0200
Date:   Wed, 16 Nov 2022 12:41:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>
Cc:     devicetree@vger.kernel.org, robh@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        alan@lxorguk.ukuu.org.uk, dirk.brandewie@gmail.com,
        grant.likely@secretlab.ca, sodaville@linutronix.de,
        devicetree-discuss@lists.ozlabs.org, linux-lgm-soc@maxlinear.com
Subject: Re: [PATCH v2 2/2] x86/of: Convert & update Intel's APIC related
 binding schemas
Message-ID: <Y3S+cgOm1vHq/kv9@smile.fi.intel.com>
References: <cover.1668589253.git.rtanwar@maxlinear.com>
 <5ba7963fbd82a859ffd99c6d8edb4d717fce0e6c.1668589253.git.rtanwar@maxlinear.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ba7963fbd82a859ffd99c6d8edb4d717fce0e6c.1668589253.git.rtanwar@maxlinear.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 06:28:21PM +0800, Rahul Tanwar wrote:
> Intel's APIC family of interrupt controllers support local APIC
> (lapic) & I/O APIC (ioapic). Convert existing bindings for lapic
> & ioapic from text to YAML schema. Separate lapic & ioapic schemas.
> 
> Also, update more info and newly introduced optional property for
> lapic to choose legacy PIC or virtual wire compatibility interrupt
> delivery mode.

Conversion should be split from a new property addition.

-- 
With Best Regards,
Andy Shevchenko


