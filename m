Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269536C402E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 03:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjCVCL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 22:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCVCLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 22:11:54 -0400
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7942257D1E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 19:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1679451109;
        bh=xZRcVHXos7s7r47JcIRB6LyLrZzCPMeTLnihHJWzZHY=;
        h=From:To:Cc:Subject:Date;
        b=vvTfdFxSAa9iykcUIu8JKOfmXEKmdqUMEEzWTAhBd1V8W1cyJGndUY4gZ0yvjPfCg
         kcc3L7Yoq0A11lhxVCKiMdvFVtcuYpHf3BhV4aqhrHvPiCuUhRueODXDAzy++zMGQ6
         Cr1ku3zj7mplJ8n5BieHmlybDv3sb3VlHKzquJYg=
Received: from localhost.localdomain.localdomain ([219.238.10.2])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id 2EFA3A9A; Wed, 22 Mar 2023 10:11:47 +0800
X-QQ-mid: xmsmtpt1679451107tu1gru0ju
Message-ID: <tencent_DA7A2DED2EBD2DF484DF69FCCE4F4B2E7C05@qq.com>
X-QQ-XMAILINFO: NJj83TeSvimwl7VS2aR+9FyPIMQEKwwQ4zqO+p4pDuCJlzl/sg5Rvbjl2VnY1W
         xDc8f2A211YyKxxhyeq3Zf35LCQTiZlj4C5dhlkY/QzN0sHRGWx4CTRcTkEAMe3Fw3ago0g8T39J
         rPWI4WRM1D+nmGLKx/n4tkDzuVZ87CRRkF+SbOi2CRGtKF+FFRbFsqc0YwUTeXGdjMpwM0gOVv1d
         sDOQ/hX4ZTC6elV1LVx48gjI0snuPEca4ZBlfsfoouD6qMo71JG/TNouxRZz6OY0EkfJUcPRmP5k
         HMBtVrLfXugSgQhFNGKVZWd1FLKJIfEYjSYNxjhoBlhfw5sEsakN+O6VnfWq8/Ig2pNVn1uGeUTN
         0D/tqSqXJWjPcvS3popW4N24jT0Nsuhjqwy3RUJlE6jYU2VE6AF3lZNBaaGccicNuBGFPKPDPIQi
         cwoYNoDE96AboCA7wU1OIz1HpMrWsKE3b+v6i2tSe9+HZbH9MoIWDsOtApAphP/9AWATVs8sHrXO
         S1dSmUfzbZ1nabLLoSHy0egM41TQ0uWM2PSFQwW+Q0gDUaNpu2LhLK41TV3RYwZ8HsnhlDUEC1Jd
         rC7Oe+0zeKJuY2ArbYtWXBw1Ts09afpa/OudIJZYj63KkGp1FLBlLzaDo0eci3bhViMyMPpDYtc9
         OwQCzM558Pl7QfAznnBXE8ygiUeC9IvaV1/10vnTUySizH3DrE5GkeLsoo2YHMxuQRHPw0jVRBOA
         5HJzTjxE4LQwK/Ub3RgFD6FlXTL0t0AHj7JFhxm902Tj86odP1IlNKMJ9nO4BsotYJXJNgv6xb0F
         /erM+0WtddG/2WS4eJ5YxhS7XO1XuEiv1H+Ar5lPrbmP7FpcXl2n5OFiLje1mOwXHCplc/ZsJqTk
         qqIdA6Ef7KYPb3Tqftb3Ov9nKjgA6SmemQszM6kU4Fr98Ci9FDnMbwa1c84gzgkZsWO4jQDf5+Jz
         FC4hLykRO82i9FP+N0GWYru3NlswAb
From:   Zipeng Zhang <zhangzipeng0@foxmail.com>
To:     akpm@linux-foundation.org, adobriyan@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zipeng Zhang <zhangzipeng0@foxmail.com>
Subject: [PATCH] fs: proc: remove unused header file
Date:   Wed, 22 Mar 2023 10:11:10 +0800
X-OQ-MSGID: <20230322021110.21588-1-zhangzipeng0@foxmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unused header file inclusion from 'fs/proc/version.c'.

Signed-off-by: Zipeng Zhang <zhangzipeng0@foxmail.com>
---
 fs/proc/version.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/proc/version.c b/fs/proc/version.c
index 02e3c3cd4a9a..63fb49ce8c2e 100644
--- a/fs/proc/version.c
+++ b/fs/proc/version.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/proc_fs.h>
-- 
2.39.2

