Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B566F640E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 06:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjEDE3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 00:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjEDE3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 00:29:40 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02B4E7;
        Wed,  3 May 2023 21:29:38 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2350D5C02FF;
        Thu,  4 May 2023 00:29:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 04 May 2023 00:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1683174577; x=1683260977; bh=ZWknfOeAL8oARcgU8JU8rBehj/kg0W2299E
        1L9NBPpg=; b=SC0Nie4KXrxGkrPtbP/AkZ+91+f92hwe7tjzAmER22sP5BePZGk
        I9bIHcvD1YjvyWyfSY2UF+o0XMivFUlalvaBQ9f/ED4qvosGevnkm6ltt04nIrQc
        zpoCnWp6PRKZ+3dnuzxvsFTAIUQg1+lkOiNbgB2pQ9wqjBnZN1s/xGfwxOATQFL9
        wAAm93jwgrWR7GDYjNJtsHVIehMIIJ2kRfsT6eR0JGRl1XwzYN8XKIroBHImcVoy
        GKGLpKNnkRPmqh9qTeqqs1F5eu9qkUkqJlYEWgEzHqqeCGReFXEEimN5A+x8OITg
        FYiyxQas4uI88RBBJoTzsDPGS2UJzZRr8BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1683174577; x=1683260977; bh=ZWknfOeAL8oARcgU8JU8rBehj/kg0W2299E
        1L9NBPpg=; b=bcWeT78JW9sItRwCE3z7BqwZSs++zBqDI5KNQkEQeJ4WgWNX0AR
        cxhpby/J7xncnHSmuQNimTt/Qk08LKQZMwFteaybXuTk5gs2xuacSI++DKTAZ1qj
        EN9fhM0AdbZuzPjWasLdEPousLfsTRMIvWrjxNQF5kPvJBaX5btJt8x94Q0LSFOb
        MtWfD0kXD1hDVy8AvgmHLT3gqSzPllcYntIUHw4KNdeSAdiPUhXPxxMPIFxvqNQ1
        bhBmSA8vp5xDCScIY66Rnq5BWI44QTgEdfzwvVfnF15Hy3r7Sk7+5J5lKTWmm5Am
        I+kh0QfXUkL5zB9bBOP35w3XO4quCaq5cTA==
X-ME-Sender: <xms:sDRTZPsqqzxnMwOw6tI3PpMvmAWXOkoxCEiTQciuAllti8AjTUYAAg>
    <xme:sDRTZAfr2C4_6UAzewL2rcr8sJP8ZYs6ZydPVp0L0Mi9YewSKuKpz743nHFqtJvT6
    x6SMomuhoGgLlhf4bA>
X-ME-Received: <xmr:sDRTZCy0WImi8FQU68dW0BmROo65c7wSOLL2ZO_odkkY_zzqFw6dH84q91t03tIi2-Dtusoa705dwiW3bW9PEXkMnxImsrB7US0s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvledgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefrvght
    vghrucfjuhhtthgvrhgvrhcuoehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnh
    gvtheqnecuggftrfgrthhtvghrnhepleeitdfhjeegkeegkeekleejjeegledvudekhfdt
    keegieeuvdffleeffedtffdtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvght
X-ME-Proxy: <xmx:sDRTZOOqF7IyHoh8LjaVLqILW-5Xb8kknNNt6FU1DrF-cZMT6M_FMA>
    <xmx:sDRTZP94I7c53I9QGuVxanCyHCCRcE20TtQSUqxELovY5g6lt2a5jQ>
    <xmx:sDRTZOU6ygYs77P0Kb-R5DCvycV0ByYSk_ar1EgmUwwIrkeFrSyeQw>
    <xmx:sTRTZMhMeDjWKrueZL4RLXaCU6rO02-nR3FAH8_VgGo0YE5WagkIQw>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 May 2023 00:29:30 -0400 (EDT)
Date:   Thu, 4 May 2023 14:29:27 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Javier Carrasco <javier.carrasco@wolfvision.net>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Stephen Boyd <sboyd@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Uwe Kleine-g <u.kleine-koenig@pengutronix.de>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [RFC v1 0/4] Input: support virtual objects on touchscreens
Message-ID: <20230504042927.GA1129520@quokka>
References: <20230425115049.870003-1-javier.carrasco@wolfvision.net>
 <419c9d72-9791-46ff-8317-b4dfe2e2d0a3@t-8ch.de>
 <ZEf5rfzs22HtQivB@nixie71>
 <aa6125d9-1233-7aab-1811-29acd4ad49a5@wolfvision.net>
 <ZEqvgnhzm7r4O7hz@nixie71>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZEqvgnhzm7r4O7hz@nixie71>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 12:23:14PM -0500, Jeff LaBundy wrote:
> Hi Javier,
> 
> On Thu, Apr 27, 2023 at 05:59:42PM +0200, Javier Carrasco wrote:
> > Hi,
> > 
> > On 25.04.23 18:02, Jeff LaBundy wrote:
> > > Hi Thomas,
> > > 
> > > On Tue, Apr 25, 2023 at 05:29:39PM +0200, Thomas Weißschuh wrote:
> > >> Hi Javier,
> > >>
> > >> On 2023-04-25 13:50:45+0200, Javier Carrasco wrote:
> > >>> Some touchscreens are shipped with a physical layer on top of them where
> > >>> a number of buttons and a resized touchscreen surface might be available.
> > >>>
> > >>> In order to generate proper key events by overlay buttons and adjust the
> > >>> touch events to a clipped surface, these patches offer a documented,
> > >>> device-tree-based solution by means of helper functions.
> > >>> An implementation for a specific touchscreen driver is also included.
> > >>>
> > >>> The functions in ts-virtobj provide a simple workflow to acquire
> > >>> physical objects from the device tree, map them into the device driver
> > >>> structures as virtual objects and generate events according to
> > >>> the object descriptions.
> > >>>
> > >>> This solution has been tested with a JT240MHQS-E3 display, which uses
> > >>> the st1624 as a touchscreen and provides two overly buttons and a frame
> > >>> that clips its effective surface.
> > >>
> > >> There are quite a few of notebooks from Asus that feature a printed
> > >> numpad on their touchpad [0]. The mapping from the touch events to the
> > >> numpad events needs to happen in software.
> > > 
> > > That example seems a kind of fringe use-case in my opinion; I think the
> > > gap filled by this RFC is the case where a touchscreen has a printed
> > > overlay with a key that represents a fixed function.
> > 
> >  Exactly, this RFC addresses exactly such printed overlays.
> > > 
> > > One problem I do see here is something like libinput or multitouch taking
> > > hold of the input device, and swallowing the key presses because it sees
> > > the device as a touchscreen and is not interested in these keys.
> > 
> > Unfortunately I do not know libinput or multitouch and I might be
> > getting you wrong, but I guess the same would apply to any event
> > consumer that takes touchscreens as touch event producers and nothing else.
> > 
> > Should they not check the supported events from the device instead of
> > making such assumptions? This RFC adds key events defined in the device
> > tree and they are therefore available and published as device
> > capabilities. That is for example what evtest does to report the
> > supported events and they are then notified accordingly. Is that not the
> > right way to do it?
> 
> evtest is just that, a test tool. It's handy for ensuring the device emits
> the appropriate input events in response to hardware inputs, but it is not
> necessarily representative of how the input device may be used in practice.

ftr, I strongly recommend "libinput record" over evtest since it can be
replayed. And for libinput testing "libinput debug-events" to see what
comes out of libinput.

> I would encourage you to test this solution with a simple use-case such as
> Raspbian, and the virtual keys mapped to easily recognizable functions like
> volume up/down.
> 
> Here, you will find that libinput will grab the device and declare it to be
> a touchscreen based on the input events it advertises. However, you will not
> see volume up/down keys are handled.

that would be a bug in libinput. libinput doesn't classify devices. It
uses *internal* backends but the backend for keyboard and touchscreen
devices is the same. So as long as your device advertises the various
EV_KEY and EV_ABS bit correctly, things should just work. If that's not
the case for a device please file a bug.

It's still "better" to split it up into different event nodes because
a lot of userspace may not be able to handle touchscreen+keyboard
devices but at least at the libinput level this shouldn't be a problem.

And the xf86-input-libinput driver splits up such devices at the X
level, so even where a device is touchscreen + keyboard you would end up
with two X devices with separate capabilities so they fit into the X
"everything is either a pointer or a keyboard" worldview.

Cheers,
  Peter

