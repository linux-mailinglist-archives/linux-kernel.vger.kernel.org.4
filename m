Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F0D63F286
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbiLAORG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiLAOQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:16:50 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D32EC773A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 06:16:47 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id r7so1961177pfl.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 06:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbPGPAIi0isMdoE0z4k6H2LnC1A8GtyTgAXJMtQTO78=;
        b=ufvToVa5IkWraBoaTPmAvV5DvUhTgt+q1SFomWqG1EBBU+6OQx8Oah5hzXQ8vVQYws
         2cvdCyCp5/0b6hSnwPcf7uRlpZSCColhnCyzUsW00cixF3B9ZFLzD+BSt6g+1aqzpune
         1rYx3IDTX6Dhi6hyka3CGQDuLgXd/ua7MF2Po9yLjJrsb7UuGCHpb3c50ey1n7JxOyLn
         tTml3jRuHgtaeUY9m1rOBxkrMPh0ubjTOpZUbxsO2VHZSz2bq0IcNHiJF2yvVI3SBbrZ
         4HxH0u9Qu6bYC1oM8Pti55/NWWCd8hw6Nj7Zthh61CLsJbpM7GpTWm0MOlR5pIP/vq6L
         6ndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbPGPAIi0isMdoE0z4k6H2LnC1A8GtyTgAXJMtQTO78=;
        b=DUCLy4icUGytMrJ7iWam3K7h7R1td7Fwgz63r0mHoRXegbzyb2HFHt2MZF4o0NWBhu
         kvKlG6QbFV7ZaD2vzugWtNZRRzcVI2sE499FOtZqASdjQtg1eS1jLOF/2TiJZHOn2pCZ
         1cdpgKHNtyB6iy8lAPbWSRijE3hVVf5u22NCgMLwAOxrNvGHQcQElcAY/wlNbe2VNcq3
         bUKtLXKNT6k75gfWfihLjgTwUW+8eOnf6ff+H246Z7Ap1QmkZiqaDBZ/+G+kKvnRNTBX
         TboNAbz5lFGZrY1kNTqSPqljQo4ESXpzvBRK9tDpDLbbwx+CktIjEw+1OJN3FC5cGCDD
         W6Qw==
X-Gm-Message-State: ANoB5pk+fqgJGU64xJfo35wQBqegejKcBshOG/OxILtiRdfRzFTRXaIT
        DUoEZSwM+FU4Bzl5XG1ORXQ0vQ==
X-Google-Smtp-Source: AA0mqf6wK4FApSY882RUW0IFdDzpJRGpItthpoBtBuoxFxInI3eavxHBziwgVrfV01Jd62+ZQRnwyg==
X-Received: by 2002:a63:d516:0:b0:477:857d:d264 with SMTP id c22-20020a63d516000000b00477857dd264mr40708942pgg.224.1669904206567;
        Thu, 01 Dec 2022 06:16:46 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1c61:2814:c945:522d:e948:beb1])
        by smtp.gmail.com with ESMTPSA id f2-20020a170902ff0200b0018975488514sm3663041plj.126.2022.12.01.06.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 06:16:46 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        a39.skl@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH 4/4] soc: qcom: socinfo: Add SM6115 / SM4250 SoC IDs to the soc_id table
Date:   Thu,  1 Dec 2022 19:46:19 +0530
Message-Id: <20221201141619.2462705-5-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221201141619.2462705-1-bhupesh.sharma@linaro.org>
References: <20221201141619.2462705-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SoC ID table entries for the SM6115 / SM4250 and variants.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/soc/qcom/socinfo.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 92b27db60840..8f9e3d0e0526 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -328,11 +328,13 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(IPQ8071A) },
 	{ qcom_board_id(IPQ6018) },
 	{ qcom_board_id(IPQ6028) },
+	{ qcom_board_id(SM4250) },
 	{ qcom_board_id(IPQ6000) },
 	{ qcom_board_id(IPQ6010) },
 	{ qcom_board_id(SC7180) },
 	{ qcom_board_id(SM6350) },
 	{ qcom_board_id(SM8350) },
+	{ qcom_board_id(SM6115) },
 	{ qcom_board_id(SC8280XP) },
 	{ qcom_board_id(IPQ6005) },
 	{ qcom_board_id(QRB5165) },
@@ -340,6 +342,8 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(SM7225) },
 	{ qcom_board_id(SA8295P) },
 	{ qcom_board_id(SA8540P) },
+	{ qcom_board_id(QCM4290) },
+	{ qcom_board_id(QCS4290) },
 	{ qcom_board_id_named(SM8450_2, "SM8450") },
 	{ qcom_board_id_named(SM8450_3, "SM8450") },
 	{ qcom_board_id(SC7280) },
-- 
2.38.1

