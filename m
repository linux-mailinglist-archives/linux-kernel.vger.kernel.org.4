Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A68F649667
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 21:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiLKU7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 15:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiLKU67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 15:58:59 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C496ABE2D
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 12:58:57 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A79D620003;
        Sun, 11 Dec 2022 20:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670792334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OW+Jf3T9krEqob1pbgkYLip+2/YZDVH0nCzV5ngx3H4=;
        b=hSrfhxHpYnh6SR9rg0SK/FKC6cZs6qjSW5QNN8+nV9SsEncdePE8OBXOjFP6RdSxS/skqg
        3DQhmEiTgC+vDX83r7AHT4XPpeLAQMlxCtiGyNPiZJqPxKc/9+/xX8r/bGFIw0cH6/Baai
        1sPDKQucr8ywQ3ZKVlAeqUIdSt5ndsU/T05ZuMOD/z+Pdu63LhLalDrpZDT8qoD140k3ZX
        jGGQ+XD+o6BREzUStK+F0XIzAKmUuR+ezisOmm/77wM2rncQfv5cMax1DMTmH0SoUVvEvY
        O5Fmj4JDtPUdVgAl5lB6EXrjaClhpCyKkHn45jTD6h6iDdVK3ppzIOFvtYIcEA==
From:   alexandre.belloni@bootlin.com
To:     linux-i3c@lists.infradead.org
Cc:     Vitor Soares <vitor.soares@synopsys.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: mark I3C DRIVER FOR SYNOPSYS DESIGNWARE orphan
Date:   Sun, 11 Dec 2022 21:55:38 +0100
Message-Id: <20221211205539.19353-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

Vitor left Synopsys and the email address is now bouncing.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf0f18502372..ebd7f7c957ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9697,8 +9697,7 @@ F:	Documentation/devicetree/bindings/i3c/cdns,i3c-master.yaml
 F:	drivers/i3c/master/i3c-master-cdns.c
 
 I3C DRIVER FOR SYNOPSYS DESIGNWARE
-M:	Vitor Soares <vitor.soares@synopsys.com>
-S:	Maintained
+S:	Orphan
 F:	Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
 F:	drivers/i3c/master/dw*
 
-- 
2.38.1

