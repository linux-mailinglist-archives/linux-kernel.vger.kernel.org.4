Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24ECC6536A0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 19:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbiLUSuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 13:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbiLUSuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 13:50:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BCF26AB6;
        Wed, 21 Dec 2022 10:50:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1030B81BFC;
        Wed, 21 Dec 2022 18:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7ECA8C433F0;
        Wed, 21 Dec 2022 18:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671648615;
        bh=HJAZdblItd5twkTV+6z8m0BTBiFhMx2rWYzmImr2nYw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eMvznkWUCvfISPcLR6PVFQp/lxffSNqcU7MN9CeD8AC5rIdBoGSYE9G8hYJMeByDG
         0lSoD0y5DWRIVBRPU11oNN3Iy5TC/kW7dp7Nn957TqmDxJPUzGqxOf/K8XsAuIxZzb
         wQPeeqLwpUtAn/tf0lJCqas8zQnl3WxKysF0h6/0lsqOYvSAg/q7UsEZwoWUJ6l2AN
         nUEKkprrBdf6pJv+u0tKxOcvAAJu+NuWZzHxZzx1n6Xr7d2038TmojfpQ7O/RMnmJS
         cbAIhAbJl5B8lD5/GMYcYUzK2/DQcvVTOCBRVAjNwi0qN7H2gpu8Xj7NYLELv0jm+Z
         5kN+3QKheTSug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A128C43141;
        Wed, 21 Dec 2022 18:50:15 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mupDphsriFvcC_Hh0dWaDWdyAKNk1xKwEts7mfm3K5ESw@mail.gmail.com>
References: <CAH2r5mupDphsriFvcC_Hh0dWaDWdyAKNk1xKwEts7mfm3K5ESw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mupDphsriFvcC_Hh0dWaDWdyAKNk1xKwEts7mfm3K5ESw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.2-rc-smb3-client-fixes-part2
X-PR-Tracked-Commit-Id: aacfc939cc42293fbcfe113040b4e8abaef68429
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a924817d2ed9396401e0557c6134276d2e26382
Message-Id: <167164861543.27828.16700385442452255152.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Dec 2022 18:50:15 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Paulo Alcantara <pc@cjr.nz>, CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 20 Dec 2022 15:49:40 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.2-rc-smb3-client-fixes-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a924817d2ed9396401e0557c6134276d2e26382

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
