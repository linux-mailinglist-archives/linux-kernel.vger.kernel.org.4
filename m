Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635396E09BD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjDMJI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjDMJIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:08:17 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2BD1FE9;
        Thu, 13 Apr 2023 02:08:10 -0700 (PDT)
X-UUID: b2cd488ed9da11edb6b9f13eb10bd0fe-20230413
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=6/PuYp06JANxyecmjfdkLJaYOHvRKSYhlev5QUYet24=;
        b=i8oHJz+Tb42zhRG/Ecq97/bF4fDTQ3lZNe7weXKaGMIG6UtkqPBui+3E67lCWW13PQ1nZRPUHqj6OaOXDFNmZsjeQdITK1WD6bhF+NSsGzN0LLMmd4QvDxEL0FM2zwLwI2M+tfBzSmG+RBaAB0wOeL2b2KbvtuynZs5Pw6IAg+A=;
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.22,REQID:4028f8c9-7f03-4f3b-8ef4-14f6199d431d,IP:0,U
        RL:0,TC:0,Content:49,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS6885AD,AC
        TION:quarantine,TS:149
X-CID-INFO: VERSION:1.1.22,REQID:4028f8c9-7f03-4f3b-8ef4-14f6199d431d,IP:0,URL
        :0,TC:0,Content:49,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_US65DF41,ACTI
        ON:quarantine,TS:149
X-CID-META: VersionHash:120426c,CLOUDID:77cb34a1-8fcb-430b-954a-ba3f00fa94a5,B
        ulkID:230413170805VK1B60VM,BulkQuantity:0,Recheck:0,SF:48|38|29|28|17|19,T
        C:nil,Content:3,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: b2cd488ed9da11edb6b9f13eb10bd0fe-20230413
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1838058108; Thu, 13 Apr 2023 17:08:04 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 13 Apr 2023 17:08:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 13 Apr 2023 17:08:03 +0800
From:   Yi-De Wu <yi-de.wu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yingshiuan Pan <yingshiuan.pan@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Jades Shih <jades.shih@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Ze-Yu Wang <ze-yu.wang@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>,
        Yi-De Wu <yi-de.wu@mediatek.com>
Subject: [PATCH v1 1/6] docs: geniezone: Introduce GenieZone hypervisor
Date:   Thu, 13 Apr 2023 17:07:30 +0800
Message-ID: <20230413090735.4182-2-yi-de.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230413090735.4182-1-yi-de.wu@mediatek.com>
References: <20230413090735.4182-1-yi-de.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>

GenieZone is MediaTek proprietary hypervisor solution, and it is running
in EL2 stand alone as a type-I hypervisor. It is a pure EL2
implementation which implies it does not rely any specific host VM, and
this behavior improves GenieZone's security as it limits its interface.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 Documentation/virt/geniezone/introduction.rst | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/virt/geniezone/introduction.rst

diff --git a/Documentation/virt/geniezone/introduction.rst b/Documentation/virt/geniezone/introduction.rst
new file mode 100644
index 000000000000..1fffd6cbb4db
--- /dev/null
+++ b/Documentation/virt/geniezone/introduction.rst
@@ -0,0 +1,34 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+GenieZone Introduction
+======================
+
+
+Overview
+========
+GenieZone is MediaTek proprietary hypervisor solution, and it is running in EL2
+stand alone as a type-I hypervisor. It is a pure EL2 implementation which
+implies it does not rely any specific host VM, and this behavior improves
+GenieZone's security as it limits its interface.
+
+To enable guest VMs running, a driver (gzvm) is provided for VMM (virtual
+machine monitor) to operate. Currently, the gzvm driver supports only crosvm.
+
+
+Supported Architecture
+======================
+GenieZone now only supports MediaTek arm64 SoC.
+
+
+Platform Virtualization
+=======================
+We leverages arm64's timer virtualization and gic virtualization for timer and
+interrupts controller.
+
+
+Device Virtualizaton
+====================
+We adopts VMM's virtio devices emulations by passing io trap to VMM, and virtio
+is a well-known and widely used virtual device implementation.
+
-- 
2.18.0

