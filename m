Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D7E5EF2C8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbiI2Jyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiI2Jyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:54:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015006416;
        Thu, 29 Sep 2022 02:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664445277; x=1695981277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FKJIqIOjD7O58rCy3DCADTX68jS2hOVZg1/xubNNFCs=;
  b=hsUqC2SWcpZCrn7emZtiYtljDtiSG0c6qZLQKaU9xaBbKBD2QG92z04Z
   AZaxcC1W6MCbeOOqPn/EuGyH7p7KQiqvb90LvA6L2OXM6V31cc6B60Fv9
   2K8H1opOH7d1UqzYPE+EQ+XXRkhKqwaoor3VjwuwHINbnIYcjyyqHm1ew
   6XZhp8OeLTPq0BTVLiZdtM31L0qecuU8RP9DL3i/c79OUzpsyar+5vd3C
   UL8xgqD56rQ4hRvCBBEQNuHE8jOHdPThEuBgcJr855afz/3yk7+OrxRXs
   3sYwxsfejTVJKDDYqaPTiikMZW5XuaTuCca5syj+NXQMMfRsFZHTsSK45
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="388130820"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="388130820"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 02:54:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="622295791"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="622295791"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 29 Sep 2022 02:54:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1odqFR-009KvT-2P;
        Thu, 29 Sep 2022 12:54:29 +0300
Date:   Thu, 29 Sep 2022 12:54:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     hdegoede@redhat.com, markgross@kernel.org, rafael@kernel.org,
        lenb@kernel.org, hmh@hmh.eng.br, matan@svgalib.org,
        corentin.chary@gmail.com, jeremy@system76.com,
        productdev@system76.com, mario.limonciello@amd.com,
        pobrn@protonmail.com, coproscefalo@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: dell-ddv: Minor style fixes
Message-ID: <YzVrVadhQdIDKP8F@smile.fi.intel.com>
References: <20220928221501.3823-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928221501.3823-1-W_Armin@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 12:15:01AM +0200, Armin Wolf wrote:
> Fix some style issues found during review to improve
> code maintainability, no functional changes.
> 
> Tested on a Dell Inspiron 3505.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


