Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F40B6BACEF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjCOKDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjCOKDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:03:15 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F34886DDC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 03:01:55 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CE2C524000E;
        Wed, 15 Mar 2023 10:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678874513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Puld4+WhROgZ/4Yw9OR4slf5b+hhfbuzWKmJzO6kHVg=;
        b=k2nFxy/36jtqWQ+3m7ylzj6fd5YIRkWAWXeuMD+pDVwGuD6D6TenmFq8G9QeDVavB4NBDB
        PMwsMOWlkErAbDGw1TOCVDs99gsxXEaY2ceDoXGzmUoD5EViaBh1nFat1p/YFkyuyXlNbT
        GPsYpcX5/Dw+ChLImwIj0SR0zHs94xFXNIOC709TN+HoWHCK3wF3C7X5xqT5JmAyR/nfKg
        FRTLLttyjE4sHjpvqrUwSvc6JU0ZgAczUGm8YKoboypWEGx52NQ7ZjQILBnEoTsfsB4lPj
        LvWxLQPfpJbEvfJLae1bYggLv3rQ9vMn1GMDpGyuShgES35cHd9m6onNSe+mnA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 4/4] nvmem: layouts: onie-tlv: Drop wrong module alias
Date:   Wed, 15 Mar 2023 11:00:18 +0100
Message-Id: <20230315100018.1660071-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315100018.1660071-1-miquel.raynal@bootlin.com>
References: <20230315100018.1660071-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

