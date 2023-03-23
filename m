Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145296C6A29
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjCWN6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjCWN57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:57:59 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398C5469D;
        Thu, 23 Mar 2023 06:57:58 -0700 (PDT)
Received: from koko.localdomain ([89.1.213.94]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MkpnF-1qL2AL0Tsd-00mIsU; Thu, 23 Mar 2023 14:52:46 +0100
From:   Maximilian Weigand <mweigand@mweigand.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Maximilian Weigand <mweigand@mweigand.net>,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 1/6] Input: cyttsp5: fix array length
Date:   Thu, 23 Mar 2023 14:52:00 +0100
Message-Id: <20230323135205.1160879-2-mweigand@mweigand.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323135205.1160879-1-mweigand@mweigand.net>
References: <20230323135205.1160879-1-mweigand@mweigand.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+1DhUNDo+nzdmkzCeHmfEL2un8XA8aBChZLaJgqifXsrgo4Te4B
 J5cBDz1wUTYE4+BoWAp0Ox3gGnMjI3r9ZvVSGaJzDcB1ggXnvLAg0wa4NMLW+xmJsjEFCG/
 wLApC9WEG4fgdMidDvNzIgR4XJax7NARqji3olDNI9yjsPPcrbjCl9JITFpy9sgBhpYnxHu
 xdZxYy6nmkvdAYN4VfW8A==
UI-OutboundReport: notjunk:1;M01:P0:H8F03Lc5QDc=;imrDxUuizjS7jnaLTI+DiXs7AMB
 Wg/llIbBSSsogOtz3A7aVAgd41Ir7eIk5gE/84XBo6B0G6y/RIQi/SUehXErAf4OSAyfJfc5E
 DW+9f+YJ7DtUzZOrhJ8V8orI+WVC92FqQ9XD6YResI+Yxo9qEktFocDLR6k6aLaSLlqZBKx7W
 jUSGiujp3IhQvyjY3qMCt7UQp7ildG+W9oI8bJV9hM46+3eiVjkrO/nc8xvYjCz/faup1e/NI
 i694ixXZQH/qMrTEw9ETm1mcJ9ug4XIbVrlhDJEU+sqoMlxd038E0b5cyohK80bQmqSsBEWzE
 1m/s1ZnNkf5A1zp/KDIXB/yatpe0sENLae1AL2w6WldusmAa2eCxHkfBnA1oWAEtpTZ8AXXXk
 /ak06ztseW+vMM2ajcQh0zqI4ixJ4IGvrzbo8/jMqV7xD9TSZSn3Hjvhc3V+1bHTg+sj6BQeY
 OGGetF3c5u+1IPUTA4ENQPMfnqAgUz+hELAmCf1wE1e4lq9Nt/cZ6ux63Mi+QRKvpzF0WXr6Q
 x7M6UJ0ugI0wovZdR9L8gtIo3uS/AWVBvxKPyVxIbAF8v5f+n/yzHctQJbcfyTe2EFDuoXB/q
 p6BsZi7/mW8JZ0BjfEGOhoRAd03AgEq8AktUxYttFjo/BVww9qgKEQOJH076Dnr/4nKoCCdYX
 WvNqHLlBvNWCNQG9a+fyNkwyGNsOzU3z70cvPh+iHA==
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cmd array should be initialized with the proper command size and not
with the actual command value that is sent to the touchscreen.

Signed-off-by: Maximilian Weigand <mweigand@mweigand.net>
Reviewed-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/input/touchscreen/cyttsp5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscreen/cyttsp5.c
index 16caffa35dd9..42c7b44e37f8 100644
--- a/drivers/input/touchscreen/cyttsp5.c
+++ b/drivers/input/touchscreen/cyttsp5.c
@@ -559,7 +559,7 @@ static int cyttsp5_hid_output_get_sysinfo(struct cyttsp5 *ts)
 static int cyttsp5_hid_output_bl_launch_app(struct cyttsp5 *ts)
 {
 	int rc;
-	u8 cmd[HID_OUTPUT_BL_LAUNCH_APP];
+	u8 cmd[HID_OUTPUT_BL_LAUNCH_APP_SIZE];
 	u16 crc;
 
 	put_unaligned_le16(HID_OUTPUT_BL_LAUNCH_APP_SIZE, cmd);
-- 
2.39.2

