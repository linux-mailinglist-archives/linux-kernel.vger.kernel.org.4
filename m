Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2C469BA39
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 14:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjBRNV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 08:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjBRNVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 08:21:25 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B451ABEE;
        Sat, 18 Feb 2023 05:21:02 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id t15so746064plg.6;
        Sat, 18 Feb 2023 05:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azOKFY8r4ZFN0TrySiezIiphodtx+QxBgOOIAouGT3U=;
        b=MnJA+KLdTx4gr6/1UI87VTaCM/r/SCkxaid7ehbgvA2XdJbatfS8WtigKdgPjirBux
         zt6CqL+N0rE10MK51ntQNMSqRmETKowp7/avz6bMn5o8SFfePnPnbhTifQoNt/iYDyWK
         XjuFwzO2vJHJ+zCwbUZp7JoMN3HNRBQeBxyS9qBOvsoqLeSXSX1vhooGO9wgoiMp8qbz
         8TWKSSbfrZboDA886/cD8MhhggUsxdoeWLEWa1K/OkeqbpxTa61ssRF5ykCNIcNeaZeb
         oNMv/8pG7C2f463Nt8Tjha0x3OGzhmnqU3sAS81R9k8emfW4ms1SP0rYwhE96PfHG/jo
         aEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azOKFY8r4ZFN0TrySiezIiphodtx+QxBgOOIAouGT3U=;
        b=Uze9lxrC6/bwTFd9R5CrP/ZjYdWfplsL563m13+gOv+YoNn/sGQkJCUudwS7YxlxLc
         tOhBaAGc6DLr2PJNWbFqkB53yE4jFBziPqI0qlO8Q2qaXIp5scnt1LjQZj1CajhyWMOT
         QT4FLNT9xh/ktSm9HhTdErg0mEMYgJx1/B0tXu7Tf0C460Zcniwc8XuZoEarTtFxUCH/
         nUG3kMRIvO9+duqYtTvcSR3WIJyxFV5WHG3qQ9eDgbbu6sLrjJEbYo02ElATrGluWk3A
         pmU4rX7oz3B68HWf1xBeXMd7l5K4z1fBXuuuQyS8nPUSBnpUxmcXhC9WJUgFqBYhv50r
         CtuQ==
X-Gm-Message-State: AO0yUKXA5lqYd2GH1XQ+aeLze4q42UC7OlJwFYXqC25aAL9CZ40bfP5P
        IbFsekQ+e2Xh3Zx7XOVGLZA=
X-Google-Smtp-Source: AK7set87id1WVpQZurYteFJVdAd+GwKFsyIlbtAXj7tEbjColPRwPc6X8uMszpcrNoC7WD3jObruBw==
X-Received: by 2002:a05:6a20:8f0e:b0:bc:8b91:69a3 with SMTP id b14-20020a056a208f0e00b000bc8b9169a3mr4237797pzk.46.1676726461649;
        Sat, 18 Feb 2023 05:21:01 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id v19-20020aa78093000000b0058e24050648sm4769448pff.12.2023.02.18.05.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 05:21:01 -0800 (PST)
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
Subject: [PATCH v3 5/5] apple-gmux: add debugfs interface
Date:   Sun, 19 Feb 2023 00:20:07 +1100
Message-Id: <20230218132007.3350-6-orlandoch.dev@gmail.com>
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

Allow reading and writing gmux ports from userspace.

For example:

echo 4 > /sys/kernel/debug/apple_gmux/selected_port
cat /sys/kernel/debug/apple_gmux/selected_port_data | xxd -p

Will show the gmux version information (00000005 in this case)

Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
---
v2->v3: don't check if the folder failed to be created
 drivers/platform/x86/apple-gmux.c | 82 +++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 01e7b1939916..4cbdc9f9bd10 100644
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
@@ -672,6 +677,81 @@ static void gmux_notify_handler(acpi_handle device, u32 value, void *context)
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
+	gmux_data->debug_dentry = debugfs_create_dir(KBUILD_MODNAME, NULL);
+
+	debugfs_create_u8("selected_port", 0644, gmux_data->debug_dentry,
+			&gmux_data->selected_port);
+	debugfs_create_file("selected_port_data", 0644, gmux_data->debug_dentry,
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
@@ -872,6 +952,7 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 		goto err_register_handler;
 	}
 
+	gmux_init_debugfs(gmux_data);
 	return 0;
 
 err_register_handler:
@@ -903,6 +984,7 @@ static void gmux_remove(struct pnp_dev *pnp)
 {
 	struct apple_gmux_data *gmux_data = pnp_get_drvdata(pnp);
 
+	gmux_fini_debugfs(gmux_data);
 	vga_switcheroo_unregister_handler();
 	gmux_disable_interrupts(gmux_data);
 	if (gmux_data->gpe >= 0) {
-- 
2.39.1

