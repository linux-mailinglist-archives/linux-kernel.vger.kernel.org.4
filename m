Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706D8694160
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjBMJhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjBMJhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:37:10 -0500
Received: from out28-148.mail.aliyun.com (out28-148.mail.aliyun.com [115.124.28.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76AEB770
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:37:05 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1776371|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0848819-0.000824855-0.914293;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=21;RT=21;SR=0;TI=SMTPD_---.RKjcWqW_1676281017;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.RKjcWqW_1676281017)
          by smtp.aliyun-inc.com;
          Mon, 13 Feb 2023 17:36:58 +0800
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
Subject: [PATCH 3/3][next] ASoC: codecs: Modify error implicit declaration of  function 'gpiod_set_value_cansleep'
Date:   Mon, 13 Feb 2023 17:36:49 +0800
Message-Id: <20230213093649.22928-4-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213093649.22928-1-wangweidong.a@awinic.com>
References: <20230213093649.22928-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weidong Wang <wangweidong.a@awinic.com>

Add select GPIOLIB to the sound/soc/codecs/Kconfig file

Signed-off-by: Ben Yi <yijiangtao@awinic.com>
Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index ab7b0696d01d..4621674e68bf 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -614,6 +614,7 @@ config SND_SOC_AW88395
 	select CRC8
 	select CRC32
 	select REGMAP_I2C
+	select GPIOLIB
 	select SND_SOC_AW88395_LIB
 	help
 	  this option enables support for aw88395 Smart PA.
-- 
2.39.1

