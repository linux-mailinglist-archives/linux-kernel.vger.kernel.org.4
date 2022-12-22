Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6A6654664
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiLVTKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiLVTKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:10:06 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D654110B77;
        Thu, 22 Dec 2022 11:10:03 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1p8Qx6-0000O2-R1; Thu, 22 Dec 2022 20:10:00 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Yuteng Zhong <zonyitoo@gmail.com>, Rob Herring <robh@kernel.org>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, DHDAXCW <lasstp5011@gmail.com>
Subject: Re: [PATCH v3 1/2] arm64: dts: rockchip: Add RK3566 LubanCat 1
Date:   Thu, 22 Dec 2022 20:10:00 +0100
Message-ID: <2863440.ElGaqSPkdT@diego>
In-Reply-To: <20221222172504.GA1741501-robh@kernel.org>
References: <Y6Kc650FuvHFWxP0@VM-66-53-centos> <20221222172504.GA1741501-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Am Donnerstag, 22. Dezember 2022, 18:25:04 CET schrieb Rob Herring:
> On Wed, Dec 21, 2022 at 01:43:07PM +0800, Yuteng Zhong wrote:
> > LubanCat 1 is a Rockchip RK3566 SBC based
> > is developed by EmbedFire Electronics Co., Ltd.
> > Mini Linux Card Type Cheap Computer Development Board
> > It has the following characteristics:
> > - MicroSD card slot, onboard eMMC flash memory
> > - 1GbE Realtek RTL8211F Ethernet Transceiver
> > - 1 USB Type-C port (power and USB2.0 OTG)
> > - 1 USB 3.0 Host port
> > - 3 USB 2.0 Host ports
> > - 1 HDMI
> > - 1 infrared receiver
> > - 1 MIPI DSI
> > - 1 MIPI CSI
> > - 1 x 4-section headphone jack
> > - Mini PCIe socket (USB or PCIe)
> > - 1 SIM Card slot
> > - 1 SYS LED and 1 PWR LED
> > - 40-pin GPIO expansion header
> > 
> > Signed-off-by: Yuteng Zhong <zonyitoo@gmail.com>
> > Signed-off-by: DHDAXCW <lasstp5011@gmail.com>
> 
> DHDAXCW is a legal name?
> 
> The person sending the patch email should be last.

We're on v7 already [0] and at least the Authorship + separate binding
issue got fixed meanwhile - haven't looked at the whitespace issue there yet.


Heiko


[0] https://lore.kernel.org/all/Y6MlrbGKiIVc6tXt@VM-66-53-centos/

> > ---
> > 
> > Changed in V2:
> >   - Remove RNG node
> > Changed in V3:
> >   - Modify all node names
> > 
> > ---
> >  .../devicetree/bindings/arm/rockchip.yaml     |   5 +
> 
> Bindings should be separate patch.
> 
> >  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> >  .../boot/dts/rockchip/rk3566-lubancat-1.dts   | 600 ++++++++++++++++++
> 
> Fix all the whitespace errors checkpatch.pl complains about.
> 




