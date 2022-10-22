Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8A96084B2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 07:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiJVFqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 01:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJVFp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 01:45:59 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B097B4DB1D;
        Fri, 21 Oct 2022 22:45:56 -0700 (PDT)
X-QQ-mid: bizesmtp78t1666417552thej280e
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 13:45:51 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: o+V1LJLjbvwu6e1PveR47JqxyLgFKerIUDADvetPE27ebD52f6nOZrebpho+b
        gRgehuhgo2AfrkbIZwHcLt9p+3wU9vkJzvicAyKkqiQ1UDlcYE8xlYROgp/Swp5/6s8uFMK
        YjSqd+uszLPtOWWpEQkpA0irEwjaeJ7A3SgQlM702D/3U1Gj0S9QHaa2Bz+P9lJ92bBuaMA
        hBMgLOELOb5N9tqDmhclzMku8N2etLMebD7x1d9lncG2u6nRIQ4Ca6BZlihlaDqWM/hfQ+K
        R8x1EsyCm3UyTo7jq6q7Cm4tib5rbzBdTu9anVJkedTg2YapPyYUb9TkffuVJhIXry77NfA
        +Y5Jayb/qMQZqrAoJk6fSjnoAMu60T2jD+VvyYiOuDRkqz6ojg=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] power/supply: fix repeated words in comments
Date:   Sat, 22 Oct 2022 13:45:44 +0800
Message-Id: <20221022054544.35121-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/power/supply/ab8500_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index d04d087caa50..2af83643508c 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -1963,7 +1963,7 @@ static int ab8500_charger_get_ext_psy_data(struct device *dev, void *data)
  *
  * Due to a asic bug it is necessary to lower the input current to the vbus
  * charger when charging with at some specific levels. This issue is only valid
- * for below a certain battery voltage. This function makes sure that the
+ * for below a certain battery voltage. This function makes sure that
  * the allowed current limit isn't exceeded.
  */
 static void ab8500_charger_check_vbat_work(struct work_struct *work)
-- 
2.36.1

