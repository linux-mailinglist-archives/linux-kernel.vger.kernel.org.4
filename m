Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821116ED7F0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 00:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjDXWaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 18:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbjDXWaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:30:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F028658A;
        Mon, 24 Apr 2023 15:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682375394; i=w_armin@gmx.de;
        bh=iVqdph6X+GipV6ZKWRoPrN5VwYjb+Cuw0LlqITIXC8g=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=EPBT1DsZlnuFQnYXiODEXNX6V/vApieESYS6Bvn+kzrf3oq8pb2ZuMaVG0jjlc7M3
         cnYgZef38ilsyf6WAsn6qXYa4/IX5bZDydINoJxLhkHHVmH2MXZLVOoSv9M1Jk0wiF
         j+PxGrbt1xbQOOeaXKM/MznyNpg06vAb72uYvkEMPOfumSgpWtPa4/1gm0E761dni8
         vKIbG48bumaIyIru6qgnwMuvIQKLMa91L7ZeO7WMKK5IN+ktwsZjJ6O/2JGYnbdL6+
         V7F8SC9VaRUPo4LYIOgdPIdczspCcjwhdMIbhVrcBMgeUH6gIc8K3aK3WGtAqbCbFD
         16ZqP/oGuJv2g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MfpSl-1qWlEu37px-00gH6M; Tue, 25 Apr 2023 00:29:53 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org, rdunlap@infradead.org
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] platform/x86: wmi: Add kernel doc comments
Date:   Tue, 25 Apr 2023 00:29:36 +0200
Message-Id: <20230424222939.208137-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230424222939.208137-1-W_Armin@gmx.de>
References: <20230424222939.208137-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vRCVVwbDWD+ZJ87iIsOkjEBi0bfwLpBmzAC78h858sft/66f5Ec
 z7kUdMGQ1VOCGx4Dqts+r38gSCuFfi/XFazYZAJGfyVzRpKG+rkbp8Ds3c3F+DOnqyK+iDi
 GBQtvuqmOVViN69BIxD04KLTCnS+8HU9WLGlFJx8unnjS6aMOctzL0KftEtq/wfSBXw707F
 y+Yszbh7OtadYnny8TNnQ==
UI-OutboundReport: notjunk:1;M01:P0:gOsB93qS9hI=;SkHAswjJY9NmoO4Uf27QmE4aze5
 P4rLLQRpWzSuWfbyK6ChIvxJCfg5sAl6YEvipZb60kf31fx/QlFxILOraQ8uaIbaEG2+Y8JEL
 hrGsNzLPgOLGAeHAmuM1ZGa4uB2Ol9eAcTtv6+5RV7GZHYZU09CMO2YryJC8hNqqxbBiwurY0
 cxhP8JnIcdDswNITNog0zCrAxqAs/usQtUXIMLHRA/zAiIEKS5LAWVE7We9MnCU43MA4Vt0eI
 lUnPRuKZVZ6VswQnqRPgWgV604QLDYlpgwmFddbJ9VFeh89AdxUDWdX3ORd+ObQqj/lbvCSHZ
 WSXEnEXiB8bSJPDPeTx++WaMMK+LiB4ptVG1smKq/MwrN0KE/4QMdLx3sHLTphaRDsztQ/h6z
 uRX05Xv5oG3hSj98reux2tYk9+yCQUd2MPQ6qWZVbG0kH4AYMaOvAf8Cos4iZt4x0F0Yb8tPP
 lboqMUFp8D/rD0KbCJOTpgy6vYtNJn6WWNyHXw5HwxNnF3Var0IH3mgbyrwsq0tjxcTIPdiG/
 kL10nfpajrH/Elv9kKr8tlCuSPB1KQEHFIzjn1lE38JH0iWBNsWInkmQu8CqhcRlM1UrcYdgV
 EwiuE7U0KcMUATfeIgEYfAUtcYZ8YeXF/g9hN+4EvsXXgzYFGTUKrA0FUKxw1Mc59LZrvFFTB
 Q2Yd85GqrSxKvMARCguMU6Y2bJC/etSW9UaEaQaKbeYQVYt/bBiB715urV69hZq2ryCowawtx
 RUPSMiDYd9Xkq65hojWCMj5fNyotk8kTE9TIeHnjo+LXU8zwnbOXf1TgWm9bH2LfCENFACmhV
 FjxvT+1PI4IZkoR7VtdC2OzXE42q29FTwASgwIOWyJaCeLlEIJAwT3DCxhSAzr1p067xvxzMl
 ClTshkEMU2MhmNEDbkh+I2/6XBhCUInmMszOGDP/MkVD5DyXqBYJPj4YrJoACQ5oaUilV6IZu
 UbijtJ4GWOlkp4Ki1iyj1T7AI6Q=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kernel doc comments useful for documenting the functions/structs
used to interact with the WMI driver core.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 51 +++++++++++++++++++++++++++++++-------
 include/linux/wmi.h        | 41 +++++++++++++++++++++++++++---
 2 files changed, 80 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index d81319a502ef..99af2cc03b0f 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -248,7 +248,9 @@ static acpi_status get_event_data(const struct wmi_blo=
ck *wblock, struct acpi_bu
  * @wdev: A wmi bus device from a driver
  * @length: Required buffer size
  *
- * Allocates memory needed for buffer, stores the buffer size in that mem=
ory
+ * Allocates memory needed for buffer, stores the buffer size in that mem=
ory.
+ *
+ * Return: 0 on success or a negative error code for failure.
  */
 int set_required_buffer_size(struct wmi_device *wdev, u64 length)
 {
@@ -269,7 +271,9 @@ EXPORT_SYMBOL_GPL(set_required_buffer_size);
  * @in: Buffer containing input for the method call
  * @out: Empty buffer to return the method results
  *
- * Call an ACPI-WMI method
+ * Call an ACPI-WMI method, the caller must free @out.
+ *
+ * Return: acpi_status signaling success or error.
  */
 acpi_status wmi_evaluate_method(const char *guid_string, u8 instance, u32=
 method_id,
 				const struct acpi_buffer *in, struct acpi_buffer *out)
@@ -294,7 +298,9 @@ EXPORT_SYMBOL_GPL(wmi_evaluate_method);
  * @in: Buffer containing input for the method call
  * @out: Empty buffer to return the method results
  *
- * Call an ACPI-WMI method
+ * Call an ACPI-WMI method, the caller must free @out.
+ *
+ * Return: acpi_status signaling success or error.
  */
 acpi_status wmidev_evaluate_method(struct wmi_device *wdev, u8 instance, =
u32 method_id,
 				   const struct acpi_buffer *in, struct acpi_buffer *out)
@@ -411,7 +417,9 @@ static acpi_status __query_block(struct wmi_block *wbl=
ock, u8 instance,
  * @instance: Instance index
  * @out: Empty buffer to return the contents of the data block to
  *
- * Return the contents of an ACPI-WMI data block to a buffer
+ * Query a ACPI-WMI block, the caller must free @out.
+ *
+ * Return: ACPI object containing the content of the WMI block.
  */
 acpi_status wmi_query_block(const char *guid_string, u8 instance,
 			    struct acpi_buffer *out)
@@ -427,6 +435,15 @@ acpi_status wmi_query_block(const char *guid_string, =
u8 instance,
 }
 EXPORT_SYMBOL_GPL(wmi_query_block);

+/**
+ * wmidev_block_query - Return contents of a WMI block
+ * @wdev: A wmi bus device from a driver
+ * @instance: Instance index
+ *
+ * Query an ACPI-WMI block, the caller must free the result.
+ *
+ * Return: ACPI object containing the content of the WMI block.
+ */
 union acpi_object *wmidev_block_query(struct wmi_device *wdev, u8 instanc=
e)
 {
 	struct acpi_buffer out =3D { ACPI_ALLOCATE_BUFFER, NULL };
@@ -445,7 +462,9 @@ EXPORT_SYMBOL_GPL(wmidev_block_query);
  * @instance: Instance index
  * @in: Buffer containing new values for the data block
  *
- * Write the contents of the input buffer to an ACPI-WMI data block
+ * Write the contents of the input buffer to an ACPI-WMI data block.
+ *
+ * Return: acpi_status signaling success or error.
  */
 acpi_status wmi_set_block(const char *guid_string, u8 instance,
 			  const struct acpi_buffer *in)
@@ -555,6 +574,8 @@ static void wmi_notify_debug(u32 value, void *context)
  * @data: Data to be returned to handler when event is fired
  *
  * Register a handler for events sent to the ACPI-WMI mapper device.
+ *
+ * Return: acpi_status signaling success or error.
  */
 acpi_status wmi_install_notify_handler(const char *guid,
 				       wmi_notify_handler handler,
@@ -597,6 +618,8 @@ EXPORT_SYMBOL_GPL(wmi_install_notify_handler);
  * @guid: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417f2f49ba
  *
  * Unregister handler for events sent to the ACPI-WMI mapper device.
+ *
+ * Return: acpi_status signaling success or error.
  */
 acpi_status wmi_remove_notify_handler(const char *guid)
 {
@@ -641,9 +664,11 @@ EXPORT_SYMBOL_GPL(wmi_remove_notify_handler);
  * wmi_get_event_data - Get WMI data associated with an event
  *
  * @event: Event to find
- * @out: Buffer to hold event data. out->pointer should be freed with kfr=
ee()
+ * @out: Buffer to hold event data
+ *
+ * Get extra data associated with an WMI event, the caller needs to free =
@out.
  *
- * Returns extra data associated with an event in WMI.
+ * Return: acpi_status signaling success or error.
  */
 acpi_status wmi_get_event_data(u32 event, struct acpi_buffer *out)
 {
@@ -664,7 +689,9 @@ EXPORT_SYMBOL_GPL(wmi_get_event_data);
  * wmi_has_guid - Check if a GUID is available
  * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417=
f2f49ba
  *
- * Check if a given GUID is defined by _WDG
+ * Check if a given GUID is defined by _WDG.
+ *
+ * Return: True if GUID is available, false otherwise.
  */
 bool wmi_has_guid(const char *guid_string)
 {
@@ -678,7 +705,7 @@ EXPORT_SYMBOL_GPL(wmi_has_guid);
  *
  * Find the _UID of ACPI device associated with this WMI GUID.
  *
- * Return: The ACPI _UID field value or NULL if the WMI GUID was not foun=
d
+ * Return: The ACPI _UID field value or NULL if the WMI GUID was not foun=
d.
  */
 char *wmi_get_acpi_device_uid(const char *guid_string)
 {
@@ -1454,6 +1481,12 @@ int __must_check __wmi_driver_register(struct wmi_d=
river *driver,
 }
 EXPORT_SYMBOL(__wmi_driver_register);

+/**
+ * wmi_driver_unregister() - Unregister a WMI driver
+ * @driver: WMI driver to unregister
+ *
+ * Unregisters a WMI driver from the WMI bus.
+ */
 void wmi_driver_unregister(struct wmi_driver *driver)
 {
 	driver_unregister(&driver->driver);
diff --git a/include/linux/wmi.h b/include/linux/wmi.h
index b88d7b58e61e..c1a3bd4e4838 100644
=2D-- a/include/linux/wmi.h
+++ b/include/linux/wmi.h
@@ -13,25 +13,44 @@
 #include <linux/mod_devicetable.h>
 #include <uapi/linux/wmi.h>

+/**
+ * struct wmi_device - WMI device structure
+ * @dev: Device associated with this WMI device
+ * @setable: True for devices implementing the Set Control Method
+ *
+ * This represents WMI devices discovered by the WMI driver core.
+ */
 struct wmi_device {
 	struct device dev;

-	 /* True for data blocks implementing the Set Control Method */
+	/* private: used by the WMI driver core */
 	bool setable;
 };

-/* evaluate the ACPI method associated with this device */
 extern acpi_status wmidev_evaluate_method(struct wmi_device *wdev,
 					  u8 instance, u32 method_id,
 					  const struct acpi_buffer *in,
 					  struct acpi_buffer *out);

-/* Caller must kfree the result. */
 extern union acpi_object *wmidev_block_query(struct wmi_device *wdev,
 					     u8 instance);

 extern int set_required_buffer_size(struct wmi_device *wdev, u64 length);

+/**
+ * struct wmi_driver - WMI driver structure
+ * @driver: Driver model structure
+ * @id_table: List of WMI GUIDs supported by this driver
+ * @no_notify_data: WMI events provide no event data
+ * @probe: Callback for device binding
+ * @remove: Callback for device unbinding
+ * @notify: Callback for receiving WMI events
+ * @filter_callback: Callback for filtering device IOCTLs
+ *
+ * This represents WMI drivers which handle WMI devices.
+ * @filter_callback is only necessary for drivers which
+ * want to set up a WMI IOCTL interface.
+ */
 struct wmi_driver {
 	struct device_driver driver;
 	const struct wmi_device_id *id_table;
@@ -47,8 +66,24 @@ struct wmi_driver {
 extern int __must_check __wmi_driver_register(struct wmi_driver *driver,
 					      struct module *owner);
 extern void wmi_driver_unregister(struct wmi_driver *driver);
+
+/**
+ * wmi_driver_register() - Helper macro to register a WMI driver
+ * @driver: wmi_driver struct
+ *
+ * Helper macro for registering a WMI driver. It automatically passes
+ * THIS_MODULE to the underlying function.
+ */
 #define wmi_driver_register(driver) __wmi_driver_register((driver), THIS_=
MODULE)

+/**
+ * module_wmi_driver() - Helper macro to register/unregister a WMI driver
+ * @__wmi_driver: wmi_driver struct
+ *
+ * Helper macro for WMI drivers which do not do anything special in modul=
e
+ * init/exit. This eliminates a lot of boilerplate. Each module may only
+ * use this macro once, and calling it replaces module_init() and module_=
exit().
+ */
 #define module_wmi_driver(__wmi_driver) \
 	module_driver(__wmi_driver, wmi_driver_register, \
 		      wmi_driver_unregister)
=2D-
2.30.2

