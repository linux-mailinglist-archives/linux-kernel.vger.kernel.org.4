Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB146F2181
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 02:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347161AbjD2AKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 20:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347080AbjD2AKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 20:10:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2835261;
        Fri, 28 Apr 2023 17:10:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BAEB645CA;
        Sat, 29 Apr 2023 00:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EED0FC433EF;
        Sat, 29 Apr 2023 00:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682727013;
        bh=BwW0UsZGvK9imyj2hady2P7Sy9vnryrQcbIQFb8hT5w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mKvNyNAw33YYJkg2cSCMYgVZvMp5SoOIFucDPMDUxcq3dKSPM+IB9pbB7jhZcK+0o
         x+yhPgdbIcbLPHhCl7wat+JZQN+9/+/t+9uVt98I2MlrSkUYzSJb2qhTfUquKUUput
         lSbG8Bn5zrjP7yeFZywQze+WNQuzMit4tm4tmYpkQOxSRnjxcV9VLRnR5uS3ERPHmC
         xKfmi2TMCQO3LK3dxOt+jzoCXe1NVnpFniCIN3MbHsL51BgzpjFHRigr+W3h3OChDt
         uXBKPPiZzFcRM4o16RSawjyRyWAbVssAAPd/xCDLnjY1FIZej+sjJiiyY3HdK9ugdx
         Lec8EuSJL9YnQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1FF5C41677;
        Sat, 29 Apr 2023 00:10:12 +0000 (UTC)
Subject: Re: [git pull] m68knommu changes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <201e8b3c-dc53-2475-1cff-34dd21ceeeea@linux-m68k.org>
References: <201e8b3c-dc53-2475-1cff-34dd21ceeeea@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-m68k.vger.kernel.org>
X-PR-Tracked-Message-Id: <201e8b3c-dc53-2475-1cff-34dd21ceeeea@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v6.4
X-PR-Tracked-Commit-Id: 8ab89e9563161921ffc86724eb3217d228eaad57
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b23c1376db2dbbf784906bbcc8db81c304fa76a7
Message-Id: <168272701285.9526.8932368182594171111.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Apr 2023 00:10:12 +0000
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     torvalds@linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, gerg@kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Apr 2023 23:26:53 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b23c1376db2dbbf784906bbcc8db81c304fa76a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
