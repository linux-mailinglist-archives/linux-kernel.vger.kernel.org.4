Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883D45F0C70
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 15:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiI3N3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 09:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiI3N31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 09:29:27 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5503C18E6A9;
        Fri, 30 Sep 2022 06:29:25 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28UDSxcC035818;
        Fri, 30 Sep 2022 08:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1664544539;
        bh=+J8ZepVgPG6tUlNyVSfPMDV3lR1z5144rtww1yHUjS4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DOCT0P94sZYiOFdjRH3cz9emeX9/kPMI0cjYL3rHzEeN+CI46uYcrMV5v4J5Ml+Gg
         KoqGcqcSQQuBYkXBd8h+xv03yZ2ZxXHMl+uZ0Rq843+gW4bKbkoCCOH0lwScqFprXh
         rxXsGFJjpd+b3DI1gDRztIOoBbqxCROe2VW6k9ag=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28UDSxcJ123017
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Sep 2022 08:28:59 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 30
 Sep 2022 08:28:59 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 30 Sep 2022 08:28:59 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28UDSwcx027570;
        Fri, 30 Sep 2022 08:28:58 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <airlied@gmail.com>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <tomi.valkeinen@ideasonboard.com>,
        <dri-devel@lists.freedesktop.org>, <nm@ti.com>, <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rahul T R <r-ravikumar@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-j721e-*: Fix the property name for dp pwr
Date:   Fri, 30 Sep 2022 18:58:42 +0530
Message-ID: <20220930132842.23421-3-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220930132842.23421-1-r-ravikumar@ti.com>
References: <20220930132842.23421-1-r-ravikumar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the property name of displayport pwr in dp connector
nodes

Signed-off-by: Rahul T R <r-ravikumar@ti.com>
Reported-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 2 +-
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index b1691ac3442d..4cccb6653217 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -162,7 +162,7 @@ dp0: connector {
 		compatible = "dp-connector";
 		label = "DP0";
 		type = "full-size";
-		dp-pwr-supply = <&dp_pwr_3v3>;
+		dp-pwr = <&dp_pwr_3v3>;
 
 		port {
 			dp_connector_in: endpoint {
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 80358cba6954..0e295c661aab 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -217,7 +217,7 @@ dp0: connector {
 		compatible = "dp-connector";
 		label = "DP0";
 		type = "full-size";
-		dp-pwr-supply = <&dp_pwr_3v3>;
+		dp-pwr = <&dp_pwr_3v3>;
 
 		port {
 			dp_connector_in: endpoint {
-- 
2.37.3

