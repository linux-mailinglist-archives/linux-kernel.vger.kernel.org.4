Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFEE6350FC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 08:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbiKWHNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 02:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbiKWHM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 02:12:59 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AC071CB2C;
        Tue, 22 Nov 2022 23:12:59 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 51D2F816A;
        Wed, 23 Nov 2022 07:12:58 +0000 (UTC)
Date:   Wed, 23 Nov 2022 09:12:56 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, b-liu@ti.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: musb: remove extra check in musb_gadget_vbus_draw
Message-ID: <Y33H+Pqf3QoN8/IM@atomide.com>
References: <1668416387-24984-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <Y3z0nvoyiHQZ3MnY@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3z0nvoyiHQZ3MnY@kroah.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH <gregkh@linuxfoundation.org> [221122 16:01]:
> On Mon, Nov 14, 2022 at 10:59:47AM +0200, Ivaylo Dimitrov wrote:
> > The check for musb->xceiv->set_power duplicates the check done in
> > usb_phy_set_power(). Moreover, not calling usb_phy_set_power() results in
> > current USB config max current not being propagated through usb_charger FW
> 
> What does "FW" mean here?
> 
> > 
> > Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> > ---
> >  drivers/usb/musb/musb_gadget.c | 2 --
> >  1 file changed, 2 deletions(-)
> 
> And is this a bugfix?  If so, what commit id does it fix?  Should it go
> to stable kernels?  What hardware was this tested on that this solved a
> problem for?
> 
> Please fix this and send a v2.

Ivaylo please also test with the musb phy changes in Linux next that might
affect this patch.

Regards,

Tony
