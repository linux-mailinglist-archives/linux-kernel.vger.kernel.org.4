Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2184661647C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 15:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiKBOIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 10:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiKBOIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:08:35 -0400
X-Greylist: delayed 1312 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Nov 2022 07:08:33 PDT
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A36B65F1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 07:08:31 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4N2TJF3w9Wz4y3Zl;
        Wed,  2 Nov 2022 22:08:29 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2A2E8NHA021607;
        Wed, 2 Nov 2022 22:08:23 +0800 (+08)
        (envelope-from zhang.songyi@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 2 Nov 2022 22:08:27 +0800 (CST)
Date:   Wed, 2 Nov 2022 22:08:27 +0800 (CST)
X-Zmail-TransId: 2af9636279db19c123a6
X-Mailer: Zmail v1.0
Message-ID: <202211022208274530566@zte.com.cn>
Mime-Version: 1.0
From:   <zhang.songyi@zte.com.cn>
To:     <agross@kernel.org>
Cc:     <andersson@kernel.org>, <konrad.dybcio@somainline.org>,
        <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <jiang.xuexin@zte.com.cn>,
        <xue.zhihong@zte.com.cn>, <zhang.songyi@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHNvdW5kd2lyZTogcWNvbTogcmVtb3ZlIHJlZHVuZGFudCByZXQgdmFyaWFibGU=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2A2E8NHA021607
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 636279DD.005 by FangMail milter!
X-FangMail-Envelope: 1667398109/4N2TJF3w9Wz4y3Zl/636279DD.005/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<zhang.songyi@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 636279DD.005/4N2TJF3w9Wz4y3Zl
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From ebc0be30e0c49d2d54a9aaa064c7f742e99e8eb2 Mon Sep 17 00:00:00 2001
From: zhang songyi <zhang.songyi@zte.com.cn>
Date: Wed, 2 Nov 2022 22:08:48 +0800
Subject: [PATCH linux-next] soundwire: qcom: remove redundant ret variable

Return value from swrm_get_packed_reg_val() directly instead of taking
this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
---
 drivers/soundwire/qcom.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 335424870290..d92f421d38c8 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -260,7 +260,6 @@ static int qcom_swrm_cpu_reg_write(struct qcom_swrm_ctrl *ctrl, int reg,
 static u32 swrm_get_packed_reg_val(u8 *cmd_id, u8 cmd_data,
                   u8 dev_addr, u16 reg_addr)
 {
-   u32 val;
    u8 id = *cmd_id;

    if (id != SWR_BROADCAST_CMD_ID) {
@@ -270,9 +269,8 @@ static u32 swrm_get_packed_reg_val(u8 *cmd_id, u8 cmd_data,
            id = 0;
        *cmd_id = id;
    }
-   val = SWRM_REG_VAL_PACK(cmd_data, dev_addr, id, reg_addr);

-   return val;
+   return SWRM_REG_VAL_PACK(cmd_data, dev_addr, id, reg_addr);
 }

 static int swrm_wait_for_rd_fifo_avail(struct qcom_swrm_ctrl *swrm)
--
2.15.2
