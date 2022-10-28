Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D4B610F23
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJ1Kz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiJ1Kze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:55:34 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123F14DF1B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 03:55:31 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MzK8B18L5zmVXJ;
        Fri, 28 Oct 2022 18:50:34 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500015.china.huawei.com (7.221.188.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 18:55:29 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <xuwei5@hisilicon.com>
CC:     <jonathan.cameron@huawei.com>, <john.garry@huawei.com>,
        <rafael.j.wysocki@intel.com>, <linuxarm@huawei.com>,
        <soc@kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@huawei.com>, <prime.zeng@hisilicon.com>
Subject: [PATCH] MAINTAINERS: Update HiSilicon LPC BUS Driver maintainer
Date:   Fri, 28 Oct 2022 18:54:34 +0800
Message-ID: <20221028105434.1661264-1-f.fangjian@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Jay Fang as the maintainer of the HiSilicon LPC BUS Driver, replacing
John Garry.

Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 781423be8400..d73921b67758 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9146,7 +9146,7 @@ W:	https://www.hisilicon.com
 F:	drivers/i2c/busses/i2c-hisi.c
 
 HISILICON LPC BUS DRIVER
-M:	john.garry@huawei.com
+M:	Jay Fang <f.fangjian@huawei.com>
 S:	Maintained
 W:	http://www.hisilicon.com
 F:	Documentation/devicetree/bindings/arm/hisilicon/low-pin-count.yaml
-- 
2.30.0

