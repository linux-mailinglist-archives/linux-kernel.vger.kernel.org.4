Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4926BD924
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjCPT2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjCPT2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:28:40 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7259B7D9F;
        Thu, 16 Mar 2023 12:28:38 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id y14so2539231wrq.4;
        Thu, 16 Mar 2023 12:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678994917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8afldfRZftLeVmekmQfoh01jVdumsVP7nkKoPaU3Q0=;
        b=FzMRr5ekh/fDiJqTlezNj6nLjzvn5z92FtYeB8MquVSMB8PuvarccnyqAzsXiccf+v
         uwRFIomnTWNLGVjzc1xrB2hGiCKD3jBo5n1u8p/yEV6rpolbxVjfM7eTHXyAHXGXz7ZJ
         TPeVbWfAlxiSD6+BPtXr/efehcdI64fIoL6G/U1WHNMo01Tzr/Obf3y5tug17N0fGcXg
         CH6E5a2HguZUtwrm26LcK9IOV/7xEx5eIE1cOvTLMxPbGWaZwEjjP16HylJr06xRLhaf
         RpiYBT3mXwwuOx0jLOhqavY/2kZ9GVbZRWMMwZrZv9xNO13SBwc1VUVgD4k3FntnSk7Z
         AaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678994917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8afldfRZftLeVmekmQfoh01jVdumsVP7nkKoPaU3Q0=;
        b=OaA5DMgqalrfqO5iOtmmxFPsH90MkN7l4EJpyVnzuiO1Wd6rSCpqPOR7xpxZno8OPP
         tdfm4vzn9Ie4AUDbFKDTUlPG+tgkmIruo3K9C0VnY9DD2PRZMEYBbWaJKU1otqKt0NKu
         IAAHNvxvQvCESKzbXFLYwWbRKFScOSMGmGBTDfgThz51A18Ff1hJy/BmnuZk7M2TLgHO
         wQpy9t7oeB/Hkxl41y46emLc/nESsvwvAG/fx/zPzCe9UiaQLrdZq+BKeOwSBedktzK5
         U/ZTfgzU2UGSI67aGRqqGnI0uXq+MAJMK18qzM0VByxj6W+AXJ6BJr5P0quljeQ8upSg
         bEUg==
X-Gm-Message-State: AO0yUKWnqTlccBDnqwCSRdqOBGc2FyfiLy1Tg7EjPENlISpzXuDYwW/R
        lJSI06rrfq+Vel/SigfpGJI=
X-Google-Smtp-Source: AK7set/jYfYl9ttVzIXJO+ZQVfa6cE/yOsP8fx4teiTmGNNWyVlIJRzMAlF3IUGqRAXAmY3hAabIuQ==
X-Received: by 2002:a5d:40ce:0:b0:2cd:ceab:df1a with SMTP id b14-20020a5d40ce000000b002cdceabdf1amr381006wrq.32.1678994916642;
        Thu, 16 Mar 2023 12:28:36 -0700 (PDT)
Received: from atlantis.lan (255.red-79-146-124.dynamicip.rima-tde.net. [79.146.124.255])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d4bca000000b002cfea3c49d5sm180041wrt.52.2023.03.16.12.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 12:28:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     f.fainelli@gmail.com, jonas.gorski@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, tglx@linutronix.de,
        maz@kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v2] irqchip/bcm-6345-l1: request memory region
Date:   Thu, 16 Mar 2023 20:28:33 +0100
Message-Id: <20230316192833.1603149-1-noltari@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230316180701.783785-1-noltari@gmail.com>
References: <20230316180701.783785-1-noltari@gmail.com>
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

Request memory region in order to display it in /proc/iomem.
Also stop printing the MMIO address since it just displays (ptrval).

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 v2: request memory region and stop displaying MMIO address.

 drivers/irqchip/irq-bcm6345-l1.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l1.c
index 6899e37810a8..fa113cb2529a 100644
--- a/drivers/irqchip/irq-bcm6345-l1.c
+++ b/drivers/irqchip/irq-bcm6345-l1.c
@@ -257,6 +257,9 @@ static int __init bcm6345_l1_init_one(struct device_node *dn,
 	if (!cpu->map_base)
 		return -ENOMEM;
 
+	if (!request_mem_region(res.start, sz, res.name))
+		pr_err("failed to request intc memory");
+
 	for (i = 0; i < n_words; i++) {
 		cpu->enable_cache[i] = 0;
 		__raw_writel(0, cpu->map_base + reg_enable(intc, i));
@@ -335,8 +338,7 @@ static int __init bcm6345_l1_of_init(struct device_node *dn,
 	for_each_cpu(idx, &intc->cpumask) {
 		struct bcm6345_l1_cpu *cpu = intc->cpus[idx];
 
-		pr_info("  CPU%u at MMIO 0x%p (irq = %d)\n", idx,
-				cpu->map_base, cpu->parent_irq);
+		pr_info("  CPU%u (irq = %d)\n", idx, cpu->parent_irq);
 	}
 
 	return 0;
-- 
2.30.2

