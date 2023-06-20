Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDD973633D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 07:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjFTFkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 01:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjFTFks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 01:40:48 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C096710D5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 22:40:47 -0700 (PDT)
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6D4134139E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 05:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1687239644;
        bh=eKxatBk/Yyq4Kcp78eUZOCU8RQk/O3McJworAZUfA7k=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=aakmGydiu4R5fSPdpuWPAOsmbMut+1PG0yt+dFWV8VgX/2id5c0kIAhqX4ktxle6+
         eEeG23VPpu8VB08UvQhtsdkRGRwdTJsJcaUJl88mmChI21kXnsUuIqNdmHuep8DQ8l
         KqUSe2wCX+Uhm3KxEtlnFvQC86zugNSIZlmmvekvMVKmcyVCZqeRaTk07P0hKSP8tk
         Dhq2+Qtt8Uw04smPvobEXAxzBcu+jb58V68GF6GkPO8ffhJMOsamWtp2Rg0zoL/cZx
         0WoZZor1XXwuCC15EwHz09ki0nsx0ZLtMKeC0jubm466wBvYcgxkScWMWLD68Bul6R
         NzJ2oGl9m9Dow==
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4f01644f62eso2667588e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 22:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687239641; x=1689831641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKxatBk/Yyq4Kcp78eUZOCU8RQk/O3McJworAZUfA7k=;
        b=a2GPS5942BX2aYkDDNtiTnv04YV6Gt6zKWNpfFiypoA2FozAMOoVif4yL1Z7m3y6JB
         uwA2JDef8sWGdPwxWouAKMobTvV8qPxcRJyojGcYwjW9Ax5yEQIvtIQZr8c4Ja6u4YRZ
         bQcL9FmkhQ0qfCy3D/HDlc45P6lXhBDrGczf6YEN0zhJ6OVKrP+CjzLng7roHRElBv0J
         QUuaO6JT4thLBqpK9mBf0vlLy97nLG09EagTVituN+iKB8vCMt2KyWl8XZyb09ApnLeh
         7psNwnqv5YehvfkgYrzl90mRKO4FmXCsb7Zq9HISI4ZQ0kE+/+xmc05JTUtfqwwlNVj8
         dvvA==
X-Gm-Message-State: AC+VfDzUVYKqQHoVm35HatDsk57Z7qEn+92n4zDV+Fvz60O2IQwG8EF2
        iU9FCQuXV0MBklVqBtx38H2h/AXFkzEfTP+lSb8cvOPfAfnZaBLX1Gthdcbqu5Ja9rmysFcaxwb
        5ZLxUevAk2o1tRL5wowB8gx3WSFlbN3AfT4zsSdbr3Q==
X-Received: by 2002:ac2:499e:0:b0:4f8:6f40:4776 with SMTP id f30-20020ac2499e000000b004f86f404776mr2610349lfl.46.1687239641133;
        Mon, 19 Jun 2023 22:40:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7mAmYRUNcTRvaEpgafMNWbpCh84NFbi5qKXny7yAHkhYQctNPgq9IskSasfT3ZfXza5M/jjg==
X-Received: by 2002:ac2:499e:0:b0:4f8:6f40:4776 with SMTP id f30-20020ac2499e000000b004f86f404776mr2610336lfl.46.1687239640866;
        Mon, 19 Jun 2023 22:40:40 -0700 (PDT)
Received: from localhost ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id m12-20020a7bcb8c000000b003f7ea771b5dsm1433746wmi.1.2023.06.19.22.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 22:40:40 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     juerg.haefliger@canonical.com
Cc:     airlied@gmail.com, daniel@ffwll.ch, dmitry.baryshkov@linaro.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        joel@joelfernandes.org, johan+linaro@kernel.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_abhinavk@quicinc.com,
        quic_akhilpo@quicinc.com, ribalda@chromium.org,
        robdclark@gmail.com, sean@poorly.run
Subject: [PATCH v2] drm/msm/adreno: Add missing MODULE_FIRMWARE macros
Date:   Tue, 20 Jun 2023 07:40:31 +0200
Message-Id: <20230620054031.1203960-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230616122815.1037425-1-juerg.haefliger@canonical.com>
References: <20230616122815.1037425-1-juerg.haefliger@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver references some firmware files that don't have corresponding
MODULE_FIRMWARE macros and thus won't be listed via modinfo. Fix that.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>

---
v2:
  - Drop addition and removal of zap files (needs more discussion)
  - Add new a690_gmu.bin
  - Update commit subject and message accordingly
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index cb94cfd137a8..7c1f9a844009 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -397,10 +397,21 @@ MODULE_FIRMWARE("qcom/a530_zap.mdt");
 MODULE_FIRMWARE("qcom/a530_zap.b00");
 MODULE_FIRMWARE("qcom/a530_zap.b01");
 MODULE_FIRMWARE("qcom/a530_zap.b02");
+MODULE_FIRMWARE("qcom/a540_gpmu.fw2");
 MODULE_FIRMWARE("qcom/a619_gmu.bin");
 MODULE_FIRMWARE("qcom/a630_sqe.fw");
 MODULE_FIRMWARE("qcom/a630_gmu.bin");
 MODULE_FIRMWARE("qcom/a630_zap.mbn");
+MODULE_FIRMWARE("qcom/a640_gmu.bin");
+MODULE_FIRMWARE("qcom/a650_gmu.bin");
+MODULE_FIRMWARE("qcom/a650_sqe.fw");
+MODULE_FIRMWARE("qcom/a660_gmu.bin");
+MODULE_FIRMWARE("qcom/a660_sqe.fw");
+MODULE_FIRMWARE("qcom/a690_gmu.bin");
+MODULE_FIRMWARE("qcom/leia_pfp_470.fw");
+MODULE_FIRMWARE("qcom/leia_pm4_470.fw");
+MODULE_FIRMWARE("qcom/yamato_pfp.fw");
+MODULE_FIRMWARE("qcom/yamato_pm4.fw");
 
 static inline bool _rev_match(uint8_t entry, uint8_t id)
 {
-- 
2.37.2

