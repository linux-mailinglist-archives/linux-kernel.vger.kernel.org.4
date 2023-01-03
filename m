Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6624A65C46F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjACQ7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 11:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjACQ7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 11:59:21 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F244CC5B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 08:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4rZt+/ZOnctX5K9vzjEgIu7kKeqecmK58ZccPLFcCgE=; b=jrKPRdfl9oSkIlnbr1BQ99/P85
        92wmbko73cvAHWp+40eG6orzloOXrLKx4XVkXXl3NwiReUBgRMloLinJqmxLYq5zA9lzKlGj/rU2Y
        CLmBjhZJdROUmEmFk8mHMtadVyL2FBXhJFKuikxuOrOPdvBqrSJX8uU99bvKpnvwLTXLWjmvt64EQ
        MEcHO/Awk5nhKCkqRHGCEc/0tUYWHrqlmhX48+9gld8Q+Qqmvwghw7/5wi8deuT9KpHUOyBq+H6Vw
        Smd87KHfplLNrwTj8xuN1GVvUDyDx628W3Mt6t+bKpuEIod5QSxsUdEztdcSKGhdGWh9oYZ0NjY1F
        S9jLhkNA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:32780 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1pCkdB-0005bv-TH; Tue, 03 Jan 2023 16:59:17 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1pCkdA-004huk-Ta; Tue, 03 Jan 2023 16:59:16 +0000
In-Reply-To: <Y7RezbPSGrO37NZZ@shell.armlinux.org.uk>
References: <Y7RezbPSGrO37NZZ@shell.armlinux.org.uk>
From:   "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH v3 1/5] nvmem: core: remove spurious white space
    Bartosz Golaszewski <bgolaszewski@baylibre.com>,Gaosheng Cui <cuigaosheng1@huawei.com>,Greg Kroah-Hartman <gregkh@linuxfoundation.org>,linux-arm-kernel@lists.infradead.org,linux-kernel@vger.kernel.org,Maxime Ripard <mripard@kernel.org>, Hector Martin <marcan@marcan.st>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1pCkdA-004huk-Ta@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Tue, 03 Jan 2023 16:59:16 +0000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a spurious white space in for the ida_alloc() call.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 321d7d63e068..bf11e0c36d60 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -764,7 +764,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (!nvmem)
 		return ERR_PTR(-ENOMEM);
 
-	rval  = ida_alloc(&nvmem_ida, GFP_KERNEL);
+	rval = ida_alloc(&nvmem_ida, GFP_KERNEL);
 	if (rval < 0) {
 		kfree(nvmem);
 		return ERR_PTR(rval);
-- 
2.30.2

