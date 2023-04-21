Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEB66EA9ED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjDUMEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 08:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjDUMEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:04:42 -0400
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8940B49E1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 05:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1682078679;
        bh=5/uODYlvVyCE/ZF+EkuMLcehTyez19vBG2MgS39y1so=;
        h=From:To:Cc:Subject:Date;
        b=zC+W5FWeE3MuygI2UKBoaggJguo3IptS4zGo53HgMlHjI2RYviMC/wmyyZjNyTXxp
         Fc37UxlhyPC+Lcns0yRhwVjwKUJA3WNgv7Z4z6hU1T8C1bseucOwRCm9MKaP40rL1s
         bjLfApPwj/7kCBLrmD764PU/DMj7OejaXwrzDDCQ=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
        id 124AB2D5; Fri, 21 Apr 2023 20:04:36 +0800
X-QQ-mid: xmsmtpt1682078676t7gj1gxvo
Message-ID: <tencent_B2592997622AA2AF59A31E88DB069C424408@qq.com>
X-QQ-XMAILINFO: N3l5ASPewLWqzZ4BwtTGxMe6MnXfHNzqXtd18wOTO1YoqtR7na9dFPR8zfpjYz
         2dhQDT2OJNtjx+mf1/Acb4dMS4YK+62KB7CGyhxlaihPIKz9lN1pRARLTcjthO4AyyInwZ2zdcM4
         r6OlPWYLQPhrtqHWst/x39d53+R6ii9ltJxPIq+liIp0+hTniwJujnzLqfwgrdcq+3gYRqYsFToE
         79f0lHx3l76dX9V4NEcpa44eD7+KP1zzVHHCZ93V4ZIR/JZ+qV2FVFjw90NtM7xz+XGcqpkE+Vfy
         Eiw2mc2e63qvVM7SPBtpLLBaSNTH9GN4R//AlJaaxP9Lj4PeNnhRV5J/lkXd8tS4aq3Fe/7rMm1P
         t4TPml/Jr7tEIVd05wZ7VeacpOxNljOY6EZYu9r0gYqE03fmyqPs6v3PCU/sRS4DvtjEMWqoFcQp
         /5LSSoeShTGqM99QOKQu0A2BG6ltxzKDyBMwSez9ZogZ+Ve2lZ4vaPv+VJdlfVucluSg9DYiwYrD
         x/6ilG1Y8L2XFvgiL1V1BBNx+qX5ldxRR9SjuSx/3BOfjUvbFLME297LDxXiXZSZApOnSG862o4z
         5UP1vQ52YsrXfUXXMS1ybchfzzc/gpiRKMsgxpcy/SvuorQsGDICsgNzMFR2K2f6lRJuVQptLQkW
         CLxSmydDm2hVqCNDHMd+DISzCiKBLtlCbTYiA8KwsCPwt50C+Xi4C9jca2q0iy6zwl+eiLVMfvvH
         Jc/u0OeT3N5sBQPJjf1ZaI2f1GE6kPro7YFxOQIr185z/DJpvCVIxGws5h569wEGfiQom8SBxlCe
         hmE9UwD0ehZTN9WgO3kQPUS98pM66JpoxfQEs2jg6d78h1E08q869MUjKne75l619AUC3clM5F8H
         kProxmmyQi09aPqdScJMc05vAh8kqyzSrVIjUi29qdIHug9fqcyV2rJpRASuVPMevGLtgx/kaNp8
         FOwxPeQ8hp7JRI7pvNyRZijrImNwpkyXMYzaT0jQId23IZOoLCsw==
From:   Rong Tao <rtoax@foxmail.com>
To:     mst@redhat.com
Cc:     Rong Tao <rongtao@cestc.cn>, Jason Wang <jasowang@redhat.com>,
        linux-kernel@vger.kernel.org (open list),
        virtualization@lists.linux-foundation.org (open list:VIRTIO CORE AND
        NET DRIVERS)
Subject: [PATCH] tools/virtio: ringtest: Add .gitignore
Date:   Fri, 21 Apr 2023 20:04:33 +0800
X-OQ-MSGID: <20230421120434.238082-1-rtoax@foxmail.com>
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

Ignore ringtest binaries.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/virtio/ringtest/.gitignore | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 tools/virtio/ringtest/.gitignore

diff --git a/tools/virtio/ringtest/.gitignore b/tools/virtio/ringtest/.gitignore
new file mode 100644
index 000000000000..4c6f4bad6b5d
--- /dev/null
+++ b/tools/virtio/ringtest/.gitignore
@@ -0,0 +1,6 @@
+/noring
+/ptr_ring
+/ring
+/virtio_ring_0_9
+/virtio_ring_inorder
+/virtio_ring_poll
-- 
2.39.1

