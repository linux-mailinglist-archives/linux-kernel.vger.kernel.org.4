Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2225B66ABE5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 15:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjANORd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 09:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjANOR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 09:17:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F62A7EFC;
        Sat, 14 Jan 2023 06:17:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C48460B4B;
        Sat, 14 Jan 2023 14:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9176EC433D2;
        Sat, 14 Jan 2023 14:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673705845;
        bh=wKCGa5m67Vuqc8IYj87M1TAXthmZQYqZPMLynHu6HJU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BVRmBExRWWaLqIrNYYULcDl3MeO3avPhbBABdl4Gtzv3psOUWf19lWEf6jAHPX7qc
         juyebr2sX5yDzw5+DUPo97FJ/xK2ga1RGFYa7u2dGcX6J+HoAR5rmib4BFvIcAZAPh
         o8QHxERGTeDKPjiVNtuk3ZuhrYeqwEnW+SMnLOqS1la2gIWC+2yA8Mp0wWJ1BhY+lt
         EuuzEhPN13BvRk4F9EfNDaz95/AGR7GRdlMMyjelbjiVfOHDnlf76XF9d2T/b1n7Cd
         tRDbRZNC6+RGd1V12ykxu23UvPDHZoPjQnc70w4HAd2LPEfZLZIEitaDA4yuoHyGEz
         pd2w1cbytGGRw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E3A1C395C8;
        Sat, 14 Jan 2023 14:17:25 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mvwNTHEfbr2DNW8HCx=pdJxNCG5vSO+qk8qxv6Hbcy9rQ@mail.gmail.com>
References: <CAH2r5mvwNTHEfbr2DNW8HCx=pdJxNCG5vSO+qk8qxv6Hbcy9rQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mvwNTHEfbr2DNW8HCx=pdJxNCG5vSO+qk8qxv6Hbcy9rQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.2-rc3-smb3-client-fixes
X-PR-Tracked-Commit-Id: a152d05ae4a71d802d50cf9177dba34e8bb09f68
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b35ad63eeccadbcc83f295a64a029f7e7188444f
Message-Id: <167370584550.24149.10871171774912685074.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Jan 2023 14:17:25 +0000
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

The pull request you sent on Fri, 13 Jan 2023 19:19:09 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.2-rc3-smb3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b35ad63eeccadbcc83f295a64a029f7e7188444f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
