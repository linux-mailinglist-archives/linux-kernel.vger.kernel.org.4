Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE0E615BD9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 06:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiKBFbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 01:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKBFbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 01:31:40 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256E527145
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 22:31:38 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y13so15451154pfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 22:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xiaomi-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDHE6t3UxgVbbxIruEWL1ehqThIK+KLXLQWZKh+uV0Q=;
        b=4iAm+JQWM7i0hJ0Ytlz2hDejZRPKk89vBrqcwpvUhuIHeZrjRl20QqxE0Z6jcsW4VM
         7yJqw4A8XhBiPB3O8h4sqVp7gboNAY7/LAAsB7EZ6TXTHTicf3qsNDEVVNRNH+s/1X6c
         R6T72avhP46cRgd203cj+xj1oXBAVAWaOc7ySsF78wa2NEpgZ9YqDyqygYAPp0+hVNIi
         ioVCh8TWAI/He6tjBkUNFPt0jp9BVDO38HWyICxvUBQEVu/HaokcznvEVXUpSxv5brGT
         FmB2ve96quvc3mJuVfNOFXdPsQIG+P2ZPat0DZxWbrzlCYgaGPBHJlVEsf3wley40d1T
         hrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDHE6t3UxgVbbxIruEWL1ehqThIK+KLXLQWZKh+uV0Q=;
        b=G1Ox/f+P6nMXYdJxwjrJGShCnlsuuUKlQS6cCy0P9FjK6DpO5QAxER5JvggftTzBaZ
         lpOn2MyLz7BZSPAn6uBTb8eUp+2zgwNmXUpm2tSpeMMxlWJ/J14sDUocnw/sK3/vKfll
         fBVDX+OD8qLCs8WNLjK5nIPfCu6CFDh/NOJCgOJGzfcIPkIsXWIEFw3BzI/sQicpc/Q6
         8pIg7LHE2fPJrjZWZRTtjTMad4Zk1B9g+13zBp7QhkCMacw6ahCV2n7sghstubSdjjrz
         H8307UBBQlmd0ukGbF4NLMtyq66E2uNX+TOkZBnbBGbgICrHSA7Zm/16RsdiHlF0ULdO
         lQXA==
X-Gm-Message-State: ACrzQf2Pe+LfgxZy3LYFQFBoTIK0fQsgi0eEuyxUDIffS7BKnCzX3dsu
        5RO1pFhYfMbMhCCFDsmAo1GIpQ==
X-Google-Smtp-Source: AMsMyM47c20eDGyI561r1pO/Lp2twkNvjbITsK4SV5xNqHCgPiGJdsGTTh8UnRbQ8WSMAEEr6A8M2w==
X-Received: by 2002:a05:6a00:994:b0:56c:fa42:4f46 with SMTP id u20-20020a056a00099400b0056cfa424f46mr23272534pfg.9.1667367097554;
        Tue, 01 Nov 2022 22:31:37 -0700 (PDT)
Received: from ubuntu18.mioffice.cn ([2408:8607:1b00:7:9e7b:efff:fe41:a22a])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902e80a00b00186b69157ecsm7276367plg.202.2022.11.01.22.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 22:31:37 -0700 (PDT)
From:   Jiaming Li <lijiaming3@xiaomi.corp-partner.google.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijiaming3 <lijiaming3@xiaomi.com>
Subject: [RESEND PATCH 4/4] scsi:ufs:add fbo functionality
Date:   Wed,  2 Nov 2022 13:30:58 +0800
Message-Id: <20221102053058.21021-5-lijiaming3@xiaomi.corp-partner.google.com>
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

add fbo analysis and defrag function

We can send LBA info to the device as a comma separated string. Each
adjacent pair represents a range:<open-lba>,<close-lba>.
e.g. The LBA range of the file is 0x1234,0x3456;0x4567,0x5678
	echo 0x1234,0x3456,0x4567,0x5678 > fbo_send_lba

Then you can instrcut the device to analyzes the file info use following
command:
	echo 1 > fbo_operation_ctrl

Use the following cmd to view the fragmentation progress status
	cat fbo_prog_state

After the value of "fbo_prog_state" changes from "1" to "2", it means
the fragment analyzes completed, ust the following cmd to check file's
LBA fragment state
	cat fbo_lba_frag_state

The data format follows the structure specified by spec
	===============================
	00  02  00  00  00  00  00  00
	00  00  12  34  00  22  23  07
	00  00  45  67  00  22  23  00
	===============================

The host then may instruct the device to execute optimization procedure to
improve the regression level
	echo 2 > fbo_operation_ctrl

Use the following cmd to view the fragment optimization status, After the
value of "fbo_prog_state" changes to "3", it means the fragment
optimization completed
	cat fbo_prog_state

Signed-off-by: lijiaming3 <lijiaming3@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-driver-ufs |  64 ++++
 drivers/ufs/core/ufsfbo.c                  | 399 +++++++++++++++++++++
 drivers/ufs/core/ufshcd.c                  |   3 +
 3 files changed, 466 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index 63daccbf7a8d..3792a444d0e2 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -1775,3 +1775,67 @@ Description:	This file shows the alignment requirement of UFS file-based
 		specifications - FBO extension.
 
 		The file is read only.
+
+What:		/sys/class/scsi_device/*/device/fbo_dev_ctrl/fbo_support
+Date:		November 2022
+Contact:	li jiaming <lijiaming3@xiaomi.com>
+Description:	This file shows the support state of UFS file-based optimization.
+
+		The file is read only.
+
+What:		/sys/class/scsi_device/*/device/fbo_dev_ctrl/fbo_prog_state
+Date:		November 2022
+Contact:	li jiaming <lijiaming3@xiaomi.com>
+Description:	This file shows the state of UFS file-based optimization. The
+		current driver implementation supports 5 states:
+
+		==  ====================================================
+		0h   UFS FBO progress state is idle
+		1h   UFS FBO progress state is on-going
+		2h   UFS FBO progress state is complete analysis
+		3h   UFS FBO progress state is complete optimization
+		FF   UFS FBO progress state is general error
+		==  ====================================================
+		The file is read only.
+
+What:		/sys/class/scsi_device/*/device/fbo_dev_ctrl/fbo_operation_ctrl
+Date:		November 2022
+Contact:	li jiaming <lijiaming3@xiaomi.com>
+Description:	This file controls the operation of UFS file-based optimization.
+		Echo different value to this file to make device perform different funcs.
+		The value are as follows
+		==  ==============================================================
+		0h   Device shall stop FBO analysis and FBO optimization operation
+		1h   Start FBO analysis based on the current LBA range
+		2h   Start FBO optimization based on the current LBA range
+		==  ==============================================================
+		The file is write only.
+
+What:		/sys/class/scsi_device/*/device/fbo_dev_ctrl/fbo_exe_threshold
+Date:		November 2022
+Contact:	li jiaming <lijiaming3@xiaomi.com>
+Description:	This file shows and sets the execute level of UFS file-based
+		optimization. It means the device will do optimization operation for
+		the ranges which fragment level equal or greater than this value .The
+		value ranges from 0x0 to 0xA.
+
+What:		/sys/class/scsi_device/*/device/fbo_dev_ctrl/fbo_send_lba
+Date:		November 2022
+Contact:	li jiaming <lijiaming3@xiaomi.com>
+Description:	This file provides an interface for host to send LBA ranges to
+		the device for UFS file-based optimization. First, we obtain the iNode
+		info of the file, which can be used to find out the corresponding block
+		address of the file, then add the offset of each partition to obtain the
+		LBA of the file. We can send LBA info to the device as a comma separated
+		string. Each adjacent pair represents a range:<open-lba>,<close-lba>.
+		e.g. The LBA range of the file is 0x1234,0x3456;0x4567,0x5678
+			echo 0x1234,0x3456,0x4567,0x5678 > fbo_send_lba
+
+		The file is write only.
+
+What:		/sys/class/scsi_device/*/device/fbo_dev_ctrl/fbo_lba_frag_state
+Date:		November 2022
+Contact:	li jiaming <lijiaming3@xiaomi.com>
+Description:	This file provides an interface for host to obtain the LBA
+		ranges fragment state sent by read buffer command of UFS file-based
+		optimization. We should read this info when the FBO analysis is completed
diff --git a/drivers/ufs/core/ufsfbo.c b/drivers/ufs/core/ufsfbo.c
index 81326fd2fb3d..303b7b7f1a2c 100644
--- a/drivers/ufs/core/ufsfbo.c
+++ b/drivers/ufs/core/ufsfbo.c
@@ -14,6 +14,18 @@
 #include <scsi/scsi_device.h>
 #include <asm/unaligned.h>
 
+#define FBO_RW_BUF_HDR_SIZE 4
+#define FBO_RW_ENTRY_SIZE 8
+#define FBO_LBA_RANGE_LENGTH 4096
+
+enum UFSFBO_PROG_STATE {
+	FBO_PROG_IDLE   = 0x0,
+	FBO_PROG_ON_GOING   = 0x1,
+	FBO_PROG_ANALYSIS_COMPLETE  = 0x2,
+	FBO_PROG_OPTIMIZATION_COMPLETE  = 0x3,
+	FBO_PROG_INTERNAL_ERR   = 0xff,
+};
+
 /**
  * struct ufsfbo_dev_info - FBO device related info
  * @fbo_version: UFS file-based optimization Version
@@ -45,6 +57,393 @@ struct ufsfbo_ctrl {
 	int fbo_lba_cnt;
 };
 
+static void ufsfbo_fill_rw_buffer(unsigned char *cdb, int size, u8 opcode)
+{
+	cdb[0] = opcode;
+	cdb[1] = 0x2;
+	cdb[2] = opcode == WRITE_BUFFER ? 0x1 : 0x2;
+	put_unaligned_be24(size, &cdb[6]);
+}
+
+static ssize_t fbo_support_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct ufs_hba *hba = shost_priv(sdev->host);
+	u8 val = 0;
+
+	if (hba->fbo_ctrl)
+		val = 1;
+
+	return sysfs_emit(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(fbo_support);
+
+static int ufsfbo_get_fbo_prog_state(struct ufs_hba *hba, int *prog_state)
+{
+	int ret = 0, attr = -1;
+
+	down(&hba->host_sem);
+	if (!ufshcd_is_user_access_allowed(hba)) {
+		ret = -EBUSY;
+		goto out;
+	}
+	ufshcd_rpm_get_sync(hba);
+	ret = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
+			QUERY_ATTR_IDN_FBO_PROG_STATE, 0, 0, &attr);
+	ufshcd_rpm_put_sync(hba);
+	if (ret) {
+		pr_err("Query attr fbo prog state failed.");
+		goto out;
+	}
+
+	switch (attr) {
+	case 0x0:
+	case 0x1:
+	case 0x2:
+	case 0x3:
+	case 0xff:
+		*prog_state = attr;
+		break;
+	default:
+		pr_info("Unknown fbo prog state attr(%d)", attr);
+		ret = -EINVAL;
+		break;
+	}
+
+out:
+	up(&hba->host_sem);
+	return ret;
+}
+
+static ssize_t fbo_prog_state_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	int fbo_prog_state;
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct ufs_hba *hba = shost_priv(sdev->host);
+
+	if (ufsfbo_get_fbo_prog_state(hba, &fbo_prog_state)) {
+		pr_err("Get fbo prog state failed.");
+		return -EINVAL;
+	}
+
+	return sysfs_emit(buf, "%d\n", fbo_prog_state);
+}
+static DEVICE_ATTR_RO(fbo_prog_state);
+
+static ssize_t fbo_operation_ctrl_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	int ret = 0;
+	u32 val;
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct ufs_hba *hba = shost_priv(sdev->host);
+
+	if (kstrtouint(buf, 0, &val))
+		return -EINVAL;
+
+	down(&hba->host_sem);
+	if (!ufshcd_is_user_access_allowed(hba)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	ufshcd_rpm_get_sync(hba);
+	ret = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
+			QUERY_ATTR_IDN_FBO_CONTROL, 0, 0, &val);
+	ufshcd_rpm_put_sync(hba);
+
+out:
+	up(&hba->host_sem);
+	return ret ? ret : count;
+}
+
+static DEVICE_ATTR_WO(fbo_operation_ctrl);
+
+static ssize_t fbo_exe_threshold_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct ufs_hba *hba = shost_priv(sdev->host);
+	struct ufsfbo_ctrl *fbo_ctrl = hba->fbo_ctrl;
+
+	return sysfs_emit(buf, "%d\n", fbo_ctrl->fbo_dev_info.fbo_exec_threshold);
+}
+
+static int ufsfbo_set_exe_level(struct ufs_hba *hba, u32 val)
+{
+	int ret = 0, fbo_prog_state = 0;
+
+	ret = ufsfbo_get_fbo_prog_state(hba, &fbo_prog_state);
+	if (ret) {
+		pr_err("Get fbo prog state failed.");
+		return -EINVAL;
+	}
+
+	if (fbo_prog_state == FBO_PROG_IDLE || fbo_prog_state == FBO_PROG_ANALYSIS_COMPLETE ||
+		fbo_prog_state == FBO_PROG_OPTIMIZATION_COMPLETE) {
+		down(&hba->host_sem);
+		if (!ufshcd_is_user_access_allowed(hba)) {
+			ret = -EBUSY;
+			goto out;
+		}
+		ufshcd_rpm_get_sync(hba);
+		ret = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
+				QUERY_ATTR_IDN_FBO_LEVEL_EXE, 0, 0, &val);
+		ufshcd_rpm_put_sync(hba);
+	} else {
+		pr_err("Illegal fbo prog state");
+		return -EINVAL;
+	}
+
+out:
+	up(&hba->host_sem);
+	return ret;
+}
+
+static ssize_t fbo_exe_threshold_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	u32 val;
+	int ret = 0;
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct ufs_hba *hba = shost_priv(sdev->host);
+	struct ufsfbo_ctrl *fbo_ctrl = hba->fbo_ctrl;
+
+	if (kstrtouint(buf, 0, &val))
+		return -EINVAL;
+
+	if (val < 0 || val > 10)
+		return -EINVAL;
+
+	ret = ufsfbo_set_exe_level(hba, val);
+	if (ret) {
+		pr_err("Set exec threshold failed.");
+		return -EINVAL;
+	}
+
+	fbo_ctrl->fbo_dev_info.fbo_exec_threshold = val;
+
+	return ret ? ret : count;
+}
+
+static DEVICE_ATTR_RW(fbo_exe_threshold);
+
+static int ufsfbo_issue_read_frag_level(struct scsi_device *sdev, char *buf, int para_len)
+{
+	int ret = 0;
+	unsigned char cdb[10] = {};
+	struct scsi_sense_hdr sshdr = {};
+
+	ufsfbo_fill_rw_buffer(cdb, para_len, READ_BUFFER);
+
+	ret = scsi_execute_req(sdev, cdb, DMA_FROM_DEVICE, buf, para_len,
+			&sshdr, msecs_to_jiffies(15000), 0, NULL);
+	if (ret)
+		pr_err("Read Buffer failed,sense key:0x%x;asc:0x%x;ascq:0x%x",
+			(int)sshdr.sense_key, (int)sshdr.asc, (int)sshdr.ascq);
+
+	return ret;
+}
+
+static ssize_t fbo_lba_frag_state_show(struct device *dev,
+					struct device_attribute *attr, char *buf)
+{
+	int i, ret, count = 0;
+	int para_len = 0;
+	int vaild_body_size = 0;
+	char *fbo_read_buffer;
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct ufs_hba *hba = shost_priv(sdev->host);
+	struct ufsfbo_ctrl *fbo_ctrl = hba->fbo_ctrl;
+
+	fbo_read_buffer = kzalloc(FBO_LBA_RANGE_LENGTH, GFP_KERNEL);
+	if (!fbo_read_buffer)
+		return -ENOMEM;
+
+	para_len = FBO_RW_BUF_HDR_SIZE + FBO_RW_ENTRY_SIZE +
+		fbo_ctrl->fbo_lba_cnt * FBO_RW_ENTRY_SIZE;
+
+	ret = ufsfbo_issue_read_frag_level(sdev, fbo_read_buffer, para_len);
+	if (ret) {
+		pr_err("Get lba range level failed");
+		goto out;
+	}
+
+	/* we allocated 4k, but reading only the relevant ReadBuffer size */
+	vaild_body_size = FBO_RW_ENTRY_SIZE + (fbo_ctrl->fbo_lba_cnt * FBO_RW_ENTRY_SIZE);
+	for (i = 0; i < vaild_body_size; i++) {
+		count += snprintf(buf + count, PAGE_SIZE - count,
+				"%02x  ", fbo_read_buffer[i + FBO_RW_BUF_HDR_SIZE]);
+		if (!((i + 1) % 8))
+			count += snprintf(buf + count, PAGE_SIZE - count, "\n");
+	}
+out:
+	kfree(fbo_read_buffer);
+	return ret ? ret : count;
+}
+
+static DEVICE_ATTR_RO(fbo_lba_frag_state);
+
+static int ufsfbo_check_lba_range_format(struct ufs_hba *hba, char *buf)
+{
+	char *p;
+	int lba_pairs = 0;
+	struct ufsfbo_ctrl *fbo_ctrl = hba->fbo_ctrl;
+
+	p = strstr(buf, ",");
+	if (!p || buf[strlen(buf) - 1] == ',') {
+		pr_err("Invalid lba range format, input lba range separated by ','");
+		return -EINVAL;
+	}
+
+	while (p) {
+		lba_pairs++;
+		p += 1;
+		p = strstr(p, ",");
+	}
+	/*
+	 * The input buffer is a comma delimited pairs of LBAs: open,close,
+	 * and so on.  So there should be an even number of LBAs, and odd
+	 * number of commas.
+	 */
+	if (lba_pairs % 2)
+		lba_pairs++;
+	else
+		return -EINVAL;
+
+	if (lba_pairs / 2 > fbo_ctrl->fbo_dev_info.fbo_max_lrc)
+		return -EINVAL;
+
+	fbo_ctrl->fbo_lba_cnt = lba_pairs / 2;
+	return 0;
+}
+
+static int ufsfbo_parse_lba_list(struct ufs_hba *hba, char *buf, char *lba_buf)
+{
+	char *lba_ptr;
+	struct ufsfbo_ctrl *fbo_ctrl = hba->fbo_ctrl;
+	struct ufsfbo_dev_info *fbo_dev_info = &fbo_ctrl->fbo_dev_info;
+	u64 lba_range_tmp, start_lba, lba_len;
+	int len_index = 1, lba_info_offset = FBO_RW_BUF_HDR_SIZE + FBO_RW_ENTRY_SIZE;
+
+	lba_buf[5] = fbo_ctrl->fbo_lba_cnt;
+
+	while ((lba_ptr = strsep(&buf, ",")) != NULL) {
+		if (kstrtou64(lba_ptr, 16, &lba_range_tmp))
+			return -EINVAL;
+
+		if (len_index % 2) {
+			start_lba = lba_range_tmp;
+			put_unaligned_be32(start_lba, lba_buf + lba_info_offset);
+		} else {
+			if (lba_range_tmp < start_lba)
+				return -EINVAL;
+
+			lba_len = lba_range_tmp - start_lba + 1;
+			if (lba_len < fbo_dev_info->fbo_min_lrs ||
+				lba_len > fbo_dev_info->fbo_max_lrs)
+				return -EINVAL;
+
+			put_unaligned_be24(lba_len, lba_buf + lba_info_offset + 4);
+			lba_info_offset += FBO_RW_ENTRY_SIZE;
+		}
+		len_index++;
+	}
+
+	return 0;
+}
+
+static int ufsfbo_issue_lba_list_write(struct scsi_device *sdev, char *buf)
+{
+	int ret = 0;
+	struct ufs_hba *hba = shost_priv(sdev->host);
+	struct ufsfbo_ctrl *fbo_ctrl = hba->fbo_ctrl;
+	int fbo_lba_cnt = fbo_ctrl->fbo_lba_cnt;
+	struct scsi_sense_hdr sshdr = {};
+	char *buf_lba;
+	unsigned char cdb[10] = {};
+	int para_len = FBO_RW_BUF_HDR_SIZE + FBO_RW_ENTRY_SIZE + fbo_lba_cnt * FBO_RW_ENTRY_SIZE;
+
+	buf_lba = kzalloc(FBO_LBA_RANGE_LENGTH, GFP_KERNEL);
+	if (!buf_lba) {
+		ret = -ENOMEM;
+		return ret;
+	}
+
+	ret = ufsfbo_parse_lba_list(hba, buf, buf_lba);
+	if (ret) {
+		pr_err("Init buf_lba fail");
+		goto out;
+	}
+
+	ufsfbo_fill_rw_buffer(cdb, para_len, WRITE_BUFFER);
+
+	ret = scsi_execute_req(sdev, cdb, DMA_TO_DEVICE, buf_lba, para_len,
+			&sshdr, msecs_to_jiffies(15000), 0, NULL);
+	if (ret)
+		pr_err("Write Buffer failed,sense key:0x%x;asc:0x%x;ascq:0x%x",
+			(int)sshdr.sense_key, (int)sshdr.asc, (int)sshdr.ascq);
+
+out:
+	kfree(buf_lba);
+	return ret;
+}
+
+static ssize_t fbo_send_lba_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	int ret = 0, fbo_prog_state = 0;
+	char *buf_ptr;
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct ufs_hba *hba = shost_priv(sdev->host);
+
+	if (!buf)
+		return -EINVAL;
+
+	buf_ptr = kstrdup(buf, GFP_KERNEL);
+	if (unlikely(!buf_ptr))
+		return -ENOMEM;
+
+	if (ufsfbo_check_lba_range_format(hba, buf_ptr))
+		goto out;
+
+	if (ufsfbo_get_fbo_prog_state(hba, &fbo_prog_state))
+		goto out;
+
+	if (fbo_prog_state == FBO_PROG_IDLE) {
+		ret = ufsfbo_issue_lba_list_write(sdev, buf_ptr);
+	} else {
+		ret = -EINVAL;
+		pr_err("Invalid fbo state");
+	}
+
+out:
+	kfree(buf_ptr);
+	return ret ? ret : count;
+}
+
+static DEVICE_ATTR_WO(fbo_send_lba);
+
+static struct attribute *fbo_dev_ctrl_attrs[] = {
+	&dev_attr_fbo_support.attr,
+	&dev_attr_fbo_prog_state.attr,
+	&dev_attr_fbo_operation_ctrl.attr,
+	&dev_attr_fbo_exe_threshold.attr,
+	&dev_attr_fbo_send_lba.attr,
+	&dev_attr_fbo_lba_frag_state.attr,
+	NULL,
+};
+
+const struct attribute_group ufs_sysfs_fbo_param_group = {
+	.name = "fbo_dev_ctrl",
+	.attrs = fbo_dev_ctrl_attrs,
+};
+
 static int ufsfbo_get_dev_info(struct ufs_hba *hba, struct ufsfbo_ctrl *fbo_ctrl)
 {
 	int ret;
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index f769fcb72392..410263e2fada 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8294,6 +8294,9 @@ static const struct attribute_group *ufshcd_driver_groups[] = {
 #ifdef CONFIG_SCSI_UFS_HPB
 	&ufs_sysfs_hpb_stat_group,
 	&ufs_sysfs_hpb_param_group,
+#endif
+#ifdef CONFIG_SCSI_UFS_FBO
+	&ufs_sysfs_fbo_param_group,
 #endif
 	NULL,
 };
-- 
2.38.1

