Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C877699446
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjBPMZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjBPMZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:25:38 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB545776D;
        Thu, 16 Feb 2023 04:25:30 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id n2so1345727pfo.3;
        Thu, 16 Feb 2023 04:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Am8BGSEip5nNE8Zh0hm60KhhWsRjuiVkZed/6iLfSSg=;
        b=kuj5ZFPccKNgGnLvhSCdjjLGRHp/Cg168G+FmzCHapcrrSBsK3Zq2++X4KBN/kfm2N
         /YvqnFNfz8wJq8hQUrRRx0qDaQ9e4Ix/LnT2/oD+P6L9iDzb4nS/q0JD7HxyjYvKeksL
         brv5h9SOUs/hfcUBWzikgIBVekWlqRnR3jK1XCC59m/1Seon8DSfXHvzPn5RhLZU2Wcs
         ag9Fg+2U4RX4jkrm3jNql2ihlc3eN6CTD1wvVWv3I+JllMKVAg5YaXHtEs2NT7Jp/9tm
         AUoF8g9dNGGJUfraAGSG0M4WJnqrt13qgU2lgPX5RHrjeS7Ok5frtdfoqVoyEsSyq8mL
         QRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Am8BGSEip5nNE8Zh0hm60KhhWsRjuiVkZed/6iLfSSg=;
        b=ee30K0aBXI6gdfGrDc+nBUKNKKC9tnDY1Q0xNX1VhiLIwltRy5cI6jJXrxzTUDlUf2
         mJc/w265f6Db6iDltxCvAS/g25XslJ9tRHhPaqpdOz45T4cOOMQckO5AZtZFnPF0wz+c
         S/Imhz8BCradViYHEGBryHfZyhCxnXDzE1zDPSiXNPonbu3FjZfQDN7se9S8kILkCww6
         VqW+kK12b6Vfdp6c1HeWZoWoX57lobcKVoksd8R4p5n2xumfQ/mK3+xKqChE2IbGuDsX
         vUebPL51xsUZZhDCQD+xHujehHl9VEDIKImMgOazr2zsg+wArpT2bPhKg25ExybU+DZY
         LoSw==
X-Gm-Message-State: AO0yUKUUQ867heqLs/ixiyBSkZ68P9Oq3MtjhZiRDPr+n6UomfhkGjF+
        YPwZ8piwnzpJCLRnfE2us5s=
X-Google-Smtp-Source: AK7set8ACMHQ+CoNxkDCXmloap5SGqUHHlZGmEKH5vb6gpD3darU63R9nZVjDqKoybEsBzYbjR4Xiw==
X-Received: by 2002:aa7:978e:0:b0:592:5276:95df with SMTP id o14-20020aa7978e000000b00592527695dfmr4534640pfp.2.1676550329599;
        Thu, 16 Feb 2023 04:25:29 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id c10-20020aa781ca000000b005a909290425sm1224055pfn.172.2023.02.16.04.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 04:25:29 -0800 (PST)
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
Subject: [PATCH v2 5/5] apple-gmux: add debugfs interface
Date:   Thu, 16 Feb 2023 23:23:43 +1100
Message-Id: <20230216122342.5918-6-orlandoch.dev@gmail.com>
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

Allow reading and writing gmux ports from userspace.

For example:

echo 4 > /sys/kernel/debug/apple_gmux/selected_port
cat /sys/kernel/debug/apple_gmux/selected_port_data | xxd -p

Will show the gmux version information (00000005 in this case)

Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
---
v1->v2: Use debugfs instead of sysfs.
 drivers/platform/x86/apple-gmux.c | 88 +++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 5bac6dcfada0..e8a35d98b113 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -22,6 +22,7 @@
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/vga_switcheroo.h>
+#include <linux/debugfs.h>
 #include <asm/io.h>
 
 /**
@@ -66,6 +67,10 @@ struct apple_gmux_data {
 	enum vga_switcheroo_client_id switch_state_external;
 	enum vga_switcheroo_state power_state;
 	struct completion powerchange_done;
+
+	/* debugfs data */
+	u8 selected_port;
+	struct dentry *debug_dentry;
 };
 
 static struct apple_gmux_data *apple_gmux_data;
@@ -674,6 +679,87 @@ static void gmux_notify_handler(acpi_handle device, u32 value, void *context)
 		complete(&gmux_data->powerchange_done);
 }
 
+/**
+ * DOC: Debugfs Interface
+ *
+ * gmux ports can be accessed from userspace as a debugfs interface. For example:
+ *
+ * # echo 4 > /sys/kernel/debug/apple_gmux/selected_port
+ * # cat /sys/kernel/debug/apple_gmux/selected_port_data | xxd -p
+ * 00000005
+ *
+ * Reads 4 bytes from port 4 (GMUX_PORT_VERSION_MAJOR).
+ *
+ * 1 and 4 byte writes are also allowed.
+ */
+
+static ssize_t gmux_selected_port_data_write(struct file *file,
+		const char __user *userbuf, size_t count, loff_t *ppos)
+{
+	struct apple_gmux_data *gmux_data = file->private_data;
+	int ret;
+
+	if (*ppos)
+		return -EINVAL;
+
+	if (count == 1) {
+		u8 data;
+
+		ret = copy_from_user(&data, userbuf, 1);
+		if (ret)
+			return ret;
+		gmux_write8(gmux_data, gmux_data->selected_port, data);
+	} else if (count == 4) {
+		u32 data;
+
+		ret = copy_from_user(&data, userbuf, 4);
+		if (ret)
+			return ret;
+		gmux_write32(gmux_data, gmux_data->selected_port, data);
+	} else
+		return -EINVAL;
+
+	return count;
+}
+
+static ssize_t gmux_selected_port_data_read(struct file *file,
+		char __user *userbuf, size_t count, loff_t *ppos)
+{
+	struct apple_gmux_data *gmux_data = file->private_data;
+	u32 data;
+
+	data = gmux_read32(gmux_data, gmux_data->selected_port);
+
+	return simple_read_from_buffer(userbuf, count, ppos, &data, sizeof(data));
+}
+
+static const struct file_operations gmux_port_data_ops = {
+	.open = simple_open,
+	.write = gmux_selected_port_data_write,
+	.read = gmux_selected_port_data_read
+};
+
+static void gmux_init_debugfs(struct apple_gmux_data *gmux_data)
+{
+	struct dentry *debug_dentry;
+
+	debug_dentry = debugfs_create_dir(KBUILD_MODNAME, NULL);
+
+	if (IS_ERR(debug_dentry))
+		return;
+
+	gmux_data->debug_dentry = debug_dentry;
+
+	debugfs_create_u8("selected_port", 0644, debug_dentry, &gmux_data->selected_port);
+	debugfs_create_file("selected_port_data", 0644, debug_dentry,
+			gmux_data, &gmux_port_data_ops);
+}
+
+static void gmux_fini_debugfs(struct apple_gmux_data *gmux_data)
+{
+	debugfs_remove_recursive(gmux_data->debug_dentry);
+}
+
 static int gmux_suspend(struct device *dev)
 {
 	struct pnp_dev *pnp = to_pnp_dev(dev);
@@ -874,6 +960,7 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 		goto err_register_handler;
 	}
 
+	gmux_init_debugfs(gmux_data);
 	return 0;
 
 err_register_handler:
@@ -905,6 +992,7 @@ static void gmux_remove(struct pnp_dev *pnp)
 {
 	struct apple_gmux_data *gmux_data = pnp_get_drvdata(pnp);
 
+	gmux_fini_debugfs(gmux_data);
 	vga_switcheroo_unregister_handler();
 	gmux_disable_interrupts(gmux_data);
 	if (gmux_data->gpe >= 0) {
-- 
2.39.1

