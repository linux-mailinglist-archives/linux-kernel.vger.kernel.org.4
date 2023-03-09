Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FC26B2A4B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 17:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjCIQGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 11:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjCIQCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 11:02:24 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AC1F7EDF;
        Thu,  9 Mar 2023 08:02:23 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3EDDB2214D;
        Thu,  9 Mar 2023 16:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678377742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tdQ9Z0pKhccY3nAxYeCZXdxmClNrcqOqv/uxdQRKhl8=;
        b=1GOpxKfrjjGckfdWBckK8lTMMWjUiFaD2WxMxiMLn7VPCW+agT5PZwDUfFtXgQUXgYP8qR
        39pNiP/D9YTBFcwtQsh/i8ws+abIYU5huxxDLLtqovGZFa5bhLdVgKks57abtUZdbPsC8u
        oeRrrPseEbzJaCXGsr7VBwTtSMxWmXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678377742;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tdQ9Z0pKhccY3nAxYeCZXdxmClNrcqOqv/uxdQRKhl8=;
        b=9xjIyggr5kkLYDs+dyPnBfcVfnq0cuhQlKupTXSl2bzzfa99inGZUg3TUx4BhAPXNIVmzz
        LOlvRmwdNDI6/mAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D704713A73;
        Thu,  9 Mar 2023 16:02:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SFucMw0DCmQHbgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 09 Mar 2023 16:02:21 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, geert+renesas@glider.be, timur@kernel.org,
        rdunlap@infradead.org, paulus@samba.org, benh@kernel.crashing.org,
        linux@armlinux.org.uk, pjones@redhat.com, adaplas@gmail.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org, mbroemme@libmpq.org,
        thomas@winischhofer.net, James.Bottomley@HansenPartnership.com,
        sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        corbet@lwn.net
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 043/101] fbdev/macfb: Remove trailing whitespaces
Date:   Thu,  9 Mar 2023 17:01:03 +0100
Message-Id: <20230309160201.5163-44-tzimmermann@suse.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309160201.5163-1-tzimmermann@suse.de>
References: <20230309160201.5163-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix coding style. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/macfb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/macfb.c b/drivers/video/fbdev/macfb.c
index 312e35c9aa6c..44ff860a3f37 100644
--- a/drivers/video/fbdev/macfb.c
+++ b/drivers/video/fbdev/macfb.c
@@ -339,7 +339,7 @@ static int civic_setpalette(unsigned int regno, unsigned int red,
 {
 	unsigned long flags;
 	int clut_status;
-	
+
 	local_irq_save(flags);
 
 	/* Set the register address */
@@ -439,7 +439,7 @@ static int macfb_setcolreg(unsigned regno, unsigned red, unsigned green,
 	 * (according to the entries in the `var' structure).
 	 * Return non-zero for invalid regno.
 	 */
-	
+
 	if (regno >= fb_info->cmap.len)
 		return 1;
 
@@ -548,7 +548,7 @@ static int __init macfb_init(void)
 		return -ENODEV;
 	macfb_setup(option);
 
-	if (!MACH_IS_MAC) 
+	if (!MACH_IS_MAC)
 		return -ENODEV;
 
 	if (mac_bi_data.id == MAC_MODEL_Q630 ||
@@ -644,7 +644,7 @@ static int __init macfb_init(void)
 		err = -EINVAL;
 		goto fail_unmap;
 	}
-	
+
 	/*
 	 * We take a wild guess that if the video physical address is
 	 * in nubus slot space, that the nubus card is driving video.
@@ -774,7 +774,7 @@ static int __init macfb_init(void)
 			civic_cmap_regs = ioremap(CIVIC_BASE, 0x1000);
 			break;
 
-		
+
 		/*
 		 * Assorted weirdos
 		 * We think this may be like the LC II
-- 
2.39.2

