Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626A060DF3B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbiJZLDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbiJZLD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:03:26 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219DED03BB;
        Wed, 26 Oct 2022 04:03:07 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4My5TL2x07z6865q;
        Wed, 26 Oct 2022 19:01:10 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Wed, 26 Oct 2022 13:03:04 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 12:03:02 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <chenxiang66@hisilicon.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] MAINTAINERS: Make Xiang Chen HiSilicon SAS controller driver maintainer
Date:   Wed, 26 Oct 2022 19:33:28 +0800
Message-ID: <1666784008-125519-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am soon leaving Huawei, so will no longer maintain this driver. However
I will stay active in upstream linux storage domain.

Xiang Chen has worked on the driver for as long as I have and has good
knowledge of the driver, so should do a good job.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index cf0f18502372..174de5e8d4c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9290,7 +9290,7 @@ F:	Documentation/devicetree/bindings/infiniband/hisilicon-hns-roce.txt
 F:	drivers/infiniband/hw/hns/
 
 HISILICON SAS Controller
-M:	John Garry <john.garry@huawei.com>
+M:	Xiang Chen <chenxiang66@hisilicon.com>
 S:	Supported
 W:	http://www.hisilicon.com
 F:	Documentation/devicetree/bindings/scsi/hisilicon-sas.txt
-- 
2.25.1

