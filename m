Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1AE615EEA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiKBJHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiKBJGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:06:55 -0400
X-Greylist: delayed 424 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Nov 2022 02:05:21 PDT
Received: from mxus.zte.com.cn (mxus.zte.com.cn [20.112.44.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9344D25F6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 02:05:20 -0700 (PDT)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxus.zte.com.cn (FangMail) with ESMTPS id 4N2LPz6s1yz9wMT5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 16:57:59 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4N2LPw34p5z8R039;
        Wed,  2 Nov 2022 16:57:56 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2A28vgoZ031476;
        Wed, 2 Nov 2022 16:57:42 +0800 (+08)
        (envelope-from zhang.songyi@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 2 Nov 2022 16:57:45 +0800 (CST)
Date:   Wed, 2 Nov 2022 16:57:45 +0800 (CST)
X-Zmail-TransId: 2af9636231091191451f
X-Mailer: Zmail v1.0
Message-ID: <202211021657454006946@zte.com.cn>
Mime-Version: 1.0
From:   <zhang.songyi@zte.com.cn>
To:     <nm@ti.com>
Cc:     <kristo@kernel.org>, <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <zhang.songyi@zte.com.cn>,
        <jiang.xuexin@zte.com.cn>, <xue.zhihong@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGZpcm13YXJlOiB0aV9zY2k6IFVzZSBvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2A28vgoZ031476
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at 10-207-168-7 with ID 63623116.000 by FangMail milter!
X-FangMail-Envelope: 1667379480/4N2LPz6s1yz9wMT5/63623116.000/192.168.250.137/[192.168.250.137]/mxhk.zte.com.cn/<zhang.songyi@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63623116.000/4N2LPz6s1yz9wMT5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 18dbde082d02c871453c5be8c762b6383a2f9641 Mon Sep 17 00:00:00 2001
From: zhang songyi <zhang.songyi@zte.com.cn>
Date: Wed, 2 Nov 2022 16:17:54 +0800
Subject: [PATCH linux-next] firmware: ti_sci: Use of_device_get_match_data()

Use of_device_get_match_data() to simplify the code.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
---
 drivers/firmware/ti_sci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 6d2fd0ff7ff3..7db7d840fbb2 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -3340,7 +3340,6 @@ MODULE_DEVICE_TABLE(of, ti_sci_of_match);
 static int ti_sci_probe(struct platform_device *pdev)
 {
    struct device *dev = &pdev->dev;
-   const struct of_device_id *of_id;
    const struct ti_sci_desc *desc;
    struct ti_sci_xfer *xfer;
    struct ti_sci_info *info = NULL;
@@ -3351,12 +3350,11 @@ static int ti_sci_probe(struct platform_device *pdev)
    int reboot = 0;
    u32 h_id;

-   of_id = of_match_device(ti_sci_of_match, dev);
-   if (!of_id) {
+   desc = of_device_get_match_data(dev);
+   if (!desc) {
        dev_err(dev, "OF data missing\n");
        return -EINVAL;
    }
-   desc = of_id->data;

    info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
    if (!info)
--
2.15.2
