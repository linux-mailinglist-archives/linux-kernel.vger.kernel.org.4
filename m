Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257896BE2A9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjCQIIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjCQIIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:08:11 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9123FC6424
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:07:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Ve2JLNs_1679040379;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Ve2JLNs_1679040379)
          by smtp.aliyun-inc.com;
          Fri, 17 Mar 2023 16:06:25 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     steve.wahl@hpe.com
Cc:     mike.travis@hpe.com, dimitri.sivanich@hpe.com,
        russ.anderson@hpe.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] x86/apic/uv: Clean up some inconsistent indenting
Date:   Fri, 17 Mar 2023 16:06:16 +0800
Message-Id: <20230317080616.20083-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional modification involved.

arch/x86/kernel/apic/x2apic_uv_x.c:111 early_get_pnodeid() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4561
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 482855227964..bdf7b2756dd3 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -108,7 +108,7 @@ static void __init early_get_pnodeid(void)
 	} else if (UVH_RH_GAM_ADDR_MAP_CONFIG) {
 		union uvh_rh_gam_addr_map_config_u  m_n_config;
 
-	m_n_config.v = uv_early_read_mmr(UVH_RH_GAM_ADDR_MAP_CONFIG);
+		m_n_config.v = uv_early_read_mmr(UVH_RH_GAM_ADDR_MAP_CONFIG);
 		uv_cpuid.n_skt = m_n_config.s.n_skt;
 		if (is_uv(UV3))
 			uv_cpuid.m_skt = m_n_config.s3.m_skt;
-- 
2.20.1.7.g153144c

