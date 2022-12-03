Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22ED641209
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 01:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbiLCAaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 19:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbiLCAah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 19:30:37 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0D6F2325;
        Fri,  2 Dec 2022 16:30:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C8E47CE2015;
        Sat,  3 Dec 2022 00:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18301C433D6;
        Sat,  3 Dec 2022 00:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670027433;
        bh=zOSco/rvqGBRZIUbwEcYbG2Xji6rgg4W3FT+EOwdiRE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mwIvRFs76myfRsS1s/qbuLziq5GiFsqqoOV8DzsJjPk3NO7iNZh7bEga457CPKV5g
         m2G59x+ek3gtlyNuAldFTKd7IuzCtOL9Za8JtZBV8EyNGhgXa5H4ebw17wf3N8J8T1
         X2amo3aloY4hLhD0SD4Nm9CLcs1DYDsjxKFQXbqWhsGpjpXBUS3SuVJTyoB2FKo8Tn
         SquHmevEbpc8+LQdrbyftZqRzeFmMPLXgrkyQ9ev0RZYTOBKEPjEKr8YS/7Aj2kCbZ
         M+ToEcFX2AiusKNFUyyXJ2MIXca5ub1xy+BUX0Ysgg0WvvggEkMMKgV+sNFDWdTDyc
         rOsJEO9hm/UsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0366CC395EC;
        Sat,  3 Dec 2022 00:30:33 +0000 (UTC)
Subject: Re: [GIT PULL] pin control fixes for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdZZ7j3fciH+J6xu-MGHyxWMy-VK1MkXsfkHLdyy3=q4RA@mail.gmail.com>
References: <CACRpkdZZ7j3fciH+J6xu-MGHyxWMy-VK1MkXsfkHLdyy3=q4RA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdZZ7j3fciH+J6xu-MGHyxWMy-VK1MkXsfkHLdyy3=q4RA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.1-5
X-PR-Tracked-Commit-Id: 6989ea4881c8944fbf04378418bb1af63d875ef8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 63050a5ca130e76af7199c9a3fba1d175f3a1102
Message-Id: <167002743301.3308.14399455575074348589.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Dec 2022 00:30:33 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 2 Dec 2022 21:51:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.1-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/63050a5ca130e76af7199c9a3fba1d175f3a1102

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
