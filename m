Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00076ACE70
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjCFTtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCFTtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:49:22 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E43E3E09E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 11:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678132162; x=1709668162;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PpZTzDEzJRgmj5SZWgSzAgUxrR0le5Z07o9pFB5Z9wQ=;
  b=HFMuqQVMm3TIvOH8e1FKOBlz7cMxBoKAPZGypLdegSGBjGzY8viKVeMf
   wiRJ1gux0pLI3I5SkM6YKCinpNrUWma0/m3f77J5A4N47Pc0Fws9jDKc/
   vddmUBj1HOLB6vnlWUYdpy7eiNuZ3psQT22cjmnZbotAIpBN0zhTUD6Xo
   KvSjdUWAezR2JrXefPVHwHjcJwCJrCkZQH1nO/juf+QGhi+ssZBsfFH+f
   huY0CXfipRA4h7exGknZQesiM0+h7xBOXYmgaVbVrRagWXEQZqhVLxM1n
   WA/UloY1bvsIwq5OLRUUK89hFdACcaHQxN0P26oGo3OdpM9Hf/m8Pcybn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="400482579"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="400482579"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 11:49:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="800113757"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="800113757"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 06 Mar 2023 11:49:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pZGpi-00Gb25-2N;
        Mon, 06 Mar 2023 21:49:18 +0200
Date:   Mon, 6 Mar 2023 21:49:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] cpumask: Fix typo nr_cpumask_size -->
 nr_cpumask_bits
Message-ID: <ZAZDvtjsjxrbbEeA@smile.fi.intel.com>
References: <20230306152204.49836-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306152204.49836-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 05:22:04PM +0200, Andy Shevchenko wrote:
> I think the never used nr_cpumask_size is just a typo,
> hence use existing redefinition that's called nr_cpumask_bits.

In another thread we still mention this. Interesting...
what did I miss?

-- 
With Best Regards,
Andy Shevchenko


