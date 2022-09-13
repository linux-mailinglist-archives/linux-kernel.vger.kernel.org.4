Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1335B7B6A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 21:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiIMTck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 15:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiIMTcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 15:32:00 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1C57A744;
        Tue, 13 Sep 2022 12:30:25 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id j12so12685448pfi.11;
        Tue, 13 Sep 2022 12:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=D2vwqOzav4CEoHkfQCGRtdC0GM50sPPilT94bMdUvjM=;
        b=nJFfUaF6joYDViuPYmXJaqGEJlU0aKCjzkr3/uyMC9FR9ZUCeiU6lS3mrMfSS4Go1o
         SiSkoNKE5R5ET4HWPIxeSzfuZgImw9+hHPVK9fBD5/+vDZuxA6jiHw3bo5kTF1+dBQlZ
         TS5umc5ag+/UI6pTHh1WG/To4VnRbxq/HQMSmSibFcAd18PhSLFnoVDh3J1KshAha1a+
         wnA3bj6xcYuGGGl5RmHg4N+U8HDwZBujWXcw9F9BcT6w/pyKeXoraOqfxIPp0UBloZfH
         uhlRMsg/kK6lgUpYpf02ev2ooi2sdcIqQuTMVpnWhp4CA3G3H2zEQNKuP88vZcHWhggU
         bTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=D2vwqOzav4CEoHkfQCGRtdC0GM50sPPilT94bMdUvjM=;
        b=cjHFAWIo6yh2HlgZHwt25edT0QduAWXcDxsb7x0TJHHjU9hf0A1nVy/HzXx2x25hai
         sfEnzU+/htRgf/IAB4vvrhDfrTNuDBhVsDujNieWMcq8Tg7bM8m03ntwbDiN9TqzvZn0
         d4/VklwrMRi4Xnz/jO+OL2+4sw3gqceEXfvqqkeDTrLbGSP3YTPvyOINSxCVhRE8t+ZN
         uvAc5Nqd/jikFs/ygBveoJcrJK7ZfBCYU5z2yXn/NVy3IauYS7BQg8XDcz7QKr12hEvt
         AUsyJrOkf8clJGGTQQaRK8wHDMVTFr8Ec2jxi6wFyO7kE2FiMVj/nM2PL6Whm5l7IX1V
         SEVg==
X-Gm-Message-State: ACgBeo3Knd1daRFQ3gF3JmZFYWhkDfRJj16LfMAsJyBS0JfIOrph4/vN
        0Cz+OoylR73ltQKkEYbHbwk=
X-Google-Smtp-Source: AA6agR4QP3iZF1NpQyf3yZ97OjjUp3qIeT9bmLCVv/nJPirFI2hu6uRzc7OSRX8F7zr9GTrDGaNmKw==
X-Received: by 2002:a63:80c6:0:b0:438:d512:e87c with SMTP id j189-20020a6380c6000000b00438d512e87cmr13605581pgd.619.1663097425170;
        Tue, 13 Sep 2022 12:30:25 -0700 (PDT)
Received: from ritvixpc.. ([2405:201:5c0b:6821:308b:e0f8:702c:13e6])
        by smtp.gmail.com with ESMTPSA id r18-20020a170902c7d200b001745662d568sm8641452pla.278.2022.09.13.12.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:30:24 -0700 (PDT)
From:   Ritwik Sahani <ritwik.shn.dev@gmail.com>
Cc:     Ritwik Sahani <ritwik.shn.dev@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] media: atomisp: move trailing statements to next line
Date:   Wed, 14 Sep 2022 00:59:32 +0530
Message-Id: <20220913192933.31694-1-ritwik.shn.dev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adhere to Linux kernel coding style.

Reported by checkpatch:
ERROR: trailing statements should be on next line

Signed-off-by: Ritwik Sahani <ritwik.shn.dev@gmail.com>
---
 .../hive_isp_css_common/host/input_system.c    | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/input_system.c b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/input_system.c
index 712e01c37870..4b426d938586 100644
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/input_system.c
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/input_system.c
@@ -878,7 +878,8 @@ static input_system_err_t input_system_configure_channel(
 			return INPUT_SYSTEM_ERR_PARAMETER_NOT_SUPPORTED;
 		}
 
-		if (error != INPUT_SYSTEM_ERR_NO_ERROR) return error;
+		if (error != INPUT_SYSTEM_ERR_NO_ERROR)
+			return error;
 		// Input switch channel configurations must be combined in united config.
 		config.input_switch_cfg.hsync_data_reg[channel.source_cfg.csi_cfg.csi_port * 2]
 		    =
@@ -1586,13 +1587,15 @@ static input_system_err_t input_system_configure_channel_sensor(
 
 	status = set_source_type(&config.source_type, channel.source_type,
 				 &config.source_type_flags);
-	if (status != INPUT_SYSTEM_ERR_NO_ERROR) return status;
+	if (status != INPUT_SYSTEM_ERR_NO_ERROR)
+		return status;
 
 	// Check for conflicts on source (implicitly on multicast, capture unit and input buffer).
 
 	status = set_csi_cfg(&config.csi_value[port], &channel.source_cfg.csi_cfg,
 			     &config.csi_flags[port]);
-	if (status != INPUT_SYSTEM_ERR_NO_ERROR) return status;
+	if (status != INPUT_SYSTEM_ERR_NO_ERROR)
+		return status;
 
 	switch (channel.source_cfg.csi_cfg.buffering_mode) {
 	case INPUT_SYSTEM_FIFO_CAPTURE:
@@ -1601,7 +1604,8 @@ static input_system_err_t input_system_configure_channel_sensor(
 		mux = INPUT_SYSTEM_MIPI_PORT0 + port;
 		status = input_system_multiplexer_cfg(&config.multiplexer, mux,
 						      &config.multiplexer_flags);
-		if (status != INPUT_SYSTEM_ERR_NO_ERROR) return status;
+		if (status != INPUT_SYSTEM_ERR_NO_ERROR)
+			return status;
 		config.multicast[port] = INPUT_SYSTEM_CSI_BACKEND;
 
 		// Shared resource, so it should be blocked.
@@ -1616,7 +1620,8 @@ static input_system_err_t input_system_configure_channel_sensor(
 		mux = INPUT_SYSTEM_ACQUISITION_UNIT;
 		status = input_system_multiplexer_cfg(&config.multiplexer, mux,
 						      &config.multiplexer_flags);
-		if (status != INPUT_SYSTEM_ERR_NO_ERROR) return status;
+		if (status != INPUT_SYSTEM_ERR_NO_ERROR)
+			return status;
 		config.multicast[port] = INPUT_SYSTEM_INPUT_BUFFER;
 
 		// Shared resource, so it should be blocked.
@@ -1631,7 +1636,8 @@ static input_system_err_t input_system_configure_channel_sensor(
 		mux = INPUT_SYSTEM_ACQUISITION_UNIT;
 		status = input_system_multiplexer_cfg(&config.multiplexer, mux,
 						      &config.multiplexer_flags);
-		if (status != INPUT_SYSTEM_ERR_NO_ERROR) return status;
+		if (status != INPUT_SYSTEM_ERR_NO_ERROR)
+			return status;
 		config.multicast[port] = INPUT_SYSTEM_INPUT_BUFFER;
 
 		// Shared resource, so it should be blocked.
-- 
2.34.1

