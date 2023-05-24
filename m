Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7999A70F6AE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 14:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbjEXMld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 08:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjEXMlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 08:41:31 -0400
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0567799
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 05:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1684931786;
        bh=JGWxk87Z43TZYSnzi2dJH5CSVLg92GvmRDyo3KDv0FM=;
        h=From:To:Cc:Subject:Date;
        b=aBcFyo7izmyXdN3obdCVV0ymbtIfYtFf/Tiu5M8Gt87Mw/0U9T1pGKG74IYApE/AW
         uwUFHrt4unQzZazSlz6FKtEwY7aW2oAZCj+KMjKUYqlyb8QAYT9OCBALPnfurLXFlE
         ZLLwF7nXgZAqFZPbfdy+upMtiyv8bPzeBPXG1QgU=
Received: from localhost.localdomain ([39.156.73.12])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id 9122F6CE; Wed, 24 May 2023 20:36:18 +0800
X-QQ-mid: xmsmtpt1684931778tom3rkbyj
Message-ID: <tencent_C8F0F579940491D14055C82FABE812478505@qq.com>
X-QQ-XMAILINFO: OaoBA5NOFC/jAyZy3vp35Q8l6r7+do+v8CHKGL7ksvQ1aKQqEvDwIL3tSsjE86
         WQMw3vnyYWnhH4hIyEFSE/lG/6jDwrFVClIj+MxNTEbXMwC8bn0K63nmnt/Pmj8BQkVU4seC9xGG
         y8Zn5oR4lDXJH16oSUVQRFDuqvaL4SJUy9Gvw3iANr7QuS0t2pK4rHIyKQ/ZaPuV+hJqZhP+YASG
         PGWqGrIavyo6p9yzlVcqC9i9hUMQIWXp3i7jyYNKB9Dp1smdL9LrN/id9x5xi4/5gk6rg1ZFYTqx
         Ot/s0IeyYC6rB6aDTcwQnPwiHhyKOMifhTqzKlZDn/6e+l2U5Mr0Ac6H6I76vNIZuqYq1oeAaYjy
         Q3gumPZ/WwCd1pxwsrY+k2DN1taSKgi8VPi94vQE3FsfGjE3K8KS0SRb4fgPV9fde/63YqrLPfS8
         B2mwkfR3bVdVbo/MjblT/b8eOuXdIw4vCq+dXu/IDuZ+CbwCVAfMNr8Ve7bpnbDhr89frM6+VYZw
         PYotKWeQ3DN0Nd8I7wbL4caxkmOF1MVqM1Bc7wA/nH235JWKr9GjjkohLyD+bDsZUnjhhu8pPW49
         EM9BZSXNMMxCQ7ra0RgaXXjqh9v/Sp+b32nCNh/6Alo6edqbGJFNEM60QJa6Tp+ak84ypZUP98/z
         RiKwowodyXWgwFF7nZ0uq3qJv/6qFo/GMGgc+nFilMlwEK6Q6m5lGmTVU5VLtyVzP8g9UZ5gsgIv
         i6GoLDJ6DVP69BYGUOkYFCUABmp0nU9t8DrlA0Cj8/SIlh/BJYUvBSnEjKt51RBUydPvlLnPASlS
         T0zyXS/4IVgUP+DxD+CmCa0I9agELs0f41aiSghP/G22dTSaHmS9GyE2XHnW3bV9Qo8BpDYqqdOz
         0nqdfs0MZ81QkfO6M7Wi3a7aaZLNienESvVw5/BkiJwKlKodUgvkHmjOkC9Y6i81QVHrWclTSarq
         u+pGcqxbGcIcplWbXmVZWgoSjS+2Bx
From:   Rong Tao <rtoax@foxmail.com>
To:     mst@redhat.com
Cc:     Rong Tao <rongtao@cestc.cn>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        linux-kernel@vger.kernel.org (open list),
        virtualization@lists.linux-foundation.org (open list:VIRTIO CORE AND
        NET DRIVERS)
Subject: [PATCH] tools/virtio: Add .gitignore to ringtest
Date:   Wed, 24 May 2023 20:36:12 +0800
X-OQ-MSGID: <20230524123613.15082-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

Ignore executions for ringtest.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/virtio/ringtest/.gitignore | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 tools/virtio/ringtest/.gitignore

diff --git a/tools/virtio/ringtest/.gitignore b/tools/virtio/ringtest/.gitignore
new file mode 100644
index 000000000000..100b9e30c0f4
--- /dev/null
+++ b/tools/virtio/ringtest/.gitignore
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+/noring
+/ptr_ring
+/ring
+/virtio_ring_0_9
+/virtio_ring_inorder
+/virtio_ring_poll
-- 
2.39.1


