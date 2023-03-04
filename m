Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385946AA696
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 01:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjCDAjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 19:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCDAjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 19:39:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C0D38018;
        Fri,  3 Mar 2023 16:39:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E40CB81A09;
        Sat,  4 Mar 2023 00:39:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF35DC433EF;
        Sat,  4 Mar 2023 00:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677890355;
        bh=7+CXXksS/QheM84IxxA2rRrCsPB3wRg1ChOMaMcmX6M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lRvqMVdNLoRNENCuhECfn9i2u4ik/soTESCI1DqPuehxIeCWxov5VG249+fvAvdgL
         rPyfKf3CoGXhr2NC/sanfA/fYa9u0yB/GsbDDCi5pp+3erYpudJJuNJASPE6BwN2+6
         fSI0zq9qR+Thhc7jmA759BMTtdNQbIXVC7S03quPTcdNA6MnsJhj/zGXeMtUvBSYjM
         yObjXkQrvIxuybFdL3aEyRUE710dpaXPYGM5R7ihOX6IUwiKEkKzt6UsroNbSGfBrY
         AHWMydBl7DG62IuYyH+8TcBWVSfn3HHmYPWJN10AafG482DVr1HfPTOqIqhFu+Veml
         Pj4a9lQ1hwCZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D7AFC41679;
        Sat,  4 Mar 2023 00:39:15 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mvneK=w-1DFk9A7y=3xgLp=HQtNFQ5Tvee+g2B4qKumeA@mail.gmail.com>
References: <CAH2r5mvneK=w-1DFk9A7y=3xgLp=HQtNFQ5Tvee+g2B4qKumeA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mvneK=w-1DFk9A7y=3xgLp=HQtNFQ5Tvee+g2B4qKumeA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.3-rc-smb3-client-fixes-part2
X-PR-Tracked-Commit-Id: 71562809e401b2f5ad371d99ce0323e988406fd6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3162745aad939af6b8bc00951d1344ee872526a9
Message-Id: <167789035564.14111.6365275079862617222.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Mar 2023 00:39:15 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Mar 2023 17:29:17 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.3-rc-smb3-client-fixes-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3162745aad939af6b8bc00951d1344ee872526a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
