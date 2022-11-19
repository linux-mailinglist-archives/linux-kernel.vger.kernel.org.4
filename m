Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D37630D13
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 08:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbiKSHyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 02:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiKSHyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 02:54:31 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D309C248DF;
        Fri, 18 Nov 2022 23:54:29 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NDmBL5jvtz15Mcm;
        Sat, 19 Nov 2022 15:54:02 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 15:54:28 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 19 Nov
 2022 15:54:27 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <gregkh@linuxfoundation.org>, <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        <yekai13@huawei.com>
Subject: [PATCH v10 2/3] Documentation: add the device isolation feature sysfs nodes for uacce
Date:   Sat, 19 Nov 2022 07:48:16 +0000
Message-ID: <20221119074817.12063-3-yekai13@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221119074817.12063-1-yekai13@huawei.com>
References: <20221119074817.12063-1-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update documentation describing sysfs node that could help to
configure hardware error threshold for users in the user space. And
describing sysfs node that could read the device isolated state.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 Documentation/ABI/testing/sysfs-driver-uacce | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-uacce b/Documentation/ABI/testing/sysfs-driver-uacce
index 08f2591138af..d3f0b8f3c589 100644
--- a/Documentation/ABI/testing/sysfs-driver-uacce
+++ b/Documentation/ABI/testing/sysfs-driver-uacce
@@ -19,6 +19,24 @@ Contact:        linux-accelerators@lists.ozlabs.org
 Description:    Available instances left of the device
                 Return -ENODEV if uacce_ops get_available_instances is not provided
 
+What:           /sys/class/uacce/<dev_name>/isolate_strategy
+Date:           Nov 2022
+KernelVersion:  6.1
+Contact:        linux-accelerators@lists.ozlabs.org
+Description:    (RW) A sysfs node that configure the error threshold for the hardware
+                isolation strategy. This size is a configured integer value, which is the
+                number of threshold for hardware errors occurred in one hour. The default is 0.
+                0 means never isolate the device. The maximum value is 65535. You can write
+                a number of threshold based on your hardware.
+
+What:           /sys/class/uacce/<dev_name>/isolate
+Date:           Nov 2022
+KernelVersion:  6.1
+Contact:        linux-accelerators@lists.ozlabs.org
+Description:    (R) A sysfs node that read the device isolated state. The value 1
+                means the device is unavailable. The 0 means the device is
+                available.
+
 What:           /sys/class/uacce/<dev_name>/algorithms
 Date:           Feb 2020
 KernelVersion:  5.7
-- 
2.17.1

