Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143045EC96A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbiI0QZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbiI0QZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:25:19 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0D5979E8;
        Tue, 27 Sep 2022 09:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664295896; x=1695831896;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+8+/xApJ1jbRQJ7bxF89i3oMtVoDfkDGQljqzqT0OQI=;
  b=Gtl221XG4ChXhWoc6ghWorSTIeVIMDTFyp7rcBlvmmc/CTtsMIpr9hHz
   xNjUWZxuD7zOoaYD4ZkzbfHqW4g5xcr1xNVANVUDZlSV/htjL7lQJ76U3
   7u6Hv21JJX0Ry+U6JfHUBd3dXSHdeI50nQ8Zpyum2DWht1syTlXAU5Gh1
   UnC9qFe+ZZj1/enskiQKy9RzX8OUKB7zJ/kTKZOPoD3s94mQSdq2tv1oq
   zApuYA7/csspjLOjotusrngmDXmqNxIxrstCTJtF998b/H4iRY8vD3f5+
   7jbkwO/blSrqJMurRnBXh80yi2RO5DENwkCf4Ta/E8EUZ3ppGCoAgyp3B
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="281732196"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="281732196"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 09:24:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="599232964"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="599232964"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 27 Sep 2022 09:24:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1odDO7-008Wo6-2L;
        Tue, 27 Sep 2022 19:24:51 +0300
Date:   Tue, 27 Sep 2022 19:24:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 4/8] pwm: lpss: Include headers we are direct user of
Message-ID: <YzMj04Gcf011F+v8@smile.fi.intel.com>
References: <20220927144723.9655-1-andriy.shevchenko@linux.intel.com>
 <20220927144723.9655-5-andriy.shevchenko@linux.intel.com>
 <20220927151053.7eh63stoganpgawr@pengutronix.de>
 <YzMWJFmeMAvn0e1c@smile.fi.intel.com>
 <20220927155521.t4hanojroe247lqr@pengutronix.de>
 <YzMiW0rjFek8VTS7@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YzMiW0rjFek8VTS7@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 07:18:36PM +0300, Andy Shevchenko wrote:
> On Tue, Sep 27, 2022 at 05:55:21PM +0200, Uwe Kleine-König wrote:

...

> That said, if you want to NAK this, please do it explicitly. I'm not going
> to waste my time on this simple change anymore.

Just sent a v4 without this change, so I will not waste more time on this.

-- 
With Best Regards,
Andy Shevchenko


