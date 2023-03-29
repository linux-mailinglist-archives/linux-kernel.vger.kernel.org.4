Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351D76CDBA9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjC2OLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjC2OLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:11:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B125D5253;
        Wed, 29 Mar 2023 07:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680099028; x=1711635028;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yRXhs08yuvV+ck05F5xZeaWMZbutT7fFUJzulNNVt3s=;
  b=BYmOlVRp8DefrIiOa4JSwQKb8CbCdoaetXfsBNhAp1iqO7lBFXFYGV8X
   p5kbtMpX+7QE8CaEs7x3O6/zr9LHOpOCW31l8wclH0J9aBPu3bcZCGkkv
   Jlhav9S4khEoDH2R1Ih870fPgPWlWo2LIZHEZjXaM+LsM1ppfWyE1ecQx
   Gg1ztXeqEzO8unT3pKoCT+EX+OkM7u4z/IMjsIwd6RM/hbauWLdj2OIXY
   4YPeYKlVpkfenKJaTeRDDg4IErVsxLeiSx9zm0dWsO1GOXyBQkdCgHey9
   HwwBIjiGP8nCpTWSbhNiUw7MVG9fgDNKI9w+Jbz19EZ5EQ963Hew7u6h7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="321278964"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="321278964"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 07:08:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="714627361"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="714627361"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 29 Mar 2023 07:08:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1phWTk-00A3NS-0O;
        Wed, 29 Mar 2023 17:08:44 +0300
Date:   Wed, 29 Mar 2023 17:08:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Sahin, Okan" <Okan.Sahin@analog.com>
Cc:     Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
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
Message-ID: <ZCRGa76BqswH7Bez@smile.fi.intel.com>
References: <20230315175257.GJ9667@google.com>
 <MN2PR03MB5168249900206433A082875EE7889@MN2PR03MB5168.namprd03.prod.outlook.com>
 <ZCLi6MB/aHIf4lMr@smile.fi.intel.com>
 <cdd53e29ca3d8dbfdfa1a2520935e2bf9418313d.camel@gmail.com>
 <d2bed74b-9eb9-45af-8f45-ad2c2889024a@sirena.org.uk>
 <fc07de9af0b691fbd3a5915c8293f0c7ad4c4e06.camel@gmail.com>
 <ZCL7J5a7UZVayQVS@smile.fi.intel.com>
 <60bbad1b38b8e3c9c3efefb0fb7b8d3cad7fa98c.camel@gmail.com>
 <ZCMMHl5ENSuCstFV@smile.fi.intel.com>
 <MN2PR03MB51688CAF5DDF0628ED6B0B06E7889@MN2PR03MB5168.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN2PR03MB51688CAF5DDF0628ED6B0B06E7889@MN2PR03MB5168.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 04:01:21PM +0000, Sahin, Okan wrote:
> >On Tue, Mar 28, 2023 at 04:51:18PM +0200, Nuno Sá wrote:
> >> On Tue, 2023-03-28 at 17:35 +0300, Andy Shevchenko wrote:
> >> > On Tue, Mar 28, 2023 at 04:18:30PM +0200, Nuno Sá wrote:
> >> > > On Tue, 2023-03-28 at 14:46 +0100, Mark Brown wrote:
> >> > > > On Tue, Mar 28, 2023 at 03:26:44PM +0200, Nuno Sá wrote:
> >> > > >
> >> > > > > IIRC, regmap_read() is not really reentrant and it is used in
> >> > > > > the IIO driver on the sysfs interface. So, yeah, I think you
> >> > > > > need the regmap lock and better just leave the config as is.
> >> > > > > Yes, the lock is
> >> > > > > opt-
> >> > > > > out
> >> > > > > so let's not disable it :)
> >> > > >
> >> > > > All the regmap operations are fully thread safe.
> >> > >
> >> > > Even if 'config->disable_locking' is set? I think that is what's
> >> > > being discussed in here...
> >> >
> >> > In case the driver has its own lock to serialize IO how on earth the
> >> > regmap lock is needed. That's what I asked the author of the driver.
> >> > He told the code
> >>
> >> Well, if the driver has it's own locking, then sure we do not need
> >> regmap's lock...
> >>
> >> > doesn't require the regmap lock, and I tend to believe the author.
> >> > So, why to
> >> > keep it?
> >>
> >> However, if you look at the adc driver, I can see plain regmap_read()
> >> calls without any "outside" locking.
> >
> >Then author of the code should know what they are doing. Right?

> Actually, I do not want to disable regmap lock that's why I did not update it.

If you have something like 

func1()
	regmap_read(reg1)
	regmap_read/write(reg2)

func2()
	regmap_read/write(regX) // X may or may not be 1 or 2

and func1() and func2() can be run in parallel then the code is racy.

Do you have such in your code?

-- 
With Best Regards,
Andy Shevchenko


