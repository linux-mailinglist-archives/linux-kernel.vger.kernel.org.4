Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4176A84AA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjCBOxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjCBOxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:53:23 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0FF4C30;
        Thu,  2 Mar 2023 06:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677768773; x=1709304773;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ebv+yvAFYIWfjP1yIrOAZOb/TIWMmyj7FnJDi/XFutw=;
  b=IaoMi5KDYPn0LkW8Tc5SFLC5ixqSqERRwasSf1DAGIjP+lZgL7GnPNDi
   XOdRLQUkp3jEz1eFGIYv+2o3vWGACzHA5OPv6JnKPIkAyxDlX9OaE9IOZ
   aMFn6Z3KoKgwN5aXZr+VbnH34vQDlntk56TtOLdoKJWszvvDUYV3NtLEC
   Cv5UlwLTnmIYjRKe3yWveDcLyvXaf5wIfW8/vmT2+j8kcqgoeXJlyLX2f
   t0Fj6QCMoqvQc7/i0ON3m/gBryiE7BQTtG+LN07uiyVPNAT0ICBkNGWsH
   h1OG1oJwm2BUeH6w0151qOfpsK6zNJlW64PwO8c/xz9EX2yZGP85Q+Ola
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="323023336"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="323023336"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 06:24:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="764017574"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="764017574"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Mar 2023 06:24:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pXjqo-00ENf7-2z;
        Thu, 02 Mar 2023 16:24:06 +0200
Date:   Thu, 2 Mar 2023 16:24:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Mike Looijmans <mike.looijmans@topic.nl>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: Add TI ADS1100 and ADS1000
Message-ID: <ZACxhiwgR7/MYUAQ@smile.fi.intel.com>
References: <20230228063151.17598-1-mike.looijmans@topic.nl>
 <20230228063151.17598-2-mike.looijmans@topic.nl>
 <Y/9vez/fzLD5dRVF@smile.fi.intel.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.0685d97e-4a28-499e-a9e3-3bafec126832@emailsignatures365.codetwo.com>
 <a2ba706f-888b-0a72-03a5-cbf761dfaf19@topic.nl>
 <87bc192e-45ae-9480-5e84-8fe0adfc12e7@metafoo.de>
 <b635b91e-1dcc-71ba-95d1-1f87a20dbaf2@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b635b91e-1dcc-71ba-95d1-1f87a20dbaf2@metafoo.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 05:20:38AM -0800, Lars-Peter Clausen wrote:
> On 3/2/23 05:16, Lars-Peter Clausen wrote:
> > On 3/1/23 23:49, Mike Looijmans wrote:

...

> > > > > +static int ads1100_runtime_suspend(struct device *dev)
> > > > > +{
> > > > > +    struct iio_dev *indio_dev =
> > > > > i2c_get_clientdata(to_i2c_client(dev));
> > > > > +    struct ads1100_data *data = iio_priv(indio_dev);
> > > > > +
> > > > > +    ads1100_set_config_bits(data, ADS1100_CFG_SC,
> > > > > ADS1100_SINGLESHOT);
> > > > > +    regulator_disable(data->reg_vdd);
> > > > Wrong devm / non-devm ordering.
> > > 
> > > Don't understand your remark, can you explain further please?
> > > 
> > > devm / non-devm ordering would be related to the "probe" function.
> > > As far as I can tell, I'm not allocating resources after the devm
> > > calls. And the "remove" is empty.
> > 
> > Strictly speaking we need to unregister the IIO device before disabling
> > the regulator, otherwise there is a small window where the IIO device
> > still exists, but doesn't work anymore. This is a very theoretical
> > scenario though.
> > 
> > You are lucky :) There is a new function
> > `devm_regulator_get_enable()`[1], which will manage the
> > regulator_disable() for you. Using that will also reduce the boilerplate
> > in `probe()` a bit
> > 
> > [1] https://lwn.net/Articles/904383/
> > 
> Sorry, just saw that Andy's comment was on the suspend() function, not
> remove(). In that case there is of course no need for any devm things. But
> still a good idea to use `devm_regulator_get_enable()` in probe for the
> boiler plate.

Yeah, sorry, I mistakenly took it as ->remove().

-- 
With Best Regards,
Andy Shevchenko


