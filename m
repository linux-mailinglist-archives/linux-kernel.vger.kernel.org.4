Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E681602E83
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiJRObA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiJROap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:30:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A9C9C21B;
        Tue, 18 Oct 2022 07:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666103443; x=1697639443;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zMnzECcq7UsdeairkvqeG/finXKvL3saHPbLkrRI2p8=;
  b=D3tMwDrAC87FjDBDeRseIhMW3Z1Q6WDbhJrxVqt0UF+2XB4F2HaeQyRI
   SCcxQGCMZVtjEU44PG/FLjRNS+vVe3xwclzFfUFRAfAvsotewhSxAdh+b
   wwmSuzYR5dGUBuExh/YtAqXI/R1l9FEv6ZcF58Qa5C5Ro5byxeydD3IBL
   ZdvocPj85PRGrwlcsdo3XNzZZgnDRWfLGifDQ6Do4U16r3ggXss4yY29f
   AMU0VkYiFyNVIpKJEHbG0BcJ8AFKgE2/Pm8xjL+LJ24C8bJHvwbq6Qdea
   arS8RH2a9Wm4RURb+xyO2bErCpvKNZnxaairo3vtRoLS3hCQhSYHb4wW6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="304856150"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="304856150"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 07:30:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="579812239"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="579812239"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 18 Oct 2022 07:30:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oknc6-009QCm-2Q;
        Tue, 18 Oct 2022 17:30:38 +0300
Date:   Tue, 18 Oct 2022 17:30:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] gpio: merrifield: Use str_enable_disable() helper
Message-ID: <Y064jqJsss8XCPD2@smile.fi.intel.com>
References: <20221017171448.63932-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017171448.63932-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 08:14:48PM +0300, Andy Shevchenko wrote:
> Use str_enable_disable() helper instead of open coding the same.

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


