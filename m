Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA08675272
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 11:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjATK3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 05:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjATK3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 05:29:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D381024B;
        Fri, 20 Jan 2023 02:29:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3AD04B821EE;
        Fri, 20 Jan 2023 10:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B2BC433D2;
        Fri, 20 Jan 2023 10:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674210541;
        bh=f390jgXCdhbURtGN3ygCqqFUwbNfq/2YUjDYYoIxekg=;
        h=From:To:Cc:Subject:Date:From;
        b=nkklfHEvIRDhg3cxnVUaenTZOuH815io2Vq//QDvvQsWSIN3jh5jlqHGbV4Yp/Tnf
         Uz3shYAc9JkcfkkVkQdkT+muY+Wh4Ahifm3KYeaoRS5gPh3vBrssLifksR+ftPylxc
         I2xDfOCNQXleOiCXBaHqto83Z+nhTcW6yCbZIj2bleM9tmjTs3DTtyeG55BlBp2RSl
         yVvWHzXRPpdnMck/i1ve2r8r6YxFR3zad/pjcMf9TDSkyJQZJisuKiD2G4zU+Fe1gA
         ei7kFu2oXE5bgYdwIJUuvyR3HpQ/4ckxF70sD3GL3IJXiJDDx8ZFH6J5M7T7PfDGjX
         tEoCmLuOqRYOw==
From:   Georgi Djakov <djakov@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: [GIT PULL] interconnect fixes for 6.2-rc
Date:   Fri, 20 Jan 2023 12:28:56 +0200
Message-Id: <20230120102856.1199868-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
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

This pull request contains fixes for the current cycle. The details
are in the signed tag. It has been in linux-next during the last two
weeks. Please pull into char-misc-linus when you have the chance.

Thanks,
Georgi


The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.2-rc5

for you to fetch changes up to dd42ec8ea5b979edcebbf0ba05807d866884b567:

  interconnect: qcom: rpm: Use _optional func for provider clocks (2023-01-05 17:29:57 +0200)

----------------------------------------------------------------
interconnect fixes for v6.2-rc

This contains fixes for a rare boot hang issue that has been reported
on the db820c dragonboard.

- dt-bindings: interconnect: Add UFS clocks to MSM8996 A2NoC
- interconnect: qcom: msm8996: Provide UFS clocks to A2NoC
- interconnect: qcom: msm8996: Fix regmap max_register values
- interconnect: qcom: rpm: Use _optional func for provider clocks

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Konrad Dybcio (4):
      dt-bindings: interconnect: Add UFS clocks to MSM8996 A2NoC
      interconnect: qcom: msm8996: Provide UFS clocks to A2NoC
      interconnect: qcom: msm8996: Fix regmap max_register values
      interconnect: qcom: rpm: Use _optional func for provider clocks

 Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml | 24 +++++++-
 drivers/interconnect/qcom/icc-rpm.c                          |  2 +-
 drivers/interconnect/qcom/msm8996.c                          | 19 ++++--
 3 files changed, 38 insertions(+), 7 deletions(-)
