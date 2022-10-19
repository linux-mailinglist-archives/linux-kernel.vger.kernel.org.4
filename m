Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA34F604FD7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 20:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiJSSpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 14:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiJSSpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:45:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DD61C8D71;
        Wed, 19 Oct 2022 11:45:34 -0700 (PDT)
Date:   Wed, 19 Oct 2022 18:45:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666205133;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yFA++4VjtUU0Ehwjqr3dkN1rspvXDpJNYwm0N7tlHbQ=;
        b=hWyeEgNnWdm2n5VBObK2cH+jPOYLQ8JUbGGblBzEkFilkrhJK/Q/Mj6blCF6LIoHjX/rKj
        mvQa5gD9foiCJ7o63o0aXeC0XmZHguRG2UShrMMOF1Xkp/jwQkoFWbD2jQw3YeCDrT+8rV
        eC0O98moupEBMRAWOuRY7/dgMAYo03PJxWU/9eXQhYO/tkKsNEdObBuB9kmJfeFJdDV///
        8sXt2ZPDoN5Axya983CU6A1Ckf+0kdOMkSbrls9JV/s7+W0YdL5zq5phzY8OVs/nliw19F
        EF/VeHmqpPVVZb/X8Bz3SNI1dEZLfQgZQ4DKmwWdMF/uWn2GGkPWcXZ3oVP+uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666205133;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yFA++4VjtUU0Ehwjqr3dkN1rspvXDpJNYwm0N7tlHbQ=;
        b=hZDZREz1rM7sm8eztXA3HIDUr129NReVU7JQlNK/y5WDGzasUcLGdMGVGtdrp4RLT8HCaT
        auQirb2QAdxiRZAw==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mtrr: Add comment for set_mtrr_state() serialization
Cc:     Borislav Petkov <bp@alien8.de>, Juergen Gross <jgross@suse.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220820092533.29420-2-jgross@suse.com>
References: <20220820092533.29420-2-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <166620513111.401.160324987040371856.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     01c97c7303580682751b5aaae043b639bdcbacb3
Gitweb:        https://git.kernel.org/tip/01c97c7303580682751b5aaae043b639bdcbacb3
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Tue, 04 Oct 2022 10:10:08 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 19 Oct 2022 20:37:23 +02:00

x86/mtrr: Add comment for set_mtrr_state() serialization

Add a comment about set_mtrr_state() needing serialization.

  [ bp: Touchups. ]

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220820092533.29420-2-jgross@suse.com
---
 arch/x86/kernel/cpu/mtrr/generic.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 5581082..c8f8951 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -684,7 +684,10 @@ static u32 deftype_lo, deftype_hi;
 /**
  * set_mtrr_state - Set the MTRR state for this CPU.
  *
- * NOTE: The CPU must already be in a safe state for MTRR changes.
+ * NOTE: The CPU must already be in a safe state for MTRR changes, including
+ *       measures that only a single CPU can be active in set_mtrr_state() in
+ *       order to not be subject to races for usage of deftype_lo. This is
+ *       accomplished by taking set_atomicity_lock.
  * RETURNS: 0 if no changes made, else a mask indicating what was changed.
  */
 static unsigned long set_mtrr_state(void)
