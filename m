Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9C9738579
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjFUNkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjFUNkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:40:51 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0F81981
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687354850; x=1718890850;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dmo767OTUQjtr6TpU8qEzcebBee6ZirqbrmdGgDPwQw=;
  b=dVlXTemmKHoOJIM0NIfsfEIZh1/JJnFWXgQK8qjnMHp8SiWgNgK5ENEQ
   c4TwCJvpEZ4mvMsBK3HvLhVhczuQS+pHmy8xyF/3jD9dCAC1B9m6zkFkz
   H63YqZZc7BPbOFTNfAo3WCLl5zlpkGqOYnbaa4BZU5YqmlhWsSJWigFmw
   8fFxAfFtnjei00ORa+3cBAWev+NHh9ADxKcB+5vjKEzCEdfLwveyBMN7j
   98MrlLGR6GS7UA1T8QQjiroBQ+8hCDWxRYAJoakwZlDZ9nJbVzFd7SfKE
   +1EzuWrFXQhO4ym9yrTb3b8a0yYALqHy9bvWWHr0zUPl7HgoUqyZpGNYm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="340519647"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="340519647"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 06:40:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="714493753"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="714493753"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 21 Jun 2023 06:40:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qBy4k-005VdW-37;
        Wed, 21 Jun 2023 16:40:46 +0300
Date:   Wed, 21 Jun 2023 16:40:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: AtomISP and V4L2 new build warnings?
Message-ID: <ZJL93k3xTe5G1IDD@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today, on Linux Next, I have got these (among others):

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/v4l2-core/v4l2-async.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/v4l2-core/v4l2-fwnode.o

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/media/atomisp/i2c/atomisp-mt9m114.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/media/atomisp/i2c/atomisp-libmsrlisthelper.o

And since Hans is maintainer of PDx86:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/intel/pmc/intel_pmc_core_pltdrv.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/classmate-laptop.o


-- 
With Best Regards,
Andy Shevchenko


