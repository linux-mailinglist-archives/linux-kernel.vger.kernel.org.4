Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A1F6EE745
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbjDYSBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbjDYSA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:00:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9307E15475
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:00:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46A4163091
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 18:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A740EC433A0;
        Tue, 25 Apr 2023 18:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682445652;
        bh=0fntXS7O/JsZbgvf+cksEbgRz8f7VvuIFh6RfWKsZaM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=se/eYyN7Ilqmii3XWmqj+1qFzSFUMn32Afk2KnkgtehTItPWiMYrFhiGSzlv1ZlV5
         oYc7wU8fzSc7xWd2ps9oRbHpbxiEg7siIPXruaw2CgTFT39o6T95exK1VZuXIIOMj1
         m19fXR3vASj59STzfMkbyokrCpF01yOqc6ydFirzhnHxkfi3utZWN2NSd4v/VOCTO1
         HEG/FRLUbSFaUjBYOISRGelzwCjHIlwyGQDmdHTxTFQu9Y0U+M3q/RtgfeYJHjw9W8
         VryQ6WmTe9blWrC2qpp1s5HtEkvpkqQm/zv4YPJ+vzIScipbCZNPEA3LbvXZdfwnFU
         FfQu1DOOfrEmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90EF1E5FFC6;
        Tue, 25 Apr 2023 18:00:52 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cpu updates for v6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230424135407.GDZEaJ/7ELCwj7rg3W@fat_crate.local>
References: <20230424135407.GDZEaJ/7ELCwj7rg3W@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230424135407.GDZEaJ/7ELCwj7rg3W@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v6.4_rc1
X-PR-Tracked-Commit-Id: 36168bc061b4368ad19e82b06a6463c95d3bb9a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e3420f98f8984c4ffde72e6a877bccbcc9cad6b6
Message-Id: <168244565258.10431.2030937459275445181.pr-tracker-bot@kernel.org>
Date:   Tue, 25 Apr 2023 18:00:52 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 15:54:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v6.4_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e3420f98f8984c4ffde72e6a877bccbcc9cad6b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
