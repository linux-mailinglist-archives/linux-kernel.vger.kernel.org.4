Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1035F682EF2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjAaONy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjAaONv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:13:51 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA733C0A;
        Tue, 31 Jan 2023 06:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675174430; x=1706710430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/BEyfGW0W/aNEviei4kNEG3m+BpXMjr5t7OGNNmaDWM=;
  b=ioz6Nc7Ln4FiaXhcghfkBaYM7jKk6skuQ8CBvZ/D0LLVMv+UOHGT+ju+
   5eQ03jQOzmxZB/fX7W79XkYAkP4KrFTmiXIlOxQy1GDsmK748q9DSQU8D
   O2EKm0qWPV+VinplluWbcoBpVsfWR8Kt0Ifhw6doKjQYSQV4//6/gQzhn
   6a4i9jgJBQpU4EluU5995lDhLVyhsyq8802iD6hZGmMds//VE+qCdkEPE
   jqqRI9ia6vmO6Jgmm1a61Uk5noMEw4sLtqwHQzqNtiIaE/ZWmOQVHBh0N
   1XBuyJVW4FqgLpM4QWq2kXckWw1BRcAlzSX8A08NEd933A5f+ogk0dgyW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="392399983"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="392399983"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 06:13:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="727958871"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="727958871"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 31 Jan 2023 06:13:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pMrNd-000Hgz-30;
        Tue, 31 Jan 2023 16:13:01 +0200
Date:   Tue, 31 Jan 2023 16:13:01 +0200
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
Message-ID: <Y9kh7QI+1RqvLr2G@smile.fi.intel.com>
References: <20230118063822.14521-1-okan.sahin@analog.com>
 <20230118063822.14521-4-okan.sahin@analog.com>
 <Y8erlpofdk24vwCC@smile.fi.intel.com>
 <MN2PR03MB5168EC97926AB33D4D806FCCE7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
 <MN2PR03MB516865804044A798AEB5B6C0E7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
 <Y9kJEsjkG8h79tcR@smile.fi.intel.com>
 <BY5PR03MB5153C18E65B954E9FEFD96B1E7D09@BY5PR03MB5153.namprd03.prod.outlook.com>
 <Y9kXxP/cEBJ5gyoB@smile.fi.intel.com>
 <BY5PR03MB51539CB52778A945C8CB788FE7D09@BY5PR03MB5153.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR03MB51539CB52778A945C8CB788FE7D09@BY5PR03MB5153.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 01:59:45PM +0000, Sahin, Okan wrote:
> On Tue, 31 Jan 2022 4:30 PM
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >On Tue, Jan 31, 2023 at 01:23:33PM +0000, Sahin, Okan wrote:
> >> On Tue, 31 Jan 2022 3:27 PM
> >> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >> >On Tue, Jan 31, 2023 at 09:27:48AM +0000, Sahin, Okan wrote:

...

> >> >> Sorry for second question. I do not want to bother you, but I
> >> >> realized that I need to be sure about driver_data before sending
> >> >> new patch. You said that you need to use pointers directly for
> >> >> driver_data then I fixed that part in mfd, but I do not need or
> >> >> use driver_data in regulator since chip_id comes from mfd device so
> >> >> I think using like below should be enough for my implementation.
> >> >>
> >> >> static const struct platform_device_id max77541_regulator_platform_id[] =
> >{
> >> >> 	{ "max77540-regulator", },
> >> >> 	{ "max77541-regulator", },
> >> >> 	{  /* sentinel */  }
> >> >> };
> >> >> MODULE_DEVICE_TABLE(platform, max77541_regulator_platform_id);
> >> >>
> >> >> static const struct of_device_id max77541_regulator_of_id[] = {
> >> >> 	{ .compatible = "adi,max77540-regulator", },
> >> >> 	{ .compatible = "adi,max77541-regulator", },
> >> >> 	{ /* sentinel */  }
> >> >> };
> >> >> MODULE_DEVICE_TABLE(of, max77541_regulator_of_id);
> >> >>
> >> >> What do you think?
> >> >
> >> >If you have got all necessary data from the upper layer, why do you
> >> >need to have an ID table here? I'm not sure I understand how this OF
> >> >ID table works in this case.
> >
> >> I added it since there is regulator node in device tree. With the help
> >> of devm_regulator_register(..), driver takes parameters of regulator
> >> node. I also used id to select and to initialize regulator descriptors
> >> which are chip specific. So far there is no comment about OF ID table
> >> so I kept it. I thought I need to add both of id table and platform id
> >> table as name matching is required to initialize platform device from mfd.
> >
> >For platform device is one mechanism how to enumerate device, and bind it to
> >the driver. The OF ID table needs to be present in case you are using it for direct
> >DT enumeration (there is also something related to MFD child nodes, but you
> >need to check and explain how your device is enumerated by this driver).
> >
> >I.o.w. please clarify how the OF ID table is being used.
> 
> I do not use "of id table" directly in max77541-regulator.c so do I need to exclude it?

Exactly my point. How does this OF ID table affect the device enumeration?

> However, devm_regulator_register(..) method initialize each regulator with
> the nodes under "regulators node". If of_match in desc and name of node
> matches, then regulator will be initialized with parameters in the node under
> the regulators node in the device tree. Since I am using device tree to
> initialize regulators, I added of id table. I hope I explained the situation
> clearly.

This is confusing. If your regulator is enumerated via DT, why do you need MFD?

-- 
With Best Regards,
Andy Shevchenko


