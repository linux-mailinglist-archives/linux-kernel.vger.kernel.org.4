Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF68F6B287F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjCIPQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjCIPPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:15:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB51946B2;
        Thu,  9 Mar 2023 07:15:00 -0800 (PST)
Date:   Thu, 9 Mar 2023 16:14:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678374898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=L0ut5A2YxWRkWpdHP5E3GMAlPPVxc9dYMp/47j8do5Y=;
        b=oItcK2ZHJx1EFmyWZstM8+/1SiiDDnT+KCVGdOMXJZii98FD2zixFOhv/3ma9O4uSWzIWx
        cbPb1WF6g7WJRlAguElyyqN9TVLPLMh67HBx9jXTu8Zl/q+nYP38ZtiSYrEy196mkONhjH
        2YDmjwv9aX928iTq4O2fJn20UvI1aoEC+qq56oZ0+V4s6RU3A4Z8f13Fl5As3XBLqUR9Ey
        FeLtV9doO/MyFlUL19TDJxAzCx/VG3Phtvbhe38Ci48PmYcXEyECNOQXes4q+bmtOrTZpW
        kNFk6EYnbm5J9hGfViF0swg+9h24lxuJpAN/Qd+oWUWcbhDdN0c66ttRB1AGoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678374898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=L0ut5A2YxWRkWpdHP5E3GMAlPPVxc9dYMp/47j8do5Y=;
        b=zbeoKVkYjK0oybMOkLY8mWISW0E57aW4ddCF8A+7c98shT+QDjFitQSLNveIwWWGKyrcDw
        CEPaTaRFqjR0d/AA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.3-rc1-rt1
Message-ID: <20230309151457.Z5BpEBUp@linutronix.de>
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

I'm pleased to announce the v6.3-rc1-rt1 patch set. 

Changes since v6.2-rt3:

  - Update to v6.3-rc1

Known issues
     - Crystal Wood reported that a filesystem (XFS) may deadlock while flushing
       during schedule.

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.3-rc1-rt1

The RT patch against v6.3-rc1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.3/older/patch-6.3-rc1-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.3/older/patches-6.3-rc1-rt1.tar.xz

Sebastian
