Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B88A6B0718
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjCHM3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjCHM3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:29:44 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36D885F20F;
        Wed,  8 Mar 2023 04:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=1LJsR
        IRUoT2bk4GGCzM/vl6oeuOVEfcYF7AMIxFQBuk=; b=g8o8M1yS6artBrbhyIHKF
        kcy0iPtKrluxIxEm78JpAJnUnvyp7ABtlDkc0vvdcqzO/WuEKkzeoQBv+NBdxQ3b
        /mx9oDjbXltjgUGJnEWLOindb8bs9ZO6qx9gwkVecilwXDRMfFcykTrqtR6QCY6X
        IxL/2e5qaVPhdFGAt1FBKY=
Received: from f00160-VMware-Virtual-Platform.localdomain (unknown [103.208.12.108])
        by zwqz-smtp-mta-g0-1 (Coremail) with SMTP id _____wCnLHlxfwhkf79ICg--.351S4;
        Wed, 08 Mar 2023 20:29:12 +0800 (CST)
From:   Jingyu Wang <jingyuwang_vip@163.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jingyu Wang <jingyuwang_vip@163.com>
Subject: [PATCH] cpufreq: fix repeated words in comments
Date:   Wed,  8 Mar 2023 20:28:30 +0800
Message-Id: <20230308122830.166728-1-jingyuwang_vip@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCnLHlxfwhkf79ICg--.351S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruFy7Xr13Xr13KF17tr1rtFb_yoW3XFX_uw
        4xWFs7ZrW8C39FgFy7uFs3urWrtay3WF97CF1xt3saqry7Zr1avrWkuF18W347Ww47GF98
        X3y8AF4ruF1UujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRN73kJUUUUU==
X-Originating-IP: [103.208.12.108]
X-CM-SenderInfo: 5mlqw5xxzd0whbyl1qqrwthudrp/xtbBMx8sF2I0iv7EfwAAsO
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'to'.

Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
---
 drivers/cpufreq/Kconfig.arm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 97acaa2136fd..123b4bbfcfee 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -95,7 +95,7 @@ config ARM_BRCMSTB_AVS_CPUFREQ
 	help
 	  Some Broadcom STB SoCs use a co-processor running proprietary firmware
 	  ("AVS") to handle voltage and frequency scaling. This driver provides
-	  a standard CPUfreq interface to to the firmware.
+	  a standard CPUfreq interface to the firmware.
 
 	  Say Y, if you have a Broadcom SoC with AVS support for DFS or DVFS.
 
-- 
2.34.1

