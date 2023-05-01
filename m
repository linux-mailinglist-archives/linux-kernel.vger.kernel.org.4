Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0EA6F3072
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 13:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbjEALbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 07:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjEALbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 07:31:03 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596BA10F7;
        Mon,  1 May 2023 04:30:59 -0700 (PDT)
Received: from koko.localdomain ([213.196.213.13]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MRTEr-1pexnY2vAL-00NOGH; Mon, 01 May 2023 13:30:49 +0200
From:   Maximilian Weigand <mweigand@mweigand.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Maximilian Weigand <mweigand@mweigand.net>,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v2 2/6] Input: cyttsp5 - remove unused code
Date:   Mon,  1 May 2023 13:30:06 +0200
Message-Id: <20230501113010.891786-3-mweigand@mweigand.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501113010.891786-1-mweigand@mweigand.net>
References: <20230501113010.891786-1-mweigand@mweigand.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:04GRXAHNNP3hfmZh/kzBFbrrSfrgqaJnyEVJ+MKgY/8gCoh7e5P
 ysf7d3bJD7UneJCt2k6QvYro6/B9Vc7OY/T5xzJ1cyUlpIjJg/YgYQOD5RAwyMYaHAjxEbJ
 TAV5T6F4p6ezacZM+0ggxDOvh1BJEfOIiYp4UYTwRoTGab+218eYFYRKHxTdbvSNARyGrJ9
 eWMoyhUJHW195YQKGTJzw==
UI-OutboundReport: notjunk:1;M01:P0:X21Tj8S84uk=;+iBO72prv/PwXlcCcUsw2W4eEzx
 bOT3BmWNSYlmYfjwnJvhd3ZMpvAiHY990RtWHySXswX0Ex6BY92WFYakpURd5vYKm7sTdlMGC
 kJUlbrskJwJ0SEDg8PmEaQQNn8bkC0MdDUX00WPLcKZX8p26QTX4vdyVnw2DJ2LtbGPso2gNN
 /qpMNfX3PuAxGDrhg5R0+3hD3Blx+eh7EFysVKkNjSkejJUVTJ5j4bbpWLyXP1AamgGlWdff7
 v1rNN2TeYTVyLLi+rlRQz/D0QgtBqlgbEpKHHdC4qSNjYWOsdY+ObY2pLH+JuWZd7SKPdW2zH
 R05zEqRcDPufez9iIUWLvQq5fo7OHt8z9fqLs6d06eS8LuP8DMGmLbTy47MA7EgruYJqhl6D1
 yy8ZsQKRn1waYJWXfrazh/P3RuKxMRfqLnm+wSeOKz+ItHpFTazx0LswVNk1UIdwMHkTKGbO4
 GlxhO7hCjCcdRS+x8T/ZPm0RFjeuVopTj5FN3iUfIz1qkn3Z1bkEWa+fDNOtIcyOHs+oGR1gL
 OmWnd/X/n7FreZCQNFNKMv6EUAiQCotelNy8OnZ5xcP/zjnRaCGIfwoQ9nvkf9Chy+Xl9ZxU6
 piDNxBO8ADr4wAVmKJV/IDtH6Pqqi23iHNewqzRajdQumLPlz0kA+/qNSsYKVOaiqMag6auC8
 xNkbGEmwsTA14o64PfpgERDWIhLBZtNn4nHVBP0+QQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The removed lines are remnants of the vendor driver and are not used in
the upstream driver.

Signed-off-by: Maximilian Weigand <mweigand@mweigand.net>
Reviewed-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/input/touchscreen/cyttsp5.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscreen/cyttsp5.c
index 3c9d07218f48..55abf568bdf6 100644
--- a/drivers/input/touchscreen/cyttsp5.c
+++ b/drivers/input/touchscreen/cyttsp5.c
@@ -601,12 +601,7 @@ static int cyttsp5_get_hid_descriptor(struct cyttsp5 *ts,
 				      struct cyttsp5_hid_desc *desc)
 {
 	struct device *dev = ts->dev;
-	__le16 hid_desc_register = cpu_to_le16(HID_DESC_REG);
 	int rc;
-	u8 cmd[2];
-
-	/* Set HID descriptor register */
-	memcpy(cmd, &hid_desc_register, sizeof(hid_desc_register));
 
 	rc = cyttsp5_write(ts, HID_DESC_REG, NULL, 0);
 	if (rc) {
-- 
2.39.2

