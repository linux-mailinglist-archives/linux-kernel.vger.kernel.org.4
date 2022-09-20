Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5B25BDE70
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiITHjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiITHjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:39:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8650260522;
        Tue, 20 Sep 2022 00:39:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F88F62492;
        Tue, 20 Sep 2022 07:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41828C43158;
        Tue, 20 Sep 2022 07:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663659539;
        bh=ORGJx+pieiDyOt7N1yDp+SZUKncCqhqusGHMQ0HumRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LhPg5YpLc2kD6bUsH3cpT+KqhlWIrHUfFOoz83w9H648wqEu7/PiLc6sOECVUmr/B
         k8JxVRiqowOXnzcD0xDkYnYOxxnHK7nYGL5JfdSHhybSfS5rk5He3B3wNyZKT4YDUT
         U28/zt2qsxMv+UU1vlnrUqoIyE8PYqDlMNtSPuuRTnlNZy2OvHFL29KTkiQ6L3Vphu
         uZ7gGA2p7O2QcA/lbCXDANsTmC0+pokX6GX4TXGnWxCzJDr0+evGKp6rZjRPJoAPha
         7nHL0y6vu8JqItUUXi/Quh/yTW94X/BPxZ8yCS4GcwliKXQGrvuQyS6Cgeu51cNRhl
         vp/+8R5GmNm2Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oaXqP-0005Qx-Ui; Tue, 20 Sep 2022 09:39:01 +0200
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
Subject: [PATCH 08/17] phy: qcom-qmp-pcie-msm8996: drop unused kernel doc
Date:   Tue, 20 Sep 2022 09:38:17 +0200
Message-Id: <20220920073826.20811-9-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220920073826.20811-1-johan+linaro@kernel.org>
References: <20220920073826.20811-1-johan+linaro@kernel.org>
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

Drop the removed mode field from the struct qmp_phy kernel doc.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
index 7e755213e9c5..e261837aee32 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
@@ -238,7 +238,6 @@ struct qmp_phy_cfg {
  * @index: lane index
  * @qmp: QMP phy to which this lane belongs
  * @lane_rst: lane's reset controller
- * @mode: current PHY mode
  */
 struct qmp_phy {
 	struct phy *phy;
-- 
2.35.1

