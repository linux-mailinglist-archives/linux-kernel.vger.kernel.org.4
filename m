Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5E170C363
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbjEVQ3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjEVQ3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:29:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C87FD;
        Mon, 22 May 2023 09:29:42 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-208-162.ewe-ip-backbone.de [91.248.208.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 19BB86606E69;
        Mon, 22 May 2023 17:29:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684772981;
        bh=1HX2q50s8U1vNgOF8gk5ASQbFDGRk4cCN9NGA82a0vU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oaPx0EhgcFiHTivfUTtRHXyJJAVDBWnJB5LLpwgonb20/EG1BrnvXhiJqb6wCQcKx
         bWB22JIM4FIJoEI967zS2RMZA73/MGvlCEKbvKlpOwH+W2TD31amZSe2S45BYAx5MS
         HtB7qHlXtKkdBTLWR7pYLkTu4ck0vCBC61oBxDWA67uSNYHLFy2Dr6O6YRh5+2Yp31
         LehxydzsZZK35Lbd9UUGAIPRKOr18oy0OndoSsDUcijxBbS7MoD5q+GgWKD6dxFKCb
         0mcV/LRqBAwRKA0nk8j7cS8fG4mWaWjjKugS+FT6lms+ijLLhuRWgpoQ2X03QGjK9k
         yEdwbayadnlyw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 004304807E2; Mon, 22 May 2023 18:29:37 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v5 3/3] usb: host: ohci-platform: increase max clock number to 4
Date:   Mon, 22 May 2023 18:29:37 +0200
Message-Id: <20230522162937.53190-4-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522162937.53190-1-sebastian.reichel@collabora.com>
References: <20230522162937.53190-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rockchip RK3588 OHCI requires 4 clocks to be enabled.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/usb/host/ohci-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index a84305091c43..dec38a845cff 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -33,7 +33,7 @@
 #include "ohci.h"
 
 #define DRIVER_DESC "OHCI generic platform driver"
-#define OHCI_MAX_CLKS 3
+#define OHCI_MAX_CLKS 4
 #define hcd_to_ohci_priv(h) ((struct ohci_platform_priv *)hcd_to_ohci(h)->priv)
 
 struct ohci_platform_priv {
-- 
2.39.2

