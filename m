Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28F86D190F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjCaHxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjCaHxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:53:12 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425A911176
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:52:38 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.187.55])
        by albert.telenet-ops.be with bizsmtp
        id evsc290071C8whw06vsc8b; Fri, 31 Mar 2023 09:52:36 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pi9Y6-00FTC0-I1;
        Fri, 31 Mar 2023 09:52:36 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pi9Yp-008Ra0-Qw;
        Fri, 31 Mar 2023 09:52:35 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/3] of: address: Document return value of of_address_to_resource()
Date:   Fri, 31 Mar 2023 09:52:28 +0200
Message-Id: <61ffcb5e87511dfa21af169efd04806101c48b8a.1680248888.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1680248888.git.geert+renesas@glider.be>
References: <cover.1680248888.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing return value documentation to the linuxdoc comment block
for the of_address_to_resource() function.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/of/address.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 4c5c3b7ab99449f2..6312b10885e85864 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -882,6 +882,8 @@ static int __of_address_to_resource(struct device_node *dev, int index, int bar_
  * @index:	Index into the array
  * @r:		Pointer to resource array
  *
+ * Returns -EINVAL if the range cannot be converted to resource.
+ *
  * Note that if your address is a PIO address, the conversion will fail if
  * the physical address can't be internally converted to an IO token with
  * pci_address_to_pio(), that is because it's either called too early or it
-- 
2.34.1

