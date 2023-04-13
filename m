Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7DC6E138E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 19:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjDMRcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 13:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDMRcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 13:32:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B17A93D6;
        Thu, 13 Apr 2023 10:31:56 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-212-251.ewe-ip-backbone.de [91.248.212.251])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 994AD6603220;
        Thu, 13 Apr 2023 18:31:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681407114;
        bh=1HX2q50s8U1vNgOF8gk5ASQbFDGRk4cCN9NGA82a0vU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bi+9/zmKoof51M4Dah5MH5BJlj/mFWVpjOAhxNAD5wbB/W60/c9eVDOU7VwhLFzKN
         3Uka0tTvR9v7/sV9Y6ow7qtcxRuLMdnlEFoIfMSGUEE1yhUkyYIFDaXpqHYDC2VzqU
         HFvkRXqupaJG7ciX/eCRC9RCTjvtY8A6D0ZriIJhkD25f4uC1YHEsD+XCPqz298SvV
         9D0vV2tsOPkD6muYchswVwwfjkd58Qc7jLg6pIMGK7LGu1jpkgL+By6wyUyZf65t9x
         acoHhWeLmTYlXDMHdXfAJaaUKz4m+TzQ8kEwsiEY5JllF1lZAk32ooioOHBwVr8t6b
         KnLFV4xWV10Bw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id CEB824807F0; Thu, 13 Apr 2023 19:31:51 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv4 3/3] usb: host: ohci-platform: increase max clock number to 4
Date:   Thu, 13 Apr 2023 19:31:50 +0200
Message-Id: <20230413173150.71387-4-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413173150.71387-1-sebastian.reichel@collabora.com>
References: <20230413173150.71387-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

