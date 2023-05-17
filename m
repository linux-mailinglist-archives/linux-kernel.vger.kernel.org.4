Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C2A706312
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjEQIin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjEQIiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:38:12 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA5640F4;
        Wed, 17 May 2023 01:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684312667; x=1715848667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RA5KBFCzqh2bbXyYZKRZdmjtf2cxumiPvVCk4Leqzzo=;
  b=VRJQYbdYhyiARI54kHjWzxDYHBwn8Pn/fsNXngH4hPpK9D9vG52ZeEJc
   QbVlz3g7TIMNtVrjuw0y2GRVZhuaSGdFQFa7idSYwt0xSbbfeYe2Axgor
   cTBHA6PHjhZa5WK+4vZg7VV/HjLq6DiXrNUwKnIYh0cbV4SFE5BS6BKbY
   St8s/SoRYfFb7c2qPVM/nycIRcCMMHOxHXfYCx71DrphUtorRclBjasOI
   wIPXVLXsRnSrcWCQlxEObNoieXkZH5V4sC0vcj4Lr7/SXPBaIMB/GcqMz
   z3+NjyzAy2Nv7xZdnghHUfoVRTXMDZuxNF5EpUfuUBLQeceEuVu9wUryU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="332062500"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="332062500"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 01:37:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="695783883"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="695783883"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 17 May 2023 01:37:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 6CF61618; Wed, 17 May 2023 11:37:54 +0300 (EEST)
Date:   Wed, 17 May 2023 11:37:54 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Watchdog Drivers <linux-watchdog@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ray Lehtiniemi <rayl@mail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Deepak Saxena <dsaxena@plexity.net>,
        Marc Zyngier <maz@kernel.org>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Sylver Bruneau <sylver.bruneau@googlemail.com>,
        Denis Turischev <denis@compulab.co.il>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>
Subject: Re: [PATCH 1/2] watchdog: Convert GPL 2.0 notice to SPDX identifier
Message-ID: <20230517083754.GD45886@black.fi.intel.com>
References: <20230517072140.1086660-1-bagasdotme@gmail.com>
 <20230517072140.1086660-2-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230517072140.1086660-2-bagasdotme@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 02:21:39PM +0700, Bagas Sanjaya wrote:
> Convert the boilerplate to SPDX license identifier. While at it, also
> move SPDX identifier for drivers/watchdog/rtd119x_wdt.c to the top of
> file (as in other files).
> 
> Cc: Ray Lehtiniemi <rayl@mail.com>,
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Deepak Saxena <dsaxena@plexity.net>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Jonas Jensen <jonas.jensen@gmail.com>
> Cc: Sylver Bruneau <sylver.bruneau@googlemail.com>
> Cc: Denis Turischev <denis@compulab.co.il>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

For ts72xx_wdt.c,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
