Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7348F6D7586
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 09:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237162AbjDEHbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 03:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237150AbjDEHbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 03:31:15 -0400
Received: from s.wrqvwxzv.outbound-mail.sendgrid.net (s.wrqvwxzv.outbound-mail.sendgrid.net [149.72.154.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932655260
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 00:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=equiv.tech;
        h=from:subject:in-reply-to:references:mime-version:cc:
        content-transfer-encoding:content-type:cc:content-type:from:subject:to;
        s=org; bh=WHm2RIViCzWT3zYPU2Vw9vCyr3A/PowltDWn5Mk40eo=;
        b=c5qHmt/IuHZZxjznRhn0jk+1NCIJWMVLSNYyvDZt0h+8FuLmwbMbN18lkfcpJ9c0td0W
        LmIpzy3WI09Tb3xIcsYxDXQKoHBySQxdWNEUWnxln2qmYutU9tDVFJnT8aOIGcuBPs4xUr
        oGbLdNSJrehHyCRfxpZxs6/slAoXyVR50=
Received: by filterdrecv-5848969764-44p6h with SMTP id filterdrecv-5848969764-44p6h-1-642D23BB-7
        2023-04-05 07:31:07.265212223 +0000 UTC m=+3657493.273161580
Received: from localhost (unknown)
        by geopod-ismtpd-11 (SG) with ESMTP
        id yZLoy5XZQl6wiZgmdZCnmA
        Wed, 05 Apr 2023 07:31:07.061 +0000 (UTC)
From:   James Seo <james@equiv.tech>
Subject: [PATCH 2/2] hwmon: fix typo in Makefile
Date:   Wed, 05 Apr 2023 07:31:07 +0000 (UTC)
Message-Id: <20230405073056.53466-3-james@equiv.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230405073056.53466-1-james@equiv.tech>
References: <20230405073056.53466-1-james@equiv.tech>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?1X41iaRO4wVP+tFXGLuxpQ0yxxMDhGIesR5UcsYKVengQKgidLJSXwOMZlPQwP?=
 =?us-ascii?Q?WsRtMyA1321KpgTLuhAnL1Q906rlnMtB0DnOXYE?=
 =?us-ascii?Q?bbiFcTMm7bAjVX0c04NwOQfq+hLlCn7ZqNW=2Fy46?=
 =?us-ascii?Q?ppxByYNwVDf51xG15cKuc7jzyUkriQZnbhBVJUP?=
 =?us-ascii?Q?wf=2FKHXw17y8H4q=2F7GMIGd1iZ+CPbQ3UNVW7JE8m?=
 =?us-ascii?Q?aq=2F8EiZpud=2F97m1yHwQWhokPQoI33K=2FLN6Mbv5?=
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Seo <james@equiv.tech>
X-Entity-ID: Y+qgTyM7KJvXcwsg19bS4g==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the spelling of "ACPI" in Makefile.

Signed-off-by: James Seo <james@equiv.tech>
---
 drivers/hwmon/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 88712b5031c8..e12c111a174a 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -6,7 +6,7 @@
 obj-$(CONFIG_HWMON)		+= hwmon.o
 obj-$(CONFIG_HWMON_VID)		+= hwmon-vid.o
 
-# APCI drivers
+# ACPI drivers
 obj-$(CONFIG_SENSORS_ACPI_POWER) += acpi_power_meter.o
 obj-$(CONFIG_SENSORS_ATK0110)	+= asus_atk0110.o
 obj-$(CONFIG_SENSORS_ASUS_EC)	+= asus-ec-sensors.o
-- 
2.34.1

