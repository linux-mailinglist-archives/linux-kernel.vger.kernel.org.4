Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7E55BCA71
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiISLMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiISLLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:11:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A39621E05;
        Mon, 19 Sep 2022 04:11:32 -0700 (PDT)
Date:   Mon, 19 Sep 2022 13:11:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663585890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=H0shSodpQ8wr2ZBQWx7H2T4on6Oaer0NGZFAOFgkPlI=;
        b=jUKAlFLlXQ+glCi4K4je/sfzdS34Y/qf4SMnMuT/zJo25508X63/ADNWd+rHIZ5zsEpjDW
        mtumNOAO1dZQw+bwBJnPBij6Yq3vYkDEFhjwjpYHaHIFqavJpmtsczJDS7Q8XUO/4hsHwg
        uN/o9Ple18Ts6egnKuqr+keZNfTQ4GPJ6o3/SctnleoIprG/vZFhnhHj4Whu4HPbdH1OCv
        vgJtwvNHhr/pGlqp1f3dt+ZkP9l4r0p5vDDRl96irZXNYP1gB4PupJu2qFCXQSPmUB8i3g
        YLVwXaDDkROO8mYa+7brek5tcKmhGBEv93D8GvhOSqamhATHbxyOtI9L/tVe1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663585890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=H0shSodpQ8wr2ZBQWx7H2T4on6Oaer0NGZFAOFgkPlI=;
        b=RkoJKsOHDveNtZyTwkMwkaXaz46LViqx32Few/LKBSmYbQoACFkYROVlxKBfIS90iPsxDC
        sIM7+02z/KrndTDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.0-rc6-rt9
Message-ID: <YyhOYFenu9V2jEPE@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v6.0-rc6-rt9 patch set. 

Changes since v6.0-rc6-rt8:

  - Drop a checkpatch patch. It has been superseded by another approach
    which is merged into the tip tree.

Known issues
     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v6.0-rc6-rt8 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.0/incr/patch-6.0-rc6-rt8-rt9.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.0-rc6-rt9

The RT patch against v6.0-rc6 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.0/older/patch-6.0-rc6-rt9.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.0/older/patches-6.0-rc6-rt9.tar.xz

Sebastian

diff --git a/localversion-rt b/localversion-rt
index 700c857efd9ba..22746d6390a42 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt8
+-rt9
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d130db6726414..79e759aac543b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5749,12 +5749,6 @@ sub process {
 			}
 		}
 
-# rwlock.h must not be included directly. It will be included via spinlock.h if needed.
-		if ($rawline =~ /\#\s*include.*\<linux\/rwlock\.h/) {
-			ERROR("INCLUDES_BAD_HEADER",
-				"Please don't include rwlock.h directly, use spinlock.h if needed.\n" . $herecurr);
-		}
-
 # warn if <asm/foo.h> is #included and <linux/foo.h> is available and includes
 # itself <asm/foo.h> (uses RAW line)
 		if ($tree && $rawline =~ m{^.\s*\#\s*include\s*\<asm\/(.*)\.h\>}) {
