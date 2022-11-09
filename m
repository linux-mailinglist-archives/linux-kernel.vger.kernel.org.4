Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A08C622779
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiKIJtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiKIJtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:49:11 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445A9CE3E;
        Wed,  9 Nov 2022 01:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1667987350; x=1699523350;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=JJm0Pn/xZJgBjOffOFVfDzPGawzaO0ZX2sFfqGf0yrQ=;
  b=sW3IDAD/7klZqiiB8OOuB+6oeG6JxwE4zCSosq2g3T+gEQkLlEjO+rOv
   WrZWF3LJXEZPYu5jYvCHo8cMrFt07ByVumnifYXAqtTBfO1IfShhjcekW
   Qch8+suethd9C58Gx3E/SAWfjZXxEZF8AoIA7jDQ0x4DPIVstPcOXzHNg
   M=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Nov 2022 01:49:08 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 01:49:06 -0800
Received: from hu-arandive-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 9 Nov 2022 01:49:03 -0800
From:   Aniket Randive <quic_arandive@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>,
        <quic_ramkri@quicinc.com>,
        Aniket Randive <quic_arandive@quicinc.com>
Subject: [RESEND V1] soc: qcom: geni: Add SPI Slave protocol type
Date:   Wed, 9 Nov 2022 15:18:46 +0530
Message-ID: <1667987326-13970-1-git-send-email-quic_arandive@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "GENI_SE_SPI_SLAVE" entry in enum which represents the
protocols supported by GENI Serial Engines. This is needed
to support the SPI slave feature on QUP based target.

Signed-off-by: Aniket Randive <quic_arandive@quicinc.com>
---
 include/linux/qcom-geni-se.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
index f567278..9fb2175 100644
--- a/include/linux/qcom-geni-se.h
+++ b/include/linux/qcom-geni-se.h
@@ -35,6 +35,7 @@ enum geni_se_protocol_type {
 	GENI_SE_UART,
 	GENI_SE_I2C,
 	GENI_SE_I3C,
+	GENI_SE_SPI_SLAVE,
 };
 
 struct geni_wrapper;
-- 
2.7.4

