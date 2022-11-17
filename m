Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D8962D5BF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239420AbiKQJDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239394AbiKQJDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:03:48 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1125A3F045;
        Thu, 17 Nov 2022 01:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668675827; x=1700211827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=x7nxFgEVjow5vF1ZtZgrRtidFMoD/jvUa6AYtcXYANc=;
  b=PCjRtbp89TbBGWSehXvLpMsqNm8E4Z7RURbSVzE4V4iJV9uq5Qqisccc
   aWIAU8zV/2D9QeRdMVm6uitPe8F/tDxJVOGrPktX0HOeNqYaKQqXWwS5C
   QUPnj694kfHSpqrcQ+GS9Xx5FZ8OeC0OvSSg2gtUXcg29CHxLe5XLSgaY
   J0+25hZ64QUNH14b5NM+DEbGzO8UnBuywCF8AHSfWeQhDZEsHcq05Drpe
   eCN588GJGFncozytJ9wsuw4IGD9b0evRD6B7lrHyGadbZoRWZ2awuyctZ
   MVH3gT+59lNuyKh68/jQ2KUyBCIwq7Rx7C1ziAjC6XPhkSo0TKbmlo4Hm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="296163359"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="296163359"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 01:03:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="670850555"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="670850555"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 17 Nov 2022 01:03:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ovaoA-00DVUa-1j;
        Thu, 17 Nov 2022 11:03:42 +0200
Date:   Thu, 17 Nov 2022 11:03:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 3/7] pwm: lpss: Include headers we are the direct user
 of
Message-ID: <Y3X47vdt8MpHNzcB@smile.fi.intel.com>
References: <20221114165545.56088-1-andriy.shevchenko@linux.intel.com>
 <20221114165545.56088-4-andriy.shevchenko@linux.intel.com>
 <20221117085027.f5qy5rsauo7vhvw2@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221117085027.f5qy5rsauo7vhvw2@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 09:50:27AM +0100, Uwe Kleine-König wrote:
> On Mon, Nov 14, 2022 at 06:55:41PM +0200, Andy Shevchenko wrote:
> > For the sake of integrity, include headers we are the direct
> > user of.
> > 
> > Replace the inclusion of device.h by a forward declaration
> > of struct device plus a (cheaper) of types.h as device.h is
> > an expensive include (measured in compiler effort).
> > 
> > While at it, move the struct pwm_lpss_chip to be after
> > the struct pwm_lpss_boardinfo as the former uses pointer
> > to the latter.
> 
> I stand by my feedback that this change is irrelevant in the end. If you
> drop it here, the patch gets a bit nicer.

OK, since you are insisting, I will modify this in v5.

-- 
With Best Regards,
Andy Shevchenko


