Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D6173DBD8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjFZJxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjFZJxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:53:13 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D18EC7;
        Mon, 26 Jun 2023 02:52:29 -0700 (PDT)
Received: from droid01-cd.amlogic.com (10.98.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Mon, 26 Jun 2023
 17:52:26 +0800
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <devicetree@vger.kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: [PATCH 0/2] Baisc devicetree support for Amlogic T7
Date:   Mon, 26 Jun 2023 17:52:21 +0800
Message-ID: <20230626095223.721011-1-xianwei.zhao@amlogic.com>
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

T7 is an advanced application processor designed for smart display.

Add the new T7 SoC/board device tree bindings.

Add basic support for the T7 based Amlogic AN400 board, which describes
the following components: CPU, GIC, IRQ, Timer, UART. It's capable of
booting up into the serial console.

Xianwei Zhao (2):
  dt-bindings: arm: amlogic: add T7 based AN400 bindings
  arm64: dts: add support for T7 based Amlogic AN400

 .../devicetree/bindings/arm/amlogic.yaml      |   6 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../dts/amlogic/amlogic-t7-a311d2-an400.dts   |  30 ++++
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi   | 156 ++++++++++++++++++
 4 files changed, 193 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-an400.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi


base-commit: 057889cb4244096ea5abcbe76ffd4d311c3078fe
-- 
2.37.1

