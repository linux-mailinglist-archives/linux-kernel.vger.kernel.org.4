Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0491604C8A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 18:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiJSQA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 12:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiJSP7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:59:52 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FD3FD3B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:59:03 -0700 (PDT)
X-QQ-mid: bizesmtp71t1666183802tlgerics
Received: from localhost.localdomain ( [182.148.15.91])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Oct 2022 20:50:00 +0800 (CST)
X-QQ-SSF: 01000000008000E0J000B00A0000000
X-QQ-FEAT: DQ0OCu3gog1uiiZDEKgAU/wvBbW9YxYJafQDS7SVRvSI5YDJn7cNLvATPyVBQ
        xGqbkfwHYzbSw9GT7oenYkl102k1gjAgwQm48GgN40dmsTrFfTC+iw6vymCsrSj4KC9HbrL
        9Hj1v9mv5KcKXuBpr8VD4aNZ6E5YY3gAyXSu/eCKabKBD4Snw0Owg63fUDCwURYnYY6csMS
        HdujbnaxnsFnDOUczi5pYnlt4/0XuvGr1nHcWb15CFw7H/CVbVmF6vkHBe/xKwoDuK5Q1rc
        k/kGresOxboDYKJgbSA0B9QBnMdM2D6g4ewBpdgOoNRFJsUZz4BbW0g4OECECTabawRMOWs
        +cDWB58GSmJwYBg/eoBmABhdQDvhSsNXZEXu8Iq18HiLrDH3S45JjnmoTDR5w==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        alexander.shishkin@linux.intel.com
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] coresight: etm4x: fix repeated words in comments
Date:   Wed, 19 Oct 2022 20:49:53 +0800
Message-Id: <20221019124953.45885-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 80fefaba58ee..849c563cfc65 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1478,7 +1478,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
 			/*
 			 * If filters::ssstatus == 1, trace acquisition was
 			 * started but the process was yanked away before the
-			 * the stop address was hit.  As such the start/stop
+			 * stop address was hit.  As such the start/stop
 			 * logic needs to be re-started so that tracing can
 			 * resume where it left.
 			 *
-- 
2.36.1


