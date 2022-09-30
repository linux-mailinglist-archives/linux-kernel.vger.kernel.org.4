Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AB85F097D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiI3LHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiI3LGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:06:22 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A51C149B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 03:43:16 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Mf6F43xJ2zHqWY;
        Fri, 30 Sep 2022 18:40:08 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 18:42:27 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 18:42:27 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
CC:     <perex@perex.cz>, <tiwai@suse.com>, <jayakumar.alsa@gmail.com>,
        <chenzhongjin@huawei.com>, <wangjianli@cdjrlc.com>
Subject: [PATCH -next 3/4] ALSA: cs5535audio: Remove unused variable 'loop_count'
Date:   Fri, 30 Sep 2022 18:38:35 +0800
Message-ID: <20220930103836.104113-4-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220930103836.104113-1-chenzhongjin@huawei.com>
References: <20220930103836.104113-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported by Clang [-Wunused-but-set-variable]

The variable 'loop_count' is introduced in this commit
'commit 719f82d3987a ("ALSA: Add support of AudioScience ASI boards")'

However, since introduced it had never been used.
Remove it for code cleaning

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 sound/pci/asihpi/hpi6000.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/pci/asihpi/hpi6000.c b/sound/pci/asihpi/hpi6000.c
index 88d902997b74..72aa135d69f8 100644
--- a/sound/pci/asihpi/hpi6000.c
+++ b/sound/pci/asihpi/hpi6000.c
@@ -1253,7 +1253,6 @@ static u16 hpi6000_dsp_block_read32(struct hpi_adapter_obj *pao,
 	int local_count = count;
 	int xfer_size;
 	u32 *pdata = dest;
-	u32 loop_count = 0;
 
 	while (local_count) {
 		if (local_count > c6711_burst_size)
@@ -1273,7 +1272,6 @@ static u16 hpi6000_dsp_block_read32(struct hpi_adapter_obj *pao,
 		pdata += xfer_size;
 		local_hpi_address += sizeof(u32) * xfer_size;
 		local_count -= xfer_size;
-		loop_count++;
 	}
 
 	if (time_out)
-- 
2.17.1

