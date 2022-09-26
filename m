Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F845E9E69
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbiIZJyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbiIZJyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:54:37 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8011533A3D;
        Mon, 26 Sep 2022 02:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664186068; x=1695722068;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ITZD2uCyqrgDqZD0u+6PumW+aD/34vkV4w5Fw7dN2xo=;
  b=mbYWsXM8zRpo0bPWYOJytpk5qM/qekGwXDuhWDp2gaEurESd9g5kBo6h
   BgjrtJcFf/U5x4c5S9N9eHeQJqgMrBq2TwemdiTimXoyKactvdqypLEU6
   UStqfGVPMR6Lv6OuDh08DTjXzdG6lLmU2T/7ClVMQqqd94BsML1vXst8Z
   kQnO8p61TcASnAiCt27BlAhyMxBFojFrRo2UEZq0C9oy1uFYyucClDdRX
   N0FfxJCDFbqU1XtZfQNj2hWP3d4D1HYziPZyGUTaCFyDl59PpTUMP6X8/
   aNClnyXhc4XjhVacWN1qKfoh55AeplKb/VgbAn+snOTtwf8v8Dn8+fjau
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="281360254"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="281360254"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 02:54:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="572146145"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="572146145"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 26 Sep 2022 02:54:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ockoj-007ji5-0E;
        Mon, 26 Sep 2022 12:54:25 +0300
Date:   Mon, 26 Sep 2022 12:54:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 9/9] pwm: lpss: Allow other drivers to enable PWM LPSS
Message-ID: <YzF20P0Af25ep/ul@smile.fi.intel.com>
References: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
 <20220908135658.64463-10-andriy.shevchenko@linux.intel.com>
 <20220924101449.bpfcitsmd2nnk3md@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220924101449.bpfcitsmd2nnk3md@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 12:14:49PM +0200, Uwe Kleine-König wrote:
> On Thu, Sep 08, 2022 at 04:56:58PM +0300, Andy Shevchenko wrote:
> > The PWM LPSS device can be embedded in another device.
> > In order to enable it, allow that drivers to probe
> > a corresponding device.
> 
> There is no in-tree user of this. Do you plan to add one?

Yes.

...

> > +#define MAX_PWMS			4
> 
> Side-note orthogonal to this patch series: IMHO this is a bad name for a
> driver specific constant. Without a driver prefix you could easily
> misjudge this as e.g. maximal number of PWMs a machine can have. This
> should better be named LPSS_MAX_PWMS or similar.

Agree. But it was before my series. I can, of course, fix it at some point.

...

> > -struct pwm_lpss_boardinfo;
> 
> So the declaration you added before and I doubted is gone again.

I agree that it looks not nice in the same series, so I will drop this change
till I have a user. Then it will be clear that intention of the previous patch
is to make sure we don't abuse C programming language.

-- 
With Best Regards,
Andy Shevchenko


