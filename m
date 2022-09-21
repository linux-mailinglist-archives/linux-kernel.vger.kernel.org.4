Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE305BFAE7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiIUJ1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbiIUJ04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:26:56 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C32E8FD4B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:26:52 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id t3so5057904ply.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=yO3ZnWbPpoGbIq8B/Q7ETdn558npB4Kk+L1NAs1JDak=;
        b=GBgTsPuo5X2S9CvY1m+P4QF8vY/0rJz4wG5xlN5JMlHJVnDp2q/1jGyw5eA1pGH9rx
         sk37E3LbXX47817Cm6Ok0xRL/1G9oJmf7Y7Ts74S8ZglLGuPqs9zPSlPqTS5hCRaMJYM
         uNpFzeWZa+P3HdkQQG/weZPEIvaeizuPB0qzkREbz7JDNej6UvazM77eaPa8WD2mfqvF
         ueELfznhgSD5Pnnj0sDaexnTXIMk2goMbuynlCeN9+JCsFtAHaV3uUWXWZGrmYKwPVI/
         M+sNwnsHrzSHhuscF3X02vIVobHCuIj2ETBklvUXNmapYSlMYXTZ4EDB7I4VfbklHw5Q
         VSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=yO3ZnWbPpoGbIq8B/Q7ETdn558npB4Kk+L1NAs1JDak=;
        b=3RDjj4jHOHphqYUrsCLWuPiYBANrFDTM5RqdroJxl1okfMT2qRzPTeHIt/8gqtM6LR
         2Qb6mWtABNa7AOADfKt9g7D5/Iu79bn62bcirmJomGfKA3l0a+WEO5cFzoy1VVCFyxwD
         9J1Z1BGkNjK93gAigm0RmS6xUMNyIrC+O6bXvOkXOeRCfvgq3QwtmrbCLu7t2I/cH/EM
         Q5YPcGDyCIXMMWlJdp47Ke2VftLc5Mrn3FKK55yxfqvHaDoihu0nzOVCFE3eWmOxmbbs
         rPmXoxtdaHdeiBE7Vh+FMtAXD1XtjwozIyG0U/d9qu+nHOi2lM3sadHcJX7y/w83tFwE
         BZQg==
X-Gm-Message-State: ACrzQf1gQzObkjMU2bW8WlmTBo0pU4qxCVapwqlvGhlrkWeHJ0o9SnaI
        7EU72rRGsBPSdq6wb+RCDC7mE/04ns0=
X-Google-Smtp-Source: AMsMyM72wBUENYWp/yF3lbC/CF5HAYIeVMDyS0AiG5oRtzrCFV76fJFwc9Ipd2LV2/UYHL0JHNW73A==
X-Received: by 2002:a17:90a:8906:b0:202:d763:72ab with SMTP id u6-20020a17090a890600b00202d76372abmr8409589pjn.56.1663752411397;
        Wed, 21 Sep 2022 02:26:51 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p63-20020a625b42000000b005367c28fd32sm1602452pfb.185.2022.09.21.02.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:26:50 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     dan.j.williams@intel.com
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>,
        ye xingchen <ye.xingchen@zte.com.cn>
Subject: 
Date:   Wed, 21 Sep 2022 09:26:46 +0000
Message-Id: <20220921092646.230274-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

m 1561c1c9285eaa8638406280b53bb9e0b5a67d93 Mon Sep 17 00:00:00 2001
From: ye xingchen <ye.xingchen@zte.com.cn>
Date: Wed, 21 Sep 2022 09:21:30 +0800
Subject: [PATCH linux-next] nvdimm: Use the function kobj_to_dev()

Use kobj_to_dev() instead of open-coding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/nvdimm/bus.c            | 2 +-
 drivers/nvdimm/core.c           | 2 +-
 drivers/nvdimm/dimm_devs.c      | 4 ++--
 drivers/nvdimm/namespace_devs.c | 2 +-
 drivers/nvdimm/region_devs.c    | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index b38d0355b0ac..6bd53d3a3eeb 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -690,7 +690,7 @@ static struct attribute *nd_numa_attributes[] = {
 static umode_t nd_numa_attr_visible(struct kobject *kobj, struct attribute *a,
 		int n)
 {
-	struct device *dev = container_of(kobj, typeof(*dev), kobj);
+	struct device *dev = kobj_to_dev(kobj);
 
 	if (!IS_ENABLED(CONFIG_NUMA))
 		return 0;
diff --git a/drivers/nvdimm/core.c b/drivers/nvdimm/core.c
index d91799b71d23..8ee7eddce0b2 100644
--- a/drivers/nvdimm/core.c
+++ b/drivers/nvdimm/core.c
@@ -466,7 +466,7 @@ static DEVICE_ATTR_ADMIN_RW(activate);
 
 static umode_t nvdimm_bus_firmware_visible(struct kobject *kobj, struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, typeof(*dev), kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
 	struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
 	enum nvdimm_fwa_capability cap;
diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index c7c980577491..5f9487e40111 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -409,7 +409,7 @@ static struct attribute *nvdimm_attributes[] = {
 
 static umode_t nvdimm_visible(struct kobject *kobj, struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, typeof(*dev), kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nvdimm *nvdimm = to_nvdimm(dev);
 
 	if (a != &dev_attr_security.attr && a != &dev_attr_frozen.attr)
@@ -525,7 +525,7 @@ static struct attribute *nvdimm_firmware_attributes[] = {
 
 static umode_t nvdimm_firmware_visible(struct kobject *kobj, struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, typeof(*dev), kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(dev);
 	struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
 	struct nvdimm *nvdimm = to_nvdimm(dev);
diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index dfade66bab73..fd2e8ca67001 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1372,7 +1372,7 @@ static struct attribute *nd_namespace_attributes[] = {
 static umode_t namespace_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 
 	if (is_namespace_pmem(dev)) {
 		if (a == &dev_attr_size.attr)
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 473a71bbd9c9..886740e2c94f 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -607,7 +607,7 @@ static struct attribute *nd_region_attributes[] = {
 
 static umode_t region_visible(struct kobject *kobj, struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, typeof(*dev), kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nd_region *nd_region = to_nd_region(dev);
 	struct nd_interleave_set *nd_set = nd_region->nd_set;
 	int type = nd_region_to_nstype(nd_region);
@@ -721,7 +721,7 @@ REGION_MAPPING(31);
 
 static umode_t mapping_visible(struct kobject *kobj, struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nd_region *nd_region = to_nd_region(dev);
 
 	if (n < nd_region->ndr_mappings)
-- 
2.25.1
