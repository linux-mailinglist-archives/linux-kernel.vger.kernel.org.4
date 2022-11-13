Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30139626DFB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 08:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbiKMHIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 02:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMHH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 02:07:59 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC6213CFD
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 23:07:57 -0800 (PST)
X-QQ-mid: bizesmtp81t1668323270tpde16i9
Received: from localhost.localdomain ( [182.148.14.167])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 13 Nov 2022 15:07:49 +0800 (CST)
X-QQ-SSF: 01000000002000C0F000B00A0000000
X-QQ-FEAT: znfcQSa1hKYhS27UA+q06IKqpzKTS0snZmcKK+0hJO9vMnMh84IlSk8dLgbmo
        SoYS0nq+dCbBmdN0K66zDzrnSaYJKaDGfHp7nJU0+OD9Xrwbu3KU49jDvD6gm62bGY2ix3n
        ZWYzXGWkkIjJdKLiAsHZtXvsNUp1QS+/NXIAr0Y6G2NWJkmEJ3L3fssaUinQSTd+6YQbjXU
        LVsR+X69ZhYk2WFnLkDVe6rBHZLEx5mE35ZV4lDfI57ReVxiJ8Oxq4YnkWOjmcgAECqTfNM
        THYPqeFngql3CNozJN7X34wcMpgjv+Q2IGAI+/X2QbMy7F9PuZ1iVrQO9Gylbc0SQ9lRv6l
        +ILxh2dxgx66YFj8IJOkzLFYtUYgg==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] tools/virtio: Variable type completion
Date:   Sun, 13 Nov 2022 15:07:42 +0800
Message-Id: <20221113070742.48271-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace "unsigned" with "unsigned int"

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 tools/virtio/virtio_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 23f142af544a..94eb96aa2e3d 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -173,7 +173,7 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
 	long started = 0, completed = 0, next_reset = reset_n;
 	long completed_before, started_before;
 	int r, test = 1;
-	unsigned len;
+	unsigned int len;
 	long long spurious = 0;
 	const bool random_batch = batch == RANDOM_BATCH;
 
-- 
2.36.1

