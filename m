Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59042614DF1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 16:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbiKAPLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 11:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiKAPLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:11:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056B01A380;
        Tue,  1 Nov 2022 08:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667315066; x=1698851066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hYrWyDx+OkwlhfrqmQICzcLjxPkbWXHK/iIT9BOIzhE=;
  b=CYdNiIY3kZuw/83pfoOoVubnkMIZq18yMNvZMh4nT6HnOWuVCNO6ZdUb
   Z4CilyyBCp9lFtanjJpCh+DlHxzl+Sms4jvu9S9iQ6v95R+mgnNd7BYk7
   uGBE3kmHdILqIvpz+j/x+Nn0WELJcrffKBCtYzX+BX6XT5tc08+rNQlSb
   JrYF/H7GIQVMKH/lvK8xgdIaoqYsPuX9w9e63tJVqso+lW2p7ZOp43fDQ
   /qeF1quC1eCI8W+6veQ9Xi9Hregi94IeRpb7RITDUvSDkR91MX0P9rfYu
   cGVoDjEKIlSXzSTL3RlOiXHg1DiAFqrPjW5hFMEfJT2IpE9fblLIs0ENA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="335824181"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="335824181"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 08:02:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="879110355"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="879110355"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 01 Nov 2022 08:02:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1opsmr-005dgq-28;
        Tue, 01 Nov 2022 17:02:45 +0200
Date:   Tue, 1 Nov 2022 17:02:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH -next] pinctrl: qcom: Include bitfield.h in
 pinctrl-lpass-lpi.c
Message-ID: <Y2E1FbRvyN6myNR2@smile.fi.intel.com>
References: <20221027191625.1738204-1-nathan@kernel.org>
 <Y1rcUbCVJi7QhcFK@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1rcUbCVJi7QhcFK@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 10:30:26PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 27, 2022 at 12:16:25PM -0700, Nathan Chancellor wrote:
> > When building ARCH=arm allmodconfig, the following error occurs:

I have pushed my version to the tree, so it will appear in the next Linux Next.

-- 
With Best Regards,
Andy Shevchenko


