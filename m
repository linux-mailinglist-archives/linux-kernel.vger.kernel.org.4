Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C00716ADE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbjE3R0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjE3R0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:26:25 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC12FE7A;
        Tue, 30 May 2023 10:25:56 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f4f8b94c06so3495226e87.1;
        Tue, 30 May 2023 10:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685467498; x=1688059498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9mcfBA7C2XEbgXjVDjCpK0Hf299E00EVQylWvc9g1Yw=;
        b=Vzk1E4CsQnADdI4J7KpPHeOmHnbn9ALXbGt+Ef0Q1qZsnyNw7dJFNJEVoVMj4Opw6B
         OsfGaZpw6UpFrGdnHGTSmS9vcFL+yqAAKCOMCNFd8tcs3IzlTE92tZ65dXUgMlugAfIS
         3fP5/4bh8dNA2oO8H1DC6+mjZThe7fZctLwlUCdnKoHYRRjBcP6JaYhMf5LEBWmhXHvN
         UovSDXFeYlc89BqZ352e30cK2xof3ikPOzf/1+yNADDXeV6tqXN6f9G+KawlmEHpni2o
         LeTpLi+HKK28lZZMfvPhqJ1tWQBCDCY1e34Zs0rkIrrENSvGBfwd8g9yUllCfv1Yx/zj
         To1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685467498; x=1688059498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9mcfBA7C2XEbgXjVDjCpK0Hf299E00EVQylWvc9g1Yw=;
        b=Q7pCtWu72APCwwCF579RjscFoPXWUpAhNhFlDRcOAVkroEA9KBr1yaqmIPYm8wywW7
         GJDiXT0UJwzCZizqRa0mFQofPM/nIY8jeToK383d5Dc+rv6pHn8iS3tfSAc+WDNSK2L5
         HU/uk7Iz8MXvCKYS7THFpiJSJrTiss1Ct4B635s2Zoos8PMEVGcUoYG0Hx6rTSJjf29f
         fkjrJhuRksIrFEMyXTys/BtAHUHpxRivY4cpt1bByt/il81Cvn5TYPYC7M9pu5MHqaLw
         Wk8/DK/zOhLG/xLbXsZsoWY/RuJmCixfRiLE0+1EC/BZ3+QE3Fq8EsUt3MJ+COYGklYs
         q7Jg==
X-Gm-Message-State: AC+VfDxbKUO7CIYRklzzBr6XGy4Klm3+xImzrbkTmu/iS+O0/nZcis9T
        O76JxBda4upTW+xosGfcuaY=
X-Google-Smtp-Source: ACHHUZ71EpQjOWoE0C2+ipu+Fj5FwrvOoRwzkItvSUH9dOdK/uSK0NCL5q2Qokp9iUPeSRZ/wTIjxA==
X-Received: by 2002:a19:ae09:0:b0:4f2:40dd:e2cf with SMTP id f9-20020a19ae09000000b004f240dde2cfmr1121845lfc.55.1685467497822;
        Tue, 30 May 2023 10:24:57 -0700 (PDT)
Received: from Osmten.. ([223.123.107.215])
        by smtp.gmail.com with ESMTPSA id k16-20020a5d66d0000000b0030ae6432504sm3932841wrw.38.2023.05.30.10.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 10:24:57 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        angelogioacchino.delregno@collabora.com,
        DLG-Adam.Ward.opensource@dm.renesas.com, amitk@kernel.org,
        wenst@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Osama Muhammad <osmtendev@gmail.com>
Subject: [PATCH] lvts_thermal.c: Drop error checking for debugfs_create_dir
Date:   Tue, 30 May 2023 22:24:39 +0500
Message-Id: <20230530172439.13683-1-osmtendev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the error checking for debugfs_create_dir
in lvts_thermal.c. This is because the debugfs_create_dir()
does not return NULL but an ERR_PTR after an error.
The DebugFS kernel API is developed in a way that the
caller can safely ignore the errors that occur during
the creation of DebugFS nodes.The debugfs Api handles
it gracefully. The check is unnecessary.

Link to the comment above debugfs_create_dir:
https://elixir.bootlin.com/linux/latest/source/fs/debugfs/inode.c#L451

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index d0a3f95b7884..da5e3652ff3b 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -179,7 +179,7 @@ static const struct debugfs_reg32 lvts_regs[] = {
 	LVTS_DEBUG_FS_REGS(LVTS_CLKEN),
 };
 
-static int lvts_debugfs_init(struct device *dev, struct lvts_domain *lvts_td)
+static void lvts_debugfs_init(struct device *dev, struct lvts_domain *lvts_td)
 {
 	struct debugfs_regset32 *regset;
 	struct lvts_ctrl *lvts_ctrl;
@@ -188,8 +188,6 @@ static int lvts_debugfs_init(struct device *dev, struct lvts_domain *lvts_td)
 	int i;
 
 	lvts_td->dom_dentry = debugfs_create_dir(dev_name(dev), NULL);
-	if (!lvts_td->dom_dentry)
-		return 0;
 
 	for (i = 0; i < lvts_td->num_lvts_ctrl; i++) {
 
@@ -197,8 +195,6 @@ static int lvts_debugfs_init(struct device *dev, struct lvts_domain *lvts_td)
 
 		sprintf(name, "controller%d", i);
 		dentry = debugfs_create_dir(name, lvts_td->dom_dentry);
-		if (!dentry)
-			continue;
 
 		regset = devm_kzalloc(dev, sizeof(*regset), GFP_KERNEL);
 		if (!regset)
@@ -211,7 +207,6 @@ static int lvts_debugfs_init(struct device *dev, struct lvts_domain *lvts_td)
 		debugfs_create_regset32("registers", 0400, dentry, regset);
 	}
 
-	return 0;
 }
 
 static void lvts_debugfs_exit(struct lvts_domain *lvts_td)
@@ -221,10 +216,9 @@ static void lvts_debugfs_exit(struct lvts_domain *lvts_td)
 
 #else
 
-static inline int lvts_debugfs_init(struct device *dev,
+static inline void lvts_debugfs_init(struct device *dev,
 				    struct lvts_domain *lvts_td)
 {
-	return 0;
 }
 
 static void lvts_debugfs_exit(struct lvts_domain *lvts_td) { }
@@ -1099,7 +1093,8 @@ static int lvts_domain_init(struct device *dev, struct lvts_domain *lvts_td,
 		}
 	}
 
-	return lvts_debugfs_init(dev, lvts_td);
+	lvts_debugfs_init(dev, lvts_td);
+	return 0;
 }
 
 static int lvts_probe(struct platform_device *pdev)
-- 
2.34.1

