Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F076641F2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238543AbjAJNdF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 10 Jan 2023 08:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238440AbjAJNci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:32:38 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C7E48CD3;
        Tue, 10 Jan 2023 05:32:36 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pFEju-0004bs-9X; Tue, 10 Jan 2023 14:32:30 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>, Jagan Teki <jagan@edgeble.ai>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kever Yang <kever.yang@rock-chips.com>, kernel@collabora.com,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: Re: [PATCHv8 3/7] arm64: dts: rockchip: Add base DT for rk3588 SoC
Date:   Tue, 10 Jan 2023 14:32:29 +0100
Message-ID: <2076503.8hzESeGDPO@diego>
In-Reply-To: <20230110121754.2olqdzbe7wst3u4n@mercury.elektranox.org>
References: <20230109155801.51642-1-sebastian.reichel@collabora.com> <2865022.7s5MMGUR32@diego> <20230110121754.2olqdzbe7wst3u4n@mercury.elektranox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 10. Januar 2023, 13:17:54 CET schrieb Sebastian Reichel:
> Hi,
> 
> On Tue, Jan 10, 2023 at 12:47:23PM +0100, Heiko Stübner wrote:
> > Hi Sebastian,
> > 
> > Am Montag, 9. Januar 2023, 16:57:57 CET schrieb Sebastian Reichel:
> > > From: Kever Yang <kever.yang@rock-chips.com>
> > > 
> > > This initial version supports CPU, dma, interrupts, timers, UART and
> > > SDHCI (everything necessary to boot Linux on this system on chip) as
> > > well as Ethernet, I2C, PWM and SPI.
> > > 
> > > The DT is split into rk3588 and rk3588s, which is a reduced version
> > > (i.e. with less peripherals) of the former.
> > > 
> > > Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> > > Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> > > Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> > > Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> > > [rebase, squash and reword commit message]
> > 
> > I guess that means the list of Rockchip Signed-off-by lines above come
> > from the squashed patches?
> > 
> > If so, I guess I should add Co-Developed-by lines for them, as right now
> > the list is incorrect (author should be first, then everyone through
> > whose hands a patch went)
> > 
> > Meaning I can add those Co-Developed-by lines, so no need to resend,
> > I'm just verifying what I assume about the lines :-)
> 
> Yes, those are SoB lines from squashed downstream commits.

so I've made the block into 
Co-Developed-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
Co-Developed-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Co-Developed-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
[rebase, squash and reword commit message]
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

and will apply that if you don't shout in the next hour or so :-)

Thanks
Heiko


