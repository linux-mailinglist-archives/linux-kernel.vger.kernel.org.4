Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06586EA721
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjDUJg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjDUJg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:36:26 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6577D93CF;
        Fri, 21 Apr 2023 02:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682069785; x=1713605785;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZdhPVeSYHPtv0zuACx4Eqg5I8pftb2XTKuKHkbl9AJ0=;
  b=Yb3PXKOBfMh0IgF/yzrg1OGxLn8V/prPTa9Ih9i1BR7k9NCRYTpL9xhQ
   jMsxEyuF3LTavZYyux3mBuXEgHYdMbzKEZu9DgVBZiTD3aRdLrPwSlx9p
   wRx7vpIXFA/sM84Nc+7JWftdZOHtFNIqWZ3JF3Z1/w+BBkGnRIap2+AYi
   3uWsNT5VgFcl4xixjZ5v+kRJHy2XsPhjH5DbvTZg1+5QpjwlJjkbPuK4+
   LFsJPJlsR/zseqEkRbXEqwBh/7U1M6zOpOXDKGgYeVuhwMVZRQD9GjUGP
   eq3qfT4FHoQmbOROh2ZeUM7WB3jLgMSCtX5kK8FOsINaS2NfTPpHcedWR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="326283980"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="326283980"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 02:36:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="692216444"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="692216444"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 21 Apr 2023 02:36:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ppnBj-0035cy-3C;
        Fri, 21 Apr 2023 12:36:19 +0300
Date:   Fri, 21 Apr 2023 12:36:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dinh Nguyen <dinh.nguyen@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        dinguyen@kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com
Subject: Re: [PATCH 3/5] hwmon: (socfpga) Add hardware monitoring support on
 SoCFPGA platforms
Message-ID: <ZEJZE5bxyXsrAZPJ@smile.fi.intel.com>
References: <20230410153314.27127-1-dinh.nguyen@linux.intel.com>
 <20230410153314.27127-3-dinh.nguyen@linux.intel.com>
 <09730359-8731-e21e-3335-bf60ba7f1280@roeck-us.net>
 <a3e966f8-8e9d-7081-1665-9d2e87acb310@linux.intel.com>
 <8d158880-1e6a-5fdd-dae7-a7647794eb60@roeck-us.net>
 <a1a34c32-dbd4-7a77-ab7e-5e34af85900f@linux.intel.com>
 <ZD/UsuzhZmK3AFJn@smile.fi.intel.com>
 <f6e4a78d-0199-3135-f85d-800457a731b0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6e4a78d-0199-3135-f85d-800457a731b0@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 09:46:20AM -0500, Dinh Nguyen wrote:
> On 4/19/2023 6:46 AM, Andy Shevchenko wrote:
> > On Tue, Apr 18, 2023 at 12:29:40PM -0500, Dinh Nguyen wrote:
> > > On 4/17/2023 4:51 PM, Guenter Roeck wrote:
> > > > On 4/17/23 13:55, Dinh Nguyen wrote:

...

> > > > ... and this contradict each other. If bit 31 indicates an error,
> > > > this can not be a signed 32-bit value.
> > > > 
> > > You're right! I've re-read the spec and should have the the code look for
> > > the specific error values:
> > > 
> > > 0x80000000 - inactive
> > > 0x80000001 - old value
> > > 0x80000002 - invalid channel
> > > 0x80000003 -  corrupted.
> > No, they are not hex. Probably you need to define an error space with it, but
> > at least just use signed _decimal_ values.
> > 
> > Instead of BIT(31) this should go as
> > 
> > #define ..._ERR_BASE   INT_MIN // or equivalent if the type is not int
> > #define ..._ERR_MAX ... // or whatever name is better
> > 
> > Then in your code
> > 
> > 	if (value >= _ERR_MAX)
> > 		return 0;
> > 
> > 	err = _ERR_MAX - value;
> > 	switch (err) {
> > 		...
> > 	}
> > 
> > P.S. I asked during internal review if the values are bit fielded when errors.
> > AFAIU that time they are, now it seems different.
> 
> Can I ask what's wrong with this simple implementation?

Technically, nothing, but from understanding point of view it would be better
to have explicit ranges of error number space vs. actual value space.

The idea in the firmware of that device seems to me similar to what we have in
the Linux kernel. Note, it may be not _so_ explicitly, but the error number
space is limited by a PAGE_SIZE. All the same may be applied here.

> static int socfpga_hwmon_err_to_errno(struct socfpga_hwmon_priv *priv)
> {
>         int value = priv->temperature.value;
> 
>         switch (value) {
>         case ETEMP_NOT_PRESENT:
>                 return -ENOENT;
>         case ETEMP_CORRUPT:
>         case ETEMP_NOT_INITIALIZED:
>                 return -ENODATA;
>         case ETEMP_BUSY:
>                 return -EBUSY;
>         case ETEMP_INACTIVE:
>         case ETEMP_TIMEOUT:
>         case ETEMP_TOO_OLD:
>                 return -EAGAIN;
>         default:
>                 /* No error */
>                 return 0;
>         }
> }

-- 
With Best Regards,
Andy Shevchenko


