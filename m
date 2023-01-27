Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8F167E691
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbjA0NZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbjA0NZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:25:30 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53F168AD5;
        Fri, 27 Jan 2023 05:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674825929; x=1706361929;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/5m6JtPV1vwzSq5kX/NBT8Ie+9nJpPQikfx5o+w8qx8=;
  b=DMRDQSELvrFpHuKsPzm6cbf+IxB0lRfChDwux9/a+/Lkel0zgZTCq8ss
   4Uik7djtjW3ge4tqDglN1MpmDSxKpItit+zMg3xT1IcCnGhVuzNQh0EPs
   KXcvD4qMiadjF6NyH1RFPb1P88nEnOjUOcM5Is6YfO4Atf5UvVngKPNhj
   UIVKsB4vWv0acjzvH5SbdOsNFEIMacyJ8WkbYeZiEMJXEoQPb/AGGgrKu
   ZOQjaOHQ5off91tIe0U+pYoLmHZMTeVc4MEzGdoO9gXAQXWBfdfTH00Zl
   QJO5PKpg2j1cvcXegu/SacrgJwMKfW2Apy6yaWY+NHgjUHamDpJvz2PZU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="310705434"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="310705434"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 05:25:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="640690830"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="640690830"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 27 Jan 2023 05:25:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pLOjM-00Fyw4-2y;
        Fri, 27 Jan 2023 15:25:24 +0200
Date:   Fri, 27 Jan 2023 15:25:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v3 2/2] kbuild: make W=1 warn files that are tracked but
 ignored by git
Message-ID: <Y9PQxCTJGTRU1cuE@smile.fi.intel.com>
References: <20221229074310.906556-1-masahiroy@kernel.org>
 <20221229074310.906556-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229074310.906556-2-masahiroy@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 04:43:10PM +0900, Masahiro Yamada wrote:
> The top .gitignore comments about how to detect files breaking
> .gitignore rules, but people rarely care about it.
> 
> Add a new W=1 warning to detect files that are tracked but ignored by
> git. If git is not installed or the source tree is not tracked by git
> at all, this script does not print anything.
> 
> Running it on v6.2-rc1 detected the following:

Since patch was published there is no sign it was ever meet Linux Next.
What's the plan?

-- 
With Best Regards,
Andy Shevchenko


