Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6E25F4892
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiJDRe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiJDReJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:34:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B4867172
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 10:34:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16F25614EC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 17:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC680C433D6;
        Tue,  4 Oct 2022 17:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664904845;
        bh=MNhb/oV1ewnj0/EV/+sFAcQHzmY8aOD5+qwRi0Y0mkU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uEqF2krD/nYTUNuSddAVZtJ233Zl4GakM6zfqWbdIrxN19OdGnlpD3lu3++qi2lFA
         D+3fwvLJeSXu8WqyL3U6DcGHzP36KKVSORfahkPHawA75P+ouhrlKB2qNYzGDwGOzJ
         inpAAocGQ7GuGfgTdg7AgVSQm6rZDgjevxZV01L6rCCTqCEj5slBvaC5jxXPGZ9SQc
         6aQ0aUvbyHSpyrCpH8PflIg9LuvkGUfYhazA3f5DSHu3m/wWo4X8Yt2HU381aMl9OF
         WgTcsG0jr7Okd9OqsQ91YD8YaYiQdrv/YBIeqecDDVU5WOKQo+raauL42dSK4Rpkca
         Blj1mJcyK2ekg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C22B5E21EC2;
        Tue,  4 Oct 2022 17:34:05 +0000 (UTC)
Subject: Re: [GIT PULL] x86/microcode for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YzxBLFqmudOPYKY5@zn.tnic>
References: <YzxBLFqmudOPYKY5@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YzxBLFqmudOPYKY5@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_microcode_for_v6.1_rc1
X-PR-Tracked-Commit-Id: 712f210a457d9c32414df246a72781550bc23ef6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5f0b11353a6a33a1accd0b742c80ed6b2f35ac0
Message-Id: <166490484579.22164.10089386462087646263.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Oct 2022 17:34:05 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 4 Oct 2022 16:20:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_microcode_for_v6.1_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5f0b11353a6a33a1accd0b742c80ed6b2f35ac0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
