Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1369644D0D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 21:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiLFUJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 15:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiLFUH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 15:07:59 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C4BCE05;
        Tue,  6 Dec 2022 12:07:56 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 6619D3BCC;
        Tue,  6 Dec 2022 21:07:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1670357274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OSr1EP0rN/jCyH2mo6XotklYCk18q8zt9OH+MC01vJQ=;
        b=latWyCPcX4HErn8RDM5qU7sKtAcHd001IWsFnRR/zL0YUma1aM9YmVbHwF6I1Zxu44vBOA
        XQ4lm8JrTj9Ekk3+W5kZHe8HH1+0LRyRbomeOA0w1RZV+ufKh7k2LbYi+tBRDfjq0Erc+f
        gp+rxtbO65eFwSXjae4uEtdfaAoui+NbnYJTgrCpOnaUDyEw5ona/DcCSxEAuxVjnMficI
        ghnCN61irRa8ijBS1OvwhjUJv0Q3WLASR8Hmv+Glk9Efeaiur26mckCQvLGsTrapw76Jjh
        72k+i4h0N6RbT71PP8GvviQ7/9xP5Uov8UzDnou38SQepWxA3PoEnKnGN81W/A==
From:   Michael Walle <michael@walle.cc>
To:     Jonathan Corbet <corbet@lwn.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Walle <michael@walle.cc>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH v5 19/21] MAINTAINERS: add myself as sl28vpd nvmem layout driver
Date:   Tue,  6 Dec 2022 21:07:38 +0100
Message-Id: <20221206200740.3567551-20-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221206200740.3567551-1-michael@walle.cc>
References: <20221206200740.3567551-1-michael@walle.cc>
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

Add myself as a maintainer for the new sl28vpd nvmem layout driver.

Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since v4:
 - none

changes since v3:
 - none

changes since v2:
 - new patch

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index acb1a249e212..92e90fd7a19c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19134,6 +19134,12 @@ F:	drivers/irqchip/irq-sl28cpld.c
 F:	drivers/pwm/pwm-sl28cpld.c
 F:	drivers/watchdog/sl28cpld_wdt.c
 
+SL28 VPD NVMEM LAYOUT DRIVER
+M:	Michael Walle <michael@walle.cc>
+S:	Maintained
+F:	Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
+F:	drivers/nvmem/layouts/sl28vpd.c
+
 SLAB ALLOCATOR
 M:	Christoph Lameter <cl@linux.com>
 M:	Pekka Enberg <penberg@kernel.org>
-- 
2.30.2

