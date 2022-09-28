Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244205EDB32
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbiI1LIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbiI1LHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:07:42 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436BBACA2A;
        Wed, 28 Sep 2022 04:04:59 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id m16so6431040ili.9;
        Wed, 28 Sep 2022 04:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=jwe/kOuCnsGDbPhUswVuxWf8gHbmYrH1aPx2on0iZ14=;
        b=iAxFZ0rhpixeBY4gv84nzxw+y5HblIgPyiWaG1nCGBCcIrBqiCmCt6gB7+CNovrh4T
         2EA710e3oTqe+zMo1xJtoKU3RC4UU43BbYhoyIUkF3Y+IMNmHwAw1rMhe0f+JMELJDWk
         X/vLJarwSoS1sAoDSrXc/WXpD3s5KvIAfB4xIfYTexwJ0Tse3a/6OdcolBu7GCzxW7xT
         iYtIswO8OkHt3UL1j1POLDw/vGUkwctmUe3XygXn/Wea95Zteufh+gKXbvzR90cZb/Ar
         QPEpft/jdfV4zzGGeivYYvge3eRlDNEKQ+I1IDDj1P1d/beNypzHJe+SFWieCZRv2PgH
         q/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=jwe/kOuCnsGDbPhUswVuxWf8gHbmYrH1aPx2on0iZ14=;
        b=xII7YSXkfaRFsVA530AC09vsDkleS/45tsRRr0v+K4MSNZOdXrEEjjIfE9TQfcfCUO
         0wc3ED5Fz1FKhcBisUcrOHgtXyuZSWwkCoPAdwJyQ9WFBQuzKP9B4IR3FwhuxOPVeWlF
         Vd9zPCelZdmEtnAReWEphXX+SIZ0IlHMjZ8sror4y8EiNgbRAme+dpF/UoIbiP5EUbxR
         8CF6vXxaZpEqgUD0lkK0C0SrWLxU3/cfxyrWIf49y1e0d+El6knI7GIIXvvkoTd22IHw
         Q6JdgqLfbsURa9craz9nrbdcmF33HgFif5CbdjLInHvblpdGgLOL2WgaDOIzfDAkUt/y
         J4dQ==
X-Gm-Message-State: ACrzQf0Jv7nw5/oZFxZuKXjNVBzq0siylAq24GRXrTme1lRf1qkpMw/l
        5lK0qpyAHVDWHyXu6Q38TsmKMMSpViAe6pCKeEnJH1PMPTc=
X-Google-Smtp-Source: AMsMyM4Gz2+5kp35fIp0/O/T05SuOIGpuqIhQaQMfxlfn5SU+fGpBCPRDRZaFXwRusB8s12f2zmpzgQFs29Q1vy0GZI=
X-Received: by 2002:a05:6e02:6c9:b0:2f6:40e0:ab8d with SMTP id
 p9-20020a056e0206c900b002f640e0ab8dmr14818762ils.259.1664363098717; Wed, 28
 Sep 2022 04:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <CANAwSgTyt2D-aEMMowO6d+0ddTQb46o0pWMahnr7ny2rjY7iaQ@mail.gmail.com>
 <20220927181531.5546-1-amadeus@jmu.edu.cn>
In-Reply-To: <20220927181531.5546-1-amadeus@jmu.edu.cn>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 28 Sep 2022 16:34:43 +0530
Message-ID: <CANAwSgSf=JZ_JiK1Gh5EYR30KQ5Yh-w3GsxzcFVweKHPi7KuLg@mail.gmail.com>
Subject: Re: [PATCH-next v1] arm64: dts: rockchip: Enable NVM Express PCIe
 controller on rock3a
To:     Chukun Pan <amadeus@jmu.edu.cn>
Cc:     heiko@sntech.de, robh+dt@kernel.org, michael.riesch@wolfvision.net,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
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

Hi Chukun,

On Tue, 27 Sept 2022 at 23:45, Chukun Pan <amadeus@jmu.edu.cn> wrote:
>
> Hi Anand,
>
> On 27-09-22, 19:16, Anand Moon wrote:
>
> > As per the schematic below pice support with 2 regulators
> >
> > VCC3V3_PCIE        (SCT2250FPA)
> > VCC3V3_PI6C_03  (PI6C557-03 is a spread spectrum clock generator
> > supporting PCI Express and Ethernet requirements)
>
> > [0] https://dl.radxa.com/rock3/docs/hw/3a/rock3a_v1.3_sch.pdf
>
> Thanks for sharing, I rewrote this patch, can you try again?
>

No, It's not working on my board.
I have to enable CONFIG_REGULATOR_DEBUG, See the logs below.

[ 0.784121] reg-fixed-voltage vcc3v3-pi6c-03-regulator: vcc3v3_pi6c03
supplying 3300000uV
[ 0.784430] vcc3v3_pcie: 3300 mV, disabled

[0] https://pastebin.com/aEKQx1YZ

> > No, it did not work on my board, see bool logs.
> > [0] https://pastebin.com/Lk93VFxg
>
If you check the driver code it requires *data-line* and *num-lanes
from the dts.

[ 0.725985] phy phy-fe8c0000.phy.4: lane number 0, val 1
[ 0.726975] phy phy-fe8c0000.phy.4: rockchip_p3phy_rk3568_init: lock
failed 0x6890000, check input refclk and power supply
[ 0.728172] phy phy-fe8c0000.phy.4: phy init failed --> -110
[ 0.728704] rockchip-dw-pcie: probe of 3c0800000.pcie failed with error -110

> From the boot log, looks like ethernet is broken:
>   mdio_bus stmmac-0: MDIO device at address 0 is missing.
>   rk_gmac-dwmac fe010000.ethernet eth0: no phy at addr -1
>
> Actually I had this problem too, and reusing the "snps, reset"
> property solved it. What confuses me is am I doing something
> wrong or there is something wrong with the device tree now?
>

Yep, I have the following changes that work to bring the Ethernet up.

alarm@rock-3a:~/linux-next-5.y-devel$ git diff
arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index 097cee13885d..498b9b2af3ed 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -242,6 +242,11 @@ &gmac1 {
        assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>;
        assigned-clock-rates = <0>, <125000000>;
        clock_in_out = "output";
+
+       snps,reset-gpio = <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
+       snps,reset-delays-us = <0 20000 100000>;
+       snps,reset-active-low;
+
        phy-handle = <&rgmii_phy1>;
        phy-mode = "rgmii-id";
        pinctrl-names = "default";
@@ -250,6 +255,8 @@ &gmac1m1_tx_bus2
                     &gmac1m1_rx_bus2
                     &gmac1m1_rgmii_clk
                     &gmac1m1_rgmii_bus>;
+       tx_delay = <0x30>;
+       rx_delay = <0x10>;
        status = "okay";
 };

@@ -559,14 +566,11 @@ &i2s1_8ch {
 };

 &mdio1 {
-       rgmii_phy1: ethernet-phy@0 {
+       rgmii_phy1: ethernet-phy@1 {
                compatible = "ethernet-phy-ieee802.3-c22";
-               reg = <0x0>;
+               reg = <0x1>;
                pinctrl-names = "default";
                pinctrl-0 = <&eth_phy_rst>;
-               reset-assert-us = <20000>;
-               reset-deassert-us = <100000>;
-               reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
        };
 };

Thanks
-Anand
