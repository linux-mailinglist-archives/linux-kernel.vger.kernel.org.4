Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A815161153C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbiJ1Oxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiJ1Ox3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:53:29 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B37F1F9A0E;
        Fri, 28 Oct 2022 07:53:27 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SDCi79013355;
        Fri, 28 Oct 2022 16:53:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=8PdcPXxidlHp2o41TdlLM3Nxlywt9jkYMVUfoBAn7Mo=;
 b=lWRxtqXpXdEYHctrNKj3M7VarZ3obgW67Rawbe7QrDbcw8beGpCkYbKafSqRscO2PY6P
 pmRTi3qEC58+iykjlwk8x1sKpPjehj+K6yBiie9ADmq2DSOEZfEPoR6PhbUaXrZtFbO6
 MZdUL4I5ZdLdOnQuFWYTC0o5qjKhGxkjyYh6qW20a9tp1hVK+WdffgnSbQkkVtjrIJhI
 0HGCeoREhNzLsZm1u0nTC4yG467VZB8W1tPVGOsTlz6v8RRqawx9TizlI4TG8sUV4Ucf
 FBag98HUT++jgjsikkc1+QZoS3scbRnsYfRFezm5cJwhU0vwl8KgVz2JjiGhwhpta+3b Eg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3kfahu5hyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 16:53:04 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B0A71100038;
        Fri, 28 Oct 2022 16:52:59 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AB7FA228A4F;
        Fri, 28 Oct 2022 16:52:59 +0200 (CEST)
Received: from localhost (10.48.0.157) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 28 Oct
 2022 16:52:59 +0200
From:   Patrick Delaunay <patrick.delaunay@foss.st.com>
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
CC:     Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 1/3] dt-bindings: nvmem: add new stm32mp13 compatible for stm32-romem
Date:   Fri, 28 Oct 2022 16:52:49 +0200
Message-ID: <20221028165150.1.Ifc1812116ff63f5501f3edd155d3cf5c0ecc846c@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221028145252.2115933-1-patrick.delaunay@foss.st.com>
References: <20221028145252.2115933-1-patrick.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.0.157]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new compatible for stm32mp13 support.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---
This patch is already sent separately in:
https://lore.kernel.org/all/20221014172324.1.Ifc1812116ff63f5501f3edd155d3cf5c0ecc846c@changeid/
https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=685403

I create a serie for more efficient review.

Patrick.

 Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
index 448a2678dc62..16f4cad2fa55 100644
--- a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
@@ -22,6 +22,7 @@ properties:
   compatible:
     enum:
       - st,stm32f4-otp
+      - st,stm32mp13-bsec
       - st,stm32mp15-bsec
 
   reg:
-- 
2.25.1

