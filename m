Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC319743B71
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbjF3MFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbjF3MF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:05:27 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A40C44AE
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 05:04:44 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U2CIgs013742;
        Fri, 30 Jun 2023 05:04:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=i/mPNEMr80w3zGu0JQ+Zqc1x/xamRYWuNbxzQn5DbZk=;
 b=KVuc6GIoIlrXqVoSiQ+N4X8Ave/Qx2x7F0rDTkGXqEnu4Dg7aZwtpe74Wv0/bhKnUusd
 PAiCXKlJ+/aOWB2mluI6qymr3GnY/MmwDj5Oyic3SdaXUxvlNtTAt97IYdoTaU5acKat
 M5IuhIkmUYfwe4Tcd0vKgrkKnfGfOYpdtWUeIDslOZi0Zrsjo2GK4pQJWJhXOAvnu8Jm
 Yq/slOc8CD3gKvO0T/yZL+X6d/ZNm5JKlZH2Fm522MuqNLzxwxYNbbpGJXcn25yPUWhb
 zLGhrQYxTeyNvj8QA0JhHXFTjRSPHSy+Ico/rhXQ4SfYkhYLtLY6RSyArEofKuHpLQKr oQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3rhp2ehnmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 05:04:38 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 30 Jun
 2023 05:04:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 30 Jun 2023 05:04:22 -0700
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
        by maili.marvell.com (Postfix) with ESMTP id 6F28D3F707E;
        Fri, 30 Jun 2023 05:04:19 -0700 (PDT)
From:   Gowthami Thiagarajan <gthiagarajan@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <bbhushan2@marvell.com>,
        <gcherian@marvell.com>, <lcherian@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH 6/6] dt-bindings: Add YAML schemas for Marvell Odyssey DDR PMU
Date:   Fri, 30 Jun 2023 17:33:51 +0530
Message-ID: <20230630120351.1143773-7-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630120351.1143773-1-gthiagarajan@marvell.com>
References: <20230630120351.1143773-1-gthiagarajan@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: jQwluIhCxADtO5mxf2BxGJ2rdu2mhmsw
X-Proofpoint-GUID: jQwluIhCxADtO5mxf2BxGJ2rdu2mhmsw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for Marvell Odyssey DDR PMU.

Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
---
 .../devicetree/bindings/perf/marvell-cn10k-ddr.yaml      | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml b/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml
index a18dd0a8c43a..a435cbf4aea0 100644
--- a/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml
+++ b/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml
@@ -11,10 +11,15 @@ maintainers:
 
 properties:
   compatible:
-    items:
+    oneOf:
       - enum:
           - marvell,cn10k-ddr-pmu
-
+          - marvell,odyssey-ddr-pmu
+      - items:
+          - enum:
+              - marvell,cn10k-ddr-pmu
+              - marvell,odyssey-ddr-pmu
+          - const: marvell,cn10k-ddr-pmu
   reg:
     maxItems: 1
 
-- 
2.25.1

