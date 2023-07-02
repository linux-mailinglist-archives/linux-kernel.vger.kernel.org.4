Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3E27452FB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 00:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjGBWdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 18:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjGBWdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 18:33:21 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B4DE50;
        Sun,  2 Jul 2023 15:33:17 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkzdf0gkyyyyyyyyyyyyt-3.rev.dnainternet.fi [IPv6:2001:14ba:4506:4f15::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4QvP2x1Wcqz49Q2n;
        Mon,  3 Jul 2023 01:33:12 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1688337195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Vq7iQBrN69OxuE9bJ+ZN+drPsjGsqsr4TGpW7XKLJ8=;
        b=v/FxeuxfV5OpR4gn+E627WvcIv5wlYTO3C20TZwQpt2RzBrhYB87gzCeMls2pp0Z3GRpyx
        fOVeiajOp1F7w+AML3CI7vRlBluOOMhHNlFLX/Nevkyqhry4awIQAJzoN703dl/db8O1ba
        UrAY06sL6osKJVsDZ/rMLZy+wO+XYcrjlysTWBcOO/4IvIL4a2ANnKkH2JW8PZUbp2BE+y
        X13PvrwQw33scXQzIVuwtHDlzaVQ0ypzCmL7ERYsyd/MmVemyb861H5DPmKhLwD9aTssPA
        8Qt1d/ItBF0pVkw6mRCaNI9+houqW1T3b8f8GEX2ngnbim5MeIExtqnEpM0ZNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1688337195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Vq7iQBrN69OxuE9bJ+ZN+drPsjGsqsr4TGpW7XKLJ8=;
        b=ZROHnp98O8v5MWk/P0Fry6ZKqhBbuY1ZConJS516gx3SypeJe+U0GQIGicEXUGBIDhMMYz
        Mn6EdM9f4FQwHnlO0pKR/S5YMMoWomAYpbS7lbOm3JTodsxvaeW0Cyi5Rm1oqa7emjaDQ5
        sRaplBzoNhk9AdFYvOw+XnOlO59+1I6sIuJmPpGLsDH+QbtT2M+htrgCQehCUN/krE6SY8
        1JDd1B5LQuo8hQvZKOemgPvzbqeJr1Rg7jhE9/MVNBY+aWVMzo8QukWMbvkldftyrPJL90
        fyNuCM9/QpLO0SfVJxYTdh58nYkvO1+2eyeERUUUdEcYozN5HNWwxZSeAeEkOA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1688337195; a=rsa-sha256;
        cv=none;
        b=PHCOUO8gdh1WhwQ4tZcMqX7EQS+3r9LGgAw9yGv1DuaaiRfP+PDWsPr8gFlNM4mW/iWaAg
        oZrwrWaF01f9nCj8MkLKXF5IpiKtlgdPVnjrMEbTKWFWqptkUoC9pUK5+GUZTEP0BmK1vh
        q2fLfcHcxPJ9RqoGCyOIodsTvdaUWgeSHBiz00dxeJYtfTEHstoav1HHDJ0xQrjlwuRqLX
        eRGPAgWOkC2KqWCMAmDgQI7GsASSdaEoCsiSmgpe8hRNYlJztubf4Hc56ar6uZ4Boc/x7e
        79YnRdq6mYO8GTc/w9UrrgLul639/Q4a1nwpLnP+3QUzZS17+LG0ogSypwFFpA==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 9315A634C93;
        Mon,  3 Jul 2023 01:33:12 +0300 (EEST)
Date:   Sun, 2 Jul 2023 22:33:12 +0000
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, lukasz@jany.st,
        mchehab@kernel.org, naush@raspberrypi.com, robh@kernel.org,
        tomi.valkeinen@ideasonboard.com,
        bcm-kernel-feedback-list@broadcom.com, stefan.wahren@i2se.com
Subject: Re: [PATCH v5 04/11] media: bcm2835-unicam: Add support for
 CCP2/CSI2 camera interface
Message-ID: <ZKH7KOtlGElmHjIm@valkosipuli.retiisi.eu>
References: <20220208155027.891055-5-jeanmichel.hautbois@ideasonboard.com>
 <YhihbncnSlmvrn/D@valkosipuli.retiisi.eu>
 <20230702152356.GA16995@pendragon.ideasonboard.com>
 <ZKG/bej80eL13Qqp@valkosipuli.retiisi.eu>
 <20230702214505.GB16995@pendragon.ideasonboard.com>
 <20230702214711.GC16995@pendragon.ideasonboard.com>
 <ZKHye/4kARSHqsIJ@valkosipuli.retiisi.eu>
 <20230702220138.GE9285@pendragon.ideasonboard.com>
 <ZKH4LXKHX8G1WK7a@valkosipuli.retiisi.eu>
 <20230702222803.GF9285@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230702222803.GF9285@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 01:28:03AM +0300, Laurent Pinchart wrote:
> On Sun, Jul 02, 2023 at 10:20:29PM +0000, Sakari Ailus wrote:
> > On Mon, Jul 03, 2023 at 01:01:38AM +0300, Laurent Pinchart wrote:
> > > > > > > > > If the hardware doesn't support lane remapping for CCP2, then that should
> > > > > > > > > be reflected in DT bindings, i.e. data-lanes isn't relevant. There's no
> > > > > > > > > need to check that here.
> > > > > > > > 
> > > > > > > > Should the above check for CSI-2 be dropped as well then ?
> > > > > > > 
> > > > > > > Same for CSI-2, too: if there's nothing to configure there (lane remapping)
> > > > > > > there's no need to validate that part of the DT either.
> > > > > > 
> > > > > > OK, I'll drop that.
> > > > > 
> > > > > Actually, I'm wondering if it would make sense to tell the parsing
> > > > > functions whether lane reordering is supported or not. The checks could
> > > > > then be moved to the framework. What do you think ?
> > > > 
> > > > I'm not sure how useful this check would be in the first place: if you have
> > > > hardware that can reorder the lanes, the framework doesn't know what to
> > > > check there (if anything) and otherwise there's little point in the
> > > > entire check.
> > > 
> > > Isn't it good to tell users that something is wrong instead of accepting
> > > the invalid configuration and let them wonder why the device isn't
> > > working ? Users in this case would be system integrators, not end
> > > users, but we have lots of debugging information in the kernel aimed for
> > > them already.
> > 
> > In which of the two cases above the framework could do something useful
> > there? For devices where you can reorder the lanes or for those where you
> > can't?
> 
> For devices where you can't, to detect DT that reorders lanes.

I'd suggest to ignore that. The data-lanes property is only used to tell
the number of lanes in that case, even bindings just specify the number of
entries in general.

The parser notifies about that, though, if the numbers clash, using a debug
messages --- since it's not an error (or even worth warning about).

-- 
Sakari Ailus
