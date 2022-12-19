Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273FC6508F1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 09:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbiLSI4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 03:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiLSI4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 03:56:37 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF4E2DD9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 00:56:35 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id b13so12676489lfo.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 00:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=amPo+fnApdePjcUPTe8sTsF7f8Gv1yF5OBc/uAvzyaM=;
        b=rQUuXEIMgq9bskQ/tOwvfOi1ETafyU4H/r6h2NHKoKTRlYQyfSz9nxRZ4WBnhwU9bZ
         zDVre4iX79vYIjbzU1xt9nloOoVZnUyveobylKki2QtrvCaS3LHB1+/g+B4SadyREyoG
         0KPrktFcrfVZpoQbs4Fx1VLYU5WuSJujZi3ivL//HUjLH763oRRXMAjSiCrTLTaX2wp5
         n3PTXyZoHUj5yZh/uRWpjLGEsXMYIpzi8I7wKXqE2r6ZWjmwAZ0DirxsK2vM7vKPASL8
         SKZKH09X0Z5FGLqqZ4Frt4YDA0twKOOdsYnd/Gi224sOsE5/oNvSokBvsB2EUpxvNv6s
         AaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=amPo+fnApdePjcUPTe8sTsF7f8Gv1yF5OBc/uAvzyaM=;
        b=4TtZ2dTbbCU7zpOzdvSZomes5d24I0u3FphcUgZjPG2L9PalRlvSDrLEweyjXkfQSq
         RCEJtjTi+mt65G2+mcifmxAtx4FJZ6Qz1OeYCqsvISXSu4KB8eegga/QP4WC8Gt3IDrc
         ASVTIzH0W569fY+GOKCXt+sk711NJf3fW5TjqGuJzzXqN8YiLk+Lm/ZNDAjd+cJI048n
         kYoTJnRsIILn/A6xd0og4L6eVdEZ/SNB6Zspu2P1DuqJ+HDx3wG68cn5iI5dhvWANxvU
         8JG9YRW1Pv94x3VPjwaumcn3fyOaD9l5+4pjHnWu7R7IQ5kPwmhHaEAIIoP9pM+3Zk23
         CvYw==
X-Gm-Message-State: AFqh2kqkseFHMQOJttQMc2vmCYZ+4qOX5Dm7E/c77ElRKgOHe/fsAoBe
        uXvv+UjooslD6OvfBcMLLZV+Fw==
X-Google-Smtp-Source: AMrXdXvegjhzr3DSgpilRdobL68KHx8NSc3HtxYcxPcIxWbFDsT14kUVvxv81Tztp+v8nZ1Gy9RhwA==
X-Received: by 2002:a05:6512:2288:b0:4bb:d287:1147 with SMTP id f8-20020a056512228800b004bbd2871147mr7075510lfu.15.1671440194161;
        Mon, 19 Dec 2022 00:56:34 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 8-20020ac25f48000000b004b590c768edsm1053055lfz.1.2022.12.19.00.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 00:56:33 -0800 (PST)
Message-ID: <fe605f23-b098-6279-23e7-8ceb2768f87b@linaro.org>
Date:   Mon, 19 Dec 2022 09:56:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH V2 2/2] arm64: dts: imx: Introduce imx8mp-beacon-kit
Content-Language: en-US
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221217234340.819752-1-aford173@gmail.com>
 <20221217234340.819752-2-aford173@gmail.com>
 <c5b8c9d1-6391-fb76-c380-6f0fdb3cc878@linaro.org>
 <CAHCN7xKHE-9VAysC4VLQNfT8c9j6AMZQFRsH+M2xE6-DSfbF7Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAHCN7xKHE-9VAysC4VLQNfT8c9j6AMZQFRsH+M2xE6-DSfbF7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/2022 20:00, Adam Ford wrote:
> On Sun, Dec 18, 2022 at 12:42 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 18/12/2022 00:43, Adam Ford wrote:
>>> Beacon Embedded has an i.MX8M Plus development kit which consists
>>> of a SOM + baseboard.  The SOM includes Bluetooth, WiFi, QSPI, eMMC,
>>> and one Ethernet PHY. The baseboard includes audio, HDMI, USB-C Dual
>>> Role port, USB Hub with five ports, a PCIe slot, and a second Ethernet
>>> PHY.
>>>
>>> Signed-off-by: Adam Ford <aford173@gmail.com>
>>> ---
>>> V2:  Fix whitespace, remove dead nodes, and fix some node and
>>> parameter names to address errors in 'make dt_binding_check'
>>
>> You still cannot check/test/build this DTS without Makefile.
> 
> The lack of makefile was an honest mistake as I forgot to add it to my
> patch.  I ran the make dt_binding_check and addressed many of the
> errors, but some of them are not unique to my board, because they were
> errors in the imx8mp.dtsi file. I addressed some of them by sending
> patches to fix some types in imx8mp.dtsi.  I will make sure V3 has the
> makefile updated.
> 
>>
>>>
>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
>>> new file mode 100644
>>> index 000000000000..70399f2419cf
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
>>> @@ -0,0 +1,549 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +/*
>>> + * Copyright 2022 Logic PD, Inc dba Beacon EmbeddedWorks
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include <dt-bindings/usb/pd.h>
>>> +#include <dt-bindings/phy/phy-imx8-pcie.h>
>>> +#include "imx8mp.dtsi"
>>> +#include "imx8mp-beacon-som.dtsi"
>>> +
>>> +/ {
>>> +     model = "Beacon EmbeddedWorks i.MX8MPlus Development kit";
>>> +     compatible = "beacon,imx8mp-beacon-kit", "fsl,imx8mp";
>>> +
>>> +     aliases {
>>> +             ethernet0 = &eqos;
>>> +             ethernet1 = &fec;
>>> +     };
>>> +
>>> +     chosen {
>>> +             stdout-path = &uart2;
>>> +     };
>>> +
>>> +     connector-1 {
>>> +             compatible = "usb-c-connector";
>>> +             label = "USB-C";
>>> +             data-role = "dual";
>>> +
>>> +             ports {
>>> +                     #address-cells = <1>;
>>> +                     #size-cells = <0>;
>>> +                     port@0 {
>>> +                             reg = <0>;
>>> +                             hs_ep: endpoint {
>>> +                                     remote-endpoint = <&usb3_hs_ep>;
>>> +                             };
>>> +                     };
>>> +                     port@1 {
>>> +                             reg = <1>;
>>> +                             ss_ep: endpoint {
>>> +                                     remote-endpoint = <&hd3ss3220_in_ep>;
>>> +                             };
>>> +                     };
>>> +             };
>>> +     };
>>> +
>>> +     gpio-keys {
>>> +             compatible = "gpio-keys";
>>> +             autorepeat;
>>> +
>>> +             button-0 {
>>> +                     label = "btn0";
>>> +                     linux,code = <BTN_0>;
>>> +                     gpios = <&pca6416_1 12 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
>>> +                     wakeup-source;
>>> +             };
>>> +
>>> +             button-1 {
>>> +                     label = "btn1";
>>> +                     linux,code = <BTN_1>;
>>> +                     gpios = <&pca6416_1 13 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
>>> +                     wakeup-source;
>>> +             };
>>> +
>>> +             button-2 {
>>> +                     label = "btn2";
>>> +                     linux,code = <BTN_2>;
>>> +                     gpios = <&pca6416_1 14 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
>>> +                     wakeup-source;
>>> +             };
>>> +
>>> +             button-3 {
>>> +                     label = "btn3";
>>> +                     linux,code = <BTN_3>;
>>> +                     gpios = <&pca6416_1 15 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
>>> +                     wakeup-source;
>>> +             };
>>> +     };
>>> +
>>> +     leds {
>>> +             compatible = "gpio-leds";
>>> +
>>> +             led0 {
>>
>> No improvements here.
> I forgot the git commit --amend so my patch was missing the changes,
> but my machine has the fix.  Sorry about that.
> 
>>
>>> +                     label = "gen_led0";
>>> +                     gpios = <&pca6416_1 4 GPIO_ACTIVE_HIGH>;
>>> +                     default-state = "off";
>>> +             };
>>> +
>>> +             led1 {
>>> +                     label = "gen_led1";
>>> +                     gpios = <&pca6416_1 5 GPIO_ACTIVE_HIGH>;
>>> +                     default-state = "off";
>>> +             };
>>> +
>>> +             led2 {
>>> +                     label = "gen_led2";
>>> +                     gpios = <&pca6416_1 6 GPIO_ACTIVE_HIGH>;
>>> +                     default-state = "off";
>>> +             };
>>> +
>>> +             led3 {
>>> +                     pinctrl-names = "default";
>>> +                     pinctrl-0 = <&pinctrl_led3>;
>>> +                     label = "heartbeat";
>>> +                     gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;
>>> +                     linux,default-trigger = "heartbeat";
>>> +             };
>>> +     };
>>> +
>>> +     pcie0_refclk: pcie0-refclk {
>>> +             compatible = "fixed-clock";
>>> +             #clock-cells = <0>;
>>> +             clock-frequency = <100000000>;
>>> +     };
>>> +
>>> +     reg_usdhc2_vmmc: regulator-usdhc2 {
>>> +             compatible = "regulator-fixed";
>>> +             regulator-name = "VSD_3V3";
>>> +             regulator-min-microvolt = <3300000>;
>>> +             regulator-max-microvolt = <3300000>;
>>> +             gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
>>> +             enable-active-high;
>>> +             startup-delay-us = <100>;
>>> +             off-on-delay-us = <20000>;
>>> +     };
>>> +
>>> +     reg_usb1_host_vbus: regulator-usb1-vbus {
>>> +             compatible = "regulator-fixed";
>>> +             regulator-name = "usb1_host_vbus";
>>> +             regulator-max-microvolt = <5000000>;
>>> +             regulator-min-microvolt = <5000000>;
>>> +             gpio = <&pca6416_1 0 GPIO_ACTIVE_HIGH>;
>>> +             enable-active-high;
>>> +     };
>>> +};
>>> +
>>> +&ecspi2 {
>>> +     pinctrl-names = "default";
>>> +     pinctrl-0 = <&pinctrl_ecspi2>;
>>> +     cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
>>> +     status = "okay";
>>> +
>>> +     tpm: tpm@0 {
>>> +             pinctrl-names = "default";
>>> +             pinctrl-0 = <&pinctrl_tpm>;
>>> +             compatible = "infineon,slb9670";
>>> +             reg = <0>;
>>> +             reset-gpios = <&gpio4 0 GPIO_ACTIVE_LOW>;
>>> +             spi-max-frequency = <18500000>;
>>> +     };
>>> +};
>>> +
>>> +&fec {
>>> +     pinctrl-names = "default";
>>> +     pinctrl-0 = <&pinctrl_fec>;
>>> +     phy-mode = "rgmii-id";
>>> +     phy-handle = <&ethphy1>;
>>> +     phy-reset-gpios = <&gpio4 18 GPIO_ACTIVE_LOW>;
>>> +     phy-reset-post-delay = <150>;
>>> +     phy-reset-duration = <10>;
>>> +     fsl,magic-packet;
>>> +     status = "okay";
>>> +
>>> +     mdio {
>>> +             #address-cells = <1>;
>>> +             #size-cells = <0>;
>>> +
>>> +             ethphy1: ethernet1-phy@3 {
>>> +                     compatible = "ethernet-phy-ieee802.3-c22";
>>> +                     reg = <3>;
>>> +             };
>>> +     };
>>> +};
>>> +
>>> +&flexcan1 {
>>> +     pinctrl-names = "default";
>>> +     pinctrl-0 = <&pinctrl_flexcan1>;
>>> +     status = "okay";
>>> +};
>>> +
>>> +
>>> +&i2c2 {
>>> +     clock-frequency = <384000>;
>>> +     pinctrl-names = "default";
>>> +     pinctrl-0 = <&pinctrl_i2c2>;
>>> +     status = "okay";
>>> +
>>> +     pca6416_3: gpio-i2c2@20 {
>>
>> No improvements.
> 
> I am not sure what I am supposed to do here.  I already have one node
> called "gpio@20" and as far as I know, I can't have duplicate nodes
> with the same name.  I have the same GPIO expander with the same on a
> different i2c bus.  Do you have a recommendation as to what name I
> should use so the names are unique?
> 
>>
>>> +             compatible = "nxp,pcal6416";
>>> +             reg = <0x20>;
>>> +             gpio-controller;
>>> +             #gpio-cells = <2>;
>>> +             interrupt-parent = <&gpio4>;
>>> +             interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
>>> +             interrupt-controller;
>>> +             #interrupt-cells = <2>;
>>> +     };
>>> +};
>>> +
>>> +&i2c3 {
>>> +     /* Connected to USB Hub */
>>> +     ptn5110: ptn5110@52 {
>>
>> No improvements ... I'll stop reviewing. No point if you do not intend
>> to apply the comments.
> 
> I changed this node from tcpc to ptn5110 per your last comment, and it
> matches other boards that use this and
> Documentation/devicetree/bindings/connector/usb-connector.yaml example
> uses ptn5110.
> Documentation/devicetree/bindings/usb/typec-tcpci.txt just called it
> "ptn5110@50" .

My comment was that node name has to be generic. ptn5110 is not generic
but specific. I gave you reference to examples of generic names but in
other boards there are more examples how this could be named.

> 
> imx8mm-evk.dtsi calls it "ptn5110: tcpc@50" so that's the example I
> followed.  I am guessing it fails the build test because there isn't a
> yaml file for this driver.
> 
> I wasn't intentionally ignoring your comments, and I honestly tried to
> catch them.
> 
> If you let me know how you want me to proceed, I will do a V3.

I stopped reviewing. Implement all the comments but if something is not
clear, just ask for clarification.

Best regards,
Krzysztof

