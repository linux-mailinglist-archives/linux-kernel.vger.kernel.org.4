Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4532E6C8F59
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 17:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjCYQJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 12:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCYQJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 12:09:51 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9C4E192;
        Sat, 25 Mar 2023 09:09:50 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 1F5A91C0AB3; Sat, 25 Mar 2023 17:09:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1679760589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kcU/9fFXfNqYOTgmAwmcaMU+wBoR0qh6jAjCJEANVdg=;
        b=JMM6sAZiMnfxahJFdVg7uY5hYAP3wcePo4ugVmHCqi+5g8UHeL8prGdDXt7+1myv6fasXZ
        LDxZITyNWCwzsvV7Cvnkpm5GB+hTv2Oj7sa4Y1CFNhhWoiF/Ti9/c8oTveFbWQCT2BaTU5
        4H0uqKx/Baniawwt/+ncjQ0aZgp/nVs=
Date:   Sat, 25 Mar 2023 17:09:46 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Joseph Strauss <jstrauss@mailbox.org>
Cc:     lee@kernel.org, jansimon.moeller@gmx.de, conor@kernel.org,
        christophe.jaillet@wanadoo.fr, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Add multicolor support to BlinkM LED driver
Message-ID: <20230325160946.GC1820@bug>
References: <20221228010958.9670-1-jstrauss@mailbox.org>
 <ZBw5E4ecNvfgd0RB@duo.ucw.cz>
 <20230325155355.gxnjpyl3mnyq2lst@libretux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230325155355.gxnjpyl3mnyq2lst@libretux>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2023-03-25 10:53:55, Joseph Strauss wrote:
> On 23/03/23 12:33PM, Pavel Machek wrote:
> > Hi!
> > 
> > > In the blinkm_probe function, the multicolor LED class is registered
> > > after the regular LED classes. The blinkm_set_mc_brightness() function
> > > had to be added to calculate the three color components and then set the
> > > fields of the blinkm_data structure accordingly.
> > 
> > It needs to be either single multicolor LED or three separate
> > LEDs. But not both at the same time.
> > 
> 
> Thank you for the feedback! How would you suggest I go about handling
> this? Is there a preferred way to ask the user which way they want to
> control the LED (Kconfig?), or should I remove the code for three
> separate LEDs entirely? Originally, I didn't delete the code because I
> thought it would be bad to remove the existing interface.

It kind of is bad. ... but hopefully blinkm users can adjust.

You could do Kconfig if it was easy.

BR,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
