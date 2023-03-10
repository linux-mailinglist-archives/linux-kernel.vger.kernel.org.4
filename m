Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563976B4B51
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbjCJPlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjCJPkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:40:41 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB16415334C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678462061; x=1709998061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MCjYveW72ixEmjq/t3nhNug4QPEnKnwQerd/TqalPxI=;
  b=V/qxJnWpP+9VXWdX0vchzzgQoEcuFol1Jywyd43N/rpQMx1nm7H9271z
   UvaRGx1aNVBkE8WJvRhz3jdrcFWzYUubmOpotq/86oHVbDtrVYUtrsWLy
   Lj/EmQ8AGvuTdyTQFoReqAGoKzab7IUIiFfac31NvLsmy2yOag4sxA4nX
   62/1mbsgiMhraK5YBAxNkAtAOjRiRLKg8tHFgIQQ3Td9gQhgTRloTRjR9
   Fp+9eAXHJQzbJe48WebAAOSQqE2RAPRDUqFGNhiUdb+XbO5ukHcFgD13l
   ZVm0fUlS6UApbxOtpZd+hDiWYj2/UKzgiCUVIdKoA56QgCdw26Vji0PPW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="339114763"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="339114763"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 07:27:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="710312619"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="710312619"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 10 Mar 2023 07:27:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1paeeX-000zwM-0E;
        Fri, 10 Mar 2023 17:27:29 +0200
Date:   Fri, 10 Mar 2023 17:27:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v1 1/1] extcon: palmas: Remove unused of_gpio,h
Message-ID: <ZAtMYGLrTj2BgcwP@smile.fi.intel.com>
References: <20230215165035.83657-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215165035.83657-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 06:50:35PM +0200, Andy Shevchenko wrote:
> of_gpio.h provides a single function, which is not used in this driver.
> Remove unused header.

Any comments on this?

-- 
With Best Regards,
Andy Shevchenko


