Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47C85B34D0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 12:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiIIKHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 06:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiIIKHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 06:07:45 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF2B13866B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 03:07:43 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id r18so2800115eja.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 03:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=d0rkg1Wut40eiym1yldjAgKe+UB9rsjZIgZDS1zS8Og=;
        b=TPjJ6gb6kEtf88JMwg1KzNxfCwiR8/s2cVlZ271QMlPhrKPmINFT3USrixhDu6YCoI
         2/StKZnkBqo7nt6pFPqO/Th75YmDp/wiEsmJQob5nSs2VrEmh/OjvJVaT0sbHevghCPL
         yNilw3cUqRwzY44SQOD0mlwD/vUVLtwM9XLxPmRVqyhPlH9ehw1q/lB9cZ3lY/yHK1+F
         c3L3aOqGRgGjPzfYuHETnoyptz0XwcsjfnUqKmDSmFjpaZNUefVf1sJkt/ImjBEwTfMs
         me/1QJqYJX9U4XnjwsSmhvy3yl9X4v2ijghlsLFcQwX27nfZw2++MztTZhSYcMvLa7/h
         Bk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=d0rkg1Wut40eiym1yldjAgKe+UB9rsjZIgZDS1zS8Og=;
        b=jA5SWGwqi7377DgREtlgSs3pMvYCrOJd2071vyU67hSIPPSHrrZ8m+YtI+ULkKuMIh
         NbeKNV+2UC6K44uyVyOq4H2ZGix2JP6T4HnbB0zrWyjKUAcOnu36p+jYRblf9QWUlhWF
         4TnsDmGYIdwy4agPHaTfCKdH/ZXIYqqcDuTrRbn4h3tV1EctNLGtFuIQ5+tu1ki7PMxc
         sZwCxVR0bK8yaQdSypExCW/cDKV8nxX4TgQdSLaZ0Edmq8ZMolEMnWp4m4TucsmeHvFm
         bbxN7GPQGTG4O3WY9gHRchFgDXfBqA4FzjJYHNRgH96YmtuR0e5XGVMugUtz6ONRc9gJ
         ULfA==
X-Gm-Message-State: ACgBeo2QETd53Gs9W04IbNS58n6gfBLrvNARFnCFnwzx6gDgHNlm4Gc9
        wwOayREQPQp76HDh/AKWduo=
X-Google-Smtp-Source: AA6agR5kUAD0FvJcUodcBXnZvqfYdN7vGbvmaFWosgjKQ/z+limR4Mqb9s/UoQmlIHT4GNVI0UqAYA==
X-Received: by 2002:a17:906:216:b0:711:f623:8bb0 with SMTP id 22-20020a170906021600b00711f6238bb0mr9533387ejd.174.1662718062233;
        Fri, 09 Sep 2022 03:07:42 -0700 (PDT)
Received: from localhost.localdomain ([131.155.244.90])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906210200b00715a02874acsm82283ejt.35.2022.09.09.03.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 03:07:41 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org
Cc:     namcaov@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH] staging: vt6655: remove unnecessary null check
Date:   Fri,  9 Sep 2022 12:06:51 +0200
Message-Id: <20220909100650.44609-1-namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Remove null check for priv->tx0_bufs, because it can never be null at
this point.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/vt6655/device_main.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 3397c78b975a..0d8876278953 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -586,13 +586,12 @@ static void device_free_rings(struct vnt_private *priv)
 			  priv->opts.tx_descs[1] * sizeof(struct vnt_tx_desc),
 			  priv->aRD0Ring, priv->pool_dma);
 
-	if (priv->tx0_bufs)
-		dma_free_coherent(&priv->pcid->dev,
-				  priv->opts.tx_descs[0] * PKT_BUF_SZ +
-				  priv->opts.tx_descs[1] * PKT_BUF_SZ +
-				  CB_BEACON_BUF_SIZE +
-				  CB_MAX_BUF_SIZE,
-				  priv->tx0_bufs, priv->tx_bufs_dma0);
+	dma_free_coherent(&priv->pcid->dev,
+			  priv->opts.tx_descs[0] * PKT_BUF_SZ +
+			  priv->opts.tx_descs[1] * PKT_BUF_SZ +
+			  CB_BEACON_BUF_SIZE +
+			  CB_MAX_BUF_SIZE,
+			  priv->tx0_bufs, priv->tx_bufs_dma0);
 }
 
 static int device_init_rd0_ring(struct vnt_private *priv)
-- 
2.25.1

