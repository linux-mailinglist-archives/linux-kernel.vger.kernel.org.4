Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E41C6563D0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 16:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbiLZPWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 10:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiLZPWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 10:22:14 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF71D8B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 07:22:13 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id c7so7365195pfc.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 07:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SCxtBabUysBaYhzIMRtIgAEFJNmq4iDUZJtVs/JoTbE=;
        b=DhWDpLv1Hzt+y0FCZQ2+Rgr70YABzLVXsndXhWVg2p3hdV6c+PRrm7YrYSYn+I7Ji+
         nxZYnl08C4/f9OFo2TCz//eLgqnBl12ziufp1pzrZmMerB/gXD7w7sgUiVS+u8tUfSHw
         TW/AhyX4UztskjTWy5anRRsc9NJ7bc5BGKhN6OmODdC/khqte7Fm+7F1zI7jsthLX1i4
         TbJ8A3npQqk/rmlmRAKUCE9sFoKAnvrk3Mvx+uRSOqpjy79w0eTUOIh/VFTKYW+GayRw
         I7KyqWey47Wrgk/r63l2waaKf4puDOej0ReRU4q04ni86Y3iCfkdbBDuKDudJcfABqKi
         c5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCxtBabUysBaYhzIMRtIgAEFJNmq4iDUZJtVs/JoTbE=;
        b=xnF7RV98QVsYkZxrfAohQwkCgKKd5kcSnGtLTfOaMZ0M+EVQ/SDC5Tno1QH5lvt0XQ
         F4y2AR2SokJ5LT0Y/lpxpHyT2yFbowROQEviiO1LvHvqMYzJXE9o0t9/WlZSmapRtqbV
         Vi1+iidRDbGTOtV2K4dgSoXYIFluFUn1P6Ax3XuNalYPHM7c3UuAVx3Ym6W088gAYkBO
         4RSQbX4oQxdJYgQqVryq15jABHcQ8UQwTZrvDDmarayJBUTI0V5deoaDz06G956Go/X5
         9XK520AVRWW6hjuGkfWLDPh6AAq/zjJT3X0bGJdEYVr5ZmhtCM0JCGz4VdutN7q785gE
         LsFg==
X-Gm-Message-State: AFqh2kr34OAqtEYoK4O/CfYlfvvQh9xiIFYcaK9kIkzdf6zy+3MFKIaC
        6Alq+12jXl4IRqdse7q0zLHYP+FW61jSW3CN9PRyNg==
X-Google-Smtp-Source: AMrXdXt88qdWKQ/Ho8+GODeFdumZGOGXPG+H+BznbpljV+Ae00tgM+RH5mlu0ydSTUL3laAUlBzWCR2rqeX531Ivo84=
X-Received: by 2002:a63:5646:0:b0:477:31bc:348f with SMTP id
 g6-20020a635646000000b0047731bc348fmr916709pgm.72.1672068133204; Mon, 26 Dec
 2022 07:22:13 -0800 (PST)
MIME-Version: 1.0
References: <20221226063625.1913-1-anand@edgeble.ai> <20221226063625.1913-4-anand@edgeble.ai>
 <d0eafc59-6718-f904-132a-1a6dbd083878@gmail.com>
In-Reply-To: <d0eafc59-6718-f904-132a-1a6dbd083878@gmail.com>
From:   Anand Moon <anand@edgeble.ai>
Date:   Mon, 26 Dec 2022 20:52:02 +0530
Message-ID: <CACF1qnecc1J2hzuPSNf8g8Wchy1c+nsGeBZ2yo79=0QjF93QcA@mail.gmail.com>
Subject: Re: [PATCHv2 linux-next 4/4] ARM: dts: rockchip: rv1126: Enable
 Ethernet for Neu2-IO
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Thanks for your review comments.

On Mon, 26 Dec 2022 at 18:16, Johan Jonker <jbx6244@gmail.com> wrote:
>
>
>
> On 12/26/22 07:36, Anand Moon wrote:
> > Rockchip RV1126 has GMAC 10/100/1000M ethernet controller.
> > Enable ethernet node on Neu2-IO board.
> >
> > Signed-off-by: Anand Moon <anand@edgeble.ai>
> > ---
> > drop SoB of Jagan Teki
> > ---
> >  arch/arm/boot/dts/rv1126-edgeble-neu2-io.dts | 37 ++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/rv1126-edgeble-neu2-io.dts b/arch/arm/boot/dts/rv1126-edgeble-neu2-io.dts
> > index dded0a12f0cd..bd592026eae6 100644
> > --- a/arch/arm/boot/dts/rv1126-edgeble-neu2-io.dts
> > +++ b/arch/arm/boot/dts/rv1126-edgeble-neu2-io.dts
> > @@ -22,6 +22,43 @@ chosen {
> >       };
> >  };
> >
> > +&gmac {
> > +     clock_in_out = "input";
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&rgmiim1_pins &clk_out_ethernetm1_pins>;
> > +     phy-mode = "rgmii";
> > +     phy-handle = <&phy>;
>
> > +     assigned-clocks = <&cru CLK_GMAC_SRC>, <&cru CLK_GMAC_TX_RX>,
> > +                     <&cru CLK_GMAC_ETHERNET_OUT>;
>
> align
>
Ok,
> > +     assigned-clock-parents = <&cru CLK_GMAC_SRC_M1>, <&cru RGMII_MODE_CLK>;
> > +     assigned-clock-rates = <125000000>, <0>, <25000000>;
> > +     phy-supply = <&vcc_3v3>;
> > +     tx_delay = <0x2a>;
> > +     rx_delay = <0x1a>;
> > +     status = "okay";
> > +};
> > +
> > +&mdio {
>
> > +     phy: phy@0 {
>
> use ethernet-phy
>
Ok,
> no '#phy-cells' here
>
> > +             compatible = "ethernet-phy-id001c.c916",
> > +                            "ethernet-phy-ieee802.3-c22";
>
> align
>
Ok,
> > +             reg = <0x0>;
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&eth_phy_rst>;
> > +             reset-assert-us = <20000>;
> > +             reset-deassert-us = <100000>;
> > +             reset-gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_LOW>;
> > +     };
> > +};
> > +
> > +&pinctrl {
>
> > +     ethernet {
>
> Maybe use a node name more in line with where it is used.
Ok,
>
> > +             eth_phy_rst: eth-phy-rst {
> > +                     rockchip,pins = <0 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>;
> > +             };
> > +     };
> > +};
> > +
> >  &sdmmc {
> >       bus-width = <4>;
> >       cap-mmc-highspeed;

Thanks
-Anand
