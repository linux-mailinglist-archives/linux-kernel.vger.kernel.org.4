Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836CE6B1B2E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjCIGNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjCIGNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:13:31 -0500
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20135FEBB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 22:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1678342403;
        bh=Fbuox8QW2JDjAeHw3oLM723lCtUM2XciyiEPjQ8rQlY=;
        h=From:To:Cc:Subject:Date;
        b=PHISvihbJ+67p8CJxaN8drK0KLxGBXzZ6/NFaZIo61cSo6X2xjbHkqO0gVxEqoZaP
         zNXv0gsYv7jB5NhEcPhVk0mhDckcIgOJrDcODLmbW9sTbPEYMUsPs48XIz4D1aPP7u
         Vl1ktok9dk5uKia22SIiVdM7HgWVVNL45aa6eZgg=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
        id 3559E6D2; Thu, 09 Mar 2023 14:13:21 +0800
X-QQ-mid: xmsmtpt1678342401t4e66esh6
Message-ID: <tencent_89579C514BC4020324A1A4ACA44B5B95BB07@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8PsoUArMVLcSk1Xpwh7+bVG1cJS9O/CbP0bdPjXNjbYkjnJdAzY
         QK/J67TtJeqUlj25+QWrnIqBBQFUsWDi0fLvE3IIwlOqAB0ZTWUgqCSGnQ/BREhASD6COX+tIjFB
         y5zKTHC3uy2xjp++OfFYk+Bj1ogRidwXbN0na2hDAhbVQ6SYlqVDme93YxDFcdtZMcb4eSAHzG0T
         n+G4KJdm3XCxSZJx81TSGNN7VyquwIQOHm6mcSUUTXIqBHjfYwPzLNRcSvBSRi7ObJFkLpdhtM7e
         09K4KKFg5mANnLfryzD8x2hCFxgRat442NbHPojnq1Yu248neb8uKQSklRs6//lhkl8yxo5yyK4u
         OsDLKhr69JGGntOwhiTHH9gmDarTzveKwLxy08lLedDy54QFkcpBYsf7LPp07Dj7paqW/bZ1szY2
         wZ33HbVAWXYsA7swrozYCRbuQ/7maWx8m7nFDTgRKUKBywe/mGaR7DrlqdsRpFi3PuF+ytNg/xlR
         0Wyy/85hEcPLjLmoMHP1Jlyc5nqXXU9oiY37/RrwD+hoTvbuSE0kIQWhZ68PTJcQyhRdf6bMkGS5
         vK4QxaZL4Te720aWDpuXDFYashXsJtCRrxspvbg9xdm2RzYIALMsshmNzWbRjkKpEuUTQe+rAJg6
         4NIHpV4scw5nPv1fsoHPisuBzQ4Tz1A2xla0ScAJZax1ApdztwonAsglLi6WRAuCTwjOU5RBIKbx
         Uh2bcFW7hvbZAWDTp82zcqQ+nODAvdQu7ig0dusa6TlECU2Q5t9bTtuaePXgc0oVZ1exflAYXlhM
         oADxA0LP7AlTl13ps8bWFRAbImEeCK8GpPoqeVoWIGiemhaTjtsDQ0H0lYF2bJREymSAJmXUkQJ5
         moIPQmh7M42E/bk2H1/b+2ePSplXd3m4ep1NtoZHtSJlT1wdHx1ebLgABPUv0tjUvJL38Huv5HXA
         jBk8foyJ3PR1b+UnpGzhBY7rdnnLaZYmhM5K6GwAfMz4jXeokvjJFmEFj+th0VF4mvLK4fiR8=
From:   Rong Tao <rtoax@foxmail.com>
To:     sgarzare@redhat.com, mst@redhat.com
Cc:     Rong Tao <rtoax@foxmail.com>, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO CORE AND
        NET DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] tools/virtio: virtio_test: Fix indentation
Date:   Thu,  9 Mar 2023 14:13:20 +0800
X-OQ-MSGID: <20230309061320.30123-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.1
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

Replace eight spaces with Tab.

Signed-off-by: Rong Tao <rtoax@foxmail.com>
---
 tools/virtio/virtio_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 6e348fbdc5d8..44409a311580 100644
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
-- 
2.39.1

