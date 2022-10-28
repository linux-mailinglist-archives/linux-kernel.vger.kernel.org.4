Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192306114C5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiJ1Ojh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiJ1OjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:39:19 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D08E1CCCFB;
        Fri, 28 Oct 2022 07:39:18 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id f37so8599208lfv.8;
        Fri, 28 Oct 2022 07:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=438MwCH9BTrA9BcLzWtnTn0JobWEvRhTpMnkj9ZVmww=;
        b=D6fblxQFn5vZbZOLKFcWYLtI+c5zEeyTAZFyxcD1/OuwZbjwiAe7Rx2XzqRykO7NB4
         FD3Urrlg6EwzXqeeeBNgNG9L6NGUf7kpLhdjTANcQw2PJyshDO1qdJS3j9dfllmSO+iF
         fitc0zBqXUiIdk3ZmY3elt03yduCSbxd8TDrrJ1EPruopt/jKNNHQf9V/ACPqJHvlXia
         Ai7z3Ow9ZFsPEGz/dt5LHnZDFLU7Lw/HQV2e3+9Ta1gfOhN3LHYGmslCk+z29lv0Ds2J
         5pdseKa35npP7brfhnpTl9nLjdYEbwiDiXAD3Kh7VYpGwghSFsUEAkd94mmCWgh+PtT3
         hWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=438MwCH9BTrA9BcLzWtnTn0JobWEvRhTpMnkj9ZVmww=;
        b=hObzsKI+/gn4XdTkxVOnOsfRptOch0qMr+fUwsDBykzSxjRdsdXAOJkt+LVPoF7CC4
         H0xi3SEn78ELXk9oZVvNpDxld80QeCRvBI+lO7sHYQlS5tToVfBb7eJDUyWm1EI2qFos
         45mPCUhZDMbjYWt1Frs6r0czNE5rfUZJThC+86KG2e43ZxbTmfNZytZmz1Kn8gfRLdOo
         zFM3fybu5uwnHzIypcK1uqDrfTU1bq9rZ4/LO7wt28hS5gJ6VWJz+tAlPHFT5JzSkqQH
         kyjAo+3B7y34Jll/8Y2va089JQUSpse24lNdN4p5uV4hKTGUOrk1CayHf9h59NWjERKk
         lGQg==
X-Gm-Message-State: ACrzQf2uYPTeoY0VagGw7HGag4GsOhHg7V5lxu0+TaWt5jLN1l92Ui4y
        kgR/wkIvKIwMbQXz7IMwVm8RmJM1IkE=
X-Google-Smtp-Source: AMsMyM62WjvitZ/M1z2g9r8bWwHww4iANV4p1qKSM1aGXF74m8W47uJXLz8akxUC5+rl6g/WQgKGBg==
X-Received: by 2002:a17:907:6288:b0:78d:ab30:c374 with SMTP id nd8-20020a170907628800b0078dab30c374mr48265363ejc.266.1666967946292;
        Fri, 28 Oct 2022 07:39:06 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id e2-20020a170906314200b0077e6be40e4asm2293971eje.175.2022.10.28.07.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 07:39:05 -0700 (PDT)
Message-ID: <e83964fe-ad87-0905-4586-e235757c6b2b@gmail.com>
Date:   Fri, 28 Oct 2022 16:39:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 0/4] Add basic Rockchip rk3128 DT support
To:     kever.yang@rock-chips.com, heiko@sntech.de
Cc:     sjg@chromium.org, philipp.tomsich@vrull.eu,
        zhangqing@rock-chips.com, hjc@rock-chips.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic Rockchip rk3128 DT support.

Features:
  Quad-core ARM Cortex-A7MP Core processor
  Clock & reset unit
  Power management unit
  Interrupt controller
  DMAC
  6x 64 bits Timers
  4x PWMs
  1x 32 bits watchdog

Internal memory:
  Internal BootRom
  Internal SRAM 8KB

External memory:
  Dynamic Memory Interface (DDR3/DDR3L/LPDDR2)
  Nand Flash Interface
  eMMC Interface
  SD/MMC Interface

Connectivity:
  SDIO interface
  SPI Controller
  3x UART controller
  4x I2C controllers
  4x groups of GPIO (GPIO0~GPIO3), 32 GPIOs per group
  USB Host2.0
  USB OTG2.0

===

The Linux kernel has added a rk3128 clock driver in the past,
but the DT is still missing.

In U-boot the rk3128 DT doesn't conform the latest bindings
and also the pin definition don't match the TRM.

On request from the U-boot maintainers I submit a basic rk3128 DT.
https://lore.kernel.org/u-boot/258c2dbf-436d-5935-83f5-a2dbb8cf62d7@rock-chips.com/

Based on:
https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/rk3128.dtsi
https://github.com/rockchip-linux/kernel/blob/develop-4.4/arch/arm/boot/dts/rk312x.dtsi

rk3128 TRM:
https://rockchip.fr/RK312X%20TRM/

rk3128 datasheet:
https://rockchip.fr/RK3128%20datasheet%20V1.2.pdf

===

NOT TESTED WITH HARDWARE
NO THERMAL PROTECTION

===

Request:
  Help with testing on hardware.

===

Changed V2:
  rk3128.dtsi:
    remove aliases
    add gic interrupts mask defines
    add virtual timer interrupts

  rk3128-evb.dts:
    use generic node names
    remove underscores in node names
    add more aliases
    sort

===

Johan Jonker (4):
  dt-bindings: arm: rockchip: Add Rockchip RK3128 Evaluation board
  dt-bindings: timer: rockchip: add rockchip,rk3128-timer
  ARM: dts: rockchip: add rk3128.dtsi
  ARM: dts: rockchip: add rk3128-evb.dts

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 .../bindings/timer/rockchip,rk-timer.yaml     |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/rk3128-evb.dts              | 110 +++
 arch/arm/boot/dts/rk3128.dtsi                 | 916 ++++++++++++++++++
 5 files changed, 1033 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3128-evb.dts
 create mode 100644 arch/arm/boot/dts/rk3128.dtsi

--
2.20.1

