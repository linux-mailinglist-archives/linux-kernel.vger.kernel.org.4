Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AF4625723
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbiKKJns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbiKKJnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:43:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176117018F;
        Fri, 11 Nov 2022 01:43:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2C5CB824C3;
        Fri, 11 Nov 2022 09:43:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5643AC433D7;
        Fri, 11 Nov 2022 09:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668159796;
        bh=3XOhKP1Tw+dE+Z0WDa+cOwqy3LoEJTTDfDARVmjTFlU=;
        h=From:To:Cc:Subject:Date:From;
        b=oihJCNV+5QiTZAly+/3w62btAo9IrDM7Z4RNw9rVtgudyXcS2kn75vRh0PyMmR0dp
         wU1zfjIef/S7S2GBkoJ0SO2KjY8iweyvIjg4V/0UPkk8VzFimXLeitXPVa3+zjCtpP
         iq6iK3eV6hwgfYBomuN/vmrhlCej/525K2a4NBs1rpVgLgMatOy1z7x/209qtBEOLv
         YvoU1c41nZtxKL/wco4iEWVbL2Hq9UTt4kOp8Npqp15ZtbfuLM+JIJI1KICk5B/ZHm
         KUJ4R0B+Wf9g1q0CCazzYspBk61Xd4v2nvM8OTChN61paGUKlN7bzkfAkdDJn4oDXJ
         XFLcKq5Ghas8w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1otQYi-00030Z-Ai; Fri, 11 Nov 2022 10:42:48 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/3] phy: qcom-qmp: misc cleanups
Date:   Fri, 11 Nov 2022 10:42:36 +0100
Message-Id: <20221111094239.11547-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
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

Here are three cleanups to the non-combo QMP drivers for smaller issues
found while reworking the combo driver.

Johan


Johan Hovold (3):
  phy: qcom-qmp: drop unused type header
  phy: qcom-qmp-usb: drop redundant clock allocation
  phy: qcom-qmp-pcie: drop redundant clock allocation

 drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c |  2 --
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c         | 10 +++-------
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c          |  2 --
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c          | 10 +++-------
 4 files changed, 6 insertions(+), 18 deletions(-)

-- 
2.37.4

