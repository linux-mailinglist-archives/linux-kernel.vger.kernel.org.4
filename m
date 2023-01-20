Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B60675854
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjATPTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjATPTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:19:04 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1454D88DA;
        Fri, 20 Jan 2023 07:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674227943; x=1705763943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6lgRC7edN3IGgPrjEACHoByxWAGoJ3PKf3o+cbcIsBM=;
  b=eCLFPTId+W3piI+2+L/paf5pSXdzCGhyDSxHm4Hrp26x8b+F+7jzRNIp
   /gPihuqWjBNZT6nBrcqd/RgKxCOcrdrT3NlR5j5am2pxWhqyUJaIAlt6W
   Q1+3UV6YsR0IC3DxO1KhwHm0RtCKM+PYAsD9wXUE2Jlx1d1qqUIlHwOzA
   YJfMQzzoNRfqwzc84owtcXL+rOGWGMNOmAeQShOwV+E3MhKLohODhc8MU
   ijRuh7PLFo9/mprsqvuNyV/cR3eAV9XcQnA4ORDODOs5qAXiDE+3zOReW
   C9pFdyjIJg1Zo3MVPPORID/82aTkTIbzcaTJ+10ttDKkql18/XR4kCK4h
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="313484844"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="313484844"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 07:19:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="989423478"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="989423478"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 20 Jan 2023 07:19:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pItAQ-00CHaY-0u;
        Fri, 20 Jan 2023 17:18:58 +0200
Date:   Fri, 20 Jan 2023 17:18:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Luca Ellero <l.ellero@asem.it>
Cc:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, u.kleine-koenig@pengutronix.de,
        mkl@pengutronix.de, miquel.raynal@bootlin.com, imre.deak@nokia.com,
        luca.ellero@brickedbrain.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Input: ads7846 - fix support for ADS7845
Message-ID: <Y8qw4kx0KEaLPsUA@smile.fi.intel.com>
References: <20230120124544.5993-1-l.ellero@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120124544.5993-1-l.ellero@asem.it>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 01:45:41PM +0100, Luca Ellero wrote:
> ADS7845 support is buggy in this driver.
> These patches fix various issues to get it work properly.

Code-wise it's fine. It would be nice to amend the commit messages.

-- 
With Best Regards,
Andy Shevchenko


