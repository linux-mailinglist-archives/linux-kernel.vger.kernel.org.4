Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2E36F9764
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 09:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjEGHw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 03:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjEGHw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 03:52:28 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50209008;
        Sun,  7 May 2023 00:52:26 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-52c30fbccd4so3045946a12.0;
        Sun, 07 May 2023 00:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683445946; x=1686037946;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cRfrrqx50vxG99XcLjNcRWo5z2zDSYMRqUZuG5jBIKY=;
        b=jaecR1OGwoXjjVTs+NKSvVFbeszPfjN+tLv/5l8vwUfQ7vVFuLIRdKn2w747nJ6H/w
         atFTxveoqIlG9h1FBOHyApFscKv/6YQAVa1RumtGUH0xcdRGIQKefDtMgtVF0K4L0iZE
         OFwmoX1tAD0dXcrPoB2urTJHVXOcwCMwIaMhp8bww4DJE3zpAN+kLzBfAHUX++0bNBqH
         V+5Dp9uxlbKc0i0+oH0XfzApOcef+spYJnIMuiLY44i+SRBZoc5orLhMYMfxcmtZPvia
         Ef1gsKeOt+q1txp1AQejxblXDU9NKi5JcPXh9XIQPm5D4/10fp+GAQ2MhRjfx5fQEEIa
         4sng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683445946; x=1686037946;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cRfrrqx50vxG99XcLjNcRWo5z2zDSYMRqUZuG5jBIKY=;
        b=jpuDTsysBGr4b/DQO4OkM+aiBvFD7G1TMqUB4O8iaS/D3KHjFfH/R9DpwXI1mOkt2y
         cxXiqDk9EpmiNLn815VLST3S0ALhW00SCK6twfQ4jligYazONmf0mrrraScRXlcYaYWR
         RN/bPTpl9GDZv/6ZKoKj0hFhawDoTplqrpwSO5T/wgNsAtK4IuU/+tsKtPkqCDuCdBmt
         WOiAONl2O2YzF/2EXodGnsVVetzgCfRvK/R21vQdOuaSbLxAM9EtD4KM3GrfZxCMA70y
         JlpLloy+4CVTLd77Y4rB42qwXDGNovdJHENz/rYJhIzSBa06sU30Lf7PAyyaMmLPb2xm
         iDvw==
X-Gm-Message-State: AC+VfDx9ekyygslYMIOHwT7MKwP7pa+D6co3bCFfFuTbF1TC5XfEXDCA
        RdVWvMNbiM3a/Etz3v6oMDDoMSPDrNkY2t4y
X-Google-Smtp-Source: ACHHUZ6n2q2Ih1X8tUu22B7REItZVx5TmnaDIb/HEDPxtiLHUddtxsFMYP8x7Lbr8SxZi9py9GRH4g==
X-Received: by 2002:a17:902:7782:b0:1aa:fdef:2a93 with SMTP id o2-20020a170902778200b001aafdef2a93mr6391203pll.7.1683445945979;
        Sun, 07 May 2023 00:52:25 -0700 (PDT)
Received: from yoga ([202.131.133.188])
        by smtp.gmail.com with ESMTPSA id t11-20020a170902a5cb00b001a043e84bf0sm4675147plq.209.2023.05.07.00.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 00:52:25 -0700 (PDT)
Date:   Sun, 7 May 2023 13:22:19 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: megaraid: Use sysfs_emit in show function callsbacks
Message-ID: <ZFdYszGYVRQQA7LP@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As stated in the Documentation/filesystems/sysfs.rst file, it
is recommended that the show() callback function for kobject
attributes strictly utilizes sysfs_emit instead of the sprintf
family of functions.
Issue identified using the coccinelle device_attr_show.cocci script.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 317c944c68e3..44e8d39b9b76 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3335,7 +3335,7 @@ fw_crash_buffer_size_show(struct device *cdev,
 	struct megasas_instance *instance =
 		(struct megasas_instance *) shost->hostdata;
 
-	return snprintf(buf, PAGE_SIZE, "%ld\n", (unsigned long)
+	return sysfs_emit(buf, "%ld\n", (unsigned long)
 		((instance->fw_crash_buffer_size) * 1024 * 1024)/PAGE_SIZE);
 }
 
@@ -3382,14 +3382,14 @@ fw_crash_state_show(struct device *cdev,
 	struct megasas_instance *instance =
 		(struct megasas_instance *) shost->hostdata;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", instance->fw_crash_state);
+	return sysfs_emit(buf, "%d\n", instance->fw_crash_state);
 }
 
 static ssize_t
 page_size_show(struct device *cdev,
 	struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%ld\n", (unsigned long)PAGE_SIZE - 1);
+	return sysfs_emit(buf, "%ld\n", (unsigned long)PAGE_SIZE - 1);
 }
 
 static ssize_t
@@ -3399,7 +3399,7 @@ ldio_outstanding_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct megasas_instance *instance = (struct megasas_instance *)shost->hostdata;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", atomic_read(&instance->ldio_outstanding));
+	return sysfs_emit(buf, "%d\n", atomic_read(&instance->ldio_outstanding));
 }
 
 static ssize_t
@@ -3409,7 +3409,7 @@ fw_cmds_outstanding_show(struct device *cdev,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct megasas_instance *instance = (struct megasas_instance *)shost->hostdata;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", atomic_read(&instance->fw_outstanding));
+	return sysfs_emit(buf, "%d\n", atomic_read(&instance->fw_outstanding));
 }
 
 static ssize_t
@@ -3419,7 +3419,8 @@ enable_sdev_max_qd_show(struct device *cdev,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct megasas_instance *instance = (struct megasas_instance *)shost->hostdata;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", instance->enable_sdev_max_qd);
+	return sysfs_emit(buf, "%d\n",
+			instance->enable_sdev_max_qd);
 }
 
 static ssize_t
@@ -3473,7 +3474,7 @@ raid_map_id_show(struct device *cdev, struct device_attribute *attr,
 	struct megasas_instance *instance =
 			(struct megasas_instance *)shost->hostdata;
 
-	return snprintf(buf, PAGE_SIZE, "%ld\n",
+	return sysfs_emit(buf, "%ld\n",
 			(unsigned long)instance->map_id);
 }
 
-- 
2.34.1

