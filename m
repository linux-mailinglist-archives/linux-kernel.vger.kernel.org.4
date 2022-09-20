Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCFA5BE374
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiITKjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiITKiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:38:24 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE9A72EE7;
        Tue, 20 Sep 2022 03:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663670212; x=1695206212;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ESeT68QBp14fZse7on7nqGxb5SnUIDEmkBvolLY55Fo=;
  b=j8nABKC8JEeI8yE58udQZGCNWm/32kxyW8vENwYH7V9pu274EsMsPWNS
   zsZXVfNiWNlaRyNO0WKj5ORHiLULkFmMOVY0z2x9+BTgNJrBTTzjmUOC1
   Mm9Ik0lLSUPSy6vKrxo3jh+RVdD+epmXAayl2F9SGzjC8lU5ZTAFd0QeB
   7xRXRiPWZblsMIFAgS9Uc/8LXBlLLhLBmvLf2snvharCsMzsQXfCrPPu3
   oWTS5+71aNqEmXPCp0/SarJQITFUQW1DPbgEzlFx57McKDhmsNgbs7gMh
   z3AF0YKWSS46d1OFsSk8JA8j/Dh6/WEK8cz7W8DwYSyuVvrIrIxIZ4ajS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="361398152"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="361398152"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 03:36:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="618865967"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 03:36:48 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 3F528200DA;
        Tue, 20 Sep 2022 13:36:46 +0300 (EEST)
Date:   Tue, 20 Sep 2022 10:36:46 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        mchehab@kernel.org, laurent.pinchart+renesas@ideasonboard.com,
        akinobu.mita@gmail.com, jacopo+renesas@jmondi.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] media: mt9m111: add V4L2_CID_LINK_FREQ support
Message-ID: <YymXviWNg/bi/HVr@paasikivi.fi.intel.com>
References: <20220916135713.143890-1-m.felsch@pengutronix.de>
 <YyhjpxHHFR4u+k+X@paasikivi.fi.intel.com>
 <20220919130829.ddoe2ajnrarkywgy@pengutronix.de>
 <YyhsQ+l1Sls00F0M@paasikivi.fi.intel.com>
 <20220920085617.7cfflloegh7en4mj@pengutronix.de>
 <20220920091933.kokk4le3cxpw4hvp@lati>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920091933.kokk4le3cxpw4hvp@lati>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Tue, Sep 20, 2022 at 11:19:33AM +0200, Jacopo Mondi wrote:
> Hello
> 
> On Tue, Sep 20, 2022 at 10:56:17AM +0200, Marco Felsch wrote:
> > Hi Sakari,
> >
> > On 22-09-19, Sakari Ailus wrote:
> >
> > ...
> >
> > > > > > +	ret = clk_prepare_enable(mt9m111->clk);
> > > > > > +	if (ret < 0)
> > > > > > +		return ret;
> > > > > > +
> > > > > > +	extclk_rate = clk_get_rate(mt9m111->clk);
> > > > > > +	clk_disable_unprepare(mt9m111->clk);
> > > > >
> > > > > I don't think you'll need to enable a clock to just get its frequency.
> > > >
> > > > The official API states that you need to turn on the clk before
> > > > requesting it and it makes sense. Also there is a new helper
> > > > devm_clk_get_enabled() which addresses simple clk usage since most of
> > > > drivers don't enable it before requesting the rate.
> 
> Had the same question on v1 and Marco pointed me to the clk_get_rate()
> documentation
> https://elixir.bootlin.com/linux/v6.0-rc1/source/include/linux/clk.h#L682
> 
> which indeed specifies
> "This is only valid once the clock source has been enabled."
> 
> However none (or very few) of the linux-media i2c drivers actually do
> that.

I'm not aware of any. That's indeed what the documentation says. Also
clk_enable() documentation says that "If the clock can not be
enabled/disabled, this should return success". So I wonder how much can
you trust it. ;-)

> 
> I have added in cc the clk framework maintainer to see if he can help
> shed some light on this

Thanks.

But yes, to make this work in general case, one would need a way to ensure
the frequency is the one assigned in DT and that it won't change.

Getting the frequency (in an unreliable way?) isn't perfect but better than
nothing. So far I haven't heard of issues in practice though.

-- 
Regards,

Sakari Ailus
