Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6F069BA34
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 14:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjBRNU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 08:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjBRNUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 08:20:55 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C3F1968D;
        Sat, 18 Feb 2023 05:20:54 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id 19so750084plo.7;
        Sat, 18 Feb 2023 05:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DV93rUPqERTzCGzgF+Nyoaubtpk03qL36hyj85V+RLA=;
        b=KA/EY+98GP20sHiGHDsgKCCYvqBnXkPPOBIZxF6NB78aXWWIpH5MWuseuao1oqew6L
         E7WmnieEoombFqBZU3btW8QK4vbpSFiwVQfGm4OB+tUNC5xicpQEFdcMIpnEYUNQTWAf
         B0Nt7klX04OhPmxwrsBbfCqVH+9uRe9Mg3wmqxPaA38O2cEIpowOH9fQl2qeW6wX+sNd
         49OGJY7ivMJI+ck4MNiQ2k5ajrEk8xQViKbEwi7EICK+JR0XfhK2oyyHFjQTAiLhF88t
         T30X8LKfzmhGaZAqAQ+nGMIvbNDSS+Cp9UJ2Xnqv+2a5BgakMTFTav/0wePzHD840B2f
         636w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DV93rUPqERTzCGzgF+Nyoaubtpk03qL36hyj85V+RLA=;
        b=Bs3PH854BVyZ8Y5RPg4ttqF3zVfaDbrDmnAz0xEbDtTbnXLtBV5dEjZhQ515+m7v4e
         r3pAaGcaNphF5IhjIkDytVo0H9oT7A7QfyWJulhorWPbtVXye7jfo+xsjiuXH8fbMLCa
         n4lGnO9O6nj0enhzFrCm69M+Sh3y9cbFV13audqEHL3LdcAmBg+Lhsabi+mC/jSAwhgf
         hGmyWsHj0IJpByCLE24AlE2Hm4yHnl23nEN584WtwtZhEXYnV83zObiTQDftGwg93egl
         4jBJ+fMdxxmgFdtOZ62ZRv0PkyRTZ+2pu+V4XHQYCKLMeGyFvabwDgvRG+CS1MMl7YSM
         UZhg==
X-Gm-Message-State: AO0yUKW/zsKL07y1u12MuzPBaT+2PXx7wvUDX8vIZ+PyuPzmMxN7O7Qo
        p3Yc+s/whMaQHK4inP1VV0s=
X-Google-Smtp-Source: AK7set/bM2vLZGaeUiVgMOOszovguu9KlevXt8hDj8+lIN3R8WzAywv4emrtHGN6RLiCjFsErfbB9Q==
X-Received: by 2002:a05:6a20:9390:b0:c7:7c12:638e with SMTP id x16-20020a056a20939000b000c77c12638emr5303286pzh.9.1676726453840;
        Sat, 18 Feb 2023 05:20:53 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id v19-20020aa78093000000b0058e24050648sm4769448pff.12.2023.02.18.05.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 05:20:53 -0800 (PST)
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
Subject: [PATCH v3 3/5] apple-gmux: Use GMSP acpi method for interrupt clear
Date:   Sun, 19 Feb 2023 00:20:05 +1100
Message-Id: <20230218132007.3350-4-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230218132007.3350-1-orlandoch.dev@gmail.com>
References: <20230218132007.3350-1-orlandoch.dev@gmail.com>
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
v2->v3: remove status != 0 check
 drivers/platform/x86/apple-gmux.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 36208e93d745..8dfa1c02be64 100644
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
@@ -537,6 +561,8 @@ static void gmux_clear_interrupts(struct apple_gmux_data *gmux_data)
 	/* to clear interrupts write back current status */
 	status = gmux_interrupt_get_status(gmux_data);
 	gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_STATUS, status);
+	if (gmux_data->config->use_acpi_gmsp)
+		gmux_call_acpi_gmsp(gmux_data, 0);
 }
 
 static void gmux_notify_handler(acpi_handle device, u32 value, void *context)
-- 
2.39.1

