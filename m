Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAEF70A9E5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 20:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjETSWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 14:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjETSVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 14:21:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E89E7C;
        Sat, 20 May 2023 11:21:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55B3660C16;
        Sat, 20 May 2023 18:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF36EC433D2;
        Sat, 20 May 2023 18:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684606875;
        bh=cWB1dZy+1AbY9jcNQa0xPC8wJXDRMfc8M7uaWfwUlok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=my5u3OxZ+1FcvF+20aLm48zM9SRPPWRkO8Ixu1wuElLQqDJMeuk6JAN5ceExNDv08
         Ncda8Tl5dB+fa1v0GIX++HYMjvjcibk7U9mgsmWAvLleT3MDh2tF2Cv4L40Ze4SK9E
         qIfSEuq1QjHQkWIe/WgoTA/d9/FduepW2jyF4lVV8tfuuVmi9nf9rRA7lh2MsUrO15
         97dJmK9UxA1Ov2t1/Z0Gx1/VcKC2nf/AGi3jNL9XdkwGm1RssHvvW6ZjDCNHIERAlj
         3bDIl9KQiUzprnaIO+SOQiwmbwl347/WYl4N+n0aFZ0Bimi0yoxT9Hl57ZrGp8Dslo
         Nmq7tH7H3oscQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julian Winkler <julian.winkler1@web.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        mika.westerberg@linux.intel.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 06/14] platform/x86: intel_scu_pcidrv: Add back PCI ID for Medfield
Date:   Sat, 20 May 2023 14:20:34 -0400
Message-Id: <20230520182044.836702-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230520182044.836702-1-sashal@kernel.org>
References: <20230520182044.836702-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

