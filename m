Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702036E9FF8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 01:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjDTXc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 19:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbjDTXcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 19:32:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E301270A;
        Thu, 20 Apr 2023 16:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682033554; i=w_armin@gmx.de;
        bh=59VQdVygaIlsJiozK74OZ/XRysCQm7UBEinzk+/3klQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=S+M/C2Y//MXwpM+09KwzlHZFSiDRP6IQaRBRqxTHhhkSj3pJBnemfEfl4lDUcdDWF
         2eRIPzFKOBi8QlK8zgoW58Ody12+jnFtHVfW0ScEKPSXWZPgBBmFAydSlD52hDhFHj
         Jb0dP4Sp3leNL18XTrJ9HI5QV4lAHqUZyu1ebFg304DS+2yzM4vjEY+hN7r3s5/KIC
         vakwamGb5WGTC6NWDHkodEaVmOrFpQqiMQ5w4T1hKI7LjfdwsEhNr1pyJL3QgmAVA2
         wDYxAyA3sMPz9MFS4yexjb67NWHyfqSOBmGuPvGINbrEg7BMFmvcy357JtaII2CtQa
         RTTDcRS6/6kMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M8ygO-1pvi2G1KS6-0066MN; Fri, 21 Apr 2023 01:32:34 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] platform/x86: wmi: Add documentation
Date:   Fri, 21 Apr 2023 01:32:25 +0200
Message-Id: <20230420233226.14561-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230420233226.14561-1-W_Armin@gmx.de>
References: <20230420233226.14561-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X0PWQTH8zdOq1am+cRdzfFag0t8NuS8L7ey5DE7VMKB41b4DXxW
 UDLkrYiqqAv50eIqPGZ8pp19CVAphTRCCKvbXYjChhT8iDuXUHPz1B7EAHyjxZgXPVBPZva
 PqZWcRLbAUvan3paLe8GjwvzsqQ2hEAXuLpiaoLvCcehuTJy33EnLVwQ4lRVIAjpGOUrs7k
 z3o8KWKI7vrtyNQFNrsDA==
UI-OutboundReport: notjunk:1;M01:P0:iqXF51PNwCQ=;w0twXHa/nMCFMGFt/W7R+Q5stKt
 oOSdnifnW06gWa4eWH3LjHP4yk0uY028UOmUrMdQNwsGYnuET70OCeCpW4GEWl4dFs0YOdF6q
 8yfMX2gtQx6Q4gawoxpb8SwtBmoiSy+opullZztpkA5fWo16bshtLAE4PKYSGy05jGmJF0CNq
 ZTgCPauFvYJ/hf5bNlI4cbUntD0/lZEHnTHzkzUJRGXEooWHSpavSZNHzjAdehDIJOi7R/w/a
 1RwALw1HcXjQy9ErPNCMswgHQgOh+NaUh9f1myTxKGSDxDiYXvo/J0J3aW3/KINdEiBKKl79m
 sjRmC7sFkT/DtH+OLrYGthnwVXyWsxRBlEnK3JhPROjcLiusVO17EJr9uEFj6+YSZpvUEf6SU
 XfLB8jhPSjrevSWOmaljWK/mgRVncR0EQavWAgRMZtwGp8YawXbyFpREiYOg4HzkTEzXJutdM
 uCVobhcx1QFUY2cXv549BapxkYY2XBEgf8uWiAe9+/NTIvH8MqHtpSGdUstv1wysOnDBxzZoA
 0seztju8uBHx0Q2yy7+0T36BKmKhesMLB0Frb2GiRxzN9hQst7X7cnBU+kTowwJcA/RchtbLx
 dFpalS49gOU8Rn8aiczW5YceDzKukbBieANvZtMz7USDsXr6nD9s6gSX5OmvR/9BjBJk41P/5
 zyRVCoanU03bznRRArB+hS29dX/ZjBeuexh5gdUr4utxJTnid8k2kKqhH5u/u1fpe0nizr1dz
 443u58pylba4LvX3IOxIF1IEMsgy3bUwSiw+Psvuno8fw0B95pgGDcAnbavpPpcP0ZISsQe5n
 UkNUmSR0/dK08HveIxaeQ9r9Fx0k30lL+v8hjn82d/Wn1K8sSTDcFDJJt4eV1wtkqhoXzMh1O
 BfdDNzAcSO89bT8wBh2HrvkjIP4k5z3w6YSHvS8OIqS4ERYGEmunN2mxuee6yaM9zT9tUwTJg
 /Nhch9EIIQKmhm1q+wrurNfn6q8=
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
where retrieved from the Ubuntu kernel references and the
Windows driver samples available on GitHub. The documentation is
supposed to help driver developers writing WMI drivers, as many
modern machines designed to run Windows provide a ACPI WMI interface.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/driver-api/index.rst   |  1 +
 Documentation/driver-api/wmi.rst     | 19 ++++++
 Documentation/subsystem-apis.rst     |  1 +
 Documentation/wmi/acpi-interface.rst | 86 ++++++++++++++++++++++++++++
 Documentation/wmi/index.rst          | 18 ++++++
 MAINTAINERS                          |  2 +
 include/linux/wmi.h                  |  2 +-
 7 files changed, 128 insertions(+), 1 deletion(-)
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
index 000000000000..06cecbe36afd
=2D-- /dev/null
+++ b/Documentation/driver-api/wmi.rst
@@ -0,0 +1,19 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+WMI Driver API
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The WMI driver core supports a more modern bus-based interface for intera=
cting with WMI devices,
+and an older GUID-based interface. The later interface is considered to b=
e deprecated, so new
+WMI drivers should generally avoid it since it has some issues with multi=
ple WMI devices and
+events sharing the same GUIDs and/or notification IDs. The modern bus-bas=
ed interface instead
+maps each WMI device to a :c:type:`struct wmi_device <wmi_device>`, so it=
 supports WMI devices
+sharing GUIDs and/or notification IDs. Drivers can then register a :c:typ=
e:`struct wmi_driver <wmi_driver>`,
+which will get bound to compatible WMI devices by the driver core.
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
index 000000000000..c0afdb6c5885
=2D-- /dev/null
+++ b/Documentation/wmi/acpi-interface.rst
@@ -0,0 +1,86 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ACPI WMI interface
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The ACPI WMI interface is a proprietary extension of the ACPI specificati=
on made by Microsoft
+to allow hardware vendors to embed WMI (Windows Management Instrumentatio=
n) objects inside
+their ACPI firmware. Typical functions implemented over ACPI WMI are hotk=
ey events on modern
+notebooks and configuration of BIOS options.
+
+PNP0C14 ACPI device
+-------------------
+
+Discovery of WMI objects is handled by defining ACPI devices with a PNP I=
D of ``PNP0C14``.
+These devices will contain a set of ACPI buffers and methods used for map=
ping and execution
+of WMI methods and/or queries. If there exist multiple of such devices, t=
hen each device is
+required to have a unique ACPI UID.
+
+_WDG buffer
+-----------
+
+The ``_WDG`` buffer is used to discover WMI objects and is required to be=
 static. Its internal
+structure consists of data blocks with a size of 20 bytes, containing the=
 following data:
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
+- 0x8: Data block describes a WMI event, use notification ID instead of m=
ethod ID.
+
+Each WMI object GUID can appear multiple times inside a system. The metho=
d/notification ID
+is used to construct the ACPI method names used for interacting with the =
WMI object.
+
+WQxx ACPI methods
+-----------------
+
+If a data block does not contain WMI methods, then its content can be ret=
rieved by this required
+ACPI methods. The last two characters of the ACPI method name are the met=
hod ID of the data block
+to query. Their single parameter is a integer describing the instance whi=
ch should be queried. This
+parameter can be omitted if the data block contains only a single instanc=
e.
+
+WSxx ACPI methods
+-----------------
+
+Similar to the ``WQxx`` ACPI methods, except that it is optional and take=
s an additional buffer
+as its second argument. The instance argument also cannot be omitted.
+
+WMxx ACPI methods
+-----------------
+
+Used for executing WMI methods associated with a data block. The last two=
 characters of the ACPI method
+name are the method ID of the data block containing the WMI methods. Thei=
r first parameter is a integer
+describing the instance which methods should be executed. The second para=
meter is a integer describing
+the WMI method ID to execute, and the third parameter is a buffer contain=
ing the WMI method parameters.
+If the data block is marked as containing a ASCIZ string, then this buffe=
r should contain a ASCIZ string.
+The ACPI method will return the result of the executed WMI method.
+
+WExx ACPI methods
+-----------------
+
+Used for optionally enabling/disabling WMI events, the last two character=
s of the ACPI method are the
+notification ID of the data block describing the WMI event as hexadecimal=
 value. Their first parameter
+is an integer with a value of 0 if the WMI event should be disabled, othe=
r values will enable the WMI event.
+
+WCxx ACPI methods
+-----------------
+Similar to the ``WExx`` ACPI methods, except that it controls data collec=
tion instead of events
+and thus the last two characters of the ACPI method name are the method I=
D of the data block
+to enable/disable.
+
+_WED ACPI method
+----------------
+
+Used to retrieve additional WMI event data, its single parameter is a int=
eger holding the
+notification ID of the event.
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

diff --git a/include/linux/wmi.h b/include/linux/wmi.h
index 88f66b12eef9..87822effdf3c 100644
=2D-- a/include/linux/wmi.h
+++ b/include/linux/wmi.h
@@ -49,7 +49,7 @@ extern int set_required_buffer_size(struct wmi_device *w=
dev, u64 length);
  *
  * This represents WMI drivers which handle WMI devices.
  * @filter_callback is only necessary for drivers which
- * want to set up a WMI IOCTL interface.
+ * want to set up a WMI IOCTL interface
  */
 struct wmi_driver {
 	struct device_driver driver;
=2D-
2.30.2

