Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6572690FFE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjBISKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjBISKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:10:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E074B68112;
        Thu,  9 Feb 2023 10:10:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 792A2B82286;
        Thu,  9 Feb 2023 18:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26F1DC433A0;
        Thu,  9 Feb 2023 18:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675966221;
        bh=Qs+MhMw4k+/Gs23oSxJ7sBhpojKfGJ4OKzEtilZRKVA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cKu6alxgRxvy4v2Q12afaL1Luexldp4B8T96hXkHuYTDdtYH6gmwVtkhYHS046zP1
         +L0cS+OYXqE0IrafCLJ56FLUliIYYifOHBgvIctCvHFIQ4kO/r3AO35/pnzKtN02qJ
         9TCT7H5yZm1U23Ew5xjN52XKJ0GENWTrwG0UIHhwOZB7qXFxIKS3lqQE43y5x/ppSr
         50LGhiQaCBT/lHzJZhZT3/0yYrYkwAotPzYXIi31IN55ICqw2RvHzfY9di6UEVf2QR
         BMWqfHmYZHyyXWXF+ddXsMw2S8mCYtpnS7i5WsSNbTMwwSnCw8RPRl8qyfjaX+jsiq
         TowyBeTeVL7Sw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12AB9E21ECB;
        Thu,  9 Feb 2023 18:10:21 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mut-6o5Jy7Kb8ZmjyRDikAi7iueqNStX1JLdixrFmJPZQ@mail.gmail.com>
References: <CAH2r5mut-6o5Jy7Kb8ZmjyRDikAi7iueqNStX1JLdixrFmJPZQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mut-6o5Jy7Kb8ZmjyRDikAi7iueqNStX1JLdixrFmJPZQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.2-rc8-smb3-client-fix
X-PR-Tracked-Commit-Id: aa5465aeca3c66fecdf7efcf554aed79b4c4b211
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 94a1f56db688f134c763a4b2a5926b437f1ab4b9
Message-Id: <167596622106.10454.16721813136064000676.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Feb 2023 18:10:21 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 8 Feb 2023 22:43:48 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.2-rc8-smb3-client-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/94a1f56db688f134c763a4b2a5926b437f1ab4b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
