Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A346C5161
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjCVQ6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjCVQ6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:58:12 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6678923847
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:58:11 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6403F20008;
        Wed, 22 Mar 2023 16:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679504290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Puld4+WhROgZ/4Yw9OR4slf5b+hhfbuzWKmJzO6kHVg=;
        b=RkglC9iEarwf0gb7yLynF/Xk1XM9jP9Ah6S8B9jAROzFu61Rc/8hgokNhLDkvPB3Raw1bo
        vhNMU7OKr4mUWxX+rEEdXig/3rtCWrxZCQ3bnG8Q6NsDvhqFp9BjM17DaxoBtFyY351WwF
        GZs9S5qwH0mnQS1LdIl1Vor5oR9YD1oT26DeH3//2RgYqHdnEoOLxjINGuAOyorgOp++4o
        Yp8iGWh+Ir6ffCaXJJS/d5nR+j7xkNrTFoFv1b8C/pb+BUxUYF2cdmuzijdzKmmV7jwKhR
        XBkG37tWjrGNZ5IEDQqK60nbGm2xxt/Oo1nA4xpHF/w9Y6qunD/mAiYA2+NZiQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 4/4] nvmem: layouts: onie-tlv: Drop wrong module alias
Date:   Wed, 22 Mar 2023 17:58:04 +0100
Message-Id: <20230322165804.2240285-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230322165804.2240285-1-miquel.raynal@bootlin.com>
References: <20230322165804.2240285-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MODULE_ALIAS macro is misused here as it carries the
description. There is currently no relevant alias to provide so let's
just drop it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/nvmem/layouts/onie-tlv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvmem/layouts/onie-tlv.c b/drivers/nvmem/layouts/onie-tlv.c
index 661093de33b4..59fc87ccfcff 100644
--- a/drivers/nvmem/layouts/onie-tlv.c
+++ b/drivers/nvmem/layouts/onie-tlv.c
@@ -242,4 +242,3 @@ module_nvmem_layout_driver(onie_tlv_layout);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Miquel Raynal <miquel.raynal@bootlin.com>");
 MODULE_DESCRIPTION("NVMEM layout driver for Onie TLV table parsing");
-MODULE_ALIAS("NVMEM layout driver for Onie TLV table parsing");
-- 
2.34.1

