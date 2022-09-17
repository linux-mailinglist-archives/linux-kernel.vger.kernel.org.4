Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AD05BB99F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 18:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiIQQ5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 12:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiIQQ5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 12:57:40 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108CF2E69F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 09:57:38 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x27so7114319lfu.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 09:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=OW5cyFrIeNWs5Ezch0QGBm4fKKcV3jLO9wWt1aINiZI=;
        b=No9Noj/xjJC54ku/mz2dTEi6t2bCFDreezHwFeM57qECzGH+xP48vI8EyPI39aK2nU
         kb6/S+dOKWYFK5om5zoV2nDcVPntA7jHtj2XEx67JROVEg9gsrlmHdrCwYJtANHQyA7A
         hCJBF+/+jhartmbN4u02MQXVDU/p9qTGn7gwTCrV1w1Wp7Oj7OX7MgLCvIiVFxDpWj7G
         roJJiKtTjdxaCYV6Sio4Zn4ngdMh49AYZsWV/NkgWgGwwJ8Re4iCpYRs8bAbBS69LlN8
         l+Oqzc8faSPdvhHgDiFXyKRlfwM9p/gkDpjjGkROeU1Cmf3BM6Ro2er3Qjh2MJoXwJGN
         Okow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=OW5cyFrIeNWs5Ezch0QGBm4fKKcV3jLO9wWt1aINiZI=;
        b=Jwzhur/UuQZzMiqXeRlMa0kIoS0HIDcgWBMzw7aHFSErvvlbRbGmV+Qc0Enr4/Quh/
         nkKKIBB91k/7nSisIcNL3UFYVakrMPqrjtg9tc6L2vRHQpbqQqU+LWwcyqWR+59KloFa
         /OixL+pY2pfsxFkQRUSzcm9/az9zoDfpkZMtjYkI47ORBmlBGGwzv9W6CwZ4vWdrt2FL
         ej+VzXUPOX48MkP+Fpk7dJkz0RWr64vqouqxziwye1c1MH1WjIp0fYTOIlOicMrs50jy
         ZE2kXRvVUEo58NOIz+16BIn8Vgm9yowG3vqn8Ao8hfysS8eF6L5qZwbpd5xGKqhRn9VO
         xZrg==
X-Gm-Message-State: ACrzQf0hVEcn+HArHWrvcw94nw++dMY7eSOF+sx1aZzzKTE8FRhz9jT9
        36xj+At4ibtv8JHVn3uO6Aa2lQ==
X-Google-Smtp-Source: AMsMyM456mL8Y53OX0R0V4J7fMAnnvEEdQmt4r0M/qYd7+Q36rEPaq+GH9DZNeKlDAp5SDRJbkXlBA==
X-Received: by 2002:a05:6512:3409:b0:49a:692:fd31 with SMTP id i9-20020a056512340900b0049a0692fd31mr3211320lfr.651.1663433856370;
        Sat, 17 Sep 2022 09:57:36 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w9-20020ac254a9000000b00497b198987bsm4180174lfk.26.2022.09.17.09.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Sep 2022 09:57:35 -0700 (PDT)
Message-ID: <10176630-3ff7-54f7-8836-779e5a2bf6d4@linaro.org>
Date:   Sat, 17 Sep 2022 17:57:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] greatlakes: dts: Add Facebook greatlakes (AST2600) BMC
Content-Language: en-US
To:     Bonnie Lo <Bonnie_Lo@Wiwynn.com>, joel@jms.id.au
Cc:     patrickw3@fb.com, garnermic@fb.com, Delphine_Chiu@Wiwynn.com,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org
References: <20220915072304.1438-1-Bonnie_Lo@Wiwynn.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220915072304.1438-1-Bonnie_Lo@Wiwynn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2022 08:23, Bonnie Lo wrote:
> From: Bonnie Lo <Bonnie_Lo@wiwynn.com>

Use subject prefixes matching the subsystem (git log --oneline -- ...).

> 
> Add linux device tree entry related to
> greatlakes specific devices connected to BMC SoC.

Please wrap commit message according to Linux coding style / submission
process:
https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586

> 
> Signed-off-by: Bonnie Lo <Bonnie_Lo@wiwynn.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../dts/aspeed-bmc-facebook-greatlakes.dts    | 248 ++++++++++++++++++

Missing documentation of board compatible (bindings) as first patch.

>  2 files changed, 249 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 05d8aef6e5d2..40fa906ab17f 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1580,6 +1580,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>         aspeed-bmc-asrock-e3c246d4i.dtb \
>         aspeed-bmc-asrock-romed8hm3.dtb \
>         aspeed-bmc-bytedance-g220a.dtb \
> +       aspeed-bmc-facebook-greatlakes.dtb \

Wrong order.

>         aspeed-bmc-facebook-bletchley.dtb \
>         aspeed-bmc-facebook-cloudripper.dtb \
>         aspeed-bmc-facebook-cmm.dtb \
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
> new file mode 100644
> index 000000000000..f011cc4d370f
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
> @@ -0,0 +1,248 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2022 Facebook Inc.
> +
> +/dts-v1/;
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/i2c/i2c.h>
> +#include <dt-bindings/leds/leds-pca955x.h>
> +
> +/ {
> +       model = "AST2600 EVB";

Wrong name.

> +       compatible = "aspeed,ast2600";

Missing board compatible.

> +
> +       aliases {
> +               serial4 = &uart5;
> +       };
> +
> +       chosen {
> +               stdout-path = &uart5;
> +               bootargs = "console=ttyS4,57600n8 root=/dev/ram rw vmalloc=384M";

Bootargs usually do not belong to mainline DTS.

> +       };
> +
> +       memory@80000000 {
> +               device_type = "memory";
> +               reg = <0x80000000 0x80000000>;
> +       };
> +
> +       iio-hwmon {
> +               compatible = "iio-hwmon";
> +               io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
> +                               <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
> +                               <&adc1 0>, <&adc1 2>, <&adc1 3>, <&adc1 4>,
> +                               <&adc1 5>, <&adc1 6>;
> +       };
> +};
> +
> +&uart1 {
> +       status = "okay";
> +};
> +
> +&uart2 {
> +       status = "okay";
> +};
> +
> +&uart3 {
> +       status = "okay";
> +};
> +
> +&uart4 {
> +       status = "okay";
> +};
> +
> +&uart5 {
> +       status = "okay";
> +};
> +
> +&wdt1 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_wdtrst1_default>;
> +       aspeed,reset-type = "soc";
> +       aspeed,external-signal;
> +       aspeed,ext-push-pull;
> +       aspeed,ext-active-high;
> +       aspeed,ext-pulse-duration = <256>;
> +};
> +
> +&mac3 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_rmii4_default>;
> +       no-hw-checksum;
> +       use-ncsi;
> +       mlx,multi-host;
> +       ncsi-ctrl,start-redo-probe;
> +       ncsi-ctrl,no-channel-monitor;
> +       ncsi-package = <1>;
> +       ncsi-channel = <1>;
> +       ncsi-rexmit = <1>;
> +       ncsi-timeout = <2>;
> +};
> +
> +&rtc {
> +       status = "okay";
> +};
> +
> +&fmc {
> +       status = "okay";
> +       flash@0 {
> +               status = "okay";
> +               m25p,fast-read;
> +               label = "bmc";
> +               spi-rx-bus-width = <4>;
> +               spi-max-frequency = <50000000>;
> +#include "openbmc-flash-layout-64.dtsi"
> +       };
> +       flash@1 {
> +               status = "okay";
> +               m25p,fast-read;
> +               label = "bmc2";
> +               spi-rx-bus-width = <4>;
> +               spi-max-frequency = <50000000>;
> +       };
> +};
> +
> +&i2c0 {
> +       status = "okay";
> +       multi-master;
> +       ipmb0@10 {
> +               compatible = "ipmb-dev";
> +               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +               i2c-protocol;
> +       };
> +};
> +
> +&i2c1 {
> +       status = "okay";
> +       multi-master;
> +       ipmb1@10 {
> +               compatible = "ipmb-dev";
> +               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +               i2c-protocol;
> +       };
> +};
> +
> +&i2c2 {
> +       status = "okay";
> +       multi-master;
> +       ipmb2@10 {
> +               compatible = "ipmb-dev";
> +               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +               i2c-protocol;
> +       };
> +};
> +
> +&i2c3 {
> +       status = "okay";
> +       multi-master;
> +       ipmb3@10 {
> +               compatible = "ipmb-dev";
> +               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +               i2c-protocol;
> +       };
> +};
> +
> +&i2c4 {
> +       status = "okay";
> +};
> +
> +&i2c5 {
> +       status = "okay";
> +};
> +
> +&i2c6 {
> +       status = "okay";
> +};
> +
> +&i2c7 {
> +       status = "okay";
> +};
> +
> +&i2c8 {
> +       status = "okay";
> +       tmp421@1f {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +               compatible = "ti,tmp421";
> +               reg = <0x1f>;
> +       };
> +       // NIC EEPROM
> +       eeprom@50 {
> +               compatible = "st,24c32";
> +               reg = <0x50>;
> +       };
> +};
> +
> +&i2c9 {
> +       status = "okay";
> +       multi-master;
> +       ipmb9@10 {
> +               compatible = "ipmb-dev";
> +               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +               i2c-protocol;
> +       };
> +};
> +
> +&i2c10 {
> +       status = "okay";
> +};
> +
> +&i2c11 {
> +       status = "okay";
> +       eeprom@51 {
> +               compatible = "atmel,24c128";
> +               reg = <0x51>;
> +       };
> +       eeprom@54 {
> +               compatible = "atmel,24c128";
> +               reg = <0x54>;
> +       };
> +};
> +
> +&i2c12 {
> +       status = "okay";
> +       lm75@4f {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +               compatible = "lm75";
> +               reg = <0x4f>;
> +       };
> +};
> +

(...)

> +
> +&gpio0 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_gpiu1_default &pinctrl_gpiu7_default>;
> +};
> +
> +
> --
> 2.17.1
> 
> WIWYNN PROPRIETARY This email (and any attachments) contains proprietary or confidential information and is for the sole use of its intended recipient. Any unauthorized review, use, copying or distribution of this email or the content of this email is strictly prohibited. If you are not the intended recipient, please notify the sender and delete this email immediately.

This means we cannot take this patch. Proprietary and/or confidential
patches cannot be merged.

Please license the patch as you wrote in SPDX header.

Best regards,
Krzysztof
