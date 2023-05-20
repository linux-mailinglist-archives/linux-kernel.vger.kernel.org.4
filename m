Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD4F70AA25
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 20:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjETSZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 14:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjETSYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 14:24:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97B1E75;
        Sat, 20 May 2023 11:23:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0382C60AFD;
        Sat, 20 May 2023 18:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA7BC433EF;
        Sat, 20 May 2023 18:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684606962;
        bh=cWB1dZy+1AbY9jcNQa0xPC8wJXDRMfc8M7uaWfwUlok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ExD7jnwjDiQaoY33tdOG7ZyDyBfnIYBtqVIavugLjYjOPAf4PljCEnHYDmsLTY6rA
         gsiqa9t2ufwJQQD4Wz6oHLjndaB7yzWJXbXWtKOSCiLYjTYgEzgMHlDeRa+4mnzuR6
         KpQlhDruOk6diCfmvQNmhowHYQo7errxt7xaS+tFpbI/7R0sn8yhPS9ngJlu3ijPYD
         DvJeGtHZiF+5ZpYGSKIETqui6U1X322dkZFfM1jvzdvbxe2+MXuqaz+jcmJp5Il0pR
         r0CWgmkky3ptWuUdZWykat9/f/tWYHjH98Zl+CF+B/kT7rpolJF5cxa/aNWVxiI2mO
         gWDcb46HCxymA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julian Winkler <julian.winkler1@web.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        mika.westerberg@linux.intel.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 05/11] platform/x86: intel_scu_pcidrv: Add back PCI ID for Medfield
Date:   Sat, 20 May 2023 14:22:08 -0400
Message-Id: <20230520182215.845131-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230520182215.845131-1-sashal@kernel.org>
References: <20230520182215.845131-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Winkler <julian.winkler1@web.de>

[ Upstream commit 4a9b6850c794e4394cad99e2b863d75f5bc8e92f ]

This id was removed in commit b47018a778c1 ("platform/x86: intel_scu_ipc:
Remove Lincroft support"), saying it is only used on Moorestown,
but apparently the same id is also used on Medfield.

Tested on the Medfield based Motorola RAZR i smartphone.

Signed-off-by: Julian Winkler <julian.winkler1@web.de>
Link: https://lore.kernel.org/r/20230416154932.6579-1-julian.winkler1@web.de
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel_scu_pcidrv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel_scu_pcidrv.c b/drivers/platform/x86/intel_scu_pcidrv.c
index 80abc708e4f2f..d904fad499aa5 100644
--- a/drivers/platform/x86/intel_scu_pcidrv.c
+++ b/drivers/platform/x86/intel_scu_pcidrv.c
@@ -34,6 +34,7 @@ static int intel_scu_pci_probe(struct pci_dev *pdev,
 
 static const struct pci_device_id pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x080e) },
+	{ PCI_VDEVICE(INTEL, 0x082a) },
 	{ PCI_VDEVICE(INTEL, 0x08ea) },
 	{ PCI_VDEVICE(INTEL, 0x0a94) },
 	{ PCI_VDEVICE(INTEL, 0x11a0) },
-- 
2.39.2

