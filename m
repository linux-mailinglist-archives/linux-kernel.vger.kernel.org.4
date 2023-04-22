Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC526EB9A4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 16:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjDVO3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 10:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVO3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 10:29:01 -0400
Received: from out203-205-251-80.mail.qq.com (out203-205-251-80.mail.qq.com [203.205.251.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CC618E;
        Sat, 22 Apr 2023 07:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1682173734;
        bh=lAhvK/6iAVJHwzi6nSMtZhd5mosxwxL4Es7IMJuPvs0=;
        h=From:To:Cc:Subject:Date;
        b=gJUYZeAuPoIwNf38RXa7VGZH1NIIK01lNJeAG2Hz1D8bsXXZldDrR4xDAOuP83a3z
         6yiRcnX+nGhf/RxryLCCgQk8KIZXo8y30ANBx6IWBev/gHaNzjm9+YuIh3dfafBj9O
         a7JIz+d47zcs/qrBsLuzEqbwl0ER53N0CkW4/l8Y=
Received: from rtoax.. ([111.199.190.121])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id 6E802069; Sat, 22 Apr 2023 22:27:40 +0800
X-QQ-mid: xmsmtpt1682173660tar8ifj1g
Message-ID: <tencent_F85E314661100B0CE2845EB27E2E2F558C09@qq.com>
X-QQ-XMAILINFO: M/NR0wiIuy70dcPQJwtU+Jpl4XyXWAWk6hB7EqnCXZLF64re4832dic/sx4cTm
         2Ac2uRIX30G5JuROgQ9gjEGy8+aN3znNUGDmpZGqjgNQE0rrVq9iPiq26e0KzgNGBHwp1hXfrzK4
         KfTnTlBD7G1s0DEk049TJtHKCnXk5DdgNfFtjVlUmumhx32uEZCMD+Kay6eIKmTQ2NTI0C/pGCWO
         CvB1PWAzTElgEBrc5PqbOfxGa+bT2075ZIQxR8PFQYIrtbI9WktiOKupNDYpa8J3FJzmnF14iX5d
         lq281V1N5J5Q2RsbZLM9qew2xkAqEARP8oT042C7FZZsOUcReA7L0B+++CZlkWhE8Pdw5gt1xt9s
         ATiEA78PMCgdAScahAJdKt6xjjlc05DCJDGsWprhfmm+MUv3bAgKyv5rMAGKow2MDzqVVWjhc2lY
         RCBWMYbT/jHOK2tp+ZDwlrpd04ApKDQkqgN1A+v9+8GtwSjxHHiBRRE4R9VtwVQW5BTGbMZOg977
         r8sjRRzM86ZAKm02eywtc6+DwYy3C6qe6YtC/W8fM566AgTfxIT0t0kY2GZocZeIujHJcQp2KJFR
         If4+mUREgmHY5enFwQAwJjwA1fULvYdVB5tWhGbEr8ZQpxbIXHh+y9NOFUqIscZblJ6Y8hxByl2Z
         riSxWDY9oXzzp3yy1VQdEA8/uJN2F7OvMifLVpDVkIysioJXWC5ur9FY6HjBO+yfHpj22/R4R6H0
         fTl36Oav+yxCCDLYhyyrWP2wZxnmtss/RJeLT1CB6LUuYwISJeo2WgLmw5Y/KHTEWFXXIncmb+YU
         plKSdQQKSiQLBF0FbANuIu5YduwWw74DdNuZKGJb9IpnsP9iSD3ixwaeYvE7sGwS/kLPnxQ/dl7W
         JhCCfHKdBw9AUmLIVdqw53xfaBwJUZdGE5gFNWbKdLyRrkmGj/TNxksNW33Cnj9IyJPKIPwdOjGr
         Ng+wwu8QHUtc/8xCjgJCUhXE1xwDaa/yKg7Uc8LViggOzyIAGZTQvifAk07VKm
From:   Rong Tao <rtoax@foxmail.com>
To:     william.gray@linaro.org
Cc:     Rong Tao <rongtao@cestc.cn>,
        linux-iio@vger.kernel.org (open list:COUNTER SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] tools/counter: Makefile: Remove lingering 'include' when make clean
Date:   Sat, 22 Apr 2023 22:27:38 +0800
X-OQ-MSGID: <20230422142739.59948-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

'make' create 'include' directory, we should remove it when 'make clean'.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
v2: this commit, according to William Breathitt Gray's suggession in v1
v1: https://lore.kernel.org/lkml/tencent_FA682F628E818DD04B96C3E5A94ACFABE206@qq.com/
---
 tools/counter/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/counter/Makefile b/tools/counter/Makefile
index 8843f0fa6119..a0f4cab71fe5 100644
--- a/tools/counter/Makefile
+++ b/tools/counter/Makefile
@@ -40,6 +40,7 @@ $(OUTPUT)counter_example: $(COUNTER_EXAMPLE)
 clean:
 	rm -f $(ALL_PROGRAMS)
 	rm -rf $(OUTPUT)include/linux/counter.h
+	rmdir -p $(OUTPUT)include/linux
 	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
 
 install: $(ALL_PROGRAMS)
-- 
2.40.0

