Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EEC5E6057
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiIVLCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiIVLCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:02:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66219DB51
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 04:02:05 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1obJxf-0000pp-8W; Thu, 22 Sep 2022 13:01:43 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1obJxe-0007J2-58; Thu, 22 Sep 2022 13:01:42 +0200
Date:   Thu, 22 Sep 2022 13:01:42 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        devicetree@vger.kernel.org, jacopo@jmondi.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        kieran.bingham+renesas@ideasonboard.com,
        linux-kernel@vger.kernel.org, kishon@ti.com, hverkuil@xs4all.nl,
        vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-phy@lists.infradead.org,
        mchehab@kernel.org, kernel@pengutronix.de,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v2 3/4] media: dt-bindings: add bindings for Toshiba
 TC358746
Message-ID: <20220922110142.qnx6w3qbb6h6grvh@pengutronix.de>
References: <20220916134535.128131-4-m.felsch@pengutronix.de>
 <YyZTCsflWtUbo2ld@pendragon.ideasonboard.com>
 <20220919100844.bb7tzbql2vpk76xz@pengutronix.de>
 <YyhDO4ohv47uIij2@paasikivi.fi.intel.com>
 <YyhKoDxFoobY9vBd@pendragon.ideasonboard.com>
 <20220920152632.mjpgpmelvx4ya4k7@pengutronix.de>
 <Yyn5MqqKYH7VpFhw@pendragon.ideasonboard.com>
 <74b6b670-747a-f326-44ea-7588c3989b0e@linaro.org>
 <20220921083513.drt4rggqj7tpaygr@pengutronix.de>
 <8e54e03e-105a-cf3e-242f-796bef77bfe1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e54e03e-105a-cf3e-242f-796bef77bfe1@linaro.org>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-09-21, Krzysztof Kozlowski wrote:
> On 21/09/2022 10:35, Marco Felsch wrote:
> > On 22-09-21, Krzysztof Kozlowski wrote:
> >> On 20/09/2022 19:32, Laurent Pinchart wrote:
> >>>>>
> >>>>> Explicit bus types in DT indeed makes it easier for drivers, so if a
> >>>>> device can support multiple bus types (even if not implemented yet in
> >>>>> the corresponding drivers), the property should be there.
> >>>>
> >>>> Okay, I will make it required.
> >>>>
> >>>>>> Why do you have hsync-active and vsync-active if both are always zero? Can
> >>>>>> the hardware not support other configuration?
> >>>>
> >>>> Sure the device supports toggling the logic but it is not implemented.
> >>>> So the bindings needs to enforce it to 0 right now. As soon as it is
> >>>> implemented & tested, we can say that both is supported :)
> >>>
> >>> Bindings are not supposed to be limited by the existing driver
> >>> implementation, so you can already allow both polarities, and just
> >>> reject the unsupported options in the driver at probe time. Future
> >>> updates to the driver won't require a binding change.
> >>>
> >>
> >> +1
> > 
> > I don't wanna do that because this let the binding user assume that
> > this mode is already supported. 
> 
> What do you mean by "not supported"? By which system? By which firmware
> element? Bindings are used by several operating systems and several
> projects.

And they can use it and of course extend it, since the propery is
available.

> That's not the argument.
> 
> Bindings should be complete. Lack of knowledge and datasheets is a good
> exception from this rule. Looking at Linux driver is not good exception.

So if I get you right, you are saying that the bindings should always be
complete and describe all ever possible combinations? I am on your side
that the properties should be there from day one. But listing all
possible values regardless of the support.. I don't know and yes, I know
that other projects using these bindings as well. But if those other
projects support more than now, they can extend it and send patches.
Since this is a new binding, the only user is Linux and listing all
possible values can lead into erroneous assumption. No system-integrator
wants to check the driver why a listed property is not supported instead
most the time it is the other way. If it is listed, than it should be
supported.

Anyway I don't wanna make a big deal out of it. I will add all possible
values to the binding if that is what you want :)

Regards,
  Marco

> > Adapting a binding is just 1 commit and
> > since the property is already existing, there is no breaking change.
> Best regards,
> Krzysztof
> 
> 
