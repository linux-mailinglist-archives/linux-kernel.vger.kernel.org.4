Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA2D737CD6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjFUHuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjFUHub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:50:31 -0400
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6EC83;
        Wed, 21 Jun 2023 00:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1687333825;
        bh=6S232VMjC7wbziWgrkeXXOdDe+/491iWQmYYurhqPhY=;
        h=From:To:Cc:Subject:Date;
        b=zRpgKOSqxCP/4i9St0ozdufw2PbdrHBwGtd7F3XQTp/3YHXPV9dBZWC/oHyccmffd
         WrrhCg1mZl4p9ls9JYRwdMKUNRnbUi9rmHUWsn9Wh0yEfg/72t5h2/3RG/l7wKDoBz
         ttnwDJgFQKTWstQUAVeP2hiB5JHCnP+3zT2je/Hc=
Received: from localhost.localdomain ([39.156.73.12])
        by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
        id B0E042AA; Wed, 21 Jun 2023 15:44:14 +0800
X-QQ-mid: xmsmtpt1687333454tfjy6s68a
Message-ID: <tencent_6142CF595B97172A46AF02A34D885D060108@qq.com>
X-QQ-XMAILINFO: OZsapEVPoiO6eY0DWtcWpjTtkqvDLES3BnTBVKNv3l0ZaoH54gYPz06I+g/oKg
         lp5WLi9U9wSKT/2itYOdWzsdQwny/nVUVQH9Abg4Jx3B/e9RRMK3oHraS/uiH/jVvygzOTsWhWET
         qXa0uwT2TCNgv1mlvJ2UgRKRsDTSfA7o8sbv0OGxhdWCfqmj8+MFB/oVGeS2Nq/okfkQ5T8iU4gj
         Ywt6AB5YXzWgNqeBNv+ueD+VAEyyoWy4sFsBGY5PDg+mHiV9VV7+yEZGwjFjHtScy4Kv3lJMg76B
         AOPi8pMYrYZZARbV27YRmScKekrVgNXSuLM4iJnM/IqxFcf+xTd/PyvV/LSDUKTry5M3U+eHUyB4
         7+xEupHa2S4IeLdUvOtl2hlOrc8ar0CbCHk36bIBxmt0n94Be6OnmdjCXQuZw7UBOLEL4jI4hBCQ
         WnRxEdKOfzO68Sa/8EhqlcI1xI87uvwaPPTMxitNfMOkFZYQO1QSZfUE1VUK0LcQpSFZgL/0zM8Y
         65bseXdx0N8kju/Yh/koiODifdukB48B8eGl+jpzz1s1VUbv82NjvYRPAvnEupoWuTT6cXodK9yq
         FwoTCmKHTX7slCCqz5IGyjRfjyQymOwA5jOEIAiHIt80SP8GrRhRcgIwQnWZeIg6T8mWxGMNJWFm
         3UCiZ3KJSvySL5KaIHfXu8xoQD9vWhXnLMBONIwZ/xk73HAQ/RW4TDnuIImqI3bi5JReev9UYz35
         91hjGKcr8ucM1eLbFbzjMygSlxBm2lf4vsNpAnFDDKYpBviGMzzk/6l0U5pPvREgi4F3V42vj3mt
         WJ1PdRj7ZARY0lxskg6r7XVNmNAKCQ1zobNl8QLFWhTnS049DyAA3tf1DVvBjqEI3riBkIv8ZKfZ
         LW/PRp544bySZner/x8iNDq29652cleWYaXUd8u6NxWnRpAjnMI4IVRph1nMi2ZbSeyncpqnd4+Z
         LhmMySxek9gvbJsgOJFc5S2vFZHGbPgmezlNfNyGpBXSCIfTWi+Ftp/6shlVU+Z2wnEHCLAiym65
         TxayS1qQ==
X-QQ-XMRINFO: OaHeJnMbHdYJoNPX7mruotAPXHzc5BrOrw==
From:   Rong Tao <rtoax@foxmail.com>
To:     corbet@lwn.net
Cc:     rongtao@cestc.cn,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] docs: trace: Convert decode_msr.py print syntax to python3
Date:   Wed, 21 Jun 2023 15:44:12 +0800
X-OQ-MSGID: <20230621074413.88019-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

Convert the decode_msr.py file to python3 to solve the following running
errors:

    File "Documentation/trace/postprocess/decode_msr.py", line 35
        print j,
             ^
    SyntaxError: Missing parentheses in call to 'print'. Did you mean
    print(j, end=" ")?

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 Documentation/trace/postprocess/decode_msr.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/postprocess/decode_msr.py b/Documentation/trace/postprocess/decode_msr.py
index aa9cc7abd5c2..2d45d6c14987 100644
--- a/Documentation/trace/postprocess/decode_msr.py
+++ b/Documentation/trace/postprocess/decode_msr.py
@@ -32,6 +32,6 @@ for j in sys.stdin:
 					break
 		if r:
 			j = j.replace(" " + m.group(2), " " + r + "(" + m.group(2) + ")")
-	print j,
+	print(j + ",")
 
 
-- 
2.39.3

