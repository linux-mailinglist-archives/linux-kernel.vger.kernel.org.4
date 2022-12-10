Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68F3648DA2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 09:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiLJIrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 03:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLJIrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 03:47:20 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6379424951
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 00:47:19 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id w23so7270122ply.12
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 00:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d7CpKTuV4AD8otSVbWNm7MqP8kndy+RPyATXgazEzEU=;
        b=DOfF+b4M5C+99sNtadOMCNgilLnCVdXCUAsMSaSPkRQmmX0aC7Kt+UvB6kLN/1M+fF
         jtjkuEKCbN3k3p1Ij7FP3jrUxjgIgJTQSZ2qXmZ+P0lBHt0lCwNlAfJLPF1VPuXQFsch
         zSvV0m+TBUoE5ywMCfbXAB1XPprCtQ3MBUsvvYXwQsfCxMvhvNCk9bMwYvIXwuJKMfjZ
         iwSdM/Pl76KmnG4CH987uxfpe2Thc5xgg0OIOsrecSL/M6+0ivsGx7onHPHcsiBev5ZW
         uut+8/XUppfzZgtYwCPsW+s6S8V1MHzYNxYTYDYlbL5zc0q79QorMRXjJ9usMwoBTzCT
         a4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d7CpKTuV4AD8otSVbWNm7MqP8kndy+RPyATXgazEzEU=;
        b=T7oJpc3yqmIzbcXwH5TM6twrVF4SkWxNBwPYNetJFpVjhaeK7cxoGfuFxyOnMwAoBe
         JJ7vNtLNOBLCnc6YxBIWThnP1uCVSaomJl2tqGMfP70kqx3wfryeeyBGajf9yrKOCjaO
         APXUIBVfKfxPKL2EcpzZwX5fgQy3t/KdpezgZBbwcbEJJQVQSswjc+Z1JAkPxnvSU5DG
         Z6gVpTDNcKjoHXL9HGKIizqZ+sHseB+JssqkE9qy2n1VYfRPknc9sCSUruVw2fG6J+RT
         dQxVrPhG8O05cU+ltT4QfGMlC+mqIf+OhQQI6V6zFz7UA4OL5aq/gtJc7ZQNXE7EZmNk
         SH7Q==
X-Gm-Message-State: ANoB5plz1YEMD22Rk1ASdX1hNAmOgLbs2h21QS8Pj2S372w8E2estvj2
        CCZj079GWeswWKpwYjvbeFhiHurOjZo=
X-Google-Smtp-Source: AA0mqf6yaIxR8Ae7QLrrEOpEQzO2fErQqxbcMWrihR6MRWty/urrmkji9Yvs4YyPoFMJ5p1K3fACqg==
X-Received: by 2002:a17:902:f112:b0:189:e545:7234 with SMTP id e18-20020a170902f11200b00189e5457234mr7939945plb.40.1670662038927;
        Sat, 10 Dec 2022 00:47:18 -0800 (PST)
Received: from RUVNQOCM782.flets-east.jp ([2400:4050:21e0:c900:e8e0:ff47:23a6:efb3])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902daca00b00186b7443082sm2518835plx.195.2022.12.10.00.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 00:47:18 -0800 (PST)
From:   Takahashi Akari <akaritakahashioss@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Takahashi Akari <akaritakahashioss@gmail.com>
Subject: [PATCH] <driver/net/ethernet/amd/nmclan_cs.c> Remove unnecessary line
Date:   Sat, 10 Dec 2022 17:47:13 +0900
Message-Id: <20221210084713.51710-1-akaritakahashioss@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Hello:

I sent a patch. Please review and merge.

Reason:
Remove unnecessaty line. (if statement is always true)

Git repository URL:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

File:
drivers/net/ethernet/amd/nmclan_cs.c : 931

Signed-off-by: Takahashi Akari <akaritakahashioss@gmail.com>
---
 drivers/net/ethernet/amd/nmclan_cs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amd/nmclan_cs.c b/drivers/net/ethernet/amd/nmclan_cs.c
index 823a329a921f..a90e0c5b603d 100644
--- a/drivers/net/ethernet/amd/nmclan_cs.c
+++ b/drivers/net/ethernet/amd/nmclan_cs.c
@@ -928,10 +928,7 @@ static irqreturn_t mace_interrupt(int irq, void *dev_id)
 
   if (lp->tx_irq_disabled) {
     const char *msg;
-    if (lp->tx_irq_disabled)
-      msg = "Interrupt with tx_irq_disabled";
-    else
-      msg = "Re-entering the interrupt handler";
+    msg = "Interrupt with tx_irq_disabled";
     netdev_notice(dev, "%s [isr=%02X, imr=%02X]\n",
 		  msg,
 		  inb(ioaddr + AM2150_MACE_BASE + MACE_IR),
-- 
2.34.1

