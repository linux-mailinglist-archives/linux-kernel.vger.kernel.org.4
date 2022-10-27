Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5475660F686
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 13:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbiJ0Luz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 07:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJ0Luw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 07:50:52 -0400
Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0CA66B159
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 04:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=pL/rs
        MZcAfjalFQs06h+m85GbtUtZ1JtImfRSdcQ5Tc=; b=bCBQUDPX+M4Wz7QdrrkJg
        3HXYUNIa6mhOtu2vsv9Q7gzXuEoDuF/0/WyS+pxV/udAY4i9uYEEoSWgS78yhMIU
        nMORtnUESeMTGJYPaJxQ8dTem1QFZEMq/P+qdxbFop3wseCXvGvqkCDdQ8nkanmY
        XSquLeW7W3yzRAswWXc5hI=
Received: from jbd-ThinkPad-X1-Nano-Gen-1.. (unknown [223.104.68.105])
        by smtp11 (Coremail) with SMTP id D8CowACHiFR4cFpjPTZ_CQ--.21952S2;
        Thu, 27 Oct 2022 19:50:17 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.or, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] PCI: Add vendor ID for Quectel and Cinterion
Date:   Thu, 27 Oct 2022 19:50:05 +0800
Message-Id: <20221027115005.5051-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowACHiFR4cFpjPTZ_CQ--.21952S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1kXFWDKr13Jryktw1UWrg_yoWfWrg_Aw
        n7Waykur45uF1xtw4kZ345ZwnIk3s2vFnIvFZYkrs5uas0kFW5C3s7Gr97Xa4F9a1qkr15
        Jan2g34Iv3WYkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRKfOz7UUUUU==
X-Originating-IP: [223.104.68.105]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiMBmnZFWBzUxOwgAAsz
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In MHI driver, there are some companies product still
do not have their own PCI vendor macro. So we add it
here to make the code neat. Ref ID could be found in
link https://pcisig.com/membership/member-companies.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 include/linux/pci_ids.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index b362d90eb9b0..e3bfea06b90e 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -172,6 +172,10 @@
 #define PCI_DEVICE_ID_BERKOM_A4T		0xffa4
 #define PCI_DEVICE_ID_BERKOM_SCITEL_QUADRO	0xffa8
 
+#define PCI_VENDOR_ID_CINTERION		0x1269
+
+#define PCI_VENDOR_ID_QUECTEL		0x1eac
+
 #define PCI_VENDOR_ID_COMPAQ		0x0e11
 #define PCI_DEVICE_ID_COMPAQ_TOKENRING	0x0508
 #define PCI_DEVICE_ID_COMPAQ_TACHYON	0xa0fc
-- 
2.34.1

