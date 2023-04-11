Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FFB6DD9FF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjDKLrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDKLrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:47:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CC949D3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681213628; x=1712749628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eUX+Mcn7t6+AxvlSTyQrQHuBTa6YiZOFiRNNNVZZIsw=;
  b=ZVtCLk4vWpmqeJ7CYds8pOS122ZHvoZiZjW4rB7KcvKiGt7eN+PUOeuj
   txSqcbNdV3qcs1rZChT7JnSO+8819O7fW2EEYolAgjiGjd3fQMHLNvq5f
   R1oRBTVDncgzFAyLhP0+NuX82d1Ou32zc6TJOdp2y+YGc9niaKEXXx0/S
   bnDNwyRF+9UZ76sUXurygQUwuOmr8XLCw1yRD1j7YmRrgDL+2GJ2lr+40
   cpxDz8qIumHNk+SnLxCJMk5kTx1GpgQ1tSHbAnNo9uFSA59NS5hYut8XB
   qMOB71BjF5bXruZ4PO5UKMyAPK7Q4F070I5QND8DmzlL4Vuq69syJoMZT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="323229498"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="323229498"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 04:43:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="688573197"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="688573197"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 11 Apr 2023 04:43:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pmCPa-00FFEb-11;
        Tue, 11 Apr 2023 14:43:46 +0300
Date:   Tue, 11 Apr 2023 14:43:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Bumwoo Lee <bw365.lee@samsung.com>
Subject: Re: [PATCH v2 5/5] extcon: Drop unneeded assignments
Message-ID: <ZDVH8tfJGrxOeqm9@smile.fi.intel.com>
References: <20230405152745.24959-1-andriy.shevchenko@linux.intel.com>
 <20230405152745.24959-6-andriy.shevchenko@linux.intel.com>
 <faf0b76d-b7ad-0326-1058-ae879167d6db@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faf0b76d-b7ad-0326-1058-ae879167d6db@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 04:35:53AM +0900, Chanwoo Choi wrote:
> On 23. 4. 6. 00:27, Andy Shevchenko wrote:

...

> But this version doesn't contain my ack tag.

Oh, sorry, I somehow missed that.

> So that 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com> again.

Thank you and thanks for the review, I'll issue a v3 shortly.

-- 
With Best Regards,
Andy Shevchenko


