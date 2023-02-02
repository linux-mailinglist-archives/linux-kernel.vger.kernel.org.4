Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C816882D7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbjBBPkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjBBPkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:40:22 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB92F23C7D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 07:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675352398; x=1706888398;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tklnhT8GNmJ7trqLgHdVnPc2VC3uRP06uBquwx2Tfng=;
  b=QVYyER+IaWmCVYGeJJ6qZnDRvjwzo0OqSS0s1Ml6hd9/c6lqHvLDCxWX
   tC5Hmuz1Ln8+P3oMAB+R/sonw2G+wcp/UwIcpNy/kX8BWsFOSETUBI4Nr
   Z+dcrUp/oYpKse1MD0K3IhbHaoWTLxhfB4hrzD3cCg8GTGYu1TMkfdEUR
   +mN2VmClbu30xkTwtk1CYz5Z4AApqhHM+PX6LATodjdkl7b96A9uS/L83
   g+lMK7tjxVXPJ2IGJkQat1/xRBo/df8pVy13AA/RWyKZUYe/paks89Jg7
   hBQek524wYGMo3nakMsPGgvPFTYbHHY0i82AK3Fvr4Rfq54gIcnIBpuOn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="414681206"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="414681206"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 07:34:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="839247590"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="839247590"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 02 Feb 2023 07:34:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pNbbM-001EgL-0Q;
        Thu, 02 Feb 2023 17:34:16 +0200
Date:   Thu, 2 Feb 2023 17:34:15 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>
Subject: memchr() vs. memscan()
Message-ID: <Y9vX95GpI272VKn0@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why do we have memchr() and memscan() implementations in lib/string.c?
As far as I can see the one may be derived from the other easily.

-- 
With Best Regards,
Andy Shevchenko


