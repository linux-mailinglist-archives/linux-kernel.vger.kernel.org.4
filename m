Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D2A63C3EA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbiK2Pi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235557AbiK2PiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:38:18 -0500
Received: from smtpcmd04131.aruba.it (smtpcmd04131.aruba.it [62.149.158.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0751D3FBAD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:38:16 -0800 (PST)
Received: from asem-TANK-H61.asem.intra ([151.1.184.193])
        by Aruba Outgoing Smtp  with ESMTPSA
        id 02Ozp6txJm9gv02P6pWxJh; Tue, 29 Nov 2022 16:20:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1669735212; bh=YjSUEgk5xEtRyb/aGmtR6rCr+sWhkB+LZFctxSrk8Ac=;
        h=From:To:Subject:Date:MIME-Version;
        b=ALCJuihXEIXFpUvHqWv0t664QYmXoTAjlWCYztlPCr2dUoUa5RvPhQseZnY1s915g
         NAg44YZJrQ+OSDYNt4oAQA9l1Ufg4EuDpD/5pSQiUzRCnBkpQm4MNp/OpN+nhXgrRq
         zroc7d5cfAyVsLPMtlSTT5oGQdZGFc+CbJL4fjaQ/pLMaO5m5RoAVl3QKV2Pc+GjVj
         Z9CYX5QWeYRbl7MMC92+2+q6Ua2pDFmMq4uBzMtFbySYUcGCdTcL+XE9C2hXCi4fDu
         E8xDPfeQGtOtqKni3Z8h/GWHi9r+lpSMPHa85gZ4pI6c913PZ4sFoCR5PQAn5ZoTnZ
         7qDoi7FaQvEAQ==
From:   Luca Ellero <l.ellero@asem.it>
To:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com,
        u.kleine-koenig@pengutronix.de, mkl@pengutronix.de,
        miquel.raynal@bootlin.com, imre.deak@nokia.com,
        luca.ellero@brickedbrain.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ellero <l.ellero@asem.it>
Subject: [PATCH 1/3] ads7846: don't report pressure for ads7845
Date:   Tue, 29 Nov 2022 16:19:57 +0100
Message-Id: <20221129151959.26052-2-l.ellero@asem.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221129151959.26052-1-l.ellero@asem.it>
References: <20221129151959.26052-1-l.ellero@asem.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfGGj2nnXxhNYvUcpYUGFwPztJwinMw1IcautUPLIYXc6uTdeTIh1MUMWJ6F1OulX/Art8NqSRdZG8bUaRuIbDeWxRxxUztUDWZPN4Q7ithsNY8kkHpLu
 q8U5WJ9ny0TbP4tpu33sjMlX5NVPDbcrHaiRENTIdJt7vIaNbdgFsS6o4QgUK4EJsaffWVmOF7YDf+ILgZEbqG4j+FqJTCV83PkJGN3laJCNVmZvBUuyEG23
 3vMw/PtHRWZofI4lf7ZtGAuueSATvkUnyQ7Y+JW+DmJlhWYuEfYszWGDL9RCtieHLzodl1sUQbikTPCFvJPQeP5oYkPrVoJd2UfTAYsoCkSL621uJPEb0Bow
 oHlw1gNopcHeMRTdBr1R2qOxVjK9qXVdUFs432oVZlLFnUMRF5uFf24VpXltHHywfmzr7EsLcPTgZmClPR/py/ODZB/pimo2HokhiMYbBYswKgGmI0u9ZgWv
 ufLdGNOS347ajSEvD7gaygU+7kZiEI1Sx3hqjWREPTSxeY7rhw7d9KaQHfedGJ859BDROqe8Az/V+dlFcKhWaZ/OMcYJG56Ah2geMMhfdr4PsLX4NcCW4s2A
 4o5Cqx7SrAaZ6M0icKnGGMKQ
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
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
index bed68a68f330..24605c40d039 100644
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

