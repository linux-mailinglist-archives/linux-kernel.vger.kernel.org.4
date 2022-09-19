Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041A25BCC72
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiISNDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiISNDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:03:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89FD26136;
        Mon, 19 Sep 2022 06:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663592613; x=1695128613;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G1P3+TIjxdWvSQeptpPpiJ2C7v1Rhk5VtMylTJBmLH4=;
  b=j137+3JutDu/onX05E9/tSbwYmZeZZtgDI66j96/K/WdsDtVI6Cye8XS
   bDG1Qbp8f3JmtRqm18k0U9IkBaTPnli2+z3uy6Vo0tJhuDLT5GgCqYIz8
   FxIKxjj/hWMrFnCLtK5kCcwydsIfOVI9p+m0q/CxhjyHGCX8yJWr8z/u/
   2Q0edU8vi4lMzBAI5f47U0owYfhD5vKTWm/4+fNI/yJcGQq+MpwLitNBQ
   dsi/ynBZyUeabD/WnIXKf8P2MFzFZQO6+zY+m9ZRV2OLkxEI+Q/2Ar/3v
   XRHhdWBxrgmCrVYQvUkUrjbgiKwwYxS34r6/yilY/quXxMrz38dx5mbc4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="298120477"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="298120477"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 06:03:33 -0700
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="863551826"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 06:03:29 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id DEE94202D2;
        Mon, 19 Sep 2022 16:03:27 +0300 (EEST)
Date:   Mon, 19 Sep 2022 13:03:27 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Marco Felsch <m.felsch@pengutronix.de>, mchehab@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kishon@ti.com, vkoul@kernel.org, hverkuil@xs4all.nl,
        jacopo@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2 4/4] media: tc358746: add Toshiba TC358746 Parallel to
 CSI-2 bridge driver
Message-ID: <Yyhonw7SEjkAPivN@paasikivi.fi.intel.com>
References: <20220916134535.128131-1-m.felsch@pengutronix.de>
 <20220916134535.128131-5-m.felsch@pengutronix.de>
 <YyhjB+RbLokmBKPx@paasikivi.fi.intel.com>
 <YyhlQPhezmLG8ZCn@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyhlQPhezmLG8ZCn@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 03:49:04PM +0300, Laurent Pinchart wrote:
> On Mon, Sep 19, 2022 at 12:39:35PM +0000, Sakari Ailus wrote:
> > > +	dev_set_drvdata(dev, tc358746);
> > > +	pm_runtime_set_autosuspend_delay(dev, 200);
> > > +	pm_runtime_use_autosuspend(dev);
> > > +	pm_runtime_enable(dev);
> > > +
> > > +	err = tc358746_init_hw(tc358746);
> > 
> > The driver depends on runtime PM being enabled but does not depend on
> > CONFIG_PM. I'd suggest to power the device on and only then enable runtime
> > PM. See
> > <URL:https://hverkuil.home.xs4all.nl/spec/driver-api/camera-sensor.html#power-management>.
> 
> Or simply depend on CONFIG_PM :-)

The user can still disable runtime PM.

I guess few do though. This should be addressed separately from this
driver, it'd be good to be able to deny that. In fact, no-one has ever
probably tested this for a large number of drivers and I guess it exists
just to have a way to disable runtime PM support in drivers that do not
work with it...

-- 
Sakari Ailus
