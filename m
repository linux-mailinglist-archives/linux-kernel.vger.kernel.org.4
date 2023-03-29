Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33D66CF4FC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 23:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjC2VDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 17:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjC2VDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 17:03:39 -0400
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1899F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 14:03:36 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 3638 invoked from network); 29 Mar 2023 23:03:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1680123811; bh=2BooZedm2mYU1eSgFeu3gvu/Vm00TPwyU1q5ew0wI88=;
          h=From:To:Subject;
          b=WLEXLiU9tCerjsLudAoVhqPLPRUfFYA36Qq7lackobZ2DTPHTsnxVOVBV3Y7njNbH
           rMFaz/sTiZIHZJvfGsulS7riqX3oo37a9XP9YzxFOJy3w9enLocKkQEn32cY4LSj4W
           hzgAvIWSIyZ76zcIre24gIhXdyjGsSfCbUZ5AQ78=
Received: from 79.184.247.17.ipv4.supernova.orange.pl (HELO LAPTOP-OLEK.home) (olek2@wp.pl@[79.184.247.17])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <tsbogend@alpha.franken.de>; 29 Mar 2023 23:03:31 +0200
From:   Aleksander Jan Bajkowski <olek2@wp.pl>
To:     tsbogend@alpha.franken.de, olek2@wp.pl, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: lantiq: remove unused function declaration
Date:   Wed, 29 Mar 2023 23:03:28 +0200
Message-Id: <20230329210328.9320-1-olek2@wp.pl>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: dcd83bcf63fe89efd577f040785c58ef
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000B [ARO0]                               
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The removed function declaration is a leftover of the old gphy firmware
loader, that has been removed in d5103604f78e1afc29e586785af540c82b573f3a.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
index 4790cfa190d6..c2e0acb755cd 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
@@ -94,9 +94,6 @@ extern __iomem void *ltq_cgu_membase;
 #define LTQ_MPS_BASE_ADDR	(KSEG1 + 0x1F107000)
 #define LTQ_MPS_CHIPID		((u32 *)(LTQ_MPS_BASE_ADDR + 0x0344))
 
-/* allow booting xrx200 phys */
-int xrx200_gphy_boot(struct device *dev, unsigned int id, dma_addr_t dev_addr);
-
 /* request a non-gpio and set the PIO config */
 #define PMU_PPE			 BIT(13)
 extern void ltq_pmu_enable(unsigned int module);
-- 
2.30.2

