Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741C4627962
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbiKNJrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236187AbiKNJrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:47:43 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9911B9D8;
        Mon, 14 Nov 2022 01:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668419262; x=1699955262;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=Gpalpu21RKRFulktqp58KwlP1muAQsziW0lSdtUPcus=;
  b=I0NDEZQFmPIM+aL+ew6I506pGs6wOOgkQya0/nUTyHC1FaFaYQ3PhMdf
   eZRSLXXGmfoU9snC29XaKLILpaGUK2gkPtmUG2aQQHIXpHJ9K+/KCei9P
   bdBbYPdJT99XHIA7H2t4mDkgUzWyNEcAXC44RUCx3JvRW9LpDf9KZti/y
   XOdrzO3g2BJvInJMu91ZBKybzXHeGs86Vx8cVogOFPQGHsr5okwC7fAew
   dLnOOwcew0R+JaQqeuD4KUrrq7rl24QPivCRRs6Flvk16NWC2nPQ1Tb0A
   VEAMwrwzEgnLYzvMk1Pyr5vA4x72j4MTmUukSJaNI1wDYQzOFxWeO0mfj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="313074493"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="313074493"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 01:47:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="640706329"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="640706329"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 14 Nov 2022 01:47:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ouW42-00C6UZ-29;
        Mon, 14 Nov 2022 11:47:38 +0200
Date:   Mon, 14 Nov 2022 11:47:38 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] media: subdev: Replace custom implementation of
 device_match_fwnode()
Message-ID: <Y3IOusYrtZgC9BiY@smile.fi.intel.com>
References: <20220927171618.51971-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927171618.51971-1-andriy.shevchenko@linux.intel.com>
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

On Tue, Sep 27, 2022 at 08:16:18PM +0300, Andy Shevchenko wrote:
> Replace custom implementation of the device_match_fwnode().

Sakari, here you are in Cc list and I never have any response on this patch.

Maybe something wrong with emails somewhere?

-- 
With Best Regards,
Andy Shevchenko


