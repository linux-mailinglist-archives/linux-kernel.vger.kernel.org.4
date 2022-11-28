Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B793663A339
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiK1IjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiK1IjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:39:12 -0500
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A92BA9FED;
        Mon, 28 Nov 2022 00:39:10 -0800 (PST)
Received: from zju.edu.cn (unknown [10.12.77.33])
        by mail-app3 (Coremail) with SMTP id cC_KCgB39bmnc4RjHCTNCQ--.64643S4;
        Mon, 28 Nov 2022 16:39:03 +0800 (CST)
From:   Lin Ma <linma@zju.edu.cn>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lin Ma <linma@zju.edu.cn>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>
Subject: [PATCH v0] media: dvbdev: fix build warning due to comments
Date:   Mon, 28 Nov 2022 16:39:03 +0800
Message-Id: <20221128083903.11117-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cC_KCgB39bmnc4RjHCTNCQ--.64643S4
X-Coremail-Antispam: 1UD129KBjvdXoWrZry8XFW7Aw1fXw4xuF4kWFg_yoWktFb_Ca
        4IvrWkurn3GF40gr13tr1rX34rKwn2qrW8KF4ftas7AFZ8WFZ8WrZrKry2qryxuw47Jry3
        Z3Z5Xw45WF10gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2xFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxF
        aVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous commit that introduces reference counter does not add proper
comments, which will lead to warning when building htmldocs. Fix them.

Reported-by: "Stephen Rothwell" <sfr@canb.auug.org.au>
Fixes: 0fc044b2b5e2 ("media: dvbdev: adopts refcnt to avoid UAF")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
 include/media/dvbdev.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/media/dvbdev.h b/include/media/dvbdev.h
index fad987115..29d25c8a6 100644
--- a/include/media/dvbdev.h
+++ b/include/media/dvbdev.h
@@ -130,6 +130,7 @@ struct dvb_adapter {
  * struct dvb_device - represents a DVB device node
  *
  * @list_head:	List head with all DVB devices
+ * @ref:	reference counter
  * @fops:	pointer to struct file_operations
  * @adapter:	pointer to the adapter that holds this device node
  * @type:	type of the device, as defined by &enum dvb_device_type.
@@ -200,7 +201,7 @@ struct dvb_device {
 struct dvb_device *dvb_device_get(struct dvb_device *dvbdev);
 
 /**
- * dvb_device_get - Decrease dvb_device reference
+ * dvb_device_put - Decrease dvb_device reference
  *
  * @dvbdev:	pointer to struct dvb_device
  */
-- 
2.38.1

