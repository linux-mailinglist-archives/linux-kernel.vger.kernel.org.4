Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8823460E8AE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbiJZTK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbiJZTIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:08:09 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341F1E03C;
        Wed, 26 Oct 2022 12:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1666811164; x=1698347164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xZHRSYU+yjUm2moVhdX98BqavTAaOK2uHU2d/+rjVqs=;
  b=SiMX0I+mVHU6SKwcdC2N5LWsqJsIKwiDPcwneJpPHdDcmyz+bH7f/BBB
   N6dKoBEoYzrp/RyKNVZ927995jkDusRw5WpjJaIpJzeLRO+qg4UyVg8sT
   ALYPDoqmggamKyjw2VZjvvnR/xoUPeU3WblWGjrfnbWIM/zl3cLusgP0f
   0=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Oct 2022 12:06:03 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 12:06:03 -0700
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 26 Oct 2022 12:06:03 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH v3 4/5] dt-bindings: arm: qcom,ids: Add SoC IDs for QDU1000/QRU1000
Date:   Wed, 26 Oct 2022 12:05:48 -0700
Message-ID: <20221026190549.4005703-5-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026190549.4005703-1-quic_molvera@quicinc.com>
References: <20221026190549.4005703-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SoC IDs for Qualcomm QDU1000 and QRU1000 platforms and their
variants.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 include/dt-bindings/arm/qcom,ids.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index 755e08d494c5..8b1a0f43bd93 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -140,6 +140,12 @@
 #define QCOM_ID_SC7280			487
 #define QCOM_ID_SC7180P			495
 #define QCOM_ID_SM6375			507
+#define QCOM_ID_QRU1000			539
+#define QCOM_ID_QDU1000			545
+#define QCOM_ID_QDU1010			587
+#define QCOM_ID_QRU1032			588
+#define QCOM_ID_QRU1052			589
+#define QCOM_ID_QRU1062			590
 
 /*
  * The board type and revision information, used by Qualcomm bootloaders and
-- 
2.25.1

