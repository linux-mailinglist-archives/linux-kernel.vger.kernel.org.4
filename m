Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFF069415F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjBMJhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjBMJhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:37:09 -0500
Received: from out28-51.mail.aliyun.com (out28-51.mail.aliyun.com [115.124.28.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB76B761
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:37:01 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1599715|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00673938-0.000857743-0.992403;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=21;RT=21;SR=0;TI=SMTPD_---.RKjcWmU_1676281015;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.RKjcWmU_1676281015)
          by smtp.aliyun-inc.com;
          Mon, 13 Feb 2023 17:36:56 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, krzysztof.kozlowski@linaro.org,
        rf@opensource.cirrus.com, pierre-louis.bossart@linux.intel.com,
        ckeepax@opensource.cirrus.com, shumingf@realtek.com,
        herve.codina@bootlin.com, james.schulman@cirrus.com,
        doug@schmorgal.com, yang.lee@linux.alibaba.com, trix@redhat.com,
        colin.i.king@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     wangweidong.a@awinic.com, liweilei@awinic.com, zhaolei@awinic.com,
        yijiangtao@awinic.com
Subject: [PATCH 2/3][next] ASoC: codecs: Modify the log print statement
Date:   Mon, 13 Feb 2023 17:36:48 +0800
Message-Id: <20230213093649.22928-3-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213093649.22928-1-wangweidong.a@awinic.com>
References: <20230213093649.22928-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weidong Wang <wangweidong.a@awinic.com>

Change hdrlen to hdr_len

Signed-off-by: Ben Yi <yijiangtao@awinic.com>
Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/aw88395/aw88395_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/aw88395/aw88395_lib.c b/sound/soc/codecs/aw88395/aw88395_lib.c
index d7c31a202adc..05bcf49da857 100644
--- a/sound/soc/codecs/aw88395/aw88395_lib.c
+++ b/sound/soc/codecs/aw88395/aw88395_lib.c
@@ -932,7 +932,7 @@ static int aw_dev_check_cfg_by_hdr(struct aw_device *aw_dev, struct aw_container
 
 	hdr_ddt_len = cfg_hdr->hdr_offset + cfg_hdr->ddt_size;
 	if (hdr_ddt_len > aw_cfg->len) {
-		dev_err(aw_dev->dev, "hdrlen with ddt_len [%d] overflow file size[%d]",
+		dev_err(aw_dev->dev, "hdr_len with ddt_len [%d] overflow file size[%d]",
 		cfg_hdr->hdr_offset, aw_cfg->len);
 		return -EINVAL;
 	}
-- 
2.39.1

