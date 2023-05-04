Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721B26F7512
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjEDTyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjEDTxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:53:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3045512489;
        Thu,  4 May 2023 12:47:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85BC8637D0;
        Thu,  4 May 2023 19:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1991DC4339C;
        Thu,  4 May 2023 19:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229658;
        bh=88DrcTD4xyYQHSI1a3da8u9WLiohSEBTY+mpseHKtRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WPGHWRk8wSsyNA4uGkxYNJaPrblir4vZos9j/11WoGF4Pgztg76P9zqziC8NzPxeu
         HgcAsF1xU9vRWlen0Nk2UNLi5bIBUdvpvpgbtaS/xI+WYjLRnkD8F/c8yDlIR/EzG3
         gl0MscBO6Fgiizlsek+2bjfGz5e7gbdxo1C2PbUh2NMx804IkW+WPhL6+wqS0nffOP
         O8N4sOtbURZDbDAC6rSf7dfjHLa6PTKM37W65aw9flChmZ/1z8mDY2TfJPLxRMkT0/
         m82qBkWOmGN7XGPBI/jfEpNpxKi/yru7h7Ubr+fLASuKtgiDeecvXqHCDq+KoX31gB
         H7BMD6XWxGZKg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, yaara.baruch@intel.com, daniel.gabay@intel.com,
        golan.ben.ami@intel.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 29/49] wifi: iwlwifi: add a new PCI device ID for BZ device
Date:   Thu,  4 May 2023 15:46:06 -0400
Message-Id: <20230504194626.3807438-29-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194626.3807438-1-sashal@kernel.org>
References: <20230504194626.3807438-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

[ Upstream commit c30a2a64788b3d617a9c5d96adb76c68b0862e5f ]

Add support for a new PCI device ID 0x272b once registering with PCIe.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230414130637.56342664110d.I5aa6f2858fdcf69fdea4f1a873115a48bd43764e@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 9c8908526194b..04c5e0c461f87 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -504,6 +504,7 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 
 /* Bz devices */
 	{IWL_PCI_DEVICE(0x2727, PCI_ANY_ID, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0x272b, PCI_ANY_ID, iwl_bz_trans_cfg)},
 	{IWL_PCI_DEVICE(0xA840, PCI_ANY_ID, iwl_bz_trans_cfg)},
 	{IWL_PCI_DEVICE(0x7740, PCI_ANY_ID, iwl_bz_trans_cfg)},
 #endif /* CONFIG_IWLMVM */
-- 
2.39.2

