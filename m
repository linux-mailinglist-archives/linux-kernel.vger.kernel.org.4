Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F856E34C7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 05:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjDPDCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 23:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjDPDCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 23:02:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59053268A;
        Sat, 15 Apr 2023 20:02:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C652D61509;
        Sun, 16 Apr 2023 03:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A1E1C433EF;
        Sun, 16 Apr 2023 03:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681614149;
        bh=x98Id3EKUNL+LcQp3r5iKifcLzhqvv+ViqyYdhCH4HE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MM0AtbD7jh6BR4M7rDb89VhM5C5RTDlDCpav0+CNy9EEYPyucKTej+VjcNB/n2FFI
         G1mLjCP2Am6mLtB37R+s2jo81QJVrHp5L7HLkrwEuFMKiOfDwtlgTRJk05zxFpbJTu
         FnWCVqk7t33JY2mXZ4tTpqZSUS+p4R3hQQUokWjrlawbcTvjUKKBYPLKXARHtihjJm
         ZbjQFqiAebgPVjgTPvL6RIic1WUatjEDLK8aDyjbGtLBXbK4W7CGXrAX6ys1ZvuOTb
         /JMDmTTpRAP3onuovCGc9EeYJw51a8csrPr2Zq1xIbEj4y51UHARtO5NxdxZelosiC
         ZyjBee5HT9Q5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22B30E5244F;
        Sun, 16 Apr 2023 03:02:29 +0000 (UTC)
Subject: Re: [GIT PULL] smb311 client fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mv+eZW6RAPOqZ0FCWixdj-kKWHj2DfEDLHZvYCZh8iAzw@mail.gmail.com>
References: <CAH2r5mv+eZW6RAPOqZ0FCWixdj-kKWHj2DfEDLHZvYCZh8iAzw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mv+eZW6RAPOqZ0FCWixdj-kKWHj2DfEDLHZvYCZh8iAzw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.3-rc6-smb311-client-negcontext-fix
X-PR-Tracked-Commit-Id: 5105a7ffce19160e7062aee67fb6b3b8a1b56d78
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e7bb4f2461710b70887704af7f175383251088e
Message-Id: <168161414913.1043.7700400503552988608.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Apr 2023 03:02:29 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 Apr 2023 18:58:39 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.3-rc6-smb311-client-negcontext-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e7bb4f2461710b70887704af7f175383251088e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
