Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FB5650DAD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbiLSOnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbiLSOnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:43:20 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2616316;
        Mon, 19 Dec 2022 06:43:19 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJ9PqqD009699;
        Mon, 19 Dec 2022 06:43:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=tfKr+xXc2cgLrr9davShwFArLLebfDxGXdhIIjfRQgg=;
 b=X0iXOns5yvh7Da8pA6fXtKa3m1NdWd4qx1fgyMxCpeZAmjZDrKJh7Oqu7C3jVO/RrQJJ
 L/6ed0fmdWWbZTBjXa8EcfkCwFYgoRb/zkIlohyJdRybLjemW4KQ6IL8u+wS/d3hRfq3
 IHekvWA+8YNKRiI+C9Y8uKOGByQmhnEVG8UW0Mv6ZiedS7t8qRnywQ+wupRnyZ0N6zQW
 aCxeHdj5ncK7iYRtzO9OCALwBJVtSoL3NnkO17F4mR/PMMr+n2Bddrsr3P2Sh/ox0/WI
 Fsf7fh9beSFgJlKd7lMc09HY4SLQWjIO+xrAO639RFNDnxTg9pxygSD/0tV5Df+OuzEQ UQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3mjnans4hp-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 06:43:12 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 19 Dec
 2022 06:43:11 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Mon, 19 Dec 2022 06:43:11 -0800
Received: from localhost.localdomain (unknown [10.110.150.170])
        by maili.marvell.com (Postfix) with ESMTP id EB2A23F7041;
        Mon, 19 Dec 2022 06:43:10 -0800 (PST)
From:   Witold Sadowski <wsadowski@marvell.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <pthombar@cadence.com>, <konrad@cadence.com>,
        <wbartczak@marvell.com>, <wzmuda@marvell.com>,
        <wsadowski@marvell.com>
Subject: [PATCH 4/7] spi: cadence: Change dt-bindings documentation for Cadence XSPI controller
Date:   Mon, 19 Dec 2022 06:42:51 -0800
Message-ID: <20221219144254.20883-5-wsadowski@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221219144254.20883-1-wsadowski@marvell.com>
References: <20221219144254.20883-1-wsadowski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 5IXw_acPU3q4AbkPGEfsRV_dZPfU1GV2
X-Proofpoint-ORIG-GUID: 5IXw_acPU3q4AbkPGEfsRV_dZPfU1GV2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add parameter cdns,read-size.
Parameter is controlling SDMA read size length.

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
---
 Documentation/devicetree/bindings/spi/cdns,xspi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
index f71a9c74e2ca..1274e3bf68e6 100644
--- a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
@@ -37,6 +37,10 @@ properties:
   interrupts:
     maxItems: 1
 
+  cdns,read-size:
+    items:
+      - description: size of single SDMA read operation
+
 required:
   - compatible
   - reg
@@ -60,6 +64,7 @@ examples:
             reg-names = "io", "sdma", "aux";
             interrupts = <0 90 IRQ_TYPE_LEVEL_HIGH>;
             interrupt-parent = <&gic>;
+            cdns,read-size=<0>;
 
             flash@0 {
                 compatible = "jedec,spi-nor";
-- 
2.17.1

