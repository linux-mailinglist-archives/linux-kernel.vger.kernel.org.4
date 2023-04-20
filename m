Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1105B6E9FFE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 01:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjDTXdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 19:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbjDTXcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 19:32:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A843335AE;
        Thu, 20 Apr 2023 16:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682033556; i=w_armin@gmx.de;
        bh=B0qhcNR9k6p0oKbOIizHquPVXpIVRFaO0y8NW2qQJoc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=NxEDBl8OuUFu3QnmFILoO2EMsNoF6dj5ESLN4wZCOArG7trJyppwWJNqJQeNuEMgl
         6TBM5FVUylu69ebRk5/z0dHcINi3Kz9uFPEdJSJ7DeJgYwUIihVM+NphaB6uUzVHDR
         NA2vASebZn/UPqaVlJPW/p9ByuGgtBiKpzIwZTEZnTHYo487nJaRJ6i1zkyXtvsw1I
         ZaIq8i/rezS/2/bKSlHdKo22utBDrZJXLPRLfHf4V5owrTuMKBVGbmqntceyKLvZUG
         hMSHh410w8TMs2uzGhnf8OWkJPL+ABhRHRYelsC6yCfga6c9pL1QpMUf1OZH57pDeO
         0swUX8dq6gkKg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N7R1J-1qNIqc4AGL-017kzy; Fri, 21 Apr 2023 01:32:36 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] platform/x86: wmi: Add device specific documentation
Date:   Fri, 21 Apr 2023 01:32:26 +0200
Message-Id: <20230420233226.14561-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230420233226.14561-1-W_Armin@gmx.de>
References: <20230420233226.14561-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XOPJV0Ar20HvejJHD0KNW0I2FFCa79KHcXCANZShI99X0xroJGg
 xVl2K7+mFnNocrvL24ewdxchEfb0F6EoQIoHFlH8LllUW8uciNx3I5I8flng7nzEInGeaso
 G6ufo/FCYbn166GB5lyLOf7SFiiVRFu/i7vwfegEihU/Fk7StnIX6F0MpZ7l2LPhDLZijfv
 ejDoic33FnQH3wNzcbmww==
UI-OutboundReport: notjunk:1;M01:P0:8nAaYfCL+R8=;/vxLV/dC7gh2JAdBeMEgVkxZHfo
 MCq07KJ7NmwEzO/m6dvxp4c9YlKQQFo5hSwAhuJ/qyCJlGBC7w0tvsbsjR9NrWvww4b1WUp9y
 JYL22XO1NvZSE7qp7+uQyzLQ9Xbal6y7+voKkjcNID/DlpLu7DsnQSy+Jk9bas1+iz8sreSV5
 S4IW5EmgvVHSwDY8xVaYOvzHdfnuYiCwCiagiPA56Zz/3kCerpVgZcxLZoikBeZuhk90pG5Xd
 JwgRLEg5wo4Xtw/FV/Pw0U9IodKI9brF94dzoJSeyH1F58Cwmsj2c5/ZtceGieHicmJRQYnU0
 GX6lrOhq4S8Uv9TBSvEHFO5q5tC7I2qqVJAngkSqeOCfZxv+v+0rttfW84XhMClLC4VclUAcT
 pJtFm/MrXplZxQ5wP8SdM69W3s83FTZA2ZVJtWuA6dp538CGMpK6ZyavOHPmmZTN2IJhYUXZT
 ZYJ6BYvVPVCdueKjFRNT+J1jDKKzF+mKz0lGGsvkZBjoenOFkRZM9mcW2w0czgUotqieaGJU3
 /BNL/uOtYfFXq/BqeuiV3lgebsjps9eArg2fHsenz/NCSvvNtHtRhsobQX5OoYc/WKIVpqAMX
 yjbARotWGC99GhY5lFfhFYJLyGORBKKzUS4S/j1Uvb5SPlCqNmxJlPUQvohLmsrwZNUqbHOjP
 K0sC87Jy9DLdUZNMQvl+AZMZ54De0VjjLFy0VY6DTVIIBnt6MYEHSm0PxZvU+U5iMJwnmKilS
 w2yAxUbnrh2eI8FdHg0Pdggrzf3yPebJEdt4rq9g+l9LbBTdR7sF6R/wuJErZaf2QESMF88Yj
 MgWzNURnzhQ+O5R09NBdUe60IklmkD5fkFBO+P0gMISfUKZv9wLnMRZgfh2GPz/lz1wWM3B68
 YR1dM7nj5P6GWyHKPqh9G2vJkMgENxBIPxMD82tAAt3bk9d56zjWjHoowPSAaurGYxhe6UM6p
 ewEH4EbFJX7Hk2bw31ibWuyO2M0=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a place for device-specific documentation of WMI drivers.
The first entry is documentation for the wmi-bmof driver, with
additional documentation being expected to follow.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 .../ABI/stable/sysfs-platform-wmi-bmof        |  7 ++++++
 Documentation/wmi/devices/index.rst           | 22 +++++++++++++++++++
 Documentation/wmi/devices/wmi-bmof.rst        | 22 +++++++++++++++++++
 Documentation/wmi/index.rst                   |  1 +
 MAINTAINERS                                   |  7 ++++++
 5 files changed, 59 insertions(+)
 create mode 100644 Documentation/ABI/stable/sysfs-platform-wmi-bmof
 create mode 100644 Documentation/wmi/devices/index.rst
 create mode 100644 Documentation/wmi/devices/wmi-bmof.rst

diff --git a/Documentation/ABI/stable/sysfs-platform-wmi-bmof b/Documentat=
ion/ABI/stable/sysfs-platform-wmi-bmof
new file mode 100644
index 000000000000..a786504b6027
=2D-- /dev/null
+++ b/Documentation/ABI/stable/sysfs-platform-wmi-bmof
@@ -0,0 +1,7 @@
+What:		/sys/bus/wmi/devices/05901221-D566-11D1-B2F0-00A0C9062910[-X]/bmof
+Date:		Jun 2017
+KernelVersion:	4.13
+Description:
+		Binary MOF metadata used to decribe the details of available ACPI WMI i=
nterfaces.
+
+		See Documentation/wmi/devices/wmi-bmof.rst for details.
diff --git a/Documentation/wmi/devices/index.rst b/Documentation/wmi/devic=
es/index.rst
new file mode 100644
index 000000000000..c08735a9d7df
=2D-- /dev/null
+++ b/Documentation/wmi/devices/index.rst
@@ -0,0 +1,22 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+Driver-specific Documentation
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+
+This section provides information about various devices supported by
+the Linux kernel, their protocols and driver details.
+
+.. toctree::
+   :maxdepth: 1
+   :numbered:
+   :glob:
+
+   *
+
+.. only:: subproject and html
+
+   Indices
+   =3D=3D=3D=3D=3D=3D=3D
+
+   * :ref:`genindex`
diff --git a/Documentation/wmi/devices/wmi-bmof.rst b/Documentation/wmi/de=
vices/wmi-bmof.rst
new file mode 100644
index 000000000000..b558fa46190c
=2D-- /dev/null
+++ b/Documentation/wmi/devices/wmi-bmof.rst
@@ -0,0 +1,22 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+WMI embedded Binary MOF driver
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+
+Introduction
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Many machines embed WMI Binary MOF metadata used to describe the details =
of their ACPI WMI interfaces.
+The data can be decoded with tools like `bmfdec <https://github.com/pali/=
bmfdec>`_ to obtain a
+human readable WMI interface description, which is useful for developing =
new WMI drivers.
+
+The Binary MOF data can be retrieved from the ``bmof`` sysfs attribute of=
 the associated WMI device.
+Please note that multiple WMI devices containing Binary MOF data can exis=
t on a given system.
+
+WMI interface
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The Binary MOF WMI device is identified by the WMI GUID ``05901221-D566-1=
1D1-B2F0-00A0C9062910``.
+The Binary MOF can be obtained by doing a WMI data block query. The resul=
t is then returned as
+an ACPI buffer with a variable size.
diff --git a/Documentation/wmi/index.rst b/Documentation/wmi/index.rst
index b29933a86380..537cff188e14 100644
=2D-- a/Documentation/wmi/index.rst
+++ b/Documentation/wmi/index.rst
@@ -8,6 +8,7 @@ WMI Subsystem
    :maxdepth: 1

    acpi-interface
+   devices/index

 .. only::  subproject and html

diff --git a/MAINTAINERS b/MAINTAINERS
index 979d37176429..4d5b1f6d77f6 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22556,6 +22556,13 @@ L:	linux-wireless@vger.kernel.org
 S:	Odd fixes
 F:	drivers/net/wireless/wl3501*

+WMI BINARY MOF DRIVER
+L:	platform-drivers-x86@vger.kernel.org
+S:	Orphan
+F:	Documentation/ABI/stable/sysfs-platform-wmi-bmof
+F:	Documentation/wmi/devices/wmi-bmof.rst
+F:	drivers/platform/x86/wmi-bmof.c
+
 WOLFSON MICROELECTRONICS DRIVERS
 L:	patches@opensource.cirrus.com
 S:	Supported
=2D-
2.30.2

