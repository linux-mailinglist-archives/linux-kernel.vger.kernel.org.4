Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BD3635AB3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237115AbiKWK5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237567AbiKWK5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:57:12 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FBEFC731;
        Wed, 23 Nov 2022 02:50:33 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id s5so11582349wru.1;
        Wed, 23 Nov 2022 02:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5mJ4XYFEsSMGscEtu1E88MW80nC31aQOMXivDq2lhNc=;
        b=IE8UMA6VhinH8zgY45hA6zbdXgQnSd5mHtHg/96rArFtXQepHbI1yalKQFcKl1vBs/
         WgvqUt6fm6vUcruIwrjm2+Ke8mbxrIis5SqNMdOeEjQQeflQ3vcJkW/PG+7BirCkLHtw
         qIqn/3eiyUjhjWnP+kXHHjf1zTv9eePWcPW0qS4EBFk1jcnD8cvgq+/pRaAry+w9o8Fx
         pAUR76EFHRIgYplPPvn9EBK15JHP4Hsnfn4s9hXynC1PzmYf/eRDf8V6yP/sW0t++dcE
         O6sabjTlVviMjoXCo9ybeCJUcWk+XO05zhNwNEWbCMnxWZ4+uLDkREkYLvfXfMZUT+DX
         1UWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5mJ4XYFEsSMGscEtu1E88MW80nC31aQOMXivDq2lhNc=;
        b=EtG8R0WRsXBsjIXxbml4MLXjFHXwnzEqbTSjxbs5AHW2yUzy8y7jo/Z+hMWg1sj+mX
         KTx++iGUbqZh+kGQ5Qnjb+/PkmjnlmGSO6LjiSUT5KhOaFesa+vtYLadOsF4EGF2pQxt
         j9I3AY64Jtz7QvUlNBMn1x0Kr4H59ilnOxmiT8ax0ZPbrFsglQQinjB6LVRMCcpRQ/Ie
         zkrDvQr/wXoC7NHruDxw6r59MU8UeyLUImtvtKyvg4068IWXMqKA7SMXN3cnY/LY1bD0
         zLJu79+Wv1smWuUdUP7XsWf80x+fjVC0hY0mC0n8mpsfUildAnkOtLBiLTYQW2jjBgJv
         JAUw==
X-Gm-Message-State: ANoB5pkwwQZqXMAHYzGiD+7tGdCnKb02DL6hlr4o6FTUXbuhulv47D+0
        swf19H9nIpHnuZiq7XdsVYO49L5mWlclaw==
X-Google-Smtp-Source: AA0mqf461/lZE5/BT2BQpKWrgzp7uOAmtw0frJclKgxnll5YFmNIxfqRxwAB7zwaQ17pLHbtKKYC+Q==
X-Received: by 2002:adf:e0c2:0:b0:236:6f18:37e6 with SMTP id m2-20020adfe0c2000000b002366f1837e6mr16294620wri.262.1669200631806;
        Wed, 23 Nov 2022 02:50:31 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:3178:d8a1:a393:6d85])
        by smtp.gmail.com with ESMTPSA id v19-20020a05600c4d9300b003cf37c5ddc0sm1759317wmp.22.2022.11.23.02.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 02:50:31 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] media: platform: rzg2l-cru: rzg2l-csi2: Enclose the macro in parentheses
Date:   Wed, 23 Nov 2022 10:50:22 +0000
Message-Id: <20221123105022.336198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Fix the below error reported by checkpatch:

ERROR: Macros with complex values should be enclosed in parentheses
					CSIDPHYSKW0_UTIL_DL1_SKW_ADJ(1) | \
					CSIDPHYSKW0_UTIL_DL2_SKW_ADJ(1) | \
					CSIDPHYSKW0_UTIL_DL3_SKW_ADJ(1)

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
index aa752b80574c..a26a17eee1e7 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -81,10 +81,10 @@
 #define CSIDPHYSKW0_UTIL_DL1_SKW_ADJ(x)	(((x) & 0x3) << 4)
 #define CSIDPHYSKW0_UTIL_DL2_SKW_ADJ(x)	(((x) & 0x3) << 8)
 #define CSIDPHYSKW0_UTIL_DL3_SKW_ADJ(x)	(((x) & 0x3) << 12)
-#define CSIDPHYSKW0_DEFAULT_SKW		CSIDPHYSKW0_UTIL_DL0_SKW_ADJ(1) | \
-					CSIDPHYSKW0_UTIL_DL1_SKW_ADJ(1) | \
-					CSIDPHYSKW0_UTIL_DL2_SKW_ADJ(1) | \
-					CSIDPHYSKW0_UTIL_DL3_SKW_ADJ(1)
+#define CSIDPHYSKW0_DEFAULT_SKW		(CSIDPHYSKW0_UTIL_DL0_SKW_ADJ(1) | \
+					 CSIDPHYSKW0_UTIL_DL1_SKW_ADJ(1) | \
+					 CSIDPHYSKW0_UTIL_DL2_SKW_ADJ(1) | \
+					 CSIDPHYSKW0_UTIL_DL3_SKW_ADJ(1))
 
 #define VSRSTS_RETRIES			20
 
-- 
2.25.1

