Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77E07107D2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238947AbjEYIo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240371AbjEYIoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:44:18 -0400
X-Greylist: delayed 72749 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 25 May 2023 01:44:08 PDT
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CD1E42
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 01:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1685004244;
        bh=i4JEJ+iedFMD6KYt68n+jBY5d6yW9GHI2pIwF3VrG6E=;
        h=From:To:Cc:Subject:Date;
        b=PAgnP96kt4tH9Qv+2drPpAc1jTFSdowH5dpTQ3T7OKGfrfHH+Nzhod3ER/Y9NGgQk
         GE1H2lnQ+tkP3/Uvh/QbSco+LNdeAc+E0F79GwJRqOi/Bl3DsO/aMTo1hHL8oXuVAs
         GGHMBSA5dZG/XhIK135+xpsZq8mG0KxhiuDbM3vk=
Received: from localhost.localdomain ([39.156.73.12])
        by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
        id 95F03E33; Thu, 25 May 2023 16:37:31 +0800
X-QQ-mid: xmsmtpt1685003851tlop1r3kr
Message-ID: <tencent_C121802C93CB4095C6D7D95113442E830A07@qq.com>
X-QQ-XMAILINFO: NZzGjqyvvdMf3CIm3NRvKWvf4w2LJXGJBmFdxBUX8nKHjbCHKx88KiV4xnC/MK
         X50X3D9GiGHM28l6Q4K8avJ9hAPGZeO7XviIIplWP8VP7LZGu6ZQ3OqW10NUTlqwUdg62KW5Ic+C
         DveeQxN9107ZK4608lLEJFCCoAsn7gm5xn1jI+adS7hCH9mwpTovczuoDPTTCVoRyaWl/+98iJz6
         yusmciq20K5ejhHhyDVOioD0Nv9u1D59waREjFx0UlVs2109DmkWj5cT7j4euOggH7FT0qpiTGUw
         kmWo1fXjsdi6Y8MM/vh4PXUvZchB1JmVpSqyyfwncYoaGUVN1yrkywNabMIx0OKGCh1NdJoUxXOC
         olxR51n8hWSTbioy8kt3oN6dYtSQUIeiBR8HJx2Hk7htEkMw8HyxnNQiEIfcSKKnfTjceHkMHSmH
         uQDB8DKNWCNi8T5bQVLcDtbfpJCxDEnfvA5NoDAMSi5LlH6RLz6n73VDBKmIsVjVxdLJHfPf+Cpe
         y9ZX5w+CFAOzjFYPwz/Zm2qiTeXgER4RXatPWhfxeWjlndxgqzV2oEpwT+YG5kfbYMYudvUstb/C
         HJeiHHOaurW/i7+1PhRXeDtO95Ev8gjt4uxFPCNtWbnwTq6Hzp3t6LVV7MRFaLs3Xmuvjp16B0b/
         XaAXnjJ7lBwxYXIwOSRdbymXTq6Qt2eqCftegyNEEAXgcpl1Z4s96IQAsCeGE6utYuaqL2psOqIL
         uT5nQCi+NTqN6Klp25kvwnmjA0xJetcF9qsFrPwgC9Y4TzaMwK0cby+OAnAfLolSpzTM88bO4Ycu
         CkYBwsaM9eumHOMsUEuIkz3UO1Pjdzj/0/tQQjMPbcQ7ndtb24Kzn4UTIxWpy4t0XPULoEBTS70x
         JrAHLh4KEQ4eHd703OySug4mU6Ndmx8EWzBvGbYKR/O1Q3yv3LkuduwBU7qRwqRiFyfFpHZJ0fqa
         jO6YeJIWcwEz9P7c3IzMUNnK75s6AsTDe/gS3rMXc=
From:   Rong Tao <rtoax@foxmail.com>
To:     mst@redhat.com
Cc:     Rong Tao <rongtao@cestc.cn>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        linux-kernel@vger.kernel.org (open list),
        virtualization@lists.linux-foundation.org (open list:VIRTIO CORE AND
        NET DRIVERS)
Subject: [PATCH v2] tools/virtio: Add .gitignore for ringtest
Date:   Thu, 25 May 2023 16:37:28 +0800
X-OQ-MSGID: <20230525083729.26278-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.1
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

Ignore executables for ringtest.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
v2: Fix Subject and Description of submission.
v1: https://lore.kernel.org/lkml/tencent_C8F0F579940491D14055C82FABE812478505@qq.com/
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

