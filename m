Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309B3739C71
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjFVJRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjFVJQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:16:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862B52D58
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687424940; x=1718960940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ovfx1LTbut8HywX7Xq3FCbWILW96L9FEgTbKCNIh7kk=;
  b=BXTPX0TXsG86F0Atzvz79q9kkmIcbdkeFB2CRGLA9aOVJW5RfLDHXofu
   HKloa0ze3qJZq4dxSN8sjS4s8+Mm9SEqs4wFAOyOIng9hXaJjZy4THw5y
   DteuEmUMFrv3kHvdMrO3cp7cuFuKsnUHMhg2regRUWWOID3piWcLMTFq6
   RXm6I9MHItZO5+MHz5jKKgCR1KKudNUrDq7F7AiqojgzUCBatGCR7CPaj
   +bFBLUqM096N+r8f/IpNJOqCRB+6qn3LhHmO1cK8EXh1CFPjjNJoq7WY0
   hurL/DOtPgdlnjQ5N2kqdMM1S4H9314cAI+YlwfR53TFtjOLUAQL7Zkch
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="359296552"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="359296552"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 02:07:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="961503684"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="961503684"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2023 02:07:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qCGHl-005jHK-2l;
        Thu, 22 Jun 2023 12:07:25 +0300
Date:   Thu, 22 Jun 2023 12:07:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH v1 0/2] bimap API: Add couple of files to MAINTAINERS
Message-ID: <ZJQPTcfzxM/9lHqY@smile.fi.intel.com>
References: <20230621162626.86033-1-andriy.shevchenko@linux.intel.com>
 <ZJM8TBQJjR40y9/e@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJM8TBQJjR40y9/e@yury-ThinkPad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 11:07:08AM -0700, Yury Norov wrote:
> On Wed, Jun 21, 2023 at 07:26:24PM +0300, Andy Shevchenko wrote:
> > During discussion
> > https://lore.kernel.org/r/20230509051403.2748545-1-lucas.demarchi@intel.com
> > I was started wondering why neither Yury nor Rasmus commented on that.
> > 
> > Hence I wanted to add some headers to the bitmap API MAINTAINERS for
> > watching the changes made elsewhere are they may correlate with bit
> > operations.
> > 
> > Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> 
> Thanks Andy!
> 
> Acked-by: Yury Norov <yury.norov@gmail.com>

Thank you! I assume you take them.

-- 
With Best Regards,
Andy Shevchenko


