Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C225272B2E2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 18:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjFKQsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 12:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjFKQs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 12:48:29 -0400
Received: from mail.gnu-linux.rocks (unknown [82.165.184.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C0A1AD;
        Sun, 11 Jun 2023 09:48:27 -0700 (PDT)
Received: from UM-350.Speedport_W_723V_1_49_000 (p5def8a02.dip0.t-ipconnect.de [93.239.138.2])
        by mail.gnu-linux.rocks (Postfix) with ESMTPSA id 71A6D3FC45;
        Sun, 11 Jun 2023 16:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnu-linux.rocks;
        s=mail; t=1686502106;
        bh=jVHH8/qqVTI5f+Xa/YcOtxZdUAMDSVlN7EJ2Eh9vf4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vHPVaHHiTVXmoTWZHlgtHQsFA39ejeFgtaoilU/pLomie1BDV0SJl17FPK5hH48ZY
         tUv7iHHVMuLdVztltnm1cAz7Wcu8blJJdyuCHjkU/v4nFpbCYHsS/1n3G8nzllyp5J
         +UVRMoZy73EO4CuAbpIrwjpL78AkumSbaBCiDQOExiSKQfZqoSiq3SuWzZmbJ42jts
         yNI5XqzAyp5qotRNQar0SdirKd2LoQoDtPaCSBCidFzjeP5RY3T+IMABDRIsdrF5mf
         ofR9hhXKp8yov6L+mma/fRMS16exCe3ShwO3lm1+38Mg+gtYvyT5IEL7w5QJOxwPON
         rmNFu4SmwGwGw==
From:   Johannes Roith <johannes@gnu-linux.rocks>
To:     jikos@kernel.org
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Roith <johannes@gnu-linux.rocks>
Subject: [PATCH 2/2] hid-mcp2200 - updated hid-id.h
Date:   Sun, 11 Jun 2023 18:48:11 +0200
Message-ID: <20230611164811.1388-2-johannes@gnu-linux.rocks>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230611164811.1388-1-johannes@gnu-linux.rocks>
References: <20230611164811.1388-1-johannes@gnu-linux.rocks>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added Product ID for Microchip MCP2200 so the module can be compiled
correctly.

Signed-off-by: Johannes Roith <johannes@gnu-linux.rocks>

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 5d29abac2300..b48cb8224e0d 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -912,6 +912,7 @@
 #define USB_DEVICE_ID_PICK16F1454_V2	0xf2f7
 #define USB_DEVICE_ID_LUXAFOR		0xf372
 #define USB_DEVICE_ID_MCP2221		0x00dd
+#define USB_DEVICE_ID_MCP2221		0x00df
 
 #define USB_VENDOR_ID_MICROSOFT		0x045e
 #define USB_DEVICE_ID_SIDEWINDER_GV	0x003b
-- 
2.41.0

