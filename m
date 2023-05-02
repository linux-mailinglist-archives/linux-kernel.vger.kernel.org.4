Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE42A6F41DF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 12:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbjEBKjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 06:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbjEBKjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 06:39:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757FE9B;
        Tue,  2 May 2023 03:38:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DEE861F54;
        Tue,  2 May 2023 10:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65486C433EF;
        Tue,  2 May 2023 10:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683023930;
        bh=7/fiKx5JOKgaQb4ObAuZZ5FqO1m0hBa3ZqHG5clQQeY=;
        h=From:To:Cc:Subject:Date:From;
        b=NGWilU2gXjwaZztlOvj8NanIsSMXuo/7hI4WBsp8OUOsvABz1W0XwiL2RukuKz5rq
         BG6U3HHk1A4Jamuc7+YBN8exZDz9FCtNYPXosO3k0EP2JE4CpByepgfNIjzLORIl7J
         CMhyjvgxWszEHG8DH0KAma+WnN6z4tRD8DVSUlu75+m+tb7d4kL6E194lHZ8X/Ltas
         4a3/crfXBgioAbpiOnbdq5TDVDMHXck0me+rNkNXIxVhBSRB2yZVzztn72yTfPpkkw
         1xkB9uqq3kewMUIrE6olYSBQDbJ0jmBCrLFQ50aveU//j5QR1wOJOOG5UQPripzq8H
         udwyrvbmGzVpA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ptnPI-00038v-98; Tue, 02 May 2023 12:38:53 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/2] phy: qcom-qmp: fix init-count imbalance
Date:   Tue,  2 May 2023 12:38:08 +0200
Message-Id: <20230502103810.12061-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two of the dedicated QMP PHY drivers suffer from a long-standing bug in
the common-block initialisation code.

Johan


Johan Hovold (2):
  phy: qcom-qmp-combo: fix init-count imbalance
  phy: qcom-qmp-pcie-msm8996: fix init-count imbalance

 drivers/phy/qualcomm/phy-qcom-qmp-combo.c        | 5 +++--
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.39.2

