Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A49D5EE83A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 23:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbiI1VVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 17:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbiI1VUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 17:20:51 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36852218;
        Wed, 28 Sep 2022 14:19:29 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso1674445wms.5;
        Wed, 28 Sep 2022 14:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=CPte1r662FSAR+yNfyqva9K9yTvoMCulNZWy04//xXs=;
        b=PB2nPPYfPxZ3iRr4GAhBgSpcqBWvn062jN+FyVCMHXHEkWtyzHA28vjt8Q+fLmSGJS
         fF6Nv3Ea3pCHOG+U+K3QssGeSZX6LvhSbkRFYW6w/oOHq5k3CHoVEwA+KmonB8WvzBOH
         R1bUdvbzM8UkOO0RoBznf6/yhoiqcviSKVlGFMlFLGtpL1icdMgkhetE6FDI61bt8BNV
         b3rKsBicgqHKbvij/jLFk7/f+cvAvwAK9jz1nF85d4IVqfRa5kRRIj/RoGCsEhw50SMO
         ktthZ8eZlmVmkVEURoIBkx14Z/OYay8Z22EEwAv663CYeb5HiR8I7oKTlXabRg6dj+Nk
         YPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=CPte1r662FSAR+yNfyqva9K9yTvoMCulNZWy04//xXs=;
        b=70IZpiUGl+KiwMPWz7TsDt0x7MlmdRJ4I93FobxcS95KL08CrJU0C9S0gVDQeDc8Zk
         gXwKUaFVQfTx2RDZFH7Q3MPG7ANgT0OoyHFK8lbw+IzhJxmybWDn65d8O8eaXmDBcG10
         KnQSRqcMh8huU0H80cSqlKakZe4CDsvAkRcJyLVNZrnC4Kq3XBWDOg9hPQjmGeaodSFH
         inYhzroPBNoVLdzQL9KXHj9qBRfv6WkHoMRyNm/5N0QnqEYvI0U+M2AqBQSlHFK35eTq
         K6kGSW8PQmNVsW9HdT7cXlBijkx/YKKdqctsBGiKsiKIQb7k6cnxN0drAByMfrxFK4i8
         nBkA==
X-Gm-Message-State: ACrzQf25NysJa8gOiSw73rQJAhoq6qpscATMu7GmhFA3CtPg8spC71+X
        aBOp9kZdUYWc6AJ8HUygOAIdlt12UwfQ4Q==
X-Google-Smtp-Source: AMsMyM5EyUUYxudsQehbIig3JI/bjqhSCkf6zlKdYtXAqaNI1tOhPuwgz+noi69xqIVuAB6aIVE2GQ==
X-Received: by 2002:a05:600c:154d:b0:3b4:aae6:4bd7 with SMTP id f13-20020a05600c154d00b003b4aae64bd7mr18916wmg.63.1664399967732;
        Wed, 28 Sep 2022 14:19:27 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id a16-20020adfed10000000b00228de351fc0sm5052933wro.38.2022.09.28.14.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 14:19:27 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: max1721x: Fix spelling mistake "Gauage" -> "Gauge"
Date:   Wed, 28 Sep 2022 22:19:26 +0100
Message-Id: <20220928211926.62818-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in the module description. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/power/supply/max1721x_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/max1721x_battery.c b/drivers/power/supply/max1721x_battery.c
index 473e53cd2801..d8d52e09da7b 100644
--- a/drivers/power/supply/max1721x_battery.c
+++ b/drivers/power/supply/max1721x_battery.c
@@ -444,5 +444,5 @@ module_w1_family(w1_max1721x_family);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Alex A. Mihaylov <minimumlaw@rambler.ru>");
-MODULE_DESCRIPTION("Maxim MAX17211/MAX17215 Fuel Gauage IC driver");
+MODULE_DESCRIPTION("Maxim MAX17211/MAX17215 Fuel Gauge IC driver");
 MODULE_ALIAS("w1-family-" __stringify(W1_MAX1721X_FAMILY_ID));
-- 
2.37.1

