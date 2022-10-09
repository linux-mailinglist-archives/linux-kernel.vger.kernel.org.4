Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2615F8A30
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 10:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJIIkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 04:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiJIIkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 04:40:33 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A1BD1B9F1;
        Sun,  9 Oct 2022 01:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=WT7mP
        mqpp8eovKoloHaflEsK82bd/ro5QMn5+o1BCQw=; b=afqI4+Q3SxSr/m/uCZRbt
        s545uyfpp4a8kxweFm5yw20l4mvuP2qb9wzBoDtnrs/1eFbBRhyJ+an+UuRTKDse
        7BbGdKxDPzXerbN2sGtVJfkS7MmvNObERjRMiwnfiAukU40Lr1oWtBPYzGWCAxdb
        vZkAKTJSokmWI2sP7MjTaM=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp2 (Coremail) with SMTP id GtxpCgD3u+fqiEJj7sS9jw--.64612S2;
        Sun, 09 Oct 2022 16:40:10 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] watchdog: sp805_wdt: fix spelling typo in comment
Date:   Sun,  9 Oct 2022 16:39:44 +0800
Message-Id: <20221009083944.2988237-1-13667453960@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgD3u+fqiEJj7sS9jw--.64612S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrury7Jr47ZFy5GF43GF1kuFg_yoWDJFX_Gr
        y7J393WryDGF1SyF1q9a1ftrW0qrZ09Fy8uF1vqrW3J3ykZ34DXFZ7XF1Iyw17Cryvvry5
        tw1DXr10kFnrJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUby8B5UUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbiyAqV+1p7H8V+6QAAsA
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Fix spelling typo in comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 drivers/watchdog/sp805_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 78ba36689eec..2756ed54ca3d 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -88,7 +88,7 @@ static bool wdt_is_running(struct watchdog_device *wdd)
 	return (wdtcontrol & ENABLE_MASK) == ENABLE_MASK;
 }
 
-/* This routine finds load value that will reset system in required timout */
+/* This routine finds load value that will reset system in required timeout */
 static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
 {
 	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

