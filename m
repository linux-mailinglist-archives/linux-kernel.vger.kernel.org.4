Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3278E724EA1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 23:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238567AbjFFVQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 17:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238448AbjFFVQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 17:16:07 -0400
Received: from smtp.dudau.co.uk (dliviu.plus.com [80.229.23.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C74A71720;
        Tue,  6 Jun 2023 14:16:04 -0700 (PDT)
Received: from mail.dudau.co.uk (bart.dudau.co.uk [192.168.14.2])
        by smtp.dudau.co.uk (Postfix) with SMTP id EDDB141D13A6;
        Tue,  6 Jun 2023 22:16:02 +0100 (BST)
Received: by mail.dudau.co.uk (sSMTP sendmail emulation); Tue, 06 Jun 2023 22:16:02 +0100
From:   Liviu Dudau <liviu@dudau.co.uk>
To:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Liviu Dudau <liviu@dudau.co.uk>
Subject: [PATCH v4 0/2] mips: dts: ralink: Add support for TP-Link HC220 G5 v1 board
Date:   Tue,  6 Jun 2023 22:15:58 +0100
Message-Id: <20230606211600.1601694-1-liviu@dudau.co.uk>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree and bindings for the TP-Link HC220 G5 v1 wireless AP,
a consumer product from TP-Link based on MT7621.

Changes since v3:
 - Turns out that adding sub-nodes to the pcie invites more warnings from
   dtbs_check so we're dropping those
 - Running dtbs_check made me realise that I need to re-order the patches
   so that the bindings are introduced first. Hence the major change in v4
   is the re-ordering of patches
 - Renamed the LEDs nodes to match the schema.

Changes since v2:
 - Remove WIP nodes for NAND flash that accidentally got included in v2
 - Fix commit message with the actual 5GHz WiFi chip name
 - Remove gmac and mdio nodes from device tree as defaults are sufficient
 - Added sub-nodes under pcie for each of the WiFi chip with appropriate
   compatible string.
 - Collect Acks received for the device tree bindings patch

Changes since v1:
 - Changed compatible for the board to "tplink,hc220-g5-v1"
 - Updated the DSA switch nodes to better reflect actual usage.
 - Disabled the fixed-link in gmac1
 - Added device tree bindings in Documentation/

v3: https://lore.kernel.org/linux-mips/20230605150114.601102-1-liviu@dudau.co.uk/
v2: https://lore.kernel.org/linux-mips/20230529150833.526084-1-liviu@dudau.co.uk/
v1: https://lore.kernel.org/linux-mips/20230509200125.309026-1-liviu@dudau.co.uk/

Liviu Dudau (2):
  dt-bindings: mips: Add bindings for TP-Link HC220 G5 v1 board
  mips: dts: ralink: Add support for TP-Link HC220 G5 v1 board

 .../devicetree/bindings/mips/ralink.yaml      |  1 +
 arch/mips/boot/dts/ralink/Makefile            |  3 +-
 .../dts/ralink/mt7621-tplink-hc220-g5-v1.dts  | 84 +++++++++++++++++++
 3 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts

-- 
2.40.1

