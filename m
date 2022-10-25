Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0138C60CEC7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJYOTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbiJYOTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:19:10 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6718A13E3C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:19:08 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 9B6393200945;
        Tue, 25 Oct 2022 10:19:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 25 Oct 2022 10:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666707545; x=1666793945; bh=VAcJBhh2sQ
        gVR7nnkpb9hlrFCM8vLrpSb6p4FzyesHo=; b=Li4SP42EFHvKsjN/pgLUUiom19
        95RnptbYew2zbJE3lgoONscmw6SFDad7yK+0+8un00w+DkuB8lIgfd11S2FjGiIN
        3RdyMogWcvSAxkRook9g9yUPiBt1skDbFSvlNDzA3ImNL0lgCY/KZ3gEQ906GJgD
        7FE43oIKcavi6BXOEyNI1TvF+ONOykAzkwEtZCUyP12z7Ovp1qLBHx+bHr0NpWmZ
        dirIdrlnWFJOnUmvmgg38oxLc5JxLjP9NHAfl+yeh5QhwURDfgueJny5dd7YDbp8
        C3jdKlfxJ4fjqPnLF6BeaEX3SluMQtiSY/tDPmsmPOCWVJVi1eMCD222QqwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666707545; x=1666793945; bh=VAcJBhh2sQgVR7nnkpb9hlrFCM8v
        LrpSb6p4FzyesHo=; b=SEBA5Gm9Vbpv8kQE79oVy1cVjXFzTGCO4uRMJwEIqNe8
        qyXLp+wioEAtYfXO221Ghued3zD+TG+veelkx03mpmo0OoHgGcPkeaMy8xe7T/gE
        hEGR/UMxk6N2wwTHkak3wsSRDnafVyCeFl24NVpVsB9h0LInnSnQx+WrIWsonI1i
        k7P47YCBFGEic+mSoD7GEbSnFUXmanHLpdCO7YWSfYExw/+MgJq+FZf++f6d17Fl
        211wbFoO2yTSlepQly6D+jyX9h4D0d/JpOzU2SAkJSbACzFz/tzXRW1LAK8AWD4j
        aP2mmfql/DOrYiibccJ9lWp6g31rAXOTCXhYZmDKNg==
X-ME-Sender: <xms:WPBXY4QygxBGqj7xsyGzjVWyMChT7D2h00nYublaseNjweQ62UNy-w>
    <xme:WPBXY1w25TgcEOov-KEvyP_tXL9l_WE8btjYkAF8-CQM5wt_y_A6K1RZoSpBSAplQ
    V-reL9uTSvh9EozvjU>
X-ME-Received: <xmr:WPBXY10lnwS2KMkPfAoH-1d_L1Je_UCQMNCJIqpH8aXw1jNwJcFZ7oZj0dk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtddtgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpedfvfihlhgv
    rhcujfhitghkshculdfoihgtrhhoshhofhhtmddfuceotghouggvsehthihhihgtkhhsrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehieeiueevgfetlefhjeekleeutddtudelveev
    hfekgefhhffhtedtffehuedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgesthihhhhitghkshdrtghomh
X-ME-Proxy: <xmx:WfBXY8Di80-8XQYNOvmrnvN-lg1A5KSbk16Wu-jcY0gA-9o_suazcg>
    <xmx:WfBXYxjQ0-3YZyO4ikRZKfKHmDpogbUBX5GE5mZBDz1BLpu9wUKGGw>
    <xmx:WfBXY4rGK7ediB4kodjxZva9F9ZR3Xd_iAfOUX5Z5_IM0yVSq5z7PQ>
    <xmx:WfBXY8VA8kYAH2MOXkl0EY0lxbBFEbiaxjV9VQNZvUPvP8N7tG0Gkg>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Oct 2022 10:19:04 -0400 (EDT)
Date:   Tue, 25 Oct 2022 09:18:54 -0500
From:   "Tyler Hicks (Microsoft)" <code@tyhicks.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vijay Balakrishna <vijayb@linux.microsoft.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clocksource/drivers/arm_arch_timer: Fix event stream
 param in Kconfig
Message-ID: <20221025141854.22ppd7mw3vb6esgr@sequoia>
References: <20221024195118.871907-1-code@tyhicks.com>
 <86pmegdwug.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86pmegdwug.wl-maz@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-25 11:24:55, Marc Zyngier wrote:
> Hi Tyler,
> 
> On Mon, 24 Oct 2022 20:51:18 +0100,
> Tyler Hicks <code@tyhicks.com> wrote:
> > 
> > From: "Tyler Hicks (Microsoft)" <code@tyhicks.com>
> > 
> > Fix the event stream timer command line parameter name that's documented
> > in the Kconfig description for CONFIG_ARM_ARCH_TIMER_EVTSTREAM. It
> > didn't match the command line parameter name that's actually honored in
> > the source code.
> > 
> > Reported-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
> > Fixes: 46fd5c6b3059 ("clocksource/drivers/arm_arch_timer: Control the evtstrm via the cmdline")
> > Cc: stable@vger.kernel.org
> 
> No, this really doesn't deserve a Cc: stable. This bit may be wrong,
> but we have the correct information in the kernel-parameters.txt file,
> which is authoritative AFAIC.

Thanks for the review!

I added the stable tag because it caused an actual waste of time in an
investigation. Upon discovering this option, I didn't notice the subtle
difference in cmdline parameter name from the Kconfig, to the
kernel-parameters.txt file and the code. I ran long-running stress tests
with the incorrect parameter name copied and pasted from the Kconfig.
This error resulted in a bad data point in the investigation and it took
a second set of eyes (Vijay's) to uncover my mistake days later when we
were trying to reconcile the bad data point with other good data points.

It is no big deal if it is merged with the tag dropped but I wanted to
provide my reasoning of why I personally felt this was a more than just
a comment typo fix or something along those lines. Thanks, again!

Tyler

> 
> > Signed-off-by: Tyler Hicks (Microsoft) <code@tyhicks.com>
> > ---
> >  drivers/clocksource/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index 4469e7f555e9..dcc274460973 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -315,7 +315,7 @@ config ARM_ARCH_TIMER_EVTSTREAM
> >  	  executing the wfe instruction at a frequency represented as a
> >  	  power-of-2 divisor of the clock rate. The behaviour can also be
> >  	  overridden on the command line using the
> > -	  clocksource.arm_arch_timer.evtstream parameter.
> > +	  clocksource.arm_arch_timer.evtstrm parameter.
> >  	  The main use of the event stream is wfe-based timeouts of userspace
> >  	  locking implementations. It might also be useful for imposing timeout
> >  	  on wfe to safeguard against any programming errors in case an expected
> 
> With this tag dropped,
> 
> Acked-by: Marc Zyngier <maz@kernel.org>
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
