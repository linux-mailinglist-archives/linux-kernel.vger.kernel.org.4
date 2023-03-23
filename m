Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F246C69FD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjCWNwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjCWNwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:52:53 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F9FB748;
        Thu, 23 Mar 2023 06:52:51 -0700 (PDT)
Received: from koko.localdomain ([89.1.213.94]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MV6Bs-1q5AF61VWo-00S9OV; Thu, 23 Mar 2023 14:52:46 +0100
From:   Maximilian Weigand <mweigand@mweigand.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Maximilian Weigand <mweigand@mweigand.net>,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 2/6] Input: cyttsp5: remove unused code
Date:   Thu, 23 Mar 2023 14:52:01 +0100
Message-Id: <20230323135205.1160879-3-mweigand@mweigand.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323135205.1160879-1-mweigand@mweigand.net>
References: <20230323135205.1160879-1-mweigand@mweigand.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YUH5iMMLxAx7e4vsbCAz3PXdHSmfYWWG0GYRvSJUmzyU8xy+8Nc
 dh9EE38jxbmYYN2c+EjmnLv70tj981P1xIZdAQ5Xbr4tc+k7TfSXIe6tFIVaCeZphlv4WGw
 MluiAWwdCyasKeqjHXqrbD2uBt/QKQzUbusHVeGCtb3PNOHVt+NbFd6Xw+rabpGj/bMVX7W
 Ou84g6q+ktG6aN20xnrig==
UI-OutboundReport: notjunk:1;M01:P0:QGfNrt1tYeU=;hDQe2Vd0r4SngaEZ4qXWTCPz9Y+
 MQuGU59IIBTgYLlAZEu1mP5HG5yo3pqT9orTEACPX/VQWi/GguRSCu/4+lhpF1hpW7qScI/Po
 3ZiSkk/PXlf7lGd28uPR6zX6qqehEHYRdTJHX9+feH+KcfDejl0Cs3REO1edQZ1h9wGfJ6NMq
 IwKhib49Y0ay7UE0AaY9bGmNZ/RqseNqMoTISFh4pqbJ6f8XnGEY7O/MZzR9Sm25oNL3hQfEJ
 BmhxNIMPWfHMmWVLbheqTQQVlqe1fLauT+fpa0f4nCvK6KFqukb1koJ2e/+a6izQIYsy5RVvn
 oI2VCGsguJUACIH8ScaQ2N1lEjTcDT7Ii7B3oLRL+61VKj80gb+C43eruQnSXSUUziYb5NBxI
 IbAioewwRx0MvQnQqJDAGz6PxvXqO4zZ54e3CBQ4trvrraDO0oyP5e+tHI9kuRBuyLeUghTHJ
 BOuPEJLcLggYy0pU35Wu3SR6/E8gdyQY03QPfeFWOiuq5BBx0BlLJ2rF0CC5PhPMJzB0R+hYw
 bOSltGIrniqQhaQtP4NV3H6gVGv2ReZ4oSR1hnDIjXzMnX678q/rNUKLHyw23BNZg86jD/h2K
 6g2pU9bnV/Iz1CEOl/gULcJmq51T8HpOIo5Ny3UrDNExEgcUHLNGGsx3HhD4alwFAgLXHpyYs
 Pxob7DbDqCaKvrV7r25VCdPU/45fbLwJNWjy2cnkQA==
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The removed lines were remnants of the android driver of the touch
screen and are not used in the current driver.

Signed-off-by: Maximilian Weigand <mweigand@mweigand.net>
Reviewed-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/input/touchscreen/cyttsp5.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscreen/cyttsp5.c
index 42c7b44e37f8..8b0c6975c6ec 100644
--- a/drivers/input/touchscreen/cyttsp5.c
+++ b/drivers/input/touchscreen/cyttsp5.c
@@ -600,13 +600,9 @@ static int cyttsp5_get_hid_descriptor(struct cyttsp5 *ts,
 				      struct cyttsp5_hid_desc *desc)
 {
 	struct device *dev = ts->dev;
-	__le16 hid_desc_register = cpu_to_le16(HID_DESC_REG);
 	int rc;
 	u8 cmd[2];
 
-	/* Set HID descriptor register */
-	memcpy(cmd, &hid_desc_register, sizeof(hid_desc_register));
-
 	rc = cyttsp5_write(ts, HID_DESC_REG, NULL, 0);
 	if (rc) {
 		dev_err(dev, "Failed to get HID descriptor, rc=%d\n", rc);
-- 
2.39.2

