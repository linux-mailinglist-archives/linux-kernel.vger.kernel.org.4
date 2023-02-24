Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB5E6A1D6F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjBXOak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjBXOai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:30:38 -0500
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABB864E25
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 06:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1677249033;
        bh=W3vbmfyZv8kgZWgDHqtjr/Qbr0uqZvAd9EBnAPC1r48=;
        h=From:To:Cc:Subject:Date;
        b=VyfK0ekRXk+ILxGydbna7SOM3fd2mBN46hf3hS2CyWjvWYLcF9odQpQEZJN2Z+5QE
         43b7gJepztgIgiIKvGMuvq+4aoEyIlfSyFsGOLwutjQqm7mKFE/PLBPMUD81qNr6Ya
         ShCaoANuklR7UhyBFBnRVsfr3PmcL4U5KxVw3pZc=
Received: from rtoax.. ([111.199.188.149])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id 79FB9AF5; Fri, 24 Feb 2023 22:30:31 +0800
X-QQ-mid: xmsmtpt1677249031thxy3muds
Message-ID: <tencent_A95EA946D511450DBE8486B2122FA1549609@qq.com>
X-QQ-XMAILINFO: MTmSu602bpi0NiHlqYwpI9anlZQTJxBil0Q4jE3kJ8tMeztO7+KOEy3BPVCAER
         j80IWathpRfQP5+IF3vQPVR3jVnfw7T6OJD7uyXdnBkfwtmChgKSQz/Xv/wW0umFlWAQKZ2EFM0i
         w+K+7J0NxNxIjrqzkXXqdaJrF51BMmVFqoUgdAOKQHzNM7GLNem3EzECXZ7p8+TkBuFtzlC81vQx
         7sQsXhdfsc5ltniJzEOT4nTabNBW1e1p6MLp+ydM3+oxPXewQqzbe/VUr9pRlXSHBK3TjyFQzFNY
         0mMrxnlvN6cPJsZXeB0VYVSQcvZlS99rgx8EYtj0vOWdK6+bkzE5d+q3JWId+GlyegqxnrThpB40
         RAOD36XH/X350+IaigUhA6c2qO650pCtlrEFqQZ0Zac1wlykqlGMC8wyY+3y8G+tjZwpav7y0iWU
         Q08hUByLoHB4K3rLVTRaaqqqI6ojIK8gbihZOZx5+IKp2O3Sr1ujoDAzxSaOZBYZ7s8oXV6zALXB
         0kiJrYFDcMZYfWZYj6QeFR5x26m7/6q0dcdEf8aUNIDUeGwKYIXWzpQ+2oNydYF/IRIKRSYgMuLH
         8eqqnuIdqAOZhDVGD/IUCv3hMAhD5zCz752XLLFaXLkX3vQVuQV7OEo/GvXviEomiqbznfhFeG0Y
         6uD2I0yDzNVFUrmzZJLSNJvV6pW31KrA3O5z4DJcGfvAXcv/huwqDx0nZzvKshaMaoO7LKfn78nA
         r4xKB7pfxj1iHaugCt6UQns4eytCgFM9+9ruVb8RXQpWtpUhlXpTIwBiYZXnnVFFxQjzUywV9MMG
         1tYQ6bB0ARhNbUyGMtS0WrZv2RBF9Fgr36BTd6XTpx5hhLMMbIW91dF90TpCZ2FUO2I3SBRLc326
         9ug5Qk8a4v7SzPPKUBMGsyY7qZxGqY44fnmPzQ4LbQaItPmRy0rflMEc7fa08gQF1QnklMLcLhLX
         6PRj8QR8jVuoQ/EM5CKhVdGqpJ/nCT
From:   Rong Tao <rtoax@foxmail.com>
To:     mst@redhat.com
Cc:     Rong Tao <rongtao@cestc.cn>, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO CORE AND
        NET DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] tools/virtio: virtio_test -h,--help should return directly
Date:   Fri, 24 Feb 2023 22:30:30 +0800
X-OQ-MSGID: <20230224143030.549967-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

When we get help information, we should return directly, and we should not
execute test cases. At the same time, the code indentation issue was fixed
and virtio-trace/trace-agent was added to .gitignore.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/virtio/.gitignore    | 1 +
 tools/virtio/virtio_test.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/virtio/.gitignore b/tools/virtio/.gitignore
index 075588c4da08..9934d48d9a55 100644
--- a/tools/virtio/.gitignore
+++ b/tools/virtio/.gitignore
@@ -2,3 +2,4 @@
 *.d
 virtio_test
 vringh_test
+virtio-trace/trace-agent
diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 120062f94590..6370cdada396 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -134,7 +134,7 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
 	dev->buf_size = 1024;
 	dev->buf = malloc(dev->buf_size);
 	assert(dev->buf);
-        dev->control = open("/dev/vhost-test", O_RDWR);
+	dev->control = open("/dev/vhost-test", O_RDWR);
 	assert(dev->control >= 0);
 	r = ioctl(dev->control, VHOST_SET_OWNER, NULL);
 	assert(r >= 0);
@@ -142,7 +142,7 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
 			  sizeof dev->mem->regions[0]);
 	assert(dev->mem);
 	memset(dev->mem, 0, offsetof(struct vhost_memory, regions) +
-                          sizeof dev->mem->regions[0]);
+			sizeof dev->mem->regions[0]);
 	dev->mem->nregions = 1;
 	dev->mem->regions[0].guest_phys_addr = (long)dev->buf;
 	dev->mem->regions[0].userspace_addr = (long)dev->buf;
@@ -361,7 +361,7 @@ int main(int argc, char **argv)
 			break;
 		case 'h':
 			help();
-			goto done;
+			exit(0);
 		case 'i':
 			features &= ~(1ULL << VIRTIO_RING_F_INDIRECT_DESC);
 			break;
-- 
2.39.2

