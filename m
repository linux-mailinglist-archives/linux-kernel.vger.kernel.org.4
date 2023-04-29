Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3C76F2712
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 00:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjD2Wzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 18:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjD2Wzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 18:55:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C7ADE;
        Sat, 29 Apr 2023 15:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682808930; i=w_armin@gmx.de;
        bh=OPVah3fGgiFDxtemCf8HhtgjxqFM4GudTMA58n/qrqg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=n3pyPON8ToRzN9zU24IWOAsIgtuJmV9Y+1AVeTsBmx2htwdYmJ70zx9H5ooOltxAv
         f03FPekgMENIepTWIXeLlVtbuP6PjkjbxvZwzW6pOFOLU31AiAtdWoVPCrWriDikIC
         uegD7pnPGotauBVOvEBhccFlNwFCxyeyWxa0MGUuctSbKHYg+YQpesHNlPeYf1LA42
         id7O23vFPl9USeMdm6RsK17sSzVDRGl4IIIKNMwfP9vNUWH10vBvFrw0fyoNpiLc/l
         QSktCg5mAbaPbOCjM8l8wFuahI0MOhnWdBJFYybzHoorQCjKD90j8Hg/Kw3lH2wDaz
         2CyPICCHcJuDg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MWASY-1pmuF93rqc-00Xe6z; Sun, 30 Apr 2023 00:55:30 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     corbet@lwn.net, platform-driver-x86@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] platform/x86: dell-ddv: Update ABI documentation
Date:   Sun, 30 Apr 2023 00:55:25 +0200
Message-Id: <20230429225525.10507-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230429225525.10507-1-W_Armin@gmx.de>
References: <20230429225525.10507-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IkdI6Yin7g1agGdxzczipPFzmKmyhclawkTmmmdxepL/Nk4/4en
 r1S9+rKZCaPsBnlV7swakSdQqV3UZBADEDERilt3SbTESYvt9nbYzyGrldUj7mw/916dBAw
 BM4PaQBFNmS4U4qLDe7RFNzxLxkaLi6br421uBmyKojcRC0/nfiVoH3LBBCbGLgeFnvArbC
 MP0lRUqZ75rocy0x4tesQ==
UI-OutboundReport: notjunk:1;M01:P0:NucOP6JeLGo=;nx8EOk6dhE4hbOh9HTCkmd26eET
 ii6KQePZj2OY2lgMmMAhxqu1OoQ95BtJ9g13SbtuN3LIrXceFzPo9+MS8YS6WiFczXFbOGVRP
 dFElhL7ABv4PAbiBltN1n9blWYrOI9xWoo4nU9Oqpx59dpT5WlaAI0KcYoiiwll66ZKYTlSeE
 90IzXf3mNC3EjFAmI6wysYlW1dNchLuEeKQ9DJHUGERCDo/zfipYK3XS2Og7J10B0gMLCJL8m
 mTdZ7f6jJItnAL2IikDkGtNKLEGhgLx2Xd33cSkIHmmsl1WJJegVWUpDjba6j8EFh4qNUjt6W
 l0mR/HgozVIPjCIZUG+7cDZwpKqh2Ktpee0fBEhA9jsvVSXmPQmAJOuprofvgEkNWdTb2AiPW
 EQdW5LWBInijaVCEQLrz3bVqLpuIjzOgrdu/wCHbmClxRcMJ0expoHR8sA10fNCUqu+JUFaqW
 ag91cr97EEz5xMZqWAPmGyzs1Owp07lZ4S9zFRa2Suu0/kHN0L6bZ6egkAcpX2q16kVxx3IPu
 tONtWRYK6AIOx+vhQXeZ5AwrnWHtxK1LN0Xg/OEoP5SrmzHHPslaY1ifFwR/WyQs/nM7DJy4U
 T/N6X2YHqnOZrF8t/iqozrTLjOwFv4lROAz1e3V8yN33nmS+5ix+l+/NqfdNeNPL7lDFhu0B5
 DOI8o4fnarMXZqaoc84uRrSM80ZNEYPNfEPwWOAKQqZYNByyCKQsW5p1y4pbudz8MNUjfONgG
 4nbqR0dun9ptkcTSPMHTRUGN38/se5wWSSUltOPrhFsLj2fucSVtMm059Ilqm0v3CBKVnL+Ds
 RJfoYq8ISam3ZNUfCtgawR3MTyeja2cDB+oMRvaqUWjMp2bD2L1iXQlF/h1P4+BN9IW6S9R45
 LMEFH4HGG4w3SZqdq64hUwjkDHCPkVK6k3cQWEQVOj3N551jK0EpCFvST/bpKTIXaDac0Kj1V
 CZuoZyK+V9+uYndyoYeqxQdXDjc=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Synchronize the ABI documentation with the driver documentation
and direct users to the latter in case they are interested in
more detailed information.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
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

