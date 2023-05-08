Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DB36FB1D8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbjEHNlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbjEHNl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:41:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C4033868;
        Mon,  8 May 2023 06:41:27 -0700 (PDT)
Date:   Mon, 08 May 2023 13:41:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683553285;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pDr6XCBRHrruP48zMzJ+ChN55e2Rx1d0obpc04QaIyE=;
        b=a/z2MhD6/20guLOItc9zWq/9V+uh3rijXAU44laa7YhHvf0NpXkHAKYTrXBxUAcXa/Bsuc
        HbjkdOT10g27W1T46Tml1duXy1nE3u2piZsRlp4j/mF/VuompWEGteciXR6A86PTHU0P7B
        FgpZvbGmDzflZbg9LM28HhXrud5UY8F34YKTqKdqUc2PTWSskWnCSrT47jvSxtRM1EiJ1B
        MhufgB7mO+dwW35KZlMHdvddyW+hhbryNO0MHWfP0YzVIgAv3Rct6Kap8WmdOQdJy5SyIp
        pzmmYtntr8K0I2+8c/+8jZrIqIheAnH91QDxMfZIvB/AtMdc+xYBPNuUAIMkNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683553285;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pDr6XCBRHrruP48zMzJ+ChN55e2Rx1d0obpc04QaIyE=;
        b=oGHzz82k0PTGMH5jUggZKElYl5fsmDwVN2Zhd70IqQLXRZrapgYFcvzO+O2MOVAY7KuS0L
        HGmovjQI2g7SL7AQ==
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
Message-ID: <168355328495.404.278386404769420617.tip-bot2@tip-bot2>
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

Commit-ID:     cb5d28c01b2d56700e1656cd6c3742b40e840bf9
Gitweb:        https://git.kernel.org/tip/cb5d28c01b2d56700e1656cd6c3742b40e840bf9
Author:        Christian Kujau <lists@nerdbynature.de>
AuthorDate:    Sat, 18 Feb 2023 22:29:44 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 08 May 2023 15:35:00 +02:00

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
