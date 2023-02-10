Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F706924FE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 19:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjBJSDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 13:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjBJSDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 13:03:39 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46885FE7F;
        Fri, 10 Feb 2023 10:03:37 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 31AI3JG7069959;
        Fri, 10 Feb 2023 12:03:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1676052199;
        bh=6OgJKNeu58dGw6Jp+CczWSAuYltsMXp4bPxaIKauZns=;
        h=From:To:CC:Subject:Date;
        b=AKmfEtCNUd6VFGj3ZEwkzV9tn1Cep1vQgouUEV//azmIdymUe6CuReokDbIyoIsJt
         77rqi7EoRXFZSZdgbEObDzj9d2tRXYNVfSA4vew09/DjIM5L1+/Bp13IAbwIA4u6CR
         ZcLk2JUB2Pu2SwjkuLcOaIzgtMZVq3VuexVJlAUg=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 31AI3JRo003852
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Feb 2023 12:03:19 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 10
 Feb 2023 12:03:18 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 10 Feb 2023 12:03:18 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 31AI3HSM001322;
        Fri, 10 Feb 2023 12:03:18 -0600
From:   Devarsh Thakkar <devarsht@ti.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <kristo@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>
CC:     <hnagalla@ti.com>, <praneeth@ti.com>, <a-bhatia1@ti.com>,
        <j-luthra@ti.com>, <devarsht@ti.com>
Subject: [PATCH v2] arm64: dts: ti: k3-am62a7-sk: Fix DDR size to full 4GB
Date:   Fri, 10 Feb 2023 23:33:17 +0530
Message-ID: <20230210180317.6157-1-devarsht@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All revisions of AM62A7-SK board have 4GB LPDDR4 Micron
MT53E2G32D4DE-046 AUT:B memory. Commit 38c4a08c820c ("arm64: dts: ti:
Add support for AM62A7-SK") enabled just 2GB due to a schematics error
in early revision of the board. Fix it by enabling full 4GB available on
the platform.

Design docs: Link: https://www.ti.com/lit/zip/spruj16

Fixes: 38c4a08c820c ("arm64: dts: ti: Add support for AM62A7-SK")

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
Logs:
https://gist.github.com/devarsht/e85b6af89c01ddadb3a62f3e5f196af8

Changelog:
V2: Update commit message with mention of schematics error
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index 5c9012141ee2..f6a67f072dca 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -27,8 +27,9 @@
 
 	memory@80000000 {
 		device_type = "memory";
-		/* 2G RAM */
-		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
+		/* 4G RAM */
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
+		      <0x00000008 0x80000000 0x00000000 0x80000000>;
 	};
 
 	reserved-memory {
-- 
2.17.1

