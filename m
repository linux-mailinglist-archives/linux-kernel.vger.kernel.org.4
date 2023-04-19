Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BAA6E7427
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjDSHkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 03:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbjDSHja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:39:30 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AD96E86;
        Wed, 19 Apr 2023 00:38:39 -0700 (PDT)
Received: from droid01-cd.amlogic.com (10.98.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Wed, 19 Apr 2023
 15:39:56 +0800
From:   =Xianwei Zhao <xianwei.zhao@amlogic.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <devicetree@vger.kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: [RFC PATCH 0/2] Baisc devicetree support for Amlogic C3
Date:   Wed, 19 Apr 2023 15:38:32 +0800
Message-ID: <20230419073834.972273-1-xianwei.zhao@amlogic.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.98.11.200]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Amlogic C3 is an advanced edge AI processor designed for smart IP camera
applications.

Add ARCH_AMLIPC for the new series.

Add basic devicetree support for the C3 based Amlogic AW409 board,
which describes the following components: CPU, GIC, IRQ, Timer, UART.
It's capable of booting up into the serial console.

Xianwei Zhao (2):
  arm64: amlogic: add new ARCH_AMLIPC for IPC SoC
  arm64: dts: add support for C3 based Amlogic AW409

 arch/arm64/Kconfig.platforms                  | 12 +++
 arch/arm64/boot/dts/amlogic/Makefile          |  1 +
 .../amlogic/amlogic-c3-c302x-aw409-256m.dts   | 30 +++++++
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi   | 87 +++++++++++++++++++
 arch/arm64/configs/defconfig                  |  2 +
 5 files changed, 132 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409-256m.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi


base-commit: ae68fb187b59bc8645974320808ab2d7c41b1833
-- 
2.37.1

