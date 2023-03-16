Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD206BD7CA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 19:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjCPSHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 14:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjCPSHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 14:07:12 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D7FB4224;
        Thu, 16 Mar 2023 11:07:06 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t15so2336098wrz.7;
        Thu, 16 Mar 2023 11:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678990025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BQxP9Hae0QJYPvRU+UgB4w9TRIz/j+3TUA20yrz0awY=;
        b=CTxWUY4d+KMAUT0PuMwWABTb/jq7Nud+0WNous+vSn7Ehew5Kklz39rKhRSn1p16pf
         3a+l5dFhH6Iszrv6s0e0lMVJjNzQi1clV54CKf8A+3cgayrobKvQoTmiST/MyI1NUsEP
         lUtSZqEPm74Ll94nLuoS7gAZsgyyDOpqvoUfrK1Cz56HJEP7/caJ0tDwiEpJYKUdGpZG
         VSrlo4LTsoEofAImhP39SdF7d1/i5s2QMvl6tOjpPzWa1RIvHYaLVU80OLGs2q6G26KZ
         EtNg1+0hEjjKS97zIveYvWdftUv9b9vq5upiO/hfK/W7ZEHnZg0XLrifaCHP9/lRn+1W
         hIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678990025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BQxP9Hae0QJYPvRU+UgB4w9TRIz/j+3TUA20yrz0awY=;
        b=hGv9dProEGHGVFEKamHoFrplDDZfveuTiXF/h6whUhR6VsvrW6DUq+aFPit6MWKGE0
         P/XAPXXo8DM1f1dHBWrRGVPkIiAGixStB2F7xt8XOxx3pjUCQuMPGQthIIIOJODnJ4ZM
         bdsHuMEKFVbsA0vTJKllk0pvZtRYN35cYZGahS3DHPpa6z+/57PnNWFChqDLnOECwdKx
         HVjVfc5LsFz8+sz0i35oX4Xc4c7svN88Cs8ocWHsjXzdlyNdi4OKHcrffsR/yuXd4bfQ
         AEuymj4TZAPVuVN95h/eEDK/8iw7vZjp9ooho3xoBEG9e9LYKuqmo9cRuOl6HxPCsVUo
         xS9w==
X-Gm-Message-State: AO0yUKVSqxTsK+X7QOLKe8pH4Ib0gq9fXMVl6dNlRPCyYVqHMKEkR9nO
        TO9WucE8XEVqIv+swkdQwokEIip3HvXcGoAg
X-Google-Smtp-Source: AK7set/1C3UcVUhiLCb1rg9+5CI9zdmZUK5x/FPjiBx+pxuekH4gNUMUjWZUMUNV6yyqy/p25XpDug==
X-Received: by 2002:a5d:6990:0:b0:2c7:1dd5:7918 with SMTP id g16-20020a5d6990000000b002c71dd57918mr5546341wru.28.1678990025010;
        Thu, 16 Mar 2023 11:07:05 -0700 (PDT)
Received: from atlantis.lan (255.red-79-146-124.dynamicip.rima-tde.net. [79.146.124.255])
        by smtp.gmail.com with ESMTPSA id s7-20020adfeb07000000b002ceaa0e6aa5sm27262wrn.73.2023.03.16.11.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 11:07:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     f.fainelli@gmail.com, jonas.gorski@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, tglx@linutronix.de,
        maz@kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH] irqchip/bcm-6345-l1: show MMIO address
Date:   Thu, 16 Mar 2023 19:07:01 +0100
Message-Id: <20230316180701.783785-1-noltari@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

It's safe to show MMIO address.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/irqchip/irq-bcm6345-l1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l1.c
index 6899e37810a8..55a2d9b31597 100644
--- a/drivers/irqchip/irq-bcm6345-l1.c
+++ b/drivers/irqchip/irq-bcm6345-l1.c
@@ -335,7 +335,7 @@ static int __init bcm6345_l1_of_init(struct device_node *dn,
 	for_each_cpu(idx, &intc->cpumask) {
 		struct bcm6345_l1_cpu *cpu = intc->cpus[idx];
 
-		pr_info("  CPU%u at MMIO 0x%p (irq = %d)\n", idx,
+		pr_info("  CPU%u at MMIO 0x%px (irq = %d)\n", idx,
 				cpu->map_base, cpu->parent_irq);
 	}
 
-- 
2.30.2

