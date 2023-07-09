Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F7174C565
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 17:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbjGIPQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 11:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbjGIPPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 11:15:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B901A2680;
        Sun,  9 Jul 2023 08:14:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85CBC60BFB;
        Sun,  9 Jul 2023 15:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7FCC433C7;
        Sun,  9 Jul 2023 15:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688915679;
        bh=djANkZTSu25obuYar9XTJizEMPBZ43FSY2Siql9GtcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q0K0arVaI0J6vGhTJlfimE3utvexDgk98l6hXPmJKSwvj8gTao6OVQoIYvgTWdLn/
         ImkewbPGCh1yxmtipdhccX38W1rYIDo2f+3cS23ptQhCP2XaiwrOAUOwvly2coGHm/
         1qFP3aisvbMXJNERbuVEsNID7x1MVkekodX5KKIaMfUI1Qz7iMAayTJx4V21JVFZk1
         GI4pDQ6hjz5Os+X4C2c09zpSjqS5xsLrilDGquOTaryZqaFFmQr44+s1ePtyVKu1BR
         yobdOTBrKSh+Z40sPtcFApKtMyjkqCocP0gzm9T31/LM+YqMO/faUES92CDcTGfQZx
         tv1xMPeIJAIxw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yi Kuo <yi@yikuo.dev>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        mukesh.sisodiya@intel.com, linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 20/22] wifi: iwlwifi: pcie: add device id 51F1 for killer 1675
Date:   Sun,  9 Jul 2023 11:13:54 -0400
Message-Id: <20230709151356.513279-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709151356.513279-1-sashal@kernel.org>
References: <20230709151356.513279-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.12
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yi Kuo <yi@yikuo.dev>

[ Upstream commit f4daceae4087bbb3e9a56044b44601d520d009d2 ]

Intel Killer AX1675i/s with device id 51f1 would show
"No config found for PCI dev 51f1/1672" in dmesg and refuse to work.
Add the new device id 51F1 for 1675i/s to fix the issue.

Signed-off-by: Yi Kuo <yi@yikuo.dev>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230621130444.ee224675380b.I921c905e21e8d041ad808def8f454f27b5ebcd8b@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 8f053054e0818..51808dc08eab8 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -681,6 +681,8 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x2726, 0x1672, iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675i_name),
 	IWL_DEV_INFO(0x51F0, 0x1671, iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675s_name),
 	IWL_DEV_INFO(0x51F0, 0x1672, iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675i_name),
+	IWL_DEV_INFO(0x51F1, 0x1671, iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675s_name),
+	IWL_DEV_INFO(0x51F1, 0x1672, iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675i_name),
 	IWL_DEV_INFO(0x54F0, 0x1671, iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675s_name),
 	IWL_DEV_INFO(0x54F0, 0x1672, iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675i_name),
 	IWL_DEV_INFO(0x7A70, 0x1671, iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675s_name),
-- 
2.39.2

