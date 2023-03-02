Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3C36A8891
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 19:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjCBSeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 13:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjCBSeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 13:34:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D272FCE2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 10:34:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7C9961633
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 18:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4027AC4339B;
        Thu,  2 Mar 2023 18:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677782047;
        bh=VshokPhUNoAm9Ok8+3ndcCA6Nv2D4MXUtMGyljfUDPc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q1XYnl4eqru/zlcAR9TzpHXMJgalObsyV7Bsp9GIbreR/3oIcZymLOxT5ZY/Ey9xh
         Lko+dGF5yWe/ABnXDbGPYmlLxVC5359x10AYRIkD+2WSJchIVCCdhsZDfoLiE7YB3D
         OqG1qfOtXFhitxyYo2GMlUvsptdhFKqB2bOwThD2MZ6jP++hTpSTrmoix36bA2RoiZ
         2JuggmAUZyZ49DEOyTz/OSqkd52fG1NqsIVEgc/HkrhNuKI3fn+zZ8YjcdKeezBH9w
         MDH+jTahV/Hp1O7ImarTAN/CYBgo6OSPdo1+wNmyfI7JMItANVcCHYFb5dYImaIUVR
         cpfqXqcndGeSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D223E450A6;
        Thu,  2 Mar 2023 18:34:07 +0000 (UTC)
Subject: Re: [GIT PULL] objtool changes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZABYbRAg4XsuW2iI@gmail.com>
References: <ZABYbRAg4XsuW2iI@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZABYbRAg4XsuW2iI@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2023-03-02
X-PR-Tracked-Commit-Id: 00c8f01c4e84637c3db76f368b8687cb61f4dd9d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 857f1268a591147f7be7509f249dbb3aba6fc65c
Message-Id: <167778204718.4243.3009433725226099140.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Mar 2023 18:34:07 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Mar 2023 09:03:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2023-03-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/857f1268a591147f7be7509f249dbb3aba6fc65c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
