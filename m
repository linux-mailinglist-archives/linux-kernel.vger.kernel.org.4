Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A356ECAF2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjDXLFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjDXLEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:04:51 -0400
X-Greylist: delayed 549 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Apr 2023 04:04:36 PDT
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5062830E2;
        Mon, 24 Apr 2023 04:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1682334274;
        bh=3y13FUQ9mzAd0pVsGACwnTzhc10tadlpX2k4sRWjS4w=;
        h=From:To:Cc:Subject:Date;
        b=zwSYVKAJUxQDW4wtCb9H040WwY/9mQ5N6dKvGeTaJxQpE1hPpVZNqb8MuHtx373aZ
         m8Lhmzo/uXqjvRW0/djwck75vrcfs/eqMxZYoqnTewzUqwwF1uQfVu0OuvY8kPs5Eu
         HK/Nl0XPCpl8x2Mxg0F23zGi7Kgia/42kBh69w5M=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
        id B89210BF; Mon, 24 Apr 2023 18:46:09 +0800
X-QQ-mid: xmsmtpt1682333169tx5u2whmb
Message-ID: <tencent_3C22A3418CD06196C2E5A84AE3EBC2281206@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8RDwxHIkBzZdjRaEtCh0I+YGocyU/+FZyxQmJ6SHZyCb6SAPX0k
         IewVYcKOGqK1OozwInrJ0bAFoI8YqL3ep8IX8+8zDi+p2r7rdzqhi+tFvkZmp/zV7et+9EATKyhv
         fUff6lN03lUSivY7bi7WaNKCGnqwOrcASS4XrH99cqCwYtE1HqF0ZPWnKAxkXctGuwqHQpgVxMfk
         juI4fhbDxRykKdzoW/dR1c1vrE6SVH24f95IfCM4zXAQxPQDpYm7ZBjfAcGLqny3kPAUpf9mIDCN
         wjZBQvnBhEkgIwzrS4H0x7rvBsfEvc0QeFy4P+NGXNCY5oHLvg/MklMuvFf65Y3WWtMmMkE6mhAC
         Bfc5d0PBDAHra+gwDeTlqNzlisoMD/uKjRMQ84ZZI/7pUfTcrXVs31fraDfMPyEDyAWvTN4W+RZ2
         fQf7zAQbnh9JZpt/lkh+tuuU/0y6KTzh7FQTc7ZmIS7z1IKfNpRTabxOR5GT4BUxQrjYNOX+GMjT
         +7Jj6I4nn8M7I+IOgS9krBAODvnTUqhe2EjUy3uNkVLMVRmHT9Vq3HUnmgDyTp1Ww8bKf+X5I/Zg
         Oz7V5M1Ct5qUmM/RSHqr9Yf2Rod5nALA3CG3djnKQYVvNvAcjLXRU4uJXcdlwasXDdie+yu0m+SH
         bA3kndb00HQrRlQFCWf268tjByAkHiiwheIB7La6HH/+Tia/ibB38fmRx814qLywFT/nQ+x4GijX
         cw5aIkkkii45CTRt3E2+SpToUzHV0tltznkKudaVKvgFzVZ8FD/vzI0zZCfDARbNvGj+Arpftyzc
         4D78hotcYLHDwusT0nhZJYAMSyGI0YvLGFu0zWA+XXY06bsMBtJ95IPDmVgpoC1Zh1vjHXcqItob
         8SsdnTA/4kV2SFPsZdvmESI7Tdhjw9ycQANP865MhnKgPzzsdUDqcKbE9ydd+zBV33v1/z5J6qvv
         SjYCugESLV1LqZ4F9i70dWgvQeLjqITghKl1bCzt0za6OL7zvNXKZkrpns30XY
From:   Rong Tao <rtoax@foxmail.com>
To:     bristot@kernel.org
Cc:     rongtao@cestc.cn, Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-trace-devel@vger.kernel.org (open list:Real-time Linux Analysis
        (RTLA) tools)
Subject: [PATCH] rtla: Add .gitignore file
Date:   Mon, 24 Apr 2023 18:46:06 +0800
X-OQ-MSGID: <20230424104606.47485-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

Add .gitignore file to ignore the rtla binary.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
v2: Improve the log and subsystem.
v1: https://lore.kernel.org/lkml/tencent_8042C05909979D2A1AAFA8A3028854065808@qq.com/
---
 tools/tracing/rtla/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/tracing/rtla/.gitignore

diff --git a/tools/tracing/rtla/.gitignore b/tools/tracing/rtla/.gitignore
new file mode 100644
index 000000000000..e9df32419b2b
--- /dev/null
+++ b/tools/tracing/rtla/.gitignore
@@ -0,0 +1 @@
+/rtla
-- 
2.39.1

