Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB556E095D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 10:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjDMIxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 04:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjDMIxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:53:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4554993CA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 01:53:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F40911FD68;
        Thu, 13 Apr 2023 08:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681375985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vw1ZoNwWrSTGCF9w3p1Uuiz6HkW0chKEEXorzYdcJC8=;
        b=fdEKnQ9DznBOosiiDYeBvRSZ4TdmZiA9We57/ZfpE/tUk5DzZ+sbRtX9EEM2Ow7QBa1yQy
        RsMvuZoF/BnCguN5YcrEaL+EsFFNu7JgdaJ0min47h6wyt7WNAafY5SMOtbLe9ZRNVS5vu
        Gx+GoJyuW0U4Z/Z14udlXGHYTGda2xI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681375985;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vw1ZoNwWrSTGCF9w3p1Uuiz6HkW0chKEEXorzYdcJC8=;
        b=mFlVifnwk8TtEc5aaOWUwgDbFirHu/qEIAW+bmbqRAvZPQphqnw9nuQeCukJIUdiuvkmMr
        p/glk/SPaCfJ4KBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E205313421;
        Thu, 13 Apr 2023 08:53:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EBLyNvDCN2RyIAAAMHmgww
        (envelope-from <iivanov@suse.de>); Thu, 13 Apr 2023 08:53:04 +0000
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Ivan T . Ivanov" <iivanov@suse.de>
Subject: [PATCH v2 2/2] ARM: dts: Add nvmem node for BCM2711 bootloader public key
Date:   Thu, 13 Apr 2023 11:52:06 +0300
Message-Id: <20230413085206.149730-3-iivanov@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230413085206.149730-1-iivanov@suse.de>
References: <20230413085206.149730-1-iivanov@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim Gover <tim.gover@raspberrypi.com>

Make a copy of the bootloader secure-boot public key available to the OS
via an nvmem node. The placement information is populated by the
Raspberry Pi firmware if a public key is present in the BCM2711
bootloader EEPROM.

Signed-off-by: Tim Gover <tim.gover@raspberrypi.com>
Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
---
 arch/arm/boot/dts/bcm2711-rpi.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2711-rpi.dtsi b/arch/arm/boot/dts/bcm2711-rpi.dtsi
index 98817a6675b9..e30fbe84f9c3 100644
--- a/arch/arm/boot/dts/bcm2711-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2711-rpi.dtsi
@@ -15,6 +15,7 @@ aliases {
 		ethernet0 = &genet;
 		pcie0 = &pcie0;
 		blconfig = &blconfig;
+		blpubkey = &blpubkey;
 	};
 };
 
@@ -67,6 +68,19 @@ blconfig: nvram@0 {
 		no-map;
 		status = "disabled";
 	};
+
+	/*
+	 * RPi4 will copy the binary public key blob (if present) from the bootloader
+	 * into memory for use by the OS.
+	 */
+	blpubkey: nvram@1 {
+		compatible = "raspberrypi,bootloader-public-key", "nvmem-rmem";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x0 0x0 0x0>;
+		no-map;
+		status = "disabled";
+	};
 };
 
 &v3d {
-- 
2.35.3

