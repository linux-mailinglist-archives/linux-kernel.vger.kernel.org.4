Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7B35F8692
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 20:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiJHSVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 14:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiJHSVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 14:21:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423E641511
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 11:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665253301; x=1696789301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OWIiubz5fdA83E6sHScFPXfGeMg/96S0x3o/FGgfFQA=;
  b=TE+ZuIg9CuSFf+RTGOaNZ6WM2teyBnSTetcHZlJW8YL7b60S0GPY8Uh3
   /IrIaqwIO7IFyNZWpKkKuyih1TmEudgoH+7xU61n44n8tyyW+J/aC2sWA
   6me+M4YMr8zBDAtDKwJPaElx/5mA0ehr3AR3H9ujzrmtMhRwu95lwUME/
   z+UaoS0eVHYC5HxDDhc77gdD5yJem0G72i/UDzb4pv8WqnNY82ToT+JjE
   2qCc2Sam/kOJEdqKnDmHsylM71+9165V3sOpYJ7yiHRLjZVYcpS0EWbSt
   OpQriIatXB9pvvnecHL+X7A3lrUSSy67D4FX1tdszxsJ3dyxrmRtDZOER
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10494"; a="305558508"
X-IronPort-AV: E=Sophos;i="5.95,170,1661842800"; 
   d="scan'208";a="305558508"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2022 11:21:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10494"; a="658706046"
X-IronPort-AV: E=Sophos;i="5.95,170,1661842800"; 
   d="scan'208";a="658706046"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 08 Oct 2022 11:21:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ohES7-0048li-2p;
        Sat, 08 Oct 2022 21:21:35 +0300
Date:   Sat, 8 Oct 2022 21:21:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "jay.xu@rock-chips.com" <jay.xu@rock-chips.com>
Cc:     "linus.walleij" <linus.walleij@linaro.org>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "robert.moore" <robert.moore@intel.com>, robh <robh@kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lenb <lenb@kernel.org>, rafael <rafael@kernel.org>
Subject: Re: Re: [PATCH 11/20] gpio/rockchip: add of_node for gpiochip
Message-ID: <Y0G/r+mp59qRVqby@smile.fi.intel.com>
References: <20220920103108.23074-1-jay.xu@rock-chips.com>
 <20220920103108.23074-12-jay.xu@rock-chips.com>
 <CACRpkdZSCamhBD-M8CkZt6B3N9c2Jo_D3kwgOykj8+VJ_otYGQ@mail.gmail.com>
 <YzvvGValqxfIriGL@smile.fi.intel.com>
 <CACRpkdbA_h4m0cY98=0C2fCbTYEtowFRm9RF=tv=XSgjKxjcAQ@mail.gmail.com>
 <2022100814192810242455@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2022100814192810242455@rock-chips.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 08, 2022 at 02:19:28PM +0800, jay.xu@rock-chips.com wrote:

...

> the gc->of_node is a fix for my patch serial, without this the gpiochip will fail to register.

Do not use of_node. We have parent and fwnode members, use them according to your needs.

-- 
With Best Regards,
Andy Shevchenko


