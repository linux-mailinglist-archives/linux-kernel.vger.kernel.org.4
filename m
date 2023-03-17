Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828786BEAC4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjCQOMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjCQOMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:12:40 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3412ED7D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679062359; x=1710598359;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eifpQLMvSzmeClZNBGX6vEj8f3i9hiF71k3b+Ift7KM=;
  b=M0ll5rq2ls+zV773rVCY/g2UKA9SeYTo7DJIcUT0JBNQiUifpSS+omF6
   w7OTOCl55OQsb5P+zuXEur1biE3fh2hOvkQhKhpHJOzm8kL1BKPWs71ir
   CS8D4TmxaSOEWpXSA//g0sS8mStW3Sp143sthjs7mdMxlwk/4+QxXGbl5
   TKYAFJCG9mr9WlHE4F6zHEuqgWmLBlYK37prIcTw2NmXKDgUz3TrYVdkH
   2Z4KOg2eoSScLnuH7fSstpYUJZaAslbUIZ/Zzrs64kvXbf/mqcg3RVDpx
   +SVhASm2uBzSX53luGCRja/1cWFvZS8rFkoNdT+p/cLUDs8Rn6Edhc67B
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="326627272"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="326627272"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 07:12:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="673563000"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="673563000"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 17 Mar 2023 07:12:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pdAoY-0054Uk-0Q;
        Fri, 17 Mar 2023 16:12:14 +0200
Date:   Fri, 17 Mar 2023 16:12:13 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Graf <graf@amazon.com>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 1/1] mei: Move uuid.h to the MEI namespace
Message-ID: <ZBR1PWRY7ql7VIth@smile.fi.intel.com>
References: <20230310170747.22782-1-andriy.shevchenko@linux.intel.com>
 <ZBR0MVcQrokpSoRp@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBR0MVcQrokpSoRp@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 03:07:45PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Mar 10, 2023 at 07:07:47PM +0200, Andy Shevchenko wrote:
> > There is only a single user of the UUID uAPI, let's make it
> > part of that user.
> > 
> > The way it's done is to prevent compilation time breakage for
> > the user space that does
> > 
> > 	#include <linux/uuid.h>
> > 
> > In the future MEI user space tools can switch over to use mei_uuid.h.
> 
> When will that happen?

I don't know

> And why the churn, what's the problem with keeping this as uuid.h?

The problem here is a possible confusion with uAPI and internal headers with
the same name.

-- 
With Best Regards,
Andy Shevchenko


