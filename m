Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A206C4648
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjCVJYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCVJYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:24:51 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB3824BE7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 02:24:43 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id k2so18690248pll.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 02:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20210112.gappssmtp.com; s=20210112; t=1679477082;
        h=content-transfer-encoding:mime-version:date:to:from:subject
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r7Tb2rdVk0Kq0Lhn7b5PfhTYo+vgtmNEVNavpXN3n3k=;
        b=6smBdnihOsEk9BxUHC1/nojaQmx36N9G0PJhWdIq7GFozFJQOUIbK2lQbt8U+2VaBy
         EZeunEtyjqOhidxR8pL/1/1KK3UN61JnYNDA51E2rr8ap5Xs3YqqQDvj5IZbiS9FlgFW
         OZmmwGm1a9vHZEEi8FezQ/nXQTcaJf1n2jW6QwAVhRUiJA1rVQOYqVKklIZXrnmKawqc
         vmaJhbi+h9VO/zuF6SVkZIwJ4PJaqlEtrmcR5J+7YvWSyOtQtgF7NyNbEMBdUyr2iUrc
         hib9eZR7Pt4pCZBT20IPPu7aV1X1iDnppXE/0MMFG4bGfRrWRGS/V9MNhTeNeRFc1kTb
         yiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679477082;
        h=content-transfer-encoding:mime-version:date:to:from:subject
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7Tb2rdVk0Kq0Lhn7b5PfhTYo+vgtmNEVNavpXN3n3k=;
        b=I8Q5/8akH3vf5dVG1CAzn2NZ8HxUajljzdmtfpyfjBafSsXIzV1+H4HQFOyse5HZs+
         d5SAQDMKNBVITdG9zjuE66fee8L21iyQ+KSwqhdMhhs1sCv6zuEzhshuqJHlEU6M8xu1
         mhvWFrBAjOFGc09PFvFjLIVt59IVwUGltEbtKYQnCjkLiShO9rjixVTl3kgN3qzLPJ/n
         nZCBsO+z8453EX9U3n/8TzGms8KBYmqLMvKTGt4Zox7cQOPurKnHytIT9/Z1cTlWHyQQ
         6Gu3S4rrgp52UNPeYeGjKYoA8LyQCAX2rt5lxfIkBMle+jNTWFp7jbRYSZjI0RR37I0u
         gN6w==
X-Gm-Message-State: AO0yUKXURBwBXi+K0UzjMMxB4P9i1Wsm+sc+eiLXcMz+/6/JqD38cAI0
        2YDL73PLr5TXpDYaDLa001g4vw==
X-Google-Smtp-Source: AK7set8Iyjh8pDLJgi4hcNTBdjsXlGImuI55mESA98K1dApFxr7fvforGjCKwsBhYAXT14pb3gbD+Q==
X-Received: by 2002:a05:6a20:3391:b0:d8:fd3b:f1ba with SMTP id f17-20020a056a20339100b000d8fd3bf1bamr4592413pzd.3.1679477082543;
        Wed, 22 Mar 2023 02:24:42 -0700 (PDT)
Received: from centos78 (60-248-88-209.hinet-ip.hinet.net. [60.248.88.209])
        by smtp.googlemail.com with ESMTPSA id l19-20020a63f313000000b0050bd71ed66fsm9201894pgh.92.2023.03.22.02.24.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Mar 2023 02:24:42 -0700 (PDT)
Message-ID: <045a0b360bd963987d9be08c1f0f785b47724caf.camel@areca.com.tw>
Subject: [PATCH 4/5] scsi: arcmsr: added driver proc_name
From:   ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 23 Mar 2023 01:24:41 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ching Huang <ching2048@areca.com.tw>

This patch added driver proc_name.

Signed-off-by: ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr.h b/drivers/scsi/arcmsr/arcmsr.h
index 07df255..6af8ae6 100644
--- a/drivers/scsi/arcmsr/arcmsr.h
+++ b/drivers/scsi/arcmsr/arcmsr.h
@@ -45,6 +45,7 @@
 #include <linux/interrupt.h>
 struct device_attribute;
 /*The limit of outstanding scsi command that firmware can handle*/
+#define ARCMSR_NAME			"arcmsr"
 #define ARCMSR_MAX_FREECCB_NUM		1024
 #define ARCMSR_MAX_OUTSTANDING_CMD	1024
 #define ARCMSR_DEFAULT_OUTSTANDING_CMD	128
diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 587332e..6a0951d 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -153,6 +153,7 @@ static int arcmsr_adjust_disk_queue_depth(struct scsi_device *sdev, int queue_de
 
 static struct scsi_host_template arcmsr_scsi_host_template = {
 	.module			= THIS_MODULE,
+	.proc_name		= ARCMSR_NAME,
 	.name			= "Areca SAS/SATA RAID driver",
 	.info			= arcmsr_info,
 	.queuecommand		= arcmsr_queue_command,

