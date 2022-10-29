Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119B161221B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 12:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJ2KEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 06:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJ2KEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 06:04:46 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4048215FE0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 03:04:42 -0700 (PDT)
X-QQ-mid: bizesmtp66t1667037876tvrc3eei
Received: from localhost.localdomain ( [182.148.13.81])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 29 Oct 2022 18:04:32 +0800 (CST)
X-QQ-SSF: 01000000002000D0E000B00A0000000
X-QQ-FEAT: FVl8EHhfVR4o8779C4NCn/kDMSE4+GisGsoWsn6VTRIUn4JcGyoElPV9whsHc
        FxLag9yHPLdMIUC1BRxPv3oQ07pHtk/H43yfF7Tc5vREVtU8Mes51eGMGu1ViuCGseeFRDB
        M4MfbRz3q0YdE4S+imCyLgvDxD9V02CIcV5+dbD0oZ78ie2nu6mq09EkYgjqcu8yLM2LeTk
        iHOoPX0TAjYBZC3eHnMB+t32pfM5/hRdeibd+t6Ngs5V7KM2D6VducPHlJ/5KBny9tZAjvL
        5xqs+hwmESjnOOUy6ObJ8u3SV8QXqKRmhJlv+WBl3H4jHC35FLhx3ilX7HY/pYRUsevy0UL
        yMZk0EBTn+QLlM/DDHCviWTMrMcr6xSbBoQJQn2PSK5cpIUTts=
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] mm/vmscan: delete rebundant word in comments
Date:   Sat, 29 Oct 2022 06:04:31 -0400
Message-Id: <20221029100431.10825-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
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

Delete the repeated word "that" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 27a3f29c0181..2ad2fec6ed3f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7053,7 +7053,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 
 		/*
 		 * There should be no need to raise the scanning priority if
-		 * enough pages are already being scanned that that high
+		 * enough pages are already being scanned that high
 		 * watermark would be met at 100% efficiency.
 		 */
 		if (kswapd_shrink_node(pgdat, &sc))
-- 
2.35.1

