Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB4362D39E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 07:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbiKQGvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 01:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbiKQGvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 01:51:01 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1785E9CA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 22:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668667858; x=1700203858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3yp9zZdhoWMWlvE8Bu/fqA7QS/7tpyYvnNuGi3StvMs=;
  b=Q15sDuaXh7d7n84kfPFzc1Gne45bDmKytlnwQn20A9pHSGro2pNm9RfT
   ErIqhqJ/SxQ5uOdhafRaxmBUYsNemIXD1q8SsfakTcLQCsvdAo2aFWLx4
   YlEhoO4R4Td92BX2UXRZ4nMJJiydd7EBA5rzehSqaEU3rKtq5LOMQZOth
   oqWnAuQInHAPRNMWzlMkEsjjfb754YWdRHjwT1Mt1tPucyCBNzRezRIr0
   5uM5kH5V+DJdQF+dcPA900jzodf5S3xVIREWs7e44IJL5fsOFBhiyRcwD
   ny/aSagEOh1bPBDDOU2j+BLz7KnsRTyxNu536cAHdP3nSOs0VEKVf50EE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="293169999"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="293169999"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 22:50:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="782096004"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="782096004"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 16 Nov 2022 22:50:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ovYjf-00DT2v-18;
        Thu, 17 Nov 2022 08:50:55 +0200
Date:   Thu, 17 Nov 2022 08:50:55 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Fei Li <fei1.li@intel.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Subject: Re: [PATCH v4 1/1] virt: acrn: Mark the uuid field as unused
Message-ID: <Y3XZz04Ev2iQUyKz@smile.fi.intel.com>
References: <20221116092254.66234-1-andriy.shevchenko@linux.intel.com>
 <Y3TMmDXEbGyDQrLF@kroah.com>
 <Y3Tlu0BjgMk3xNDQ@smile.fi.intel.com>
 <Y3T/qJalJ9H224Mu@kroah.com>
 <Y3UKFQJJI/02QDWU@smile.fi.intel.com>
 <Y3WIdBYYoQQ0Ifqk@louislifei-OptiPlex-7090>
 <Y3XY7maFECUPVIbv@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3XY7maFECUPVIbv@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 08:47:10AM +0200, Andy Shevchenko wrote:
> On Thu, Nov 17, 2022 at 09:03:48AM +0800, Fei Li wrote:
> > On 2022-11-16 at 18:04:37 +0200, Andy Shevchenko wrote:

...

> > ACRN does not use uuid recently. But before that, the old ACRN still uses it.
> > So could we just change the uuid data structure definition here ?
> 
> That's what is meant by removing the Fixes tags.

Note, this change also removes the link to non-existing file.

-- 
With Best Regards,
Andy Shevchenko


