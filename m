Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E34F6D4DA6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjDCQ05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjDCQ0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:26:55 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83E22694;
        Mon,  3 Apr 2023 09:26:50 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333CkHZ0009298;
        Mon, 3 Apr 2023 18:26:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=rY+Djr2HOgaqAVEnK7qs+dyjPZEDKffzgGQnxC80TYU=;
 b=A2UU/ecL/XEpK2cTyI6ftFb/gp2EtyMfCKqFg9z+aPIT8mlPgcH06pUhSg2DKPeqm/Xz
 w0kkrz+DxSLPlZAKFBZjwfAgwBTFpnlKT2VfAxzs33/KUH6EoCd29OPyJ9c7wscEiGPJ
 mEWeqH1oahyHVbSSJEt9ynPrbtg6ms0g8hqHWsox3MQLH3oQZCoBPKHiwunwy2+bZZe6
 GfD5Lh7bvUAsIpZ8oWz2d42nKKRuOF8qIQVaeFX38fWhfsHfkpB+wNoGgQTjBmlsMScQ
 JvXJgrhuOoHRQ3GTtWSZvZeIei9+iXc8pKVsDgSDTF9ArSnjZatkieShX1dQ2QXwxbMi Fw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ppby3un5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 18:26:41 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 06D7210002A;
        Mon,  3 Apr 2023 18:26:40 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E1C3720972D;
        Mon,  3 Apr 2023 18:26:40 +0200 (CEST)
Received: from localhost (10.201.21.178) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Mon, 3 Apr
 2023 18:26:38 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v2] dt-bindings: remoteproc: st,stm32-rproc: Typo fix
Date:   Mon, 3 Apr 2023 18:24:23 +0200
Message-ID: <20230403162423.3325968-1-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.178]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_13,2023-04-03_03,2023-02-09_01
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix "communnication" typo error.

Fixes: aca8f94e5b69 ("dt-bindings: remoteproc: stm32-rproc: add new mailbox channel for detach")
Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
updates vs V1: address Krzysztof comments
- Add missing "st,stm32-rproc" device prefix in subject
- Drop line break between "Fixes" and "Signed-off-by"
- Add Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/remoteproc/st,stm32-rproc.yaml        | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
index 66b1e3efdaa3..ff95648f4967 100644
--- a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
@@ -72,9 +72,9 @@ properties:
               ready for shutdown
       - description: |
           A channel (d) used by the local proc to notify the remote proc that it
-          has to stop interprocessor communnication.
+          has to stop interprocessor communication.
           Unidirectional channel:
-            - from local to remote, where ACK from the remote means that communnication
+            - from local to remote, where ACK from the remote means that communication
               as been stopped on the remote side.
     minItems: 1
 
-- 
2.25.1

