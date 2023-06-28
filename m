Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C2D740F0D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjF1KnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:43:02 -0400
Received: from mga05.intel.com ([192.55.52.43]:57087 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230481AbjF1Kks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687948848; x=1719484848;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2Zmhe10xKcWrQRM+knMSqhQmXAMpUf7kd2FjgsGcrkY=;
  b=hshj4b30L4r6KWirqS/lPTh/EGPA9UtAGKed1hsR1GY4jCDK2lSumDOH
   jBK89CLhX4/Sl3ax5RpkSr3EgJl9EikKUSXluMtxdG9EYv9FVRDqh4GSv
   N5R/QVXpIwbjI8G81BZdbZJmVrsXej8uyGqVdQOtWbJBuEwJd17ain2Dc
   X8+3KxRgbLz80yGbGumnC3pHOIIVVrVFMCDtAcVKfUonKvNFK07Rn8Uu3
   LloEH5woG66vVMR3uyJJXcFpPUhcAbxphiMhhQ1QBud/i/DZ5+qA4037Y
   Yft1E+JgAbB95TC7Ax3uZVTzz46jNJhyQA5i49hGW2rUiuWERrcYtEzbT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="448193894"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="448193894"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 03:40:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="667067110"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="667067110"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 28 Jun 2023 03:40:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qESbI-000Yvj-2P;
        Wed, 28 Jun 2023 13:40:40 +0300
Date:   Wed, 28 Jun 2023 13:40:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Luo Jiaxing <luojiaxing@huawei.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        john.garry@huawei.com, himanshu.madhani@cavium.com,
        gregkh@linuxfoundation.org, uma.shankar@intel.com,
        anshuman.gupta@intel.com, animesh.manna@intel.com,
        linux-usb@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v4 0/5] Introduce a new helper macro
 DEFINE_SHOW_STORE_ATTRIBUTE at seq_file.c
Message-ID: <ZJwOKJSgLg3Zhdxt@smile.fi.intel.com>
References: <1605164864-58944-1-git-send-email-luojiaxing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605164864-58944-1-git-send-email-luojiaxing@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 03:07:38PM +0800, Luo Jiaxing wrote:
> We already own DEFINE_SHOW_ATTRIBUTE() helper macro for defining attribute
> for read-only file, but we found many of drivers also want a helper macro
> for read-write file too.
> 
> So we add this macro to help decrease code duplication.

Is it abandoned?
Besides kbuildbot complains, can you simply reduce the scope to one subsystem
and resend?

Let's say USB is nice one and it has no issues according to kbuildbot.

-- 
With Best Regards,
Andy Shevchenko


