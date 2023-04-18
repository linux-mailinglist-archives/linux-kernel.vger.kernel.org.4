Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8E86E68B2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjDRPxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjDRPxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:53:06 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C246E12C92;
        Tue, 18 Apr 2023 08:52:41 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ponce-002J3n-R0; Tue, 18 Apr 2023 17:52:00 +0200
Received: from p5b13a017.dip0.t-ipconnect.de ([91.19.160.23] helo=z6.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ponce-003jUm-Kb; Tue, 18 Apr 2023 17:52:00 +0200
Received: from glaubitz by z6.fritz.box with local (Exim 4.96)
        (envelope-from <glaubitz@physik.fu-berlin.de>)
        id 1ponce-000voW-0k;
        Tue, 18 Apr 2023 17:52:00 +0200
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sh: pci: Remove unused variable in SH-7786 PCI Express code
Date:   Tue, 18 Apr 2023 17:51:49 +0200
Message-Id: <20230418155153.222214-1-glaubitz@physik.fu-berlin.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.160.23
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Addresses the following warning when building sdk7786_defconfig:

arch/sh/drivers/pci/pcie-sh7786.c:34:22: warning: 'dma_pfn_offset' defined but not used [-Wunused-variable]
   34 | static unsigned long dma_pfn_offset;
      |                      ^~~~~~~~~~~~~~

Fixes: e0d072782c73 ("dma-mapping: introduce DMA range map, supplanting dma_pfn_offset")

Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
---
 arch/sh/drivers/pci/pcie-sh7786.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/drivers/pci/pcie-sh7786.c b/arch/sh/drivers/pci/pcie-sh7786.c
index b0c2a5238d04..39bb5038e1c6 100644
--- a/arch/sh/drivers/pci/pcie-sh7786.c
+++ b/arch/sh/drivers/pci/pcie-sh7786.c
@@ -31,7 +31,6 @@ struct sh7786_pcie_port {
 
 static struct sh7786_pcie_port *sh7786_pcie_ports;
 static unsigned int nr_ports;
-static unsigned long dma_pfn_offset;
 size_t memsize;
 u64 memstart;
 
-- 
2.39.2

