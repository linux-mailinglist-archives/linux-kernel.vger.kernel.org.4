Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558185B9031
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 23:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiINVrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 17:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiINVrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 17:47:09 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CE480E84;
        Wed, 14 Sep 2022 14:47:08 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6B25A201AD0;
        Wed, 14 Sep 2022 23:47:07 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2D76C201B28;
        Wed, 14 Sep 2022 23:47:07 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id E97D14060D;
        Wed, 14 Sep 2022 14:47:05 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 00/11] accumulated dts updates for ls1043a
Date:   Wed, 14 Sep 2022 16:46:52 -0500
Message-Id: <20220914214703.29706-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 updates:
- Use MACROs for interrupts and gpio property

Hou Zhiqiang (2):
  arm64: dts: ls1043a: Add SCFG phandle for PCIe nodes
  arm64: dts: ls1043a: Add big-endian property for PCIe nodes

Laurentiu Tudor (2):
  arm64: dts: ls1043a: add missing dma ranges property
  arm64: dts: ls1043a: use a pseudo-bus to constrain usb and sata dma
    size

Li Yang (7):
  arm64: dts: ls1043a: fix the wrong size of dcfg space
  arm64: dts: ls1043a: Enable usb3-lpm-capable for usb3 node
  arm64: dts: ls1043a: use pcie aer/pme interrupts
  arm64: dts: ls1043a: make dma-coherent global to the SoC
  arm64: dts: ls1043a: add gpio based i2c recovery information
  arm64: dts: ls1043a-qds: add mmio based mdio-mux support
  arm64: dts: ls1043a-rdb: add pcf85263 rtc node

 .../boot/dts/freescale/fsl-ls1043a-qds.dts    | 173 +++++++++++++++++-
 .../boot/dts/freescale/fsl-ls1043a-rdb.dts    |  10 +
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 132 +++++++------
 3 files changed, 257 insertions(+), 58 deletions(-)

-- 
2.37.1

