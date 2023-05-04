Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390576F771A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjEDUfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjEDUep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:34:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D5C1C0C5;
        Thu,  4 May 2023 13:26:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 774E7639D4;
        Thu,  4 May 2023 20:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF766C4339B;
        Thu,  4 May 2023 20:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683231821;
        bh=CDrx0eRYgGfaYH2eVD7zoll83lV+IJ/khlvSxjxweMc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ufo3D0OEPj3B61M1jjtXQ/33hQ9iyNeMseS2JhaIxcYuWpxhVcXSs8ySNNeOugNJf
         FiKz4Y4kAQeUijVzZeFDtCGENgO14GnGuEkkE+xXRqXfSgpsJ41X8LWFQcdAiKV2Ti
         ZVrRvJnQhq4KM2SjLCc/ahR8j83Lxq8jeDbzIIzGCEBSHwIdpiLTTpyUKdptcHxq/k
         17qzVvA5U8WNAdUXTDbzhXafRV7i4tfXgbo6B1qQWISQYRdl+C0vC0xKBc46Dtdjyr
         FkmluV8g4P21LpkWg0iOFIEozqS1XyI/eK76U+UuEny5JEHd0TPUt2pZ8UsfVil6Nx
         gichzWG7s9AnQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CAA37C395C8;
        Thu,  4 May 2023 20:23:41 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230503162943.f6dc961eec9488db9ae411b0@linux-foundation.org>
References: <20230503162943.f6dc961eec9488db9ae411b0@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20230503162943.f6dc961eec9488db9ae411b0@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-05-03-16-27
X-PR-Tracked-Commit-Id: 6152e53d9671b0ccc21c1bca842617b32ccfc5d8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1fd058b07d58c3372c1aba25dd65f1c9c9b65f1
Message-Id: <168323182182.6214.12902050704020189398.pr-tracker-bot@kernel.org>
Date:   Thu, 04 May 2023 20:23:41 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 May 2023 16:29:43 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-05-03-16-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1fd058b07d58c3372c1aba25dd65f1c9c9b65f1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
