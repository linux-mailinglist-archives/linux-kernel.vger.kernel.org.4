Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF5873E099
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjFZN0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjFZN0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:26:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8882613D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687785967; x=1719321967;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l3I567JqO5KMCBIUecx9Hm3MVttkk0qQQyX2t1ijyJc=;
  b=CPZHAGhejs2+6z6sL+qkFAtoExq37tT72Ve7oo+SyKQi2THEYSm7oQOZ
   pH3cKuPNTpBZU1uRfeRU2vvUeaqNPCcHUFPhYT+JTnhdSvE7XBZOPuKqk
   W+HsmkYu/BEYe2mr/geLFRTOUS+hP6UObgJOZjDmmPtsVJD5GNNblR4wN
   oIRAiZ81dKyHEq4GjLxP0EeGfMoxAX8aDonRF1SjNpNgOR0MY03mZxKvM
   b9RFKIEunvae1LnvJZXWxivwvnWSgVccFHAispGm++SS8WR8mif8b8Zwp
   3qSqNRLOPoX++61v0i+A8wc4otpffWOcOdzVlNKcp0KPlrp9casSgFxhj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="358760546"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="358760546"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 06:26:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="719353606"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="719353606"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jun 2023 06:26:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qDmEF-0002hf-2o;
        Mon, 26 Jun 2023 16:26:03 +0300
Date:   Mon, 26 Jun 2023 16:26:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Yury Norov <yury.norov@gmail.com>
Subject: Re: lib/test_bitmap.c:920:2: error: call to __compiletime_assert_372
 declared with 'error' attribute: BUILD_BUG_ON failed:
 !__builtin_constant_p(res)
Message-ID: <ZJmR6zrjDZgDvWCA@smile.fi.intel.com>
References: <202306250533.CBxzOSEh-lkp@intel.com>
 <ZJlNMwzlt2MGTvBp@smile.fi.intel.com>
 <0e50e878-3944-c57c-1dbf-10d260f05afc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e50e878-3944-c57c-1dbf-10d260f05afc@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 01:57:46PM +0200, Alexander Lobakin wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date: Mon, 26 Jun 2023 11:32:51 +0300
> > On Sun, Jun 25, 2023 at 05:12:36AM +0800, kernel test robot wrote:
> >> Hi Alexander,
> >>
> >> FYI, the error/warning still remains.
> > 
> > Alexander, do you have anything to present to fix this? Or is your plan to send
> > something after v6.5-rc1?
> 
> I was waiting for an email from Nick (or some further update of the
> GitHub issue page) to clarify whether the compiler should be fixed or I
> should work around this in the code.

Okay, got it! Maybe you can ping him?

> If the latter, I could send a fix
> this week, so that it could even hit the bitmap pull request.

It could hit a PR after v6.5-rc1 (Linus expects the following: a) the PR
to be send in the _first_ week of merge window with rare exceptions, and
b) the commits in PR has to be sit in Linux Next for a while, usually
a couple of weeks).

-- 
With Best Regards,
Andy Shevchenko


