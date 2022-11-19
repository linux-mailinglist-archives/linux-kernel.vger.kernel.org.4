Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA16630F75
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 17:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbiKSQYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 11:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbiKSQYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 11:24:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B218443AF0;
        Sat, 19 Nov 2022 08:24:11 -0800 (PST)
Date:   Sat, 19 Nov 2022 16:24:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668875050;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JO9kPLYnuN9z55eNPJSY/THCRt4tVUPwIM1vs699eio=;
        b=tcSBFRRTTrOdRugBidxzcGBwVjZZES+A8xnkAXRZ2DTMfE+JASJKWI5wChmbfx9OJaP9Ya
        p0+4JxLRH1ZH719W7bIQhI3h6iTbmeTzqKFqYcPW+RxBwhesHmjL6Bp9TxvghU4UTpDS3J
        XqVuZBLfIE6w1Hk/R1NuLlxuDWndeLZ85pD6YbGyra2h+xmTqKC3SS+9aDWX0noCWx6p9X
        2Mm7H0Jh3n1zrvLTb4aI5vSpbNugmELulqhAbVdEozTaSJUUW09WETvZaF3ZY0jxwdtldU
        lY+siMN4W5ojvrrF61q96QLV4sJsjzlCAM/a9IKdikBZx+an94ULid6fIa78Vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668875050;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JO9kPLYnuN9z55eNPJSY/THCRt4tVUPwIM1vs699eio=;
        b=0oqKVBDAv9wwjFJGJiF0NZTYm4waOefFQUIZId2sFilbT2m3Afc/IoUqDpmyLjwADB5w+u
        5XCGSEyzGFEKfUAA==
From:   "tip-bot2 for Jithu Joseph" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Use appropriate type in
 microcode_sanity_check()
Cc:     Tony Luck <tony.luck@intel.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Borislav Petkov <bp@suse.de>, Ashok Raj <ashok.raj@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221117035935.4136738-7-jithu.joseph@intel.com>
References: <20221117035935.4136738-7-jithu.joseph@intel.com>
MIME-Version: 1.0
Message-ID: <166887504907.4906.8459321279475497881.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     2e13ab0158dd4a033d61a5baa8f9b5b7c9ea8431
Gitweb:        https://git.kernel.org/tip/2e13ab0158dd4a033d61a5baa8f9b5b7c9ea8431
Author:        Jithu Joseph <jithu.joseph@intel.com>
AuthorDate:    Wed, 16 Nov 2022 19:59:25 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 18 Nov 2022 21:51:56 +01:00

x86/microcode/intel: Use appropriate type in microcode_sanity_check()

The data type of the @print_err parameter used by microcode_sanity_check()
is int. In preparation for exporting this function to be used by
the IFS driver convert it to a more appropriate bool type for readability.

No functional change intended.

Suggested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20221117035935.4136738-7-jithu.joseph@intel.com
---
 arch/x86/kernel/cpu/microcode/intel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index c77ec1b..e48f05e 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -135,7 +135,7 @@ static void save_microcode_patch(struct ucode_cpu_info *uci, void *data, unsigne
 		intel_ucode_patch = p->data;
 }
 
-static int microcode_sanity_check(void *mc, int print_err)
+static int microcode_sanity_check(void *mc, bool print_err)
 {
 	unsigned long total_size, data_size, ext_table_size;
 	struct microcode_header_intel *mc_header = mc;
@@ -253,7 +253,7 @@ scan_microcode(void *data, size_t size, struct ucode_cpu_info *uci, bool save)
 		mc_size = get_totalsize(mc_header);
 		if (!mc_size ||
 		    mc_size > size ||
-		    microcode_sanity_check(data, 0) < 0)
+		    microcode_sanity_check(data, false) < 0)
 			break;
 
 		size -= mc_size;
@@ -792,7 +792,7 @@ static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
 		memcpy(mc, &mc_header, sizeof(mc_header));
 		data = mc + sizeof(mc_header);
 		if (!copy_from_iter_full(data, data_size, iter) ||
-		    microcode_sanity_check(mc, 1) < 0) {
+		    microcode_sanity_check(mc, true) < 0) {
 			break;
 		}
 
