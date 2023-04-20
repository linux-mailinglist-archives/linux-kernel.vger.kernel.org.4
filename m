Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C0C6E9C69
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 21:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjDTTVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 15:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjDTTVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 15:21:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A0E2717
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 12:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682018420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NFDxpoy2DcBE5wK3y+F/p+EUL+YVKW5BxO5v43iU+ZQ=;
        b=bPsJPQGY1ZuqNuzVrgNf956mymdMKKgLrBNS2fYrpKmJ9uv7lqMNs9k9xzeNyMgk03vc5L
        /P3fTJXEMe/p/swE6wJnrlAPHClNzBWJ/ueMYf2WG4XWN//rZ1sjjcFM+ToYUT6VhwzlFu
        6qDFT5Oy5udn87+e4GpE4xmHrcHvoew=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-vtxokf2dPLKiumP7Y_Wsyg-1; Thu, 20 Apr 2023 15:20:16 -0400
X-MC-Unique: vtxokf2dPLKiumP7Y_Wsyg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B24BB3C025B0;
        Thu, 20 Apr 2023 19:20:15 +0000 (UTC)
Received: from cantor.redhat.com (unknown [10.2.16.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CAEA82166B33;
        Thu, 20 Apr 2023 19:20:14 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] iommu: amd: Fix up merge conflict resolution
Date:   Thu, 20 Apr 2023 12:20:13 -0700
Message-Id: <20230420192013.733331-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge commit e17c6debd4b2 ("Merge branches 'arm/mediatek', 'arm/msm', 'arm/renesas', 'arm/rockchip', 'arm/smmu', 'x86/vt-d' and 'x86/amd' into next")
added amd_iommu_init_devices, amd_iommu_uninit_devices,
and amd_iommu_init_notifier back to drivers/iommu/amd/amd_iommu.h.
The only references to them are here, so clean them up.

Fixes: e17c6debd4b2 ("Merge branches 'arm/mediatek', 'arm/msm', 'arm/renesas', 'arm/rockchip', 'arm/smmu', 'x86/vt-d' and 'x86/amd' into next")
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/amd/amd_iommu.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index c160a332ce33..ec139f540c08 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -15,9 +15,6 @@ extern irqreturn_t amd_iommu_int_thread(int irq, void *data);
 extern irqreturn_t amd_iommu_int_handler(int irq, void *data);
 extern void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid);
 extern void amd_iommu_restart_event_logging(struct amd_iommu *iommu);
-extern int amd_iommu_init_devices(void);
-extern void amd_iommu_uninit_devices(void);
-extern void amd_iommu_init_notifier(void);
 extern void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
-- 
2.38.1

