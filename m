Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AD5720366
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbjFBNap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbjFBNag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:30:36 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D766E52;
        Fri,  2 Jun 2023 06:30:25 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352CPh86004909;
        Fri, 2 Jun 2023 15:30:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=2GzwoxYEjBT0JhugYezi2XGAktvGSWYGvh5MOPi4uiM=;
 b=1t7tUoPhodc9wAxJcRSzW/le1XLeRT9bosK7fJDy5mJb0MXGIFTG8A+Z7aSs0GmmJits
 nS9I71iJxd8HTrd0IkfM/YKxlnMBxGjH6uhfVkTJfq9uPxyvZLesmEHabOxsP5qabi8E
 a9+jUGgFOu2sGitLsQoISuNTkzHdYIwoXV7OtpKAgvqhqUnXM+UOPTxSo2h8z+2LzWFb
 k3xunm11OP4GCAeUOJJJRcQd0zOS8MHNtp/Ene2u7J2vzD2HOyiGldSjxz0+eTRNAF3z
 4m/wYbl5TTtHp6+n7GlPSPVFrpp5NtiBU/XdyQ8Os3ZwtddXeCc1TCwvzYf8GOMGJ4HF Cw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qyc51a0aw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 15:30:11 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BE591100034;
        Fri,  2 Jun 2023 15:30:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B5FE923694A;
        Fri,  2 Jun 2023 15:30:10 +0200 (CEST)
Received: from localhost (10.201.21.93) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 2 Jun
 2023 15:30:10 +0200
From:   Alexandre Torgue <alexandre.torgue@foss.st.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, <soc@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
Subject: [PATCH v2 07/10] dt-bindings: stm32: document stm32mp257f-ev1 board
Date:   Fri, 2 Jun 2023 15:28:56 +0200
Message-ID: <20230602132859.16442-8-alexandre.torgue@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230602132859.16442-1-alexandre.torgue@foss.st.com>
References: <20230602132859.16442-1-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_10,2023-06-02_02,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new entry for stm32mp257f-ev1 board.

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index 4af5b8f4f803..4466b455bffa 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -161,6 +161,12 @@ properties:
           - const: phytec,phycore-stm32mp157c-som
           - const: st,stm32mp157
 
+      - description: ST STM32MP257 based Boards
+        items:
+          - enum:
+              - st,stm32mp257f-ev1
+          - const: st,stm32mp257
+
 additionalProperties: true
 
 ...
-- 
2.17.1

