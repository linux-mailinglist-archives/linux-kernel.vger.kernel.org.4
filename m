Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8885A62D394
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 07:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbiKQGrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 01:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbiKQGrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 01:47:16 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992AC167C4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 22:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668667634; x=1700203634;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9lhgF53VlUlTMZEb2M4X8jJQKVgfHE75B9W23N8cuJI=;
  b=ORRNaukD+sHPU+0DGMHmM4EZen5DAldrMJH7fdiZlPlpp4RQrmyW4old
   ehjOlVi+/6MM3yLP0P71D4hlLsm1xV1ZlvKNHG5ssLF4J5sBSAmfCOzby
   oRbS7iToL/wHrdNVjm/ufiF7kif/wjjTid/ZkjMfp/03u8ZBgmf86h2V1
   nz5RMWN93pVEOAovsXg24I/8UXEoewyA3nNQXeNgy61RRjoAylv2rPyJu
   bIj+zVnDgJ6dwPLwvP2AtOog6mZ1Z4Ci5RhuOI/Hb+3Hg5cpSenGuRBoN
   6RCgSbYpStgs1sB41ZsD0e0DvZfWrb2485Qo5G8EUInkyOvKIO4LZcyVs
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="399062741"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="399062741"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 22:47:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="884736525"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="884736525"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 16 Nov 2022 22:47:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ovYg2-00DSyD-0w;
        Thu, 17 Nov 2022 08:47:10 +0200
Date:   Thu, 17 Nov 2022 08:47:10 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Fei Li <fei1.li@intel.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Subject: Re: [PATCH v4 1/1] virt: acrn: Mark the uuid field as unused
Message-ID: <Y3XY7maFECUPVIbv@smile.fi.intel.com>
References: <20221116092254.66234-1-andriy.shevchenko@linux.intel.com>
 <Y3TMmDXEbGyDQrLF@kroah.com>
 <Y3Tlu0BjgMk3xNDQ@smile.fi.intel.com>
 <Y3T/qJalJ9H224Mu@kroah.com>
 <Y3UKFQJJI/02QDWU@smile.fi.intel.com>
 <Y3WIdBYYoQQ0Ifqk@louislifei-OptiPlex-7090>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3WIdBYYoQQ0Ifqk@louislifei-OptiPlex-7090>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 09:03:48AM +0800, Fei Li wrote:
> On 2022-11-16 at 18:04:37 +0200, Andy Shevchenko wrote:

...

> ACRN does not use uuid recently. But before that, the old ACRN still uses it.
> So could we just change the uuid data structure definition here ?

That's what is meant by removing the Fixes tags.

-- 
With Best Regards,
Andy Shevchenko


