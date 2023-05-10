Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC0E6FE712
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 00:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbjEJWNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 18:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236519AbjEJWNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 18:13:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8293B76BC
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 15:12:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CBA9640C3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 22:12:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DAF7C433EF;
        Wed, 10 May 2023 22:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683756767;
        bh=/GO48DJdlDbNUFdhRsKLyxsXK49hcWXXheoucB0Lyak=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jmakxV3VEc2oiyr4TDFcnrhSayF41AwpdNexuMsgKevkxO2RhAVIUtAYF9KzXyIHm
         gBnh090xaV36Ew2b2jOI1BTy+mxJwe/67kY3bjZ7kiQQ2aJdti8DHPKxvDIJ9Z98hW
         /5YmeWzZrcIfX+f1Lk1FXfj0+FgcAoS8umkyhtZP7PPTnh2wi1BA8j2vu8JrW5SFcT
         8NmPACEP6TpHRn2gBfsEV2pUA0/u2ehDQU+rjVcd8BIRmdetJ4EZj27yXeusLWUOtb
         vb8+Kf09sg2desC1slkVI2oW1oSc/XpfaCAhDPiF9WEUBm0C0MOLTpq91KkqZ6nOII
         pBWGqAmg/Bo3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5BA75E26D2A;
        Wed, 10 May 2023 22:12:47 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2: Don't deref jdesc in evict
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230510151918.280115-1-agruenba@redhat.com>
References: <20230510151918.280115-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230510151918.280115-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.3-fix
X-PR-Tracked-Commit-Id: 504a10d9e46bc37b23d0a1ae2f28973c8516e636
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a78769da34b792cc4c4f7157cda6b622fab0872
Message-Id: <168375676736.24436.5887636492162638288.pr-tracker-bot@kernel.org>
Date:   Wed, 10 May 2023 22:12:47 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 10 May 2023 17:19:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.3-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a78769da34b792cc4c4f7157cda6b622fab0872

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
