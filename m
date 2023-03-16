Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF346BDB6E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 23:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjCPWMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 18:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCPWMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 18:12:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629F277E1A;
        Thu, 16 Mar 2023 15:12:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBF2962135;
        Thu, 16 Mar 2023 22:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FCAAC433D2;
        Thu, 16 Mar 2023 22:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679004750;
        bh=blkqnagaUqPW+2mgMNz2gB1RDzsSKL2IX+6bnYtgGYE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ch7w9FSNo5E6yyLIapOBgbiheg/7Yuk/Og0SMPGewGZmXjZOjGfRw9g7mQziRvc5g
         1antCtLL0BsU4P3tyQtS+vNYqSodUKJ8TN6Ss+Yw0F+UhzYSYj+Q3+aEMBsy10ynBT
         xNOk6BtBmepF7LamuRzR+faAy71Up5V3w96tszYi+vET6/hXcfJOAZ8r7aSz8bfiQy
         6qUsmUS0aEfqtadTOt09/sPNe0Ih7CcTUGcVM1FClUBlGnsxe1xgOK0RTMB6EH9gkw
         mseiyQpJ1T0ZPqym65t7s5KBGgNRH13zMc0dUA83GUIqn2au3PuiVCX4nXe9Z6XCUr
         b5RrsUwoSjHvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4D831C43161;
        Thu, 16 Mar 2023 22:12:30 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mvy1og79Zxumu_Bn4NZGpian1Tk2LXpDTQYjCG4nF4Mbw@mail.gmail.com>
References: <CAH2r5mvy1og79Zxumu_Bn4NZGpian1Tk2LXpDTQYjCG4nF4Mbw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mvy1og79Zxumu_Bn4NZGpian1Tk2LXpDTQYjCG4nF4Mbw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.3-rc2-smb3-client-fixes
X-PR-Tracked-Commit-Id: 6284e46bdd47743a064fe6ac834a7ac05b1fd206
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 38e04b3e4240a6d8fb43129ebad41608db64bc6f
Message-Id: <167900475031.29338.15186387726164392384.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Mar 2023 22:12:30 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 Mar 2023 15:39:53 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.3-rc2-smb3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/38e04b3e4240a6d8fb43129ebad41608db64bc6f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
