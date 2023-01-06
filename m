Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3537865F996
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 03:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjAFCbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 21:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjAFCbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 21:31:41 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C153E852
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 18:31:40 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VYxvtnS_1672972279;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VYxvtnS_1672972279)
          by smtp.aliyun-inc.com;
          Fri, 06 Jan 2023 10:31:38 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] ASoC: amd: ps: Make acp63_fill_platform_dev_info static
Date:   Fri,  6 Jan 2023 10:31:16 +0800
Message-Id: <20230106023116.117404-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This symbol is not used outside of pci-ps.c, so marks it static.

sound/soc/amd/ps/pci-ps.c:170:6: warning: no previous prototype for ‘acp63_fill_platform_dev_info’.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3640
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 sound/soc/amd/ps/pci-ps.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 401cfd0036be..570736e1b5e8 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -167,10 +167,10 @@ static void get_acp63_device_config(u32 config, struct pci_dev *pci,
 	}
 }
 
-void acp63_fill_platform_dev_info(struct platform_device_info *pdevinfo, struct device *parent,
-				  struct fwnode_handle *fw_node, char *name, unsigned int id,
-				  const struct resource *res, unsigned int num_res,
-				  const void *data, size_t size_data)
+static void acp63_fill_platform_dev_info(struct platform_device_info *pdevinfo,
+					 struct device *parent, struct fwnode_handle *fw_node,
+					 char *name, unsigned int id, const struct resource *res,
+					 unsigned int num_res, const void *data, size_t size_data)
 {
 	pdevinfo->name = name;
 	pdevinfo->id = id;
-- 
2.20.1.7.g153144c

