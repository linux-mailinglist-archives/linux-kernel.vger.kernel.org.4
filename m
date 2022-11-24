Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9BB6370FD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 04:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiKXD1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 22:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKXD1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 22:27:44 -0500
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C9A13DE5;
        Wed, 23 Nov 2022 19:27:37 -0800 (PST)
X-QQ-mid: bizesmtpipv603t1669260363t7i0
Received: from localhost ( [255.189.44.3])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 24 Nov 2022 11:26:01 +0800 (CST)
X-QQ-SSF: 01400000000000506000000A0000000
X-QQ-FEAT: bhet8yMU7vlg0O7K5y1cuHvfOsuOnbFPWThQh75wv84jueJng5ranrq4icUFy
        rK/0wsHKEQWOLONmuASx1Rtsq1DG9A9nsBMgWZtYFKxHa3XHD0/63mySWn5xArfbDvs/BTg
        9BHkt4fbINdrzrTY4Dh5ltnS09IZl7WpG3g84pnhY2eNy+2C7/X0aUl/QOQsbGerQzmo4lh
        0FzSf6gUG0hNu0Amp2GQ4t6YQwBWu65f9PPoRmYrvD0U/kjdtshzptnnTqC59bA1Yekc+2n
        2bSWtbEDWh+1Wgay/LXeiivt0wr9phcnW2NSd5Ze86gSaUuFdxiBeAAsgaoJaoL6uWdXMo5
        FvZhb1X61Dp4/14vyMeiHe5+y2uZUawZmmj9j40
X-QQ-GoodBg: 2
Date:   Thu, 24 Nov 2022 11:26:01 +0800
From:   Wang Honghui <honghui.wang@ucas.com.cn>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/3] Modify to support Phytium FT2000/4 CPU for acpi
Message-ID: <9CAB43B4193E4C62+Y37kSTHfZuJeOvI8@TP-P15V.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:ucas.com.cn:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_ILLEGAL_IP,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify to support Phytium FT2000/4 CPU for acpi

Signed-off-by: Wang Honghui <honghui.wang@ucas.com.cn>
---
 drivers/hwmon/scpi-hwmon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
index 6021ae00b334..a6ee9806e47e 100644
--- a/drivers/hwmon/scpi-hwmon.c
+++ b/drivers/hwmon/scpi-hwmon.c
@@ -316,6 +316,7 @@ static struct platform_driver scpi_hwmon_platdrv = {
 	.driver = {
 		.name	= "scpi-hwmon",
 		.of_match_table = scpi_of_match,
+		.acpi_match_table = scpi_sensors_acpi_match,
 	},
 	.probe		= scpi_hwmon_probe,
 };
-- 
2.34.1

