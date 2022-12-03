Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9563364161A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 11:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiLCKua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 05:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLCKu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 05:50:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1944B10E7;
        Sat,  3 Dec 2022 02:50:26 -0800 (PST)
Date:   Sat, 03 Dec 2022 10:50:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670064624;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dPQIQu5mdTdhbDyvD0w06ZpJmMixlUWkvVk/ylgo9Ak=;
        b=vcVXB6eVuBmFXh2xP9rmxTK2tY83xr4AnGwq95R1PHezt/O8Dsm3TC+PM4CqTBugk6omXi
        YI7VizI+CDboAzprHQGQXitC4FHRmGhZtC9PpTM9BMigsKdMbwpnnQ09qUlQWmOHqskFmj
        y+9fWSCI/My9apkKKWOVcD9S3yKkcNTLpahqh2MpBtlpktMQL0BfSfEKUYu1KDGDJBPwnM
        TUMMx0tHbb+toJXpTfx9LmEMNdNDbO8cC3KW9UWeiDvyeFL2KsmAtqFV2gu/oSHZq3WNvg
        XouQ5JOhhYr1HUfym3c5vjeYbdQ/FmfE8weUT/y3gFBMBIN4w1Oddz7Er7t9vQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670064624;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dPQIQu5mdTdhbDyvD0w06ZpJmMixlUWkvVk/ylgo9Ak=;
        b=1YT5aANctk2PQLwY7is1jsHTfEAxgZvOG1QZPW5J57NOA8Eec0JjzHKci8LGITnj9k9oOz
        AVdSA2Dyzq07o7Cw==
From:   "tip-bot2 for Jithu Joseph" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] platform/x86/intel/ifs: Add missing kernel-doc entry
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jithu Joseph <jithu.joseph@intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167006462384.4906.5071508694876473649.tip-bot2@tip-bot2>
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

Commit-ID:     09265345cc8900cd0bf10c2ff98e51b495b2c5b2
Gitweb:        https://git.kernel.org/tip/09265345cc8900cd0bf10c2ff98e51b495b2c5b2
Author:        Jithu Joseph <jithu.joseph@intel.com>
AuthorDate:    Fri, 02 Dec 2022 21:24:45 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 03 Dec 2022 11:16:16 +01:00

platform/x86/intel/ifs: Add missing kernel-doc entry

Document the test_num member of struct ifs_data.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/lkml/774fd22a-aaee-758d-8195-77bac783ecbc@infradead.org/
---
 drivers/platform/x86/intel/ifs/ifs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index da1474e..046e393 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -208,6 +208,7 @@ union ifs_status {
  * @status: it holds simple status pass/fail/untested
  * @scan_details: opaque scan status code from h/w
  * @cur_batch: number indicating the currently loaded test file
+ * @test_num: number indicating the test type
  */
 struct ifs_data {
 	int	integrity_cap_bit;
