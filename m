Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C97060ED29
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 02:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbiJ0Aug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 20:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJ0Aud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 20:50:33 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9AD56B93;
        Wed, 26 Oct 2022 17:50:31 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id u2so35512ljl.3;
        Wed, 26 Oct 2022 17:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jt3MIRMKXjXJnnd81rELlMmSLDWwlHxTIiZ16VJwbbw=;
        b=ldaVpeXnNCizOC81BoRZpy0h3vlJqWMvSMySEkRZ8RTWUhzLCXCG2mzZUhcQyWzYAp
         +53PxdCtY+eC7j7sDd8eOPmBzNwH0Z5YDD9VlcE4HVmlDhAoo5lBwtbsCbkITU9ciGZ7
         /RD97MuWjjKSnr3CJ9AEcU8efAWzwCWCLCfSxfDQI5lY0BkxBkq1TwEIhp0noV3G9Nka
         f5CE8BMYF0vCYxm4Srcts/Tc9B5IGgfk5SdaqiXMPrH57jqggQHoY+XA7Mk4z8qHNb0E
         z6ki+TvbuRhUjzcIFGcm0airNcaT5p4t8p7EpHEK2aj47IScVThsAu+BYehnss9igfcH
         rSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jt3MIRMKXjXJnnd81rELlMmSLDWwlHxTIiZ16VJwbbw=;
        b=EFfDrWBws3hOIKzXehH0CWn3jiPiuzLAoJTTdXKGfG3mf50nrJMA1SllafNoET6OsJ
         NMlyZb5X558dlwCatNByajvfwmmyXLh9uAhlBADqkJLfBG2nnOui11Po3pUb3wOMgt6e
         7467JtvAk+RZDroFwjMUu2YhNgZQIn0raHRrZhIp35453zD8dUf8mqYLT6qQ3WGpqupu
         8+SnVDMChLp1hxUFn7OnhICJsctBfzZUxNgdRSS1y/a0lFD+3ycjlhK/PPalexNa8eXL
         43GDSIPggKQtMGBYFw7SgHK+zXJawh6TjcjDK02y1d/RY0BCBe3ybiIQGltlod1KAKUZ
         PDag==
X-Gm-Message-State: ACrzQf0RMWwnkqVDkSUyJdCyIxiX7Wsn9qoXws8phPDLytzxvBpTBjtQ
        78mVXvWS9v7Zm2CGLPqKDbQzTd/234U=
X-Google-Smtp-Source: AMsMyM4UN8PRjyzxfcCMWbPkvysSgG57BxsgajhoMihbcJPaMRC9bTJ77a01K1tO4L3Qm2mElKka7w==
X-Received: by 2002:a17:907:6e9e:b0:78c:5533:4158 with SMTP id sh30-20020a1709076e9e00b0078c55334158mr37883433ejc.417.1666831819650;
        Wed, 26 Oct 2022 17:50:19 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id n3-20020a170906724300b007a7f9b6318asm3632975ejk.50.2022.10.26.17.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 17:50:19 -0700 (PDT)
Message-ID: <da1252eb-85e9-bdb8-0542-207173523523@gmail.com>
Date:   Thu, 27 Oct 2022 02:50:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 0/4] Add basic Rockchip rk3128 DT support
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
  Review of nodes and pin definitions.

  Help with testing on hardware.

  Help with correct "arm,armv7-timer" properties.

===

Johan Jonker (4):
  dt-bindings: arm: rockchip: Add Rockchip RK3128 Evaluation board
  dt-bindings: timer: rockchip: add rockchip,rk3128-timer
  ARM: dts: rockchip: add rk3128.dtsi
  ARM: dts: rockchip: add rk3128-evb.dts

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 .../bindings/timer/rockchip,rk-timer.yaml     |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/rk3128-evb.dts              | 105 ++
 arch/arm/boot/dts/rk3128.dtsi                 | 930 ++++++++++++++++++
 5 files changed, 1042 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3128-evb.dts
 create mode 100644 arch/arm/boot/dts/rk3128.dtsi

--
2.20.1

