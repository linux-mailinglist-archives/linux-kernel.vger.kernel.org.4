Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01655EE92F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 00:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbiI1WKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 18:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbiI1WKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 18:10:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC472A730;
        Wed, 28 Sep 2022 15:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664402995;
        bh=6IBYOglFVphYzLyS7Cy9i6YsOeXFYUH6ZBhePpREwzk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=X0Xdt3BI6W9hoGCzFIpUNbM76q+hGJQ6McZOIPqHCIRHrnUlEQOJcSn16rGstoHQN
         cOTcFHkV6+FGf/hjaTKpZOJuuo+JeyixhnZR718auH1zW8wjpoPXJpkVOP8tTzeE88
         48hzqcP1QCJ1yQ02DXdMdZr72du5prTJXNtJ2B9E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MBlxW-1oW0H12GjM-00C7I2; Thu, 29 Sep 2022 00:09:55 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     andriy.shevchenko@intel.com, rafael@kernel.org, lenb@kernel.org,
        hmh@hmh.eng.br, matan@svgalib.org, corentin.chary@gmail.com,
        jeremy@system76.com, productdev@system76.com,
        mario.limonciello@amd.com, pobrn@protonmail.com,
        coproscefalo@gmail.com, platform-driver-x86@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: dell: Minor style fixes
Date:   Thu, 29 Sep 2022 00:09:52 +0200
Message-Id: <20220928220952.2772-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:51Ed9uc991NPy61dqt81skN2+lxNAdMCc4CN0jXk+lkQmizRVQE
 R2SfhDNsa1F4/9OUHiuDimO0gjiqH58/EyN1dFpQgx3p4ftsgcPjyWtDQlVY3Vf9meSUcEw
 7vAn84g79jyGORhzjna8vpIVOWupzwOme5gx0jwaBS8+4xZaUGP8hule9kHgLt4cC2u27O5
 SbkGn5SZIRhjy3d62um9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1gMNfHiW/sg=:nV4t9vDBx8l57vTkyCoNRq
 107MHEYNwldTJ7m3aofqcOhBwmjdSFZNoaa+/CegCOPTMXgdvdVW5Bwk8WXuYMC0cBtx6jaL7
 2SbJKEuVgwwAyCCaRynTILqXXTrHH18IhZfYtn1NRnnfcNMaq0a0OPf+1EzgL18Um1CSl7xMS
 gL6cmaGelIxNkz1kaP/GoRUAJSv7/LKd+4dXtA/7Cgvw5GAmbWE007IUhbp1TVCVwB3WW0uP0
 Xn378232EkHburjZmdaCOoNC/ZAWMOHcHRCpDSRK/Gr5w/sNBnQ+48kmEiBxGDx+zjEcDuxIA
 DOAZaCe7xz37+Yk8PCQICZO1J8y6L0gsKnIsABnFddVvEDAVAY4wbZM8D/g25QQqQ/y4P0cas
 mJsvBWCGeGcaYOKbqo8CGaEhp0KN5msM7WkP3+u9lBnHwNyKafAosn9U+yurKS+d3OkxMoiB2
 e+HtAh4MC7gnsy9e6G3t9TS1XC9Z7VzWpPbwCQ70rrGvo0nonP01y4dqoaV60GlfCylRrhD+o
 p0RaXhmoWwOYTclsTSOaHrY9w1N9baSJqUIxTAw2kJ8pTkPeZoC+2EYo8LOyXNrJO/5Wic3JW
 T6eU1ZXxgHYKUcxnDXPMBp95ty3UUxMfwRofv1T4Wqljh84Ki+evp9IxKuXfQqk8DwWvwiGJN
 HR1PRFiGWkHEoRF5dgrDAejzU7hkoBvZERtTp11dDPAlESlEELd5m6bfIFH2tH+lkQmGI1/QN
 pGZE4jIAVwglF5USXJ4r74i3P0P++USMl0R1KtpGoroigcB7ig61ekVLW1cwcO6aDNPvLz25G
 fyeVXrKAbBk0OuddzC/QRKv/TrF+eQk1sK51f98a8FENTMxSlCqCm3W6SoaKhixe3tDi/uGhC
 3pe/xMpeUmag5/KOXTBFYzD2PfCaRDVZXwE0MF/XTMGjZ5IoYFSRqzCtqFQDs1MSHWh5W3P5v
 81MEJKL095Nl/nuWeM0o4qOzcBeT5JtIBfQV4HHXVKc7oNn+hpidQPjcn8GyWUPLJeuN8b1cT
 bicQVddyAosTcxEMCbaIVB0sVTjCvsE65euPilJ0gOiQa9DiZFwwD9n/qT3lB3KftP/joEmzd
 ekuwO7FIdzXitfAZxia6Dbcm7JhjiE0yNVp2oTrfoNUGsrdC9cMxBNNhjmNYqehSJ+mU4vvRu
 mi2vNYV2w4sieED5MZQIw50IO/
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

