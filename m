Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47EC62E4FB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 20:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbiKQTKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 14:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiKQTKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 14:10:22 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D018D5F867;
        Thu, 17 Nov 2022 11:10:21 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v1so5391031wrt.11;
        Thu, 17 Nov 2022 11:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lWBIo8iR5Cc8cPnhhgtUS76Ot54p5OwTZpWMb1LSuCg=;
        b=cSr4gXfaufxdly8H76V6WOGOvIJkL8W0nBJq/pB+w9Ixt/OUQkTFHgJ5cy/VYbJ+4V
         MMAVHiNpI6OCX1vfq2OXaETtSi8lioQtbcwVhQIBQiKgbCXjSXjhrEeqgzMJc0CC2Ikj
         qeBWa6noTYFYtr15wkDWYZg683mqeqoEEpaK7bbeH0aqPdG/EF1r99iJdGdODR3iY1Hy
         3snv/VAbCsyTsqegQL5pji8TDem7kJuK7vEGUV7OQvcvZa/wTEk3cjZjb4SATz8LOE5H
         JKvvEfFiKjgzenGCif70zxxrZbaR3u4zU3+VkUwnRlQljX7NphEm6OZcxa6EfHEynXPZ
         mTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lWBIo8iR5Cc8cPnhhgtUS76Ot54p5OwTZpWMb1LSuCg=;
        b=2HnXNYZBOowHO20uQq79+XNgrNnrrhnq6NYTua0uTXk2EZRuW9FtUWCPfUNXT1M6nC
         6uXxbnpbL3qTNFXZuE0BI8UV//20jZ4z/nIdq1chxsskmfxvtamWjwbYwpbJ04acG+aH
         dUM/hkiCUTGOaZSZqIgHBiTz8XtSZQTPixK8gdsr7/2gkqCHOVKe5PXw5HNbUTacGNf1
         tK66zG4YBjqjDbbu5ZeRl6auQwO8GrTnbIT3uSRF4czjtvYtYpUNWMM0Gjx2I+0ywwFC
         ZbPFk31j2A2+rgyPzaZExrgyURfKrCfUiAlex/ZIEmtMNPOmAjPC64k2feelQldFHr3B
         bzmQ==
X-Gm-Message-State: ANoB5pmkaslgcRtPxvJCX8pLfLU5Z7j99/Al+yXD+okaSzL+3zJgghnv
        z5SFqbnWkmOwFTXjM7hGFaDGyeH8EqpT6vUP4IA=
X-Google-Smtp-Source: AA0mqf4gBw6YV/eqOk3zMGQQiB6pI0LiqMn28Aeza7cB+qVLtZD/sIkf0ixSE8k8q5Q4/ImNCcH3bsPlbTdF47haX6w=
X-Received: by 2002:adf:e405:0:b0:241:7f6f:da84 with SMTP id
 g5-20020adfe405000000b002417f6fda84mr2342433wrm.282.1668712220057; Thu, 17
 Nov 2022 11:10:20 -0800 (PST)
MIME-Version: 1.0
References: <20221116200150.4657-1-linux.amoon@gmail.com> <20221116200150.4657-7-linux.amoon@gmail.com>
 <CAMdYzYo_DGiO0UxJEb3xues7Um=X9AgPvz+Xp_YWb9pp9HaScg@mail.gmail.com>
 <CANAwSgQJGH-+aXyUF18kGks4YKfBYvQ4-B7S2m8eaAr=yNS7vQ@mail.gmail.com>
 <99849c5e-5bd9-386b-99c5-fbc8c8df9656@arm.com> <CANAwSgT7rasp=QYdvukAO-y6NzsOfKsjdy0jAEubvMymmfDqWA@mail.gmail.com>
In-Reply-To: <CANAwSgT7rasp=QYdvukAO-y6NzsOfKsjdy0jAEubvMymmfDqWA@mail.gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Thu, 17 Nov 2022 14:10:07 -0500
Message-ID: <CAMdYzYqkHb0_Rwp+fAMwS=-VrNow6yFw1HErz28EGKd6bLzY4A@mail.gmail.com>
Subject: Re: [linux-next-v2 5/5] arm64: dts: rockchip: Add missing of
 ethernet-phy-id to reset the phy on Rock 3A SBC
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Chukun Pan <amadeus@jmu.edu.cn>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 9:56 AM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Robin
>
> On Thu, 17 Nov 2022 at 16:24, Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 2022-11-17 05:57, Anand Moon wrote:
> > > Hi Peter,
> > >
> > > On Thu, 17 Nov 2022 at 02:16, Peter Geis <pgwipeout@gmail.com> wrote:
> > >>
> > >> On Wed, Nov 16, 2022 at 3:02 PM Anand Moon <linux.amoon@gmail.com> wrote:
> > >>>
> > >>> Add MDIO description with ethernet-phy-id compatible string
> > >>> which enable calling reset of the phy. The PHY will then be probed,
> > >>> independent of if it can be found on the bus or not,
> > >>> and that probing will enable the GPIO.
> > >>>
> > >>> ethernet-phy-id is read from ethenet register dump reg2 and reg3.
> > >>>
> > >>> Fix following warning.
> > >>> [   12.323417] rk_gmac-dwmac fe010000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
> > >>> [   12.324078] rk_gmac-dwmac fe010000.ethernet eth0: no phy at addr -1
> > >>> [   12.324099] rk_gmac-dwmac fe010000.ethernet eth0: __stmmac_open: Cannot attach to PHY (error: -19)
> > >>>
> > >>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > >>> ---
> > >>> V2: new to the patch series.
> > >>>
> > >>> alarm@rock-3a:~$ sudo ethtool -d eth0
> > >>> [sudo] password for alarm:
> > >>> ST GMAC Registers
> > >>> GMAC Registers
> > >>> Reg0  0x08072203
> > >>> Reg1  0x00000000
> > >>> Reg2  0x00000404
> > >>> Reg3  0x00000000
> > >>> Reg4  0x00000002
> > >>> ---
> > >>>   arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 2 +-
> > >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> > >>> index 9f84a23a8789..fe36156a5017 100644
> > >>> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> > >>> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> > >>> @@ -585,7 +585,7 @@ &i2s2_2ch {
> > >>>
> > >>>   &mdio1 {
> > >>>          rgmii_phy1: ethernet-phy@0 {
> > >>> -               compatible = "ethernet-phy-ieee802.3-c22";
> > >>> +               compatible = "ethernet-phy-id0000.0404", "ethernet-phy-ieee802.3-c22";
> > >>>                  reg = <0x0>;
> > >>>                  pinctrl-names = "default";
> > >>>                  pinctrl-0 = <&eth_phy_rst>, <&eth_phy_int>;
> > >>
> > >> Have you tried instead moving the reset to the mdio bus? I've had
> > >> success with this, though you'll need to change the reset assert and
> > >> deassert timing handles, they are different for the bus.
> > >>
> > > No can you share some examples?
> > > If you got a better way to solve this issue please let me know.
> > > I will give this a try.
> >
> > Note that the Rock 3A schematic says the phy is configured for address
> > 1, not 0. From what I remember of adding the MDIO node for NanoiPi4,
> > that didn't work if I got the address wrong, despite the fact that the
> > auto-detection when the MDIO node is omitted claimed to find the same
> > phy on both addresses 0 and 1.
> >

From the net-dev folk, mdio address 0 is a broadcast address. All
functional phys we have on the mdio bus should respond to it. The
problem I've run into is with the reset on the phy node the reset
triggers too late for the dwmac to detect the phy correctly. However
moving it to the mdio bus node makes the reset happen at roughly the
same time as the depreciated dwmac reset and the phy detects without
any weird hacks.

>
> Yes, I have tested with these changes still this does not work, with
> out this fix as of now..
>
> We can check this comment in the below commit id
> 70f04e9a3358404367030493dc36718d4495a9a5  ARM: dts: imx6ul-14x14-evk:
> Enable the GPIO expander
>
> maybe something is still missing to be configured.
>
> Thanks
> -Anand
>
>
>
>
>
> > Robin.
> >
> > >
> > > Thanks
> > > -Anand
> > >>> --
> > >>> 2.38.1
> > >>>
> > >
> > > _______________________________________________
> > > Linux-rockchip mailing list
> > > Linux-rockchip@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-rockchip
