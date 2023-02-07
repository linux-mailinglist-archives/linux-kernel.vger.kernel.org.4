Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D051968DE3B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjBGQv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjBGQvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:51:25 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2893B0C6;
        Tue,  7 Feb 2023 08:51:24 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675788682;
        bh=9AP4I0rjgvgt9DJJZ6qcFwMfymICKIz69p/X/bUnTjg=;
        h=From:Date:Subject:To:Cc:From;
        b=WEzf0kyDPFHYWy3niUlAhr/HsK73J5NoudUA4a7qb0ShJqHcD5LCSViNIi6H02y3f
         CNyLll39ArCY2jVdkL2+ZFaWp6gVFixoA3kxtqjePw3ml2I4zaIe7SdsLrUk14CzvC
         FFgAEry3ynoVmTADiqIauNaJQBjkY1sa36yslbkI=
Date:   Tue, 07 Feb 2023 16:51:19 +0000
Subject: [PATCH RFC] MAINTAINERS: dell-wmi-sysman: drop Divya Bharathi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230207-maintainers-dell-wmi-sysman-v1-1-6594fea12f6c@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAIaB4mMC/x2NuwoCQQxFf2VJbWB2FAVbwQ+wFYvZSdYNzESZ+
 GTZfzdY3OLc4pwZjJuwwb6bofFLTG7q0K86yFPSK6OQM8QQ1yGGHdYk+vBxMyQuBd9V0L5Wk+I
 m0DZTn5loBDcMyRiHljRP7tBnKX7eG4/y+SfPcDoe4LIsP4wzkfuHAAAA
To:     Prasanth Ksr <prasanth.ksr@dell.com>,
        Divya Bharathi <divya.bharathi@dell.com>
Cc:     Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675788680; l=829;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=9AP4I0rjgvgt9DJJZ6qcFwMfymICKIz69p/X/bUnTjg=;
 b=Di9GeoIzHdRAuVaJ0poJJdc3LaaldKGfY4uJn4/rer+v+m/fFKm4wQI9o6RjGj/HEbcp2x1kz
 T/g4dHm2bK4D8A5qPdUTuROsjdkPVhX8fIKVNT4e3AVkJLUi6jfB/3S
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the bounce sent by Dell's mailserver this user does not
exist (anymore).

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fb1471cb5ed3..396bb00d98a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5930,7 +5930,6 @@ F:	Documentation/ABI/testing/sysfs-platform-dell-wmi-ddv
 F:	drivers/platform/x86/dell/dell-wmi-ddv.c
 
 DELL WMI SYSMAN DRIVER
-M:	Divya Bharathi <divya.bharathi@dell.com>
 M:	Prasanth Ksr <prasanth.ksr@dell.com>
 L:	Dell.Client.Kernel@dell.com
 L:	platform-driver-x86@vger.kernel.org

---
base-commit: d2d11f342b179f1894a901f143ec7c008caba43e
change-id: 20230207-maintainers-dell-wmi-sysman-40d6cd1ceddf

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

