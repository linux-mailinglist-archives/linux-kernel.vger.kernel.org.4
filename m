Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B5C6CD5F6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjC2JIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjC2JIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:08:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD4819BA;
        Wed, 29 Mar 2023 02:08:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CEB9B821AC;
        Wed, 29 Mar 2023 09:08:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941CFC433EF;
        Wed, 29 Mar 2023 09:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680080922;
        bh=1bBGA8NktkVBqzjr2FRdql4wXbWDk2rW1T2qFU/H/WY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AJRFZAFAZnYkDvEcmN0A82nvXmRVbfplHCpFLa/vgEDTwGcVsZ8U1S8KGwWS4A2Rk
         Sd3C0jUyxKTIPcIO9Ed3hC/FRnvPm4L7piw8S4LLuSZOdr8OuoBJ2UHrf/qGkTvpGo
         oE9dMJM+pXx20guVutDuajtgRwCrtqWoVilzVvj4=
Date:   Wed, 29 Mar 2023 11:08:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v9 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <ZCQAF-nrrsfBtviT@kroah.com>
References: <20230323071051.2184-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323071051.2184-1-tony@atomide.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 09:10:47AM +0200, Tony Lindgren wrote:
> --- /dev/null
> +++ b/drivers/tty/serial/serial_base.c
> @@ -0,0 +1,142 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

Given that the driver core is "GPL-2.0-only", why is this -or-later?

Sorry, I have to ask.


> +
> +/*
> + * Serial core base layer for controllers
> + *
> + * The serial core bus manages the serial core controller instances.

No copyright notice?  That's fine, but again, I have to ask.

thanks,

greg k-h
