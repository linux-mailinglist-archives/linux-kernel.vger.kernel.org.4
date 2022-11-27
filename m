Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890B1639CAD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 20:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiK0T4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 14:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiK0T4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 14:56:44 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A6ADF5D
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 11:56:42 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id x66so8607614pfx.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 11:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dt7gCiRU+QTmWH6bkeGBsrTCAMP3VsxMn4QpUawUMm0=;
        b=v4N9hl1EyFHlA6KZaaPBGFB58m88TmGR+PZfL6VCaVDLqjK1xJLiYDpiefWq8A/eSB
         d/hrZ1WpUaQznKroe9I2nfbwfGk9wcj7OUCf02Iq7bGUuwBBKkbdTQ8vYh0Uga+qnRsu
         6T+kVZluuq6kdxTIpek7VpW100zjwjKYcPf93B590xpjsHklFId3Ze53MGPLo/mWfKLH
         0y2791zj/nU8ghP/GWRR0Bs3VByqu0+OYQnWnPonCp+Z/Nqrfu6GQOywOW7Yr1HjF4Gj
         kOn3LDck+hgMmR9xolSDuhVSO/WAiTXR2FjtmfOWI1NQcDJoobLSE9MiDWLPUmcJRjbq
         Z/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dt7gCiRU+QTmWH6bkeGBsrTCAMP3VsxMn4QpUawUMm0=;
        b=zRtIGK99l8t0KwGfFLfy0OYX59m7jsxgBZMg965ek7u89Hr7nUkqXTGwLsmJyEI6ZE
         tAQ7x1yQdI5NK35SCVtdFYruRVPMjPAAmxMk1nCSEA0KbeuO497bm9WHb7nK2FnJHrYK
         /SPWk+UCtrwIp72yXYVV5DwAM5cJHbG8ZYHnKOI11zOrpE1t00WvGLh2zsEJRDJpEXmQ
         EfFrhO8W/gLesbuMJ1u1jBO1OIhbYrJZtKzJipX5Vw9zrDLf5rAYyGh7lT6pOlFrcjxf
         3XX+fZC+s56dr+Z+0VmY3w4OT2cjAUJ5nYqa9QRb/RKlA9+pPQ0X+F0052WaTMeMkOLY
         y6Mg==
X-Gm-Message-State: ANoB5pnKA1oMP4F76BVquEhxnn8Bfv/jRZyxsuf9KTC9XKvhdC5DS6WI
        /ySYtxQRxFgs3Fh47X+M46oWgQ==
X-Google-Smtp-Source: AA0mqf4fbBoeVfMe/1K4ikBELh3iuW94LslZ/0oFH0/ogMA+aOCNPPr1/9nb8CW+zrTlPG1sxMb4XQ==
X-Received: by 2002:a63:5544:0:b0:477:6fe2:c1d1 with SMTP id f4-20020a635544000000b004776fe2c1d1mr24459962pgm.444.1669579002420;
        Sun, 27 Nov 2022 11:56:42 -0800 (PST)
Received: from localhost.localdomain ([223.179.131.184])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902968100b00186616b8fbasm564636plp.10.2022.11.27.11.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 11:56:42 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     jassisinghbrar@gmail.com, devicetree@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, agross@kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH 2/2] mailbox: qcom-apcs-ipc: Add SM4250 APCS IPC support
Date:   Mon, 28 Nov 2022 01:24:18 +0530
Message-Id: <20221127195418.1506876-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221127195418.1506876-1-bhupesh.sharma@linaro.org>
References: <20221127195418.1506876-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable SM4250 APCS IPC support by adding the compatible.
It reuses msm8994_apcs_data.

Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index f1f0e87a79e6..0e9f9cba8668 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -156,6 +156,7 @@ static const struct of_device_id qcom_apcs_ipc_of_match[] = {
 	{ .compatible = "qcom,sc8180x-apss-shared", .data = &apps_shared_apcs_data },
 	{ .compatible = "qcom,sdm660-apcs-hmss-global", .data = &msm8994_apcs_data },
 	{ .compatible = "qcom,sdm845-apss-shared", .data = &apps_shared_apcs_data },
+	{ .compatible = "qcom,sm4250-apcs-hmss-global", .data = &msm8994_apcs_data },
 	{ .compatible = "qcom,sm6125-apcs-hmss-global", .data = &msm8994_apcs_data },
 	{ .compatible = "qcom,sm8150-apss-shared", .data = &apps_shared_apcs_data },
 	{ .compatible = "qcom,sm6115-apcs-hmss-global", .data = &msm8994_apcs_data },
-- 
2.38.1

