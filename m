Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1611469D595
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 22:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjBTVMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 16:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjBTVMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 16:12:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1731CF5A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 13:11:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE1C1B80DE6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 21:11:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 940BCC4339B;
        Mon, 20 Feb 2023 21:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676927504;
        bh=MiRxkTLraNOHy8suDJ78dT8OV8kJ+UAFsj/p1obIWmw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oIyfNfEFEJHTivpJOjY8R8wm6f/3A6PzWYRgkdLQgDHxrLf+993DVfsUql5yUXQBm
         ez1O/WSpXSuZ+u0UB5ADznXWoNLByxUZVEgfC1R2ShSLU1EicWM0rB8Vt88hmfuHcx
         rXbYIAK+gSunlc4JdcE9qSONPntTmvI9zAijHX/jL+M8q7KpYfUwR64NfntdH2lYu3
         US5v7uZYPtpqpLFzEtsrrCDpUBycJEleZgZJS1Gc0xhDr72miuMFHrxjA57k5fyVef
         +IeA2rVZCf8Oalyj0X8paV5OktoPrNNWFa/sQ5fNaYg0yk++psGfgOgYQksaBGxTqh
         K0KG8sF8QPtkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81F4EE68D20;
        Mon, 20 Feb 2023 21:11:44 +0000 (UTC)
Subject: Re: [GIT PULL] dlm updates for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230220183611.GA11414@redhat.com>
References: <20230220183611.GA11414@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230220183611.GA11414@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.3
X-PR-Tracked-Commit-Id: 723b197bbdf1e0adbab772b8e5e022c40db6a9fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eca3a04f140a7380d8a7b4cd89d681706a69380c
Message-Id: <167692750452.16986.5629016486776200380.pr-tracker-bot@kernel.org>
Date:   Mon, 20 Feb 2023 21:11:44 +0000
To:     David Teigland <teigland@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cluster-devel@redhat.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Feb 2023 12:36:11 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eca3a04f140a7380d8a7b4cd89d681706a69380c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
