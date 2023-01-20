Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253A1675535
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 14:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjATNEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 08:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjATNEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:04:06 -0500
Received: from smtpcmd13147.aruba.it (smtpcmd13147.aruba.it [62.149.156.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD3909D28B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 05:04:04 -0800 (PST)
Received: from asem-TANK-H61.asem.intra ([151.1.184.193])
        by Aruba Outgoing Smtp  with ESMTPSA
        id IqmFpgGfF6DTZIqmNpKxBE; Fri, 20 Jan 2023 13:46:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1674218760; bh=aKZV7YqgUVh4R9awPP7VR+8sbXhX+ysYAcgvRZTvUls=;
        h=From:To:Subject:Date:MIME-Version;
        b=JWvMxhup1Fy6IyuRYpgDsQm/NbZdmAl/Cti3f0wKMJze3lgVapg8YGHt4eZDv5OxG
         25NM4bmVQP/dM/g5MzOz924p9DOtLKr9oA8dna58B9zmnRtFBUXTghDBJj5VJvqc+3
         Lb5LQcvm8lHEbHybdkTL7WAhM1QY97YOvdp5mc01/qUpemq3EskGfP9v0rZlJF6FsQ
         cprGQvs9Dis8hw/h50yx0Dk9lc7VD7nT5TkD7rF3xaXl8vnIlUih3irQ8e+dpDH/bb
         KNyp2I9Sz2XajGux1q1mhUnwOjXhgoQl9fF91vmjMZcOa0vKaWPOjbCSYzpLdVHN5a
         BRdwJyBUmXXsQ==
From:   Luca Ellero <l.ellero@asem.it>
To:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com,
        u.kleine-koenig@pengutronix.de, mkl@pengutronix.de,
        miquel.raynal@bootlin.com, imre.deak@nokia.com,
        luca.ellero@brickedbrain.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ellero <l.ellero@asem.it>
Subject: [PATCH 1/3] Input: ads7846 - don't report pressure for ads7845
Date:   Fri, 20 Jan 2023 13:45:42 +0100
Message-Id: <20230120124544.5993-2-l.ellero@asem.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230120124544.5993-1-l.ellero@asem.it>
References: <20230120124544.5993-1-l.ellero@asem.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfMHgp32vFwmxKkThC/2xZoh1U2HE14/ocdRhWnkWzpyt2YOvvxb5NLG47OKRwoSygfHLcrk3qhKsA5W8vehGLKc9bYNxUVVEifm97ttxwGnl+vrK/WW4
 E+XCZnSpVR/3uXSilSGaHiSW7M32IwSZFcwD1Yb+sdRwPy1hLy8JseDoYSVb+3BdHDt5Tc4iZ7Wn9YMGSzvQnboqfoWWIXaOVgkU7Jz8awhjL9MmMk+4cBix
 YlIhRKkrCpB8ua/NKiojr0g1TWbW58v09XxRbTBTW3CB8oXp8aAz5lqRBoA/9LLtN0SQho9pTnSvoxSidbu8vwS99Hm43D+UIxnVsrkXVXYb2bu1PViIdDPA
 HbH0yS6CAlM+546K9sbKhI3bK365nMPq0v9mue3ANCBQ+YjHbQUntfdoARLZ0BNnjFj8oLmgSnriSkYCMeQvFLKLB0soANbSW82kn3eUqtlVxxbCrILwY5bs
 U+Ez/Krl4jJjqtK2RjyjOggUwyGT/qyjk/dpON71dfzixSULTeCLj7RDmGdf/6XP0Vs/EuoF48qD1sTDwP8tzP3wsy9I9SCfCqj0D6vKsK4ByG2V8lbzqNla
 wQ+ASeCHWVmPpMVKDHJhV/re
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADS7845 doesn't support pressure.
This patch avoids the following error reported by libinput-list-devices:
"ADS7845 Touchscreen: kernel bug: device has min == max on ABS_PRESSURE".

Signed-off-by: Luca Ellero <l.ellero@asem.it>
---
 drivers/input/touchscreen/ads7846.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 4c3dd01902d0..f11b444f2138 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1316,8 +1316,9 @@ static int ads7846_probe(struct spi_device *spi)
 			pdata->y_min ? : 0,
 			pdata->y_max ? : MAX_12BIT,
 			0, 0);
-	input_set_abs_params(input_dev, ABS_PRESSURE,
-			pdata->pressure_min, pdata->pressure_max, 0, 0);
+	if (ts->model != 7845)
+		input_set_abs_params(input_dev, ABS_PRESSURE,
+				pdata->pressure_min, pdata->pressure_max, 0, 0);
 
 	/*
 	 * Parse common framework properties. Must be done here to ensure the
-- 
2.25.1

