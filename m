Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036755B3FFB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbiIITjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbiIITiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:38:15 -0400
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 029EF143411
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 12:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=+ta9/
        yptiww5NAB3QXlYt8Sh6mpDEzb/2/ykp9KFAlE=; b=EpD/b2Fp3wWc776thRUn3
        nnDDCR09AYqJhU7VhyrDAmcnHfnGHvjWReTslYpcXHbZ/fekjWoiyFhDFQAbc0NP
        nrdgCC/pBsr8NWRQcE6G8osuz6hg6Ar32omJfxUiQo0oy7EjfamZYNu8DtPxhsMd
        MPb0T9SFrqzQcdZG4/5Sso=
Received: from f00160-VMware-Virtual-Platform.localdomain (unknown [1.203.67.201])
        by smtp12 (Coremail) with SMTP id EMCowAB3IwGylRtjd+voAg--.62844S4;
        Sat, 10 Sep 2022 03:36:38 +0800 (CST)
From:   Jingyu Wang <jingyuwang_vip@163.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Jingyu Wang <jingyuwang_vip@163.com>
Subject: [PATCH] genirq: remove unneeded "default n" options
Date:   Sat, 10 Sep 2022 03:36:13 +0800
Message-Id: <20220909193613.85269-1-jingyuwang_vip@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowAB3IwGylRtjd+voAg--.62844S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw1fKr4DJF1UJFW3urWDCFg_yoWxArX_K3
        yv9rZ7uF1UAwsFyr1Iqa1Sgr40yw15KFWxZF1YyFZ8Xw1Sqa13Ww1kXFy7Xr9xuay8uF1x
        ZrWFvFnFkas5tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUjb_-7UUUUU==
X-Originating-IP: [1.203.67.201]
X-CM-SenderInfo: 5mlqw5xxzd0whbyl1qqrwthudrp/1tbiyQZ3F2I661uFtwAAs1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove "default n" options. If the "default" line is removed, it
defaults to 'n'.

Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
---
 kernel/irq/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index db3d174c53d4..950dabed53fb 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -129,7 +129,6 @@ config GENERIC_IRQ_DEBUGFS
 	bool "Expose irq internals in debugfs"
 	depends on DEBUG_FS
 	select GENERIC_IRQ_INJECTION
-	default n
 	help
 
 	  Exposes internal state information through debugfs. Mostly for

base-commit: 5957ac6635a1a12d4aa2661bbf04d3085a73372a
-- 
2.34.1

