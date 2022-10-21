Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02CF60756C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiJUKvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiJUKvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:51:52 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FDD1885A1;
        Fri, 21 Oct 2022 03:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666349511; x=1697885511;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SOnQ/Ahm8Fyy/0dvQUsxSsRNaNTEuAF/+je6ADXP20g=;
  b=FRemYAPON8k1UpX1JTSq5KMnxZMxHCkI2TKiPsaFMiHoGDfrdlUA6Li9
   sZgIuR5CApNtYG24AL7pUjfYEC/oAATRxpGf2pWBN7sRbn6sXFT268BT8
   QXytuoxHZh/nT8qqJGAUXEb2qWhnsZx5WFDq2Vidsj+WHm71+vxRYRw+t
   GnEWCYblSYxy2N+1DeNfPORw1rJKNf5GPJN2Ga6IhHVWS5kbhB7Hjeq38
   jsmObXHtMdMOmTXzgfcOgU9pT8EO9/5uyH4rnZj/zvRM1lRy4EmHn/JF3
   yy2OcNuQtmE7tBJ71bhRLMcy+BcG14sQprsz56G8Y5NwUFyJ+YJM7uLOa
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="305708855"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="305708855"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 03:51:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="735483334"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="735483334"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 21 Oct 2022 03:51:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1olpcy-00B6v2-0U;
        Fri, 21 Oct 2022 13:51:48 +0300
Date:   Fri, 21 Oct 2022 13:51:47 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 3/6] spi: pxa2xx: Remove no more needed PCI ID table
Message-ID: <Y1J5wx63bzq4tnik@smile.fi.intel.com>
References: <Y1F6YRzRS2DR+cKL@smile.fi.intel.com>
 <Y1F+Pw52nN195qDO@sirena.org.uk>
 <Y1F/aVEYn3GIVEN2@smile.fi.intel.com>
 <Y1GEqa07/b25utui@sirena.org.uk>
 <Y1GIVy8l4vKsUYLr@smile.fi.intel.com>
 <Y1GJL8/YfeoUy8wB@sirena.org.uk>
 <Y1GLdp9GCqD7CdfW@smile.fi.intel.com>
 <Y1GOTtYIeOFmrmm7@sirena.org.uk>
 <Y1GRGrt8EvhoeV0z@smile.fi.intel.com>
 <Y1J3lyrygPvVGUJw@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1J3lyrygPvVGUJw@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 11:42:31AM +0100, Mark Brown wrote:
> On Thu, Oct 20, 2022 at 09:19:06PM +0300, Andy Shevchenko wrote:
> > On Thu, Oct 20, 2022 at 07:07:10PM +0100, Mark Brown wrote:
> 
> > > Remember that device_property backs onto fwnode so properties can come
> > > from _DSD properties too since fwnode will query any source of
> 
> > > I think the code would have to also check that it was a
> > > MFD child at least,
> 
> > That's exactly what I'm talking about when said "named resource check".
> 
> Like I say a property can come from any firmware interface.

But I'm talking about resource (not a property) as IO memory. It doesn't come
via firmware at all. Have you had a chance to look into the v4?

-- 
With Best Regards,
Andy Shevchenko


