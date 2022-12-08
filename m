Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3F36468E0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 07:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiLHGGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 01:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHGGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 01:06:34 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9A8899F0D;
        Wed,  7 Dec 2022 22:06:32 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 3069B804D;
        Thu,  8 Dec 2022 06:06:32 +0000 (UTC)
Date:   Thu, 8 Dec 2022 08:06:30 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 1/1] serial: core: Start managing serial
 controllers to enable runtime PM
Message-ID: <Y5F+5kAAr7pMeGWE@atomide.com>
References: <20221207124305.49943-1-tony@atomide.com>
 <Y5D187ygOvDEA0UK@smile.fi.intel.com>
 <Y5D3UKLgHCT9feuC@smile.fi.intel.com>
 <Y5F7i8Ee/jAQKu9n@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5F7i8Ee/jAQKu9n@atomide.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [221208 05:52]:
> * Andy Shevchenko <andriy.shevchenko@intel.com> [221207 20:28]:
> > We can avoid this check by caching the platform device.
> > 
> > 	struct platform_device *ctrl_pdev = NULL;
> > 
> > 	if (...) {
> > 		ctrl_pdev = to_platform_device(ctrl_dev);
> > 	}
> > 
> > 	platform_device_del(ctrl_pdev);
> 
> OK yeah that's nicer :)
> 
> > > Shouldn't you call platform_device_unregister()?
> 
> Outside the error path it should be platform_device_unregister(),
> I'll check. Thanks also for your other comments.

To me looks like we should just use platform_device_unregister()
in call cases here like you noted.

Regards,

Tony
