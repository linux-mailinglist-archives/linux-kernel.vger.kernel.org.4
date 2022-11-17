Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424E862DEC0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239647AbiKQO4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiKQO4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:56:09 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9056270A30;
        Thu, 17 Nov 2022 06:56:04 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ud5so5692712ejc.4;
        Thu, 17 Nov 2022 06:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IwcBeOeaR1x2IX2rcDUeXOgXDe6Ex8fSz1cnyCozQpY=;
        b=YSbLyyV7nMqaA8uzhE/7NUar5IU3ldPaqFTGYdhbhpi/i6JENFicWabNE82rh3YcvC
         /MsEW+riExmXumJl0F33+QZHopBnPiAnfChwq56W09Mqn5Ly7SEcblsrbFPQV7WuizAo
         QDaqrHBAKGYiHgCnBbzD2rDZyYN25iVBg4cajJ2MW/ZV95uNesh+LY+OzOvUvu2kgGxY
         dhxPoRPsODjcaaEW4z10TpmHrT9/l+KArlJaC8fWUReXOY9uNSkHWCB0cOpBgN+FEiaW
         HDk3K67YU7e/8zqqxhbljCrCKWLejAH5IrDRLMkEDs3bbU3YfCqF2u8RjG/bTh7wPJxj
         Odng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IwcBeOeaR1x2IX2rcDUeXOgXDe6Ex8fSz1cnyCozQpY=;
        b=s/3dZypUTeslpF53GMZA2LfydiIJ7QQeK3E35qbzJFrRvYym21LMDhn2Q5e+V+p34e
         TyKzcOh5WjgMSlpIUo5hYcHxctzgDs4if4uUVP/vBU+J1Kuv8hWYpNBsDS+TG9fjCTda
         8rtaDp1LHKayeKKf1q6zTKNN4UiaZiSwad5EMLjtSRk4rWuddcTLBBe2diPCVkr/SSgG
         UcloDaK2TYas7rxEDPMxzxLIPaL398bvPqygqNAhD/2KbeURWCSY2fZFP6F5F4Kq7Cza
         gDkXb4uEIrmrFRMwpmNPzJyk6EoQFYG7bVo1EsdouiwOwSNxk45GSvNALaXw/Qm3nLH+
         LjJg==
X-Gm-Message-State: ANoB5pk4Q5sMGFvK53RprIF3vUuoWGofXilCXBOurmQXMNPIW+dHjm3h
        A40dfdcQf4KXLjRCgYS+8bK7Nh7oi/K5ele45Qg=
X-Google-Smtp-Source: AA0mqf52mP6ZXbFpsqp7GEgOo5nw27q8XKx7vtmAVStFWouVwqYRa/fwXgtfW4+1KV5eCfJecGpJcMybBmTEHTaypHM=
X-Received: by 2002:a17:906:c18c:b0:7b2:8a6e:c569 with SMTP id
 g12-20020a170906c18c00b007b28a6ec569mr2464374ejz.582.1668696963090; Thu, 17
 Nov 2022 06:56:03 -0800 (PST)
MIME-Version: 1.0
References: <20221116200150.4657-1-linux.amoon@gmail.com> <20221116200150.4657-7-linux.amoon@gmail.com>
 <CAMdYzYo_DGiO0UxJEb3xues7Um=X9AgPvz+Xp_YWb9pp9HaScg@mail.gmail.com>
 <CANAwSgQJGH-+aXyUF18kGks4YKfBYvQ4-B7S2m8eaAr=yNS7vQ@mail.gmail.com> <99849c5e-5bd9-386b-99c5-fbc8c8df9656@arm.com>
In-Reply-To: <99849c5e-5bd9-386b-99c5-fbc8c8df9656@arm.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Thu, 17 Nov 2022 20:25:47 +0530
Message-ID: <CANAwSgT7rasp=QYdvukAO-y6NzsOfKsjdy0jAEubvMymmfDqWA@mail.gmail.com>
Subject: Re: [linux-next-v2 5/5] arm64: dts: rockchip: Add missing of
 ethernet-phy-id to reset the phy on Rock 3A SBC
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Peter Geis <pgwipeout@gmail.com>, Rob Herring <robh+dt@kernel.org>,
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

Hi Robin

On Thu, 17 Nov 2022 at 16:24, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-11-17 05:57, Anand Moon wrote:
> > Hi Peter,
> >
> > On Thu, 17 Nov 2022 at 02:16, Peter Geis <pgwipeout@gmail.com> wrote:
> >>
> >> On Wed, Nov 16, 2022 at 3:02 PM Anand Moon <linux.amoon@gmail.com> wrote:
> >>>
> >>> Add MDIO description with ethernet-phy-id compatible string
> >>> which enable calling reset of the phy. The PHY will then be probed,
> >>> independent of if it can be found on the bus or not,
> >>> and that probing will enable the GPIO.
> >>>
> >>> ethernet-phy-id is read from ethenet register dump reg2 and reg3.
> >>>
> >>> Fix following warning.
> >>> [   12.323417] rk_gmac-dwmac fe010000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
> >>> [   12.324078] rk_gmac-dwmac fe010000.ethernet eth0: no phy at addr -1
> >>> [   12.324099] rk_gmac-dwmac fe010000.ethernet eth0: __stmmac_open: Cannot attach to PHY (error: -19)
> >>>
> >>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> >>> ---
> >>> V2: new to the patch series.
> >>>
> >>> alarm@rock-3a:~$ sudo ethtool -d eth0
> >>> [sudo] password for alarm:
> >>> ST GMAC Registers
> >>> GMAC Registers
> >>> Reg0  0x08072203
> >>> Reg1  0x00000000
> >>> Reg2  0x00000404
> >>> Reg3  0x00000000
> >>> Reg4  0x00000002
> >>> ---
> >>>   arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> >>> index 9f84a23a8789..fe36156a5017 100644
> >>> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> >>> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> >>> @@ -585,7 +585,7 @@ &i2s2_2ch {
> >>>
> >>>   &mdio1 {
> >>>          rgmii_phy1: ethernet-phy@0 {
> >>> -               compatible = "ethernet-phy-ieee802.3-c22";
> >>> +               compatible = "ethernet-phy-id0000.0404", "ethernet-phy-ieee802.3-c22";
> >>>                  reg = <0x0>;
> >>>                  pinctrl-names = "default";
> >>>                  pinctrl-0 = <&eth_phy_rst>, <&eth_phy_int>;
> >>
> >> Have you tried instead moving the reset to the mdio bus? I've had
> >> success with this, though you'll need to change the reset assert and
> >> deassert timing handles, they are different for the bus.
> >>
> > No can you share some examples?
> > If you got a better way to solve this issue please let me know.
> > I will give this a try.
>
> Note that the Rock 3A schematic says the phy is configured for address
> 1, not 0. From what I remember of adding the MDIO node for NanoiPi4,
> that didn't work if I got the address wrong, despite the fact that the
> auto-detection when the MDIO node is omitted claimed to find the same
> phy on both addresses 0 and 1.
>

Yes, I have tested with these changes still this does not work, with
out this fix as of now..

We can check this comment in the below commit id
70f04e9a3358404367030493dc36718d4495a9a5  ARM: dts: imx6ul-14x14-evk:
Enable the GPIO expander

maybe something is still missing to be configured.

Thanks
-Anand





> Robin.
>
> >
> > Thanks
> > -Anand
> >>> --
> >>> 2.38.1
> >>>
> >
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
