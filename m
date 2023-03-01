Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4546A7184
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 17:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjCAQsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 11:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCAQsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 11:48:16 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C8AAD0F;
        Wed,  1 Mar 2023 08:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677689295; x=1709225295;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Mz6AaW2EAL5+8w/UoTuUOtm7CuKPJpul0keJ2dUux/c=;
  b=fHTCH33QtGH8nWBIN+G9okEiBoSUA2xDc8QfBdFnBQJBRx2J0C/8iDP1
   v8rpGoRRrzY8+kO9xPjEU1G59O5OWRccKhBv16IZEp1gaoFyZe5NTHQUf
   ZxCf2i3MvhMHTOg0Ph77426fqtYPX8oiotTnKwVjN3IOmN7s+yA7r3F3p
   L2pJlokn8zQfRi8pT5oV32d3IsmNRrSJEm664TEqwcaiKsGuEw5H6rOAE
   QI2atuZYOSdo+Y7/BUUmJykilI18i8ZmBsS5vX4/RBj9VB4JN/OuiVQHZ
   VMhltG87gNb+Eu7ZKGOpP5TTkmnKygibrFpuIZBlHYLawKRRlc8ikGLG1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="331937306"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="331937306"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 08:48:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="707041215"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="707041215"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 01 Mar 2023 08:48:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pXPcc-00Dq1P-0X;
        Wed, 01 Mar 2023 18:48:06 +0200
Date:   Wed, 1 Mar 2023 18:48:05 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        airlied@redhat.com, dipenp@nvidia.com, treding@nvidia.com,
        mwen@igalia.com, fmdefrancesco@gmail.com, arnd@arndb.de,
        bvanassche@acm.org, ogabbay@kernel.org, axboe@kernel.dk,
        mathieu.poirier@linaro.org, linux@zary.sk, masahiroy@kernel.org,
        yangyicong@hisilicon.com, dan.j.williams@intel.com,
        jacek.lawrynowicz@linux.intel.com, benjamin.tissoires@redhat.com,
        devicetree@vger.kernel.org, furong.zhou@linux.intel.com,
        linus.walleij@linaro.org
Subject: Re: [PATCHv3 2/4] wiegand: add Wiegand bus driver
Message-ID: <Y/+Bxb/9wSIrQcFT@smile.fi.intel.com>
References: <20230301142835.19614-1-m.zatovic1@gmail.com>
 <20230301142835.19614-3-m.zatovic1@gmail.com>
 <Y/98GqIPgMyPLRi3@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y/98GqIPgMyPLRi3@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 06:23:54PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 01, 2023 at 03:28:33PM +0100, Martin Zaťovič wrote:

...

> > +#include <linux/of.h>
> > +#include <linux/of_device.h>

Forgot to add that these are probably optional. Or at least OF specific code
should leave in a separate file with a good explanation why we even have it
to begin with.

-- 
With Best Regards,
Andy Shevchenko


