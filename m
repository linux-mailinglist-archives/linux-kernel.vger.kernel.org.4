Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7925163D60C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 13:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbiK3MzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 07:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbiK3MzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 07:55:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9113F2A73E;
        Wed, 30 Nov 2022 04:55:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26AD261B2F;
        Wed, 30 Nov 2022 12:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671D9C433B5;
        Wed, 30 Nov 2022 12:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669812913;
        bh=caKgaaIV0oXMwRYscFbFUjaVc2wY6Y6lLAE0QR29CR4=;
        h=From:To:Cc:Subject:Date:From;
        b=KrQKNeBqB9TdkZXpD4zXCNJ059Bhfn4Ojq39TYC1dhPtSM6nJZTLfeXAzgntMRqbe
         7RFlEyXNeO0lfslP+QAcZcE8h1mv6n+p0l8E3x7oS8U7Re1lncgtPEhLJtKI69mYTj
         5RH3RhxNGYHLoTgJ1QlfF3njkdoyyfnSDFDezH2WhlkwZoPtDSxPHjQYJab8+Di7y7
         hw2JhjfLGBm9Dqdv9tFXr0hipf2oYhNFv+YSLnJv+JaOEfLlQBjv9UlrCVu15wbDz9
         tTpIK9b2EiNO6PB3sARRvkUpAx7jg6fQL1XH1eyzl5T+bBNEWh+hZIH4VmSWPw4MFL
         xs9LeWtRIpG8g==
From:   Georgi Djakov <djakov@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: [GIT PULL] interconnect changes for 6.2
Date:   Wed, 30 Nov 2022 14:55:08 +0200
Message-Id: <20221130125508.4349-1-djakov@kernel.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This is the pull request with interconnect changes for the 6.2-rc1 merge
window. It contains a new driver and misc fixes. The details are in the
signed tag.

All patches have been in linux-next during the last two weeks. Please pull
into char-misc-next when possible.

Thanks,
Georgi

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.2-rc1

for you to fetch changes up to 26e90ec7a8403fc8f7a4507098d7d262e9c2d302:

  Merge branch 'icc-sc8280xp-l3' into icc-next (2022-11-17 17:44:14 +0200)

----------------------------------------------------------------
interconnect changes for 6.2

These are the interconnect changes for the 6.2-rc1 merge window consisting
of new drivers to enable both L3 and DDR scaling on sc8280xp platforms.
There are also a few miscellaneous fixes.

New osm-l3 driver:
- interconnect: qcom: osm-l3: Use platform-independent node ids
- interconnect: qcom: osm-l3: Squash common descriptors
- interconnect: qcom: osm-l3: Add per-core EPSS L3 support
- interconnect: qcom: osm-l3: Simplify osm_l3_set()
- dt-bindings: interconnect: Add sm8350, sc8280xp and generic OSM L3 compatibles
- dt-bindings: interconnect: qcom,msm8998-bwmon: Add sc8280xp bwmon instances

Fixes:
 - interconnect: qcom: icc-rpm: Remove redundant dev_err call
 - interconnect: qcom: sc7180: fix dropped const of qcom_icc_bcm
 - interconnect: qcom: sc7180: drop double space
 - interconnect: qcom: sc8180x: constify pointer to qcom_icc_node

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Bjorn Andersson (6):
      interconnect: qcom: osm-l3: Use platform-independent node ids
      interconnect: qcom: osm-l3: Squash common descriptors
      interconnect: qcom: osm-l3: Add per-core EPSS L3 support
      interconnect: qcom: osm-l3: Simplify osm_l3_set()
      dt-bindings: interconnect: Add sm8350, sc8280xp and generic OSM L3 compatibles
      dt-bindings: interconnect: qcom,msm8998-bwmon: Add sc8280xp bwmon instances

Georgi Djakov (1):
      Merge branch 'icc-sc8280xp-l3' into icc-next

Krzysztof Kozlowski (4):
      dt-bindings: interconnect: qcom,msm8998-bwmon: Correct SC7280 CPU compatible
      interconnect: qcom: sc7180: fix dropped const of qcom_icc_bcm
      interconnect: qcom: sc7180: drop double space
      interconnect: qcom: sc8180x: constify pointer to qcom_icc_node

Shang XiaoJing (1):
      interconnect: qcom: icc-rpm: Remove redundant dev_err call

 .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml    |   7 +-
 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml |  24 +-
 drivers/interconnect/qcom/icc-rpm.c                             |   5 +-
 drivers/interconnect/qcom/osm-l3.c                              | 126 ++------
 drivers/interconnect/qcom/sc7180.c                              |   4 +-
 drivers/interconnect/qcom/sc8180x.c                             |   2 +-
 6 files changed, 61 insertions(+), 107 deletions(-)
