Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593B1664E93
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 23:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjAJWPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 17:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjAJWPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 17:15:08 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0C83D1D5;
        Tue, 10 Jan 2023 14:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1673388897; bh=++pRjfOkk84CS8qa9gW7zgi0gUf2nFlLOMtBIEba+vs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=KYug+P0swJ1ggPwWaJ6od4lV8yEjhiL9HnPYf5PGBHSosWoOXrQGfhymAeazHN+Y5
         X8q14m1VEMNxmyGYlHYxSbWrmc9mQzw/J1FCxJtaYoRLYd818d/gDyvagQpOdC1QMQ
         3/vtEDStAbByFmKpWLXGeY+tudMcLy04lZDRUfDWm5tVL4UAuDkgzohE7MIv786DIA
         5RpHHbxJt2fkMTisgPMkCE6ysMV8zDmP8fsqQgNgM72D2DVROY13dbUt+XMtS4Q6Gh
         hjsEJIJFZPlIq/3eaEezo3JQaXyiELFf8f+QH8TuB1IJFYtMMdPT66aZxDxPFbbhA0
         tzIAtIrqwGD2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M42nY-1pFMtV1ch6-0008Is; Tue, 10 Jan 2023 23:14:57 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] platform/x86: dell-ddv: Add hwmon support
Date:   Tue, 10 Jan 2023 23:14:43 +0100
Message-Id: <20230110221443.8184-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z4NjSahkYN7NkPOIHouaRpUKD83DtY1ualXSFJ+pH8k1JkuigWO
 A5Ftk8D0eXPNX6LYj0QkvuaFZmYm/a1+EjIOVZYe90c80wRgySV8Aa+CWA3AKizfV5/ykcz
 BUhie8AbHaBMymxrxzFLVIg7oHQ4LoRGejh84Yz2jstavxTuITk+u+jAWGzv52zfrULBD7Y
 s+WJ3Kd4HRXZgHbIb8hAA==
UI-OutboundReport: notjunk:1;M01:P0:jVrWOSmLoUc=;xnux7kiUPjhlfi+wrJg2bHxiXZx
 pwkwBKit4vhjEww7EVMnlsbBKZDkzGyunp1b1hC/NK+LjmlH9qCtgEAgCrpfyvy1v7qccOCIs
 HALaqIvyOtP2XwZw0h9bjedCe2WR+SWlCTvPxSlSPGVe9gmdtH0ScgStmXXogPFi83n3lbJrR
 j7N5MeyJIRDKIaIdzkZ1LB68JpK6vocANL5XNJjC7dp2UbByHWEJr07C4RK4DzIhcEzY6L0Ho
 Ct5tJqJ8TO8uaqALgg0bmPJ7Oo87S81qDbl/b1nSlmQwfuJ1wBCDgZTqtLk9cQx9dgibF+P8h
 eEb++Tcam0zME2Dx0lftDj9fpk9vKy4KCihKthu5CjZ64nfZ1oQl80sf681hzE3ORHOJIF0BH
 /fDoImR6nw7PopDeluhHrYscnXRzOMM5+LVWk3vmHOc0hNY9QtjEQ15Qrf4qhkbJeoId2SteN
 Yl16/a3ii35AmURNUdY6OKh4NiGiXukhos3HLu8F1g8jJjCaAO603QLwYI44P0L+uaACgSieM
 nDfOQ0rYZXPazApDyTnrxVXguJ6hbT7E/rfq9SDB4X/00Pt6pHfTVBfdPtJ5A0JfCGPUW52Pr
 kH0BGeMvxWlEqWWoIcD7EWnjDvSfFTi6l+6KTf9gwob8B0rqNyGg5a+/cQiZJK1fWB+iwVjDS
 vuYd9aUaB/gmXK7hVkH40ocJVfeMwX5VDBoSjSS0MdghL8q/XpgZ9zxW/PUV5KpQ5rMFppaIQ
 VO2pVvTk4hWBYVG85sQdRufnaF81Jd70cbB9J3ecOM9m2NvYVHxi2ydNrugZ/6bkQ2d8leWep
 hI5V4BW4LSvvbowu39gFf8JBGzJWbg4ukY2zIDwf1AxE+HdjNzOeLclUH5W+3RBjVVFRu/WSy
 /KFb81ORRdpLhsi/L0d3KvzCNWwkCVg8CDq8mU4zEuPntLnRu2DYlXmqJvRTgpV3KMjAVu2vM
 klfI0B5aofQJldjb3nPPSYlMsjg=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to a bugreport on bugzilla triggered by the
dell-smm-hwmon driver, the contents of the sensor buffers
could be partially decoded.
Add an hwmon interface for exposing the fan and thermal
sensor values. The debugfs interface remains in place to
aid in reverse-engineering the thermal buffer.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
This patch is in the process of being tested by multiple people
on multiple Dell notebooks, and AFAIK the drivers seems to do its
job well.
I want to ask for comments regarding how the hwmon support code
interfaces with the main driver. The hwmon and battery hook support
code are expected to grow significantly once more people use this
driver and are reporting bugs and reverse-engineering findings.
Since both the hwmon and battery support code is quiet independent
from each other, i was thinking about modularizing the driver by either:
- spliting the driver into multiple source files which are being linked
  together
- spliting the driver into separate subdevice drivers using the MFD or
  auxiliary bus infrastructure

When is it justified to modularize a driver?
And if yes which option should be used to facilitate this?

Armin Wolf
=2D--
 drivers/platform/x86/dell/Kconfig        |   1 +
 drivers/platform/x86/dell/dell-wmi-ddv.c | 374 ++++++++++++++++++++++-
 2 files changed, 374 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell=
/Kconfig
index d319de8f2132..21a74b63d9b1 100644
=2D-- a/drivers/platform/x86/dell/Kconfig
+++ b/drivers/platform/x86/dell/Kconfig
@@ -194,6 +194,7 @@ config DELL_WMI_DDV
 	default m
 	depends on ACPI_BATTERY
 	depends on ACPI_WMI
+	depends on HWMON
 	help
 	  This option adds support for WMI-based sensors like
 	  battery temperature sensors found on some Dell notebooks.
diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x=
86/dell/dell-wmi-ddv.c
index f99c4cb686fd..b79ff8621aea 100644
=2D-- a/drivers/platform/x86/dell/dell-wmi-ddv.c
+++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
@@ -13,6 +13,7 @@
 #include <linux/dev_printk.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/hwmon.h>
 #include <linux/kstrtox.h>
 #include <linux/math.h>
 #include <linux/module.h>
@@ -21,10 +22,13 @@
 #include <linux/printk.h>
 #include <linux/seq_file.h>
 #include <linux/sysfs.h>
+#include <linux/types.h>
 #include <linux/wmi.h>

 #include <acpi/battery.h>

+#include <asm/unaligned.h>
+
 #define DRIVER_NAME	"dell-wmi-ddv"

 #define DELL_DDV_SUPPORTED_VERSION_MIN	2
@@ -59,13 +63,45 @@ enum dell_ddv_method {
 	DELL_DDV_THERMAL_SENSOR_INFORMATION	=3D 0x22,
 };

+struct fan_sensor_entry {
+	u8 type;
+	__le16 rpm;
+} __packed;
+
+struct thermal_sensor_entry {
+	u8 type;
+	s8 now;
+	s8 min;
+	s8 max;
+	u8 unknown;
+} __packed;
+
 struct dell_wmi_ddv_data {
 	struct acpi_battery_hook hook;
 	struct device_attribute temp_attr;
 	struct device_attribute eppid_attr;
+	struct hwmon_chip_info chip_info;
 	struct wmi_device *wdev;
 };

+static const char * const fan_labels[] =3D {
+	"Processor Fan",
+	"Motherboard Fan",
+	"Video Fan",
+	"Power Supply Fan",
+	"Chipset Fan",
+	"Other Fan",
+};
+
+static const char * const fan_dock_labels[] =3D {
+	"Docking Processor Fan",
+	"Docking Motherboard Fan",
+	"Docking Video Fan",
+	"Docking Power Supply Fan",
+	"Docking Chipset Fan",
+	"Docking Other Fan",
+};
+
 static int dell_wmi_ddv_query_type(struct wmi_device *wdev, enum dell_ddv=
_method method, u32 arg,
 				   union acpi_object **result, acpi_object_type type)
 {
@@ -167,6 +203,334 @@ static int dell_wmi_ddv_query_string(struct wmi_devi=
ce *wdev, enum dell_ddv_meth
 	return dell_wmi_ddv_query_type(wdev, method, arg, result, ACPI_TYPE_STRI=
NG);
 }

+static int dell_wmi_ddv_query_sensors(struct wmi_device *wdev, enum dell_=
ddv_method method,
+				      size_t entry_size, union acpi_object **result)
+{
+	union acpi_object *obj;
+	u64 buffer_size;
+	u8 *buffer;
+	int ret;
+
+	ret =3D dell_wmi_ddv_query_buffer(wdev, method, 0, &obj);
+	if (ret < 0)
+		return ret;
+
+	buffer_size =3D obj->package.elements[0].integer.value;
+	buffer =3D obj->package.elements[1].buffer.pointer;
+	if (buffer_size % entry_size !=3D 1 || buffer[buffer_size - 1] !=3D 0xff=
) {
+		kfree(obj);
+
+		return -ENOMSG;
+	}
+
+	*result =3D obj;
+
+	return 0;
+}
+
+static u64 dell_wmi_ddv_sensor_count(union acpi_object *obj, size_t entry=
_size)
+{
+	return (obj->package.elements[0].integer.value - 1) / entry_size;
+}
+
+static void *dell_wmi_ddv_get_sensor_entry(union acpi_object *obj, int in=
dex, size_t entry_size)
+{
+	if (index >=3D dell_wmi_ddv_sensor_count(obj, entry_size))
+		return ERR_PTR(-EINVAL);
+
+	return &obj->package.elements[1].buffer.pointer[index * entry_size];
+}
+
+static umode_t dell_wmi_ddv_is_visible(const void *drvdata, enum hwmon_se=
nsor_types type, u32 attr,
+				       int channel)
+{
+	return 0444;
+}
+
+static int dell_wmi_ddv_read(struct device *dev, enum hwmon_sensor_types =
type, u32 attr,
+			     int channel, long *val)
+{
+	struct dell_wmi_ddv_data *data =3D dev_get_drvdata(dev);
+	struct thermal_sensor_entry *thermal_entry;
+	struct fan_sensor_entry *fan_entry;
+	union acpi_object *obj;
+	int ret;
+
+	switch (type) {
+	case hwmon_temp:
+		ret =3D dell_wmi_ddv_query_sensors(data->wdev, DELL_DDV_THERMAL_SENSOR_=
INFORMATION,
+						 sizeof(*thermal_entry), &obj);
+		if (ret < 0)
+			return ret;
+
+		thermal_entry =3D dell_wmi_ddv_get_sensor_entry(obj, channel, sizeof(*t=
hermal_entry));
+		if (!IS_ERR(thermal_entry)) {
+			switch (attr) {
+			case hwmon_temp_input:
+				*val =3D thermal_entry->now * 1000;
+
+				break;
+			case hwmon_temp_min:
+				*val =3D thermal_entry->min * 1000;
+
+				break;
+			case hwmon_temp_max:
+				*val =3D thermal_entry->max * 1000;
+
+				break;
+			default:
+				ret =3D -EOPNOTSUPP;
+
+				break;
+			}
+		} else {
+			ret =3D PTR_ERR(thermal_entry);
+		}
+
+		kfree(obj);
+
+		return ret;
+	case hwmon_fan:
+		ret =3D dell_wmi_ddv_query_sensors(data->wdev, DELL_DDV_FAN_SENSOR_INFO=
RMATION,
+						 sizeof(*fan_entry), &obj);
+		if (ret < 0)
+			return ret;
+
+		fan_entry =3D dell_wmi_ddv_get_sensor_entry(obj, channel, sizeof(*fan_e=
ntry));
+		if (!IS_ERR(fan_entry)) {
+			switch (attr) {
+			case hwmon_fan_input:
+				*val =3D get_unaligned_le16(&fan_entry->rpm);
+
+				break;
+			default:
+				ret =3D -EOPNOTSUPP;
+
+				break;
+			}
+		} else {
+			ret =3D PTR_ERR(fan_entry);
+		}
+
+		kfree(obj);
+
+		return ret;
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static const char *dell_wmi_ddv_fan_label(u8 type)
+{
+	if (type & BIT(4))
+		return fan_dock_labels[clamp_val(type & 0x0f, 0, ARRAY_SIZE(fan_dock_la=
bels) - 1)];
+
+	return fan_labels[clamp_val(type & 0x0f, 0, ARRAY_SIZE(fan_labels) - 1)]=
;
+}
+
+static int dell_wmi_ddv_read_string(struct device *dev, enum hwmon_sensor=
_types type, u32 attr,
+				    int channel, const char **str)
+{
+	struct dell_wmi_ddv_data *data =3D dev_get_drvdata(dev);
+	struct thermal_sensor_entry *thermal_entry;
+	struct fan_sensor_entry *fan_entry;
+	union acpi_object *obj;
+	int ret;
+
+	switch (type) {
+	case hwmon_fan:
+		ret =3D dell_wmi_ddv_query_sensors(data->wdev, DELL_DDV_FAN_SENSOR_INFO=
RMATION,
+						 sizeof(*fan_entry), &obj);
+		if (ret < 0)
+			return ret;
+
+		fan_entry =3D dell_wmi_ddv_get_sensor_entry(obj, channel, sizeof(*fan_e=
ntry));
+		if (!IS_ERR(fan_entry)) {
+			switch (attr) {
+			case hwmon_fan_label:
+				*str =3D dell_wmi_ddv_fan_label(fan_entry->type);
+
+				break;
+			default:
+				ret =3D -EOPNOTSUPP;
+
+				break;
+			}
+		} else {
+			ret =3D PTR_ERR(fan_entry);
+		}
+
+		kfree(obj);
+
+		return ret;
+	case hwmon_temp:
+		ret =3D dell_wmi_ddv_query_sensors(data->wdev, DELL_DDV_THERMAL_SENSOR_=
INFORMATION,
+						 sizeof(*thermal_entry), &obj);
+		if (ret < 0)
+			return ret;
+
+		thermal_entry =3D dell_wmi_ddv_get_sensor_entry(obj, channel, sizeof(*t=
hermal_entry));
+		if (!IS_ERR(thermal_entry)) {
+			switch (attr) {
+			case hwmon_temp_label:
+				switch (thermal_entry->type) {
+				case 0x00:
+					*str =3D "CPU";
+
+					break;
+				case 0x11:
+					*str =3D "Video";
+
+					break;
+				case 0x22:
+					*str =3D "Memory";
+
+					break;
+				case 0x33:
+					*str =3D "Other";
+
+					break;
+				case 0x44:
+					*str =3D "Ambient"; // sometimes called SKIN
+
+					break;
+				case 0x73:
+					*str =3D "NB";
+
+					break;
+				default:
+					ret =3D -ENXIO;
+				}
+
+				break;
+			default:
+				ret =3D -EOPNOTSUPP;
+
+				break;
+			}
+		} else {
+			ret =3D PTR_ERR(thermal_entry);
+		}
+
+		kfree(obj);
+
+		return ret;
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static const struct hwmon_ops dell_wmi_ddv_ops =3D {
+	.is_visible =3D dell_wmi_ddv_is_visible,
+	.read =3D dell_wmi_ddv_read,
+	.read_string =3D dell_wmi_ddv_read_string,
+};
+
+static struct hwmon_channel_info *dell_wmi_ddv_channel_init(struct wmi_de=
vice *wdev,
+							    enum dell_ddv_method method,
+							    size_t entry_size,
+							    enum hwmon_sensor_types type,
+							    u32 config)
+{
+	struct hwmon_channel_info *info;
+	union acpi_object *obj;
+	u32 *channel_config;
+	int i, ret;
+	u64 count;
+
+	ret =3D dell_wmi_ddv_query_sensors(wdev, method, entry_size, &obj);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	count =3D dell_wmi_ddv_sensor_count(obj, entry_size);
+	kfree(obj);
+	if (!count)
+		return ERR_PTR(-ENODEV);
+
+	info =3D devm_kzalloc(&wdev->dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	info->type =3D type;
+	channel_config =3D devm_kcalloc(&wdev->dev, count + 1, sizeof(*channel_c=
onfig), GFP_KERNEL);
+	if (!channel_config) {
+		devm_kfree(&wdev->dev, info);
+
+		return ERR_PTR(-ENOMEM);
+	}
+
+	for (i =3D 0; i < count; i++)
+		channel_config[i] =3D config;
+
+	info->config =3D channel_config;
+
+	return info;
+}
+
+static int dell_wmi_ddv_hwmon_add(struct dell_wmi_ddv_data *data)
+{
+	const struct hwmon_channel_info **info;
+	struct wmi_device *wdev =3D data->wdev;
+	struct device *hdev;
+	int index =3D 0;
+	int ret;
+
+	if (!devres_open_group(&wdev->dev, dell_wmi_ddv_hwmon_add, GFP_KERNEL))
+		return -ENOMEM;
+
+	info =3D devm_kcalloc(&wdev->dev, 3, sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		ret =3D -ENOMEM;
+
+		goto err_release;
+	}
+
+	info[index] =3D dell_wmi_ddv_channel_init(wdev, DELL_DDV_FAN_SENSOR_INFO=
RMATION,
+						sizeof(struct fan_sensor_entry), hwmon_fan,
+						(HWMON_F_INPUT | HWMON_F_LABEL));
+	if (!IS_ERR(info[index]))
+		index++;
+
+	info[index] =3D dell_wmi_ddv_channel_init(wdev, DELL_DDV_THERMAL_SENSOR_=
INFORMATION,
+						sizeof(struct thermal_sensor_entry), hwmon_temp,
+						(HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX |
+						HWMON_T_LABEL));
+	if (!IS_ERR(info[index]))
+		index++;
+
+	if (!index) {
+		ret =3D -ENODEV;
+
+		goto err_release;
+	}
+
+	info[index] =3D NULL;
+
+	data->chip_info.ops =3D &dell_wmi_ddv_ops;
+	data->chip_info.info =3D info;
+
+	hdev =3D devm_hwmon_device_register_with_info(&wdev->dev, "dell_ddv", da=
ta, &data->chip_info,
+						    NULL);
+	if (IS_ERR(hdev)) {
+		ret =3D PTR_ERR(hdev);
+
+		goto err_release;
+	}
+
+	devres_close_group(&wdev->dev, dell_wmi_ddv_hwmon_add);
+
+	return 0;
+
+err_release:
+	devres_release_group(&wdev->dev, dell_wmi_ddv_hwmon_add);
+
+	return ret;
+}
+
 static int dell_wmi_ddv_battery_index(struct acpi_device *acpi_dev, u32 *=
index)
 {
 	const char *uid_str;
@@ -361,7 +725,15 @@ static int dell_wmi_ddv_probe(struct wmi_device *wdev=
, const void *context)

 	dell_wmi_ddv_debugfs_init(wdev);

-	return dell_wmi_ddv_battery_add(data);
+	ret =3D dell_wmi_ddv_hwmon_add(data);
+	if (ret < 0)
+		dev_dbg(&wdev->dev, "Unable to register hwmon interface: %d\n", ret);
+
+	ret =3D dell_wmi_ddv_battery_add(data);
+	if (ret < 0)
+		dev_dbg(&wdev->dev, "Unable to register acpi battery hook: %d\n", ret);
+
+	return 0;
 }

 static const struct wmi_device_id dell_wmi_ddv_id_table[] =3D {
=2D-
2.30.2

