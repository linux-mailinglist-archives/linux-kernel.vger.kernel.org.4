Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788FF64A492
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 17:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbiLLQIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 11:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiLLQIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 11:08:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CA213D75;
        Mon, 12 Dec 2022 08:07:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3B4461130;
        Mon, 12 Dec 2022 16:07:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBA4C433D2;
        Mon, 12 Dec 2022 16:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670861274;
        bh=WwnYlPtkuw+Ow6a4SYeX/8UoIZRk0Qh11SrgzRO24rw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WxbaR4vfBYZYLLCs6iYyCHTboCSG/GajlwHKR2y+js+30KB8Rqt0VSj4xjdoRvX0R
         +oATBw5D0HQ5rjYyxJDRhY59RHsUuNt3cp4ucRWnM1IyDKZ8Jry01InV2Pb7a8ddW1
         GkNxWL+P/Or8XBo+XinL8EOL6uBQt7EGoHZwDPlv5LriNwtmatIIp3MBA/B7/lAH7Q
         yk/Zqykwn2kSaRsOjnXUcgUN4YJ7xmNSQn+mzcwz37fWQDW5O1jibSGiAvdEgyiRO9
         WkXqKxhWZH5X0Fmt/68GFBLdrwVYmfUJMyyc+Z94G7qjyMVw43rgvsgipE43kHKrPf
         4EbkBTpPOUYdw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p4lLl-0000Q6-PE; Mon, 12 Dec 2022 17:08:17 +0100
Date:   Mon, 12 Dec 2022 17:08:17 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: drop misleading usb_set_intfdata() kernel doc
Message-ID: <Y5dR8X2mnytSCWrp@hovoldconsulting.com>
References: <20221211120626.12210-1-johan@kernel.org>
 <efca6b26-fb20-ae38-0fc4-8612f1ee150b@suse.com>
 <Y5cDBSZrgC2TUnXs@hovoldconsulting.com>
 <4cf7bce3-dfbb-b064-9d91-27616bf11d6a@suse.com>
 <Y5cpH8aV7aox2Pbd@hovoldconsulting.com>
 <2a2935e6-ae3c-85d9-a2e9-f42fb4ca7d59@suse.com>
 <Y5cvPulXceujfZv6@hovoldconsulting.com>
 <b1a5874b-8028-db14-e2ac-ebe3967559a5@suse.com>
 <Y5c3WWKyohzkspnw@hovoldconsulting.com>
 <Y5dH5RqY2yOK1bVj@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5dH5RqY2yOK1bVj@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 10:25:25AM -0500, Alan Stern wrote:

> > Since you insist, I'll just rewrite the whole thing.
> 
> You're both missing the main point, which is that the USB core clears 
> intfdata after a driver is unbound.

I assure you that that hasn't been missed. :)

> As a consequence, drivers don't 
> need to worry about clearing intfdata themselves -- a fact which is 
> _not_ easily apparent from the implementation.  This would be a useful 
> thing to mention in the kerneldoc, as it may help prevent lots of 
> drivers from making unnecessary function calls (like the ones that 
> Vincent recently removed).

My point is that the fact the USB core (and driver core) clears the
pointer after the driver is unbound is mostly irrelevant. The driver
would typically have freed the driver data at that point anyway, and the
interface must no longer be used by the driver (e.g. as it could be
bound to a new driver).

This is a fundamental property of the driver model and not something
that necessarily needs to be repeated for every function that operates
on a struct device (or a subsystem container like struct usb_interface).

> Of course, this doesn't mean that drivers can't clear intfdata if they 
> want to, for example, if they use it as an internal flag.  But 
> developers shouldn't feel that they _need_ to clear it as a sort of 
> hygienic measure.

Right.

> IMO it's worthwhile keeping the kerneldoc (but correcting it) so that it 
> can get this point across.

As you saw I fixed up the kernel doc in v2, and tried to get the point
about not having to clear the pointer across without getting into too
much detail.

The fact that USB core and driver core clears the pointer is an
implementation detail which in principle could change. The important
part is that drivers generally should not touch the struct device or
containing structure after unbind (and must do so with care otherwise).

Johan
