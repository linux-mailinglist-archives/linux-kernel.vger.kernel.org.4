Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A075628B9F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237662AbiKNVyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbiKNVyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:54:14 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BAEE089;
        Mon, 14 Nov 2022 13:54:13 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id v8so4276908uap.12;
        Mon, 14 Nov 2022 13:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v+blShwVzVn2ShDVrtqz1stWlM2XFhwIpWM5biYTUq8=;
        b=MYKEo8YFBIQYr1WtSl7TXE9Q2jF4hIFgSZ1Eb3ha7p0oVKPS0JCk+feFpLdaWfSPWj
         W0ANvk5V9+DZGgztA4m1n9+8AGjdq21I4cHxCSrCNEtetNs9e//bnBPYZH/te6kQH4LZ
         rKFGfiWC7u8aaJSCfkfIxRaDmp6eH7XJZ8RITcX2R4NWf4cOUPfqCQG15O/AHM4wBwIz
         MYfSeTnUFDAUhXrT2LZkvDF/3g7cIR6wBsg7NWY5zY5881aePqHmgnJcHPXX5guZh8dS
         GPJU1/MihZtQZluCmnEEYEXwnFxJeN2X1vTentMHHxLH+WuaT6DQ4mLTFg29LK5bUHeZ
         zQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+blShwVzVn2ShDVrtqz1stWlM2XFhwIpWM5biYTUq8=;
        b=t0wNrgDYpPJsLpqq+O0M7IAh+FZbzGbz65hYLPgkZ56xSx31chCnk0QWQ8HQWatyBV
         acH1g6CQGEjeHSnX8w5DeHvuF4wrznX+rsMbNFp7XTqwfM9ogytwMX53XNFWcOXNcZYN
         OyQeJ2ZIrG9rExOIlXbOT3xXyTn6Czemz3GawXrZ91XafK9DiW+DuuWNp0qrhtg1d+UH
         trl6cRibN7JawREqMJdHgSWmR4J4NiGgWVfBeSB/zPXNUtptJ89oAs4wOmQIfIyLPs8U
         qDM25N4jAUFeMMpZDRMc4NNbYkF6ouQlWExy6VELpHaD4py0ib7B//GkSwreCO+Obk/d
         UkIA==
X-Gm-Message-State: ANoB5pkMSmaLSEF13qyJle2zYItvmYyhaJsNOn8AO/f/qWoWRmmTdZUG
        B/VZ/CCHe+87IaUbxgQi7CmS9bVY0zXKhDt0ubA=
X-Google-Smtp-Source: AA0mqf4LjH2sk4MuaRBt6ypZQWs5afjoGfErlCG086KjswrlCzzSdD/OhVpFc1Fp9+9aMfOIb1+LohIGL77vmgspU4Y=
X-Received: by 2002:ab0:2411:0:b0:3dc:3d19:584 with SMTP id
 f17-20020ab02411000000b003dc3d190584mr7568106uan.122.1668462852176; Mon, 14
 Nov 2022 13:54:12 -0800 (PST)
MIME-Version: 1.0
References: <20221031200114.987024-1-robertcnelson@gmail.com>
 <20221031200114.987024-2-robertcnelson@gmail.com> <ce9291a0-e138-f0ec-9604-83abd93e72c3@ti.com>
In-Reply-To: <ce9291a0-e138-f0ec-9604-83abd93e72c3@ti.com>
From:   Robert Nelson <robertcnelson@gmail.com>
Date:   Mon, 14 Nov 2022 15:53:46 -0600
Message-ID: <CAOCHtYi-aBwxY3Hivgj+uW71E3XT6q6j0=SfWg+EfJOqQB3_SA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: ti: add k3-j721e-beagleboneai64
To:     Andrew Davis <afd@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>
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

Thanks Andrew, sorry for the delay!

On Wed, Nov 2, 2022 at 11:16 AM Andrew Davis <afd@ti.com> wrote:
>
> On 10/31/22 3:01 PM, Robert Nelson wrote:
> > BeagleBoard.org BeagleBone AI-64 is an open source hardware single
> > board computer based on the Texas Instruments TDA4VM SoC featuring
> > dual-core 2.0GHz Arm Cortex-A72 processor, C7x+MMA and 2 C66x
> > floating-point VLIW DSPs, 3x dual Arm Cortex-R5 co-processors,
> > 2x 6-core Programmable Real-Time Unit and Industrial Communication
> > SubSystem, PowerVR Rogue 8XE GE8430 3D GPU. The board features 4GB
> > DDR4, USB3.0 Type-C, 2x USB SS Type-A, miniDisplayPort, 2x 4-lane
> > CSI, DSI, 16GB eMMC flash, 1G Ethernet, M.2 E-key for WiFi/BT, and
> > BeagleBone expansion headers.
> >
> > This board family can be indentified by the BBONEAI-64-B0 in the
> > at24 eeprom:
> >
> > [aa 55 33 ee 01 37 00 10  2e 00 42 42 4f 4e 45 41 |.U3..7....BBONEA|]
> > [49 2d 36 34 2d 42 30 2d  00 00 42 30 30 30 37 38 |I-64-B0-..B00078|]
> >
> > https://beagleboard.org/ai-64
> > https://git.beagleboard.org/beagleboard/beaglebone-ai-64

> > +
> > +     reserved_memory: reserved-memory {
> > +             #address-cells = <2>;
> > +             #size-cells = <2>;
> > +             ranges;
> > +
> > +             secure_ddr: optee@9e800000 {
> > +                     reg = <0x00 0x9e800000 0x00 0x01800000>;
> > +                     alignment = <0x1000>;
>
> "alignment" property should not be needed here since you cannot
> allocate from this region anyway.

I removed alignment, wondering if these all should be eventually moved
into the common file, with custom applications just updating the
offset's.

> > +
> > +     gpio_keys: gpio-keys {
> > +             compatible = "gpio-keys";
> > +             autorepeat;
>
> Do you need "autorepeat" on these?
>

Removed, no idea where that came from...

> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&sw_pwr_pins_default>;
> > +
> > +             sw_boot: switch-1 {
>
> I don't see anyone referencing these nodes, the "sw_boot" shouldn't be needed.
>
> > +                     label = "BOOT";
> > +                     linux,code = <BTN_0>;
> > +                     gpios = <&wkup_gpio0 0 GPIO_ACTIVE_LOW>;
> > +             };
> > +
> > +             sw_pwr: switch-2 {
>
> NIT (no need to actually change this),
> Would "button"-1/2 be better here, I see on the silkscreen has them as "sw"
> but most would call these buttons if they saw them.

I do like the 'button' label much better, nothing uses these, so i
removed the label name.

>
> > +                     label = "POWER";
> > +                     linux,code = <KEY_POWER>;
> > +                     gpios = <&wkup_gpio0 4 GPIO_ACTIVE_LOW>;
> > +             };
> > +     };
>
> [...]
>
> > +
> > +&main_sdhci2 {
> > +     /* Unused */
> > +     status = "disabled";
> > +};
> > +
>
> For J7x I did not "disable by default" several classes of device
> like this one, since the default pinmux may allow their function.
> Once that is sorted out I'll fix up this DT here and in the spots
> below for you.
>
> BTW, thanks for taking the time to rebase on my series for the
> devices I did disable. Hope that didn't cause too much churn
> on your side :)

I love it!  I prefer everything disabled, and just enable what nodes we need.

> > +
> > +&main_r5fss0_core0 {
> > +     firmware-name = "pdk-ipc/ipc_echo_test_mcu2_0_release_strip.xer5f";
> > +};
> > +
>
> What is this crazy firmware name? These are not in linux-firmware, might
> be better to leave these out until we get these names sorted out and
> upstreamed. (yes I know the same snuck into k3-j721e-sk.dtb but
> it probably isn't correct there either).

Yeap, direct copy from k3-j721e-sk, I'll remove it till we get
everything sorted out..

>
> > +
> > +&mcu_cpsw {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&mcu_cpsw_pins_default &mcu_mdio_pins_default>;
>
> mcu_mdio_pins_default should belong to the MDIO node below.
>
> > +};
> > +
> > +&davinci_mdio {
>
>
> Right here.
>
> pinctrl-names = "default";
> pinctrl-0 = <&mcu_mdio_pins_default>;

and moved!


> Everything else looks sane enough to me,
>
> Reviewed-by: Andrew Davis <afd@ti.com>

Thanks!

-- 
Robert Nelson
https://rcn-ee.com/
