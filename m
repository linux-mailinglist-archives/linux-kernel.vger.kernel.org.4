Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F1862FA38
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 17:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbiKRQ2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 11:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241686AbiKRQ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 11:27:58 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EE392B75;
        Fri, 18 Nov 2022 08:27:55 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id m18so2650294vka.10;
        Fri, 18 Nov 2022 08:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aP8xigMH6Cdm1FehOCVDAAEkuLsKjaAGKg6SNk11hm4=;
        b=OTjo/3/lVabVMWDiNLgPqAXVGqRIpWx8gvTgzherYcnKTjbHY9eYeUmqjKxALgB6pv
         d5haJ64lg6v/HMu5tYzW4aUQBG6vJka3W0/CpMw0oaumAZN/Zf4QpJkrwuSMIeM0pvdp
         VgDCSu7Qo+KMGuRK4J2f6Bxlslls85Sh0fOjvTyquUo2EGEzcpa0rC5hyFpOTHc+ZUpC
         W1LKg9Q2u645orMaA8H6nExHFVam0t60DF7qOXTN8raIvJI51IH3GxUhEWuxAnHbe7Tw
         c5HGfpsJNnxkydeq/Z2TOYYSUPoq7B0tXBWGs0Ljap2EyOC1Q3L3vvS12/cYWh52codC
         rCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aP8xigMH6Cdm1FehOCVDAAEkuLsKjaAGKg6SNk11hm4=;
        b=CwqqBVAZc3kG4gdXHj8JGTHkXZZjedtnJkiiGD2NTbwWwBgb51aMEydPcywnKzCTzH
         tKE5OobEC5lJ/2cgMDJFwsnnoJwR5IaUTlBffvpvsc1fuAnCW5h+ESdddEqTkN0XJk4L
         PjSLLYo1wvcW7q6Rx17BXUPwsZwKvFuHZ/M1Q2HVdU5KK0pBl7LtEwe91zN5wKJnbada
         U6ASRe+bxv1FgalfRL/1pZavlG1H1hqugseAI3g7HOeuO+Z88Yw5drp0DC+8oQ99Mp/R
         xIOcdqP45ZNhLPTiKV681FogJ0no+8nFoCiaQk2q/8Ux6HMVehly23YBkiQXkiiMDSBA
         Cvfw==
X-Gm-Message-State: ANoB5pnWXS5nJdLfKl+7TUR82PQyLS9mzl59qQqSjov07/Ym8EB1m8Lv
        4iNw6Z2nKLjq5Ij9tDb1YX1PX2O60sNiHelAivGi8h/y
X-Google-Smtp-Source: AA0mqf5knH/KwKqTKOiQd/z0yhn+IqZ67caj8iY/xM73bDp4/rQAeV2haenOZy56wBGm1B6UliEIwrur+lSZUECx51s=
X-Received: by 2002:a1f:900f:0:b0:3ab:42ba:252 with SMTP id
 s15-20020a1f900f000000b003ab42ba0252mr4415727vkd.8.1668788874135; Fri, 18 Nov
 2022 08:27:54 -0800 (PST)
MIME-Version: 1.0
References: <20221114215817.1953186-1-robertcnelson@gmail.com>
 <20221114215817.1953186-2-robertcnelson@gmail.com> <20221115200357.qa2rvw3clbz7unzq@symptom>
In-Reply-To: <20221115200357.qa2rvw3clbz7unzq@symptom>
From:   Robert Nelson <robertcnelson@gmail.com>
Date:   Fri, 18 Nov 2022 10:27:27 -0600
Message-ID: <CAOCHtYj-6C4-yesHOz0EzDxC+YyZNLUz7f9PxYstvCn_BaiOzQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] arm64: dts: ti: add k3-j721e-beagleboneai64
To:     Nishanth Menon <nm@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Andrew Davis <afd@ti.com>,
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

Thanks Nishanth

On Tue, Nov 15, 2022 at 2:04 PM Nishanth Menon <nm@ti.com> wrote:
> > diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts

> > +
> > +             led-4 {
> > +                     gpios = <&main_gpio0 109 GPIO_ACTIVE_HIGH>;
> > +                     linux,default-trigger = "phy0tx";
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/leds/common.yaml#n82
>
> we'd be Violating the oneOf conditions here.

Removed..

> > +
> > +     vdd_mmc1: regulator-3 {
> > +             compatible = "regulator-fixed";
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&sd_pwr_en_pins_default>;
> > +             regulator-name = "vdd_mmc1";
> > +             regulator-min-microvolt = <3300000>;
> > +             regulator-max-microvolt = <3300000>;
> > +             regulator-boot-on;
> > +             enable-active-high;
> > +             vin-supply = <&vsys_3v3>;
> > +             gpios = <&main_gpio0 82 GPIO_ACTIVE_HIGH>;
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
>
> s/gpios/gpio ?

cleaned up these old gpios -> gpio references...

> > +&main_gpio0 {
> > +     gpio-line-names = "", "P9_11", "P9_13", "P8_17", "P8_18", /* 0-4 */
> > +             "P8_22", "P8_24", "P8_34", "P8_36", "P8_38A", /* 5-9 */
> > +             "P9_23", "P8_37B", "P9_26B", "P9_24B", "P8_08", /* 10-14 */
> > +             "P8_07", "P8_10", "P8_09", "P9_42B", "", /* 15-19 */
> > +             "P8_03", "TYPEC_PWR_ST", "M2_RSTz", "M2_I2C_ALERT#", "P8_35A", /* 20-24 */
> > +             "P8_33A", "P8_32A", "", "P9_17A", "", /* 25-29 */
> > +             "P8_21", "P8_23", "P8_31A", "P8_05", "P8_06", /* 30-34 */
> > +             "P8_25", "M2_W_DISABLE1#", "M2_W_DISABLE2#", "P9_22A (BOOTMODE1)", "P9_21A", /* 35-39 */
> > +             "P9_18A", "DSI_I2C_SCL", "DSI_I2C_SDA", "P9_28B", "P9_30B", /* 40-44 */
> > +             "P9_12", "P9_27A", "P9_15", "P8_04 (BOOTMODE2)", "VCC_DP_EN", /* 45-49 */
> > +             "P9_33B", "P8_26", "P9_31B", "P9_29B", "P9_39B", /* 50-54 */
> > +             "P9_35B", "P9_36B", "P9_37B", "P9_38B", "P8_12", /* 55-59 */
> > +             "P8_11 (BOOTMODE7)", "P8_15", "P8_16", "", "", /* 60-64 */
> > +             "P8_43", "P8_44", "P8_41", "P8_42 (BOOTMODE6)", "P8_39", /* 65-69 */
> > +             "P8_40", "P8_27", "P8_28", "P8_29", "P8_30", /* 70-74 */
> > +             "P8_14", "P8_20", "P9_20B", "P9_19B", "P8_45", /* 75-79 */
> > +             "P8_46 (BOOTMODE3)", "P9_40B", "VDD_SD_EN", "CSI_I2C_SCL", "CSI_I2C_SDA", /* 80-84 */
> > +             "M2_I2S_SCK", "M2_I2S_WS", "M2_I2S_IN", "P8_19", "P8_13", /* 85-89 */
> > +             "P9_21B", "P9_22B", "M2_I2S_OUT", "P9_14", "P9_16", /* 90-94 */
> > +             "USR1", "USR0", "USR2", "DSI_GPIO1", "FAN_PWM", /* 95-99 */
> > +             "FAN_TACH", "CSI1_GPIO1", "CSI0_GPIO2", "CSI0_GPIO1", "P9_25B", /* 100-104 */
> > +             "P8_38B", "P8_37A", "CSI1_GPIO2", "DSI_GPIO2", "USR4", /* 105-109 */
> > +             "USR3", "P8_33B", "DP_HPD", "M2_UART_CTSn", "M2_UART_RTSn", /* 110-114 */
> > +             "P9_17B", "P8_35B", "VDD_SD_SEL", "P9_26A", "P9_24A", /* 115-119 */
> > +             "P9_18B", "CONSOLE_RX", "CONSOLE_TX", "P9_42A", "P9_27B", /* 120-124 */
> > +             "M2_UART_RX", "M2_UART_TX", "P9_25A"; /* 125-127 */
>
> Can we drop the gpio-line-names description for now?
> gpio-line-names: maxItems: 32 in
> Documentation/devicetree/bindings/gpio/ti,omap-gpio.yaml - that probably
> should be fixed prior to this else we get the dtbs_check warning around
> this. The max count actually depends on ti,ngpio - So, I think the
> schema is probably not accurate here.

Removed for now, till we are ready..

Regards,

-- 
Robert Nelson
https://rcn-ee.com/
