Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55B065135D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbiLSTgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiLSTgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:36:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E5428C;
        Mon, 19 Dec 2022 11:36:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F0CCB80EF7;
        Mon, 19 Dec 2022 19:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D093C433D2;
        Mon, 19 Dec 2022 19:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671478571;
        bh=epnBLjt4Ve+p9cL+td7nEEfYISQTnqxK3OOoKHZSTls=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BfCZ9lKLlscZv93HuiADtWLw469qifMUBO6TH7IkPJ8CVwRTfDz1zYH3c1dlB8IIx
         +TYfMNRC03tzDa7FzX4dci7tZknduaO0i0JHQe7soc276rTLwPemQL7dmH2WglE/Ft
         56JZgMjOjk8b0YL1y2WcKkbvfsc2fJe9t0ezn1DBbi208BpqmWcvSzZwtdgLRj452L
         utphjuq6xtt1s78idRDy1z7xPKinbU62Kg9ezFeZu0khUkILoIKsBQCP/gY3MXzwN2
         //u0jBXFKOOsaTQ5Qnnivmc1UJ/2xK0H1XMfFEMepP8UkdrtdrU19g599rQ4niW48I
         IZNCI3ucFCENg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2315DC00445;
        Mon, 19 Dec 2022 19:36:11 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild updates for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNAR5JSqfOZ1WCHHPtjAQTOGiwpPEqshCheXrj7WSW1fMxg@mail.gmail.com>
References: <CAK7LNAR5JSqfOZ1WCHHPtjAQTOGiwpPEqshCheXrj7WSW1fMxg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kbuild.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNAR5JSqfOZ1WCHHPtjAQTOGiwpPEqshCheXrj7WSW1fMxg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v6.2
X-PR-Tracked-Commit-Id: 731c4eac848ff9dd42776da8ed3407b257e3abf0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6feb57c2fd7c787aecf2846a535248899e7b70fa
Message-Id: <167147857112.10172.16891309809763885215.pr-tracker-bot@kernel.org>
Date:   Mon, 19 Dec 2022 19:36:11 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 18 Dec 2022 05:23:59 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6feb57c2fd7c787aecf2846a535248899e7b70fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
