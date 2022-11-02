Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A02A615BD6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 06:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiKBFbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 01:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiKBFbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 01:31:34 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CA026AF5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 22:31:33 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id b29so15418934pfp.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 22:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xiaomi-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KnnWJUQR4WDFYSEVJOeb/AO0+nVi5JMMZzph+rKzO8=;
        b=Ili2CV5SsdGAU0DKycsDSvgnj4jxXon4R8VUfUMNqjSEeFu1e3EhhyuwPneWNxcRjb
         25ThIBZ6aprOLc+BSiIej1fJt7i+Uoy+AQ9p0u4ttY9WA49iCRxRfTeVyWoLGeR2O6US
         gwKs9gvLGQHEm7sLuOsO2T3APJ60DF3op7L1B1SQi89d7qxJk1VFuNCK8OHPOoelOStY
         36KhoDagA2R/nBujDyxQ4yOulR6vGhZanMzRILHJv2iErClFUvgrqarfenfii/iqHFSD
         bSUDV0bdcRoj+G8BH+rpI7mYgR5fyXGFSQs7Ooop2mTnZfl35JDSM4VBzgt8SMUBBEyh
         HQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KnnWJUQR4WDFYSEVJOeb/AO0+nVi5JMMZzph+rKzO8=;
        b=22LVEJL7mKtswfXOCvYMyorHfg73M5aKR1OJpM1EOxw2y+iXB6J+mT/Qov12dyi4w5
         1lDq/u0zbFCriX2tiPf2XcY9oaclZ86ZrKItR/V1aYTgOxBF3nOT03A8AW8HAHqToJks
         q2liYFEi4W9T6tTUKYBdIprkwVrFZ62UYBYW8pN4M+zb0azBbMTOO8Tndjao7hVDriYy
         IL7guA2zeB6q1LivnI9Gq+mcKOsyqENtb6xsUeEul+qPnie/FtNTHWRYbcIWvGSFd/tT
         Cdyak0ddjWUfV2FJBKD4z1cxoHpfYObQ53AeO2AniYyt2e1pS6qAZyD5So7GuaWovYdv
         oRTg==
X-Gm-Message-State: ACrzQf2YdEOylRbpfhsF0jlgcEyV6OlvIIihXrzW/dEpV3l05JW3OdTz
        7bUCM0e+1imwSr/ADOBWZEBWGg==
X-Google-Smtp-Source: AMsMyM5iFuvBSKEL8IFoxmPWVVyNjj7z+y9N524ofOHMV4ncdiVHeTpPuc+X1kHxXd+SWANxRY88ng==
X-Received: by 2002:a63:fb0b:0:b0:46f:a98b:5685 with SMTP id o11-20020a63fb0b000000b0046fa98b5685mr14944691pgh.393.1667367093189;
        Tue, 01 Nov 2022 22:31:33 -0700 (PDT)
Received: from ubuntu18.mioffice.cn ([2408:8607:1b00:7:9e7b:efff:fe41:a22a])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902e80a00b00186b69157ecsm7276367plg.202.2022.11.01.22.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 22:31:32 -0700 (PDT)
From:   Jiaming Li <lijiaming3@xiaomi.corp-partner.google.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijiaming3 <lijiaming3@xiaomi.com>
Subject: [RESEND PATCH 2/4] scsi:ufs:add File-Based Optimization descriptor
Date:   Wed,  2 Nov 2022 13:30:56 +0800
Message-Id: <20221102053058.21021-3-lijiaming3@xiaomi.corp-partner.google.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102053058.21021-1-lijiaming3@xiaomi.corp-partner.google.com>
References: <20221102053058.21021-1-lijiaming3@xiaomi.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lijiaming3 <lijiaming3@xiaomi.com>

The full information about the descriptor could be found
at UFS specifications - FBO extension.

Signed-off-by: lijiaming3 <lijiaming3@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-driver-ufs | 65 ++++++++++++++++++++++
 drivers/ufs/core/ufs-sysfs.c               | 26 +++++++++
 include/ufs/ufs.h                          | 13 +++++
 3 files changed, 104 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index 228aa43e14ed..63daccbf7a8d 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -1710,3 +1710,68 @@ Contact:	Avri Altman <avri.altman@wdc.com>
 Description:	In host control mode the host is the originator of map requests.
 		To avoid flooding the device with map requests, use a simple throttling
 		mechanism that limits the number of inflight map requests.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/fbo_descriptor/fbo_version
+What:		/sys/bus/platform/devices/*.ufs/fbo_descriptor/fbo_version
+Date:		November 2022
+Contact:	li jiaming <lijiaming3@xiaomi.com>
+Description:	This file shows the version of UFS file-based optimization. This
+		is one of the UFS fbo descriptor parameters. The full information about
+		the descriptor could be found at UFS specifications - FBO extension.
+
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/fbo_descriptor/fbo_rec_lrs
+What:		/sys/bus/platform/devices/*.ufs/fbo_descriptor/fbo_rec_lrs
+Date:		November 2022
+Contact:	li jiaming <lijiaming3@xiaomi.com>
+Description:	This file shows the recommended LBA range size of UFS file-based
+		optimization to be used by the host. This is one of the UFS fbo descriptor
+		parameters. The full information about the descriptor could be found at UFS
+		specifications - FBO extension.
+
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/fbo_descriptor/fbo_max_lrs
+What:		/sys/bus/platform/devices/*.ufs/fbo_descriptor/fbo_max_lrs
+Date:		November 2022
+Contact:	li jiaming <lijiaming3@xiaomi.com>
+Description:	This file shows the max LBA range size of UFS file-based
+		optimization to be used by the host. This is one of the UFS fbo descriptor
+		parameters. The full information about the descriptor could be found at UFS
+		specifications - FBO extension.
+
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/fbo_descriptor/fbo_min_lrs
+What:		/sys/bus/platform/devices/*.ufs/fbo_descriptor/fbo_min_lrs
+Date:		November 2022
+Contact:	li jiaming <lijiaming3@xiaomi.com>
+Description:	This file shows the min LBA range size of UFS file-based
+		optimization to be used by the host. This is one of the UFS fbo descriptor
+		parameters. The full information about the descriptor could be found at UFS
+		specifications - FBO extension.
+
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/fbo_descriptor/fbo_max_lrc
+What:		/sys/bus/platform/devices/*.ufs/fbo_descriptor/fbo_max_lrc
+Date:		November 2022
+Contact:	li jiaming <lijiaming3@xiaomi.com>
+Description:	This file shows the max number of LBA ranges supported by read/write
+		buffer command of UFS file-based optimization. This is one of the UFS fbo
+		descriptor parameters. The full information about the descriptor could be
+		found at UFS specifications - FBO extension.
+
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/fbo_descriptor/fbo_lra
+What:		/sys/bus/platform/devices/*.ufs/fbo_descriptor/fbo_lra
+Date:		November 2022
+Contact:	li jiaming <lijiaming3@xiaomi.com>
+Description:	This file shows the alignment requirement of UFS file-based
+		optimization. This is one of the UFS fbo descriptor parameters. The
+		full information about the descriptor could be found at UFS
+		specifications - FBO extension.
+
+		The file is read only.
diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index 53aea56d1de1..006d99b15be0 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -871,6 +871,31 @@ static const struct attribute_group ufs_sysfs_health_descriptor_group = {
 	.attrs = ufs_sysfs_health_descriptor,
 };
 
+#define UFS_FBO_DESC_PARAM(_name, _uname, _size)			\
+	UFS_DESC_PARAM(_name, _uname, FBO, _size)
+
+UFS_FBO_DESC_PARAM(fbo_version, _VERSION, 2);
+UFS_FBO_DESC_PARAM(fbo_rec_lrs, _REC_LBA_RANGE_SIZE, 4);
+UFS_FBO_DESC_PARAM(fbo_max_lrs, _MAX_LBA_RANGE_SIZE, 4);
+UFS_FBO_DESC_PARAM(fbo_min_lrs, _MIN_LBA_RANGE_SIZE, 4);
+UFS_FBO_DESC_PARAM(fbo_max_lrc, _MAX_LBA_RANGE_CONUT, 1);
+UFS_FBO_DESC_PARAM(fbo_lra, _MAX_LBA_RANGE_ALIGNMENT, 2);
+
+static struct attribute *ufs_sysfs_fbo_descriptor[] = {
+	&dev_attr_fbo_version.attr,
+	&dev_attr_fbo_rec_lrs.attr,
+	&dev_attr_fbo_max_lrs.attr,
+	&dev_attr_fbo_min_lrs.attr,
+	&dev_attr_fbo_max_lrc.attr,
+	&dev_attr_fbo_lra.attr,
+	NULL,
+};
+
+static const struct attribute_group ufs_sysfs_fbo_descriptor_group = {
+	.name = "fbo_descriptor",
+	.attrs = ufs_sysfs_fbo_descriptor,
+};
+
 #define UFS_POWER_DESC_PARAM(_name, _uname, _index)			\
 static ssize_t _name##_index##_show(struct device *dev,			\
 	struct device_attribute *attr, char *buf)			\
@@ -1220,6 +1245,7 @@ static const struct attribute_group *ufs_sysfs_groups[] = {
 	&ufs_sysfs_interconnect_descriptor_group,
 	&ufs_sysfs_geometry_descriptor_group,
 	&ufs_sysfs_health_descriptor_group,
+	&ufs_sysfs_fbo_descriptor_group,
 	&ufs_sysfs_power_descriptor_group,
 	&ufs_sysfs_string_descriptors_group,
 	&ufs_sysfs_flags_group,
diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
index 1bba3fead2ce..c3fd954ce005 100644
--- a/include/ufs/ufs.h
+++ b/include/ufs/ufs.h
@@ -179,6 +179,7 @@ enum desc_idn {
 	QUERY_DESC_IDN_GEOMETRY		= 0x7,
 	QUERY_DESC_IDN_POWER		= 0x8,
 	QUERY_DESC_IDN_HEALTH           = 0x9,
+	QUERY_DESC_IDN_FBO		= 0xA,
 	QUERY_DESC_IDN_MAX,
 };
 
@@ -319,6 +320,17 @@ enum health_desc_param {
 	HEALTH_DESC_PARAM_LIFE_TIME_EST_B	= 0x4,
 };
 
+/* File-based Optimization descriptor parameters offsets in bytes */
+enum fbo_desc_param {
+	FBO_DESC_PARAM_LEN			= 0x0,
+	FBO_DESC_PARAM_VERSION			= 0x1,
+	FBO_DESC_PARAM_REC_LBA_RANGE_SIZE	= 0x3,
+	FBO_DESC_PARAM_MAX_LBA_RANGE_SIZE	= 0x7,
+	FBO_DESC_PARAM_MIN_LBA_RANGE_SIZE	= 0xB,
+	FBO_DESC_PARAM_MAX_LBA_RANGE_CONUT	= 0xF,
+	FBO_DESC_PARAM_MAX_LBA_RANGE_ALIGNMENT	= 0x10,
+};
+
 /* WriteBooster buffer mode */
 enum {
 	WB_BUF_MODE_LU_DEDICATED	= 0x0,
@@ -352,6 +364,7 @@ enum {
 	UFS_DEV_EXT_TEMP_NOTIF		= BIT(6),
 	UFS_DEV_HPB_SUPPORT		= BIT(7),
 	UFS_DEV_WRITE_BOOSTER_SUP	= BIT(8),
+	UFS_DEV_FBO_SUP			= BIT(17),
 };
 #define UFS_DEV_HPB_SUPPORT_VERSION		0x310
 
-- 
2.38.1

