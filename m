Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FA16D757F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 09:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbjDEHb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 03:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237109AbjDEHbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 03:31:13 -0400
Received: from s.wrqvtbkv.outbound-mail.sendgrid.net (s.wrqvtbkv.outbound-mail.sendgrid.net [149.72.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6BA4C20
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 00:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=equiv.tech;
        h=from:subject:in-reply-to:references:mime-version:cc:
        content-transfer-encoding:content-type:cc:content-type:from:subject:to;
        s=org; bh=HoPh/Ucn4T55an3hAyMyebHQEpRQ6pkjUilxlT4S6sQ=;
        b=adSfsVHZbL5bGTWBjjhUKHaaPfM7f4EqfJ6XskSPPpBZCFGxRLp1lwKNvsmiR1yTEcHE
        HaCsuONcdRn0OFm3o04s58QqXCvnAeaeoRAMOhW87EN4fjpwHpa1VxQSbkr0nWoK7hJ3+w
        HkQ5GdeXIj7cV8bgUYYNxWrIVmZrVYwu8=
Received: by filterdrecv-5848969764-6b8cb with SMTP id filterdrecv-5848969764-6b8cb-1-642D23B9-22
        2023-04-05 07:31:05.503007987 +0000 UTC m=+3657528.108268007
Received: from localhost (unknown)
        by geopod-ismtpd-5 (SG) with ESMTP
        id ofnNMQBPQYC9uyx0dKODXQ
        Wed, 05 Apr 2023 07:31:05.328 +0000 (UTC)
From:   James Seo <james@equiv.tech>
Subject: [PATCH 1/2] hwmon: remove trailing whitespace in Kconfig
Date:   Wed, 05 Apr 2023 07:31:05 +0000 (UTC)
Message-Id: <20230405073056.53466-2-james@equiv.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230405073056.53466-1-james@equiv.tech>
References: <20230405073056.53466-1-james@equiv.tech>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?1X41iaRO4wVP+tFXGLuxpQ0yxxMDhGIesR5UcsYKVengQKgidLJSXwOMZlPQwP?=
 =?us-ascii?Q?WsKS14j+js7oLIknBGD=2FQ37Iiq1gpjGbBVPmgYa?=
 =?us-ascii?Q?eM9BT32Kn3H0lG6uMV6Psg8mJ9VXEgoyaSlmI1k?=
 =?us-ascii?Q?MyBhe+wSv7K2vDo2sU8zllm6Q7v14xNd8f7h8pN?=
 =?us-ascii?Q?+LzIhR9X1B2QZiRFfTUk0wnecnl3N1Qb5xCbR2t?=
 =?us-ascii?Q?VugQtU=2FsOZJWPRTL8K8Wkds=2F+TV0YKiiZ8OhlN?=
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

Remove an unneeded trailing space.

Signed-off-by: James Seo <james@equiv.tech>
---
 drivers/hwmon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 5b3b76477b0e..0d6b60b8d0d2 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1976,7 +1976,7 @@ config SENSORS_ADS7871
 
 config SENSORS_AMC6821
 	tristate "Texas Instruments AMC6821"
-	depends on I2C 
+	depends on I2C
 	help
 	  If you say yes here you get support for the Texas Instruments
 	  AMC6821 hardware monitoring chips.
-- 
2.34.1

