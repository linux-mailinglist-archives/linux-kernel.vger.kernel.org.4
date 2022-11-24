Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3964637F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 20:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiKXTOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 14:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKXTOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 14:14:14 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A747581581;
        Thu, 24 Nov 2022 11:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1669317246; bh=NFWnNIWqkptw3ml6zf4DoZN14+tM1IwZ1YOxSQItJOg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=qRDGKxIB3KUwiyL5cPwS3qckpNr+fdytN1/q52WReVT+FHiy8go0kdxmp+Pwezs1l
         oYVW2FTw62eb7Dr149j4l0e2ERhEgAHAcumG0ld1tUsd1wai9z0Fh28z+kaqb4cCbC
         kLiZFEzjwUbnyprILH0tRR1rmzr39WmmgSN29WHwJ57+c3TqmjcPZwuli/VMAfYRBC
         wmWuWpu63LDxrE/LOJO4OvhpnCdXWqRATbwys3sANIpMN9d4B/Z6OOyHEyNDzZmILa
         GgUnCBYsWaRfaU2+FfMGK+oQ4aAP1rncZvtaFiI2+zmIe1g+teLBJowzI8mjQkPb3s
         VJ2ifp8f8qEPg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.31]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXXyJ-1oPM5y40J5-00Z1jI; Thu, 24
 Nov 2022 20:14:06 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Nuvoton WPCM450 FIU SPI flash controller
Date:   Thu, 24 Nov 2022 20:13:57 +0100
Message-Id: <20221124191400.287918-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pxBod3xIczrwLY9TifnwC2+iMmnbFLXoB3ncLDjLkc76RRm7b5V
 DQY3on6qpKyjtMl6Tl46ZNBFCBoIDNhbQi8ihsiK3KOpORQSJBzxsihmQ6043gmqrEboUtQ
 nxt77CW/A/A+ZRr/GjXCJLoaQ6YTihgLcc2CJpzXzEIMSwOHN297UWQWfJM3SlC3N18mHA5
 yUv+synyMgjdNL2EWsVUA==
UI-OutboundReport: notjunk:1;M01:P0:6rq0NvK4hUg=;9vvRmFGmZv6gIbOpnueK+q+q0Jm
 6ERSxohsixgTlgNiU/Xndkj/jA7u8heRAVIOQfSGEIMlr5vG/dRHKCwuJEkWb00rPjRX/mwKB
 YlOHMpNT8k9KY+RqOzEII/DX/VF1BHW7wWbhWlJyHBHKQU4Lc8zrFXqzw+ptd0nKrAiQe8Ec1
 KkPLAJ5c+6plhUApX9WuJjQM1sBAxozt8Djaqjw0CBEAM6AZkGcyvlwpJdPRM70mcCtPxj+Pf
 az2zR+r1R4QWrY7K8/Iht0TBCUYbSI1uCnY83qq/DbkAHnXcZMnOssnqPLbF87FCHyucZS4ec
 vbfR89zxtCkG/JZjZd166UyU1bQt7WaX9jcdIkB2U0oD+LhaNEUwTbLmj3wBlWH22GWFGIHk1
 wzTMihBdAPSkd1mAwOUAHFxSlAVdEIm6PnA8OMpsa7x2mXlUu8qG62GhLAhecnDYj1aykD+Bh
 /UvYoEqX6y7uPKB3TyBEiA0rvE21UdsCypFPyRiul8jLSVlB0+gIcb787ls2ThwW6IGqkT+V8
 jwp1QX9h8v40tgZN/MC7+Lp49nsLZjdYxn+K7X00kMzTw9+E8se0L3S6Jz1ern6wJgTGnSyzV
 l7QX3GFQztupKGJ/s6Qa9LOCQrAPZ5vPxLuq5PRVXRcU4iOjYnM5625OfH5vniNartVgdzcIj
 HD8jYmKNW6u9/nMozEdvGbR2+tTPBKI/r7ua3px8wvvSRCWqXa0wFlHjmyQ+izu84UDDKPj7b
 +BmMdBOM8BpTuzQ95hlAh60cfMi2XYDnKbTl/QjTy9xizikIHMSHWfmRdLKb7GGbzwP9fbaYy
 CjxPv/8GtaAK4WKJwtsztTcBXbqTbqK6yk0qRYtydOBLr5nvSeiiGBnfraNht+0XC0gDVZ23F
 uWhoxO2ymApUbZcQkPsV11qo794JYcfi1o6MAC9yoJCWGQUizrQhzTi0dr2HC+JRMqh6iGe6y
 viIb3qA3hUNcaUR3IIfb3W2sPcs=
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds DT bindings and a driver for the Flash Interface Unit
(FIU), the SPI flash controller in the Nuvoton WPCM450 BMC SoC. It
supports four chip selects, and direct (memory-mapped) access to 16 MiB
per chip. Larger flash chips can be accessed by software-defined SPI
transfers.

The existing NPCM7xx FIU driver is sufficitently incompatible with the
WPCM450 FIU that I decided to write a new driver.

Changelog for v2:

- Dropped the patches which have been applied in the meantime, leaving
  only three out of eight
- Changed the binding to require both items in the reg property, because
  there is no need to keep the second item optional, suggested by
  Krzysztof Kozlowski
- Various other cleanups suggested by Krzysztof Kozlowski and the kernel
  test robot


Jonathan


Jonathan Neusch=C3=A4fer (3):
  dt-bindings: spi: Add Nuvoton WPCM450 Flash Interface Unit (FIU)
  spi: wpcm-fiu: Add driver for Nuvoton WPCM450 Flash Interface Unit
    (FIU)
  spi: wpcm-fiu: Add direct map support

 .../bindings/spi/nuvoton,wpcm450-fiu.yaml     |  66 +++
 drivers/spi/Kconfig                           |  11 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-wpcm-fiu.c                    | 508 ++++++++++++++++++
 4 files changed, 586 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,wpcm450-=
fiu.yaml
 create mode 100644 drivers/spi/spi-wpcm-fiu.c

=2D-
2.35.1

