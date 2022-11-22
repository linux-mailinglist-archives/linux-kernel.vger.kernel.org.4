Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91297633EBF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbiKVOVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiKVOVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:21:02 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E0F67F67;
        Tue, 22 Nov 2022 06:21:00 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1431386d5bbso1385083fac.10;
        Tue, 22 Nov 2022 06:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SHX+r3o3V3envxmtyDAC/DiXE+gGNoPNrnRmBhYS2YA=;
        b=bzw6WcmW4gcZyahHz4St8lxqfPCy255jxjxESN3SysXIr3ahVwGGwNgvtfmVtfQu7R
         aXQnNpnA2TakLL5r4M4WVful2l4efeMrOwp78QWfyudl/8uGxO8SYnBMgbgfotwY8z0+
         AFgGQF2Xquo/YRPkvjrb9TpOYk4wU0dCTdfXq90kTbT3Gw8fLYZ1j4OJFPWFjBBDlzSZ
         I5KMuxeGO/t3Ev3FtX4K2mXEigYm87FlxmOH1bcarcQmILnzDi5vIoRUrysVB/Zs97kG
         Yf18mV4B9rf/6V4SwPNTg6Lfsv0O5kH/VfLLy19giFCkv56y8GxrTr87y9DVbi4cEHvp
         3PAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SHX+r3o3V3envxmtyDAC/DiXE+gGNoPNrnRmBhYS2YA=;
        b=k0FLz1BusZEXiHKQq4qNVQ5tia5b6yhjr2J4pizsjGRG3SV0TpHMMx6EURE+TXzwmN
         QO4jf3L/mDaR7K3QCfl05CDBQ+NWH2kce6qyLoSAzZpmAQ4XH3KBjS0tZMFuiVaVA56r
         FOAvgt63yU4O8W5HqkK6YG/Nfn24BVD0lHdpkJFYSpaNoaOnNRLGMhwkNe/ttMKoUPpC
         dQbzowa7svvkYtgoqIelpMtUvcGgXSUm5vRMSr8xomuFTW01WkoAW0dZ09hYeL2zt+L0
         C3CKxtAlLGtLvT41ZaDCR+T1TEcxJb+TM9egIUkxqCgKiySW9LI9dmiNk6Z8UVHXwxm7
         Hrog==
X-Gm-Message-State: ANoB5pmQKiHEo64dE+ZlgCp6ReVjejRyShM8Ca/ABeKGoR/212hzR4gB
        9lsd9sZ3Tux5GI3JzifVLZZxFHWRtktPA9qG54s=
X-Google-Smtp-Source: AA0mqf46DIivwj4MjcutixW4t1k+fdnMvhiLdZIyjTe+CkRsiOunapEO2lBlDZ1ZUs6fVv4g65Fmd8S/IgGotj8Oq0o=
X-Received: by 2002:a05:6871:4407:b0:132:7fa0:41bb with SMTP id
 nd7-20020a056871440700b001327fa041bbmr12920126oab.260.1669126859346; Tue, 22
 Nov 2022 06:20:59 -0800 (PST)
MIME-Version: 1.0
References: <20221116200150.4657-1-linux.amoon@gmail.com> <20221116200150.4657-7-linux.amoon@gmail.com>
 <CAMdYzYo_DGiO0UxJEb3xues7Um=X9AgPvz+Xp_YWb9pp9HaScg@mail.gmail.com>
 <CANAwSgQJGH-+aXyUF18kGks4YKfBYvQ4-B7S2m8eaAr=yNS7vQ@mail.gmail.com>
 <99849c5e-5bd9-386b-99c5-fbc8c8df9656@arm.com> <CANAwSgT7rasp=QYdvukAO-y6NzsOfKsjdy0jAEubvMymmfDqWA@mail.gmail.com>
 <CAMdYzYqkHb0_Rwp+fAMwS=-VrNow6yFw1HErz28EGKd6bLzY4A@mail.gmail.com>
In-Reply-To: <CAMdYzYqkHb0_Rwp+fAMwS=-VrNow6yFw1HErz28EGKd6bLzY4A@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Tue, 22 Nov 2022 19:50:42 +0530
Message-ID: <CANAwSgR2h4tcuM2sNZt6QsporLuopkt2nCSHrbnTgT8r9iE3Cg@mail.gmail.com>
Subject: Re: [linux-next-v2 5/5] arm64: dts: rockchip: Add missing of
 ethernet-phy-id to reset the phy on Rock 3A SBC
To:     Peter Geis <pgwipeout@gmail.com>
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

Hi Peter,

On Fri, 18 Nov 2022 at 00:40, Peter Geis <pgwipeout@gmail.com> wrote:
>
> On Thu, Nov 17, 2022 at 9:56 AM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Hi Robin
> >
> > On Thu, 17 Nov 2022 at 16:24, Robin Murphy <robin.murphy@arm.com> wrote:
> > >
> > > On 2022-11-17 05:57, Anand Moon wrote:
> > > > Hi Peter,
> > > >
> > > > On Thu, 17 Nov 2022 at 02:16, Peter Geis <pgwipeout@gmail.com> wrote:
> > > >>
> > > >> On Wed, Nov 16, 2022 at 3:02 PM Anand Moon <linux.amoon@gmail.com> wrote:
> > > >>>
> > > >>> Add MDIO description with ethernet-phy-id compatible string
> > > >>> which enable calling reset of the phy. The PHY will then be probed,
> > > >>> independent of if it can be found on the bus or not,
> > > >>> and that probing will enable the GPIO.
> > > >>>
> > > >>> ethernet-phy-id is read from ethenet register dump reg2 and reg3.
> > > >>>
> > > >>> Fix following warning.
> > > >>> [   12.323417] rk_gmac-dwmac fe010000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
> > > >>> [   12.324078] rk_gmac-dwmac fe010000.ethernet eth0: no phy at addr -1
> > > >>> [   12.324099] rk_gmac-dwmac fe010000.ethernet eth0: __stmmac_open: Cannot attach to PHY (error: -19)
> > > >>>
> > > >>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > >>> ---
> > > >>> V2: new to the patch series.
> > > >>>
> > > >>> alarm@rock-3a:~$ sudo ethtool -d eth0
> > > >>> [sudo] password for alarm:
> > > >>> ST GMAC Registers
> > > >>> GMAC Registers
> > > >>> Reg0  0x08072203
> > > >>> Reg1  0x00000000
> > > >>> Reg2  0x00000404
> > > >>> Reg3  0x00000000
> > > >>> Reg4  0x00000002
> > > >>> ---
> > > >>>   arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 2 +-
> > > >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> > > >>>
> > > >>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> > > >>> index 9f84a23a8789..fe36156a5017 100644
> > > >>> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> > > >>> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> > > >>> @@ -585,7 +585,7 @@ &i2s2_2ch {
> > > >>>
> > > >>>   &mdio1 {
> > > >>>          rgmii_phy1: ethernet-phy@0 {
> > > >>> -               compatible = "ethernet-phy-ieee802.3-c22";
> > > >>> +               compatible = "ethernet-phy-id0000.0404", "ethernet-phy-ieee802.3-c22";
> > > >>>                  reg = <0x0>;
> > > >>>                  pinctrl-names = "default";
> > > >>>                  pinctrl-0 = <&eth_phy_rst>, <&eth_phy_int>;
> > > >>
> > > >> Have you tried instead moving the reset to the mdio bus? I've had
> > > >> success with this, though you'll need to change the reset assert and
> > > >> deassert timing handles, they are different for the bus.
> > > >>
> > > > No can you share some examples?
> > > > If you got a better way to solve this issue please let me know.
> > > > I will give this a try.
> > >
> > > Note that the Rock 3A schematic says the phy is configured for address
> > > 1, not 0. From what I remember of adding the MDIO node for NanoiPi4,
> > > that didn't work if I got the address wrong, despite the fact that the
> > > auto-detection when the MDIO node is omitted claimed to find the same
> > > phy on both addresses 0 and 1.
> > >
>
> From the net-dev folk, mdio address 0 is a broadcast address. All
> functional phys we have on the mdio bus should respond to it. The
> problem I've run into is with the reset on the phy node the reset
> triggers too late for the dwmac to detect the phy correctly. However
> moving it to the mdio bus node makes the reset happen at roughly the
> same time as the depreciated dwmac reset and the phy detects without
> any weird hacks.
>

This is not a hack, we are already using mdio bus node.
&gma1 {
   phy-handle=ethernet-phy
}
mdio1 {
   ethernet-phy {
   }
}

Actually, *ethernet-phy-id* is one of the binding properties (see below).
we can find many examples in the device tree that used this property in
the linux kernel and u-boot.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/net/ethernet-phy.yaml?h=v6.1-rc6#n31

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/net/ethernet-phy.yaml?h=v6.1-rc6#n211

Please check this phy reset section below.

[2] https://wiki.st.com/stm32mpu/wiki/Ethernet_device_tree_configuration#RMII_with_25MHz_on_ETH_CLK_-28no_PHY_Crystal-29-2C_REF_CLK_from_PHY_-28Reference_clock_-28standard_RMII_clock_name-29_is_provided_by_a_PHY-29

If you have some other input please share I have tried but failed.

Thanks

-Anand
