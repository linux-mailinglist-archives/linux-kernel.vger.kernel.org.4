Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F476977BB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 09:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbjBOICU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 03:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbjBOICK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 03:02:10 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA4130B09;
        Wed, 15 Feb 2023 00:02:07 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id k16so14538601ejv.10;
        Wed, 15 Feb 2023 00:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYpuouRtqGGYmfeCWWTT/2rWXrPC61M4tuQYBc16990=;
        b=Ewy3+ElsaB8wC+43QB/lfm6tQzdZpiyQ90g2dcojPYfreVDuUoUiZIX1QRFQ4ur+8d
         YpynnM+VOqTiBoS2gcwOCQgRMBHEHRa7DDwYgt+9gFT3Ax5RR/fK88ZjaB4ShaijJJQd
         pKAF0DuwZeJWtxQRb/as5Rpco5nFCUbGTlK3ZrPdCaN2FJeQWaiILYYaksPdcwGRaUjt
         pZ3+WeMMQFf3l0iYpMZhFIRp/UzxlavSH8s97HpohyoB1Wiiq27aNfG58bV2FJ3bQe3r
         eCjGzailwH8oX3hMJek/7Y3xI0sT2pD05SE07tn61F7FzTTQUB3rW0/C9gZNuqVWZSbV
         ulrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYpuouRtqGGYmfeCWWTT/2rWXrPC61M4tuQYBc16990=;
        b=YzXuw1xYjm3gfiIpTVv0u+Mpn2h0ogSB5hjs9o7GP9Wn6Q3vYK7Sz+vRJwu6ewiCcx
         XpAywwg1FHMrLCVpZS8XCxyNEoQkKS9wKaKVZbAECfCjgR4T+EfSqOT+bmG5biFNtB2K
         AjDRUGXeV+ZVUKR6yuF4pCBLqC++2RDmy0+Nrnx+JSGZf4ZVURfFmOzkamBkiBtsDrFU
         yCA9p2xwa+KLf4C5kcH6YUEHKh0opEZ/649QnWhzY3KXbewcckMdvBzpSYrb/633T8Xd
         ZE+eCOXg7CauJLOc6JgOSrUK/JT0FHIVP8kfdPLApYSI5HM4EnqeHOTzcJfjPvynLH44
         8C+A==
X-Gm-Message-State: AO0yUKXKqZCobKW8ppcAidgYnR3RqVse1/7mLU6VBKVUBZPqloklekoG
        2V9vYcgg3OpVJFKfltyqAkA=
X-Google-Smtp-Source: AK7set8L1CiiJwryrzPT+bqNoU9kWn4IRGRjCWQD3hofSiPU02XlmrnSQ8929Pfwkl3yRRdX0hnQzg==
X-Received: by 2002:a17:907:584:b0:870:d9a:9ebb with SMTP id vw4-20020a170907058400b008700d9a9ebbmr1578180ejb.38.1676448126256;
        Wed, 15 Feb 2023 00:02:06 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:983e:41b3:46f3:e161])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709066a8200b0087bdae9a1ebsm9394619ejr.94.2023.02.15.00.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 00:02:05 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     William Qiu <william.qiu@starfivetech.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-riscv@lists.infradead.org, linux-mmc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: repair file entry for STARFIVE JH7110 MMC/SD/SDIO DRIVER
Date:   Wed, 15 Feb 2023 09:02:03 +0100
Message-Id: <20230215080203.27445-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit bfde6b3869f5 ("mmc: starfive: Add sdio/emmc driver support") adds a
section in MAINTAINERS refering to the file drivers/mmc/dw_mmc-starfive.c,
but the file is actually located at drivers/mmc/host/dw_mmc-starfive.c.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair this file entry in STARFIVE JH7110 MMC/SD/SDIO DRIVER.

Fixes: bfde6b3869f5 ("mmc: starfive: Add sdio/emmc driver support")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 945b86f93cf7..74a30e724f7c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19935,7 +19935,7 @@ STARFIVE JH7110 MMC/SD/SDIO DRIVER
 M:	William Qiu <william.qiu@starfivetech.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/mmc/starfive*
-F:	drivers/mmc/dw_mmc-starfive.c
+F:	drivers/mmc/host/dw_mmc-starfive.c
 
 STARFIVE JH71XX PMU CONTROLLER DRIVER
 M:	Walker Chen <walker.chen@starfivetech.com>
-- 
2.17.1

