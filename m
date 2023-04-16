Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7306E3B59
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 21:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjDPTAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 15:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDPTAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 15:00:33 -0400
X-Greylist: delayed 333 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 16 Apr 2023 12:00:32 PDT
Received: from qs51p00im-qukt01072702.me.com (qs51p00im-qukt01072702.me.com [17.57.155.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3916A19B9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 12:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1681671631; bh=QAN81MKwVcJUypjnCIzr2RsjX6wyliLgubt6kklNa4U=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=twFT6yHJHu/leHiYQe0it2jz8GgcJsKflFLbDZKKoewTHxETzPUKHWVtYNUlaLznC
         TdvzDcG3L3M8QT551ip+4t8Ieur3sMGmmLYxwW6ZaM7nOiVB1T9rz+M5Q5DbXR894i
         v6fxJA1nBsmrfL5+FJalYWJcqcVJQzjLuglarY5XJQf1JkP3vslTDUTpG4v/C4CVRi
         dwoST2SGTeixqK0fymZD68ObOw8q7gIoz3ZGDT4irzk9U216rceNeqRDLLNsDYGtPZ
         sXdJIvjrxlIaMveLj1GjJV12pV+M7OFHc9bP8ok82kt1XIRNj2Rc/qbRs6HX5kgiWT
         QEge5H+Ssk3Vw==
Received: from localhost (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01072702.me.com (Postfix) with ESMTPSA id BA96A168066F;
        Sun, 16 Apr 2023 19:00:30 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     Alain Volmat <avolmat@me.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: sti: removal of stih415/stih416 related entries
Date:   Sun, 16 Apr 2023 20:59:38 +0200
Message-Id: <20230416185939.18497-1-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Zt2cW-BS7xoCe38YDWBx66SWWo3zWBU3
X-Proofpoint-ORIG-GUID: Zt2cW-BS7xoCe38YDWBx66SWWo3zWBU3
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.790,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-12=5F02:2020-02-14=5F02,2022-01-12=5F02,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 spamscore=0 bulkscore=0
 mlxlogscore=950 mlxscore=0 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2304160180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ST's STiH415 and STiH416 platforms have already been removed since
a while.  Remove some remaining bits within the mach-sti.

Signed-off-by: Alain Volmat <avolmat@me.com>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Patch sent previously as part of serie: https://lore.kernel.org/all/20230209091659.1409-3-avolmat@me.com/

 arch/arm/mach-sti/Kconfig    | 20 +-------------------
 arch/arm/mach-sti/board-dt.c |  2 --
 2 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
index b2d45cf10a3c..609957dead98 100644
--- a/arch/arm/mach-sti/Kconfig
+++ b/arch/arm/mach-sti/Kconfig
@@ -19,31 +19,13 @@ menuconfig ARCH_STI
 	select PL310_ERRATA_769419 if CACHE_L2X0
 	select RESET_CONTROLLER
 	help
-	  Include support for STMicroelectronics' STiH415/416, STiH407/10 and
+	  Include support for STMicroelectronics' STiH407/10 and
 	  STiH418 family SoCs using the Device Tree for discovery.  More
 	  information can be found in Documentation/arm/sti/ and
 	  Documentation/devicetree.
 
 if ARCH_STI
 
-config SOC_STIH415
-	bool "STiH415 STMicroelectronics Consumer Electronics family"
-	default y
-	help
-	  This enables support for STMicroelectronics Digital Consumer
-	  Electronics family StiH415 parts, primarily targeted at set-top-box
-	  and other digital audio/video applications using Flattned Device
-	  Trees.
-
-config SOC_STIH416
-	bool "STiH416 STMicroelectronics Consumer Electronics family"
-	default y
-	help
-	  This enables support for STMicroelectronics Digital Consumer
-	  Electronics family StiH416 parts, primarily targeted at set-top-box
-	  and other digital audio/video applications using Flattened Device
-	  Trees.
-
 config SOC_STIH407
 	bool "STiH407 STMicroelectronics Consumer Electronics family"
 	default y
diff --git a/arch/arm/mach-sti/board-dt.c b/arch/arm/mach-sti/board-dt.c
index ffecbf29646f..8c313f07bd02 100644
--- a/arch/arm/mach-sti/board-dt.c
+++ b/arch/arm/mach-sti/board-dt.c
@@ -12,8 +12,6 @@
 #include "smp.h"
 
 static const char *const stih41x_dt_match[] __initconst = {
-	"st,stih415",
-	"st,stih416",
 	"st,stih407",
 	"st,stih410",
 	"st,stih418",
-- 
2.34.1

