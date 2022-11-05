Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D868761DBBE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 16:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiKEPwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 11:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKEPwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 11:52:17 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA47DF73
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 08:52:10 -0700 (PDT)
X-QQ-mid: bizesmtp91t1667663523txn0ij32
Received: from localhost.localdomain ( [182.148.13.29])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 05 Nov 2022 23:51:52 +0800 (CST)
X-QQ-SSF: 01000000002000D0E000B00A0000000
X-QQ-FEAT: ClLnYZSF2IvtW478ofI2IHhbJOKmOFe+9LilYZJvfuGI/D02gLAapdAzgjFTi
        6SRLoc+1L6rAWlbgwt4fN6TlKd47IY41/oqeoUIMGZtwMyZBUw6jtov6MGVm0jatxRLEAsm
        U0RqhJWn6ILB5/vLa07cxCREhHKsyJRwaNOVHS1uWClDghweJwaFyPN8rxeMYeeSJ6+nieW
        cv52TffWYxmG0h/pWfHNHe9aTOPBU8O+H5OwwoGBR9OzIIF25zVqQL2mXkdYzYcFSEaLY6M
        Wvq+HJim9TfAkZj9x0XPMUn8KkfIV/9yjvodEePqC3a4mzfb9SUtPta0gi2enOKQUKlDu/o
        rnqQmhWwxjHaBuMaB+mxzOshKNYau00J9j8N9bQvniOj2XYf69omNBwIodJww==
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] tools: Delete the unneeded semicolon after curly braces
Date:   Sat,  5 Nov 2022 11:51:51 -0400
Message-Id: <20221105155151.12155-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unneeded semicolon after curly braces, so delete it.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 tools/virtio/virtio-trace/trace-agent-ctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/virtio-trace/trace-agent-ctl.c b/tools/virtio/virtio-trace/trace-agent-ctl.c
index 73d253d4b559..39860be6e2d8 100644
--- a/tools/virtio/virtio-trace/trace-agent-ctl.c
+++ b/tools/virtio/virtio-trace/trace-agent-ctl.c
@@ -75,7 +75,7 @@ static int wait_order(int ctl_fd)
 
 		if (ret)
 			break;
-	};
+	}
 
 	return ret;
 
-- 
2.35.1

