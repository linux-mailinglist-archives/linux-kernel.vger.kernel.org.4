Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627F261E868
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 02:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiKGBqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 20:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiKGBqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 20:46:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CA3D118;
        Sun,  6 Nov 2022 17:46:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7C7460E16;
        Mon,  7 Nov 2022 01:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3EEC433D6;
        Mon,  7 Nov 2022 01:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667785571;
        bh=wdW4MuLubcZsoo6RyAO3d6UmEsN46a6OqI3ERxcJLnY=;
        h=Date:From:To:Subject:From;
        b=WIaAzPu0qfn4DPxl8nsVRIDs0CpET1Lp1bu+JHYRl99Q1bZJujei4jJIWovZJRPPr
         /Qj1aDoubNKYZNsy2PrkMxTPNfQYqrTsr5k310Llt12KcthSGgU5NWax9e4Cfmaxow
         EwV4EwQqSC6LfSBdq7oKJsd0+NHjZHmNrQKCjln8sDPiKNtudYDmZhcMhF19peqWRE
         7pVlHmyQJs43lw22XLu/7UrpuQsJcNPeujS8GEwiKsNsk8zDV2tiV9Nmq0YuAFnkpF
         BND+lOYeqcQ6jCcvWJZT3Q/22NAK31rgqEpQ57f9wiBjvtCJEcvxMb6yKvQfw95rUG
         09rK5bJ6q3RPw==
Date:   Sun, 6 Nov 2022 17:46:09 -0800
From:   Mark Gross <markgross@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Danie l Wagner <dwagner@suse.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.9.327-rt197
Message-ID: <166778430472.25456.2119007061331575558@T470>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.327-rt197 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt-rebase
  Head SHA1: 526140e6fc728cfdda65e2c4ef6dd085eb5e3aec

Or to build 4.9.327-rt197 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.327.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/older/patch-4.9.327-rt197.patch.xz

Signing key fingerprint:

  A073 BC64 746A 086C DA24  97C8 F92D 73C9 A31A 1C17

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Mark Gross

