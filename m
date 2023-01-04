Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B72765DD67
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 21:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239824AbjADUIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 15:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239830AbjADUIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 15:08:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F687FCF1;
        Wed,  4 Jan 2023 12:08:31 -0800 (PST)
Date:   Wed, 04 Jan 2023 20:08:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672862909;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E8t7dQIyWK5WQjI17E7L9fh3dy/gkCN7U/fHMiEQLO0=;
        b=XIwZSc2VoNql0e7b1X4+VX0T2V0MW6Ixy72YlraZvE2piUUPT/xoyr7dYd5O3u0Pg+tQ7O
        oLx6Lpg53zSiPI2ubKGNHIVMKcRYubetPTUUlib98x92G0iBnjSXZbFrw8FA5bpB2qzcLd
        k7Jdp6bN/1oUi6Nudh0/LL7eXVRO+ZHdQewznFgI4AFOaBbuuVkkS+t3rAa5PatOytjF6f
        hzvFAX9u1gFugTAjHN7crpg6b332bA5W7uw+gi+8x30hQlrdss4gZr+3/Iz3Qnp57Tga4+
        M9IMT8A3pPFB2S4DMWT/d0NbjUrE4u8m4/PU4Fw7lVKkDeGf/gsfn3hbGDxUaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672862909;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E8t7dQIyWK5WQjI17E7L9fh3dy/gkCN7U/fHMiEQLO0=;
        b=pxeEgIEvUuLF7D0Hxj9uqAlmvWA/STFGsOvre6UpHckKwmHDSgzq3ql8B94Z0sZjD/WO91
        RccyTC4u2duqakCg==
From:   "tip-bot2 for Zhang Rui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/rapl: Add support for Intel Meteor Lake
Cc:     Zhang Rui <rui.zhang@intel.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230104145831.25498-1-rui.zhang@intel.com>
References: <20230104145831.25498-1-rui.zhang@intel.com>
MIME-Version: 1.0
Message-ID: <167286290849.4906.3624732511270016278.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     f52853a668bfeddd79f319d536a506f68cc2b478
Gitweb:        https://git.kernel.org/tip/f52853a668bfeddd79f319d536a506f68cc2b478
Author:        Zhang Rui <rui.zhang@intel.com>
AuthorDate:    Wed, 04 Jan 2023 22:58:30 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 04 Jan 2023 21:00:28 +01:00

perf/x86/rapl: Add support for Intel Meteor Lake

Meteor Lake RAPL support is the same as previous Sky Lake.
Add Meteor Lake model for RAPL.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230104145831.25498-1-rui.zhang@intel.com
---
 arch/x86/events/rapl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index ae5779e..589c688 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -809,6 +809,8 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,	&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	&model_skl),
 	{},
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
