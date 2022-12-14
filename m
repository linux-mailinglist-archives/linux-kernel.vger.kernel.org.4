Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FDA64CFD7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 20:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbiLNTDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 14:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238281AbiLNTDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 14:03:19 -0500
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5812A737;
        Wed, 14 Dec 2022 11:03:17 -0800 (PST)
Received: from TimeMachine.lan (adsl-d248.84-47-10.t-com.sk [84.47.10.248])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 6D2E62020A;
        Wed, 14 Dec 2022 20:03:15 +0100 (CET)
From:   Martin Botka <martin.botka@somainline.org>
To:     martin.botka1@gmail.com
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Jan Trmal <jtrmal@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] AXP1530 PMIC
Date:   Wed, 14 Dec 2022 20:03:02 +0100
Message-Id: <20221214190305.3354669-1-martin.botka@somainline.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series adds support for the AXP1530 PMIC which is controlled via the
I2C bus.

Changes in v2:
Remove RSB support.
Drop .id = 0
Add dt-binding for the AXP1530

Changes in v3:
Move AXP1530 dt-binding to alphabetical order

Changes in v4:
Fix indentation

Changes in v5:
Use alphabetical ordering in mfd
Correct { placement line
Replace spaces with tabs in 1 struct

Martin Botka (3):
  dt-bindings: mfd: x-powers,axp152: Document the AXP1530 variant
  mfd: ax20x: Add suppport for AXP1530 PMIC
  regulator: axp20x: Add support for AXP1530 variant

 .../bindings/mfd/x-powers,axp152.yaml         |  1 +
 drivers/mfd/axp20x-i2c.c                      |  2 +
 drivers/mfd/axp20x.c                          | 62 +++++++++++++++++++
 drivers/regulator/axp20x-regulator.c          | 44 +++++++++++++
 include/linux/mfd/axp20x.h                    | 34 ++++++++++
 5 files changed, 143 insertions(+)

-- 
2.38.1

