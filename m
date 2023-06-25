Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AE873D01C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 12:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjFYKdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 06:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjFYKdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 06:33:45 -0400
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235A2E44
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 03:33:37 -0700 (PDT)
Received: from newone.lan (unknown [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id F307D160F0D;
        Sun, 25 Jun 2023 12:33:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1687689214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vURs0dN7pFAtc/1rIOXHSQy4w1XN8ufieVIUbmodPfw=;
        b=yxge9f4ZK7Ht+yxKVbBuWKkSldUDdqgw9PHXsjHZCyMfpId5iad2mwKXTTisaUwbXaIcvJ
        Gov68vuREA+bzH8zOrjKHihNAm+NeGqZ5QX8TxQwKTY99JHgYSlXU6VAKLkOqOQqZxevuN
        YYUZovtX7CyOE5/GrPXRvfhnCHNL+RQ=
From:   David Heidelberg <david@ixit.cz>
To:     Jonathan Corbet <corbet@lwn.net>, David Heidelberg <david@ixit.cz>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: ACPI: fix typo in ssdt-overlays.rst
Date:   Sun, 25 Jun 2023 12:33:04 +0200
Message-Id: <20230625103305.115484-1-david@ixit.cz>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 Documentation/admin-guide/acpi/ssdt-overlays.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/acpi/ssdt-overlays.rst b/Documentation/admin-guide/acpi/ssdt-overlays.rst
index b5fbf54dca19..5ea9f4a3b76e 100644
--- a/Documentation/admin-guide/acpi/ssdt-overlays.rst
+++ b/Documentation/admin-guide/acpi/ssdt-overlays.rst
@@ -103,7 +103,7 @@ allows a persistent, OS independent way of storing the user defined SSDTs. There
 is also work underway to implement EFI support for loading user defined SSDTs
 and using this method will make it easier to convert to the EFI loading
 mechanism when that will arrive. To enable it, the
-CONFIG_EFI_CUSTOM_SSDT_OVERLAYS shoyld be chosen to y.
+CONFIG_EFI_CUSTOM_SSDT_OVERLAYS should be chosen to y.
 
 In order to load SSDTs from an EFI variable the ``"efivar_ssdt=..."`` kernel
 command line parameter can be used (the name has a limitation of 16 characters).
-- 
2.39.2

