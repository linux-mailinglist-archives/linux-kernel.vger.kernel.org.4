Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2677160849F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 07:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiJVFgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 01:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiJVFgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 01:36:17 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB03A28B1FC;
        Fri, 21 Oct 2022 22:36:13 -0700 (PDT)
X-QQ-mid: bizesmtp63t1666416969tzmap60o
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 13:36:08 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: r/cTxDoDoiHtF+qYAVJu9vtCCJV3DBLH0AuDzXdVIaIYzdJI/plmbSJG/poTi
        f8FWgJBNC5GsvpMTk4rwvAGIK011LhmQ5n+pNVuhZn6maA/82oSYG/rPr+JaIHgYa7K3trM
        6I+bAlbLZqLQUDKOhd3sIU/Z8R7oSpQyAf8yKUURdYGKz8UeHxucVcYo3jwWkokZL2wgucQ
        zJLO62qhpuecQLB7oe5kpnoaTIrslVOTLDmuzKLb41DtQJ9gzF6m7n11JLvTT65hUGl7x+K
        q46k3W9AohUOS2SSk0LY34u4sbk+SJvnDKHdGDahcWNOOMsjE4yYNwoaQrZasGZLSKG6Zys
        dia0Ke3OIkT+kBXwmjjBs1FieekT2ZnGfaH1z9x8AdicvwltCU=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     tony@atomide.com
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] drivers/bus: fix repeated words in comments
Date:   Sat, 22 Oct 2022 13:36:02 +0800
Message-Id: <20221022053602.24624-1-wangjianli@cdjrlc.com>
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

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/bus/ti-sysc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 9a7d12332fad..a864f24d6b4f 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -912,7 +912,7 @@ static int sysc_check_registers(struct sysc *ddata)
  * Note that the interconnect target module registers can be anywhere
  * within the interconnect target module range. For example, SGX has
  * them at offset 0x1fc00 in the 32MB module address space. And cpsw
- * has them at offset 0x1200 in the CPSW_WR child. Usually the
+ * has them at offset 0x1200 in the CPSW_WR child. Usually
  * the interconnect target module registers are at the beginning of
  * the module range though.
  */
-- 
2.36.1

