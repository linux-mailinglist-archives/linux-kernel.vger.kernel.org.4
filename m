Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4241F72AC50
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 16:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbjFJOaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 10:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFJO37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 10:29:59 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A86CC0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 07:29:58 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 7zbHqY0SlW2Gf7zbIq8AYt; Sat, 10 Jun 2023 16:29:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1686407397;
        bh=sPMzKdWTCeIaXKkyZnkASaVYeO7GZgv565HWu+Ri3g8=;
        h=From:To:Cc:Subject:Date;
        b=mg2ARX+1cRnl9jXvWy0xNoLwFoVhimZ3et4FnzrLwNNMqA958LOllMayjxbSy3ETK
         ymfaSdu2lru5rr25e8G/2evp+mKorWKFA3Chn+Jjf8NENJxIp2o+B0DOShv0gyJtRQ
         RNB78dXhvlau8XeaHVGRJbAxbwTplm9jbahrv6+ZTMVEnQGFnVNubamGZyEhnK6Q90
         VnOR7ehDqTXljiK8IygqUQtmGb2J9BAsPwhBWzwjHnsVMZwx3A3TPfuHn3kAgjq6DH
         vGySYoW6M+aaEafihRVVcUoJspMEvj76B+ag77SSjy77YUK7gMXjQlF/Ct8dMTr1yB
         vGdeg9kUMz3bA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 10 Jun 2023 16:29:56 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        sparclinux@vger.kernel.org
Subject: [PATCH] envctrl.h: Fix a typo in an example
Date:   Sat, 10 Jun 2023 16:29:48 +0200
Message-Id: <96e2fc8a1bcee8003a66eb5f20853dc36f203f30.1686407377.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/envtrl/envctrl/ 	(c missing)

This way, it matches the device name given a few lines above and the name
of the .h file

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/sparc/include/uapi/asm/envctrl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/include/uapi/asm/envctrl.h b/arch/sparc/include/uapi/asm/envctrl.h
index cf8aa0a14f40..ee5a712fcd0d 100644
--- a/arch/sparc/include/uapi/asm/envctrl.h
+++ b/arch/sparc/include/uapi/asm/envctrl.h
@@ -20,7 +20,7 @@
  * The device name is /dev/envctrl.
  * Below is sample usage:
  *
- *	fd = open("/dev/envtrl", O_RDONLY);
+ *	fd = open("/dev/envctrl", O_RDONLY);
  *	if (ioctl(fd, ENVCTRL_READ_SHUTDOWN_TEMPERATURE, 0) < 0)
  *		printf("error\n");
  *	ret = read(fd, buf, 10);
-- 
2.34.1

