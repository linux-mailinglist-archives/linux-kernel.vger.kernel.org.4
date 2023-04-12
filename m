Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182006E01EE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 00:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjDLWhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 18:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjDLWhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 18:37:04 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9B876B4;
        Wed, 12 Apr 2023 15:37:03 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Pxcyk1VX8z9skh;
        Thu, 13 Apr 2023 00:37:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mariushoch.de;
        s=MBO0001; t=1681339022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L8uQAP5W5OhdK/Say6eNAKnt1Ni1+GY+dfRsckCmId0=;
        b=1sr/qOySTRqdIHMiDupIqC1wNwKpFBntAHmXDyRkfRtunGAY1hWe7DbwHGzlMKgw0spgJ6
        PXCJcRPPQmnBB4Y/nc1GypkPF8AOQRRHtB0byd9q9Opnrdgnu/JK3c/50IyX4JxzHs5u/O
        X0cGOJIGcCgdCNEkr1yG6tBZ5dDNtudBev12TFb6pUmDms4GXWndh26Ec9hwuRCDGM+75R
        WYbpER/E95CkUypgGRVdUL9wvx8zesKZTxwTv1mZ6JqaYaHHn5Fb85vY0Om9JWnh45OrTp
        lNZ3cI+xWX4wpXW8Vbhdk0NI01j0sUFnE2Uu7vY4r+3YcE/eheP+/lE4zB4EWA==
From:   mail@mariushoch.de
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Marius Hoch <mail@mariushoch.de>
Subject: [PATCH] iio: Comment that the LSM303D also has the Magnetometer DRDY
Date:   Thu, 13 Apr 2023 00:36:26 +0200
Message-Id: <20230412223627.442963-6-mail@mariushoch.de>
In-Reply-To: <20230412223627.442963-1-mail@mariushoch.de>
References: <20230412223627.442963-1-mail@mariushoch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Pxcyk1VX8z9skh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marius Hoch <mail@mariushoch.de>

Per its datasheet, the LSM303D also features that
pin.

Signed-off-by: Marius Hoch <mail@mariushoch.de>
---
 include/linux/platform_data/st_sensors_pdata.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/platform_data/st_sensors_pdata.h b/include/linux/platform_data/st_sensors_pdata.h
index 897051e51b78..a657830232ae 100644
--- a/include/linux/platform_data/st_sensors_pdata.h
+++ b/include/linux/platform_data/st_sensors_pdata.h
@@ -15,7 +15,7 @@
  * @drdy_int_pin: Redirect DRDY on pin 1 (1) or pin 2 (2).
  *	Available only for accelerometer, magnetometer and pressure sensors.
  *	Accelerometer DRDY on LSM330 available only on pin 1 (see datasheet).
- *	Magnetometer DRDY is supported only on LSM9DS0.
+ *	Magnetometer DRDY is supported only on LSM9DS0 and LSM303D.
  * @open_drain: set the interrupt line to be open drain if possible.
  * @spi_3wire: enable spi-3wire mode.
  * @pullups: enable/disable i2c controller pullup resistors.
-- 
2.39.2

