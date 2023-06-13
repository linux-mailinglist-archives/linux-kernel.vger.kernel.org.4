Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED4272E4DE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242642AbjFMODY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242605AbjFMODQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:03:16 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565D5EC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:03:15 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f61735676fso6965957e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686664993; x=1689256993;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SD+82Kp64qdWpl/p0nHwxIb/l/7wz0DuQnwuSSdR/H4=;
        b=xj0xlSeCPhw5AxVZORqoblYLF2f8uDEmnpl5KdIW7yvz3l3wcasDuEnC4W1e63Tlyt
         310F6tlPgqNLQ49PR8DgDkil1BjnqR/gBK3ghiV9KAWxME1vk352EWKGzGxGNKWOFoek
         eFDIR5tbtt+tNRvEB0hQwa55nzfO+mkjob07pS46OpnWC1tk81qKYZWEcvnBuc/vCy9U
         gIpanrcKM6Zwr4ew/lIQdSIZDjwkpOJq91SSU3wq3q1NpxM0+aFxN1btmUxE/wCNXW3p
         GLE4UM5JiocXYnlDoxH26S1QhLJfWOub1IUgp1JylTkVwCrn+iGujvr40TwZBO+NuETz
         Cfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686664993; x=1689256993;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SD+82Kp64qdWpl/p0nHwxIb/l/7wz0DuQnwuSSdR/H4=;
        b=CCWYcLVTl20yBzghUaPcnV20nQ5rAqcW6zXNZYodhj5AzuN8laLJeNYLab1dPjPE59
         raks5bciZaT5Gf4MsuO3Oy/dME+WQBOXJ55taGsKgJqLZjMW7w/xkpsRaEQJ9N/UghGs
         9hBYBBnmYZnBIHPMIpYLPg64jwkr6uaSFG+bCLzS+8oejS09hdizNdouDFFWFFP9tGMQ
         BYu6Qt2wOivfX5+tpWFukgDIkpIidMfdcIEUvdoL2fJcDxtU83wGmO74kzaNS8XQe7EN
         yQRlAZE++oUex0jTKHhR9z/VU+M6DsLxBtExOqcGYJpQtu7i1DSKWvr9YUa4I7DA/K8m
         2V0A==
X-Gm-Message-State: AC+VfDyC37pgf4avENokPtWLtlA/Pgx5a4OPM1+mM1UwRmG7TQRfdBya
        Zpx0+6mInnUe5PKI4ti6gkI9ug==
X-Google-Smtp-Source: ACHHUZ4jJ9jeHuvL/oUVggWU+lb/Tql+Z/RsGUdCZRwl7wGbtNPjiAYUWW6kFh7AprExSrksK+bzBQ==
X-Received: by 2002:a2e:4949:0:b0:2b1:be22:4741 with SMTP id b9-20020a2e4949000000b002b1be224741mr4652288ljd.51.1686664993643;
        Tue, 13 Jun 2023 07:03:13 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id a18-20020a05651c011200b002b32af2e9c6sm901490ljb.116.2023.06.13.07.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 07:03:13 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 13 Jun 2023 16:03:03 +0200
Subject: [PATCH v4 03/22] soc: qcom: smd-rpm: Use tabs for defines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v4-3-5ba82b6fbba2@linaro.org>
References: <20230526-topic-smd_icc-v4-0-5ba82b6fbba2@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v4-0-5ba82b6fbba2@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686664985; l=691;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=7uAPa6YDjXHLJZjqpcpTS8PIWFtwDRP9qtCSKC7URyY=;
 b=3QxTLVHO4Nr6bVB2frFdYaQedokBMp38qiprqfH/uJfbdIhUt5gKU6UxggRbV2D7R4kUa8Pkp
 Bx/In/tt5kvBMujWMNlvZkL5UPROUqK5TZgTKvBRxbQetqOqRAhjTlH
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use tabs for defines to make things spaced consistently.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 include/linux/soc/qcom/smd-rpm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/soc/qcom/smd-rpm.h b/include/linux/soc/qcom/smd-rpm.h
index e468f94fa323..99499e4b080e 100644
--- a/include/linux/soc/qcom/smd-rpm.h
+++ b/include/linux/soc/qcom/smd-rpm.h
@@ -4,8 +4,8 @@
 
 struct qcom_smd_rpm;
 
-#define QCOM_SMD_RPM_ACTIVE_STATE        0
-#define QCOM_SMD_RPM_SLEEP_STATE         1
+#define QCOM_SMD_RPM_ACTIVE_STATE	0
+#define QCOM_SMD_RPM_SLEEP_STATE	1
 #define QCOM_SMD_RPM_STATE_NUM		2
 
 /*

-- 
2.41.0

