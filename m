Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD256650D53
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbiLSOdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiLSOc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:32:56 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF79D92;
        Mon, 19 Dec 2022 06:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671460365; x=1702996365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7AbPvSv1kPQXQdzO+u45Lqh+bdmfi8ejYkCELKLfYfE=;
  b=jwPL2x3Qk70mCrveo5xd5mD5+Ltoh26NBjtvTMnzS0iGAhHzjn0hOj+K
   kfp/UgsdA9qG5GpjLYyqOLS4FwoMdG1YDowvuJAPvbnBo9XgJo/HFC5/0
   cFSE0BdItbnDUPM13gAvTC+p2veDcKNG78VzVzd00IfzUSUEF7FY/dUsw
   Wp2Q5n+qxi46XJzf8+byGyS0ANslRbpY7WSNncGpRNbqaROC9H/LITN8L
   6hQendlTUmiv/zj+ti7431x8ZTvYzuFBxv8jr5E7jtApSZsZm/xZ5Sj1t
   lIHEpbyaO8WI+fGQqMSQzxlDKhQXcDtmJKcUcR/Uiwy06EUBf+y5AnM8Y
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="321254004"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="321254004"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 06:32:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="979392896"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="979392896"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 19 Dec 2022 06:32:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 4458911D; Mon, 19 Dec 2022 16:32:56 +0200 (EET)
Date:   Mon, 19 Dec 2022 16:32:55 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 01/17] pinctrl: intel: Introduce INTEL_COMMUNITY_*()
 to unify community macros
Message-ID: <Y6B2FyOvOK2rR9H9@black.fi.intel.com>
References: <20221219122643.3513-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221219122643.3513-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, Dec 19, 2022 at 02:26:27PM +0200, Andy Shevchenko wrote:
> Now it becomes visible that we can deduplicate SoC specific
> *_COMMUNITY() macros across the Intel pin control drivers.
> For that, introduce a common INTEL_COMMUNITY_GPPS() and
> INTEL_COMMUNITY_SIZE() macros in the pinctrl-intel.h.

You should really start learning how to use --cover-letter option with
git format-patch because for anything more than one patch pretty much
requires such. Here I would really like to see how much lines this
series ends up removing :)

The series looks good to me, though.
