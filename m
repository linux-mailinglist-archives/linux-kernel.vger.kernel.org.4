Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898E46EDA53
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 04:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjDYCt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 22:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbjDYCtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 22:49:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E9EA5CB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 19:49:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCE0762B21
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 02:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F7BFC4339B;
        Tue, 25 Apr 2023 02:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682390974;
        bh=c9gGLDat6H88yBAl1wocMWJtYpTu1I67Vge+/CTHAy0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CF3TX3RmW/amYy5+V+tc1phD2vXCIi5jno663ntHOauvjbAr2eOpbHcUFhAE8FLgc
         UC0Y53ykI2gRMs69sfNUzTpxsO24WI5V/qVzDBQm2+3SPeOCwyQI1GL162+DKfc3wY
         8q+nIIkgm1AiF/w7wIMfKfdSXrBIWfKjTqVNdwhpOlhSvhI5gUTOOKw2El4gvm4SQ7
         pi22Ur6Ks9MaYq/McRm9TmRQmgEbyWqshCwLbhBp14g4FRKFXiEjvGZTXPwo1q3eXE
         mDhbGaNT17zS93GpfkxApi08HZZpjX1aiiJrASfqEdjyMbMZY7WRCwXg7mCyo/Xftk
         EtvD7BGwdUSSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E894C395D8;
        Tue, 25 Apr 2023 02:49:34 +0000 (UTC)
Subject: Re: [git pull] trivial nios2 cleanup
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230424042833.GL3390869@ZenIV>
References: <20230424042833.GL3390869@ZenIV>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230424042833.GL3390869@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-nios2
X-PR-Tracked-Commit-Id: eb2317b13b1884b07db23d986988620941b2f075
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 173ea743bf7a9eef04460e03b00ba267cc52aee2
Message-Id: <168239097425.20647.7092129733159656129.pr-tracker-bot@kernel.org>
Date:   Tue, 25 Apr 2023 02:49:34 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 05:28:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-nios2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/173ea743bf7a9eef04460e03b00ba267cc52aee2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
