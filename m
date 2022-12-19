Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B32650D57
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiLSOeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbiLSOeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:34:09 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D03204;
        Mon, 19 Dec 2022 06:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671460448; x=1702996448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4zJim5syjwTCO1ZKhJMIDJLYaQP0FGp1hH1PHRAopJQ=;
  b=GcpUQ2/P2QnTGmlhbl/G6SOGo/+ymukR3tPdlBFwVbV5DG8bwTkc8GE2
   uQDO0BI3ISsa5STJ7TTo+q8UW9W/I8SthL1sZ9KjGRcjhPh2vRzEPA/GX
   lF4fWDhYMKxG6BcPUWNRhKGTKHpA7kfWnq4DXp/xY1Bt3UZutFzmZ1tHi
   HW8AxNgHhbglwT2WVjfciBbZ3aQyrcLtqdZVBJb+t6U+yVBEnsaJLdHyX
   M18sQyPa4W5SkGc/UXuhT0qWNi5RuEDhiCBidLM7cbIuxwpGwa+iPVZMq
   UPHjBA6j2kRYz3KgQSgrE0vdDla9fNSMFjBqVc9/1way8ubYHq2C6h1P1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="321254374"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="321254374"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 06:34:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="979393144"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="979393144"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 19 Dec 2022 06:34:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id BFDC511D; Mon, 19 Dec 2022 16:34:35 +0200 (EET)
Date:   Mon, 19 Dec 2022 16:34:35 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: intel: Use same order of bit fields for
 PADCFG2
Message-ID: <Y6B2e17sDuUxUgpY@black.fi.intel.com>
References: <20221219123229.5564-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221219123229.5564-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 02:32:29PM +0200, Andy Shevchenko wrote:
> PADCFG0 and PADCFG1 are ordered from MSB to LSB, do the same
> for PADCFG2 bit fields.

Perhaps:

No functional changes.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
