Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50699682DD7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjAaN1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjAaN06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:26:58 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BA8392BD;
        Tue, 31 Jan 2023 05:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675171606; x=1706707606;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3XvfexoOzLzK+QX1hdeFmURVNAbq120zFvC/kuhd59g=;
  b=R8gLa3qZEo+T/UM2ABe26s7p1BPFr/rF2ynrAQ7rUVpZebIkVhm6qaiM
   dHJmS94aGk9BU0LIlRRB3S7plzs8AdmYpyqOODDm559w0/2jB2J6g2NPZ
   An7Hz/GdTQ0h/VA9U5WrzkoB+f8btk9vop/aMu045GbCY3iib4/2WmPj2
   Uq/mrUdeA4RZPPsCA+ZbycWkbo4dhkma//oBKEli7bbTrLSLWq9NcD8ta
   Ze80oAabf1yyWIoJXwpZK0c+QXbrHdRD6TMxdu1EHcn9vdZQ+SFyuxQkY
   C5ZRz2LKAhxJzhPR/CmYBkjeN+7NLaJTMc16VAaoj/CCTN+Awx0YTuDwk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="325535993"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="325535993"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 05:26:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="657866093"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="657866093"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 31 Jan 2023 05:26:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pMqel-000Gdv-2L;
        Tue, 31 Jan 2023 15:26:39 +0200
Date:   Tue, 31 Jan 2023 15:26:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Sahin, Okan" <Okan.Sahin@analog.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] drivers: regulator: Add ADI MAX77541/MAX77540
 Regulator Support
Message-ID: <Y9kXD/ienqmOfmJE@smile.fi.intel.com>
References: <20230118063822.14521-1-okan.sahin@analog.com>
 <20230118063822.14521-4-okan.sahin@analog.com>
 <Y8erlpofdk24vwCC@smile.fi.intel.com>
 <MN2PR03MB5168EC97926AB33D4D806FCCE7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
 <Y9kIfEj70XdO3Q/7@smile.fi.intel.com>
 <BY5PR03MB5153112086B2B9F899E8524AE7D09@BY5PR03MB5153.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR03MB5153112086B2B9F899E8524AE7D09@BY5PR03MB5153.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 01:12:26PM +0000, Sahin, Okan wrote:
> On Tue, 31 Jan 2022 3:24 PM
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >On Tue, Jan 31, 2023 at 07:20:52AM +0000, Sahin, Okan wrote:
> >> On Wed, 18 Jan 2022 11:20 AM
> >> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >> >On Wed, Jan 18, 2023 at 09:38:10AM +0300, Okan Sahin wrote:

...

> >> >> +		rdev = devm_regulator_register(dev,
> >> >> +					       &desc[i], &config);
> >> >
> >> >This is perfectly one line.
> >> Thank you, I will arrange it.
> >> >
> >> >> +		if (IS_ERR(rdev))
> >> >> +			return dev_err_probe(dev, PTR_ERR(rdev),
> >> >> +					     "Failed to register regulator\n");
> >> >> +	}
> >> >> +
> >> >> +	return 0;
> >> >> +}
> >
> >> However, this one is not fit when I set max-line-length argument as 80
> >> in checkpatch script. What do you suggest? This line has 99 characters.
> >
> >Which line do you refer to?
> I am referring "return dev_err_probe(dev, PTR_ERR(rdev), "Failed to register
> regulator\n");"

I have had no comments on that line.

-- 
With Best Regards,
Andy Shevchenko


