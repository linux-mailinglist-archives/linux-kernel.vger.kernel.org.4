Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4CB5B2E86
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiIIGLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiIIGLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:11:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E5910873E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 23:11:29 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MP5BY3gM6zmVLx;
        Fri,  9 Sep 2022 14:07:49 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 14:11:26 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <perex@perex.cz>, <tiwai@suse.com>, <rdunlap@infradead.org>,
        <bunk@kernel.org>, <bunk@stusta.de>, <cuigaosheng1@huawei.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] sound: oss: dmasound: remove software_input_volume declaration
Date:   Fri, 9 Sep 2022 14:11:26 +0800
Message-ID: <20220909061126.1129585-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

expand_read_bal has been removed since commit fc37449f7959 ("The
next round of scheduled OSS code removal").

software_input_volume has been removed since
commit 0a1b42db4bf9 ("sound: sound/oss/dmasound/: cleanups").

so remove the declare for them from header file.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 sound/oss/dmasound/dmasound.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/oss/dmasound/dmasound.h b/sound/oss/dmasound/dmasound.h
index ad8ce6a1c25c..f065840c0efb 100644
--- a/sound/oss/dmasound/dmasound.h
+++ b/sound/oss/dmasound/dmasound.h
@@ -250,7 +250,4 @@ extern int dmasound_catchRadius;
 #define SW_INPUT_VOLUME_SCALE	4
 #define SW_INPUT_VOLUME_DEFAULT	(128 / SW_INPUT_VOLUME_SCALE)
 
-extern int expand_read_bal;	/* Balance factor for reading */
-extern uint software_input_volume; /* software implemented recording volume! */
-
 #endif /* _dmasound_h_ */
-- 
2.25.1

