Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6231F6741F6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjASTB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjASTBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:01:16 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC7794CAD;
        Thu, 19 Jan 2023 11:00:19 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id q10so2814213wrs.2;
        Thu, 19 Jan 2023 11:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SW3KKlGhrddVguZYn0d+e2LgFlJNd7o3tlCwCQMDobE=;
        b=iecPY2kTytemtO6WxcHUFTn+Y5RDFWBv09reAom1B+5GI2kjLknlCoGv6JXYpIQQgR
         7b4FaAOG8JbgZDk6wL/niLmwLT7UjQolw/zar0BXggrAk/NMA6vM+TrmTPwuIQ6Hx4dA
         PCuGHPdwPyaEN0rtS/XMQKIRz2q2C+CcFZtVORWjIAz/0KAq/WkwITMtd6xpZUivlx6o
         2QpoLX8+SqmKNCYVer9+UTlUOUQ45W0yF1lRejrGEjm4DyaIwiOqlMA2VwgGt313H0zu
         ocv6d5YNIVKoiNP7Hr0X1Wt/o6woQv+pVThRKLRAra4eKHJlwyeVeGB0bisXoa8o/IyL
         n0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SW3KKlGhrddVguZYn0d+e2LgFlJNd7o3tlCwCQMDobE=;
        b=wqg2RfZLji9U06AMVGdeNf78jbpJUf0Y/TbOTzsss8MoGWNlAYwQfuNjwX0Yvb/e0h
         hWqoEL5xnDFxf2XUzLrIsl2N93z3kBxrHSKmtpl6JeipnHFoU1tADbV6dJmuq6qRBYD5
         kqZTqBKu00GjmWrnn+kdYLczDvxCNtYS50psAlO6KhoYswwY03RazHo40SU8+Crk/ggU
         855zK1YTPhsMRnXWp5z6PiOx59Np4tV5GxBbpOPL1ivvXJLKjZ5lVV+RRMmXp6gNzGFY
         GVM6h2YGtCRvF/3kB1ceL5Or4vo4NJ71caG7z6kxeWa2nh1xeM/vwRRoc6cyTwCUR3wE
         1vyQ==
X-Gm-Message-State: AFqh2kp9K8dD0cwuN3Efqon3bEdRSPigA8UGxQK01hoyn1/Lc3dlY0PF
        xXKH4G1tjnXfwosC/UAlVqS0St6W4qI=
X-Google-Smtp-Source: AMrXdXu3wlzXgr0rfyoRWVRZoeMyd3+QVGrwFvbL6UAYs+lbW3XbVXoDnUs+qgwxR6cekhBwRwhuag==
X-Received: by 2002:a5d:5a87:0:b0:2bd:ee0c:26a3 with SMTP id bp7-20020a5d5a87000000b002bdee0c26a3mr6924263wrb.8.1674154797193;
        Thu, 19 Jan 2023 10:59:57 -0800 (PST)
Received: from localhost.localdomain ([37.55.203.63])
        by smtp.gmail.com with ESMTPSA id u14-20020adfdd4e000000b002366e3f1497sm34814488wrm.6.2023.01.19.10.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 10:59:56 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 3/3] arm: dts: exynos5800: Use Exynos5422 compatible for the DSI controller
Date:   Thu, 19 Jan 2023 20:59:39 +0200
Message-Id: <20230119185940.156558-4-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119185940.156558-1-markuss.broks@gmail.com>
References: <20230119185940.156558-1-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver adding support for Exynos5422/Exynos5800 DSI controller was
merged in 2016, yet it wasn't actually used. Add a proper compatible
for it.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 arch/arm/boot/dts/exynos5800.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
index 526729dad53f..8328ddb3b02f 100644
--- a/arch/arm/boot/dts/exynos5800.dtsi
+++ b/arch/arm/boot/dts/exynos5800.dtsi
@@ -148,6 +148,10 @@ opp-200000000 {
 	};
 };
 
+&dsi {
+	compatible = "samsung,exynos5422-mipi-dsi";
+};
+
 &mfc {
 	compatible = "samsung,mfc-v8";
 };
-- 
2.39.0

