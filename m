Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038016CD966
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjC2MfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 08:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjC2MfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:35:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A414201;
        Wed, 29 Mar 2023 05:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680093305; x=1711629305;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2l2hmoiUE09lV8CvoAEQLjTkPM9/Sd/B1b4VpgazUKw=;
  b=FFMHuGILZ9hfaqhmy1i3kJBj52qLKCp3hOxV2SJ/o07krVXEL8nGZpx0
   pu8sFLQljqo2/PzN38xhwgpI6GEbn4se4AU9snyAfUMm1lh2B6TFF75zB
   ZV6IJcEhnBXE/XFWCouYJ2BQgx/lagVQc2i4iLtIu4vXhkDq3Q6+YIktA
   v9wdfGpRW41z8hrqX6Vb4VT7LDWEhNTKslzXVJzib2byVyKlWVFL8hId7
   TZYTtNBUj2g+Gn7rC7RHHTvRrVRzJCQp8HW1z4ey2q3QyJp92+SWKt9Vd
   3MtJCX4y1TtNc+qHEl3nj2xV9aX5TyXoX59vBikvRArfiDnVixKP2bRDA
   w==;
X-IronPort-AV: E=Sophos;i="5.98,300,1673938800"; 
   d="scan'208";a="207245760"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Mar 2023 05:35:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 05:35:03 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Wed, 29 Mar 2023 05:35:01 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <corbet@lwn.net>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] docs: driver-api: firmware_loader: fix missing argument in usage example
Date:   Wed, 29 Mar 2023 13:34:26 +0100
Message-ID: <20230329123425.4177084-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1832; i=conor.dooley@microchip.com; h=from:subject; bh=2l2hmoiUE09lV8CvoAEQLjTkPM9/Sd/B1b4VpgazUKw=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCkqBgHV8VeF9GISglz9q7cxRUhbTowSeSSvJOMefmpLysrd lnc6SlkYxDgYZMUUWRJv97VIrf/jssO55y3MHFYmkCEMXJwCMJHuFkaGDWKBWVX+B8ITZFsOnbAI1v +480H9+yks/kXVrLk6n/adZ2SY49edx3p9U7eB7e4io12LRZQT4zWXyRhImjUtY1BIvcUNAA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By the time firmware-upload support landed in commit 97730bbb242c
("firmware_loader: Add firmware-upload support"), the arguments for
firmware_upload_register() had changed, and while this is automagically
represented in the kernel doc bits, the usage example was not kept in
sync.
Add the missing argument as per the driver.

Fixes: 97730bbb242c ("firmware_loader: Add firmware-upload support")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
From skimming the threads adding this stuff, looks like THIS_MODULE was
always needed, so either I'm missing something or the doc stuff wasn't
matching in any of the submitted versions.

CC: Jonathan Corbet <corbet@lwn.net>
CC: Russ Weight <russell.h.weight@intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Tianfei zhang <tianfei.zhang@intel.com>
CC: Luis Chamberlain <mcgrof@kernel.org>
CC: linux-doc@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 Documentation/driver-api/firmware/fw_upload.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/firmware/fw_upload.rst b/Documentation/driver-api/firmware/fw_upload.rst
index 76922591e446..edf1d0c5e7c3 100644
--- a/Documentation/driver-api/firmware/fw_upload.rst
+++ b/Documentation/driver-api/firmware/fw_upload.rst
@@ -57,7 +57,8 @@ function calls firmware_upload_unregister() such as::
 		len = (truncate) ? truncate - fw_name : strlen(fw_name);
 		sec->fw_name = kmemdup_nul(fw_name, len, GFP_KERNEL);
 
-		fwl = firmware_upload_register(sec->dev, sec->fw_name, &m10bmc_ops, sec);
+		fwl = firmware_upload_register(THIS_MODULE, sec->dev, sec->fw_name,
+					       &m10bmc_ops, sec);
 		if (IS_ERR(fwl)) {
 			dev_err(sec->dev, "Firmware Upload driver failed to start\n");
 			kfree(sec->fw_name);
-- 
2.39.2

