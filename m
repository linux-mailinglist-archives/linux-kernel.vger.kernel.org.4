Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207B0604691
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiJSNPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiJSNPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:15:01 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E181C2F21;
        Wed, 19 Oct 2022 06:00:33 -0700 (PDT)
X-QQ-mid: bizesmtp82t1666184265ts1d409a
Received: from localhost.localdomain ( [182.148.15.91])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Oct 2022 20:57:44 +0800 (CST)
X-QQ-SSF: 01000000008000F0I000B00A0000000
X-QQ-FEAT: k8Irs33ik7sILmaHIJIKazcpedYQTXSyVb7gcd1y8saozIYNH5bXRuhnQO5B8
        SWZ9upd814P4xShyibxu61MWNqCE8tch/gIjSZItSK0/xuHX4awzX672bkvgOXGzhe4vIkX
        RvejmXyU5Es4iw7TyTMNh7yFak8YB0eUd8pH5ajNJTF77j5d5lLdBU00yvQ2HHcQVmxzjH/
        4G3B/HzwGa4Je/LB/JW3rv7FIwybuXP0JrSU9QiCfVGHJ53Wta/9gTphZ9Eb6wkkds4CrS4
        f7TAdFrPppanMdIb4x3L7yTFytEOLJW3QcFIPJVCmcaid10Dl03duaerDT6isFmidbTFNF5
        E8JlTxslIHR2Q2Uo85eGpOuhSE2ojkhg8mro1igmXXsRUDL/h9OurpYGMDdIlnN7ley0iGk
        oNDHIOIswnM=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     thomas@winischhofer.net, deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] video: fix repeated words in comments
Date:   Wed, 19 Oct 2022 20:57:38 +0800
Message-Id: <20221019125738.54964-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
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

Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/video/fbdev/sis/sis_accel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sis/sis_accel.c b/drivers/video/fbdev/sis/sis_accel.c
index 1914ab5a5a91..5850e4325f07 100644
--- a/drivers/video/fbdev/sis/sis_accel.c
+++ b/drivers/video/fbdev/sis/sis_accel.c
@@ -202,7 +202,7 @@ SiS310SubsequentScreenToScreenCopy(struct sis_video_info *ivideo, int src_x, int
 	 * and destination blitting areas overlap and
 	 * adapt the bitmap addresses synchronously
 	 * if the coordinates exceed the valid range.
-	 * The the areas do not overlap, we do our
+	 * The areas do not overlap, we do our
 	 * normal check.
 	 */
 	if((mymax - mymin) < height) {
-- 
2.36.1

