Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61211733EBF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 08:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345514AbjFQGkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 02:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbjFQGj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 02:39:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814A5294C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 23:39:51 -0700 (PDT)
Date:   Sat, 17 Jun 2023 06:39:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686983990;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s5pSv7CsvLRB031YGG+oJjdEDdCG65BQTlz1N1na0lo=;
        b=4U7pWFM9zb0Cm89rXGJOLUTeCDIsSmvDlGlTvTXucz638y2AY1zj+0OK9IUFkSfl1UNxcY
        UtnHefLP7wpetj1EcaUeGXune5L9RigXMr5S/z9dqQjiNiBlLCz7lvevEdctXpS+ZGJhUF
        cPDZb969tFButNVebuEohgLpDeRs9E89r5Nn1Ws5TZiPel43v1o9+pmk9Je5enIDNiBnc/
        CctUWOk65zg0UIYjoD524FRE9/EtNhtLaD9Iw+6KpnVSy9q5GBChKhipQlAqKSc7te1rEl
        US3J7caaYCI9MXN4e0k+z/jY9A0I6o8VnyragVV7yelMI/lNB+XA6M+Iand50g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686983990;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s5pSv7CsvLRB031YGG+oJjdEDdCG65BQTlz1N1na0lo=;
        b=Bcd6598Xieba30vOX8bc8xLz3Voa8kDomKCVPLHqonDhSmPZsBZLTWUJ7/UQZLRD7SEXjp
        IvWQrf6gVQd3jyDA==
From:   "irqchip-bot for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gicv3: Add a
 iort_pmsi_get_dev_id() prototype
Cc:     Arnd Bergmann <arnd@arndb.de>, Hanjun Guo <guohanjun@huawei.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230516200516.554663-5-arnd@kernel.org>
References: <20230516200516.554663-5-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <168698398963.404.14767196667583828029.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     415e84294798d1cb041c902168393054cc4ad211
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/415e84294798d1cb041c902168393054cc4ad211
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 16 May 2023 22:05:08 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 17 Jun 2023 07:21:24 +01:00

irqchip/gicv3: Add a iort_pmsi_get_dev_id() prototype

iort_pmsi_get_dev_id() has a __weak definition in the driver, and
an override in arm64 specific code, but the declaration is conditional
and not always seen when the copy in the driver gets built:

drivers/irqchip/irq-gic-v3-its-platform-msi.c:41:12: error: no previous prototype for 'iort_pmsi_get_dev_id' [-Werror=missing-prototypes]

Move the existing declaration out of the #ifdef block to ensure
it can be seen in all configurations.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230516200516.554663-5-arnd@kernel.org
---
 include/linux/acpi_iort.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index b43be09..6b70d02 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -26,13 +26,14 @@ int iort_register_domain_token(int trans_id, phys_addr_t base,
 			       struct fwnode_handle *fw_node);
 void iort_deregister_domain_token(int trans_id);
 struct fwnode_handle *iort_find_domain_token(int trans_id);
+int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
+
 #ifdef CONFIG_ACPI_IORT
 void acpi_iort_init(void);
 u32 iort_msi_map_id(struct device *dev, u32 id);
 struct irq_domain *iort_get_device_domain(struct device *dev, u32 id,
 					  enum irq_domain_bus_token bus_token);
 void acpi_configure_pmsi_domain(struct device *dev);
-int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
 void iort_get_rmr_sids(struct fwnode_handle *iommu_fwnode,
 		       struct list_head *head);
 void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode,
