Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918A76F0C83
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245316AbjD0TVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245198AbjD0TUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:20:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3106526F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 12:20:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA0D663F79
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 19:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7BCBCC4339B;
        Thu, 27 Apr 2023 19:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682623220;
        bh=fsv/fCFh4yPeHDT4yNQCACU1Tdh3QYcUQ4GQlCYq9y4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FOsGyRstaYMaGFvYcYM2kVVwKmRJSaTF7vKPtYlCOzwkGcEElng7Y3JXPpBHsQKu1
         RKlRFMgctJZqNW/pGRLE6iUmOy2w6efVpZI0BQpSaHY1SvAiq11x4brTXrYgOefXsK
         NI1mA+pYhdzW4fiBdHaiXdZVySIRwp7p0nN9Tx+f+ZE2yXGoJ10Q3Ym9wE0ZzbodPG
         cvU98FTGczAoLTx8KUIiSLABAJPmE0atovysV/PFAjog/4e5NvFBDndhfu8M1Rqm+n
         Z8RINfKdAh1TWXa1z7vGf0QW+wHASZJgjfKRvaLoFvpoPwAmoObKXDRopTMg68wOpV
         EvogPjuoxT46A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 694E3C39562;
        Thu, 27 Apr 2023 19:20:20 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core updates for 6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZEqEx7C2iuApvrvt@kroah.com>
References: <ZEqEx7C2iuApvrvt@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZEqEx7C2iuApvrvt@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.4-rc1
X-PR-Tracked-Commit-Id: 046b6a171009e1ed9ede02194025e9ccd709beb2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 556eb8b79190151506187bf0b16dda423c34d9a8
Message-Id: <168262322042.21394.10870783091432180090.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Apr 2023 19:20:20 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Apr 2023 16:20:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/556eb8b79190151506187bf0b16dda423c34d9a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
