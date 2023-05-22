Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5BD70BA2F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 12:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjEVKap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 06:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjEVKaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 06:30:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F353E49
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 03:30:09 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1q12ne-0002T8-3x; Mon, 22 May 2023 12:29:58 +0200
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1q12nZ-0001jw-Dh; Mon, 22 May 2023 12:29:53 +0200
Date:   Mon, 22 May 2023 12:29:53 +0200
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Diederik de Haas <didi.debian@cknow.org>
Cc:     Jacob Chen <jacob-chen@iotwrt.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND 0/2] media: rockchip: rga: Add rk3568 support
Message-ID: <20230522102953.GB23678@pengutronix.de>
Mail-Followup-To: Michael Tretter <m.tretter@pengutronix.de>,
        Diederik de Haas <didi.debian@cknow.org>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230119-rk3568-rga-v1-0-43d4d14365e6@pengutronix.de>
 <168466589373.900480.8086350880534437090.b4-ty@sntech.de>
 <2386524.2IynHR6iFi@prancing-pony>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2386524.2IynHR6iFi@prancing-pony>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 May 2023 21:32:51 +0200, Diederik de Haas wrote:
> On Sunday, 21 May 2023 12:44:58 CEST Heiko Stuebner wrote:
> > On Fri, 20 Jan 2023 10:14:21 +0100, Michael Tretter wrote:
> > > The RGA2 on the Rockchip rk3568 is the same core as the RGA2 on the
> > > Rockchip rk3288.
> > > 
> > > This series adds the necessary device tree binding and node in the device
> > > tree to enable the RGA2 on the Rockchip rk3568.
> > > 
> > > I tested the driver with the GStreamer v4l2convert element on a Rock3
> > > Model A board.
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [1/2] media: dt-bindings: media: rockchip-rga: add rockchip,rk3568-rga
> >       commit: 9b12ceb5a80d1fb45d293265de100e33b5843943
> > [2/2] arm64: dts: rockchip: Add RGA2 support to rk356x
> >       commit: 0c3391f8bb06b744df521651534cd99e3d77e0a8
> 
> https://lore.kernel.org/all/TY3P286MB26115F60D273E840D36A610598CA9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM/
> 
> indicated that there was a problem with device >= 4GB (RAM?):
> > Since we have the over-4GB problem now, should we mark this problem as a
> > TODO or something?
> 
> I thought that was the reason that these patches weren't picked up before?

That's what I thought, too.

> 
> I have no insight into this problem, so I can't comment on the technical
> aspects, but I had made a note for myself 'locally' about it.

Using the RGA2 with the driver in its current form on devices with more than 4
GB system memory may lead to memory corruption as buffer addresses are
silently truncated to 32 bits.

I'm not sure if that's actually a blocker for merging these patches.

Michael
