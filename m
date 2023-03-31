Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CFD6D25B5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 18:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjCaQfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 12:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbjCaQfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 12:35:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AAC6A4E;
        Fri, 31 Mar 2023 09:31:54 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-213-136.ewe-ip-backbone.de [91.248.213.136])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A3BB8660319C;
        Fri, 31 Mar 2023 17:31:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680280312;
        bh=SqLwpD/VfjJuwJfI7aAMwd3dBIJssnUeBqE949br198=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZQvS1muqq+EBvB7L9UxgOVB8l6u7CjSEbOb8VFZnkPbAXcIj197OStDFJaT0oEuzV
         L1d8GAAjR+SrwPC32n++zin9CFOW1rv6UgzQQ2hxqRYbBtnElLydIHv+S+oK21YMCY
         rMKjAFjRQ9qtWouTl0ljIrkyRyWkAoOgoOhC5+BIS/LHFhcRXtrtyqCUgy1wUNtioe
         RKlRQPxfNgK3fPwxkKXbhf8gWKGt6N/BzmkL9XFS3k4a4dE9aSiYTc+YjViOurXiaE
         /9ZN26gz9b7nnIs1J9iVQmH4GQhAwUAzQrzY44xrhHKPjkRwOFb23v7Tk91CkIkVDI
         0Cg38srHvfQ1g==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 686A94807E3; Fri, 31 Mar 2023 18:31:50 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv1 2/2] usb: host: ohci-platform: increase max clock number to 4
Date:   Fri, 31 Mar 2023 18:31:48 +0200
Message-Id: <20230331163148.5863-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230331163148.5863-1-sebastian.reichel@collabora.com>
References: <20230331163148.5863-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rockchip RK3588 OHCI requires 4 clocks to be enabled.

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

