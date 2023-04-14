Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0CF6E1D03
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 09:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjDNHTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 03:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDNHTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 03:19:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4214C06;
        Fri, 14 Apr 2023 00:19:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03167615AB;
        Fri, 14 Apr 2023 07:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A930AC433EF;
        Fri, 14 Apr 2023 07:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681456779;
        bh=YOGmlIeWOea1UxwP1vvPEOA2tt31dy0r2k9+GNwWsyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QRaDMit2dyhVao2j3mKIItS8mOLHwqSVKHsGQeOt8JzdOJLwYskhISpYG0yY2dqxR
         fK8jLFP5w6C35+3bMhjx3KwT8whYd6geSkmRPLiTnJ0zlsryvXJQjZHr+XnpMBYqgr
         LG2sxe4ff5oERS369yXmNA1SDT00FNYhZYPfqxdM=
Date:   Fri, 14 Apr 2023 09:19:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, opendmb@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Eric Tremblay <etremblay@distech-controls.com>,
        Wander Lairson Costa <wander@redhat.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250: Add missing wakeup event reporting
Message-ID: <ZDj-htAWWxJ5gqPr@kroah.com>
References: <20230413213957.1985949-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413213957.1985949-1-f.fainelli@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 02:39:54PM -0700, Florian Fainelli wrote:
> An 8250 UART configured as a wake-up source would not have reported
> itself through sysfs as being the source of wake-up, correct that.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 4 ++++
>  1 file changed, 4 insertions(+)

What commit does this fix?  Is it needed to go to stable kernel(s)?

thanks,

gre gk-h
