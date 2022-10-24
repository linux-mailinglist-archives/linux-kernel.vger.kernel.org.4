Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9A460BF41
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiJYAKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiJYAKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:10:00 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656BB199896
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:28:11 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id f22so6510613qto.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tRuFE8rO3s/0mvr+V059lZduueV0GA9w+VMqdluqJH8=;
        b=hxxXf/pBZu7/fPCeIoQdmSDHOJ97iHe5rdvbn8MXq987X7ys42YoOGpfyGyTFJJeLb
         Rb2CLyImVxjmIKj2WV7qRxt6PfE90OQkdUQIsAZWBC5BTxTU0HTg16uEW7nFTTf90gFV
         ntCjQJIzfn0I2iSr4G9wexBpuo6i5A3Kt54X7s4N/mBBA3RZa5HTjf0vrTYIPacMV9XH
         HeTb1ABxvEihziE8ib60zXrL54Ma20/LBlGltpbdIefOlnF5T1lDQTU44Diw5d+Lrte/
         m0UfTLvJfjFU1zwAgpB4dzMqX66IbqsvotA5g2RB7fjnM3dRhmkjhXtJqhiRlvGVQ1n3
         gjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tRuFE8rO3s/0mvr+V059lZduueV0GA9w+VMqdluqJH8=;
        b=J3Te7yjoNn7EYUOLJmVOKaPO7H4ZqZVpS9wIfgc23HyMd//JHjUu8VSuaj/CJpmr4x
         oHndCRAgUN7W71VPd4/ehnM5o03WX+D13QvH6+UW588jT0//nH/NuZx6m5QFTLDf4Fva
         RLUi5A0LXcv64WoMEqC+tZtbzeXy5/MX9BasIUViMqCGowt41emH3sYvwfB1zMGT7jI5
         x2XjGF7Arko/7QGyoHgWIy42VJahSkoq7UEz2ioWDza98NlYKro8UAkcxdhu9cunjpUb
         CEbpSrU2l22S/tMaM8prt3ussdJSJMHhjc2slKeQ7I+OzZISkWVoyp/oIX4TOW4GJq7a
         O9Dw==
X-Gm-Message-State: ACrzQf3FTLIJ1vq10WJDOWndDUti5o1LK8z1ypZPBG37CCsHS+rj202h
        Tq0lp/UyUvrs/WSsWzXxrOjmEFLpTW8bcw==
X-Google-Smtp-Source: AMsMyM655o3Twr/DW5kbbexz+rdBLJUEJY0qudVYosLym3QB6p3xQRLoCQIrFAyDIrsgEgDrzf7DAg==
X-Received: by 2002:ac8:7f11:0:b0:39c:e908:6451 with SMTP id f17-20020ac87f11000000b0039ce9086451mr29911008qtk.560.1666650489848;
        Mon, 24 Oct 2022 15:28:09 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id br17-20020a05620a461100b006e9b3096482sm788662qkb.64.2022.10.24.15.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 15:28:09 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH] irqchip: Allow test compilation of Broadcom drivers
Date:   Mon, 24 Oct 2022 15:27:39 -0700
Message-Id: <20221024222749.2341479-1-f.fainelli@gmail.com>
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

Allow test compilation of the Broadcom irqchip drivers by adding a
COMPILE_TEST dependency.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 7ef9f5e696d3..e4b2ec9b2450 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -116,7 +116,7 @@ config BCM6345_L1_IRQ
 
 config BCM7038_L1_IRQ
 	tristate "Broadcom STB 7038-style L1/L2 interrupt controller driver"
-	depends on ARCH_BRCMSTB || BMIPS_GENERIC
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
 	default ARCH_BRCMSTB || BMIPS_GENERIC
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
@@ -124,14 +124,14 @@ config BCM7038_L1_IRQ
 
 config BCM7120_L2_IRQ
 	tristate "Broadcom STB 7120-style L2 interrupt controller driver"
-	depends on ARCH_BRCMSTB || BMIPS_GENERIC
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
 	default ARCH_BRCMSTB || BMIPS_GENERIC
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 
 config BRCMSTB_L2_IRQ
 	tristate "Broadcom STB generic L2 interrupt controller driver"
-	depends on ARCH_BCM2835 || ARCH_BRCMSTB || BMIPS_GENERIC
+	depends on ARCH_BCM2835 || ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
 	default ARCH_BCM2835 || ARCH_BRCMSTB || BMIPS_GENERIC
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
-- 
2.25.1

