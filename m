Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DCF699442
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjBPMZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjBPMZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:25:23 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439A92D150;
        Thu, 16 Feb 2023 04:25:22 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id ja21so1814624plb.13;
        Thu, 16 Feb 2023 04:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cV5gSZbAk+OK4o2s0sGW4RLDMGE24woGtYndT0R/1so=;
        b=aiP8Gui+ZfrGDh/k74j4XykYop7KbIq6K+9dHNcBJ0e+9iMDfxlkDF+31txhH6GLxY
         iQujF3TsQgE9ve0hvj0GX+bF+ncNsIDFx18qNQfm0S+ldzG341W17q1pm+IvCghRNzWp
         KzTDhMWO6WTO9ooW8CKJfo/yC5ESUD76658oGpEPXHQLq/6EdwktEyvZK1nxEhg//rcz
         vHiJmUOdBI41ZxL2PTrJtkDcMkQMnVme7poxaq/UEFjLiPGVHiI59LBQgiCe+f/jWRXj
         zUpo7snaDK81yK5vlTWoB5LccLGcIGN1o4DTGA9E3wzidcJTOBA1m98HB67zw47jlx9I
         PcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cV5gSZbAk+OK4o2s0sGW4RLDMGE24woGtYndT0R/1so=;
        b=QNxKU6QtCZjzXXUxeQv01w8/RpJad2GXtGylldod60HdCmjWKYBPBHpl77Wf9r0kUK
         sL41XVnyndxbBost1YdKcjoQFUcbuU7/snH4HHosTS35/ZE/7RX5VASZD9vXLU9BJBeU
         4M94OVTxKUju8Cme6qWJbptGtuEBtFj4eyQZnCyGWSZVJXYEJikaYjH7cgF6DqZnHfMo
         LVKJuS2BT8sW2LUtUXAvfNv4tESQwYYOksDhZUZyOVmJCP4nsRiAI995A3muHbXkVVRe
         tuQlwZsR7DARHctKgFaVl/7UjU2rJ0CwdvLhbA39xtGUuhaHITvoteTYKgHR16xSSfMv
         rsnQ==
X-Gm-Message-State: AO0yUKUgoHt0bX41HYdOAmBjE7bYdKIuUPUFWM9Nt4q+tNGn4scGyTrA
        f+RGQ4i4YHE/hUDAj83KA8w=
X-Google-Smtp-Source: AK7set8lgQgTFHuQOU93piNNIhJaCFNr7hD2gq6r1xOtJXC06dAh6skYAl6RED7PEyRPsFVWpDbdMw==
X-Received: by 2002:a05:6a20:728f:b0:bc:ce49:798d with SMTP id o15-20020a056a20728f00b000bcce49798dmr6571360pzk.41.1676550321820;
        Thu, 16 Feb 2023 04:25:21 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id c10-20020aa781ca000000b005a909290425sm1224055pfn.172.2023.02.16.04.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 04:25:21 -0800 (PST)
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Seth Forshee <sforshee@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: [PATCH v2 3/5] apple-gmux: Use GMSP acpi method for interrupt clear
Date:   Thu, 16 Feb 2023 23:23:41 +1100
Message-Id: <20230216122342.5918-4-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230216122342.5918-1-orlandoch.dev@gmail.com>
References: <20230216122342.5918-1-orlandoch.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed for interrupts to be cleared correctly on MMIO based
gmux's. It is untested if this helps/hinders other gmux types, so
currently this is only enabled for the MMIO gmux's.

There is also a "GMLV" acpi method, and the "GMSP" method can be called
with 1 as its argument, but the purposes of these aren't known and they
don't seem to be needed.

Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
---
v1->v2: Only enable this on MMIO gmux's
 drivers/platform/x86/apple-gmux.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 36208e93d745..12a93fc49c36 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -76,6 +76,7 @@ struct apple_gmux_config {
 	enum vga_switcheroo_handler_flags_t handler_flags;
 	unsigned long resource_type;
 	bool read_version_as_u32;
+	bool use_acpi_gmsp;
 	char *name;
 };
 
@@ -488,6 +489,7 @@ static const struct apple_gmux_config apple_gmux_pio = {
 	.handler_flags = VGA_SWITCHEROO_CAN_SWITCH_DDC,
 	.resource_type = IORESOURCE_IO,
 	.read_version_as_u32 = false,
+	.use_acpi_gmsp = false,
 	.name = "classic"
 };
 
@@ -500,6 +502,7 @@ static const struct apple_gmux_config apple_gmux_index = {
 	.handler_flags = VGA_SWITCHEROO_NEEDS_EDP_CONFIG,
 	.resource_type = IORESOURCE_IO,
 	.read_version_as_u32 = true,
+	.use_acpi_gmsp = false,
 	.name = "indexed"
 };
 
@@ -511,8 +514,29 @@ static const struct apple_gmux_config apple_gmux_index = {
  * MCP79, on all following generations it's GPIO pin 6 of the Intel PCH.
  * The GPE merely signals that an interrupt occurred, the actual type of event
  * is identified by reading a gmux register.
+ *
+ * On MMIO gmux's, we also need to call the acpi method GMSP to properly clear
+ * interrupts.
  */
 
+static int gmux_call_acpi_gmsp(struct apple_gmux_data *gmux_data, int arg)
+{
+	acpi_status status = AE_OK;
+	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
+	struct acpi_object_list arg_list = { 1, &arg0 };
+
+	arg0.integer.value = arg;
+
+	status = acpi_evaluate_object(gmux_data->dhandle, "GMSP", &arg_list, NULL);
+	if (ACPI_FAILURE(status)) {
+		pr_err("GMSP call failed: %s\n",
+		       acpi_format_exception(status));
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 static inline void gmux_disable_interrupts(struct apple_gmux_data *gmux_data)
 {
 	gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_ENABLE,
@@ -536,7 +560,11 @@ static void gmux_clear_interrupts(struct apple_gmux_data *gmux_data)
 
 	/* to clear interrupts write back current status */
 	status = gmux_interrupt_get_status(gmux_data);
-	gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_STATUS, status);
+	if (status) {
+		gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_STATUS, status);
+		if (gmux_data->config->use_acpi_gmsp)
+			gmux_call_acpi_gmsp(gmux_data, 0);
+	}
 }
 
 static void gmux_notify_handler(acpi_handle device, u32 value, void *context)
-- 
2.39.1

