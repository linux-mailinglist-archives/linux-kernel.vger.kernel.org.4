Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3AF5EE940
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 00:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbiI1WQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 18:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiI1WQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 18:16:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274E6CD66A;
        Wed, 28 Sep 2022 15:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664403305;
        bh=ibjtVxtpavqCZDVP7y4RI1PBz/mwSGzCcQeKG6o8fQY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=hrDx7HjzYoAWaDsASGWu0HH3ZiQTaCP1a5rsk1Ki2iQZPWzDRJ/z17Vfh22TRSMm/
         hRIGdtTLWw/ueCIXQjq4fQ30KWMLNyQuSXa9Nb4SKjCHIT4LbsUNI9F0dgQ/6ITP4S
         7kgQ0CUzJ4TFUJFqg/uz9rGW2PTLdrFkPKzwukws=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MkYXm-1p5c5G3LYs-00lzGi; Thu, 29 Sep 2022 00:15:04 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     andriy.shevchenko@intel.com, rafael@kernel.org, lenb@kernel.org,
        hmh@hmh.eng.br, matan@svgalib.org, corentin.chary@gmail.com,
        jeremy@system76.com, productdev@system76.com,
        mario.limonciello@amd.com, pobrn@protonmail.com,
        coproscefalo@gmail.com, platform-driver-x86@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] platform/x86: dell-ddv: Minor style fixes
Date:   Thu, 29 Sep 2022 00:15:01 +0200
Message-Id: <20220928221501.3823-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nj6AwMYL8lgVwhwDheJAZPMH7j8l9XfP4urS0cXxMi7YJxVUm8E
 n0A83QSE1P2VpTzjqJX3Vy7yLJSA5D9ezlOYvVSOXUn2no36RKDTi0ZBGcJv1e/LhUndhY5
 MZ/i9FK9P19NEhKKbKkIy9F5u1ML7bSZiqDuphREmGOtGGPeS6wcDcphqsYj/FtWLFFVmEH
 zf4bfA4KkWHOJ1IgoYiNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xdckZvpyjd8=:hi0sBfM8Xh9mtue086RGXO
 3gPvmUARBZA4+URDKRFDkRXYhDPY83P63Yxe+tsGl2w7xv0YyKWOLDhtVqB3vFDYr4GAhr79K
 JeXUmiFgvh4TekKSXZUAwyXikwi/PPwgSqHQFjKhEjPVdgMqwL/ZXEs9cJXIzSgSziIUujcTj
 TPD8A08CT0vXsHoODmBBSOeUR4sFURlCBysIZfpOtlrNaNFc7AfFomwNVJrzbhZVaIf9xErbD
 791u3ZCcEyfo4PtEPMDLAt4+++KQJTXyyVC6mb6/AdtJA8pXoLoMcn/we8xUDoDUhvjvK/RdD
 i72OF6A06pisb4zVjb0cMBHZn6X4ItpN+T7sZ5zXOGGZVkWGfbALL8OWUwoFbcC1sm0c9yKiR
 WQP92NAEHENgpMY15vJe82Z2xA+O+NdCRFusG5eHqdCWT/CJN2NT9OYNRXP3WRY6cvdvL/H3a
 KcwwROb5aQiJPL14ZNZ8epJ8rtGcAYDislFIOTwz5IaSYqfeEEwi/vixVGhYximgyzRExcR5U
 XMcrYuVpNJuOoG7vrTV35yj8IEHpzrEFzDQOQESqmV43B0+snP0tKyPI6/EY768u8qgjXt4zd
 1G7va3PaMiAzvo4GvFC6UlCBWPjkjAHz5Kg0kt8giX0PsWCtx2pS2JdKGt4C9twxD80VQ4KOY
 YqGHxt71zq/ZvNlBC95s0yu5aRHb1/an7GtT2Cv+C4u05MhD1ZEtaAZDkaAggbiYQwr48a5FY
 1Qe98sh8SfZTgJi4v1aARK0mMKaiXT+SiRnhfr5QqolBBQBOLlQFGNlX7wR9Og1VPlCEBmYDV
 aSzctTLwNDu1xrsthU5rsr4o7e2yA9b9mY48VizaQvHDHYvHLSw8BJqbGCkQcGsQzCUiyeYDa
 zDVNZSTB6pysv3oDIVRSmeeMoP+moMHqqiVYWe5tC2kap71fqUsFuW6VXEj6090vFtoZv27CW
 /4bae19AC917rY1QS1PXVP05quOa1mfNuQzBa9yHaRHgogodQ78QtCqJEB3OgCuke/g2PNiRT
 fw7k9Nv2VXJ2cKELW3E11pwxhlzC+9GrdN+s6J60EiXnp4oVxEN2rjmZjLDDJVzudt4eDvXrN
 brqMJh3Bhj6N/RSLlOCm2+kHsnr7wlmfoxvh+yaWhw34l6xH3JcqPAPAAamY1w3onckklyNnb
 M9uarj3gTho4/6LIGi0Jk9jNoU
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some style issues found during review to improve
code maintainability, no functional changes.

Tested on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes in v2:
- change commit message
=2D--
 drivers/platform/x86/dell/dell-wmi-ddv.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x=
86/dell/dell-wmi-ddv.c
index 6ccce90f475d..699feae3c435 100644
=2D-- a/drivers/platform/x86/dell/dell-wmi-ddv.c
+++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
@@ -1,13 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * dell-wmi-ddv.c -- Linux driver for WMI sensor information on Dell note=
books.
+ * Linux driver for WMI sensor information on Dell notebooks.
  *
  * Copyright (C) 2022 Armin Wolf <W_Armin@gmx.de>
  */

 #define pr_format(fmt) KBUILD_MODNAME ": " fmt

-#include <acpi/battery.h>
 #include <linux/acpi.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
@@ -21,6 +20,8 @@
 #include <linux/sysfs.h>
 #include <linux/wmi.h>

+#include <acpi/battery.h>
+
 #define DRIVER_NAME	"dell-wmi-ddv"

 #define DELL_DDV_SUPPORTED_INTERFACE 2
@@ -52,7 +53,8 @@ enum dell_ddv_method {

 struct dell_wmi_ddv_data {
 	struct acpi_battery_hook hook;
-	struct device_attribute temp_attr, eppid_attr;
+	struct device_attribute temp_attr;
+	struct device_attribute eppid_attr;
 	struct wmi_device *wdev;
 };

@@ -153,8 +155,9 @@ static int dell_wmi_ddv_query_string(struct wmi_device=
 *wdev, enum dell_ddv_meth

 static int dell_wmi_ddv_battery_index(struct acpi_device *acpi_dev, u32 *=
index)
 {
-	const char *uid_str =3D acpi_device_uid(acpi_dev);
+	const char *uid_str;

+	uid_str =3D acpi_device_uid(acpi_dev);
 	if (!uid_str)
 		return -ENODEV;

=2D-
2.30.2

