Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AEE67A824
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 02:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbjAYBCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 20:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjAYBCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 20:02:16 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F43F2330B;
        Tue, 24 Jan 2023 17:02:12 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 25 Jan 2023 10:02:10 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 010362059054;
        Wed, 25 Jan 2023 10:02:10 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 25 Jan 2023 10:02:12 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 5B0DC3D53;
        Wed, 25 Jan 2023 10:02:09 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 0/5] mmc: uniphier-sd: Add UHS mode support
Date:   Wed, 25 Jan 2023 10:01:56 +0900
Message-Id: <20230125010201.28246-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uniphier-sd controller needs to control some siginals from the SD
interface logic to transition to UHS mode.

This series adds UHS mode support to the controller driver
to refer to and control the interface logic registers, which include
mode selector and SDR speed selector.

Kunihiko Hayashi (5):
  dt-bindings: mmc: uniphier-sd: Add socionext,syscon-uhs-mode property
  mmc: uniphier-sd: Add control of UHS mode using SD interface logic
  mmc: uniphier-sd: Add control to switch UHS speed
  ARM: dts: uniphier: Add syscon-uhs-mode to SD node
  arm64: dts: uniphier: Add syscon-uhs-mode to SD node

 .../bindings/mmc/socionext,uniphier-sd.yaml   | 10 +++
 arch/arm/boot/dts/uniphier-ld4.dtsi           |  3 +-
 arch/arm/boot/dts/uniphier-pro4.dtsi          |  3 +-
 arch/arm/boot/dts/uniphier-pro5.dtsi          |  3 +-
 arch/arm/boot/dts/uniphier-pxs2.dtsi          |  3 +-
 arch/arm/boot/dts/uniphier-sld8.dtsi          |  3 +-
 .../boot/dts/socionext/uniphier-ld20.dtsi     |  3 +-
 .../boot/dts/socionext/uniphier-pxs3.dtsi     |  3 +-
 drivers/mmc/host/uniphier-sd.c                | 83 +++++++++++++++++--
 9 files changed, 102 insertions(+), 12 deletions(-)

-- 
2.25.1

