Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4921560F9D3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbiJ0N4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbiJ0N4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:56:51 -0400
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077B0185418
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:56:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1666879003; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Bdq8jPhSQIsJWMxI4ng2jPj/PKMqqkcH1re7jdg1QBgCyboVwS0DeLST7Rw3w8mMYL+ELDLwAFE2nBYH54+t2S7QexuRf5j4HTChQVw00jWAq5UAZs2olmBrsSK0GsbHVAAsoA+BbvRvrsw1R0tGt6BxoUlLAkM0CS38KuPJM50=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1666879003; h=Content-Type:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=GovURUzTYW0B0CpcAXUDLRwwLt9nM36i1qpfsHPFVa4=; 
        b=koltOXjGMRmWBSxS/ydzvEZGAqpASHwRwh3jdlfmbbrmS+UHuPSFr+NgK3+CC/9z0BJu73QQpYRFmSTNTVADTz5+7kTCNsBt+p0947GOyxcN9VqADO0KBQlGsoS9zhef2Y9RoeFcpD7Qp1lR75vB3yToUKXG7G4UfUn7SHSbO4Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=t4rmin@zohomail.com;
        dmarc=pass header.from=<t4rmin@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1666879003;
        s=zm2022; d=zohomail.com; i=t4rmin@zohomail.com;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
        bh=GovURUzTYW0B0CpcAXUDLRwwLt9nM36i1qpfsHPFVa4=;
        b=ear0Ly3cCRT7lMMdP5m4wGXfybpC8DRF/bQMoivfr1XwFvwcbgfK+aemmAeza4mf
        gpYozFkaLfO+hHREIwF3xSNOdAmjSWribZ4RPV3GFdbqiQ5ABewl9cNiUfYCJL0wa7t
        NpqXq9XdFuDvcArnj5MVpmOXaRSz5hNc3geWlszw=
Received: from plymouth (103.47.132.38 [103.47.132.38]) by mx.zohomail.com
        with SMTPS id 1666879002063679.8011510916507; Thu, 27 Oct 2022 06:56:42 -0700 (PDT)
Date:   Thu, 27 Oct 2022 20:56:27 +0700
From:   Aaron Lawrence <t4rmin@zohomail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: rtllib_module: remove unnecessary
 parentheses
Message-ID: <20221027135627.vzc3woeuhrivozqz@plymouth>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is intended to remove unnecessary parentheses in the
rtllib_module.c file following the Linux kernel coding-style
regulations. The modification is recommended by the checkpatch script.

Signed-off-by: Aaron Lawrence <t4rmin@zohomail.com>
---
 drivers/staging/rtl8192e/rtllib_module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_module.c b/drivers/staging/rtl8192e/rtllib_module.c
index 41697ef55dbd..ce8b73f437a3 100644
--- a/drivers/staging/rtl8192e/rtllib_module.c
+++ b/drivers/staging/rtl8192e/rtllib_module.c
@@ -107,7 +107,7 @@ struct net_device *alloc_rtllib(int sizeof_priv)
 	spin_lock_init(&ieee->lock);
 	spin_lock_init(&ieee->wpax_suitlist_lock);
 	spin_lock_init(&ieee->reorder_spinlock);
-	atomic_set(&(ieee->atm_swbw), 0);
+	atomic_set(&ieee->atm_swbw, 0);
 
 	/* SAM FIXME */
 	lib80211_crypt_info_init(&ieee->crypt_info, "RTLLIB", &ieee->lock);
-- 
2.38.1

