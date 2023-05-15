Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CA670318A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242403AbjEOP3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240538AbjEOP26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:28:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BD71BEF;
        Mon, 15 May 2023 08:28:57 -0700 (PDT)
Date:   Mon, 15 May 2023 15:28:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684164535;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JHkRtBnLgUXHekCUCH9zzjA8JoRFSuD+qEnkNCWR4Rg=;
        b=TidLpN4HmkuWKwu32AJAX1EL1oe/30cMlcY1fCfk+Jcnh+B8N7Kfy1in5ToJXH+hhnwx6n
        SBV+wIps71XKrqmgBa8/4r8AXvZ+SIFtzf1/dsRPMtCRjs6199LJy/Tj04JI3AQUAkxjY6
        wFBeR66y/R9h7N+0Efa60fk3QVTEFtAfsIHrgMTogo7ug964iv5EYgu89k+q8/XW+tTOFD
        DKG0pXWH+PPdE9jJaFjjqrCcP5zKQ1/JLE3SRwLUtpBaYCnu5RwYH2tzvV5+A95MiZQBGP
        T51i2NF3w0BHSlI/dMbaBVD6MQGxQTB9noCMtro6hfcjxqTJQRBbH93wU6SSDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684164535;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JHkRtBnLgUXHekCUCH9zzjA8JoRFSuD+qEnkNCWR4Rg=;
        b=GWjNHgoaC4oShKwj8ZAmo7mm+Y0Uo7D0MsToUfDCy2nP66/B5D3iC0KDAl2hy+G+eYGX8m
        0199MON2mI1Mz4Dw==
From:   "tip-bot2 for Christian Kujau" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] Documentation/process: Explain when tip branches
 get merged into mainline
Cc:     Borislav Petkov <bp@alien8.de>,
        Christian Kujau <lists@nerdbynature.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <8a1fd8b7-9fe3-b2b5-406e-fa6f5e03e7c0@nerdbynature.de>
References: <8a1fd8b7-9fe3-b2b5-406e-fa6f5e03e7c0@nerdbynature.de>
MIME-Version: 1.0
Message-ID: <168416453547.404.5378455363307181129.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     4f1192559707eaa7adef307f5b9ad3a444b248f8
Gitweb:        https://git.kernel.org/tip/4f1192559707eaa7adef307f5b9ad3a444b248f8
Author:        Christian Kujau <lists@nerdbynature.de>
AuthorDate:    Sat, 18 Feb 2023 22:29:44 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 May 2023 17:11:28 +02:00

Documentation/process: Explain when tip branches get merged into mainline

Explain when tip branches get merged into mainline.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Christian Kujau <lists@nerdbynature.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/8a1fd8b7-9fe3-b2b5-406e-fa6f5e03e7c0@nerdbynature.de
---
 Documentation/process/maintainer-tip.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/process/maintainer-tip.rst b/Documentation/process/maintainer-tip.rst
index 178c95f..93d8a79 100644
--- a/Documentation/process/maintainer-tip.rst
+++ b/Documentation/process/maintainer-tip.rst
@@ -421,6 +421,9 @@ allowing themselves a breath. Please respect that.
 The release candidate -rc1 is the starting point for new patches to be
 applied which are targeted for the next merge window.
 
+So called _urgent_ branches will be merged into mainline during the
+stabilization phase of each release.
+
 
 Git
 ^^^
