Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147C9636087
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237589AbiKWNxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236344AbiKWNxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:53:14 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896BCB7F8;
        Wed, 23 Nov 2022 05:47:37 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oxq5x-0008Ig-KZ; Wed, 23 Nov 2022 14:47:21 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Michael Riesch <michael.riesch@wolfvision.net>,
        Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chukun Pan <amadeus@jmu.edu.cn>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-next-v2 2/5] arm64: dts: rockchip: Add support of external clock to ethernet node on Rock 3A SBC
Date:   Wed, 23 Nov 2022 14:47:20 +0100
Message-ID: <14662283.uLZWGnKmhe@phil>
In-Reply-To: <CANAwSgTbTziSY-5=V3_WJG9-SaTY4R0JM4hkohLFE-q1bERcdg@mail.gmail.com>
References: <20221116200150.4657-1-linux.amoon@gmail.com> <3e4e601b-e7f8-e9df-0ec5-4f4b629d9c0c@wolfvision.net> <CANAwSgTbTziSY-5=V3_WJG9-SaTY4R0JM4hkohLFE-q1bERcdg@mail.gmail.com>
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

Hi,

Am Mittwoch, 23. November 2022, 14:00:50 CET schrieb Anand Moon:
> Hi Michael, Heiko
> 
> On Tue, 22 Nov 2022 at 16:48, Michael Riesch
> <michael.riesch@wolfvision.net> wrote:
> >
> > Hi Anand,
> >
> > On 11/16/22 21:01, Anand Moon wrote:
> > > Add support of external clock gmac1_clkin which is used as input clock
> > > to ethernet node.
> >
> > Indeed this operating mode is defined in the schematics, thanks for the fix.
> >
> > >
> > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> >
> > Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
> > Tested-by: Michael Riesch <michael.riesch@wolfvision.net>
> >
> 
> Actually, I wanted to drop these changes since looking into clk_summary
> gmac1 CLK gets wrongly configured with PLL and the reference count is
> not correct.
> 
> Plz do the patches, I will send the correct changes next version.

as you might've seen, I've applied this patch yesterday.

When doing patches also please always take into account, that devicetree
describes the hardware situation, not what the Linux-kernel does.

But assigned-clock* fixups in a next version are ok to do.

Thanks
Heiko


