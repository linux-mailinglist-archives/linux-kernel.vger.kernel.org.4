Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470196D0339
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjC3Lch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjC3Lcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:32:35 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9809910A;
        Thu, 30 Mar 2023 04:32:33 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id CD4F880FE;
        Thu, 30 Mar 2023 11:32:32 +0000 (UTC)
Date:   Thu, 30 Mar 2023 14:32:31 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v9 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <20230330113231.GR7501@atomide.com>
References: <20230323071051.2184-1-tony@atomide.com>
 <ZCQAF-nrrsfBtviT@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCQAF-nrrsfBtviT@kroah.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> [230329 09:08]:
> On Thu, Mar 23, 2023 at 09:10:47AM +0200, Tony Lindgren wrote:
> > --- /dev/null
> > +++ b/drivers/tty/serial/serial_base.c
> > @@ -0,0 +1,142 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> 
> Given that the driver core is "GPL-2.0-only", why is this -or-later?

Thanks for noticing, the intention was to set it to what serial_core.c has:

$ git grep -e SPDX -e MODULE_LICENSE drivers/tty/serial/serial_core.c
drivers/tty/serial/serial_core.c:// SPDX-License-Identifier: GPL-2.0+
drivers/tty/serial/serial_core.c:MODULE_LICENSE("GPL");

> No copyright notice?  That's fine, but again, I have to ask.

Will add thanks.

Tony
