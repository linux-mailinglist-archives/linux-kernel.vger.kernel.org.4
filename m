Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEC970409C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 00:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343507AbjEOWDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 18:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245651AbjEOWCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 18:02:40 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0A111B6D;
        Mon, 15 May 2023 15:01:22 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-54f83997f10so4918653eaf.1;
        Mon, 15 May 2023 15:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684188068; x=1686780068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yu54r7N7LEeOXWN2Jux2IdWU044d6aZfC2B6oJJ+MdM=;
        b=mw+7Unb8bT4FJ42GBnPVaY7W2spFQU+cgHwoO8PrBs69v19Eu8gs35QOYJJ7l82wiq
         E1zAEzmqZWlQBdeoPRCPPb9N/VnOjRmqfE+PS57I0lhwNsVTeig+u1RgNTU7OVWzkzI8
         WtxOjfo8rvQ3eZ6RoNr8TzHDpaF9p3x4J7d4/PI7TOxX4ujf4G3spLm8yF8pwUXDNmrM
         7PBMYun1KSYm09LQZXSgBMXDmf7RiaG0Hps76SboO/ZHaSE0O06jEc0krWLZ8ShxsT8z
         WRgvi3JaKismNSPB5wtYy1Z3jRqrE5yyD/vw+CrQD0r5t38QnFgd1ZZMQpNavpE4ctm5
         otzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684188068; x=1686780068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yu54r7N7LEeOXWN2Jux2IdWU044d6aZfC2B6oJJ+MdM=;
        b=I9yyDtjCEz/I+sNdEgXWzkrbkDaJst+a4NpXc6ajbAxFVJ2noaylZn6XaW1XFkq84w
         d5PMf5MG1tpmtfPQotZCAOs25LXfNwg74PTb9nB+w0cEHTPRd1tRaOwoHVuDcAaE701a
         NoC8WsYuEkP+YM+jns0lChMbN7QN5fShf558bMwuz9Uw25Ye8wTlqESyhJfvqd+mNKni
         BxwrBIDho0NOH+RFgcjADPhaQIHTfhAo3Jf8ODG8P5O+RFVc5Zzp2KeM8gI62ljGE5Ln
         Nr0aasH1+FeGFJLyVFxz+5TjQRIyVIl8RYI6O2uwUUxFGlZ4BDxPcJX39OVJf6nORvyu
         1CtQ==
X-Gm-Message-State: AC+VfDxsdyQvVz4t+IxL5hmNhLbyoXtxJLupjntR5lMU8pl12NS6qeOj
        C7txFfbHeyjI4FmYW0DGSaj1yE9gRvg=
X-Google-Smtp-Source: ACHHUZ6/4wRb+afjoi/7yskrUlXQ5x5xp0qSxSUAH/i6yKqcUXV7iqzT3wZZsG3RY2iM1fMBxQj+Dw==
X-Received: by 2002:a05:6808:150c:b0:395:1c40:64c6 with SMTP id u12-20020a056808150c00b003951c4064c6mr6800299oiw.37.1684188067611;
        Mon, 15 May 2023 15:01:07 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:5391:4539:59c2:4092])
        by smtp.gmail.com with ESMTPSA id i1-20020aca0c41000000b0038e07fe2c97sm5265148oiy.42.2023.05.15.15.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 15:01:07 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v13 04/13] hp-bioscfg: biosattr-interface
Date:   Mon, 15 May 2023 17:00:52 -0500
Message-Id: <20230515220101.39794-5-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230515220101.39794-1-jorge.lopez2@hp.com>
References: <20230515220101.39794-1-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HP BIOS Configuration driver purpose is to provide a driver supporting
the latest sysfs class firmware attributes framework allowing the user
to change BIOS settings and security solutions on HP Inc.’s commercial
notebooks.

Many features of HP Commercial notebooks can be managed using Windows
Management Instrumentation (WMI). WMI is an implementation of Web-Based
Enterprise Management (WBEM) that provides a standards-based interface
for changing and monitoring system settings. HP BIOSCFG driver provides
a native Linux solution and the exposed features facilitates the
migration to Linux environments.

The Linux security features to be provided in hp-bioscfg driver enables
managing the BIOS settings and security solutions via sysfs, a virtual
filesystem that can be used by user-mode applications. The new
documentation cover HP-specific firmware sysfs attributes such Secure
Platform Management and Sure Start. Each section provides security
feature description and identifies sysfs directories and files exposed
by the driver.

Many HP Commercial notebooks include a feature called Secure Platform
Management (SPM), which replaces older password-based BIOS settings
management with public key cryptography. PC secure product management
begins when a target system is provisioned with cryptographic keys
that are used to ensure the integrity of communications between system
management utilities and the BIOS.

HP Commercial notebooks have several BIOS settings that control its
behaviour and capabilities, many of which are related to security.
To prevent unauthorized changes to these settings, the system can
be configured to use a cryptographic signature-based authorization
string that the BIOS will use to verify authorization to modify the
setting.

Linux Security components are under development and not published yet.
The only linux component is the driver (hp bioscfg) at this time.
Other published security components are under Windows.

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next
---
 .../x86/hp/hp-bioscfg/biosattr-interface.c    | 318 ++++++++++++++++++
 1 file changed, 318 insertions(+)
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c

diff --git a/drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c b/drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
new file mode 100644
index 000000000000..fa95da03de19
--- /dev/null
+++ b/drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
@@ -0,0 +1,318 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Functions corresponding to methods under BIOS interface GUID
+ * for use with hp-bioscfg driver.
+ *
+ *  Copyright (c) 2022 Hewlett-Packard Inc.
+ */
+
+#include <linux/wmi.h>
+#include "bioscfg.h"
+
+/*
+ * struct bios_args buffer is dynamically allocated.  New WMI command types
+ * were introduced that exceeds 128-byte data size.  Changes to handle
+ * the data size allocation scheme were kept in hp_wmi_perform_query function.
+ */
+struct bios_args {
+	u32 signature;
+	u32 command;
+	u32 commandtype;
+	u32 datasize;
+	u8 data[];
+};
+
+/**
+ * hp_set_attribute
+ *
+ * @a_name: The attribute name
+ * @a_value: The attribute value
+ *
+ * Sets an attribute to new value
+ *
+ * Returns zero on success
+ *	-ENODEV if device is not found
+ *	-EINVAL if the instance of 'Setup Admin' password is not found.
+ *	-ENOMEM unable to allocate memory
+ */
+int hp_set_attribute(const char *a_name, const char *a_value)
+{
+	int security_area_size;
+	int a_name_size, a_value_size;
+	u16 *buffer = NULL;
+	u16 *start;
+	int  buffer_size, instance, ret;
+	char *auth_token_choice;
+
+	mutex_lock(&bioscfg_drv.mutex);
+	if (!bioscfg_drv.bios_attr_wdev) {
+		ret = -ENODEV;
+		goto out_set_attribute;
+	}
+
+	instance = hp_get_password_instance_for_type(SETUP_PASSWD);
+	if (instance < 0) {
+		ret = -EINVAL;
+		goto out_set_attribute;
+	}
+
+	/* Select which auth token to use; password or [auth token] */
+	if (bioscfg_drv.spm_data.auth_token)
+		auth_token_choice = bioscfg_drv.spm_data.auth_token;
+	else
+		auth_token_choice = bioscfg_drv.password_data[instance].current_password;
+
+	a_name_size = hp_calculate_string_buffer(a_name);
+	a_value_size = hp_calculate_string_buffer(a_value);
+	security_area_size = hp_calculate_security_buffer(auth_token_choice);
+	buffer_size = a_name_size + a_value_size + security_area_size;
+
+	buffer = kmalloc(buffer_size + 1, GFP_KERNEL);
+	if (!buffer) {
+		ret = -ENOMEM;
+		goto out_set_attribute;
+	}
+
+	/* build variables to set */
+	start = buffer;
+	start = hp_ascii_to_utf16_unicode(start, a_name);
+	if (!start) {
+		ret = -EINVAL;
+		goto out_set_attribute;
+	}
+
+	start = hp_ascii_to_utf16_unicode(start, a_value);
+	if (!start) {
+		ret = -EINVAL;
+		goto out_set_attribute;
+	}
+
+	ret = hp_populate_security_buffer(start, auth_token_choice);
+	if (ret < 0)
+		goto out_set_attribute;
+
+	ret = hp_wmi_set_bios_setting(buffer, buffer_size);
+
+out_set_attribute:
+	kfree(buffer);
+	mutex_unlock(&bioscfg_drv.mutex);
+	return ret;
+}
+
+/**
+ * hp_wmi_perform_query
+ *
+ * @query:	The commandtype (enum hp_wmi_commandtype)
+ * @command:	The command (enum hp_wmi_command)
+ * @buffer:	Buffer used as input and/or output
+ * @insize:	Size of input buffer
+ * @outsize:	Size of output buffer
+ *
+ * returns zero on success
+ *         an HP WMI query specific error code (which is positive)
+ *         -EINVAL if the query was not successful at all
+ *         -EINVAL if the output buffer size exceeds buffersize
+ *
+ * Note: The buffersize must at least be the maximum of the input and output
+ *       size. E.g. Battery info query is defined to have 1 byte input
+ *       and 128 byte output. The caller would do:
+ *       buffer = kzalloc(128, GFP_KERNEL);
+ *       ret = hp_wmi_perform_query(HPWMI_BATTERY_QUERY, HPWMI_READ,
+ *				    buffer, 1, 128)
+ */
+int hp_wmi_perform_query(int query, enum hp_wmi_command command, void *buffer,
+			 u32 insize, u32 outsize)
+{
+	struct acpi_buffer input, output = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct bios_return *bios_return;
+	union acpi_object *obj = NULL;
+	struct bios_args *args = NULL;
+	u32 mid, actual_outsize, ret;
+	size_t bios_args_size;
+
+	mid = hp_encode_outsize_for_pvsz(outsize);
+	if (WARN_ON(mid < 0))
+		return mid;
+
+	bios_args_size = struct_size(args, data, insize);
+	args = kmalloc(bios_args_size, GFP_KERNEL);
+	if (!args)
+		return -ENOMEM;
+
+	input.length = bios_args_size;
+	input.pointer = args;
+
+	/* BIOS expects 'SECU' in hex as the signature value*/
+	args->signature = 0x55434553;
+	args->command = command;
+	args->commandtype = query;
+	args->datasize = insize;
+	memcpy(args->data, buffer, flex_array_size(args, data, insize));
+
+	ret = wmi_evaluate_method(HP_WMI_BIOS_GUID, 0, mid, &input, &output);
+	if (ret)
+		goto out_free;
+
+	obj = output.pointer;
+	if (!obj) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	if (obj->type != ACPI_TYPE_BUFFER ||
+	    obj->buffer.length < sizeof(*bios_return)) {
+		pr_warn("query 0x%x returned wrong type or too small buffer\n", query);
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	bios_return = (struct bios_return *)obj->buffer.pointer;
+	ret = bios_return->return_code;
+	if (ret) {
+		if (ret != INVALID_CMD_VALUE && ret != INVALID_CMD_TYPE)
+			pr_warn("query 0x%x returned error 0x%x\n", query, ret);
+		goto out_free;
+	}
+
+	/* Ignore output data of zero size */
+	if (!outsize)
+		goto out_free;
+
+	actual_outsize = min_t(u32, outsize, obj->buffer.length - sizeof(*bios_return));
+	memcpy_and_pad(buffer, outsize, obj->buffer.pointer + sizeof(*bios_return),
+		       actual_outsize, 0);
+
+out_free:
+	hp_wmi_error_and_message(ret);
+	kfree(obj);
+	kfree(args);
+	return ret;
+}
+
+static void *utf16_empty_string(u16 *p)
+{
+	*p++ = 2;
+	*p++ = 0x00;
+	return p;
+}
+
+/**
+ * hp_ascii_to_utf16_unicode -  Convert ascii string to UTF-16 unicode
+ *
+ * BIOS supports UTF-16 characters that are 2 bytes long.  No variable
+ * multi-byte language supported.
+ *
+ * @p:   Unicode buffer address
+ * @str: string to convert to unicode
+ *
+ * Returns a void pointer to the buffer string
+ */
+void *hp_ascii_to_utf16_unicode(u16 *p, const u8 *str)
+{
+	int len = strlen(str);
+	int ret;
+
+	/*
+	 * Add null character when reading an empty string
+	 * "02 00 00 00"
+	 */
+	if (len == 0)
+		return utf16_empty_string(p);
+
+	/* Move pointer len * 2 number of bytes */
+	*p++ = len * 2;
+	ret = utf8s_to_utf16s(str, strlen(str), UTF16_HOST_ENDIAN, p, len);
+	if (ret < 0) {
+		dev_err(bioscfg_drv.class_dev, "UTF16 conversion failed\n");
+		return NULL;
+	}
+
+	if (ret * sizeof(u16) > U16_MAX) {
+		dev_err(bioscfg_drv.class_dev, "Error string too long\n");
+		return NULL;
+	}
+
+	p += len;
+	return p;
+}
+
+/**
+ * hp_wmi_set_bios_setting - Set setting's value in BIOS
+ *
+ * @input_buffer: Input buffer address
+ * @input_size:   Input buffer size
+ *
+ * Returns: Count of unicode characters written to BIOS if successful, otherwise
+ *		-ENOMEM unable to allocate memory
+ *		-EINVAL buffer not allocated or too small
+ */
+int hp_wmi_set_bios_setting(u16 *input_buffer, u32 input_size)
+{
+	union acpi_object *obj;
+	struct acpi_buffer input = {input_size, input_buffer};
+	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
+	int ret;
+
+	ret = wmi_evaluate_method(HP_WMI_SET_BIOS_SETTING_GUID, 0, 1, &input, &output);
+
+	obj = output.pointer;
+	if (!obj)
+		return -EINVAL;
+
+	if (obj->type != ACPI_TYPE_INTEGER) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	ret = obj->integer.value;
+	if (ret) {
+		if (ret != INVALID_CMD_VALUE && ret != INVALID_CMD_TYPE)
+			hp_wmi_error_and_message(ret);
+		goto out_free;
+	}
+
+out_free:
+	kfree(obj);
+	return ret;
+}
+
+static int hp_attr_set_interface_probe(struct wmi_device *wdev, const void *context)
+{
+	mutex_lock(&bioscfg_drv.mutex);
+	bioscfg_drv.bios_attr_wdev = wdev;
+	mutex_unlock(&bioscfg_drv.mutex);
+	return 0;
+}
+
+static void hp_attr_set_interface_remove(struct wmi_device *wdev)
+{
+	mutex_lock(&bioscfg_drv.mutex);
+	bioscfg_drv.bios_attr_wdev = NULL;
+	mutex_unlock(&bioscfg_drv.mutex);
+}
+
+static const struct wmi_device_id hp_attr_set_interface_id_table[] = {
+	{ .guid_string = HP_WMI_BIOS_GUID},
+	{ }
+};
+
+static struct wmi_driver hp_attr_set_interface_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+	},
+	.probe = hp_attr_set_interface_probe,
+	.remove = hp_attr_set_interface_remove,
+	.id_table = hp_attr_set_interface_id_table,
+};
+
+int hp_init_attr_set_interface(void)
+{
+	return wmi_driver_register(&hp_attr_set_interface_driver);
+}
+
+void hp_exit_attr_set_interface(void)
+{
+	wmi_driver_unregister(&hp_attr_set_interface_driver);
+}
+
+MODULE_DEVICE_TABLE(wmi, hp_attr_set_interface_id_table);
-- 
2.34.1

