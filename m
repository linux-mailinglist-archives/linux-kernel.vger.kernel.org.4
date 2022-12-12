Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F40649F26
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 13:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbiLLMx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 07:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiLLMxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 07:53:25 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1CF3DFD3;
        Mon, 12 Dec 2022 04:53:22 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D172E80B3;
        Mon, 12 Dec 2022 12:53:21 +0000 (UTC)
Date:   Mon, 12 Dec 2022 14:53:20 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v4 1/1] serial: core: Start managing serial
 controllers to enable runtime PM
Message-ID: <Y5ckQKmQYwi8aWgi@atomide.com>
References: <20221207124305.49943-1-tony@atomide.com>
 <7f105ff9-cdc3-f98e-2557-812361faa94@linux.intel.com>
 <Y5G5Udw6FAEFdAYi@atomide.com>
 <3c87186b-336f-6884-a2c-6ee3c9d70@linux.intel.com>
 <Y5HG2okzlqX+xfWv@atomide.com>
 <Y5bToLirsgA5NK/j@atomide.com>
 <ced9e9ea-317e-f2a2-d42f-97c2cd39f11b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ced9e9ea-317e-f2a2-d42f-97c2cd39f11b@linux.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> [221212 12:49]:
> On Mon, 12 Dec 2022, Tony Lindgren wrote:
> 
> > Hi Ilpo,
> > 
> > * Tony Lindgren <tony@atomide.com> [221208 11:13]:
> > > * Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> [221208 10:48]:
> > > > With the other patch on top of this, yes, I did see uninitialized 
> > > > port->port_dev already in serial_core_add_one_port()->uart_configure_port().
> > > > While that could be solved by removing the pm_runtime_*() calls from 
> > > > there, I think it's a generic problem because after 
> > > > serial_core_add_one_port() the port can have anything happening on it, no?
> > > 
> > > OK. Sounds like it should get sorted out by moving the call to
> > > serial_core_add_one_port() to happen after the devices are created.
> > 
> > Can you give a try with the patch below and see if it works for you?
> 
> This one worked, yes.

OK good to hear. I'll send out v5 after -rc1 then.

Thanks,

Tony
