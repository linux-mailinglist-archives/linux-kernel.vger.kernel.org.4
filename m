Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68425FE8DB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 08:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJNGYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 02:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJNGYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 02:24:43 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46AAB1D9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 23:24:41 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29E6OWCC047135;
        Fri, 14 Oct 2022 01:24:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1665728672;
        bh=qe2gyXvDE+BMFUGXRhvyFIUF6gnIH6JhuSdFdkENsv4=;
        h=From:To:CC:Subject:Date;
        b=vqQ6F6SCyObEcGuh/69h7LicGH4a45CEgONwQp1lOO7SGmyQV6v8h+belS2Y6vYNU
         F1EE/FBuCppgZyAZ1Mc68utQ5ZVyNC8/yIKt4a/RDJa9IYMwC0RWA3NEcxiXnpuZx1
         I68QcatdT7OXuB+yW1nxZY1Vr+V961HumaeKQ7lM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29E6OWHJ016002
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Oct 2022 01:24:32 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 14
 Oct 2022 01:24:32 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 14 Oct 2022 01:24:32 -0500
Received: from a0393678ub.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29E6OUaN003197;
        Fri, 14 Oct 2022 01:24:31 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH] MAINTAINERS: Update Kishon's email address in GENERIC PHY FRAMEWORK
Date:   Fri, 14 Oct 2022 11:54:24 +0530
Message-ID: <20221014062424.3327-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update Kishon's email address in GENERIC PHY FRAMEWORK maintainer
entry.

Cc: Kishon Vijay Abraham I <kishon@kernel.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9dc9a4aa2301..071428241c50 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8543,8 +8543,8 @@ F:	include/asm-generic/
 F:	include/uapi/asm-generic/
 
 GENERIC PHY FRAMEWORK
-M:	Kishon Vijay Abraham I <kishon@ti.com>
 M:	Vinod Koul <vkoul@kernel.org>
+M:	Kishon Vijay Abraham I <kishon@kernel.org>
 L:	linux-phy@lists.infradead.org
 S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-phy/list/
-- 
2.17.1

