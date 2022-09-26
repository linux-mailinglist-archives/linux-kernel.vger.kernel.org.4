Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075615EA5CB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 14:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239511AbiIZMSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 08:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239474AbiIZMRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 08:17:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB6D8A1FB;
        Mon, 26 Sep 2022 04:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664190060; x=1695726060;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nB29y1GYOUd0HbB8WJkijehIt5bscKQsE896rD960Zo=;
  b=F1ALqvAnWReIZYWP71Lnq5XoeWOHoNA0vO6z6po/N3Hkk3LPNmh4IbD6
   QOOlvJg6/nZtqyz/FZJi9ivSrwOUzVc8X9iuBt0PyHakj48uAu3KzmH5Q
   lJZScIeObLMT2olVme8xXLDwOgZ55+ltCbh/wPxYmj1FC7Yz+51mKlDu0
   pXbeU3ssiaJ8rh0ISDdkXwMF/sHjVVxgtA6vzhmUbQLjpDvrheJH3GgcZ
   h7HnPyBsb4f+4MdPMFB1HBJPBw4QwHY0BWLbD9R3sqc95/eSBHKajM0Q9
   YsJU8oslv2oKqWk0qAjre38IlVgkSeqJ9SZ70u80GMenxARxtNAvhdKUN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="288135876"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="288135876"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 03:57:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="689509636"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="689509636"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 26 Sep 2022 03:57:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oclo6-007lfB-1H;
        Mon, 26 Sep 2022 13:57:50 +0300
Date:   Mon, 26 Sep 2022 13:57:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] Input: lm8333 - add missing linux/input.h include
Message-ID: <YzGFrjXnJj+MEHrR@smile.fi.intel.com>
References: <20220923194738.927408-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923194738.927408-1-dmitry.torokhov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 12:47:34PM -0700, Dmitry Torokhov wrote:
> We are going to clean up matrix_keymap.h from unnecessary includes,
> so the driver needs to include API that it uses directly.
> 
> Also let's sort includes alphabetically and drop unneeded irq.h

For the entire series:
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for doing this!

-- 
With Best Regards,
Andy Shevchenko


