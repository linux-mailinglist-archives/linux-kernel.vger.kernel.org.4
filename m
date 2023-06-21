Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B720E737CD1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjFUHm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjFUHmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:42:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C13E65
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 00:42:08 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qBsTa-0004Rj-9Y; Wed, 21 Jun 2023 09:42:02 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qBsTX-0003Jg-KN; Wed, 21 Jun 2023 09:41:59 +0200
Date:   Wed, 21 Jun 2023 09:41:59 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Conor Dooley <conor@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-rockchip@lists.infradead.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        kernel@pengutronix.de, Vincent Legoll <vincent.legoll@gmail.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 22/26] dt-bindings: devfreq: event: rockchip,dfi: Add
 rk3588 support
Message-ID: <20230621074159.GN18491@pengutronix.de>
References: <20230616062101.601837-1-s.hauer@pengutronix.de>
 <20230616062101.601837-23-s.hauer@pengutronix.de>
 <20230616-swimwear-prewar-f9dce761d2ec@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616-swimwear-prewar-f9dce761d2ec@spud>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 08:05:33PM +0100, Conor Dooley wrote:
> On Fri, Jun 16, 2023 at 08:20:57AM +0200, Sascha Hauer wrote:
> > This adds rockchip,rk3588-dfi to the list of compatibles. Unlike ealier
> > SoCs the rk3588 has four interrupts (one for each channel) instead of
> > only one, so increase the number of allowed interrupts to four.
> > 
> > Link: https://lore.kernel.org/r/20230524083153.2046084-23-s.hauer@pengutronix.de
> 
> It's unclear what the point of this link is.

The link was added automatically by b4. I re-applied the series from the
last one I sent just to be sure that I base my work for the new series
on the one I sent last time. I didn't remember that b4 adds these links,
I should have disabled that option.

> My comment still stands about whether only the new compatible should be
> permitted to have more than one interrupt. I don't recall a response to
> that question on the last version.

My personal take on this is that such additions make the bindings more
readable by machines, but less by humans. That's why I don't have enough
intrinsic motivation to make this change. Anyway, if you insist then
I'll make it for the next round.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
