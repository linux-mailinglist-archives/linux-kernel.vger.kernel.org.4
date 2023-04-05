Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D066D7720
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237569AbjDEIkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237576AbjDEIj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:39:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4245255;
        Wed,  5 Apr 2023 01:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680683986; x=1712219986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ehsUMXYWrybujltGCXXqPomdr6uFX8yL/RylcYCsfck=;
  b=AG44AaKBNENNoXk2Du/7OJMJ8GXwD+hCl6IMapWxHJrbqH7ddBGF/w37
   5mUcPthF4SES31fU67pt6PQEpU/4lmhZF4LFy6fmBU9p3NN2EBDjPnkA/
   asNnLfRjxyCI72iR6BUef881xbDgVdgzyCmJMseZC3p8Pq8dM/nZ3aL0m
   i6rpHcvXeHvqzLY4T3MmPolqkXDfv9juHTdGkqDkyZbGnyac8Mt0AUfKO
   H6RdVD0YaMEImWX47JZS3TWhWUye5hSRV9TrrOaEsu7CgWlwPfaiFeHy9
   pOlZV991fRSXv3dGLcO/dmi5cjGXzsMg20ap/Y3lqMGEy3kfQDOCzxnXd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="428685896"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="428685896"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 01:39:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="775969138"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="775969138"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Apr 2023 01:39:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pjyg4-00CkmF-37;
        Wed, 05 Apr 2023 11:39:36 +0300
Date:   Wed, 5 Apr 2023 11:39:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        airlied@redhat.com, dipenp@nvidia.com, treding@nvidia.com,
        mwen@igalia.com, fmdefrancesco@gmail.com, arnd@arndb.de,
        bvanassche@acm.org, ogabbay@kernel.org, axboe@kernel.dk,
        mathieu.poirier@linaro.org, linux@zary.sk, masahiroy@kernel.org,
        yangyicong@hisilicon.com, dan.j.williams@intel.com,
        jacek.lawrynowicz@linux.intel.com, benjamin.tissoires@redhat.com,
        devicetree@vger.kernel.org, furong.zhou@linux.intel.com
Subject: Re: [PATCHv3 2/4] wiegand: add Wiegand bus driver
Message-ID: <ZC0zyM3zEHYG/PLF@smile.fi.intel.com>
References: <20230301142835.19614-1-m.zatovic1@gmail.com>
 <20230301142835.19614-3-m.zatovic1@gmail.com>
 <Y/98GqIPgMyPLRi3@smile.fi.intel.com>
 <ZCwifu6yxUikt42i@fedora>
 <CACRpkdYyGjTMCJvAHWa=GE7i1qb98+7zDeK-28-Ko+1B2U8-mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYyGjTMCJvAHWa=GE7i1qb98+7zDeK-28-Ko+1B2U8-mw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 10:30:59PM +0200, Linus Walleij wrote:
> On Tue, Apr 4, 2023 at 3:13 PM Martin Zaťovič <m.zatovic1@gmail.com> wrote:
> > On Wed, Mar 01, 2023 at 06:23:54PM +0200, Andy Shevchenko wrote:

...

> > > > +/**
> > > > + * of_register_wiegand_device - allocates and registers a new Wiegand device based on devicetree
> > >
> > > NAK for OF only code. New, esp. bus, code must be agnostic. We have all means
> > > for that.
> >
> > In one of the previous versions of this patch series, there was also the possibility to instantiate
> > the device from another driver. I have been told, that this is not the way to go anymore, unless
> > there is a very specific reason for that. I did not find such reason, so I have removed this suport.
> 
> I don't know for sure but I think Andy simply means that you should take a look
> in include/linux/property.h and replace every function named of_* with
> the corresponding fwnode_* or device_* function from that file, and it
> should all just magically work the same, but abstracted away from device
> tree. It's not much more than a search/replace and rename operation
> (unless there is a "hole" in the fwnode implementations... I hope not.)
> 
> In the end you can keep just <linux/property.h> and drop <linux/of.h>
> and <linux/of_device.h> if this works.

Yes. And the argument for embedded devices it's exactly why the non-OF
interface is needed as we want to have a possibility to connect devices on
ACPI (or another, if any) based platform without changing the code.

-- 
With Best Regards,
Andy Shevchenko


