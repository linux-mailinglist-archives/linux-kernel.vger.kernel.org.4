Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307B06046D7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbiJSNVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiJSNVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:21:05 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDC11D73FE;
        Wed, 19 Oct 2022 06:06:37 -0700 (PDT)
X-QQ-mid: bizesmtp77t1666184042tqyquoew
Received: from localhost.localdomain ( [182.148.15.91])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Oct 2022 20:54:01 +0800 (CST)
X-QQ-SSF: 01000000008000E0J000B00A0000000
X-QQ-FEAT: Mxc3K7F63kw2rbapekzvNNxLgK7h/sooyVMhwFI2007VL6SRstJIdXVeWE7dx
        WqGeXF2uLGlwPD36/VS1t/G6r7LQrF4u0iy5QNX3595WAhsyiB0vGS9ZuKk27g03DgyDnyN
        58j/MqbnDFM6rWT1qG+pfSuR24r0SNEAtL74V00iSKgfgBduKV/qNwQ5twylYC9vGQI/l32
        xL8CkYMKEv8uewDwGGIeWfF6M4zNpzhYHhw5Gtz5vI8FDGlSA7TH1r0jmEUySVtWXqY+VmB
        +si8iA+8pxhajtdeioKvL1zjD4sm0kRYnPbkGsCBkn92inx102Kv5b6xjHV9pbL4D8R496X
        0W/NCAXiSne7jlz+CnUo++2yoCab6BwUf5sedWPQQFDBJXSfBQsEdvACUdQi9eR23BEuZDH
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     irenic.rajneesh@gmail.com, david.e.box@intel.com,
        hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] platform/x86/intel: fix repeated words in comments
Date:   Wed, 19 Oct 2022 20:53:55 +0800
Message-Id: <20221019125355.50674-1-yuanjilin@cdjrlc.com>
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

Delete the redundant word 'toZ'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/platform/x86/intel/pmc/core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 7a059e02c265..4c7e77f1ccac 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -264,7 +264,7 @@ struct pmc_bit_map {
  * @slp_s0_offset:	PWRMBASE offset to read SLP_S0 residency
  * @ltr_ignore_offset:	PWRMBASE offset to read/write LTR ignore bit
  * @regmap_length:	Length of memory to map from PWRMBASE address to access
- * @ppfear0_offset:	PWRMBASE offset to to read PPFEAR*
+ * @ppfear0_offset:	PWRMBASE offset to read PPFEAR*
  * @ppfear_buckets:	Number of 8 bits blocks to read all IP blocks from
  *			PPFEAR
  * @pm_cfg_offset:	PWRMBASE offset to PM_CFG register
-- 
2.36.1

