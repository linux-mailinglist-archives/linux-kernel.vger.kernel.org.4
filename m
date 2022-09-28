Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C825EE2E6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiI1RSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbiI1RSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:18:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2104895B5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664385481; x=1695921481;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hUrCqqG9CAkKv2NNX4W3EQZBrGnfPI+wUr7CsrSi1ls=;
  b=gkAO2f/mt/pH+8moFDNXXEqHaXHoacsRorPMv1s7zZR/mOPE09XgvB8Z
   W1FZhRunQ0fmDQF825AkOpmFgfjdpF2wMu1MJVRn050A0hNNKK8hPFDCX
   Vi8hXBGdc/yRfHws0AgZxH7Evaj+zXrW423RypX/vhVY48R/PofUDYZCx
   47p71Lk2mFSn5247gSZ1W+cS6WNYg2qSnbRqJiJe0DjSDV7Zw06dQx+AC
   7sD9BnmqlPBKD5plShdS5THxB1ZNHlY4Fq+rU3nn5icwOz+w6r6sZK+JD
   OH4zurJXKVtxiqKDqfqBmnSAMoHCMFG2HuZGphuJb93xLtdf+s9t3k50P
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="284797239"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="284797239"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 10:17:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="690473822"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="690473822"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 28 Sep 2022 10:17:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1odah2-0092JO-2C;
        Wed, 28 Sep 2022 20:17:56 +0300
Date:   Wed, 28 Sep 2022 20:17:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 1/1] mfd: syscon: Remove repetition of the
 regmap_get_val_endian()
Message-ID: <YzSBxI2TjmTGHu+1@smile.fi.intel.com>
References: <20220808140811.26734-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808140811.26734-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 05:08:11PM +0300, Andy Shevchenko wrote:
> Since the commit 0dbdb76c0ca8 ("regmap: mmio: Parse endianness
> definitions from DT") regmap MMIO parses DT itsef, no need to
> repeat this in the caller(s).

Any comment?

-- 
With Best Regards,
Andy Shevchenko


