Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C925F488E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJDRee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiJDReH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:34:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662311EC40
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 10:34:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD9AA614E9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 17:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34CDFC43145;
        Tue,  4 Oct 2022 17:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664904845;
        bh=P2HUiNFKlyZzqlrOKmToCqlZ/O97TKYokDb/lkAosNE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=j1PTD6PvNLIhxIx5zBs+Z83SvCp2zqu8B5RyYz6YgolOWYdmLLcxC5OfwNTdWqMGh
         TDe8ubc6hBZJTFnrz7iHoh0CG5r3XFeeuZ9VM/6+V3H7TsvQKQoDB8Iv6Q1Ji5e6rr
         pkWrafBtvE6bK5nZylVovZvcPsDjZYHiwwtXlVZgI9CKRhdi4CSFWW9VAGJJ3Hwv2h
         JQjdnozh/tMW2Vm+XZ4k3tNB/PZ+akIgW0ArB3kD11LhsIx+YW2NpJvmVWtCvTNyht
         eOE8T9nKMpXl6FqLEnYcRXGp/s4GvkNZs6LPpg4yQVgDrVdICTgL45HAOewfarEQZB
         POLjlfoOIRsXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25231E21EC2;
        Tue,  4 Oct 2022 17:34:05 +0000 (UTC)
Subject: Re: [GIT PULL] ras/core for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yzv6eCHCFWFp0adu@zn.tnic>
References: <Yzv6eCHCFWFp0adu@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yzv6eCHCFWFp0adu@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v6.1_rc1
X-PR-Tracked-Commit-Id: f9781bb18ed828e7b83b7bac4a4ad7cd497ee7d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51eaa866a50f3e5f006b0c4876ddfa0e5c72c5f0
Message-Id: <166490484514.22164.8703190285109216597.pr-tracker-bot@kernel.org>
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

The pull request you sent on Tue, 4 Oct 2022 11:18:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v6.1_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51eaa866a50f3e5f006b0c4876ddfa0e5c72c5f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
