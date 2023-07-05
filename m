Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9DF747F78
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjGEIVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjGEIVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:21:11 -0400
Received: from out28-194.mail.aliyun.com (out28-194.mail.aliyun.com [115.124.28.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399B91BCA;
        Wed,  5 Jul 2023 01:20:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4140505|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0205348-0.00026336-0.979202;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=like@awinic.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.TlzGdjT_1688545214;
Received: from awinic..(mailfrom:like@awinic.com fp:SMTPD_---.TlzGdjT_1688545214)
          by smtp.aliyun-inc.com;
          Wed, 05 Jul 2023 16:20:39 +0800
From:   like@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     liweilei@awinic.com, liangdong@awinic.com, like@awinic.com,
        yijiangtao@awinic.com
Subject: [PATH V2 0/2] regulator: aw3750x: AW3750X regulator driver
Date:   Wed,  5 Jul 2023 08:19:40 +0000
Message-ID: <20230705081942.2608531-1-like@awinic.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ke Li <like@awinic.com>

AW37503 is a boost converter that integrates a step-up DC-DC converter,
LDO and charge pump.Whose voltages can be programmed via an I2C
compatible interface.
awinic,aw3750x.yaml describes pin information and output voltage.

Ke Li (2):
  regulator: Add Awinic AW37503 boost regulator
  regulator: aw3750x: Fix MODULE_LICENSE

 drivers/regulator/aw3750x.c | 1676 +++++++++++++++++++++++++++++++++++
 1 file changed, 1676 insertions(+)
 create mode 100644 drivers/regulator/aw3750x.c


base-commit: 3a8a670eeeaa40d87bd38a587438952741980c18
-- 
2.41.0

