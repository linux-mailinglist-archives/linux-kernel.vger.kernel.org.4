Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E41D6FE5A1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbjEJUvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237069AbjEJUvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:51:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE21C9006;
        Wed, 10 May 2023 13:50:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BB5F64059;
        Wed, 10 May 2023 20:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBE0C433D2;
        Wed, 10 May 2023 20:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683751803;
        bh=/cVgxAil8PWw7aNezkRshuCnH82jfUgncVom3ws6J2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HLmFhh62V1OxqI1wN4yFb7l+ijq8pjngr7CRCrI02KnXeqnbZzU3SjF3LFtKL5HQr
         cr5LUv6WXjoEsecASYY/njwjqKW+g60G0GxjlwAJ75SPnJkS/gacyBqKzhMtmDSHj1
         heP2haN7A29+nlAEwvWhch1n5+qAKtXwxfF5EEDsHOBVgktBqp3WqUJmiPzsAeDhBT
         ge/vJvRQkDIUxyTg7lN4JPWpwCdmrjsPDUKAowdlZlo6QZyghZvbXb+WDjf4fjxeAw
         2cNDemHp1f0aeRpWv2IQmDjTJdTsS7wJwo2VUDkncPDwuqQuVZMDDYkB+Px5lZILi7
         nLrxNzd9Ea5sw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 7/8] mfd: intel-lpss: Add Intel Meteor Lake PCH-S LPSS PCI IDs
Date:   Wed, 10 May 2023 16:49:48 -0400
Message-Id: <20230510204950.104873-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230510204950.104873-1-sashal@kernel.org>
References: <20230510204950.104873-1-sashal@kernel.org>
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

From: Jarkko Nikula <jarkko.nikula@linux.intel.com>

[ Upstream commit 72d4a1683741ee578da0e265886e6a7f3d42266c ]

Add Intel Meteor Lake PCH-S also called as Meteor Point-S LPSS PCI IDs.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Lee Jones <lee@kernel.org>
Link: https://lore.kernel.org/r/20230330132618.4108665-1-jarkko.nikula@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/intel-lpss-pci.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index dde31c50a6320..699f44ffff0e4 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -447,6 +447,21 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x7e79), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x7e7a), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x7e7b), (kernel_ulong_t)&bxt_i2c_info },
+	/* MTP-S */
+	{ PCI_VDEVICE(INTEL, 0x7f28), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x7f29), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x7f2a), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0x7f2b), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0x7f4c), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7f4d), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7f4e), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7f4f), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7f5c), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x7f5d), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x7f5e), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0x7f5f), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0x7f7a), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7f7b), (kernel_ulong_t)&bxt_i2c_info },
 	/* LKF */
 	{ PCI_VDEVICE(INTEL, 0x98a8), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x98a9), (kernel_ulong_t)&bxt_uart_info },
-- 
2.39.2

