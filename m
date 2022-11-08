Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1843621DAB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 21:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiKHU2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 15:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiKHU2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 15:28:23 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209BC554DC;
        Tue,  8 Nov 2022 12:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=cu/Nq8NSTxGmNeXXn7OeR7u1GCvrQSeqPMHwOJbQwEI=; b=pvB41jdPI6bkGA/24CTuwPpNuX
        ynqPInOEv1yVnKKuAHtMi1nF9Oso4ySQCCD2LgaLeO5svhMvT/pylgBgB/FkuvFsVAACPv6QbD/J9
        CcTR0JolyTtagPedXrnd3meQQsiyNbgD4KzDL9sKlgXG7PzT9tRyTI66iXB5tAT81ocg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1osVC0-001r2n-Aq; Tue, 08 Nov 2022 21:27:32 +0100
Date:   Tue, 8 Nov 2022 21:27:32 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Deepak R Varma <drv@mailo.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: patches for staging:media drivers
Message-ID: <Y2q7tFF7YeX16H20@lunn.ch>
References: <Y2eSCZJNWn6DzCUu@qemulion>
 <48f4bda9-b5e3-9649-aab9-b529889bf110@linaro.org>
 <Y2oO7fU4whKr+3hb@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2oO7fU4whKr+3hb@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 11:10:21AM +0300, Dan Carpenter wrote:
> On Mon, Nov 07, 2022 at 06:29:30PM +0100, Neil Armstrong wrote:
> > Hi,
> > 
> > On 06/11/2022 11:52, Deepak R Varma wrote:
> > > Greetings to all.
> > > My name is Deepak R Varma and I was part of the recent Outreachy internship
> > > round. I learned during this program that patches for the media drivers were
> > > prohibited to be included in the Outreachy effort due to lack of bandwidth for
> > > the maintainers to respond on those.
> > > 
> > > The Outreachy round is now over but I am continuing to work on code improvement
> > > and changes. I would like to know if it is okay for me to now identify
> > > opportunities in the media drivers and send patch proposal for your kind
> > > consideration. I intend to send couple of Coccinelle identified code
> > > improvements as patches.
> > > 
> > > Please let me know.
> > 
> > I won't say no but since the media maintainers will need to apply them,
> > the problem is the same.
> 
> Yeah.  Me either.  Those rules are for Outreachy so they don't apply to
> anyone else, but at the same time no one is going to Ack your patches
> without seeing them and especially for a subsystem they don't maintain.
> 
> I always try to think about if maintainers will want my patches.  Like
> I sometimes see people returning -1 instead of -ENOMEM but, you know,
> unless it reaches user space it's not technically a bug.  You can't go
> around fixing everyone's bad taste.  But everyone likes bug fixes.

I cannot say anything about the media subsystem, but for networking
patches, i will be much more willing to help somebody going from
Outreach to being a full kernel developers if they decide to take on
something more than just some Coccinelle changes. If it looks like you
have the hardware and want to make it better, have a vision where the
driver should go, then you are likely to get more help from me. So if
media drivers are what you interested in, go buy some hardware which
uses one of the drivers in staging, look at the TODO file, and submit
bigger patches than just -1 to -ENOMEM.

     Andrew
