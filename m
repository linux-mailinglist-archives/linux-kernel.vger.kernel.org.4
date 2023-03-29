Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010B36CEC10
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjC2OqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjC2OqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:46:07 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FB693C0;
        Wed, 29 Mar 2023 07:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680101039; x=1711637039;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mF5KcYfESzULnMbcHpPg9/Y3X1FNg6NDTzgQz7ayaEc=;
  b=nMByuSNhu5KCr70AFM0k4PV9tT6hInOq9Wds5kSn2a4KZ5ztdxyLypvF
   pqBx0tNgNIKEhk4qiDYQ7rEBeRUZh1y2WO4zBxdYB118RKbuIaVJ1Bw6M
   o1LoK7/22yzOgO8peYoPW4fam750R4oxPHqxYwwVd042Ok76QdSYSr3yV
   1/RiUlZQrCdtBFWxMqhlgfUzHJ9kDO/ZC36WmWkJgUVWWvcrj5o6bEgif
   fu8VRTvXbnxhFN0Qf3avVopCApzZIXvUFSs5iyabuK0W1G8M9xpEcyqKQ
   wIUWsBg1+Ln8IHJcQH6f3KcNdChMX7+7ffH7HCiHxMELzwcsyrf3jkP8Q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="338393917"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="338393917"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 07:43:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="716906281"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="716906281"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 29 Mar 2023 07:43:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1phX1k-00A41k-0n;
        Wed, 29 Mar 2023 17:43:52 +0300
Date:   Wed, 29 Mar 2023 17:43:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee@kernel.org>
Cc:     "Sahin, Okan" <Okan.Sahin@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <ZCROpw0il1VQCLPu@smile.fi.intel.com>
References: <20230307112835.81886-1-okan.sahin@analog.com>
 <20230307112835.81886-6-okan.sahin@analog.com>
 <20230315175223.GI9667@google.com>
 <20230315175257.GJ9667@google.com>
 <MN2PR03MB5168249900206433A082875EE7889@MN2PR03MB5168.namprd03.prod.outlook.com>
 <20230329143615.GS2673958@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329143615.GS2673958@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 03:36:15PM +0100, Lee Jones wrote:
> On Tue, 28 Mar 2023, Sahin, Okan wrote:
> > >On Wed, 15 Mar 2023, Lee Jones wrote:
> > >> On Tue, 07 Mar 2023, Okan Sahin wrote:

...

> > +static const struct i2c_device_id max77541_i2c_id[] = {
> > +	{ "max77540", (kernel_ulong_t)&chip[MAX77540] },
> > +	{ "max77541", (kernel_ulong_t)&chip[MAX77541] },
> 
> Just 'MAX77540' is fine.

I tend to disagree.

There is an error prone approach esp. when we talk with some functions
that unifies OF/ACPI driver data retrieval with legacy ID tables.
In such a case the 0 from enum is hard to distinguish from NULL when
the driver data is not set or not found. On top of that the simple integer
in the legacy driver data will require additional code to be added in
the ->probe().

-- 
With Best Regards,
Andy Shevchenko


