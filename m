Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C1574C85F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 23:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjGIVSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 17:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGIVSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 17:18:06 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CC811C;
        Sun,  9 Jul 2023 14:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1688937483;
        bh=J+Xea2ihWP8J7/RiQgrqlVFiwt7iwUc6uaPbB3lfgT0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=I8RxAsQg62HQ66sqqhmhr+oK3L/xaZmqwwluFr0cdP4PfwPVeX966Bqn+lB5XDLq/
         B8WWhRhkkUMo+LMzWiMJpatVc6K1vPVEoSLt77EcX3VrD41JChigvM3/qGCzuQuEop
         U3if3wAq2698rY8f46z9E3v4NLhdZ5hh53c1+ZHk=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sun, 09 Jul 2023 23:17:59 +0200
Subject: [PATCH v2 2/3] dyndbg: increase PREFIX_SIZE to 128
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230709-dyndbg-filename-v2-2-fd83beef0925@weissschuh.net>
References: <20230709-dyndbg-filename-v2-0-fd83beef0925@weissschuh.net>
In-Reply-To: <20230709-dyndbg-filename-v2-0-fd83beef0925@weissschuh.net>
To:     Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688937480; l=677;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=J+Xea2ihWP8J7/RiQgrqlVFiwt7iwUc6uaPbB3lfgT0=;
 b=IXJ1KgkRmSd+BA8ncaDY1B60bjM00KbTjufQhsm5yV3ZJ51bqklliktBMrjZUeewGJe9i5P8e
 roTWGcweoZoAMs1s0au8A+jrH8gmbjRYrZ0PT88it9P52pFdquJ3teN
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 71b22d206a1b..166229dfe171 100644
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
2.41.0

