Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863525ECEE4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbiI0Up6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiI0Upu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:45:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9EAFF3C2;
        Tue, 27 Sep 2022 13:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664311529;
        bh=G7ZbgOc4H7a8PLktj4EmRtojg+lQwmZ743trNDnHyCU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jocVMcQdqr+KWdt078ehSDb4xkwW1ZyJjQ6/O/CjFfGJc6pagnDE764tIKrHEuaVd
         Ljy2LJkoX9gZdbXqEwuN8seWkNm6k9TzrwIOck5pb99Sj6u60+08dnX3hEcNoO6gse
         +bC8wXlCpNfBT+U1yEUmy7DeI8nAvnte+fBTUAWI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Md6Mt-1pBnGE0rVj-00aCj5; Tue, 27 Sep 2022 22:45:29 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, hmh@hmh.eng.br,
        matan@svgalib.org, corentin.chary@gmail.com, jeremy@system76.com,
        productdev@system76.com, mario.limonciello@amd.com,
        pobrn@protonmail.com, coproscefalo@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] platform/x86: dell: Add new dell-wmi-ddv driver
Date:   Tue, 27 Sep 2022 22:45:21 +0200
Message-Id: <20220927204521.601887-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220927204521.601887-1-W_Armin@gmx.de>
References: <20220927204521.601887-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i1hZZh1MrKRfJ/1k17iJIQ49w9XVfFPp5NiAm+EFQ/k8EEWKzQ3
 6oQNv/aBnN46ieiOXag5exbKQydh255DuuzT66LiF/7eCEEGUGgTVTnxqU4bn4+F7YVqWVp
 KhB+KJiYPIgEodvrOszy/DV+eMkacmYHHEarNt4Smhd0xZvVp1g6oAr0syJl56QE5jJZE0A
 rvdipp/wV6PWs/YqBjpvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WpWGBr6PgcI=:jp7mwLQ3s4T3E6QA5ML9Vc
 TrxV4RA7vPJJROLSIXMP2MgOr6h/Ne8nPqKHRvg3TOTETucM9pySS0iHIRg+dqZIM/6Gs9+17
 c8MryuzIDnyjq/rRemVOzdJIXHJPDV9iMGP/bV9mWdiin4u//Y7lk7EbpHJoD9ihJ2UT4+28A
 scXK1LvY2/MBr5DdP8OPmNwljEfLzCGYFaI1SLXiyGL0G/c7NZZ0yCGtFrghyMAfARfSkAu/w
 nqPzJRpV3SleqE7vap/0lxCPhbU8AXULyYOfOQUAhxJimb5WRT60+8b9VvaqSsgM2wHH5tjJI
 F5/sq9rq6fB5uHlKOLogl4Vb7dDwMhE4DiavHcGNZPodMWVFm3InCZEmP2xlBH+vOT9wJ/bFH
 l70gNkSPlFIB03Aenwh70qxGgfXttO9SbARnScQHN/w2tC+dGI5LFPW+Rx7xirCCJJaYXWSzP
 O6dr0MLFZ8RdS3ppLdiF+rgGEQB7yUbc85wZyV1RLPZA6i4tIqfDnUrBC9WtjmNzcXDh2szAj
 XkhEOcNDjmY2e6bDVVP8JUM3Z+2o1t3QtSvuhmWwz78N4ZKetmdnt/7DJNAjaPlQFwyi9cZ4p
 tWLYhBcndZU7aDVZUEB1gs6g53Q+QNNcNY745UjnuhhmqaOtkooHTgJljko47AVXT3BBK+yYH
 SS8kolsOKZZ2wCbiLQHvOg2zBdEp1iMUHMUiHVqMnAJKQPbY2e0dyJNqCgVaXpO4opkvoae5M
 +ehwSCu0XoVMG2+IB6WDZtbt+kxNobyIrinyhpSnNrBTUlUmsbVKQGC/HNctXAcD2VQGJ47M3
 e6ftBfYpda147+yS5HUO3dAlN6CmzRIahjEdxa0dD1vxltMNH7NYjwjNJtOUOo3+VeOa/k6+O
 HX7/oFg6OboWIS6EwJP616rRY7djL/WtFORZ+OnVhw5zmuDLRTrh8s9l3TGZl8RkS8FG/6Y+9
 8Z4Mt6tWU7EMhE2hyWamRzRS70SmKx62BcGRaJOWlXxdSznvdIdw9sQrRCz//63Yk99dQKlLk
 xIXEZDiYafd1zWVvrdSQZyZdypLhwN+8tGpd/MBS9YogiZ2IWEZkqV4o7XCblFrX++0fi5eQ6
 2/sXJliFtCEltU8Wv7/VkQM2RzzyLbkraAPBsrjMNGxVHvYJFielw7nthrop9wbVSZZ/GHYhV
 BXgpBwynfU0g1d4P+7Zw0PiLEl
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_H2,RCVD_IN_MSPIKE_ZBI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dell-wmi-ddv driver adds support for reading
the current temperature and ePPID of ACPI batteries
on supported Dell machines.

Since the WMI interface used by this driver does not
do any input validation and thus cannot be used for probing,
the driver depends on the ACPI battery extension machanism
to discover batteries.

The driver also supports a debugfs interface for retrieving
buffers containing fan and thermal sensor information.
Since the meaing of the content of those buffers is currently
unknown, the interface is meant for reverse-engineering and
will likely be replaced with an hwmon interface once the
meaning has been understood.

The driver was tested on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 .../ABI/testing/debugfs-dell-wmi-ddv          |  21 +
 .../ABI/testing/sysfs-platform-dell-wmi-ddv   |   7 +
 MAINTAINERS                                   |   7 +
 drivers/platform/x86/dell/Kconfig             |  13 +
 drivers/platform/x86/dell/Makefile            |   1 +
 drivers/platform/x86/dell/dell-wmi-ddv.c      | 361 ++++++++++++++++++
 drivers/platform/x86/wmi.c                    |   1 +
 7 files changed, 411 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-dell-wmi-ddv
 create mode 100644 Documentation/ABI/testing/sysfs-platform-dell-wmi-ddv
 create mode 100644 drivers/platform/x86/dell/dell-wmi-ddv.c

diff --git a/Documentation/ABI/testing/debugfs-dell-wmi-ddv b/Documentatio=
n/ABI/testing/debugfs-dell-wmi-ddv
new file mode 100644
index 000000000000..fbcc5d6f7388
=2D-- /dev/null
+++ b/Documentation/ABI/testing/debugfs-dell-wmi-ddv
@@ -0,0 +1,21 @@
+What:		/sys/kernel/debug/dell-wmi-ddv-<wmi_device_name>/fan_sensor_inform=
ation
+Date:		September 2022
+KernelVersion:	6.1
+Contact:	Armin Wolf <W_Armin@gmx.de>
+Description:
+		This file contains the contents of the fan sensor information buffer,
+		which contains fan sensor entries and a terminating character (0xFF).
+
+		Each fan sensor entry consists of three bytes with an unknown meaning,
+		interested people may use this file for reverse-engineering.
+
+What:		/sys/kernel/debug/dell-wmi-ddv-<wmi_device_name>/thermal_sensor_in=
formation
+Date:		September 2022
+KernelVersion:	6.1
+Contact:	Armin Wolf <W_Armin@gmx.de>
+Description:
+		This file contains the contents of the thermal sensor information buffe=
r,
+		which contains thermal sensor entries and a terminating character (0xFF=
).
+
+		Each thermal sensor entry consists of five bytes with an unknown meanin=
g,
+		interested people may use this file for reverse-engineering.
diff --git a/Documentation/ABI/testing/sysfs-platform-dell-wmi-ddv b/Docum=
entation/ABI/testing/sysfs-platform-dell-wmi-ddv
new file mode 100644
index 000000000000..1d97ad615c66
=2D-- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-dell-wmi-ddv
@@ -0,0 +1,7 @@
+What:		/sys/class/power_supply/<battery_name>/eppid
+Date:		September 2022
+KernelVersion:	6.1
+Contact:	Armin Wolf <W_Armin@gmx.de>
+Description:
+		Reports the Dell ePPID (electronic Dell Piece Part Identification)
+		of the ACPI battery.
diff --git a/MAINTAINERS b/MAINTAINERS
index 6bb894ea4a77..d9fd4c9eebbc 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5821,6 +5821,13 @@ L:	Dell.Client.Kernel@dell.com
 S:	Maintained
 F:	drivers/platform/x86/dell/dell-wmi-descriptor.c

+DELL WMI DDV DRIVER
+M:	Armin Wolf <W_Armin@gmx.de>
+S:	Maintained
+F:	Documentation/ABI/testing/debugfs-dell-wmi-ddv
+F:	Documentation/ABI/testing/sysfs-platform-dell-wmi-ddv
+F:	drivers/platform/x86/dell/dell-wmi-ddv.c
+
 DELL WMI SYSMAN DRIVER
 M:	Divya Bharathi <divya.bharathi@dell.com>
 M:	Prasanth Ksr <prasanth.ksr@dell.com>
diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell=
/Kconfig
index 25421e061c47..d319de8f2132 100644
=2D-- a/drivers/platform/x86/dell/Kconfig
+++ b/drivers/platform/x86/dell/Kconfig
@@ -189,6 +189,19 @@ config DELL_WMI_DESCRIPTOR
 	default n
 	depends on ACPI_WMI

+config DELL_WMI_DDV
+	tristate "Dell WMI sensors Support"
+	default m
+	depends on ACPI_BATTERY
+	depends on ACPI_WMI
+	help
+	  This option adds support for WMI-based sensors like
+	  battery temperature sensors found on some Dell notebooks.
+	  It also supports reading of the battery ePPID.
+
+	  To compile this drivers as a module, choose M here: the module will
+	  be called dell-wmi-ddv.
+
 config DELL_WMI_LED
 	tristate "External LED on Dell Business Netbooks"
 	default m
diff --git a/drivers/platform/x86/dell/Makefile b/drivers/platform/x86/del=
l/Makefile
index ddba1df71e80..1b8942426622 100644
=2D-- a/drivers/platform/x86/dell/Makefile
+++ b/drivers/platform/x86/dell/Makefile
@@ -19,5 +19,6 @@ dell-wmi-objs				:=3D dell-wmi-base.o
 dell-wmi-$(CONFIG_DELL_WMI_PRIVACY)	+=3D dell-wmi-privacy.o
 obj-$(CONFIG_DELL_WMI_AIO)		+=3D dell-wmi-aio.o
 obj-$(CONFIG_DELL_WMI_DESCRIPTOR)	+=3D dell-wmi-descriptor.o
+obj-$(CONFIG_DELL_WMI_DDV)		+=3D dell-wmi-ddv.o
 obj-$(CONFIG_DELL_WMI_LED)		+=3D dell-wmi-led.o
 obj-$(CONFIG_DELL_WMI_SYSMAN)		+=3D dell-wmi-sysman/
diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x=
86/dell/dell-wmi-ddv.c
new file mode 100644
index 000000000000..6ccce90f475d
=2D-- /dev/null
+++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
@@ -0,0 +1,361 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * dell-wmi-ddv.c -- Linux driver for WMI sensor information on Dell note=
books.
+ *
+ * Copyright (C) 2022 Armin Wolf <W_Armin@gmx.de>
+ */
+
+#define pr_format(fmt) KBUILD_MODNAME ": " fmt
+
+#include <acpi/battery.h>
+#include <linux/acpi.h>
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/kstrtox.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/limits.h>
+#include <linux/power_supply.h>
+#include <linux/seq_file.h>
+#include <linux/sysfs.h>
+#include <linux/wmi.h>
+
+#define DRIVER_NAME	"dell-wmi-ddv"
+
+#define DELL_DDV_SUPPORTED_INTERFACE 2
+#define DELL_DDV_GUID	"8A42EA14-4F2A-FD45-6422-0087F7A7E608"
+
+enum dell_ddv_method {
+	DELL_DDV_BATTERY_DESIGN_CAPACITY	=3D 0x01,
+	DELL_DDV_BATTERY_FULL_CHARGE_CAPACITY	=3D 0x02,
+	DELL_DDV_BATTERY_MANUFACTURE_NAME	=3D 0x03,
+	DELL_DDV_BATTERY_MANUFACTURE_DATE	=3D 0x04,
+	DELL_DDV_BATTERY_SERIAL_NUMBER		=3D 0x05,
+	DELL_DDV_BATTERY_CHEMISTRY_VALUE	=3D 0x06,
+	DELL_DDV_BATTERY_TEMPERATURE		=3D 0x07,
+	DELL_DDV_BATTERY_CURRENT		=3D 0x08,
+	DELL_DDV_BATTERY_VOLTAGE		=3D 0x09,
+	DELL_DDV_BATTERY_MANUFACTURER_ACCESS	=3D 0x0A,
+	DELL_DDV_BATTERY_RELATIVE_CHARGE_STATE	=3D 0x0B,
+	DELL_DDV_BATTERY_CYCLE_COUNT		=3D 0x0C,
+	DELL_DDV_BATTERY_EPPID			=3D 0x0D,
+	DELL_DDV_BATTERY_RAW_ANALYTICS_START	=3D 0x0E,
+	DELL_DDV_BATTERY_RAW_ANALYTICS		=3D 0x0F,
+	DELL_DDV_BATTERY_DESIGN_VOLTAGE		=3D 0x10,
+
+	DELL_DDV_INTERFACE_VERSION		=3D 0x12,
+
+	DELL_DDV_FAN_SENSOR_INFORMATION		=3D 0x20,
+	DELL_DDV_THERMAL_SENSOR_INFORMATION	=3D 0x22,
+};
+
+struct dell_wmi_ddv_data {
+	struct acpi_battery_hook hook;
+	struct device_attribute temp_attr, eppid_attr;
+	struct wmi_device *wdev;
+};
+
+static int dell_wmi_ddv_query_type(struct wmi_device *wdev, enum dell_ddv=
_method method, u32 arg,
+				   union acpi_object **result, acpi_object_type type)
+{
+	struct acpi_buffer out =3D { ACPI_ALLOCATE_BUFFER, NULL };
+	const struct acpi_buffer in =3D {
+		.length =3D sizeof(arg),
+		.pointer =3D &arg,
+	};
+	union acpi_object *obj;
+	acpi_status ret;
+
+	ret =3D wmidev_evaluate_method(wdev, 0x0, method, &in, &out);
+	if (ACPI_FAILURE(ret))
+		return -EIO;
+
+	obj =3D out.pointer;
+	if (!obj)
+		return -ENODATA;
+
+	if (obj->type !=3D type) {
+		kfree(obj);
+		return -EIO;
+	}
+
+	*result =3D obj;
+
+	return 0;
+}
+
+static int dell_wmi_ddv_query_integer(struct wmi_device *wdev, enum dell_=
ddv_method method,
+				      u32 arg, u32 *res)
+{
+	union acpi_object *obj;
+	int ret;
+
+	ret =3D dell_wmi_ddv_query_type(wdev, method, arg, &obj, ACPI_TYPE_INTEG=
ER);
+	if (ret < 0)
+		return ret;
+
+	if (obj->integer.value <=3D U32_MAX)
+		*res =3D (u32)obj->integer.value;
+	else
+		ret =3D -ERANGE;
+
+	kfree(obj);
+
+	return ret;
+}
+
+static int dell_wmi_ddv_query_buffer(struct wmi_device *wdev, enum dell_d=
dv_method method,
+				     u32 arg, union acpi_object **result)
+{
+	union acpi_object *obj;
+	u64 buffer_size;
+	int ret;
+
+	ret =3D dell_wmi_ddv_query_type(wdev, method, arg, &obj, ACPI_TYPE_PACKA=
GE);
+	if (ret < 0)
+		return ret;
+
+	if (obj->package.count !=3D 2)
+		goto err_free;
+
+	if (obj->package.elements[0].type !=3D ACPI_TYPE_INTEGER)
+		goto err_free;
+
+	buffer_size =3D obj->package.elements[0].integer.value;
+
+	if (obj->package.elements[1].type !=3D ACPI_TYPE_BUFFER)
+		goto err_free;
+
+	if (buffer_size !=3D obj->package.elements[1].buffer.length) {
+		dev_warn(&wdev->dev,
+			 FW_WARN "ACPI buffer size (%llu) does not match WMI buffer size (%d)\=
n",
+			 buffer_size, obj->package.elements[1].buffer.length);
+
+		goto err_free;
+	}
+
+	*result =3D obj;
+
+	return 0;
+
+err_free:
+	kfree(obj);
+
+	return -EIO;
+}
+
+static int dell_wmi_ddv_query_string(struct wmi_device *wdev, enum dell_d=
dv_method method,
+				     u32 arg, union acpi_object **result)
+{
+	return dell_wmi_ddv_query_type(wdev, method, arg, result, ACPI_TYPE_STRI=
NG);
+}
+
+static int dell_wmi_ddv_battery_index(struct acpi_device *acpi_dev, u32 *=
index)
+{
+	const char *uid_str =3D acpi_device_uid(acpi_dev);
+
+	if (!uid_str)
+		return -ENODEV;
+
+	return kstrtou32(uid_str, 10, index);
+}
+
+static ssize_t temp_show(struct device *dev, struct device_attribute *att=
r, char *buf)
+{
+	struct dell_wmi_ddv_data *data =3D container_of(attr, struct dell_wmi_dd=
v_data, temp_attr);
+	u32 index, value;
+	int ret;
+
+	ret =3D dell_wmi_ddv_battery_index(to_acpi_device(dev->parent), &index);
+	if (ret < 0)
+		return ret;
+
+	ret =3D dell_wmi_ddv_query_integer(data->wdev, DELL_DDV_BATTERY_TEMPERAT=
URE, index, &value);
+	if (ret < 0)
+		return ret;
+
+	return sysfs_emit(buf, "%d\n", DIV_ROUND_CLOSEST(value, 10));
+}
+
+static ssize_t eppid_show(struct device *dev, struct device_attribute *at=
tr, char *buf)
+{
+	struct dell_wmi_ddv_data *data =3D container_of(attr, struct dell_wmi_dd=
v_data, eppid_attr);
+	union acpi_object *obj;
+	u32 index;
+	int ret;
+
+	ret =3D dell_wmi_ddv_battery_index(to_acpi_device(dev->parent), &index);
+	if (ret < 0)
+		return ret;
+
+	ret =3D dell_wmi_ddv_query_string(data->wdev, DELL_DDV_BATTERY_EPPID, in=
dex, &obj);
+	if (ret < 0)
+		return ret;
+
+	ret =3D sysfs_emit(buf, "%s\n", obj->string.pointer);
+
+	kfree(obj);
+
+	return ret;
+}
+
+static int dell_wmi_ddv_add_battery(struct power_supply *battery, struct =
acpi_battery_hook *hook)
+{
+	struct dell_wmi_ddv_data *data =3D container_of(hook, struct dell_wmi_dd=
v_data, hook);
+	u32 index;
+	int ret;
+
+	/* Return 0 instead of error to avoid being unloaded */
+	ret =3D dell_wmi_ddv_battery_index(to_acpi_device(battery->dev.parent), =
&index);
+	if (ret < 0)
+		return 0;
+
+	ret =3D device_create_file(&battery->dev, &data->temp_attr);
+	if (ret < 0)
+		return ret;
+
+	ret =3D device_create_file(&battery->dev, &data->eppid_attr);
+	if (ret < 0) {
+		device_remove_file(&battery->dev, &data->temp_attr);
+
+		return ret;
+	}
+
+	return 0;
+}
+
+static int dell_wmi_ddv_remove_battery(struct power_supply *battery, stru=
ct acpi_battery_hook *hook)
+{
+	struct dell_wmi_ddv_data *data =3D container_of(hook, struct dell_wmi_dd=
v_data, hook);
+
+	device_remove_file(&battery->dev, &data->temp_attr);
+	device_remove_file(&battery->dev, &data->eppid_attr);
+
+	return 0;
+}
+
+static void dell_wmi_ddv_battery_remove(void *data)
+{
+	struct acpi_battery_hook *hook =3D data;
+
+	battery_hook_unregister(hook);
+}
+
+static int dell_wmi_ddv_battery_add(struct dell_wmi_ddv_data *data)
+{
+	data->hook.name =3D "Dell DDV Battery Extension";
+	data->hook.add_battery =3D dell_wmi_ddv_add_battery;
+	data->hook.remove_battery =3D dell_wmi_ddv_remove_battery;
+
+	sysfs_attr_init(&data->temp_attr.attr);
+	data->temp_attr.attr.name =3D "temp";
+	data->temp_attr.attr.mode =3D 0444;
+	data->temp_attr.show =3D temp_show;
+
+	sysfs_attr_init(&data->eppid_attr.attr);
+	data->eppid_attr.attr.name =3D "eppid";
+	data->eppid_attr.attr.mode =3D 0444;
+	data->eppid_attr.show =3D eppid_show;
+
+	battery_hook_register(&data->hook);
+
+	return devm_add_action_or_reset(&data->wdev->dev, dell_wmi_ddv_battery_r=
emove, &data->hook);
+}
+
+static int dell_wmi_ddv_buffer_read(struct seq_file *seq, enum dell_ddv_m=
ethod method)
+{
+	struct device *dev =3D seq->private;
+	struct dell_wmi_ddv_data *data =3D dev_get_drvdata(dev);
+	union acpi_object *obj;
+	union acpi_object buf;
+	int ret;
+
+	ret =3D dell_wmi_ddv_query_buffer(data->wdev, method, 0, &obj);
+	if (ret < 0)
+		return ret;
+
+	buf =3D obj->package.elements[1];
+	ret =3D seq_write(seq, buf.buffer.pointer, buf.buffer.length);
+	kfree(obj);
+
+	return ret;
+}
+
+static int dell_wmi_ddv_fan_read(struct seq_file *seq, void *offset)
+{
+	return dell_wmi_ddv_buffer_read(seq, DELL_DDV_FAN_SENSOR_INFORMATION);
+}
+
+static int dell_wmi_ddv_temp_read(struct seq_file *seq, void *offset)
+{
+	return dell_wmi_ddv_buffer_read(seq, DELL_DDV_THERMAL_SENSOR_INFORMATION=
);
+}
+
+static void dell_wmi_ddv_debugfs_remove(void *data)
+{
+	struct dentry *entry =3D data;
+
+	debugfs_remove(entry);
+}
+
+static void dell_wmi_ddv_debugfs_init(struct wmi_device *wdev)
+{
+	struct dentry *entry;
+	char name[64];
+
+	scnprintf(name, ARRAY_SIZE(name), "%s-%s", DRIVER_NAME, dev_name(&wdev->=
dev));
+	entry =3D debugfs_create_dir(name, NULL);
+
+	debugfs_create_devm_seqfile(&wdev->dev, "fan_sensor_information", entry,
+				    dell_wmi_ddv_fan_read);
+	debugfs_create_devm_seqfile(&wdev->dev, "thermal_sensor_information", en=
try,
+				    dell_wmi_ddv_temp_read);
+
+	devm_add_action_or_reset(&wdev->dev, dell_wmi_ddv_debugfs_remove, entry)=
;
+}
+
+static int dell_wmi_ddv_probe(struct wmi_device *wdev, const void *contex=
t)
+{
+	struct dell_wmi_ddv_data *data;
+	u32 version;
+	int ret;
+
+	ret =3D dell_wmi_ddv_query_integer(wdev, DELL_DDV_INTERFACE_VERSION, 0, =
&version);
+	if (ret < 0)
+		return ret;
+
+	dev_dbg(&wdev->dev, "WMI interface version: %d\n", version);
+	if (version !=3D DELL_DDV_SUPPORTED_INTERFACE)
+		return -ENODEV;
+
+	data =3D devm_kzalloc(&wdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	dev_set_drvdata(&wdev->dev, data);
+	data->wdev =3D wdev;
+
+	dell_wmi_ddv_debugfs_init(wdev);
+
+	return dell_wmi_ddv_battery_add(data);
+}
+
+static const struct wmi_device_id dell_wmi_ddv_id_table[] =3D {
+	{ DELL_DDV_GUID, NULL },
+	{ }
+};
+MODULE_DEVICE_TABLE(wmi, dell_wmi_ddv_id_table);
+
+static struct wmi_driver dell_wmi_ddv_driver =3D {
+	.driver =3D {
+		.name =3D DRIVER_NAME,
+	},
+	.id_table =3D dell_wmi_ddv_id_table,
+	.probe =3D dell_wmi_ddv_probe,
+};
+module_wmi_driver(dell_wmi_ddv_driver);
+
+MODULE_AUTHOR("Armin Wolf <W_Armin@gmx.de>");
+MODULE_DESCRIPTION("Dell WMI sensor driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index aff23309b5d3..f307d8c5c6c3 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -108,6 +108,7 @@ MODULE_DEVICE_TABLE(acpi, wmi_device_ids);
 /* allow duplicate GUIDs as these device drivers use struct wmi_driver */
 static const char * const allow_duplicates[] =3D {
 	"05901221-D566-11D1-B2F0-00A0C9062910",	/* wmi-bmof */
+	"8A42EA14-4F2A-FD45-6422-0087F7A7E608",	/* dell-wmi-ddv */
 	NULL
 };

=2D-
2.30.2

