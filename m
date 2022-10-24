Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F0960BF56
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiJYAQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiJYAQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:16:20 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE2F16726B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:35:41 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id m6so7011109qkm.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PVH9IFhUFtwNqEntymYkuy4/xdGSxf96mErhYF2LkIQ=;
        b=R0vNc4ErwqLPje4s+CrmvCd6OmxxYBjoRVjve7EBhkuMsnYZKG4NIPNZfB43IDhNI/
         28RZDJC2JEFpZrdw+luqFy9av8s5OCckomFx80ZAeRQsvWDMYBdEHiVb5hR8Uv6KL7nx
         dgIGIXIvvL568b0UK0pl06NmEQ2f1w4N+FiqRTm25p/azDcRrhH0Hr7gO7cwZsYI9OkR
         Frvq4gytF2XogxF9xnrRKq4+6gPwLqa/zyIJGwqZ38VHnb5zi8W81eXBspIkkd9reU42
         SpS3z39Njykqxj5Z2t5Xb1zwIfh4aLZSv+akuGvfcDj3RFGHSJQPRVan8I4t5BzLMNWr
         OeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PVH9IFhUFtwNqEntymYkuy4/xdGSxf96mErhYF2LkIQ=;
        b=5VzSdNgX6dUXqcc73/tJmq42UUOzNf4gCew12cTxzX7SI3O8E/6G9ulBTMDJlh5QmT
         PLOLbi502TyoTkBGWV07At3PyC795DJ9TzmAXZqaQ3CV71zvCXP2k+MD/1+nuYdsk5H4
         V+YJz6Qh4tNb8Pd6nq4LBFLt2J1uRHV2+NKQSk65c78c8ytvrgDnsNYMph9Dn2h2Uv1X
         J/KEo1LnV3QIo2BZwYRaX7Xl4ogRAkuJYC/NF5ZVY4qZKspWX0mMQGubp/L0hgR7UEJl
         zMYYvhpnDbjTcg5F/CykgHd6l/9J26eeKG74a9GPrye6G4SK9yZf4NJAEaJr0bpim//L
         3AmA==
X-Gm-Message-State: ACrzQf00M/kq9yTObyJVr6gYfszww29MvVkJeP3nmjufQMi3JLiRGmEY
        K3nx1ziF5kQA6gChYh8Wrls=
X-Google-Smtp-Source: AMsMyM5sUZP9X3XmzqFPL4kdV8pmul+brTO/0yhkq0QyoY4juOhkBkJVLpkFxCn2EZ7B8zYg+OHs2Q==
X-Received: by 2002:a05:620a:2a02:b0:6ee:bfc3:3a22 with SMTP id o2-20020a05620a2a0200b006eebfc33a22mr25230548qkp.737.1666650940305;
        Mon, 24 Oct 2022 15:35:40 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o10-20020ac872ca000000b003988b3d5280sm614930qtp.70.2022.10.24.15.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 15:35:39 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michael Srba <Michael.Srba@seznam.cz>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] bus: brcmstb_gisb: Allow compile testing
Date:   Mon, 24 Oct 2022 15:35:30 -0700
Message-Id: <20221024223532.2342024-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it possible to compile test the brcmstb_gisb arbiter driver to
increase build coverage.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/bus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 7bfe998f3514..825759892482 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -31,7 +31,7 @@ config ARM_INTEGRATOR_LM
 
 config BRCMSTB_GISB_ARB
 	tristate "Broadcom STB GISB bus arbiter"
-	depends on ARM || ARM64 || MIPS
+	depends on ARM || ARM64 || MIPS || COMPILE_TEST
 	default ARCH_BRCMSTB || BMIPS_GENERIC
 	help
 	  Driver for the Broadcom Set Top Box System-on-a-chip internal bus
-- 
2.25.1

