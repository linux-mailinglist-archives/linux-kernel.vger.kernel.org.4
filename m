Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B3765AE4D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 09:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjABIm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 03:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjABImS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 03:42:18 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD0BDF4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 00:42:17 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id g16so19317950plq.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 00:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JV7mKkj4m/LbjdZ+E3y5ghBdnOoxXVhztXdDkfMjQ3Y=;
        b=LnOdDY/x11L2fWrc3DS8NW4NDOu1PWG9qOJCbJslNnneoe+SOcgeHhjAk/sZvYewEo
         jMlNouPohv6UO21l880LPap2L+oZ4UTjFlXLLPfEknP3pweaRshCLU8u2VIW+OG0Z6BW
         e6dEk3rYJkyB/oqut1yL41ELcuIh8OWrwzbNvKOqasT6TQnL55IiccBWvX3Nx8C/mN6I
         lVGCytF/KmPtFje99ltjbeW7g1XsdO17dOaOAAbd3e2K0me7ZwkmNEWtzM/BmA9OSNlG
         WlF4eH3Zw3YzcqGLnBEKMRqklsDH+PGl6wUC18ao+0gZ6E5D4YMY3kHA91SvOotW5yLb
         qBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JV7mKkj4m/LbjdZ+E3y5ghBdnOoxXVhztXdDkfMjQ3Y=;
        b=5Go3yCkNY4E10ApGFN2Fr6flFV6CXxYxSv4VmsDV8QkbZwXbIfdKiMm5GrkQwhoyLA
         HKMmyQrQclrkbZ/e+UAGyk4ssXrNhRTeh02FQ/FIyd/wdNwttjX4oCEH3tlj7nVHi0j7
         djUiQxI+PxoxA/i5ffO4joh5MueV5V44sqAuahqMq4+ivwR9C27qFkrdXF60yyDmGTG9
         kMY8fj7pRjwBDe4ikTQN7HHRfvb/yuH1ljnM0wGR2Y0QFPDEEzCNs6gAJYjKVgjgc38J
         rj9NVFukhRUd4bFOALL+em/2iOSNeGg6WUfVaZtbmFp7PvfY8ZXdNLMqAPZdhIc8qaQm
         Zv7g==
X-Gm-Message-State: AFqh2kq91D3E4cQN6JvVIBCM8evjcroHYpafV1B48nGLDdQdYCW9jUzT
        dZV8LSiqONIj4JnP0RmTdqbdQR527CrlYr9+
X-Google-Smtp-Source: AMrXdXtPxWUpseKD4UE0s2pK1XNqVl6yXxmY55pKjUBfq1N4kFubl+XKIzHqP9vXQXroG/v2yX7+EQ==
X-Received: by 2002:a05:6a20:8f26:b0:ad:db18:6d0d with SMTP id b38-20020a056a208f2600b000addb186d0dmr62886922pzk.59.1672648937455;
        Mon, 02 Jan 2023 00:42:17 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id t29-20020a63535d000000b004767bc37e03sm16609386pgl.39.2023.01.02.00.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 00:42:16 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] irqchip/irq-mvebu-gicp: Fix refcount leak in mvebu_gicp_probe
Date:   Mon,  2 Jan 2023 12:42:08 +0400
Message-Id: <20230102084208.3951758-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_irq_find_parent() returns a node pointer with refcount incremented,
We should use of_node_put() on it when not needed anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: a68a63cb4dfc ("irqchip/irq-mvebu-gicp: Add new driver for Marvell GICP")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/irqchip/irq-mvebu-gicp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-mvebu-gicp.c b/drivers/irqchip/irq-mvebu-gicp.c
index fe88a782173d..c43a345061d5 100644
--- a/drivers/irqchip/irq-mvebu-gicp.c
+++ b/drivers/irqchip/irq-mvebu-gicp.c
@@ -221,6 +221,7 @@ static int mvebu_gicp_probe(struct platform_device *pdev)
 	}
 
 	parent_domain = irq_find_host(irq_parent_dn);
+	of_node_put(irq_parent_dn);
 	if (!parent_domain) {
 		dev_err(&pdev->dev, "failed to find parent IRQ domain\n");
 		return -ENODEV;
-- 
2.25.1

