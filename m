Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB2369415D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjBMJhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjBMJhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:37:08 -0500
Received: from out28-53.mail.aliyun.com (out28-53.mail.aliyun.com [115.124.28.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9174C08
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:36:58 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08069851|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00672893-0.000500749-0.99277;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=21;RT=21;SR=0;TI=SMTPD_---.RKjcWdk_1676281011;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.RKjcWdk_1676281011)
          by smtp.aliyun-inc.com;
          Mon, 13 Feb 2023 17:36:53 +0800
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
Subject: [PATCH 0/3][next] ASoC: codecs: Modify error implicit declaration of function and misspelling
Date:   Mon, 13 Feb 2023 17:36:46 +0800
Message-Id: <20230213093649.22928-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.39.1
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
Change hdrlen to hdr_len
Add select GPIOLIB to the sound/soc/codecs/Kconfig file

Weidong Wang (3):
  ASoC: codecs: Fixed a spelling error in the function name
  ASoC: codecs: Modify the log print statement
  ASoC: codecs: Modify error: implicit declaration of  function
    'gpiod_set_value_cansleep'

 sound/soc/codecs/Kconfig               | 1 +
 sound/soc/codecs/aw88395/aw88395.c     | 4 ++--
 sound/soc/codecs/aw88395/aw88395_lib.c | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)


base-commit: 6ba8a227fd19d19779005fb66ad7562608e1df83
-- 
2.39.1

