Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056DE710BCC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241159AbjEYMKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240900AbjEYMKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:10:06 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4324813A;
        Thu, 25 May 2023 05:10:05 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-96f683e8855so82446066b.2;
        Thu, 25 May 2023 05:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685016604; x=1687608604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpOWhP8DxFONC41kTCdHjaq2c0kscoG17qr+mKyv86Y=;
        b=GOUtwfzPxtELqg3Ri36VE60/4NTg/iDdprk4djIdIXaitecB7GeUQUitlaVHTKL3FG
         WvY9g097lOTq9vdGSb4bKKl2GAyda+Blrko6ZYKOpF+LCPzWieRXvRbpi5sHHs5uwzSR
         vJPf7S6U+DxcRKRxLMGPBX2DT6keND7DbBTs0THzj1YqW9IZVZAXbqg6FOvP2VLA7uim
         nCSoxfVTf/HhHidvPFjOg5IiXQZ+buZh59Ns1yzOtbo4dvguBXUTUfx2M6Arab3R4Avh
         lMW7pQce1DzjwBxycTv4lgNTeUjR5JDQfvlYDRyYWfYGG0WxkjF9Kx+5a/Xo2EE1T1q/
         4WXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685016604; x=1687608604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpOWhP8DxFONC41kTCdHjaq2c0kscoG17qr+mKyv86Y=;
        b=VobwFHxlTsEnQYlCfkcxftQFhuimHWrnnSCKajTFQEmBbJooz3jje1tq/thuGQdvU0
         W73GAwnkMyEmvcDnAjhqQDMVJlcGoKITIUm5HCoc5CcVh6ax5uPyhSVnFFhEVV7VvdoS
         1Ao7Ryi8a9VMiwAqEPsI3sTUWx2h+2wWrrI4J3kz4s4GgplBxssJJFD7x2IifdW80PVk
         R/VZhubSsHcVdIqpu+TV7qwuG0Wc5+R7k7vzRYuRydnqy9s7xRFXFzuPdw1nuzUK5bSQ
         mzXsSsbIiOXbuNhogWfkYd6AjUSpffcM27vcmWAU6hW3ztSzGwmEo5qgVI/IwzZD+kwV
         +8Xw==
X-Gm-Message-State: AC+VfDxJo3SvkkIik1xgFCKfKf0mQe2qthPnFyzvz6zj6nmg63szL3Ih
        mny03eCptWnKEM6lZdJbPJI=
X-Google-Smtp-Source: ACHHUZ50n76LIZs5UAkNr6F2AbByhk+nIMIaLjRQ81Lo8S/DtZSCxZNV9AALDZRRc2ID3xJQ4T4hcQ==
X-Received: by 2002:a17:907:948f:b0:967:769e:a098 with SMTP id dm15-20020a170907948f00b00967769ea098mr1209262ejc.15.1685016603673;
        Thu, 25 May 2023 05:10:03 -0700 (PDT)
Received: from fedora.. ([213.149.38.146])
        by smtp.googlemail.com with ESMTPSA id d5-20020a170906640500b0094ef923a6ccsm765216ejm.219.2023.05.25.05.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 05:10:03 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     ansuelsmth@gmail.com, Robert Marko <robimarko@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v3 4/5] cpufreq: qcom-nvmem: use SoC ID-s from bindings
Date:   Thu, 25 May 2023 14:09:55 +0200
Message-Id: <20230525120956.3095317-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525120956.3095317-1-robimarko@gmail.com>
References: <20230525120956.3095317-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMEM SoC ID-s are now stored in DT bindings so lets use those instead of
defining them in the driver again.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index a577586b23be..60e99be2d3db 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -31,12 +31,7 @@
 
 #define MSM_ID_SMEM	137
 
-enum _msm_id {
-	MSM8996V3 = 0xF6ul,
-	APQ8096V3 = 0x123ul,
-	MSM8996SG = 0x131ul,
-	APQ8096SG = 0x138ul,
-};
+#include <dt-bindings/arm/qcom,ids.h>
 
 enum _msm8996_version {
 	MSM8996_V3,
@@ -154,12 +149,12 @@ static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
 	msm_id++;
 
 	switch ((enum _msm_id)*msm_id) {
-	case MSM8996V3:
-	case APQ8096V3:
+	case QCOM_ID_MSM8996:
+	case QCOM_ID_APQ8096:
 		version = MSM8996_V3;
 		break;
-	case MSM8996SG:
-	case APQ8096SG:
+	case QCOM_ID_MSM8996SG:
+	case QCOM_ID_APQ8096SG:
 		version = MSM8996_SG;
 		break;
 	default:
-- 
2.40.1

