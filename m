Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7A36B683E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjCLQY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjCLQYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:24:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A3124734
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:23:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C909760F85
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 16:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32A1EC4339B;
        Sun, 12 Mar 2023 16:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678638061;
        bh=unOZNl7RbxCqiFsaFNvEzmLFLh31GO4jV0FCSTnGgHs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=U20jhAG/jJSYD4MuzSGYg2Ph5Gkm9KAzKuuN/3Y+yjnJM83oRRM7o+rwKXGEmH1qq
         MqNQLcFv+bzFyTqzKWvOUIlAViAf+1xaZJ57ZmQ8L3w3SkFwla9hyo6aZ2OVjxJ7kC
         w4cAfMZq3XPpwGrpOHNtj16z2dHtq/qgVAaBd5WHnNn7JDNCNvubtiIJNiqh/1DpAy
         Ssid0Ehdp9JdoMn1OFI3+VDdegHREOS2R+pNnR7fhkk1GT0Ou5q50A5r6Ver/kWm2u
         0rWRLTTYYukhfLMoo3r+AyDxwXpsJKY55+OgZfWfTr1TE85BoJ5oSSJAVPJ2NV6vHl
         L47SNeM05CD+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1DEA6E61B75;
        Sun, 12 Mar 2023 16:21:01 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230312113201.GAZA24MdYiw4Cq97sJ@fat_crate.local>
References: <20230312113201.GAZA24MdYiw4Cq97sJ@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230312113201.GAZA24MdYiw4Cq97sJ@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.3_rc2
X-PR-Tracked-Commit-Id: b0563468eeac88ebc70559d52a0b66efc37e4e9d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d3d0cac69fc509ece28a267c093d2f1094f88dba
Message-Id: <167863806111.16000.15461533141382189699.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Mar 2023 16:21:01 +0000
To:     Borislav Petkov <bp@alien8.de>
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

The pull request you sent on Sun, 12 Mar 2023 12:32:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.3_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d3d0cac69fc509ece28a267c093d2f1094f88dba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
