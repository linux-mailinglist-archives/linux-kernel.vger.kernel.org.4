Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBDD5EC291
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbiI0MX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiI0MXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:23:49 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E133246602;
        Tue, 27 Sep 2022 05:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664281428; x=1695817428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CjNzelJJb+xIQRdT8dfjXlqIMCpEnV3/rYeQ0cYNAdo=;
  b=MPDcL/6xA3IyvblIO0sMqv0OOTEfY7UcXLOn/NIrwah5t+q85loJyZqN
   715qLlelFW63x5KD54Ax2IOTqyAH8ZqmvPWmTEsEiFuONpbSefSoKWpJ8
   Y/ifjiTE4DgZKON5Q8Du4uVl4/BxdV10ExRN5+xNJo4+6tbuL93CWo2yp
   zJauxYrD9jptAkY9DNUpMypxCq1b4wohnDOdIm92Rw5mdJKZPQ2S1a7Fv
   7XzogBgRwjyEnu02a9TATFyJUJ+GDxeoPyzLAz43NfBJPqX7mN4kbhPyu
   It3zThe2xU9YuF8xKKpkVsAylchsUeiJI/nNbHwfDVyLy4M/Xw1lzsuTC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="327659585"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="327659585"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 05:23:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="621502083"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="621502083"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 27 Sep 2022 05:23:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1od9cl-008ROg-1z;
        Tue, 27 Sep 2022 15:23:43 +0300
Date:   Tue, 27 Sep 2022 15:23:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] watchdog: twl4030_wdt: add missing of.h include
Message-ID: <YzLrTx3uvrSMDgrc@smile.fi.intel.com>
References: <20220927052217.2784593-1-dmitry.torokhov@gmail.com>
 <20220927052217.2784593-2-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927052217.2784593-2-dmitry.torokhov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 10:22:14PM -0700, Dmitry Torokhov wrote:
> The driver is using of_device_id and therefore needs to include
> of.h header.

This is incorrect. For of_device_id the mod_devicetable.h should be used.

> We used to get this definition indirectly via inclusion
> of matrix_keypad.h from twl.h, but we are cleaning up matrix_keypad.h
> from unnecessary includes.

-- 
With Best Regards,
Andy Shevchenko


