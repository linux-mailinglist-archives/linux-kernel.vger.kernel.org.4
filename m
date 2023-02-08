Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C7868EACE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjBHJPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjBHJPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:15:12 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12D0460AD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:13:52 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id dr8so49495805ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 01:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zFpsL7Z7sroK9EcjaH6WVngQRH67YREWwOinR3i/iU=;
        b=RqDXqnw5pvtRcM5XElKb00KsFBrwzoOzMIA97rdTFtO5qrCf2/knc+ABbtCoplcAy/
         vI9EYkSRzKEj2j8NuKEm3l6ETcUMmfO+oLnKpYBk5JycdA9D3TRKEs83ztFJ2qHNRKY+
         da/ikvzMVGN3fASdYaDLuce5ZXfIZavLV46M3wOHFab/2QIAsxCEjBxMvSTCfcMW/Y/b
         OaNESr3o5lH1XwQX0KsoANrXXn8FO+L1Oh3Q2u9BvJKVW59Mz8wwlyCj8ftzDhq/Z3Ta
         hytsCqOGcFXLVAGKoWe+UOvX9SQZCBqdcOo8rs3wrJc4Q1J1ELSho3NTDw1CoSQaUNPR
         360A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zFpsL7Z7sroK9EcjaH6WVngQRH67YREWwOinR3i/iU=;
        b=doJ2nxlYaj9cIj7qm4xsz6LCNYMOuLcPzai66kyFuPt5cAjuEe7J7Dw82KhRJvk4gR
         aPfDvl9hrFSzJiaBc6+9wMPQkKw4L54KaO8nz9JJJ0zScR9HGqIME8bWR1eDbDtQ99dn
         JuFXUXTMNjNAsmDaHzuRMz+fWcq6dvecH5/JGdMsDvjGf0a2Wkyn/E8eIA/SkLEfiNcl
         rFnI0lrr+aEoeyMTvvfj7Pxl0lbOLidhqICC1wL61p7GO/js2nTDkQ355MfPEJEcvhSN
         r68TE202Wtf1g8d07JK8weQwlu4VZU8e1Y5mG+0Whqf10t6hcFNx944L0uFkYamGmvIJ
         IzYQ==
X-Gm-Message-State: AO0yUKWNl+MEmb/XoCQS4IDHqzbLkji+eelP4Hgmce+bqz2d02GWVOzY
        fbUJbzc2hIJCeToDhT+EeTvsGg==
X-Google-Smtp-Source: AK7set+TMOVDnZJ1a7bu738npcfjumWRSe6WOwanwY7gaup9cykx/1dqODjq8dwsLIGcObFFBeKe6A==
X-Received: by 2002:a17:907:204c:b0:7c4:fa17:7203 with SMTP id pg12-20020a170907204c00b007c4fa177203mr6786812ejb.63.1675847630675;
        Wed, 08 Feb 2023 01:13:50 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id z2-20020a1709064e0200b00887a23bab85sm7987279eju.220.2023.02.08.01.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 01:13:50 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 04/10] clk: qcom: branch: Clean up branch enable registers
Date:   Wed,  8 Feb 2023 10:13:34 +0100
Message-Id: <20230208091340.124641-5-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208091340.124641-1-konrad.dybcio@linaro.org>
References: <20230208091340.124641-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefix the "branch enable" registers with CBCR_ to be closer to what
they are actually called in Qualcomm terms, use GENMASK instead of
shifting values around and adjust their usage accordingly.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-branch.c | 10 +++++-----
 drivers/clk/qcom/clk-branch.h |  7 +++----
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
index f2b577b07b7e..ca896ebf7e1b 100644
--- a/drivers/clk/qcom/clk-branch.c
+++ b/drivers/clk/qcom/clk-branch.c
@@ -44,17 +44,17 @@ static bool clk_branch2_check_halt(const struct clk_branch *br, bool enabling)
 	u32 val;
 	u32 mask;
 
-	mask = BRANCH_NOC_FSM_STATUS_MASK << BRANCH_NOC_FSM_STATUS_SHIFT;
-	mask |= BRANCH_CLK_OFF;
+	mask = CBCR_NOC_FSM_STATUS;
+	mask |= CBCR_CLK_OFF;
 
 	regmap_read(br->clkr.regmap, br->halt_reg, &val);
 
 	if (enabling) {
 		val &= mask;
-		return (val & BRANCH_CLK_OFF) == 0 ||
-			val == BRANCH_NOC_FSM_STATUS_ON;
+		return (val & CBCR_CLK_OFF) == 0 ||
+			FIELD_GET(CBCR_NOC_FSM_STATUS, val) == FSM_STATUS_ON;
 	} else {
-		return val & BRANCH_CLK_OFF;
+		return val & CBCR_CLK_OFF;
 	}
 }
 
diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
index 9bec563ab4ee..0cf800b9d08d 100644
--- a/drivers/clk/qcom/clk-branch.h
+++ b/drivers/clk/qcom/clk-branch.h
@@ -39,10 +39,9 @@ struct clk_branch {
 };
 
 /* Branch clock common bits for HLOS-owned clocks */
-#define BRANCH_CLK_OFF			BIT(31)
-#define BRANCH_NOC_FSM_STATUS_SHIFT	28
-#define BRANCH_NOC_FSM_STATUS_MASK	0x7
-#define BRANCH_NOC_FSM_STATUS_ON	(0x2 << BRANCH_NOC_FSM_STATUS_SHIFT)
+#define CBCR_CLK_OFF			BIT(31)
+#define CBCR_NOC_FSM_STATUS		GENMASK(30, 28)
+ #define FSM_STATUS_ON			BIT(1)
 #define CBCR_FORCE_MEM_CORE_ON		BIT(14)
 #define CBCR_FORCE_MEM_PERIPH_ON	BIT(13)
 #define CBCR_FORCE_MEM_PERIPH_OFF	BIT(12)
-- 
2.39.1

