Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26A6604821
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbiJSNuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbiJSNs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:48:58 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EDF19E90B;
        Wed, 19 Oct 2022 06:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666186386; x=1697722386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uMSS2UGALuEpzvvAM47D5sxAZNzAFsz3tkvccmabASw=;
  b=jS3uZQIfZTGBP4YKRFEKP46zzLs2PGAsvGfPVC9R4QA9wizh5V/FyHMK
   1GolAJIy5jlsZklxwFPv7UKBQNBLMPxCIC3BIdXuzfXw5Vz9qQI0+P+fp
   loGhT1LFXVWmQunB+F+mByxdWhcW1tCzHVxmc/ayF5WhJoC0obli7ypgw
   3UTLqvj1ocDM1aUSy88UoWoK9Ycj5lgeoZ4RUeahGmp4MocIDxa5BcOVC
   kEcbTgmxwPEnoP+JJj/yEsmcp59hQBv+k5qI2rdVa08K2j48QZeurBdxD
   IRvSsof26qgsLIcrkskwwxYpOHgCITATAkB1svygDeEKUwLnMjTWA2FW5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="307517393"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="307517393"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 06:32:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="631670176"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="631670176"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 19 Oct 2022 06:32:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ol9BX-009sV1-2C;
        Wed, 19 Oct 2022 16:32:39 +0300
Date:   Wed, 19 Oct 2022 16:32:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     chengwei <foxfly.lai.tw@gmail.com>
Cc:     lee@kernel.org, broonie@kernel.org, rafael@kernel.org,
        mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        GaryWang@aaeon.com.tw, musa.lin@yunjingtech.com,
        jack.chang@yunjingtech.com, chengwei <larry.lai@yunjingtech.com>
Subject: Re: [PATCH 3/5] ACPI: acpi_node_add_pin_mapping added to header file
Message-ID: <Y0/8d66G3HndiRJF@smile.fi.intel.com>
References: <20221019022450.16851-1-larry.lai@yunjingtech.com>
 <20221019022450.16851-4-larry.lai@yunjingtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019022450.16851-4-larry.lai@yunjingtech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 10:24:48AM +0800, chengwei wrote:
> Declare acpi_node_add_pin_mapping added for pinctrl-upboard
> reference.

This should be a part of the next change.

-- 
With Best Regards,
Andy Shevchenko


