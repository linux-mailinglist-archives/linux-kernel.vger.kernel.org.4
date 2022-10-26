Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEAD60E531
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 18:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbiJZQD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 12:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbiJZQDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 12:03:16 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384603ED49;
        Wed, 26 Oct 2022 09:03:14 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id i21so21212038edj.10;
        Wed, 26 Oct 2022 09:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yYLspxKBLe6VOgufkSWikbMUpY/L7ohCSbY/unPCwSU=;
        b=U39hpm+etoqyCUadd+PboIdqMPjpz1pCz1s5CR5l1KR0eRpssb1QbAoo4Pnc6xtU30
         CU0D35x+5ojQ80FW4MZu1QqkJPKvBeocaMo5u6d7Q3vZQYXhQ5+K6fHsLoEFX+//uXGg
         EB4I0SkUg+2G1EcNvnijCHwD0mhhdCRVQPs2gimO6czUcidqFy0hujocpn1subnbF9S8
         90PklyR94o2cylYKbV0/11J3yEdKukafDaKpg2EzADUkXPYQlxL8K4y2NArnD7aay8jn
         DqpZONm+8GlZKIPZ2aJQjyRG+VJqso+fv6l4rdKYzV0sJrPuvldDq8slvgAZshwcxXDF
         SmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yYLspxKBLe6VOgufkSWikbMUpY/L7ohCSbY/unPCwSU=;
        b=P9xITNCIhoo+Q36H3ALZxZzRSI+UGEYPJpdWhL0PZfo0z9EkyKsD6gFSHXpe3777gx
         2gGy5rVgffaqby+m/Dua0Pa3cP6Qe98yUHfUd+MusEHkrQO+3thV+aKqkUjtaKQxgLIB
         mzJzW22wGN6aiddiqWNbc3OppjTy5YYDhzSb07q5T/iicyiTjtah6MYFwJHt2eAg+wo0
         qesMVUd7V4tQw8/oHHUv6yJk45jPkytqqUCDrbE7RTljmgqjEFUfzoOIL9wsnz0f5jqx
         QIOvNhEyLpWTcVI1fmpy3oxeHveXph6nfAa8MiTpN+eu/1fYwgvwF7H7O6iD9YsgH18Q
         lnNw==
X-Gm-Message-State: ACrzQf0AdkgRb6bguwybKXrN65QAud9IOofABlLox6uLyn1VFl0IpLff
        hIZMlAG+Qy6Kk2Dz/lv06Z1F5YXyCBH3jze/PCQ=
X-Google-Smtp-Source: AMsMyM6IyjfRRhU335+2dHq3/bo4scng930I2w0IbnNfgmeQ25McW+aDtO5PPBeun56aU3c2Fepx8Rs3KU2pQ9ZGm08=
X-Received: by 2002:a05:6402:4029:b0:45b:d50c:b9b0 with SMTP id
 d41-20020a056402402900b0045bd50cb9b0mr41419087eda.126.1666800193309; Wed, 26
 Oct 2022 09:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221022084737.1028-1-linux.amoon@gmail.com> <CAFBinCBu_-0m9JeAr5kd-v7Z5LTi7w0WmmUYybW_kL4KJXXpOQ@mail.gmail.com>
 <CANAwSgRzdD0FWg+z6hTFs7KvpsD64bChX-k0dPXJfACXZH2zbQ@mail.gmail.com>
 <CAFBinCCNJiL-ZKRYesQAwys6bBMpYHJbUDK-Zi_VhGDVSvF7uQ@mail.gmail.com>
 <CANAwSgTLTCA9=WvWXcR-40baauN3kAk2qx9k4FQOPCa1+_O0Yw@mail.gmail.com> <5d2ffeca-b41c-20b4-454b-703c39bbb29e@linaro.org>
In-Reply-To: <5d2ffeca-b41c-20b4-454b-703c39bbb29e@linaro.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 26 Oct 2022 21:32:56 +0530
Message-ID: <CANAwSgR1CN=Gho6NGMoM1bH92KyeGqoAphmT6NqtnL=+3Zg_jQ@mail.gmail.com>
Subject: Re: [PATCHv3] arm64: dts: meson: Enable active coling using gpio-fan
 on Odroid N2/N2+
To:     neil.armstrong@linaro.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Dan Johansen <strit@manjaro.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_HEX
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Wed, 26 Oct 2022 at 13:32, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Hi,
>
> On 25/10/2022 20:06, Anand Moon wrote:
> > Hi Martin,
> >
> > On Sat, 22 Oct 2022 at 17:22, Martin Blumenstingl
> > <martin.blumenstingl@googlemail.com> wrote:
> >>
> >> Hi Anand,
> >>
> >> On Sat, Oct 22, 2022 at 1:27 PM Anand Moon <linux.amoon@gmail.com> wrote:
> >> [...]
> >>>>> @@ -1982,7 +1982,6 @@ pwm_ao_d_10_pins: pwm-ao-d-10 {
> >>>>>                                                  mux {
> >>>>>                                                          groups = "pwm_ao_d_10";
> >>>>>                                                          function = "pwm_ao_d";
> >>>>> -                                                       bias-disable;
> >>>> &pwm_ao_d_10_pins is not referenced anywhere so it seems that this
> >>>> change has no impact on controlling the fan on Odroid-N2(+).
> >>>> How did you test this change?
> >>>>
> >>> Ok I felt these changes affect the behavior of the pinctrl
> >>>
> >>>    * @PIN_CONFIG_BIAS_DISABLE: disable any pin bias on the pin, a
> >>>   *  transition from say pull-up to pull-down implies that you disable
> >>>   *  pull-up in the process, this setting disables all biasing.
> >>>
> >>> I mapped this is linked in pinctrl driver, pwm_ao_d_10_pins GPIOAO_10 see below
> >> Yes, I understand this part.
> >> My concern is: &pwm_ao_d_10_pins settings only become active when this
> >> node is actively referenced. You can even see it in your output
> >> below...
> >>
> >> [...]
> >>> pin 10 (GPIOAO_10): (MUX UNCLAIMED) aobus-banks:1958
> >> This shows that it's used as a GPIO. If the &pwm_ao_d_10_pins setting
> >> was used then it would show "function pwm_ao_d group pwm_ao_d_10"
> >> (similar to what GPIOE_1 shows in your output)
> >>
> >> If you want to know if a pull-up/down is enabled you can look at the output of:
> >> $ cat /sys/kernel/debug/pinctrl/ff800000.sys-ctrl\:pinctrl@14-pinctrl-meson/pinconf-pins
> >> (I'm sure this can also be retrieved from some userspace tools, but I
> >> don't know how)
> >>
> >
> > I now switch using pwm-fan with the local changes I am able to link
> > pwm_ao_d_10_pins
> > but now the issue is fan keeps on spinning on boot-up and stays on.
> >
> > I can manually turn on off by using
> > $ sudo gpioset gpiochip1 10=1   // fan on
> > $ sudo gpioset gpiochip1 10=0   // fan off
>
> By doing that actually override the PWM function of the pin and set it as a GPIO.

Yes, I just want to test if this pin is working.
>
> >
> > It is not controlled by the thermal tip as expected.
> > I feel some configuration is missing in pwm-meson driver.
> > Any input for me?
> >
> > $ sudo cat /sys/kernel/debug/pinctrl/ff800000.sys-ctrl\:pinctrl@14-pinctrl-meson/pinmux-pins
> > [sudo] password for alarm:
> > Pinmux settings per pin
> > Format: pin (name): mux_owner gpio_owner hog?
> > pin 0 (GPIOAO_0): ff803000.serial (GPIO UNCLAIMED) function uart_ao_a
> > group uart_ao_a_tx
> > pin 1 (GPIOAO_1): ff803000.serial (GPIO UNCLAIMED) function uart_ao_a
> > group uart_ao_a_rx
> > pin 2 (GPIOAO_2): (MUX UNCLAIMED) aobus-banks:1950
> > pin 3 (GPIOAO_3): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> > pin 4 (GPIOAO_4): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> > pin 5 (GPIOAO_5): ff808000.ir (GPIO UNCLAIMED) function
> > remote_ao_input group remote_ao_input
> > pin 6 (GPIOAO_6): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> > pin 7 (GPIOAO_7): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> > pin 8 (GPIOAO_8): (MUX UNCLAIMED) aobus-banks:1956
> > pin 9 (GPIOAO_9): (MUX UNCLAIMED) aobus-banks:1957
> > pin 10 (GPIOAO_10): ff807000.pwm (GPIO UNCLAIMED) function pwm_ao_d
> > group pwm_ao_d_10
> > pin 11 (GPIOAO_11): (MUX UNCLAIMED) aobus-banks:1959
> > pin 12 (GPIOE_0): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> > pin 13 (GPIOE_1): ff802000.pwm (GPIO UNCLAIMED) function pwm_ao_d
> > group pwm_ao_d_e
> > pin 14 (GPIOE_2): ffd1b000.pwm (GPIO UNCLAIMED) function pwm_a_e group pwm_a_e
> >
> > $ sudo cat /sys/kernel/debug/pwm
> > platform/ffd1b000.pwm, 2 PWM devices
> >   pwm-0   (regulator-vddcpu-a  ): requested enabled period: 1250 ns
> > duty: 838 ns polarity: normal
> >   pwm-1   ((null)              ): period: 0 ns duty: 0 ns polarity: normal
> >
> > platform/ff807000.pwm, 2 PWM devices
> >   pwm-0   (pwm-fan             ): requested period: 1250 ns duty: 0 ns
> > polarity: normal
> >   pwm-1   ((null)              ): period: 0 ns duty: 0 ns polarity: normal
>
> This should be on the pwm-1, hence the "pwm_AO_cd" name, "c" and "d" and the
> names of the outputs.
>
> So you need to use 1 as first PWM phandle argument instead of 0.
>
> >
> > platform/ff802000.pwm, 2 PWM devices
> >   pwm-0   ((null)              ): period: 0 ns duty: 0 ns polarity: normal
> >   pwm-1   (regulator-vddcpu-b  ): requested enabled period: 1250 ns
> > duty: 1213 ns polarity: normal
> >
> > I could observe a change in duty when we have stress testing the CPU.
>
> Can you share the complete change you did here ?
>

When I try to use pwm_AO_cd,,
Either one of the PWM binds will fail to get the following error.

 &pwm_AO_cd {
-       pinctrl-0 = <&pwm_ao_d_e_pins>;
+       pinctrl-0 = <&pwm_ao_d_e_pins>, <&pwm_ao_d_10_pins>;
        pinctrl-names = "default";
        clocks = <&xtal>;
        clock-names = "clkin1";

[    3.941700] pwm-regulator regulator-vddcpu-b: error -EBUSY: Failed to get PWM
[    3.943198] pwm-regulator: probe of regulator-vddcpu-b failed with error -16

[    3.956356] pwm-fan pwm-fan: error -EBUSY: Could not get PWM
[    3.956396] pwm-fan: probe of pwm-fan failed with error -16

Below are my changes with  pwm_AO_ab
---------------------------------------------------------------------------------------------
alarm@odroid-n2:~/linux-amlogic-5.y-devel$ git diff
arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
index fd3fa82e4c33..d038ba1e2453 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
@@ -39,6 +39,14 @@ emmc_pwrseq: emmc-pwrseq {
                reset-gpios = <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
        };

+       fan: pwm-fan {
+               compatible = "pwm-fan";
+               pwms = <&pwm_AO_ab 1 1250 0>;
+               fan-supply = <&vcc_5v>;
+               #cooling-cells = <2>;
+               cooling-levels = <0 100 170 230>;
+       };
+
        leds {
                compatible = "gpio-leds";

@@ -410,6 +418,40 @@ &cpu103 {
        clock-latency = <50000>;
 };

+&cpu_thermal {
+       trips {
+               cpu_active: cpu-active {
+                       temperature = <55000>; /* millicelsius */
+                       hysteresis = <2000>; /* millicelsius */
+                       type = "active";
+               };
+       };
+
+       cooling-maps {
+               map {
+                       trip = <&cpu_active>;
+                       cooling-device = <&fan THERMAL_NO_LIMIT
THERMAL_NO_LIMIT>;
+               };
+       };
+};
+
+&ddr_thermal {
+       trips {
+               ddr_active: ddr-active {
+                       temperature = <55000>; /* millicelsius */
+                       hysteresis = <2000>; /* millicelsius */
+                       type = "active";
+               };
+       };
+
+       cooling-maps {
+               map {
+                       trip = <&ddr_active>;
+                       cooling-device = <&fan THERMAL_NO_LIMIT
THERMAL_NO_LIMIT>;
+               };
+       };
+};
+
 &ext_mdio {
        external_phy: ethernet-phy@0 {
                /* Realtek RTL8211F (0x001cc916) */
@@ -547,6 +589,14 @@ &pwm_ab {
        status = "okay";
 };

+&pwm_AO_ab {
+       pinctrl-0 = <&pwm_ao_d_10_pins>;
+       pinctrl-names = "default";
+       clocks = <&xtal>;
+       clock-names = "clkin1";
+       status = "okay";
+};
+
 &pwm_AO_cd {
        pinctrl-0 = <&pwm_ao_d_e_pins>;
        pinctrl-names = "default";
-------------------------------------------------------------------------------------------
> >
> > Thanks
> >
> > -Anand
>
> Neil
