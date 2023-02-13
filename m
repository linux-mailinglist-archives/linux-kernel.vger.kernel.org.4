Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD7969415E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjBMJhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjBMJhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:37:09 -0500
Received: from out28-73.mail.aliyun.com (out28-73.mail.aliyun.com [115.124.28.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67E19009
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:36:59 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09901703|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0186795-0.00496536-0.976355;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=21;RT=21;SR=0;TI=SMTPD_---.RKjcWil_1676281013;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.RKjcWil_1676281013)
          by smtp.aliyun-inc.com;
          Mon, 13 Feb 2023 17:36:55 +0800
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
Subject: [PATCH 1/3][next] ASoC: codecs: Fixed a spelling error in the function name
Date:   Mon, 13 Feb 2023 17:36:47 +0800
Message-Id: <20230213093649.22928-2-wangweidong.a@awinic.com>
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

Change the function name aw88395_plack_event to aw88395_playback_event

Signed-off-by: Ben Yi <yijiangtao@awinic.com>
Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/aw88395/aw88395.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/aw88395/aw88395.c b/sound/soc/codecs/aw88395/aw88395.c
index 16ca7ac5ad28..afdce6b7fa26 100644
--- a/sound/soc/codecs/aw88395/aw88395.c
+++ b/sound/soc/codecs/aw88395/aw88395.c
@@ -363,7 +363,7 @@ static const struct snd_kcontrol_new aw88395_controls[] = {
 		aw88395_profile_get, aw88395_profile_set),
 };
 
-static int aw88395_plack_event(struct snd_soc_dapm_widget *w,
+static int aw88395_playback_event(struct snd_soc_dapm_widget *w,
 				struct snd_kcontrol *k, int event)
 {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
@@ -388,7 +388,7 @@ static int aw88395_plack_event(struct snd_soc_dapm_widget *w,
 static const struct snd_soc_dapm_widget aw88395_dapm_widgets[] = {
 	 /* playback */
 	SND_SOC_DAPM_AIF_IN_E("AIF_RX", "Speaker_Playback", 0, 0, 0, 0,
-					aw88395_plack_event,
+					aw88395_playback_event,
 					SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_OUTPUT("DAC Output"),
 
-- 
2.39.1

