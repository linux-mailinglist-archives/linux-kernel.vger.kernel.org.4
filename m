Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD8D60E118
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbiJZMoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiJZMoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:44:05 -0400
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3834F95B2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 05:44:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1666788241; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=QN5FgsdNhFnCRS91LIc1akmaEeCbcgyHzXjErDezIqawzV0F+aaazgd79hi41Y73rHxyqkYU02iTRcsPBx4/aD06+yhV7AP9aKy50I8vJcU9nyfKjMQ3zk2DaIo1z3V+uSxsC2xT3nsbzNpDWe3+fg0FKWyn8xJmGGhlJHHYf/I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1666788241; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=NhEnCBIWiWhW0byYC8XES1kb52GQs7ocwSW0WqCzYhU=; 
        b=dky9QHdmNKDaZRvMGqvVSC0P9sT8h8h98WHNxHqJ6+4ioBbuCQc8z9Scgc7ymzcr3+vHTz/bLrxk1M9fOGSeg/Z20PZuHOx+dC+RgtEHWbvoR008mRrf9iL9bkpBlYQrD5wmFiT9NuJdiepvT110Jh15eKYLHZQbv9Rj2ICJHo4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=t4rmin@zohomail.com;
        dmarc=pass header.from=<t4rmin@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1666788241;
        s=zm2022; d=zohomail.com; i=t4rmin@zohomail.com;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
        bh=NhEnCBIWiWhW0byYC8XES1kb52GQs7ocwSW0WqCzYhU=;
        b=KREsLJTuBSGqOnc1o8WLJhi4ND33J/qKx8k2x3pg9Q/TQ8AyZFRSh4rXbc8tAcmT
        GJ1JTXY/+F4PDQ6I600+rcppd5k9cmYs42bqlVUHlP7JTB6yvaAJky/DHlahGLUq6YC
        DyoH9iVJooVktIgqsI5pU5IIQqSt1r2ckOFE2VEI=
Received: from plymouth (103.47.132.12 [103.47.132.12]) by mx.zohomail.com
        with SMTPS id 1666788239134352.55749610584144; Wed, 26 Oct 2022 05:43:59 -0700 (PDT)
Date:   Wed, 26 Oct 2022 19:43:51 +0700
From:   Aaron Lawrence <t4rmin@zohomail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] staging: rtl8192e: rtllib_crypt_tkip: rewritten
 comparison to NULL
Message-ID: <ca33296630627020694f4b653580f689a8a3d1c7.1666787061.git.t4rmin@zohomail.com>
References: <cover.1666787061.git.t4rmin@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666787061.git.t4rmin@zohomail.com>
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rewritten a comparison to NULL with a negation operator in
accordance with the Linux kernel coding-style regulations. The fix
was directly recommended by the checkpatch script.

Signed-off-by: Aaron Lawrence <t4rmin@zohomail.com>
---
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
index b8a52b9f9d07..9fdfcc017ee6 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
@@ -62,7 +62,7 @@ static void *rtllib_tkip_init(int key_idx)
 		return NULL;
 
 	priv = kzalloc(sizeof(*priv), GFP_ATOMIC);
-	if (priv == NULL)
+	if (!priv)
 		goto fail;
 	priv->key_idx = key_idx;
 
-- 
2.38.1

