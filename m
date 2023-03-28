Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B3D6CBFD7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjC1MxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjC1Mwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:52:49 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A615FAF04;
        Tue, 28 Mar 2023 05:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680007943; x=1711543943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l6KhjifBs0SRRIZGlOLy+bxSHMaoJPaXiq2Oi4B8MyY=;
  b=HEFFnI1t3yH9fd0ioHfTCE1Qfsv2M8JxIsnfem+5ONZ7p0iUU/4foVRe
   fuD8lN2khMLEKW/tOaca3/AzQWJkcq1RJO0tJmxJRR938VJv4djbq/0ud
   1MEob+++o7wYQxMlspw6+aF58y/pNysJ+11WQuV0E2q0Hx/LgmR+bJaAK
   hxZgxxZ/xJXu1TC1gYy9bH/1bGp3K9jk5mkMh0GFSkdzX5chT2NHPuKx1
   OYl8bpQIUAK//nb7Co3+5GtBvZT7xWxsgOTTV3oAKv+8Z5rVkwr8SIZr4
   TfhTCvfQpiVTUq2QYWEC4IpIre6AP8CgeupEnwOg7klOnMfCUCpXrRQGl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="342962372"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="342962372"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 05:52:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="716480701"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="716480701"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 28 Mar 2023 05:51:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ph8no-009dLA-21;
        Tue, 28 Mar 2023 15:51:52 +0300
Date:   Tue, 28 Mar 2023 15:51:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Sahin, Okan" <Okan.Sahin@analog.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v6 5/5]  mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Message-ID: <ZCLi6MB/aHIf4lMr@smile.fi.intel.com>
References: <20230307112835.81886-1-okan.sahin@analog.com>
 <20230307112835.81886-6-okan.sahin@analog.com>
 <20230315175223.GI9667@google.com>
 <20230315175257.GJ9667@google.com>
 <MN2PR03MB5168249900206433A082875EE7889@MN2PR03MB5168.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR03MB5168249900206433A082875EE7889@MN2PR03MB5168.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 08:26:41AM +0000, Sahin, Okan wrote:
> >On Wed, 15 Mar 2023, Lee Jones wrote:
> >> On Tue, 07 Mar 2023, Okan Sahin wrote:

...

> For previous patch(v5), There was feedback from Andy. I did not fix them. 

Why not? :-)

> 1) 
> > They have same regmap except for ADC part of MAX77541.
> 
> Extra space in the Subject.
> 
> ...
> 
> > +#include <linux/of_device.h
> 
> This is my fault, I missed this comment. I will fix in following patch(v7).
> 
> 2)
> ...
> 
> > +static const struct regmap_config max77541_regmap_config = {
> > +	.reg_bits   = 8,
> > +	.val_bits   = 8,
> 
> Do you need lock of regmap?
> 
> > +};
> 
> ...
> 
> Since I do not need lock of regmap, I did not change anything in
> regmap_config (v6). Do I need to answer this question even if I don't need
> lock of regmap?

IIRC the lock is opt-out. You need to explicitly disable it if not needed.

-- 
With Best Regards,
Andy Shevchenko


