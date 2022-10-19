Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2236046E2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiJSNWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiJSNVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:21:38 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7126C1C1178;
        Wed, 19 Oct 2022 06:06:50 -0700 (PDT)
X-QQ-mid: bizesmtp70t1666182659taljh1go
Received: from localhost.localdomain ( [182.148.15.91])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Oct 2022 20:30:58 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: znfcQSa1hKa87pgj2S7F3qPfeuk3/1Pt49V0OdFtVp8joR23lTLnZU6Yv2SK4
        Uum81LkoPLRHJWaGjN6VeWVTsqbyPMfb6RpG9GyRrZAWF1XyDZGp8iORbEOfIefb6V7cka6
        J1I0RQcbCZYIqd+Dn46n42eUZZf4e+HrYxdc79qH44PuF5CKCS1+AEWf1NqW1D2AXy2/KdU
        TFocDz+3DL+Le4hNida3YlO+VCv0Mzb6RVlNNEmMyI2WFXGgwZfk/WeRsP1fkKaKY2U+wzn
        sG2bSpAMKNqQtaDZUcFgHQuZmHdCgcyQUZORZ0opcTtAJD7sdr0Gzl20Q6kLtxgmFN45yb8
        kPgiCKYVSxnHoDwzogcgV1VN2qwkOqj6kkqjTHaDwXu09MaxVY=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] input/serio: fix typo in comments
Date:   Wed, 19 Oct 2022 20:30:49 +0800
Message-Id: <20221019123049.26196-1-wangjianli@cdjrlc.com>
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

Delete the redundant word 'in', and add a word it.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/input/serio/q40kbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/serio/q40kbd.c b/drivers/input/serio/q40kbd.c
index bd248398556a..ebc9f9941be0 100644
--- a/drivers/input/serio/q40kbd.c
+++ b/drivers/input/serio/q40kbd.c
@@ -81,7 +81,7 @@ static void q40kbd_stop(void)
 
 /*
  * q40kbd_open() is called when a port is open by the higher layer.
- * It allocates the interrupt and enables in in the chip.
+ * It allocates the interrupt and enables it in the chip.
  */
 
 static int q40kbd_open(struct serio *port)
-- 
2.36.1

