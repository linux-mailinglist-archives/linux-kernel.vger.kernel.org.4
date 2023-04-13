Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8576E09B5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjDMJIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDMJIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:08:16 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2405319A9;
        Thu, 13 Apr 2023 02:08:08 -0700 (PDT)
X-UUID: b2acd338d9da11edb6b9f13eb10bd0fe-20230413
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=IJBhdLEftjKd/RMnGVYFfq0WyqFuvFWPZWbwN8VhW4c=;
        b=HwqLloYfiwgtmvMZMDgMYLc4fyc2ujG+zhEyhGIQWwmENIbDkPSwaH6mStqOcpoYVigSSywSUcD2/bO3EiKLn/ljTgqyGjEuU7uFoxLlpAPz27LWi+gn124PCq7P8NvkUfv45dHqp/u+A3gc4DGncNNlVEGaEvXdveLjf6pB75w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:20c4eaad-0cfa-4d1a-b5ba-b0785c46c5a8,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:95
X-CID-INFO: VERSION:1.1.22,REQID:20c4eaad-0cfa-4d1a-b5ba-b0785c46c5a8,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:95
X-CID-META: VersionHash:120426c,CLOUDID:75cb34a1-8fcb-430b-954a-ba3f00fa94a5,B
        ulkID:230413170805P1IX5SS6,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: b2acd338d9da11edb6b9f13eb10bd0fe-20230413
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1434903257; Thu, 13 Apr 2023 17:08:04 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 13 Apr 2023 17:08:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 13 Apr 2023 17:08:02 +0800
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
Subject: [PATCH v1 0/6] GenieZone hypervisor drivers
Date:   Thu, 13 Apr 2023 17:07:29 +0800
Message-ID: <20230413090735.4182-1-yi-de.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on linux-next, tag: next-20230412.

GenieZone is MediaTek proprietary hypervisor solution, and it is running
in EL2 stand alone as a type-I hypervisor. It is a pure EL2
implementation which implies it does not rely any specific host VM, and
this behavior improves GenieZone's security as it limits its interface.

To enable guest VMs running, a driver (gzvm) is provided for VMM (virtual
machine monitor) to operate. Currently, the gzvm driver supports only
crosvm.

This series supports ioctl interfaces for userspace VMM(eg., crosvm) to
operate guest VMs lifecycle, irqchip for virtual interrupt handling,
asynchronous notifcation mechanism for VMM.

Yi-De Wu (6):
  docs: geniezone: Introduce GenieZone hypervisor
  dt-bindings: hypervisor: Add binding for MediaTek GenieZone hypervisor
  soc: mediatek: virt: geniezone: Introduce GenieZone hypervisor support
  soc: mediatek: virt: geniezone: Introduce irqchip for virtual
    interrupt injection
  soc: mediatek: virt: geniezone: Add ioeventfd support
  soc: mediatek: virt: geniezone: Add irqfd support

 .../bindings/hypervisor/mediatek,gzvm.yaml    |  30 +
 Documentation/virt/geniezone/introduction.rst |  34 +
 arch/arm64/include/uapi/asm/gzvm_arch.h       |  79 ++
 drivers/soc/mediatek/Kconfig                  |   2 +
 drivers/soc/mediatek/Makefile                 |   1 +
 drivers/soc/mediatek/virt/geniezone/Kconfig   |  17 +
 drivers/soc/mediatek/virt/geniezone/Makefile  |   5 +
 drivers/soc/mediatek/virt/geniezone/gzvm.h    | 126 +++
 .../mediatek/virt/geniezone/gzvm_eventfd.c    | 749 ++++++++++++++++++
 .../soc/mediatek/virt/geniezone/gzvm_hyp.h    |  72 ++
 .../mediatek/virt/geniezone/gzvm_irqchip.c    | 107 +++
 .../soc/mediatek/virt/geniezone/gzvm_main.c   | 233 ++++++
 .../soc/mediatek/virt/geniezone/gzvm_vcpu.c   | 296 +++++++
 drivers/soc/mediatek/virt/geniezone/gzvm_vm.c | 551 +++++++++++++
 include/uapi/linux/gzvm_common.h              | 291 +++++++
 15 files changed, 2593 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hypervisor/mediatek,gzvm.yaml
 create mode 100644 Documentation/virt/geniezone/introduction.rst
 create mode 100644 arch/arm64/include/uapi/asm/gzvm_arch.h
 create mode 100644 drivers/soc/mediatek/virt/geniezone/Kconfig
 create mode 100644 drivers/soc/mediatek/virt/geniezone/Makefile
 create mode 100644 drivers/soc/mediatek/virt/geniezone/gzvm.h
 create mode 100644 drivers/soc/mediatek/virt/geniezone/gzvm_eventfd.c
 create mode 100644 drivers/soc/mediatek/virt/geniezone/gzvm_hyp.h
 create mode 100644 drivers/soc/mediatek/virt/geniezone/gzvm_irqchip.c
 create mode 100644 drivers/soc/mediatek/virt/geniezone/gzvm_main.c
 create mode 100644 drivers/soc/mediatek/virt/geniezone/gzvm_vcpu.c
 create mode 100644 drivers/soc/mediatek/virt/geniezone/gzvm_vm.c
 create mode 100644 include/uapi/linux/gzvm_common.h

-- 
2.18.0

