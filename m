Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BBD6E1BE3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 07:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjDNFrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 01:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjDNFr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 01:47:29 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EBC52738;
        Thu, 13 Apr 2023 22:47:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9C70A80F0;
        Fri, 14 Apr 2023 05:47:27 +0000 (UTC)
Date:   Fri, 14 Apr 2023 08:47:26 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: Clear port->pm on port specific driver
 unbind
Message-ID: <20230414054726.GE36234@atomide.com>
References: <20230413070342.36155-1-tony@atomide.com>
 <ZDgoi2mFYYqswAhu@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDgoi2mFYYqswAhu@smile.fi.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [230413 16:06]:
> On Thu, Apr 13, 2023 at 10:03:41AM +0300, Tony Lindgren wrote:
> > Let's fix the issue by clearing port->pm in serial8250_unregister_port().
> 
> Sounds to me like a fix that needs a Fixes tag.

Maybe commit c161afe9759d ("8250: allow platforms to override PM hook.").

That's a bit unclear though as the hardware specific functions were
available at that point as they were passed in platform data. This can
be seen with git blame c161afe9759d drivers/serial/8250.c. To me it seems
the port->pm became potentially invalid if a serial port device driver
started implementing PM runtime?

Maybe just tagging it with Cc: stable is better if no obvious Fixes tag
can be figured out.

> Code wise LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

OK thanks,

Tony
