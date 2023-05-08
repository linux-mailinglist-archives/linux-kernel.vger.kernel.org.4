Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70826FB86B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 22:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbjEHUnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 16:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbjEHUnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 16:43:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B84A1BF5;
        Mon,  8 May 2023 13:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1683578569; i=w_armin@gmx.de;
        bh=r5HXSxnx/KjqPNJSP3WGgf4fjTPaNtfHHpZ6K3D7eHM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=qyb3wcbTOzAwJp9xmKDuCHXHgu0NYF4jtQB8TNphx+041gdBYomz8jAI4//JsqGos
         raQGfWANAOdkY/Z60igCVKIj5FnCOg88D4WNzv1tHmFoK8gnu+XqkA8Q009qEBFxvn
         vjlvdDwRFQ+S/iWklu5re3uxFQ9prD66nj2gwIJxaoY1Sj465S1TVxBgGzIrqheS4K
         S1shXypTFm29vVcGjNPW8DkV7svV/jRtbtQ009fzyMXkQ8ijXYLGWC+csPD0fA1Wl3
         6H4xbmTWsV74eTP4JR+m/BZ+ONf95vU/ViDNuAb7JSC+XZjN2xPUQV/24xBOT9HcXi
         TdBLr9iqWGGAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MybGh-1q7zDJ45OP-00yx1r; Mon, 08 May 2023 22:42:49 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     corbet@lwn.net, bagasdotme@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] platform/x86: dell-ddv: Update ABI documentation
Date:   Mon,  8 May 2023 22:42:41 +0200
Message-Id: <20230508204241.11076-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230508204241.11076-1-W_Armin@gmx.de>
References: <20230508204241.11076-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PtXvOwuzI8GBNkgvzFrOnQ4/FEfjNFHlXPicx/6QaagXY9XXcX9
 rS8ckOYNAJQAddILazHDGZjKphrvVGWVT1XWVTvv/7JjO2ewbGnhzqL7Q1CuU1MGNzTNNtb
 1mKBg4vCp0vrvKmdvybJOJ7RlZjL0tFbdc6U/g3Brj9frWkN0zAsC+DZgOdQty98cJGXZmT
 AD+dLNc9RQhrM9Zw8C47w==
UI-OutboundReport: notjunk:1;M01:P0:s2XUhjDFoDA=;bGQjvKXQUKwYWW3MACdY8UPsDss
 qS7U8hAwayQQ4oXqshkRIgtufUbN0ZrqVA4+rrVk4kgeBQzIZl9cb5ulNqln1MKjK1UVk8f8S
 WWRhcHQH5AZKEnymXtLJKI73y3U7WUlv9Vg3Q6x8VN0ZYZjmTwrDZCtAXBuWEAWKj6LmEYONa
 nNkqpDP3p/EfL8tAE2kVLevlNui9WH1qHNPYWP5DwQ8ZZOD5RLarP9PMhSVjE7wifsyWVHVk3
 qta8AD3tm/7MI1M8yvpBktmS+49PyxBFav8kxIw116GELYocngazcAWPdeGo38gDM37gfOW+8
 tek62zI40ikUN7jf/qMeDDcuTSJ0mgfzg2hiNG3LvdsEpFEJOQQn6YG6SA/zf5Jk0DZRBzFiv
 /d8XfOBxgurikd5m02ZuY4BCAdlcDzZcu9mY8LHKZbvLtTEgM6r/dgiugldA3INoy2TntRwCM
 OprG9rYr7MKKDlxZtXD1+8WdUWvoIP4GytsY6/Z7WI59jEeOlkKoZKM/BnSQDNizjf4NPCiFB
 fp5/Hv3b1E4bax9V+9fP6oUDNmU4cYAl31awNSPDViEajrf/NtJ00fd0mwtTMcMY4FQGbYzRR
 zq4om2Ta1LAJGrDu1w4j7LePGYiSb2rCv2yh7yKdaBa5eFi1M+28EzTV9v6rDYQVwTI+CNuf6
 dDTWQh8oPvowUEdf4QPdv8KIdQuHdCy6+zmLlut/x7QUUScF0gqxueT8m0WmZeSVL1aKp4/V1
 J/s3UjnXYJmSwGZdbNRhD9d21IVSdOV27day1NyjQvbgPKjKcEvWsVkWEg1JpI8t7xUfeYEga
 WAsdopgIrMqA0vIhpGCEMhrqiwgPgJDgUnR2orumHnL14NR/xxddpZjn32EBxs/atUUARLf1k
 RXNPrWW8Q6P8VQ42dZ2lVqjhi4HGu0ecCv9adM8XGY481/35otgAbFCu0h94DnqIU70oF9r5s
 2xnum7wwQ+yUX4qJy4b7OdYuAfw=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Synchronize the ABI documentation with the driver documentation
and direct users to the latter in case the search for more
detailed information.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes in v2:
- None
=2D--
 .../ABI/testing/debugfs-dell-wmi-ddv          | 29 ++++++++++++++-----
 .../ABI/testing/sysfs-platform-dell-wmi-ddv   |  4 ++-
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-dell-wmi-ddv b/Documentatio=
n/ABI/testing/debugfs-dell-wmi-ddv
index fbcc5d6f7388..81cfc788be15 100644
=2D-- a/Documentation/ABI/testing/debugfs-dell-wmi-ddv
+++ b/Documentation/ABI/testing/debugfs-dell-wmi-ddv
@@ -3,19 +3,32 @@ Date:		September 2022
 KernelVersion:	6.1
 Contact:	Armin Wolf <W_Armin@gmx.de>
 Description:
-		This file contains the contents of the fan sensor information buffer,
-		which contains fan sensor entries and a terminating character (0xFF).
+		This file contains the contents of the fan sensor information
+		buffer, which contains fan sensor entries and a terminating
+		character (0xFF).

-		Each fan sensor entry consists of three bytes with an unknown meaning,
-		interested people may use this file for reverse-engineering.
+		Each fan sensor entry contains:
+
+		- fan type (single byte)
+		- fan speed in RPM (two bytes, little endian)
+
+		See Documentation/wmi/devices/dell-wmi-ddv.rst for details.

 What:		/sys/kernel/debug/dell-wmi-ddv-<wmi_device_name>/thermal_sensor_in=
formation
 Date:		September 2022
 KernelVersion:	6.1
 Contact:	Armin Wolf <W_Armin@gmx.de>
 Description:
-		This file contains the contents of the thermal sensor information buffe=
r,
-		which contains thermal sensor entries and a terminating character (0xFF=
).
+		This file contains the contents of the thermal sensor information
+		buffer, which contains thermal sensor entries and a terminating
+		character (0xFF).
+
+		Each thermal sensor entry contains:
+
+		- thermal type (single byte)
+		- current temperature (single byte)
+		- min. temperature (single byte)
+		- max. temperature (single byte)
+		- unknown field (single byte)

-		Each thermal sensor entry consists of five bytes with an unknown meanin=
g,
-		interested people may use this file for reverse-engineering.
+		See Documentation/wmi/devices/dell-wmi-ddv.rst for details.
diff --git a/Documentation/ABI/testing/sysfs-platform-dell-wmi-ddv b/Docum=
entation/ABI/testing/sysfs-platform-dell-wmi-ddv
index 1d97ad615c66..a9d39d9e8865 100644
=2D-- a/Documentation/ABI/testing/sysfs-platform-dell-wmi-ddv
+++ b/Documentation/ABI/testing/sysfs-platform-dell-wmi-ddv
@@ -3,5 +3,7 @@ Date:		September 2022
 KernelVersion:	6.1
 Contact:	Armin Wolf <W_Armin@gmx.de>
 Description:
-		Reports the Dell ePPID (electronic Dell Piece Part Identification)
+		Reports the Dell ePPID (electronic Piece Part Identification)
 		of the ACPI battery.
+
+		See Documentation/wmi/devices/dell-wmi-ddv.rst for details.
=2D-
2.30.2

