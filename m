Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BCF614DEC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 16:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiKAPLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 11:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiKAPIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:08:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127361EC4F;
        Tue,  1 Nov 2022 08:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667314918; x=1698850918;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JQ1lTj2lqZx7DC5afP1JL1wnOdepQj60udlfX3dHNyI=;
  b=XGSfFNqterg2zKIKYqZwlxKkvIyG4QYxLOkUnTINgy6KWBGGqkg9li7q
   klNxTSRLec+PpE6hShJfXwtmNbrOxOZ4ftbiK3nqd5rbZ3ne9zx1qyYEE
   4UXkeUgIIribT73ZxDUgu4zGKczza9ilKDbRKXgp0l5sAKIYqojCNwLaX
   S7l5vaDKZ+mnr1KmA5o9QYuvcb3mT1B9b+ghpQlH9OEQS19cUcLt+5x/P
   MZeHnJPKkAbd/Pa8JKDH7i/+dfrKCnjptpdx2zWxRqxR1m6q8zo7uTlDP
   BOQ0hZpCXjOUmMXkNhjleEMB0fhHu1NuU8Yl7NBbV1Ja/mSvFGG8nQeJ0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="289544198"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="289544198"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 08:01:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="636424912"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="636424912"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 01 Nov 2022 08:01:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1opslY-005dfY-0X;
        Tue, 01 Nov 2022 17:01:24 +0200
Date:   Tue, 1 Nov 2022 17:01:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] pinctrl: qcom: lpass-lpi: Add missed bitfield.h
Message-ID: <Y2E0w+SgyPOfBPaM@smile.fi.intel.com>
References: <20221027184145.2533-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027184145.2533-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 09:41:45PM +0300, Andy Shevchenko wrote:
> Previously the cleanup change dropped the bitfield.h from the
> pinctrl-lpass-lpi.h, since it's not used there, but forgot to
> re-instantiate it in the C-file, where users are located.
> 
> Fix this by adding missed bitfield.h to the C-file.

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


