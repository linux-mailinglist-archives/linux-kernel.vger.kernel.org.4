Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B626C1576
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjCTOrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjCTOqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:46:18 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47C5FF1F;
        Mon, 20 Mar 2023 07:45:16 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id fd25so7072120pfb.1;
        Mon, 20 Mar 2023 07:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679323516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTj6lDaB879i6vS4ZDrKb4b2c9OODf1NGI0zVIt2OIQ=;
        b=Bj+oH3CQChclMtHQOjFJOIB+Z7POqoHz3M05DrKcE49Bnf7ohSE3pDsx71PYs3ECvr
         oTHseaJiODm/MyHSlBMBASGteA5HzjOenIVagUXFeZlt7Q+3YFMZoD7rUejgRISy+aVY
         2odaelScwYvdePOWDQYmQtu9g1I2XR+9uN9ba8aIcs04yVVbk2zqIX1fxAN1D/wbDGbE
         GKnk4Dos7F1ERtbzl7QoDAY8Tv0VU4CBkNuZAfbMf6wRdovcBhxA0rKvl1ZusIAFOTqG
         Ji6tDLvUkL6ZHoI/zPauDcA1VF/2Q7lzDyCG6Rg7kTodWzwhyU4JJcSU+8FUk5u7Mgzx
         O7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679323516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTj6lDaB879i6vS4ZDrKb4b2c9OODf1NGI0zVIt2OIQ=;
        b=fvJT19qqknclywQ8N5iPBs4hvjycnTKC7F5IriZQ581YZxPMea6PxZ/g2thCQJZ4iC
         cUd/DVF2jQTB3+Bt4xAPX3lYGnBaRX5gpPJYXA6oyEK0iU1OFY2FN2gY6j4fOXtnlQDU
         7yj2/w1Qe2k67XRV2sua+WD1NoFK4nAOEaFyy+dNC44kUuoxszekUKIO7rP707kWZUCu
         9vmkcwsspFNHKf/c7cVQvTXOB9xxsQWJwRyt5Ts2I2VAgVAjxlc1/abbV6SSGNJOSoUK
         /r51+/3Eao5L0xO+0lzJP2DhO1GhwYcmqJngWoAzNmBDLDT2mlaybGwVTQTWYkPwgHLz
         h5Rw==
X-Gm-Message-State: AO0yUKUUHwpPEzNxKViOLlcC4vgvNTz2Dz3lPlcgNDBonC8oX7N5hSXN
        o8RaDMMcT1ekio0oaBr7dufZ6TfKbp4=
X-Google-Smtp-Source: AK7set+YZdGvBmz/yJ5ACJx//DaOCsv2sHayWOfLM7STeuIIzbdJFihoX6ELSY7Jku8dzTLjKv9Llg==
X-Received: by 2002:a62:7946:0:b0:625:2636:9cd2 with SMTP id u67-20020a627946000000b0062526369cd2mr19429597pfc.18.1679323516022;
        Mon, 20 Mar 2023 07:45:16 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id x48-20020a056a000bf000b005a79596c795sm6428405pfu.29.2023.03.20.07.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:45:15 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-pm@vger.kernel.org (open list:INTERCONNECT API),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 22/23] interconnect: Teach lockdep about icc_bw_lock order
Date:   Mon, 20 Mar 2023 07:43:44 -0700
Message-Id: <20230320144356.803762-23-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320144356.803762-1-robdclark@gmail.com>
References: <20230320144356.803762-1-robdclark@gmail.com>
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

From: Rob Clark <robdclark@chromium.org>

Teach lockdep that icc_bw_lock is needed in code paths that could
deadlock if they trigger reclaim.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/interconnect/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index f7251784765f..5619963ee85c 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -1127,13 +1127,21 @@ void icc_sync_state(struct device *dev)
 			}
 		}
 	}
+	mutex_unlock(&icc_bw_lock);
 	mutex_unlock(&icc_lock);
 }
 EXPORT_SYMBOL_GPL(icc_sync_state);
 
 static int __init icc_init(void)
 {
-	struct device_node *root = of_find_node_by_path("/");
+	struct device_node *root;
+
+	/* Teach lockdep about lock ordering wrt. shrinker: */
+	fs_reclaim_acquire(GFP_KERNEL);
+	might_lock(&icc_bw_lock);
+	fs_reclaim_release(GFP_KERNEL);
+
+	root = of_find_node_by_path("/");
 
 	providers_count = of_count_icc_providers(root);
 	of_node_put(root);
-- 
2.39.2

