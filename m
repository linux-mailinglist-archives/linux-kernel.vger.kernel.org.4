Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BAC6803AA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 03:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbjA3CBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 21:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbjA3CB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 21:01:28 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054261C5BF;
        Sun, 29 Jan 2023 18:01:24 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675044082;
        bh=4N4nvguOlNTE34sqbnvTE3IRMGoOqGvhLDtXDoYx+EQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=YrqnAX5UI6esPR0SyGBZgj+o2uTccq6DO7LWjru1yhYYkRw2qjvraL7kIgpoaxS18
         iRlLy7/OVRQ6igFNUHpi2EZaMAMK0/CCA5EERWWefYvcX4ju/bTZlMouPIBroPKFLX
         nQ2vZViHjyl4mAmaybm/McooOk6ZCth5pc1VOnlg=
Date:   Mon, 30 Jan 2023 02:01:19 +0000
Subject: [PATCH 2/3] dyndbg: increase PREFIX_SIZE to 128
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221223-dyndbg-filename-v1-2-cbf8543009a1@weissschuh.net>
References: <20221223-dyndbg-filename-v1-0-cbf8543009a1@weissschuh.net>
In-Reply-To: <20221223-dyndbg-filename-v1-0-cbf8543009a1@weissschuh.net>
To:     Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675044079; l=677;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=4N4nvguOlNTE34sqbnvTE3IRMGoOqGvhLDtXDoYx+EQ=;
 b=NoRY/Q6NrNgmOBCHx6uCF9rcwE3r5EsreIlcD5BTd3Z5nYv/tim0IL23AkIXmwgbt3F2tx2byg5h
 GIYvB9UsC/YNHv9kXuaD6Zn5mTO+1M3QxAGMdcJ0Ahz3EXePlA8x
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A follow-up patch will add the possibility to print the filename as part
of the prefix.
Increase the maximum prefix size to accommodate this.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 6915e088bed6..e96ea427d8af 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -808,7 +808,7 @@ const struct kernel_param_ops param_ops_dyndbg_classes = {
 };
 EXPORT_SYMBOL(param_ops_dyndbg_classes);
 
-#define PREFIX_SIZE 64
+#define PREFIX_SIZE 128
 
 static int remaining(int wrote)
 {

-- 
2.39.1

