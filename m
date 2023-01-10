Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35E3663DD5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237809AbjAJKRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238378AbjAJKQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:16:38 -0500
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC684551EC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 02:16:33 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 1CA0C1A009FB;
        Tue, 10 Jan 2023 18:16:47 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JOAek9nwWfFb; Tue, 10 Jan 2023 18:16:46 +0800 (CST)
Received: from localhost.localdomain.localdomain (unknown [219.141.250.2])
        (Authenticated sender: xupengfei@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 22E141A0090A;
        Tue, 10 Jan 2023 18:16:46 +0800 (CST)
From:   XU pengfei <xupengfei@nfschina.com>
To:     siglesias@igalia.com, jens.taprogge@taprogge.org,
        gregkh@linuxfoundation.org, andy.shevchenko@gmail.com,
        ilpo.jarvinen@linux.intel.com
Cc:     industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, XU pengfei <xupengfei@nfschina.com>
Subject: [PATCH 1/1] ipack: ipoctal: remove unnecessary (void*) conversions
Date:   Tue, 10 Jan 2023 18:16:14 +0800
Message-Id: <20230110101613.4519-1-xupengfei@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arg is a void * type and does not require a cast.

Signed-off-by: XU pengfei <xupengfei@nfschina.com>
---
 drivers/ipack/devices/ipoctal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ipack/devices/ipoctal.c b/drivers/ipack/devices/ipoctal.c
index fc00274070b6..39f0852e5ca7 100644
--- a/drivers/ipack/devices/ipoctal.c
+++ b/drivers/ipack/devices/ipoctal.c
@@ -253,7 +253,7 @@ static void ipoctal_irq_channel(struct ipoctal_channel *channel)
 static irqreturn_t ipoctal_irq_handler(void *arg)
 {
 	unsigned int i;
-	struct ipoctal *ipoctal = (struct ipoctal *) arg;
+	struct ipoctal *ipoctal = arg;
 
 	/* Clear the IPack device interrupt */
 	readw(ipoctal->int_space + ACK_INT_REQ0);
-- 
2.18.2

