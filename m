Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F8C6E9FF7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 01:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjDTXcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 19:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjDTXco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 19:32:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA52A1FDE;
        Thu, 20 Apr 2023 16:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682033551; i=w_armin@gmx.de;
        bh=Da4PHCXaosXpykDrP87jrud25OULHX5gF6GpD5hlCjk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=t4hTEB7A/5hInBeoBkypP8asJUDLA+GCqKB0j3NYoTuzF7GHKvPGe3W3TGo2UEh+b
         FVUyHZ4NQCl8hzMlFFjulF02ZMXzZllPhrH0exYV9NghmEtFV5F6BM9FnsoZoL+/qG
         U/GX0X8cr/sdxWvCjtRoH+EEjPyFCSXjZWEqLJsSIvL6ZjF8grWKRwCintt3gUyhD9
         gO6YPUSnK6WiIE312FAzOq/f+Os7h6yIB5l3jj5HGWC7Jc5fD6rj25QB1R6K54oZVf
         wFk/0vQ/lN6xlMGAkl1hRx3XgfTmsVU/1jcDKaRDhTQSTKnGF0cuqumqwovUOu1BCh
         04SdV6/qwfBIw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N1Obh-1qIKV20NMx-012ppz; Fri, 21 Apr 2023 01:32:31 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] platform/x86: wmi: Add kernel doc comments
Date:   Fri, 21 Apr 2023 01:32:23 +0200
Message-Id: <20230420233226.14561-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230420233226.14561-1-W_Armin@gmx.de>
References: <20230420233226.14561-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fSd0QTLLNKuFlQrIfQkjWUYjLpmuYGJzdnrmDNWWJIoKyr3vBPD
 qtNhSwyF7uw490szcqf1ZmpWy1TY+ItKEY4Hw9g41aok9ZB7JLXOX6XL7ZdAUaXVD/2bCrN
 EbmtALcHVpyYj+JRktmcHAhfLtsG6wYWeLZlTxXbmNlB2sEQOQEHRIkh5YxNgiDYsvPb8Xh
 MF4hymQZaMj68dRmfPU7w==
UI-OutboundReport: notjunk:1;M01:P0:9ZovCV5aIWI=;nwiSxoPMyEkA1XDo9sEwJmgKo0w
 KC/TqXcZwXzBOuyfobPiSCMJb2+gN82BXnFJLYsgalr2oPPG4M6BqA84DW3byO8YNHkp77+mq
 OGcgA1KCnjVNn6Cy0doNow4gNbRXilN7FENzn2u9Rvb+oAfVwR+9eeGTKFxbq3oViEoKkHvwD
 UrKmN5ijdBtCImSLskGYfIAKW/iJJDLAg9oGrskLuaVMVBo97F0FIixu/WVK/9Mt8G7B/OeOe
 7+EhxXPXejI0edIU/cd2N6/DwS5zio9l3/YdLf9QZ0xAQ6w5T7jZM7iH0/uyaBuNYAQ8D+hbA
 jr3yYPV+f2vTt3XPgno+19XrIn1Hnjae81YcaSPbKXsyBQAnt+HydinepIOxV0XkknhnUJbhP
 NnpNkl22EvDbi4OfnjtDNVRJ9RlFh999N+5oGvgJiYUimSw/qvwukxgf+41/2N8UR1/YMDiNr
 997BT+7O2dJDn9oRV7fYP10OGQSZw2lwc2/yJgujYLUJVS5a3VyKfQ5mB1U539ipNOqVAZ0Sl
 UHrjx6vKQyEqm0JnGkzh8SVrZ9UMM+MYyiPrZLk9V9EddnnMx7+NeY8dImGrLDSEvH4fX9dM6
 FMmHoADJiphYkigsiq/Hkmt2RZwmtYSFKrCdwb65ezTNtP02/DveDPC/ry2qwOLlcuTEpHJrW
 5/KUuizL6q2kpR9lO/hx7XKFaSspnD4V+U9nMOcHoJgLFX3hwUSn6/80Rmk+2yJxSr7erjY+t
 QGhHwj67XZJwESjDAg/9CLpBgjkpdj4lkoayuF6GINbw1rsRoq/ivCzBGRAl+915BmOhwd5yt
 ed4d9BQahLmNrSdCBo4e0tBVGNjsCYJIGM1QA1xOv3ql88Xrv4Df9SVQZaUhp4hI4+3h7wXbK
 SaFNkihngjUZRFws66KMXNRK+6fSGzDdM+wcS4tj0wujKmlc6YekWBvxv3z6U5wKLIU5CvRni
 V3T/WQtkyL4eVOHbkoadMT6hgOs=
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
index d81319a502ef..e4b41dca70c7 100644
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
+ * Query a ACPI-WMI block, the caller must free the result.
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
index b88d7b58e61e..88f66b12eef9 100644
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
+ * wmi_driver_register() - Helper macro ro register a WMI driver
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

