Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F017636846
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239622AbiKWSFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239412AbiKWSDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:03:04 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D3A635D;
        Wed, 23 Nov 2022 10:02:29 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 989813B3B;
        Wed, 23 Nov 2022 19:02:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1669226547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rylqEwz1+bn7DE+ns+IvNz+B/VeOKU/ixN6d8R2r6nY=;
        b=Jlbm3mquRT12NKmKh5Kck//WtT5Mo3RuBQWhGkHvzlfBZo0Bqf3gpE2BSdPZtuJaJzxxYA
        n1HOAu3R4TK+Owx5qWbZUtoQc+YmkfzvbXW7LjNscyScjGBnv/CgcmzCjNBkLTiioi+PZc
        Uyug3VRFX/CxyZCJKu7xdeEiOqZfsW3E21I4U5TvjRsS3mOaPD2915uqI8cVSYAiMFCbjc
        kI8onZjhKhFoFAnl/Nwi8Wk7k63feDsnJ5tkuGy3PwrwdhhY728kUbd35oMdKhd612/p4g
        smwXO3O09BUX+/Fu8Be7XNjsmKqkrWrenMxEdhZ5XcyqbG6WCD8sX5kfwYpLkw==
From:   Michael Walle <michael@walle.cc>
To:     Jonathan Corbet <corbet@lwn.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v4 20/20] MAINTAINERS: Add myself as ONIE tlv NVMEM layout maintainer
Date:   Wed, 23 Nov 2022 19:01:51 +0100
Message-Id: <20221123180151.2160033-21-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221123180151.2160033-1-michael@walle.cc>
References: <20221123180151.2160033-1-michael@walle.cc>
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
changes since v3:
 - none

changes since v2:
 - new patch

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e0cc35d90b7..22abbbcf42c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15507,6 +15507,12 @@ L:	linux-hwmon@vger.kernel.org
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

