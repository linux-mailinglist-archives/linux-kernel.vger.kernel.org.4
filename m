Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E166ED7F5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 00:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjDXWas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 18:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjDXWaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:30:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA47719BA;
        Mon, 24 Apr 2023 15:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682375399; i=w_armin@gmx.de;
        bh=5sBozmCf1BEgGSGkQpQ5TyvhvOpqQjnfZg8RI7c13lk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FC5JywkA/v5UxGhp8hi3nxL80rlZlTGfNrFD1a2FKtJ60+MKzi+d8Nksv97tNglu3
         q0FxY8612TUoitJkt5zEsZfGEAEb4IjitLlzI+W/4WKVYzt2DCKJV+08bCocRqqsKD
         bPV3B91ffGYh8tiIllxEUkTg2mIPS53a9DdF4QhbeQxLKYVIO4r4BsJuGZ7jULr3YG
         MTzZRjaARA5OISsRwcYaCuMqM7iF30ycjcmUDOP7fJpr6Wu8Hhfxg8LkElRhbXC83s
         fyPau81CN/0Yi9fPHcigm0vqAD7nNlKuZkUeLzZWm+h0u18G6s664m3VvgRkEPuXqo
         kODP61Oxy7r/Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MTzf6-1phpGX1oVW-00R1oW; Tue, 25 Apr 2023 00:29:59 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org, rdunlap@infradead.org
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] platform/x86: wmi: Add device specific documentation
Date:   Tue, 25 Apr 2023 00:29:39 +0200
Message-Id: <20230424222939.208137-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230424222939.208137-1-W_Armin@gmx.de>
References: <20230424222939.208137-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7+O4enu/7tBLqmAzdJ19x3VYC6p81wTc2Dcvcw2qlO/LUffLERb
 u/8VvAuNUSQdNEyYsgw173I+QYxGCtgRrTSlFW0B2mnnlheRktdqrtbe+H0+98750UXoEbR
 1lVD2oERS6EteadvPBY7xLdyMsoPgDJLJMcMf7jqXuml9sfaPx4vVNddA5rfv1TVck9gZ5U
 DoqIhLHzmUWm8rEECS16Q==
UI-OutboundReport: notjunk:1;M01:P0:loTMlzO8HN0=;r3JaavTxwMUfj/S5WPf6y8yap4K
 DOI7NZPNEEh//RJrvbktQw1wA9+YApoiVOiMFpu7IS3mvbmPrIW3nOITznzKa36ZUKTO6SH//
 Pfi4Bf+XTVkmdZZyZ2+yfs6X6wdIn/feM77tNyK1wtyCEuUO3fyKzEWvJLjUm/YFWmmlJMGgP
 osZX2ZETorSIhCV0AK9eQhy0P8p1PI/RVsFa2dnjoztplSOK90UJVW0QGEpgcm2bc7rGxC8Od
 U60Xoh9lHrIR660ZPopVmItpU8Iy3QafykhD2A1VhNXwKPgky8Tt7556O2xvCh8mOz3GyQRnY
 wtsQkya+PtLUBqqzdfhQ4QUtYxRnwsLa44ofx+GrzyU/X2JXlXDi7C2cNRSrKnEKOGyBFz5mO
 oRRRjaL+V7d+eSPvFyLyyZXPQTewAoMU2tnz+8nHHd8qCeu/Dfioyonrb8Z6Wdf04Zl4Yd/kw
 AgMdEYk8vsCiWeMRkRVvoiv826on997cRUbgK+fW+66K6y7hHLcAPF4QT1FTl212kOPIoa9Kw
 JkLgdMyuLEQSwgX0vLv8S2Nc7GVX9lGK16CCuD/Swpz5wuyJ10fy/Lzzt4Tglb29ugpsoUMwR
 7pud+fjZ8gu3zw2N2JJJNCL6nY7gvqIlsMmzI71+WEW+InH4kVqEQSB/iQzDMA1YiYm5WZQjP
 TmiMTmgPyX/RaSqRNxPVsu56qxrkJeuVCdHMbKKpJnOsgpAx8isvoiXwddvYi6EI29Ks6D5Do
 DpEtCudvkNOHR9J5dZAVhqfda2LN57IJibeWxWgKhu2ow38uSBslz/DVm3Y+vf6k8ulCPT2Mb
 +WJCnOSeY8e/eqkrU+zB/9Akqr2JQRvhSzxIIJvmKMwIf59RBle2hMafNwU1DOmbVlzSZcfma
 PqE7e3U653MZZiSvOcqCcFGRxVuKlF2Aw018o/Z8unf2E+cSwcqZTHbg3RDfY8NhFXSPb5tTp
 k4EGVb81m4NMelmNJrGI+qjoG/s=
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
 Documentation/wmi/devices/index.rst           | 22 ++++++++++++++++
 Documentation/wmi/devices/wmi-bmof.rst        | 25 +++++++++++++++++++
 Documentation/wmi/index.rst                   |  1 +
 MAINTAINERS                                   |  7 ++++++
 drivers/platform/x86/Kconfig                  |  4 +--
 6 files changed, 64 insertions(+), 2 deletions(-)
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
index 000000000000..ca1ee9a29be3
=2D-- /dev/null
+++ b/Documentation/wmi/devices/wmi-bmof.rst
@@ -0,0 +1,25 @@
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
+Many machines embed WMI Binary MOF (Managed Object Format) metadata used =
to
+describe the details of their ACPI WMI interfaces. The data can be decode=
d
+with tools like `bmfdec <https://github.com/pali/bmfdec>`_ to obtain a
+human readable WMI interface description, which is useful for developing
+new WMI drivers.
+
+The Binary MOF data can be retrieved from the ``bmof`` sysfs attribute of=
 the
+associated WMI device. Please note that multiple WMI devices containing B=
inary
+MOF data can exist on a given system.
+
+WMI interface
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The Binary MOF WMI device is identified by the WMI GUID ``05901221-D566-1=
1D1-B2F0-00A0C9062910``.
+The Binary MOF can be obtained by doing a WMI data block query. The resul=
t is
+then returned as an ACPI buffer with a variable size.
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
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 22052031c719..3d5dd9e997a6 100644
=2D-- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -43,8 +43,8 @@ config WMI_BMOF
 	default ACPI_WMI
 	help
 	  Say Y here if you want to be able to read a firmware-embedded
-	  WMI Binary MOF data. Using this requires userspace tools and may be
-	  rather tedious.
+	  WMI Binary MOF (Managed Object Format) data. Using this requires
+	  userspace tools and may be rather tedious.

 	  To compile this driver as a module, choose M here: the module will
 	  be called wmi-bmof.
=2D-
2.30.2

