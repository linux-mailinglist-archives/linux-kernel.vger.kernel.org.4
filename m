Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839B86A2128
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 19:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjBXSIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 13:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjBXSIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 13:08:35 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518A79030
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 10:08:34 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id bh1so289342plb.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 10:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m72Q2LX47Fd2G4iaDSLuBTewGnVaLRCtRzAf9b4ENNs=;
        b=b1j5BY26QzYIYtMCqc8aI9cayDjo7BLHSsQTdXXDbVpy213+FRBffqwpa5cgjfTFsi
         0UMdE5BJ/az0tkLJZkhK9SaQ+uJyWnyXETbDXxOb0SKg1WLzW3NWkpqKE0i5xn+h2M+J
         a3Tjsg331glowVh4x/HkDAYH69BxY3jtkQ8pPFSmXqvwHyb3FiBgKJfZ4VC7s596HhlG
         jqrYQ0pdYsxtRZDSOWnzyReo7UqZjaxV538kG/0JenwPXaGfTEwRshHqsqK6ZSYsIDB/
         ohQosBIdwAnDlINb1eeDpHiMDoj7FTNEk01tc3S/gXiM2IQeQyf92BBzjYfEyO51fDz/
         5x4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m72Q2LX47Fd2G4iaDSLuBTewGnVaLRCtRzAf9b4ENNs=;
        b=6yDJPMJaPAuxkUpppiG8aNQtfFQAhUDk4rBDmyC+C/cGR9sZIensd08x+PHHHmB3HK
         viqIxNT4vsuEltpGORQo5iEbaMQj3Zyt2az3giIYjsthsv48JbOtyB2io+vJNdUt7Tvy
         BSWrcvLzPXd6CRfO84AWrl3OaugpF6bP88UEEx8sc1L6RnPUhJ5mUkCfZIl3n2TFGYem
         ztXxq1AN0yz928y+NW8god7xZ2P2sQkN5Ryhk0Ui083otsuxQrtfzj1PDlnJLL0Pvinh
         ofxKMbxKCD+OfYDuiFvlI4zvacHTxV+JeTfKlwBJuvEKtx+hM92MnITBYTeQA1kVlfnw
         Z85g==
X-Gm-Message-State: AO0yUKVHMNJX/r5zNmeXDI8DKBoGNHG4Be94QyWmrYYDm3RgdDujaEkX
        CJ7CyDhA3/E4Nl4Eeiq/a/o=
X-Google-Smtp-Source: AK7set+mBPXWiSYdy3wx0nDD5e0+7kXz92Qx/gA/ZaSt6Z5eoQf4tVRCeVyeYwSobJBqFyJ4dHGa9Q==
X-Received: by 2002:a17:90b:1c10:b0:234:1621:3792 with SMTP id oc16-20020a17090b1c1000b0023416213792mr18669402pjb.4.1677262113689;
        Fri, 24 Feb 2023 10:08:33 -0800 (PST)
Received: from pavilion.. ([2402:e280:2146:9e0:378e:1cc3:a44a:c5ba])
        by smtp.gmail.com with ESMTPSA id mv11-20020a17090b198b00b002376d85844dsm1828612pjb.51.2023.02.24.10.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 10:08:33 -0800 (PST)
From:   Saalim Quadri <danascape@gmail.com>
To:     vishal.l.verma@intel.com, dan.j.williams@intel.com,
        dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
        maddy@in.ibm.com, peterz@infradead.org, kjain@linux.ibm.com
Cc:     Saalim Quadri <danascape@gmail.com>, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev
Subject: [PATCH] Documentation/ABI: sysfs-bus-nvdimm: Fix sphinx warnings
Date:   Fri, 24 Feb 2023 23:38:03 +0530
Message-Id: <20230224180803.21285-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Fix the following warning from "make htmldocs":

Documentation/ABI/testing/sysfs-bus-nvdimm:10:
  WARNING: Unexpected indentation.

Fixes: 2bec6d9aa89c ("docs: ABI: sysfs-bus-nvdimm: Document sysfs event format entries for nvdimm pmu")

Signed-off-by: Saalim Quadri <danascape@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-nvdimm | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-nvdimm b/Documentation/ABI/testing/sysfs-bus-nvdimm
index de8c5a59c77f..8564a0ff0d3e 100644
--- a/Documentation/ABI/testing/sysfs-bus-nvdimm
+++ b/Documentation/ABI/testing/sysfs-bus-nvdimm
@@ -18,9 +18,11 @@ Description:	(RO) Attribute group to describe the magic bits
 		Each attribute under this group defines a bit range of the
 		perf_event_attr.config. Supported attribute is listed
 		below::
+
 		  event  = "config:0-4"  - event ID
 
 		For example::
+
 			ctl_res_cnt = "event=0x1"
 
 What:           /sys/bus/event_source/devices/nmemX/events
-- 
2.34.1

