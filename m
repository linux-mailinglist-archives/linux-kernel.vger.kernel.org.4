Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA346ED7F4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 00:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjDXWaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 18:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjDXWaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:30:15 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8852265BD;
        Mon, 24 Apr 2023 15:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682375397; i=w_armin@gmx.de;
        bh=7xRY30R6PXSQyDMierFQ8JoyNLMxxmzzr3zVRFswPG8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=DtchKjHSsUoNxbg56fdo584LnTsOc1BLexEoPato1YybQiBwPRXB3+WBWuixk2m+E
         U6gUFofBT0lFh7XFtfDMy10yGoH0afW61xJkgWzHza/zaMvkXFIxNf79TeVNQsxoie
         12fF9fInvUrQUZW6wCUma7N3D/RqcURuP0qgSKIfPoYJ5OD/9M40fMkhIQHAND0l9B
         pJ46f6iqWYIenn2JvlGMwG1ejPeioAx0Fd02H0fXwIOhaDfWk4Xv+sNHKcocXTvE/I
         WIkGaUSgkHmZOXF5rYKo7s+RaM5+yqRBJV3nikLM5IN4aB6Gv8X/AVDdQp90yrJFHK
         qhNs0qYQqyybw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M5fIW-1px9F1270E-007DPB; Tue, 25 Apr 2023 00:29:57 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org, rdunlap@infradead.org
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] platform/x86: wmi: Add documentation
Date:   Tue, 25 Apr 2023 00:29:38 +0200
Message-Id: <20230424222939.208137-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230424222939.208137-1-W_Armin@gmx.de>
References: <20230424222939.208137-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G7wfzvf0b2FmNc7WgLDZkgubw083T6DgfoLFo5jse07WvsvhvmR
 cN6ZCIT0oZcV/LCGFVYbmGTp77EnSfiAzQ5n6LsV0+V9QiXMTF1gehbwA3cSJbLHsxSR2dB
 LoDpcqMe0Cu4F/udWr0K5+YubzJbBixK3n4+swc5efRUU7f5Hw2A15jru/ieHj6n50Wc8lY
 HVUgNPZaMFS8j0Sm30Zcw==
UI-OutboundReport: notjunk:1;M01:P0:JRf1laSJV5c=;bviMjp8nreVz+dyAfaLvNsh6Vyo
 dGX40jI7cC9O8bDXvSaFN4no5U+PJySI3dC8YmdGq5U0Eai5+6JdCpSxXGqOx+4wxtj5rd2RO
 WFOBoasrxrQCsl3SYdhoRO8urrFr6giR+WP49dilY/0D3bGMe0jIoequi4euXnWbH/XgW8YJa
 baFs0gblpd6KrZmpMCkFk6qVkNneA4qvco2D6teCNXIFxjH/L+7sTJm4o9sRFAqQyGwbCXkk6
 T1PS3hkFzcdyu1zRQEzj0t0F2Ea3twiGp6blV2fo9c5ym7BrhqbGWfV3mdlj9jnKTLL93lpNb
 1P5ieyep3xlhuurdx1khag2Sg2gTwe1dYk2sAMwjA/JZ0EtLCJnuGgC/pXINRY03Nmnh0t9Hz
 UhpUTGcNu+t3fAVh8NTL6Ny6xTXdDZrDqQM34uF2gLu3ZKnNT1NBVuDlwBJdKMN2G+ZzMBkO8
 Q7OR0lsTIC8uLK0tWP8/SySfQ8oy9Ugp7TY2TDj+6tXBJyK+Mn0sPVmbeOn32TtZ4JVTewTtA
 l5n9uLni15gGYnMy66OrsugCQ3Z/fDngSUCqSndsdcH2IG9qyG/wdoBWG5z3epo8iNaJGiTkV
 /Mz1D9qRF91Y5DkV12MpLtMVuolZEBh0A1jiecqLA0lRQsh+KfB454cZwsaesXNEK+mad+EHG
 Ha6A5CvO795JfnRS+p96PKIp/0NyxK94Sc2CRait7Gjgs6GanCc2H4UxlZZZb6LdjpPrFpcQk
 HGNQqZ4hvUk6E9wrShZjRuyCIJlCAONMHt7VT1wtVMKzqS3Rwm9JG+8f9Fyl/3s3+2zAHqYOz
 u7Z97exC10seMuxrFBIfLvITkCjuxiH5G7me2qdzptRc+nKaHsZ41f4iqWbkOFCakA/YoDwYU
 Cj7QxwWiu1T9rgeT17JzkHjEgAQrbc7JqH9W+6+QETFJQslZPE1gG6q/LTrJNSwyt/NXnFPkP
 5883RnKUvLezI0T+UTTBpjzgUus=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the WMI subsystem. The documentation describes
both the ACPI WMI interface and the driver API for interacting with
the WMI driver core. The information regarding the ACPI interface
was retrieved from the Ubuntu kernel references and the Windows driver
samples available on GitHub. The documentation is supposed to help
driver developers writing WMI drivers, as many modern machines designed
to run Windows provide an ACPI WMI interface.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/driver-api/index.rst   |  1 +
 Documentation/driver-api/wmi.rst     | 21 ++++++
 Documentation/subsystem-apis.rst     |  1 +
 Documentation/wmi/acpi-interface.rst | 96 ++++++++++++++++++++++++++++
 Documentation/wmi/index.rst          | 18 ++++++
 MAINTAINERS                          |  2 +
 6 files changed, 139 insertions(+)
 create mode 100644 Documentation/driver-api/wmi.rst
 create mode 100644 Documentation/wmi/acpi-interface.rst
 create mode 100644 Documentation/wmi/index.rst

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api=
/index.rst
index ff9aa1afdc62..1e16a40da3ba 100644
=2D-- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -113,6 +113,7 @@ available subsections can be seen below.
    xillybus
    zorro
    hte/index
+   wmi

 .. only::  subproject and html

diff --git a/Documentation/driver-api/wmi.rst b/Documentation/driver-api/w=
mi.rst
new file mode 100644
index 000000000000..6ca58c8249e5
=2D-- /dev/null
+++ b/Documentation/driver-api/wmi.rst
@@ -0,0 +1,21 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+WMI Driver API
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The WMI driver core supports a more modern bus-based interface for intera=
cting
+with WMI devices, and an older GUID-based interface. The latter interface=
 is
+considered to be deprecated, so new WMI drivers should generally avoid it=
 since
+it has some issues with multiple WMI devices and events sharing the same =
GUIDs
+and/or notification IDs. The modern bus-based interface instead maps each
+WMI device to a :c:type:`struct wmi_device <wmi_device>`, so it supports
+WMI devices sharing GUIDs and/or notification IDs. Drivers can then regis=
ter
+a :c:type:`struct wmi_driver <wmi_driver>`, which will be bound to compat=
ible
+WMI devices by the driver core.
+
+.. kernel-doc:: include/linux/wmi.h
+   :internal:
+
+.. kernel-doc:: drivers/platform/x86/wmi.c
+   :export:
diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-ap=
is.rst
index b51f38527e14..69f5e4d53bad 100644
=2D-- a/Documentation/subsystem-apis.rst
+++ b/Documentation/subsystem-apis.rst
@@ -57,3 +57,4 @@ needed).
    scheduler/index
    mhi/index
    peci/index
+   wmi/index
diff --git a/Documentation/wmi/acpi-interface.rst b/Documentation/wmi/acpi=
-interface.rst
new file mode 100644
index 000000000000..d31af0ed9c08
=2D-- /dev/null
+++ b/Documentation/wmi/acpi-interface.rst
@@ -0,0 +1,96 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ACPI WMI interface
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The ACPI WMI interface is a proprietary extension of the ACPI specificati=
on made
+by Microsoft to allow hardware vendors to embed WMI (Windows Management I=
nstrumentation)
+objects inside their ACPI firmware. Typical functions implemented over AC=
PI WMI
+are hotkey events on modern notebooks and configuration of BIOS options.
+
+PNP0C14 ACPI device
+-------------------
+
+Discovery of WMI objects is handled by defining ACPI devices with a PNP I=
D
+of ``PNP0C14``. These devices will contain a set of ACPI buffers and meth=
ods
+used for mapping and execution of WMI methods and/or queries. If there ex=
ist
+multiple of such devices, then each device is required to have a
+unique ACPI UID.
+
+_WDG buffer
+-----------
+
+The ``_WDG`` buffer is used to discover WMI objects and is required to be
+static. Its internal structure consists of data blocks with a size of 20 =
bytes,
+containing the following data:
+
+=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+Offset  Size (in bytes) Content
+=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+0x00    16              128 bit Variant 2 object GUID.
+0x10    2               2 character method ID or single byte notification=
 ID.
+0x12    1               Object instance count.
+0x13    1               Object flags.
+=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+
+The WMI object flags control whether the method or notification ID is use=
d:
+
+- 0x1: Data block usage is expensive and must be explicitly enabled/disab=
led.
+- 0x2: Data block contains WMI methods.
+- 0x4: Data block contains ASCIZ string.
+- 0x8: Data block describes a WMI event, use notification ID instead
+  of method ID.
+
+Each WMI object GUID can appear multiple times inside a system.
+The method/notification ID is used to construct the ACPI method names use=
d for
+interacting with the WMI object.
+
+WQxx ACPI methods
+-----------------
+
+If a data block does not contain WMI methods, then its content can be ret=
rieved
+by this required ACPI method. The last two characters of the ACPI method =
name
+are the method ID of the data block to query. Their single parameter is a=
n
+integer describing the instance which should be queried. This parameter c=
an be
+omitted if the data block contains only a single instance.
+
+WSxx ACPI methods
+-----------------
+
+Similar to the ``WQxx`` ACPI methods, except that it is optional and take=
s an
+additional buffer as its second argument. The instance argument also cann=
ot
+be omitted.
+
+WMxx ACPI methods
+-----------------
+
+Used for executing WMI methods associated with a data block. The last two
+characters of the ACPI method name are the method ID of the data block
+containing the WMI methods. Their first parameter is a integer describing=
 the
+instance which methods should be executed. The second parameter is an int=
eger
+describing the WMI method ID to execute, and the third parameter is a buf=
fer
+containing the WMI method parameters. If the data block is marked as cont=
aining
+an ASCIZ string, then this buffer should contain an ASCIZ string. The ACP=
I
+method will return the result of the executed WMI method.
+
+WExx ACPI methods
+-----------------
+
+Used for optionally enabling/disabling WMI events, the last two character=
s of
+the ACPI method are the notification ID of the data block describing the =
WMI
+event as hexadecimal value. Their first parameter is an integer with a va=
lue
+of 0 if the WMI event should be disabled, other values will enable
+the WMI event.
+
+WCxx ACPI methods
+-----------------
+Similar to the ``WExx`` ACPI methods, except that it controls data collec=
tion
+instead of events and thus the last two characters of the ACPI method nam=
e are
+the method ID of the data block to enable/disable.
+
+_WED ACPI method
+----------------
+
+Used to retrieve additional WMI event data, its single parameter is a int=
eger
+holding the notification ID of the event.
diff --git a/Documentation/wmi/index.rst b/Documentation/wmi/index.rst
new file mode 100644
index 000000000000..b29933a86380
=2D-- /dev/null
+++ b/Documentation/wmi/index.rst
@@ -0,0 +1,18 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+WMI Subsystem
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+.. toctree::
+   :maxdepth: 1
+
+   acpi-interface
+
+.. only::  subproject and html
+
+
+   Indices
+   =3D=3D=3D=3D=3D=3D=3D
+
+   * :ref:`genindex`
diff --git a/MAINTAINERS b/MAINTAINERS
index 0c9011f5fc17..979d37176429 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -449,6 +449,8 @@ F:	include/linux/acpi_viot.h
 ACPI WMI DRIVER
 L:	platform-driver-x86@vger.kernel.org
 S:	Orphan
+F:	Documentation/driver-api/wmi.rst
+F:	Documentation/wmi/
 F:	drivers/platform/x86/wmi.c
 F:	include/uapi/linux/wmi.h

=2D-
2.30.2

