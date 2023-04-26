Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD096EEBC0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 02:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238601AbjDZAuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 20:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239027AbjDZAuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 20:50:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4875C19A4B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 17:49:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDC706324F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35E2EC433EF;
        Wed, 26 Apr 2023 00:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682470180;
        bh=JFdXkCCcznfwnL6r8CHzjDjQwLiG5MtAxuB95Iz7aNE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cxVHTucw4ORacjBr/gYQyimS0qCSXA3hab/26aqZSyinoRSYHz2SBltBvjS0JL2Wj
         QDC97r1eDaBpF9pBbjdbHjtLPjzEKdJTBeRty5LHQieuhtkXLDb35vFGjFIqi0RBHP
         A+yI1VXAm3jR1nfx7zj1/nmIAKW1PN6h1c1kYS/DldNm3hNWH/0V0aFAozBU7Gn5HH
         1H5aUUM/RBeI+8JAbk3FPeGmX9TVwemnOuyUZMG6asmQ5VtZotPRfCcIWksgeSIoBn
         5WXclyZOL7DdO1ToOa4Jfl32fdea/6x34Vw6ccdV6oV4ujLkU42tsNkDkmAGnepV3A
         4asXCCh7xuZVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 248CAE5FFC5;
        Wed, 26 Apr 2023 00:49:40 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.4-1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <81fbca39-bbd9-102f-247a-22c1998dd51f@redhat.com>
References: <81fbca39-bbd9-102f-247a-22c1998dd51f@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <81fbca39-bbd9-102f-247a-22c1998dd51f@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.4-1
X-PR-Tracked-Commit-Id: e578c943e363ff47d08e7b4f5648f3da9db325d8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 088e0c188513b58a0056a488cf5b7df094a8a48a
Message-Id: <168247018014.10866.11056524730785574716.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Apr 2023 00:49:40 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 17:06:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.4-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/088e0c188513b58a0056a488cf5b7df094a8a48a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
