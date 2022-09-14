Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6815F5B8FF1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 23:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiINVPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 17:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiINVPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 17:15:45 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558B245057;
        Wed, 14 Sep 2022 14:15:43 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 57A3B1A19C2;
        Wed, 14 Sep 2022 23:15:42 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E81BB1A0447;
        Wed, 14 Sep 2022 23:15:41 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 580AE4060A;
        Wed, 14 Sep 2022 14:15:40 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v4 0/5] ls208xa dts updates
Date:   Wed, 14 Sep 2022 16:15:33 -0500
Message-Id: <20220914211538.29473-1-leoyang.li@nxp.com>
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

Some accumulated dts updates for NXP ls208xa SoC family.

v2 Updates:
- Cleaned up patch descriptions
- Updated node names to use - instead of _

v3 Updates:
- Move fpga mdiomux changes from seperate board dtses into common
  ls208xa-qds dtsi
- Update interrupt properties to use MACRO
- More style fixes

v4 Updates:
- Fix node ordering issue
- Add SoB

Biwen Li (1):
  arm64: dts: ls208xa-rdb: fix errata E-00013

Ioana Radulescu (1):
  arm64: dts: ls2080a-rdb: add phy nodes

Li Yang (1):
  arm64: dts: ls208xa-qds: add mdio mux nodes from on-board FPGA

Pankaj Bansal (1):
  arm64: dts: ls208x: remove NXP Erratum A008585 from LS2088A.

Priyanka Jain (1):
  arm64: dts: ls2081a-rdb: Add DTS for NXP LS2081ARDB

 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/fsl-ls2080a-rdb.dts    |  69 +++++++++
 .../arm64/boot/dts/freescale/fsl-ls2080a.dtsi |   4 +
 .../boot/dts/freescale/fsl-ls2081a-rdb.dts    | 132 ++++++++++++++++++
 .../boot/dts/freescale/fsl-ls208xa-qds.dtsi   |  65 ++++++++-
 .../boot/dts/freescale/fsl-ls208xa-rdb.dtsi   |   2 +
 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi |   3 +-
 7 files changed, 271 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dts

-- 
2.37.1

