Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5EF691926
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 08:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjBJH1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 02:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjBJH1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 02:27:53 -0500
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E055ACFE;
        Thu,  9 Feb 2023 23:27:51 -0800 (PST)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 31A7EW2B068844;
        Fri, 10 Feb 2023 15:14:32 +0800 (GMT-8)
        (envelope-from chiawei_wang@aspeedtech.com)
Received: from Chiawei-PC03.aspeed.com (192.168.2.66) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 10 Feb
 2023 15:26:47 +0800
From:   Chia-Wei Wang <chiawei_wang@aspeedtech.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <jirislaby@kernel.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>
Subject: [PATCH 0/4] arm: aspeed: Add UART with DMA support
Date:   Fri, 10 Feb 2023 15:26:39 +0800
Message-ID: <20230210072643.2772-1-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.66]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 31A7EW2B068844
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add the serial driver with DMA support for
AST26xx UART and VUART devices.

Chia-Wei Wang (4):
  dt-bindings: aspeed: Add UART controller
  soc: aspeed: Add UART DMA support
  serial: 8250: Add Aspeed UART driver
  ARM: dts: aspeed-g6: Add UDMA node

 .../bindings/serial/aspeed,uart.yaml          |  81 +++
 arch/arm/boot/dts/aspeed-g6.dtsi              |   7 +
 drivers/soc/aspeed/Kconfig                    |   9 +
 drivers/soc/aspeed/Makefile                   |   1 +
 drivers/soc/aspeed/aspeed-udma.c              | 447 ++++++++++++++++
 drivers/tty/serial/8250/8250_aspeed.c         | 502 ++++++++++++++++++
 drivers/tty/serial/8250/Kconfig               |   8 +
 drivers/tty/serial/8250/Makefile              |   1 +
 include/linux/soc/aspeed/aspeed-udma.h        |  34 ++
 9 files changed, 1090 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/aspeed,uart.yaml
 create mode 100644 drivers/soc/aspeed/aspeed-udma.c
 create mode 100644 drivers/tty/serial/8250/8250_aspeed.c
 create mode 100644 include/linux/soc/aspeed/aspeed-udma.h

-- 
2.25.1

