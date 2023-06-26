Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB2D73DD01
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 13:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjFZLN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 07:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjFZLNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:13:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98876EE;
        Mon, 26 Jun 2023 04:13:51 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="361283944"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="361283944"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 04:13:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="716096630"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="716096630"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 26 Jun 2023 04:13:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qDkAD-006kCY-1H;
        Mon, 26 Jun 2023 14:13:45 +0300
Date:   Mon, 26 Jun 2023 14:13:45 +0300
From:   "andy@kernel.org" <andy@kernel.org>
To:     YE Chengfeng <cyeaa@connect.ust.hk>
Cc:     Kent Gibson <warthog618@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpio: gpiolib-cdev: Fix potential &lr->wait.lock
 deadlock issue
Message-ID: <ZJly6YWZsI3ItNRM@smile.fi.intel.com>
References: <TYCP286MB1188B6A0379F7928C63288DF8A21A@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
 <ZJk87rWsDj7pWJIP@sol>
 <3C977550-9829-4A6F-A5CA-04C938D77693@connect.ust.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C977550-9829-4A6F-A5CA-04C938D77693@connect.ust.hk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 10:38:53AM +0000, YE Chengfeng wrote:
> > 1) do you have any warning/oops/etc to show the real case?
> > 2) shouldn't we annotate with respective lockdep asserts this code?
> The bugs were detected by an experimental static code analyzer that I am 
> implementing. I don't have input to trigger it, so I manually review the 
> report and then send the ones I believe to be true to you. Perhaps next 
> time I should mention this while sending the patch.

This you have to mention in the submission.
https://docs.kernel.org/process/researcher-guidelines.html

-- 
With Best Regards,
Andy Shevchenko


