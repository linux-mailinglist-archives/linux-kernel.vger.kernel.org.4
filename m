Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B294B64AFAF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 07:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbiLMGOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 01:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbiLMGOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 01:14:41 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325FE1AD94
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 22:14:39 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jiapeng.chong@linux.alibaba.com;NM=0;PH=DS;RN=6;SR=0;TI=SMTPD_---0VXCbbTo_1670912063;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VXCbbTo_1670912063)
          by smtp.aliyun-inc.com;
          Tue, 13 Dec 2022 14:14:36 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     perex@perex.cz
Cc:     tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] ALSA: azt3328: Remove the unused function snd_azf3328_codec_outl()
Date:   Tue, 13 Dec 2022 14:13:55 +0800
Message-Id: <20221213061355.62856-1-jiapeng.chong@linux.alibaba.com>
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

The function snd_azf3328_codec_outl is defined in the azt3328.c file, but
not called elsewhere, so remove this unused function.

sound/pci/azt3328.c:367:1: warning: unused function 'snd_azf3328_codec_outl'.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3432
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 sound/pci/azt3328.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/pci/azt3328.c b/sound/pci/azt3328.c
index 7f329dfc5404..0c6754bf9455 100644
--- a/sound/pci/azt3328.c
+++ b/sound/pci/azt3328.c
@@ -363,15 +363,6 @@ snd_azf3328_codec_inw(const struct snd_azf3328_codec_data *codec, unsigned reg)
 	return inw(codec->io_base + reg);
 }
 
-static inline void
-snd_azf3328_codec_outl(const struct snd_azf3328_codec_data *codec,
-		       unsigned reg,
-		       u32 value
-)
-{
-	outl(value, codec->io_base + reg);
-}
-
 static inline void
 snd_azf3328_codec_outl_multi(const struct snd_azf3328_codec_data *codec,
 			     unsigned reg, const void *buffer, int count
-- 
2.20.1.7.g153144c

