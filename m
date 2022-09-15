Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A405BA342
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 01:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiIOXeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 19:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiIOXen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 19:34:43 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190C7959D;
        Thu, 15 Sep 2022 16:34:39 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 08C46205BAB;
        Fri, 16 Sep 2022 01:34:38 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BE6FF205BA5;
        Fri, 16 Sep 2022 01:34:37 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 8951B40AA2;
        Thu, 15 Sep 2022 16:34:36 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 0/9] accumulated dts updates for ls1046a
Date:   Thu, 15 Sep 2022 18:34:23 -0500
Message-Id: <20220915233432.31660-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 updates:
- Style fixes
- Updated to use MACROs for interrupt and gpio property
- Remove dma-coherent for remaining nodes under SoC

Hou Zhiqiang (1):
  arm64: dts: ls1046a: Add big-endian property for PCIe nodes

Laurentiu Tudor (2):
  arm64: dts: ls1046a: add missing dma ranges property
  arm64: dts: ls1046a: use a pseudo-bus to constrain usb and sata dma
    size

Li Yang (4):
  arm64: dts: ls1046a: Enable usb3-lpm-capable for usb3 node
  arm64: dts: ls1046a: make dma-coherent global to the SoC
  arm64: dts: ls1046a: add gpios based i2c recovery information
  arm64: dts: ls1046a-qds: add mmio based mdio-mux nodes for FPGA

Pankaj Bansal (1):
  arm64: dts: ls1046a-qds: Modify the qspi flash frequency

Xiaowei Bao (1):
  arm64: dts: ls1046a: Add the PME interrupt and big-endian to PCIe EP
    nodes

 .../boot/dts/freescale/fsl-ls1046a-qds.dts    | 157 +++++++++++++++++-
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 117 ++++++++-----
 2 files changed, 225 insertions(+), 49 deletions(-)

-- 
2.37.1

