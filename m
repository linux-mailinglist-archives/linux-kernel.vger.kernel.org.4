Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341BC64E2C7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 22:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiLOVJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 16:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLOVJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:09:47 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF10554C0;
        Thu, 15 Dec 2022 13:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1671138568; bh=HRre9GB0UYc7LgQsgp8Vk2HqhfewbBbAsqZMTdnz/SI=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=IPbkpOZuMRBAJkuF2idB3cKb6qIOeLh+rAcXNQCW8qaVh1Urzi+jMKN1ZvHRXQGxN
         So4APKkM4mo/G3gnkuTQQDNa5AEbnEYVigrPz7KH9nlZymW/ivjVIjBfjuySm5a76D
         9djAjDGsqmB1QJI3syuhPE6PFXIhnUUq5ACO9PgfBNLdf1ds3gg2xFxlgLlp4oohRC
         8EaK4bPf5cJohlUIif7rF+TBobzfv8MYmPXAfzUvlBiqJ42MeM/oAGFcAJ0z7Ss0vb
         KI+A4KSRHuQ9mR99gCSJJhMhdtnTGzJBTccaKiToMp++BbyBHd20sqvF56RqyajAF2
         CGHNFrThFk2wQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from 9300 ([93.221.18.29]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhD6g-1oRf3K2tBS-00eOzt; Thu, 15
 Dec 2022 22:09:28 +0100
Date:   Thu, 15 Dec 2022 22:09:28 +0100 (CET)
From:   Andreas Bergmeier <abergmeier@gmx.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hid: Support for Litra Glow
Message-ID: <9fca69c7-cc24-63d0-98f6-80c28fc69a5@9300>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UZk/Gs16qIKCHZ5T50IHvP267ZL2PT4WA63nlSA+FJmLVs5HKBP
 +p43xa0DqPiOZMh5MBYrFp/A6Vt5GwrBhjnz2rhoLg6tUUrvj8QP06kNuIBQ0vWq/rW2Qny
 Ni/PUjZAAcZWdXaIhIPvQTj96Pfu66QdDmAxjXg9TBu2WjeQTMJ7m4JYv8k3ty8xo9e0Jzt
 4J7KFDkBByC2mPBuEndsA==
UI-OutboundReport: notjunk:1;M01:P0:Uks8Dxgz8rQ=;x1Y1qowRnj8P7hTi1db9udbipFr
 0N6VD91Rgrv1CdIbvBb1/bdxVRGa9BJm+L7CAt0stxqjpie2pbLkK+3FUgBeJX+xzMLZc5j1O
 TFHnZLhqkOIl8jhxuP3wdwkUec1EnPFVt2M/Pdb+vYV+h4KT2Is3dYqIwv+iuRBpFgCZp3sbQ
 P7c4DQBQmXSf//xTE0DEuFG2YEyYZOrc7xiecLUCKXJhhFcK0HFAP8b/vS1KBr32Mi6zg7Tr2
 Tt5YfHWrbThvyNO5o37KBP7JMYsDz72H5UliImL3YdXnVs8CFYFc0zHaCESFPobyIGx80+1HP
 k1/UgKwD4VUnqORond5mygzlqCDfyyzH25eIq7VlYHeqqWqQA0YwuYqlHWJtTZXNEXENOhXdO
 S4/gbBiX4B9eynN30uGERFpeVZIO1tv8NGSiV3/7O6BLdqW63V2x05YsfAYGmaUpyTUoXR/fP
 4uoHVrvlBDidVN9VbUfG65wKTxuzTcGiFPh1x6QTK3LAEej4EDliVcuGgfYqRyuMk/lOUbA/f
 7iP7xwWFnnXgs3miTe2k1eqFN9hmKC6xFepGoR1TCvPLa9V3Uk/spiy8qCUYFbTl77EGTf5M6
 qvVlxqiDpsxYacTXsMys3IpurfJja/yqedPwT8AR+W342paYO90L/gXqmMg/qN0o94qc5m2EM
 umrmHf6VRUTWFRA12Yj28HBXKVMhK49Myggl6J/jRs0ugCpj4dUwXqkQmW8HI3bQWoNklRktQ
 RTNeZ0SXqHhoJ8jvJ26KXRBhFekfs2mXcLBhrp/vImUmW0UTC1klL+8YwSngj+smpKQmV72hZ
 67wyFyoyLql5tpQ5LW0uXT2z7+K4T9SscuGH5tJRiNX6dGdvzrxxA0jsiMDOHeFRNW8yd0ncH
 H95jma6TQshjy1TfjJ4pZB5eK/D/4vPWONuFQ7W/da8oqLTER+Kutu0IuJo/ymShza0MCQnxR
 wx8qfg==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tries to implement as general support for Illumination Light as
possible. Note that it is singular, which means by Logitech spec we are
fine off with just handling one capability/device.

Implementation currently only exposes Brightness and On/Off controls.
Does currently not expose Color Temperature because LEDs does not
support it.

Introduces HIDPP_QUIRK_CLASS_SIMPLE_START to prevent reconnect on
startup. Could not get Glow to work with that.

Signed-off-by: Andreas Bergmeier <abergmeier@gmx.net>
=2D--
 drivers/hid/hid-ids.h            |   1 +
 drivers/hid/hid-logitech-hidpp.c | 435 ++++++++++++++++++++++++++++++-
 drivers/hid/hid-quirks.c         |   1 +
 3 files changed, 432 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 8f58c3c1bec3..728dede997d3 100644
=2D-- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -857,6 +857,7 @@
 #define USB_DEVICE_ID_MX5500_RECEIVER_MOUSE_DEV		0xc71c
 #define USB_DEVICE_ID_DINOVO_MINI_RECEIVER_KBD_DEV	0xc71e
 #define USB_DEVICE_ID_DINOVO_MINI_RECEIVER_MOUSE_DEV	0xc71f
+#define USB_DEVICE_ID_LOGITECH_LITRA_GLOW   0xc900
 #define USB_DEVICE_ID_LOGITECH_MOMO_WHEEL2	0xca03
 #define USB_DEVICE_ID_LOGITECH_VIBRATION_WHEEL	0xca04

diff --git a/drivers/hid/hid-logitech-hidpp.c
b/drivers/hid/hid-logitech-hidpp.c
index 6d8d933efe18..c495484e9765 100644
=2D-- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -11,6 +11,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

 #include <linux/device.h>
+#include <linux/dmi.h>
 #include <linux/input.h>
 #include <linux/usb.h>
 #include <linux/hid.h>
@@ -77,6 +78,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_QUIRK_HIDPP_WHEELS		BIT(26)
 #define HIDPP_QUIRK_HIDPP_EXTRA_MOUSE_BTNS	BIT(27)
 #define HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS	BIT(28)
+#define HIDPP_QUIRK_CLASS_SIMPLE_START	BIT(29)

 /* These are just aliases for now */
 #define HIDPP_QUIRK_KBD_SCROLL_WHEEL HIDPP_QUIRK_HIDPP_WHEELS
@@ -99,6 +101,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_CAPABILITY_HIDPP20_HI_RES_WHEEL	BIT(7)
 #define HIDPP_CAPABILITY_HIDPP20_HI_RES_SCROLL	BIT(8)
 #define HIDPP_CAPABILITY_HIDPP10_FAST_SCROLL	BIT(9)
+#define HIDPP_CAPABILITY_ILLUMINATION_LIGHT		BIT(10)

 #define lg_map_key_clear(c)  hid_map_usage_clear(hi, usage, bit, max,
EV_KEY, (c))

@@ -207,6 +210,7 @@ struct hidpp_device {
 	struct hidpp_scroll_counter vertical_wheel_counter;

 	u8 wireless_feature_index;
+	u8 illumination_feature_index;
 };

 /* HID++ 1.0 error codes */
@@ -228,6 +232,7 @@ struct hidpp_device {
 #define HIDPP20_ERROR				0xff

 static void hidpp_connect_event(struct hidpp_device *hidpp_dev);
+static void hidpp_illumination_defered_event(struct hidpp_device *hidpp);

 static int __hidpp_send_report(struct hid_device *hdev,
 				struct hidpp_report *hidpp_report)
@@ -402,6 +407,9 @@ static void delayed_work_cb(struct work_struct *work)
 	struct hidpp_device *hidpp =3D container_of(work, struct
hidpp_device,
 							work);
 	hidpp_connect_event(hidpp);
+	if (hidpp->capabilities & HIDPP_CAPABILITY_ILLUMINATION_LIGHT) {
+		hidpp_illumination_defered_event(hidpp);
+	}
 }

 static inline bool hidpp_match_answer(struct hidpp_report *question,
@@ -857,6 +865,8 @@ static int hidpp_unifying_init(struct hidpp_device
*hidpp)
 #define CMD_ROOT_GET_FEATURE				0x00
 #define CMD_ROOT_GET_PROTOCOL_VERSION			0x10

+#define HIDPP_FEATURE_TYPE_HIDDEN 0x70
+
 static int hidpp_root_get_feature(struct hidpp_device *hidpp, u16
feature,
 	u8 *feature_index, u8 *feature_type)
 {
@@ -1723,6 +1733,392 @@ static int hidpp_set_wireless_feature_index(struct
hidpp_device *hidpp)
 	return ret;
 }

+/*
=2D-----------------------------------------------------------------------=
--
*/
+/* 0x1990: Illumination Light
*/
+/*
=2D-----------------------------------------------------------------------=
--
*/
+
+#define HIDPP_PAGE_ILLUMINATION_LIGHT 0x1990
+
+#define HIDPP_ILLUMINATION_FUNC_GET 0x00
+#define HIDPP_ILLUMINATION_FUNC_SET 0x10
+#define HIDPP_ILLUMINATION_FUNC_GET_BRIGHTNESS_INFO 0x20
+#define HIDPP_ILLUMINATION_FUNC_GET_BRIGHTNESS 0x30
+#define HIDPP_ILLUMINATION_FUNC_SET_BRIGHTNESS 0x40
+
+/* Not yet supported
+ * #define HIDPP_ILLUMINATION_FUNC_GET_BRIGHTNESS_LEVELS 0x50
+ * #define HIDPP_ILLUMINATION_FUNC_SET_BRIGHTNESS_LEVELS 0x60
+ */
+
+#define HIDPP_ILLUMINATION_FUNC_GET_COLOR_TEMPERATURE_INFO 0x70
+#define HIDPP_ILLUMINATION_FUNC_GET_COLOR_TEMPERATURE 0x80
+#define HIDPP_ILLUMINATION_FUNC_SET_COLOR_TEMPERATURE 0x90
+
+/* Not yet supported
+ * #define HIDPP_ILLUMINATION_FUNC_GET_COLOR_TEMPERATURE_LEVELS 0xA0
+ * #define HIDPP_ILLUMINATION_FUNC_SET_COLOR_TEMPERATURE_LEVELS 0xB0
+ */
+
+#define HIDPP_ILLUMINATION_EVENT_CHANGE 0x00
+#define HIDPP_ILLUMINATION_EVENT_BRIGHTNESS_CHANGE 0x10
+#define HIDPP_ILLUMINATION_EVENT_COLOR_TEMPERATURE_CHANGE 0x20
+
+#define HIDPP_ILLUMINATION_CAP_EVENTS BIT(0)
+#define HIDPP_ILLUMINATION_CAP_LINEAR_LEVELS BIT(1)
+#define HIDPP_ILLUMINATION_CAP_NON_LINEAR_LEVELS BIT(2)
+
+struct control_info {
+	u16 min;
+	u16 max;
+	u16 res;
+	u8 capabilities;
+	u8 max_levels;
+};
+
+struct led_data {
+	struct led_classdev cdev;
+	struct hidpp_device *drv_data;
+	struct hid_device *hdev;
+	u16 feature_index;
+	struct control_info brightness_info;
+	struct control_info color_temperature_info;
+	struct {
+		struct mutex mutex;
+		int on;
+		int brightness;
+	} hw_change;
+	char dirname[256];
+};
+
+/* kernel led interface designates 0 as off. To not lose the ability to
chose
+ * minimal brightness, we thus need to increase the reported range by 1
+ */
+static unsigned int device_to_led_brightness(struct led_data *led, u16
device_brightness)
+{
+	u16 relative =3D device_brightness - led->brightness_info.min;
+	u16 step =3D relative / led->brightness_info.res;
+
+	return step + 1;
+}
+
+static u16 led_to_device_brightness(struct led_data *led, unsigned int
led_brightness)
+{
+	unsigned int step =3D led_brightness - 1;
+	unsigned int relative =3D step * led->brightness_info.res;
+
+	return led->brightness_info.min + relative;
+}
+
+static int request_led_on(struct hidpp_device *hidpp, struct led_data
*led, bool *on)
+{
+
+	struct hidpp_report report;
+
+	int ret =3D hidpp_send_fap_command_sync(hidpp,
+		hidpp->illumination_feature_index,
+		HIDPP_ILLUMINATION_FUNC_GET, NULL,
+		0, &report);
+	if (ret) {
+		hid_err(hidpp->hid_dev, "Getting Illumination failed\n");
+		return ret;
+	}
+
+	*on =3D report.fap.params[0] & BIT(0);
+	return 0;
+}
+
+static int request_led_brightness(struct hidpp_device *hidpp, struct
led_data *led,
+	unsigned int *led_brightness)
+{
+	u16 device_brightness;
+	struct hidpp_report report;
+
+	int ret =3D hidpp_send_fap_command_sync(
+		hidpp, hidpp->illumination_feature_index,
+		HIDPP_ILLUMINATION_FUNC_GET_BRIGHTNESS, NULL, 0, &report);
+	if (ret) {
+		hid_err(hidpp->hid_dev,
+			"Getting Illumination Brightness failed\n");
+		return ret;
+	}
+
+	device_brightness =3D get_unaligned_be16(&report.fap.params[0]);
+	*led_brightness =3D device_to_led_brightness(led,
device_brightness);
+	return 0;
+}
+
+static enum led_brightness led_brightness_get(struct led_classdev
*led_cdev)
+{
+	bool on;
+	unsigned int brightness;
+	struct led_data *led =3D container_of(led_cdev, struct led_data,
cdev);
+	struct hidpp_device *hidpp =3D led->drv_data;
+
+	int ret =3D request_led_on(hidpp, led, &on);
+
+	if (ret || !on)
+		return LED_OFF;
+
+	ret =3D request_led_brightness(hidpp, led, &brightness);
+	if (ret)
+		return LED_OFF;
+
+	return brightness;
+}
+
+
+static void led_brightness_set_dummy(struct led_classdev *led_cdev,
+			enum led_brightness led_brightness)
+{
+}
+
+static int led_brightness_set_sync(struct led_classdev *led_cdev,
+			       enum led_brightness led_brightness)
+{
+	struct hidpp_report report;
+	struct led_data *led =3D container_of(led_cdev, struct led_data,
cdev);
+	struct hidpp_device *hidpp =3D led->drv_data;
+	u16 device_brightness =3D led_to_device_brightness(led,
led_brightness);
+
+	bool on =3D led_brightness !=3D 0;
+	u8 params[2] =3D { on ? BIT(0) : 0, 0 };
+
+	int ret =3D hidpp_send_fap_command_sync(hidpp,
+
hidpp->illumination_feature_index,
+					  HIDPP_ILLUMINATION_FUNC_SET,
params,
+					  1, &report);
+	if (ret) {
+		hid_err(hidpp->hid_dev, "Setting Illumination failed\n");
+		return ret;
+	}
+
+	if (!on)
+		return 0;
+
+	put_unaligned_be16(device_brightness, params);
+	ret =3D hidpp_send_fap_command_sync(
+		hidpp, hidpp->illumination_feature_index,
+		HIDPP_ILLUMINATION_FUNC_SET_BRIGHTNESS, params, 2,
+		&report);
+	if (ret) {
+		hid_err(hidpp->hid_dev,
+			"Setting Illumination Brightness failed\n");
+	}
+	return ret;
+}
+
+static int get_brightness_info_sync(struct hidpp_device *hidpp,
+				    struct control_info *info)
+{
+	struct hidpp_report resp;
+	int ret =3D hidpp_send_fap_command_sync(
+		hidpp, hidpp->illumination_feature_index,
+		HIDPP_ILLUMINATION_FUNC_GET_BRIGHTNESS_INFO, NULL, 0,
&resp);
+	if (ret) {
+		hid_err(hidpp->hid_dev,
+			"%s: failed with %d\n", __func__, ret);
+		return ret;
+	}
+
+	info->capabilities =3D resp.fap.params[0];
+	info->min =3D get_unaligned_be16(&resp.fap.params[1]);
+	info->max =3D get_unaligned_be16(&resp.fap.params[3]);
+	info->res =3D get_unaligned_be16(&resp.fap.params[5]);
+	info->max_levels =3D resp.fap.params[7] & 0x0F;
+	return 0;
+}
+
+static int get_color_temperature_info_sync(struct hidpp_device *hidpp,
+					   struct control_info *info)
+{
+	struct hidpp_report resp;
+	int ret =3D hidpp_send_fap_command_sync(
+		hidpp, hidpp->illumination_feature_index,
+		HIDPP_ILLUMINATION_FUNC_GET_COLOR_TEMPERATURE_INFO, NULL,
0,
+		&resp);
+	if (ret) {
+		hid_err(hidpp->hid_dev,
+			"%s: failed with %d\n", __func__, ret);
+		return ret;
+	}
+
+	info->capabilities =3D resp.fap.params[0];
+	info->min =3D get_unaligned_be16(&resp.fap.params[1]);
+	info->max =3D get_unaligned_be16(&resp.fap.params[3]);
+	info->res =3D get_unaligned_be16(&resp.fap.params[5]);
+	info->max_levels =3D resp.fap.params[7];
+	return 0;
+}
+
+static int register_led(struct hidpp_device *hidpp)
+{
+	int ret;
+	unsigned int brightness_range;
+	struct led_data *led =3D devm_kzalloc(&hidpp->hid_dev->dev,
sizeof(struct led_data),
+			  GFP_KERNEL);
+
+	if (!led)
+		return -ENOMEM;
+
+	ret =3D get_brightness_info_sync(hidpp, &led->brightness_info);
+	if (ret)
+		goto cleanup;
+
+	ret =3D get_color_temperature_info_sync(hidpp,
+
&led->color_temperature_info);
+	if (ret)
+		goto cleanup;
+
+	led->drv_data =3D hidpp;
+	mutex_init(&led->hw_change.mutex);
+	led->hw_change.on =3D -1;
+	led->hw_change.brightness =3D -1;
+	led->cdev.name =3D "logitech::illumination";
+	led->cdev.flags =3D LED_BRIGHT_HW_CHANGED | LED_HW_PLUGGABLE;
+	led->cdev.max_brightness =3D device_to_led_brightness(led,
led->brightness_info.max);
+	brightness_range =3D led->brightness_info.max -
led->brightness_info.min;
+	if (brightness_range =3D=3D 0) {
+		/* According to docs set value is not supported under
these
+		 * conditions.
+		 * LED interface enforces a set function.
+		 */
+		led->cdev.brightness_set =3D led_brightness_set_dummy;
+	} else {
+		led->cdev.brightness_set_blocking =3D
led_brightness_set_sync;
+	}
+	led->cdev.brightness_get =3D led_brightness_get;
+
+	ret =3D devm_led_classdev_register(&hidpp->hid_dev->dev,
&led->cdev);
+	if (ret < 0)
+		goto register_fail;
+
+	hidpp->private_data =3D led;
+	return 0;
+register_fail:
+	mutex_destroy(&led->hw_change.mutex);
+cleanup:
+	devm_kfree(&hidpp->hid_dev->dev, led);
+	return ret;
+}
+
+static int hidpp_initialize_illumination(struct hidpp_device *hidpp)
+{
+	int ret;
+	unsigned long capabilities =3D hidpp->capabilities;
+
+	if (hidpp->protocol_major >=3D 2) {
+		u8 feature_index;
+		u8 feature_type;
+
+		ret =3D hidpp_root_get_feature(hidpp,
+
HIDPP_PAGE_ILLUMINATION_LIGHT,
+					     &feature_index,
&feature_type);
+		if (!ret && !(feature_type & HIDPP_FEATURE_TYPE_HIDDEN)) {
+			hidpp->capabilities |=3D
+				HIDPP_CAPABILITY_ILLUMINATION_LIGHT;
+			hidpp->illumination_feature_index =3D feature_index;
+			hid_dbg(hidpp->hid_dev,
+				"Detected HID++ 2.0 Illumination
Light\n");
+			return 0;
+		}
+	}
+
+	if (hidpp->capabilities =3D=3D capabilities)
+		hid_dbg(hidpp->hid_dev,
+			"Did not detect HID++ Illumination Light hardware
support\n");
+	return 0;
+}
+
+static void hidpp_remove_illumination(struct hidpp_device *hidpp)
+{
+	struct led_data *led =3D (struct led_data *)hidpp->private_data;
+
+	mutex_destroy(&led->hw_change.mutex);
+}
+
+static void hidpp_illumination_defered_event(struct hidpp_device *hidpp)
+{
+	bool has_hw_change, on;
+	int ret;
+	unsigned int led_brightness;
+	struct led_data *led =3D (struct led_data *)hidpp->private_data;
+
+	mutex_lock(&led->hw_change.mutex);
+
+	has_hw_change =3D led->hw_change.on =3D=3D -1 &&
led->hw_change.brightness =3D=3D -1;
+
+	if (!has_hw_change)
+		goto unlock;
+
+	if (led->hw_change.on =3D=3D -1) {
+		ret =3D request_led_on(hidpp, led, &on);
+		if (ret)
+			goto reset_hw_change;
+	} else {
+		on =3D led->hw_change.on;
+	}
+
+	if (!on) {
+		led_brightness =3D LED_OFF;
+		goto notify_changed;
+	}
+
+	if (led->hw_change.brightness =3D=3D -1) {
+		ret =3D request_led_brightness(hidpp, led, &led_brightness);
+		if (ret)
+			goto reset_hw_change;
+	} else {
+		led_brightness =3D device_to_led_brightness(led,
led->hw_change.brightness);
+	}
+
+notify_changed:
+	led_classdev_notify_brightness_hw_changed(
+		&led->cdev, led_brightness);
+reset_hw_change:
+	led->hw_change.on =3D -1;
+	led->hw_change.brightness =3D -1;
+unlock:
+	mutex_unlock(&led->hw_change.mutex);
+}
+
+static int hidpp20_illumination_raw_event(struct hidpp_device *hidpp, u8
*data,
+					  int size)
+{
+	struct led_data *led =3D (struct led_data *)hidpp->private_data;
+	struct hidpp_report *report =3D (struct hidpp_report *)data;
+
+	switch (report->report_id) {
+	case REPORT_ID_HIDPP_LONG:
+		/* size is already checked in hidpp_raw_event.
+		 * only leave long through
+		 */
+		break;
+	default:
+		hid_err(hidpp->hid_dev, "%s:Unhandled report_id %u\n",
__func__, report->report_id);
+		return 0;
+	}
+
+	if (report->fap.feature_index !=3D
hidpp->illumination_feature_index)
+		return 0;
+
+	if (report->fap.funcindex_clientid =3D=3D
HIDPP_ILLUMINATION_EVENT_CHANGE) {
+		mutex_lock(&led->hw_change.mutex);
+		led->hw_change.on =3D report->fap.params[0] & BIT(0);
+		mutex_unlock(&led->hw_change.mutex);
+		return 0;
+	}
+
+	if (report->fap.funcindex_clientid =3D=3D
+	    HIDPP_ILLUMINATION_EVENT_BRIGHTNESS_CHANGE) {
+		mutex_lock(&led->hw_change.mutex);
+		led->hw_change.brightness =3D
get_unaligned_be16(&report->fap.params[0]);
+		mutex_unlock(&led->hw_change.mutex);
+		return 0;
+	}
+
+	return 0;
+}
+
 /*
=2D-----------------------------------------------------------------------=
--
*/
 /* 0x2120: Hi-resolution scrolling
*/
 /*
=2D-----------------------------------------------------------------------=
--
*/
@@ -3640,6 +4036,12 @@ static int hidpp_raw_hidpp_event(struct
hidpp_device *hidpp, u8 *data,
 			return ret;
 	}

+	if (hidpp->capabilities & HIDPP_CAPABILITY_ILLUMINATION_LIGHT) {
+		ret =3D hidpp20_illumination_raw_event(hidpp, data, size);
+		if (ret !=3D 0)
+			return ret;
+	}
+
 	if (hidpp->quirks & HIDPP_QUIRK_HIDPP_WHEELS) {
 		ret =3D hidpp10_wheel_raw_event(hidpp, data, size);
 		if (ret !=3D 0)
@@ -3964,6 +4366,7 @@ static void hidpp_connect_event(struct hidpp_device
*hidpp)

 	hidpp_initialize_battery(hidpp);
 	hidpp_initialize_hires_scroll(hidpp);
+	hidpp_initialize_illumination(hidpp);

 	/* forward current battery state */
 	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP10_BATTERY) {
@@ -3986,6 +4389,14 @@ static void hidpp_connect_event(struct hidpp_device
*hidpp)
 	if (hidpp->capabilities & HIDPP_CAPABILITY_HI_RES_SCROLL)
 		hi_res_scroll_enable(hidpp);

+	if (hidpp->capabilities & HIDPP_CAPABILITY_ILLUMINATION_LIGHT) {
+		ret =3D register_led(hidpp);
+		if (ret) {
+			hid_err(hdev, "Registering leds failed.\n");
+			return;
+		}
+	}
+
 	if (!(hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT) ||
hidpp->delayed_input)
 		/* if the input nodes are already created, we can stop now
*/
 		return;
@@ -4156,11 +4567,15 @@ static int hidpp_probe(struct hid_device *hdev,
const struct hid_device_id *id)
 		hid_warn(hdev, "Cannot allocate sysfs group for %s\n",
 			 hdev->name);

-	/*
-	 * Plain USB connections need to actually call start and open
-	 * on the transport driver to allow incoming data.
-	 */
-	ret =3D hid_hw_start(hdev, 0);
+	if (hidpp->quirks & HIDPP_QUIRK_CLASS_SIMPLE_START) {
+		ret =3D hid_hw_start(hdev, HID_CLAIMED_DRIVER);
+	} else {
+		/*
+		 * Plain USB connections need to actually call start and
open
+		 * on the transport driver to allow incoming data.
+		 */
+		ret =3D hid_hw_start(hdev, 0);
+	}
 	if (ret) {
 		hid_err(hdev, "hw start failed\n");
 		goto hid_hw_start_fail;
@@ -4211,6 +4626,10 @@ static int hidpp_probe(struct hid_device *hdev,
const struct hid_device_id *id)

 	hidpp_connect_event(hidpp);

+	/* Resetting HID node made communication with Glow break down*/
+	if (hidpp->quirks & HIDPP_QUIRK_CLASS_SIMPLE_START)
+		return 0;
+
 	/* Reset the HID node state */
 	hid_device_io_stop(hdev);
 	hid_hw_close(hdev);
@@ -4254,6 +4673,9 @@ static void hidpp_remove(struct hid_device *hdev)
 	if (!hidpp)
 		return hid_hw_stop(hdev);

+	if (hidpp->capabilities & HIDPP_CAPABILITY_ILLUMINATION_LIGHT)
+		hidpp_remove_illumination(hidpp);
+
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);

 	hid_hw_stop(hdev);
@@ -4334,6 +4756,9 @@ static const struct hid_device_id hidpp_devices[] =
=3D
{
 		.driver_data =3D HIDPP_QUIRK_CLASS_G920 |
HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
 	{ /* Logitech G Pro Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC088) },
+	{ /* Logitech Litra Glow over USB*/
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
USB_DEVICE_ID_LOGITECH_LITRA_GLOW),
+		.driver_data =3D HIDPP_QUIRK_CLASS_SIMPLE_START |
HIDPP_QUIRK_FORCE_OUTPUT_REPORTS },

 	{ /* MX5000 keyboard over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb305),
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 0e9702c7f7d6..64c176b0ba88 100644
=2D-- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -494,6 +494,7 @@ static const struct hid_device_id
hid_have_special_driver[] =3D {
 #endif
 #if IS_ENABLED(CONFIG_HID_LOGITECH_HIDPP)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
USB_DEVICE_ID_LOGITECH_G920_WHEEL) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
USB_DEVICE_ID_LOGITECH_LITRA_GLOW) },
 #endif
 #if IS_ENABLED(CONFIG_HID_MAGICMOUSE)
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
USB_DEVICE_ID_APPLE_MAGICMOUSE) },
=2D-
2.34.1

