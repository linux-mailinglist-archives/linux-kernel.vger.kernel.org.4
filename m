Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A409D7098D8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 15:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjESN6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 09:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbjESN6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 09:58:19 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA571AD
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 06:58:15 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d24136663so1251402b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 06:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684504695; x=1687096695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KlUcxwV3gHbaA4F0tBqjLsI2LgjbYmHKZKwiT7gbhio=;
        b=gyQPvSS053XBYCQ+ulxO8jW8Fmtq1OHPBkIElOynEB24rNWum9fd4vNcGVumCLQXHr
         H0lHQIY4KR77DtaPP+1Pqc3orpKb5wJCzyOMlsFVsKJM3elUlcrYz+Yji8FmZXl+mIHi
         zgO5cYxUO8SnLM4MUgrFSOqdDDWqwoES4wUMXLI++QZ35Yb+yv45TlScA6FPoRp49aQR
         T0e6Yl9Sq/nopmZSvgSqqSitQNGtePYTeAXih5RAU48oohyWoz6W6sUpDez8EvZrsXbZ
         WgONjcXu+KFY6fxAegXn1eMfobcpNUElTWVjXGII/LR1IyHBnQGlnMHN6BeDBl11uVlI
         0jTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684504695; x=1687096695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KlUcxwV3gHbaA4F0tBqjLsI2LgjbYmHKZKwiT7gbhio=;
        b=OWBeMv5SSE8JzanBoQMl0S20snrNPIm6OodLMgcEYH9ZNp+gcf9Fdr3xROhXQuMYwy
         A8w1D9d9lcQofT2yz4kAnka76tqhYDI8o87OUITHhJOiqp6NTFIn+GASGbN9mxWYGdYC
         y8DO9udEAPEtSa3SoRjZDH7NDVwQKe7R4/1EctWBVrdmUs8gWp+j2VCKKitVhH+hEZtw
         99fjvtBTBx2vszJi8Xnn7oXAwF8wgA5xNbUT50VccRcbwaGlUhW/0lJy9ohn6U+I0gm0
         6E6ayH/0J15dhw12yl3YRdM6pXay+wGK/71x9mV4h0zS4G/1Fprbs1flmbKSDxoCYvQZ
         MHsw==
X-Gm-Message-State: AC+VfDx+hIJNQzqakTo+CZeLfEUCPOg9B3Ut4HkdFSV71V11O7UDpoJh
        EAJjVgPLx9EHeBVb8nzr5Wil
X-Google-Smtp-Source: ACHHUZ4/BIkQFVCK8F94/Uf3Z9uqkLZjy+JIWTSYU7oAl3bKx61PWCnAyinFjETqy7PbT/rCJ/s3gw==
X-Received: by 2002:a05:6a20:72a8:b0:100:c7bd:9f5d with SMTP id o40-20020a056a2072a800b00100c7bd9f5dmr2169335pzk.44.1684504695128;
        Fri, 19 May 2023 06:58:15 -0700 (PDT)
Received: from localhost.localdomain ([117.202.184.13])
        by smtp.gmail.com with ESMTPSA id i3-20020a63e443000000b0052873a7cecesm3112096pgk.0.2023.05.19.06.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 06:58:14 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     loic.poulain@linaro.org, quic_krichai@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] bus: mhi: host: pci_generic: Add support for IP_SW0 channels
Date:   Fri, 19 May 2023 19:28:03 +0530
Message-Id: <20230519135803.13850-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IP_SW0 channels are used to transfer data over the networking interface
between MHI endpoint and the host. Define the channels in the MHI v1
channel config along with dedicated event rings.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/host/pci_generic.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index db0a0b062d8e..70e37c490150 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -212,6 +212,19 @@ struct mhi_pci_dev_info {
 		.offload_channel = false,	\
 	}
 
+#define MHI_EVENT_CONFIG_SW_DATA(ev_ring, el_count) \
+	{					\
+		.num_elements = el_count,	\
+		.irq_moderation_ms = 0,		\
+		.irq = (ev_ring) + 1,		\
+		.priority = 1,			\
+		.mode = MHI_DB_BRST_DISABLE,	\
+		.data_type = MHI_ER_DATA,	\
+		.hardware_event = false,	\
+		.client_managed = false,	\
+		.offload_channel = false,	\
+	}
+
 #define MHI_EVENT_CONFIG_HW_DATA(ev_ring, el_count, ch_num) \
 	{					\
 		.num_elements = el_count,	\
@@ -237,8 +250,10 @@ static const struct mhi_channel_config modem_qcom_v1_mhi_channels[] = {
 	MHI_CHANNEL_CONFIG_DL_AUTOQUEUE(21, "IPCR", 8, 0),
 	MHI_CHANNEL_CONFIG_UL_FP(34, "FIREHOSE", 32, 0),
 	MHI_CHANNEL_CONFIG_DL_FP(35, "FIREHOSE", 32, 0),
-	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0", 128, 2),
-	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0", 128, 3),
+	MHI_CHANNEL_CONFIG_UL(46, "IP_SW0", 64, 2),
+	MHI_CHANNEL_CONFIG_DL(47, "IP_SW0", 64, 3),
+	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0", 128, 4),
+	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0", 128, 5),
 };
 
 static struct mhi_event_config modem_qcom_v1_mhi_events[] = {
@@ -246,9 +261,12 @@ static struct mhi_event_config modem_qcom_v1_mhi_events[] = {
 	MHI_EVENT_CONFIG_CTRL(0, 64),
 	/* DIAG dedicated event ring */
 	MHI_EVENT_CONFIG_DATA(1, 128),
+	/* Software channels dedicated event ring */
+	MHI_EVENT_CONFIG_SW_DATA(2, 64),
+	MHI_EVENT_CONFIG_SW_DATA(3, 64),
 	/* Hardware channels request dedicated hardware event rings */
-	MHI_EVENT_CONFIG_HW_DATA(2, 1024, 100),
-	MHI_EVENT_CONFIG_HW_DATA(3, 2048, 101)
+	MHI_EVENT_CONFIG_HW_DATA(4, 1024, 100),
+	MHI_EVENT_CONFIG_HW_DATA(5, 2048, 101)
 };
 
 static const struct mhi_controller_config modem_qcom_v1_mhiv_config = {
-- 
2.25.1

