Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2EF6423A7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 08:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbiLEHfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 02:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiLEHf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 02:35:28 -0500
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDC4FAFD
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 23:35:26 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jiapeng.chong@linux.alibaba.com;NM=0;PH=DS;RN=10;SR=0;TI=SMTPD_---0VWPrFg9_1670225710;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VWPrFg9_1670225710)
          by smtp.aliyun-inc.com;
          Mon, 05 Dec 2022 15:35:24 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     srinivas.kandagatla@linaro.org
Cc:     bgoswami@quicinc.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] ASoC: codecs: wcd-clsh: Remove the unused function
Date:   Mon,  5 Dec 2022 15:35:07 +0800
Message-Id: <20221205073507.36071-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function wcd_clsh_set_buck_mode() is defined in the wcd-clsh-v2.c
file, but not called elsewhere, so remove this unused function.

sound/soc/codecs/wcd-clsh-v2.c:133:20: warning: unused function 'wcd_clsh_enable_status'.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3348
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 sound/soc/codecs/wcd-clsh-v2.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/codecs/wcd-clsh-v2.c b/sound/soc/codecs/wcd-clsh-v2.c
index 4c7ebc7fb400..a75db27e5205 100644
--- a/sound/soc/codecs/wcd-clsh-v2.c
+++ b/sound/soc/codecs/wcd-clsh-v2.c
@@ -130,12 +130,6 @@ static inline void wcd_enable_clsh_block(struct wcd_clsh_ctrl *ctrl,
 		ctrl->clsh_users = 0;
 }
 
-static inline bool wcd_clsh_enable_status(struct snd_soc_component *comp)
-{
-	return snd_soc_component_read(comp, WCD9XXX_A_CDC_CLSH_CRC) &
-					WCD9XXX_A_CDC_CLSH_CRC_CLK_EN_MASK;
-}
-
 static inline void wcd_clsh_set_buck_mode(struct snd_soc_component *comp,
 					  int mode)
 {
-- 
2.20.1.7.g153144c

