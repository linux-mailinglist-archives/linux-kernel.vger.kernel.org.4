Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A933F70A9FE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 20:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjETSXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 14:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjETSWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 14:22:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F36172D;
        Sat, 20 May 2023 11:22:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BFDC60BC9;
        Sat, 20 May 2023 18:21:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBB0C433D2;
        Sat, 20 May 2023 18:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684606870;
        bh=LEXUqYnFYNBp/lSZwiBu4F7bB23102+sZXyYbD4ZC0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dMuZwgs2aYztnCLjaZ6ffsMCJuTRSgri0lYFhUbd3wgVRmUuQixPc8wnTD+pbrjZa
         zyHNwgLS3loXadBcVvM0xG/bZBsZKWX9I10poPO3gvUYJSdbxgpLm1L8mi+1VqAEdD
         duqL5UZctiDhWO+CaRAK+lydw+U/6/aRM7IeyQLThmm8ThXJSBa5+dDEaxwk3iUYT+
         M+W1oeKeYBlUjuay+W+aGzM6qb8hqwQ0PgkybU7cUPZNn75D36957Ev08jm/hjuJ1+
         IpJOakfFAHBjMmwaNWpaAmuyLhqWkJpwwWH30adddRFAJSE1jaORPKxIWlQk2ZRz5v
         jPvG7bYSJSdzQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>, clemens@ladisch.de,
        jdelvare@suse.com, linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 04/14] hwmon: (k10temp) Add PCI ID for family 19, model 78h
Date:   Sat, 20 May 2023 14:20:32 -0400
Message-Id: <20230520182044.836702-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230520182044.836702-1-sashal@kernel.org>
References: <20230520182044.836702-1-sashal@kernel.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 7d8accfaa0ab65e4282c8e58950f7d688342cd86 ]

Enable k10temp on this system.

  [ bp: Massage. ]

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20230427053338.16653-3-mario.limonciello@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/k10temp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index be8bbb1c3a02d..823d0ca1d6059 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -507,6 +507,7 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
 };
-- 
2.39.2

