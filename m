Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DE362FD48
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242518AbiKRSxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242876AbiKRSv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:51:56 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2C78FF8A;
        Fri, 18 Nov 2022 10:51:55 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 7F4E23027;
        Fri, 18 Nov 2022 19:51:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1668797493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NMezbZ86aEnKi4RucMK6Z8Q0L8T/YZVy7XoJzzdgBDw=;
        b=qOUZlBKZ1mmdmsS5xamk7uGebSdSfgYf4BlGDg+yJSEfSkIbCd5+O++ZrmCQY1/kKeJ5ZL
        JiR4jEG10kDnfslSmoxgDphQKYEKBjxn2c4smJxo+6LVlxyscsmFUyOLupms73ZfTM8ujY
        RvS3GZQm+9N/EhGHsL1OnItweJK69SKGDlCchxFWCmIqk7cdY000mkyOmm9pun2D3kSMWb
        qyTO3NehO6RP+IzZqYC3JDf+G8ZJsaqAuuDPIdI6vfLxLv0l9WZpGfJN0hCr4eSwQzwf1L
        LdyH8W+oCuOCot76gbuggf0kZXJr1NzpvEPVJhHR1RzXCyMqsXImIWXwerGKWQ==
From:   Michael Walle <michael@walle.cc>
To:     Jonathan Corbet <corbet@lwn.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v3 18/18] MAINTAINERS: Add myself as ONIE tlv NVMEM layout maintainer
Date:   Fri, 18 Nov 2022 19:51:18 +0100
Message-Id: <20221118185118.1190044-19-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221118185118.1190044-1-michael@walle.cc>
References: <20221118185118.1190044-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

Following the introduction of the bindings for this NVMEM parser and the
layout driver, add myself as maintainer.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
changes since v2:
 - new patch

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ef4b7a31f8b4..101cff82ce44 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15499,6 +15499,12 @@ L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	drivers/hwmon/oxp-sensors.c
 
+ONIE TLV NVMEM LAYOUT DRIVER
+M:	Miquel Raynal <miquel.raynal@bootlin.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
+F:	drivers/nvmem/layouts/onie-tlv.c
+
 ONION OMEGA2+ BOARD
 M:	Harvey Hunt <harveyhuntnexus@gmail.com>
 L:	linux-mips@vger.kernel.org
-- 
2.30.2

