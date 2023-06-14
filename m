Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAFC72FAF4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243691AbjFNKbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244339AbjFNKaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:30:11 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D97C26B6;
        Wed, 14 Jun 2023 03:28:52 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EAO0ip016397;
        Wed, 14 Jun 2023 12:27:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=IO45dz8yA49c+yguw/M+bsYiIHpf2WR12MPWBTcEkBs=;
 b=F7OnhocDcs14aM7aaN19kJAua6vQfWL3iBAO3Q3BJKjD6G43iGCKNFsAyI2jLuF6K1Ya
 9dVEc/0km5CSjORfFd7KdLgyzJQ2bXNs0pIKZ7Do6Dr8OTCZHP+tEnsPWRsEa8T7Xwe9
 +bsA4mmmIuo1I4XGoWynLNKw21Tg7ThwEdOsAFLbOxNSAM+ToEl9t295Lk96DduUX3qq
 UL4aiKgPGVaip3UF5wGvuWOSbGSC+8kpOUmKwNpLQeBghMbRopEjS9crsE05Vvh8hHbc
 9e1SGZT7xqMB+7B6esYoEZpYoXd48un9AHHAFINnnbBOPIxZnnF9AZHOokTnuEDszQ1s 5A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r795qsdx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 12:27:49 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1A1C410002A;
        Wed, 14 Jun 2023 12:27:49 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1395F2278AF;
        Wed, 14 Jun 2023 12:27:49 +0200 (CEST)
Received: from localhost (10.252.29.239) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 14 Jun
 2023 12:27:48 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: [PATCH v2 3/4] dt-bindings: spi: stm32: disable spi-slave property for stm32f4-f7
Date:   Wed, 14 Jun 2023 12:26:26 +0200
Message-ID: <20230614102628.202936-4-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230614102628.202936-1-valentin.caron@foss.st.com>
References: <20230614102628.202936-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.29.239]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_06,2023-06-14_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alain Volmat <alain.volmat@foss.st.com>

STM32F4 and STM32F7 can't switch to spi slave mode.
Forbid this property with compatible "st,stm32f4-spi".

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 Documentation/devicetree/bindings/spi/st,stm32-spi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
index 9ca1a843c820..f1c86e694af1 100644
--- a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
@@ -27,6 +27,7 @@ allOf:
     then:
       properties:
         st,spi-midi-ns: false
+        spi-slave: false
 
 properties:
   compatible:
-- 
2.25.1

