Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7CC709FDB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 21:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjESTZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 15:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjESTZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 15:25:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F75FD;
        Fri, 19 May 2023 12:25:36 -0700 (PDT)
Date:   Fri, 19 May 2023 21:25:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684524334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=aJhZWD2Wm9TCQhQWvm5jAMDg1cYqV2+CoAto+enKCiY=;
        b=Vu7AhKWF4+4pNSsjoeZRva/bsT/6u+ouMNWnERmxwkANVUR25NHazyYw/ZcRiXkF7S1te0
        PjgrkJeOu3xClfX4w6nbQ/ASBUBvRZDEP33OiL3wR8DN6vsorQOKdv42Lw4KXZQK0Q/IoC
        h+MVYfj8eld+JsQ6ESo0FRQCfHLzjOCp8cpG8RuwRXkUiJTp1LmEpnNFYDz9R9TBcFmDI3
        jMsp/bVSxkotJi1GyOS6c0ziJO68LomcZ1KOXe6kqyWI8hgfrcoOWtoB9AH84P4K7P9pOO
        SmWfir5nvYUITMA/yEWXk+LImKc4cza3OTofI4Wa6P2UqEqQD4KH0Y3Nrz4/kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684524334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=aJhZWD2Wm9TCQhQWvm5jAMDg1cYqV2+CoAto+enKCiY=;
        b=aPVtFR7Gmx9QgoSlomhzozWsyuN/70CMXoAzMJFfUPkoIets6Fm0rVKR4q9AVUdjTz0+f+
        jbn2Kx6I+0HvliDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.4-rc2-rt1
Message-ID: <20230519192532.z0vfxnlz@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v6.4-rc2-rt1 patch set. 

Changes since v6.3.3-rt15:

  - Rebase to v6.4-rc2

Known issues
     None

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.4-rc2-rt1

The RT patch against v6.4-rc2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.4/older/patch-6.4-rc2-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.4/older/patches-6.4-rc2-rt1.tar.xz

Sebastian
