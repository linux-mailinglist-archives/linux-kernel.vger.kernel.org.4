Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16F85BDE72
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiITHjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiITHjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:39:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86288606B8;
        Tue, 20 Sep 2022 00:39:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23F16B81C00;
        Tue, 20 Sep 2022 07:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23281C43141;
        Tue, 20 Sep 2022 07:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663659539;
        bh=eMzRMOuITtXlZDAcCmKMPvOjEHytU8mCI4T2I/LUy8Y=;
        h=From:To:Cc:Subject:Date:From;
        b=l/lrpngFflAzqTa/76oLoQ0FmopYCDJfwjEiNJY0kakl8JbMMM5a/AU1TptxXb3w9
         rAdgGARNHfi5tPVbOUL2TGeCjTf4iSuMHfCDk/t6mHUZ+YsRSZMPJw+yH5GqWlYRWt
         SZQf0+XZCCqKjIZvCMsb6Khn/0EvPxLzfL1ODpS5gp5DwKm5Uj9XoqqCuofKrKh+s7
         44NKMui20J5gRQIlBxMjmTDVQhJRcI/7Z65qHl7uZUXQWG8eQuiIlUhNBPeS/DToIZ
         NYBjs2uVvPCKU1Ksyp21e8NGoZZYCGISdK1F0wk+iazqzLnsmbhcAI6p+r4Lsm0wnI
         9dN2bkv7Xp/Ow==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oaXqO-0005Qc-Hg; Tue, 20 Sep 2022 09:39:01 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 00/17] phy: qcom-qmp: config and misc clean ups
Date:   Tue, 20 Sep 2022 09:38:09 +0200
Message-Id: <20220920073826.20811-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
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

Here's the next and hopefully last set of QMP driver cleanups for a
while.

These patches drops further configuration parameters that are unused or
redundant since the QMP driver split.

This notably includes consolidating the lane configuration, which for
legacy reasons was inconsistent.

Johan


Johan Hovold (17):
  phy: qcom-qmp-pcie: drop unused type from config
  phy: qcom-qmp-pcie-msm8996: drop unused type from config
  phy: qcom-qmp-ufs: drop unused type from config
  phy: qcom-qmp-usb: drop unused type from config
  phy: qcom-qmp-pcie: drop init and exit wrappers
  phy: qcom-qmp-usb: drop init and exit wrappers
  phy: qcom-qmp: drop unused forward declarations
  phy: qcom-qmp-pcie-msm8996: drop unused kernel doc
  phy: qcom-qmp-pcie: drop unused mode field
  phy: qcom-qmp-pcie: drop unused config field
  phy: qcom-qmp: drop unused index field
  phy: qcom-qmp-pcie: consolidate lane config
  phy: qcom-qmp-pcie-msm8996: rename nlanes config
  phy: qcom-qmp-combo: consolidate lane config
  phy: qcom-qmp-ufs: consolidate lane config
  phy: qcom-qmp-usb: consolidate lane config
  phy: qcom-qmp-combo: drop redundant DP config flag

 drivers/phy/qualcomm/phy-qcom-qmp-combo.c     | 104 +++++-----------
 .../phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c  |  14 +--
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      |  90 ++++----------
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       |  44 ++-----
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c       | 112 ++++--------------
 5 files changed, 89 insertions(+), 275 deletions(-)

-- 
2.35.1

