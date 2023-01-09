Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6FA662B2C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbjAIQ2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbjAIQ1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:27:53 -0500
Received: from mailrelay5-1.pub.mailoutpod2-cph3.one.com (mailrelay5-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:404::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47D05FFA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 08:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=dTBh2Be6Q1A/kCwcp9I8OjPATYhgdC0pFQ07Wxod3+Y=;
        b=EOIf6mOnKkwHLtxJfgBg+c8bPYu10/CKQBjGac1w8zAfMoPxooFOFujSC2ijxczH4uOtY0Bvbr2DB
         dOfgp/+5vh+TdYJ9/gS2dW0oSa9EK9kwH08Gq6W7zHk+zYtXjrMB5o85CSGzKR/qu4SxRHIkB3YjhJ
         nK33nuOn8mS58pgxZ/8KZOujIXPLA8gEzLXSCWI63CwTYgbSjeYf3V9Aez9KhtnTgwWvhq865DJmyl
         OegDyOeMmkzrZLPHNHiOW8GLRLIFT2s4E6jlU9Z8KUTOcuTJzwVr7O4P+N+b3pvZOFVL9/CY1/0CS7
         UyPxebBNy3HMfqddcSX+d0Qa+M9j2aQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=dTBh2Be6Q1A/kCwcp9I8OjPATYhgdC0pFQ07Wxod3+Y=;
        b=6W6KcsOY9JYk9b8jg6LJ3hg3GFrer/Pt34tm0RAXXpZTaoIrXrRW9qNshWIWd8BH9aKUo8XvraB9r
         XpoLe/SAQ==
X-HalOne-ID: 8af36721-903a-11ed-b86b-7703b0afff57
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay5 (Halon) with ESMTPSA
        id 8af36721-903a-11ed-b86b-7703b0afff57;
        Mon, 09 Jan 2023 16:27:45 +0000 (UTC)
Date:   Mon, 9 Jan 2023 17:27:44 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Helge Deller <deller@gmx.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Antonino Daplas <adaplas@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>, Lee Jones <lee@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-staging@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, Stephen Kitt <steve@sk2.org>
Subject: Re: [PATCH 15/15] backlight: backlight: Drop the deprecated fb_blank
 property
Message-ID: <Y7xAgHgg0sfh32Ga@ravnborg.org>
References: <20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org>
 <20230107-sam-video-backlight-drop-fb_blank-v1-15-1bd9bafb351f@ravnborg.org>
 <Y7v1OxdowGdxgvUj@aspen.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7v1OxdowGdxgvUj@aspen.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel.

On Mon, Jan 09, 2023 at 11:06:35AM +0000, Daniel Thompson wrote:
> On Sat, Jan 07, 2023 at 07:26:29PM +0100, Sam Ravnborg via B4 Submission Endpoint wrote:
> > From: Sam Ravnborg <sam@ravnborg.org>
> >
> > With all users gone remove the deprecated fb_blank member in
> > backlight_properties.
> >
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Lee Jones <lee@kernel.org>
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> 
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

Thanks for the follow-up on all the backlight related patches.

> 
> 
> PS Please don't treat this like a maintainer Acked-by: and merge it
>    (Lee's not on holiday so work with Lee to figure out the merge
>    strategy ;-) ).
Nope, I am aware that the usual pattern here and wait for Lee to show
up.
For this patch there is a bug as I need to update a comment.
I will fix this when I resend after all the patches in flight has
landed. So likely after the next merge window,

	Sam

