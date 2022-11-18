Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F0E62EA95
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 01:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240730AbiKRAxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 19:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240703AbiKRAxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 19:53:20 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9A985EF9;
        Thu, 17 Nov 2022 16:53:18 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VV1r-1Z_1668732795;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VV1r-1Z_1668732795)
          by smtp.aliyun-inc.com;
          Fri, 18 Nov 2022 08:53:16 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] samples/hid: Remove unneeded semicolon
Date:   Fri, 18 Nov 2022 08:53:14 +0800
Message-Id: <20221118005314.57981-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./samples/hid/hid_surface_dial.c:170:5-6: Unneeded semicolon

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3207
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 samples/hid/hid_surface_dial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/hid/hid_surface_dial.c b/samples/hid/hid_surface_dial.c
index bceea53d39b0..dcb31464992e 100644
--- a/samples/hid/hid_surface_dial.c
+++ b/samples/hid/hid_surface_dial.c
@@ -167,7 +167,7 @@ int main(int argc, char **argv)
 						"invalid r option %s - expecting a number\n",
 						optarg ? optarg : "");
 					exit(EXIT_FAILURE);
-				};
+				}
 
 				resolution = (int) l;
 				break;
-- 
2.20.1.7.g153144c

