Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18356682C87
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjAaM1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjAaM1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:27:08 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF0C3A90;
        Tue, 31 Jan 2023 04:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675168027; x=1706704027;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pm+2Xp9G75JHYb1LMbl4t3W66mzSj4xDQZ/8FSjmgMw=;
  b=GESqnCWahHJhpR5ZJWD9wqpAViL4gjusMmBSNxvvtuTzmHhnJeafylhN
   PZJwWJrRad9C9rgAHnjSXXqHLVJrYxbk77pS46NKh7c7ykVds5Kp28If7
   UWH+6vfg7vNcQbeJzGD8aR7PxyEo2oJyDTR8x6qXYxQ0UFDrwLavOSgJ1
   eiWYoyWB7Y6wcZ4LYDe8ZLacZIqzftkqib/h4jljtZ1UZ0LC+2MqsB4jU
   r4qckRau/6IuHQJZlD+zvLBZU3lobjtt4VhxVNigdSNVsD345nfKuXRjm
   YlmtOR+OaVxTuH3QbCXeM0o/05LVSC90ZiRmWua59WO8w4IHLIUBAsMrg
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="325522679"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="325522679"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 04:27:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="733091691"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="733091691"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 31 Jan 2023 04:27:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pMpj0-000FHX-2y;
        Tue, 31 Jan 2023 14:26:58 +0200
Date:   Tue, 31 Jan 2023 14:26:58 +0200
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
Message-ID: <Y9kJEsjkG8h79tcR@smile.fi.intel.com>
References: <20230118063822.14521-1-okan.sahin@analog.com>
 <20230118063822.14521-4-okan.sahin@analog.com>
 <Y8erlpofdk24vwCC@smile.fi.intel.com>
 <MN2PR03MB5168EC97926AB33D4D806FCCE7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
 <MN2PR03MB516865804044A798AEB5B6C0E7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR03MB516865804044A798AEB5B6C0E7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 09:27:48AM +0000, Sahin, Okan wrote:

First of all, please do avoid top-posting.

> Sorry for second question. I do not want to bother you, but I realized that I
> need to be sure about driver_data before sending new patch. You said that you
> need to use pointers directly for driver_data then I fixed that part in mfd,
> but I do not need or  use driver_data in regulator since chip_id comes from
> mfd device so I think using like below should be enough for my
> implementation.
> 
> static const struct platform_device_id max77541_regulator_platform_id[] = {
> 	{ "max77540-regulator", },
> 	{ "max77541-regulator", },
> 	{  /* sentinel */  }
> };
> MODULE_DEVICE_TABLE(platform, max77541_regulator_platform_id);
> 
> static const struct of_device_id max77541_regulator_of_id[] = {
> 	{ .compatible = "adi,max77540-regulator", },
> 	{ .compatible = "adi,max77541-regulator", },
> 	{ /* sentinel */  }
> };
> MODULE_DEVICE_TABLE(of, max77541_regulator_of_id);
> 
> What do you think?

If you have got all necessary data from the upper layer, why do you need to
have an ID table here? I'm not sure I understand how this OF ID table works
in this case.

-- 
With Best Regards,
Andy Shevchenko


