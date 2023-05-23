Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3414570D56B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbjEWHma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235327AbjEWHm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:42:28 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A063C5;
        Tue, 23 May 2023 00:42:24 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N41JOv005315;
        Tue, 23 May 2023 09:42:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=9KXPbntQJjThryM7ZH+pOmBiljxCSklz9zzzhSCRtqg=;
 b=vzn1lJK0lbm2qCgl4ZlUV3WkI6TBP5LXnDCzBKN3h5AMCc4l89PALKf0inFqgHv3GNIb
 FyTU3E6hOFkgVYlWPhq48V0jHVMNhLnzywb8QgX7fUoiMXsKUMPl8CWonDg9+P+2khI2
 qPAfrNdkIosUy5McwJb6O9+tdb66W69dDFsgtv+SZw3Lv5ZaTM6fMbKJ0s+xPcPgijHh
 tGnPM+cCCAmTgFF4PM45QK4x5/cHFkFntylMC1uKsACtF1j9L3zsjZSa+4Giko/a2mDQ
 CfKAVweB9JHSgRXbA8vRh15ovPlmdrB66LZLE4PtRPdSgZy0ny3jgcSWUb67PqFTOvJ4 dg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qpnj1fkaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 09:42:12 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DA7A910002A;
        Tue, 23 May 2023 09:42:11 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BF2B221ADC9;
        Tue, 23 May 2023 09:42:11 +0200 (CEST)
Received: from localhost (10.201.22.238) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 23 May
 2023 09:42:10 +0200
From:   <p.paillet@foss.st.com>
To:     <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Pascal Paillet <p.paillet@foss.st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: mfd: add vref_ddr supply for STPMIC1
Date:   Tue, 23 May 2023 09:42:06 +0200
Message-ID: <20230523074206.201962-1-p.paillet@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.22.238]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_04,2023-05-22_03,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pascal Paillet <p.paillet@foss.st.com>

Add vref_ddr supply description for the STPMIC1.

Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
---
 Documentation/devicetree/bindings/mfd/st,stpmic1.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
index 9573e4af949e..97c61097f9e2 100644
--- a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
+++ b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
@@ -184,7 +184,7 @@ properties:
         additionalProperties: false
 
     patternProperties:
-      "^(buck[1-4]|ldo[1-6]|boost|pwr_sw[1-2])-supply$":
+      "^(buck[1-4]|ldo[1-6]|vref_ddr|boost|pwr_sw[1-2])-supply$":
         description: STPMIC1 voltage regulators supplies
 
       "^(buck[1-4]|ldo[1-6]|boost|vref_ddr|pwr_sw[1-2])$":
-- 
2.25.1

