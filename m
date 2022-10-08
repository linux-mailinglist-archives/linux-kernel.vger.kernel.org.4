Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EC65F8506
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 13:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJHLfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 07:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiJHLfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 07:35:40 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6524C029
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 04:35:38 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 8CFEA240026
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 13:35:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1665228937; bh=vUAZAf/vEWwxOLNiizsdND0eAM7EAAGZFVQqSdmNQ/g=;
        h=Date:From:To:Cc:Subject:From;
        b=LX5zlb5XwvyZ38Ie/WAJ+4NC8oS+JUs9W2PHOzjHfkUjoc9lwFB052tJhAZ5qUyzH
         TOj8sDJqllQ/vIpdA4ahDADrK0xKC9IR50yMtyX+ucUK8pMenOTjrwrmM1nFCgAOaH
         4gE/14pZKhqXxs0L4tV5Jl8AqHELGGnflWY8bizPHNqW7WwFibjGm+pKQcjgBxzmfN
         RnlPlSp8ooGCDxUtegoONfyuU0DA5S2YxRWRbm9Qm9rGguXs9nRa9Q6tVEyTZ+oogr
         xPmEH8hzYVN7nMLRGii+AX3OxpCmQuRCuGOeMjJRvWzYpZw3xvYMijlokofyDjSrMn
         engh5PiIpXr1Q==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Ml35N3C4Lz6tmQ;
        Sat,  8 Oct 2022 13:35:36 +0200 (CEST)
Date:   Sat,  8 Oct 2022 11:35:34 +0000
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: corsair-psu: add USB id of the new HX1500i psu
Message-ID: <Y0FghqQCHG/cX5Jz@monster.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also updates the documentation accordingly.

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
---
 Documentation/hwmon/corsair-psu.rst | 2 ++
 drivers/hwmon/corsair-psu.c         | 1 +
 2 files changed, 3 insertions(+)

diff --git a/Documentation/hwmon/corsair-psu.rst b/Documentation/hwmon/corsair-psu.rst
index 3c1b164eb3c0..6a03edb551a8 100644
--- a/Documentation/hwmon/corsair-psu.rst
+++ b/Documentation/hwmon/corsair-psu.rst
@@ -19,6 +19,8 @@ Supported devices:
 
   Corsair HX1200i
 
+  Corsair HX1500i
+
   Corsair RM550i
 
   Corsair RM650i
diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
index c1c27e475f6d..2210aa62e3d0 100644
--- a/drivers/hwmon/corsair-psu.c
+++ b/drivers/hwmon/corsair-psu.c
@@ -821,6 +821,7 @@ static const struct hid_device_id corsairpsu_idtable[] = {
 	{ HID_USB_DEVICE(0x1b1c, 0x1c0c) }, /* Corsair RM850i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c0d) }, /* Corsair RM1000i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c1e) }, /* Corsair HX1000i revision 2 */
+	{ HID_USB_DEVICE(0x1b1c, 0x1c1f) }, /* Corsair HX1500i */
 	{ },
 };
 MODULE_DEVICE_TABLE(hid, corsairpsu_idtable);
-- 
2.38.0

