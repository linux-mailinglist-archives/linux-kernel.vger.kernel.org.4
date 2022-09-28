Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF5F5EE078
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbiI1P3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbiI1P2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:28:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0C72DE7;
        Wed, 28 Sep 2022 08:28:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB4B5B820F5;
        Wed, 28 Sep 2022 15:28:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE8DC433B5;
        Wed, 28 Sep 2022 15:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664378915;
        bh=mpt7Wt62/XLXSTtuLqLCkWtnDTklKqxsrGIGesPgzSY=;
        h=From:To:Cc:Subject:Date:From;
        b=gEyEUeBoQ+YktZsRsh1aS8RD+DjXy0gp5UoLVdGiwHhIYvLtTKEUuB4eddwBr+KK8
         O20Pqe1REMdRTYwZirSOParDIJvXUc+537WqWMOYjfyR14WY/Ey1MJY7gdGEYUMlWh
         JhmGwWF2/IpsII2OQTUP1mCNANT3QeIniMEWd3MKZHitVjfhddaayaYaVflOnn/k52
         ancsg2A70qx9lfwUvFmPOSnBgBd+Zs4QkvhLw1FmqFbSEKDM4zn1GW+ARQ9AmnOOMU
         LEqXHFxY3toOfZLcoayM+0hoVNX7kS5/w3Fqmu4tzj8xuYoH9PFB+RSbDgBOg7fm2b
         4jguI9lfBAqdA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1odYzJ-0007zY-EF; Wed, 28 Sep 2022 17:28:42 +0200
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
Subject: [PATCH 00/13] phy: qcom-qmp: more fixes and cleanups
Date:   Wed, 28 Sep 2022 17:28:09 +0200
Message-Id: <20220928152822.30687-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the next batch of QMP driver fixes and cleanups.

Johan


Johan Hovold (13):
  phy: qcom-qmp: fix obsolete lane comments
  phy: qcom-qmp-combo: drop unused UFS reset
  phy: qcom-qmp-pcie: drop unused common-block registers
  phy: qcom-qmp-pcie: unify ipq registers
  phy: qcom-qmp-pcie: unify sdm845 registers
  phy: qcom-qmp-pcie: drop bogus register update
  phy: qcom-qmp-pcie: clean up power-down handling
  phy: qcom-qmp-pcie: move power-down update
  phy: qcom-qmp-pcie-msm8996: clean up power-down handling
  phy: qcom-qmp-combo: clean up power-down handling
  phy: qcom-qmp-ufs: clean up power-down handling
  phy: qcom-qmp-usb: clean up power-down handling
  phy: qcom-qmp-pcie: clean up clock lists

 drivers/phy/qualcomm/phy-qcom-qmp-combo.c     | 30 ++-------
 .../phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c  | 12 +---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 67 +++++--------------
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       | 24 +++----
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c       | 22 ++----
 5 files changed, 40 insertions(+), 115 deletions(-)

-- 
2.35.1

