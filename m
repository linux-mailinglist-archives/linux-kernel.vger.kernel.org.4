Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE80719A3F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjFAK5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjFAK5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:57:19 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D606107;
        Thu,  1 Jun 2023 03:57:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 116B180F1;
        Thu,  1 Jun 2023 10:57:18 +0000 (UTC)
Date:   Thu, 1 Jun 2023 13:57:16 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v12 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <20230601105716.GY14287@atomide.com>
References: <20230525113034.46880-1-tony@atomide.com>
 <f44b5fb0-2345-df07-abab-c04abd6f8a13@arm.com>
 <20230601104431.GX14287@atomide.com>
 <fca99838-991d-66a7-0c2c-16ae901e3935@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fca99838-991d-66a7-0c2c-16ae901e3935@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Steven Price <steven.price@arm.com> [230601 10:53]:
> On 01/06/2023 11:44, Tony Lindgren wrote:
> > Hi,
> > 
> > * Steven Price <steven.price@arm.com> [230601 10:04]:
> >> I haven't studied this change in detail, but I assume the bug is that
> >> serial_base_port_device_remove() shouldn't be dropping port_mutex. The
> >> below hack gets my board booting again.
> > 
> > You're right. I wonder how I managed to miss that.. Care to post a proper
> > fix for this or do you want me to post it?
> 
> I'll post a proper fix shortly. Thanks for the confirmation of the fix.

OK great thanks!

> > Seems you can remove out here and just do a return earlier instead of goto.
> 
> Yes, this was just the smallest change. I'll do it properly with an
> early return in the proper patch.

OK

Regards,

Tony
