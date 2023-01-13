Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD63F668C04
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 06:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237727AbjAMF60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 00:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240123AbjAMF5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 00:57:33 -0500
Received: from out29-225.mail.aliyun.com (out29-225.mail.aliyun.com [115.124.29.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547BE6D522;
        Thu, 12 Jan 2023 21:53:30 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08223306|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0236966-0.000586858-0.975717;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=23;RT=23;SR=0;TI=SMTPD_---.QrY0tRj_1673589183;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.QrY0tRj_1673589183)
          by smtp.aliyun-inc.com;
          Fri, 13 Jan 2023 13:53:11 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, rf@opensource.cirrus.com,
        pierre-louis.bossart@linux.intel.com, james.schulman@cirrus.com,
        wangweidong.a@awinic.com, flatmax@flatmax.com,
        jonathan.albrieux@gmail.com, povik+lin@cutebit.org,
        13691752556@139.com, shumingf@realtek.com,
        ryan.lee.analog@gmail.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     liweilei@awinic.com, yijiangtao@awinic.com, zhaolei@awinic.com
Subject: [PATCH V10 0/5] ASoC: codecs: Add Awinic AW88395 audio amplifier driver
Date:   Fri, 13 Jan 2023 13:52:56 +0800
Message-Id: <20230113055301.189541-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weidong Wang <wangweidong.a@awinic.com>

The Awinic AW88395 is an I2S/TDM input, high efficiency
digital Smart K audio amplifier with an integrated 10.25V
smart boost convert

Add a DT schema for describing Awinic AW88395 audio amplifiers. They are
controlled using I2C

v9 -> v10: Modified return before unlock
           Change the way the if statement is written
           Use __le16 instead of unsigned short
           Rename the file, changing aw883xx to aw88395
           Change variable name
           Modify the Makefile and Kconfig

Weidong Wang (5):
  ASoC: codecs: Add i2c and codec registration for aw88395 and their
    associated operation functions
  ASoC: codecs: ACF bin parsing and check library file for aw88395
  ASoC: codecs: Aw88395 function for ALSA Audio Driver
  ASoC: codecs: Aw88395 chip register file, data type file and Kconfig
    Makefile
  ASoC: dt-bindings: Add schema for "awinic,aw88395"

 .../bindings/sound/awinic,aw88395.yaml        |   53 +
 sound/soc/codecs/Kconfig                      |   17 +
 sound/soc/codecs/Makefile                     |    5 +
 sound/soc/codecs/aw88395/aw88395.c            |  580 ++++++
 sound/soc/codecs/aw88395/aw88395.h            |   58 +
 sound/soc/codecs/aw88395/aw88395_data_type.h  |  142 ++
 sound/soc/codecs/aw88395/aw88395_device.c     | 1748 +++++++++++++++++
 sound/soc/codecs/aw88395/aw88395_device.h     |  194 ++
 sound/soc/codecs/aw88395/aw88395_lib.c        | 1066 ++++++++++
 sound/soc/codecs/aw88395/aw88395_lib.h        |   92 +
 sound/soc/codecs/aw88395/aw88395_reg.h        |  383 ++++
 11 files changed, 4338 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
 create mode 100644 sound/soc/codecs/aw88395/aw88395.c
 create mode 100644 sound/soc/codecs/aw88395/aw88395.h
 create mode 100644 sound/soc/codecs/aw88395/aw88395_data_type.h
 create mode 100644 sound/soc/codecs/aw88395/aw88395_device.c
 create mode 100644 sound/soc/codecs/aw88395/aw88395_device.h
 create mode 100644 sound/soc/codecs/aw88395/aw88395_lib.c
 create mode 100644 sound/soc/codecs/aw88395/aw88395_lib.h
 create mode 100644 sound/soc/codecs/aw88395/aw88395_reg.h


base-commit: d9fc1511728c15df49ff18e49a494d00f78b7cd4
-- 
2.39.0

