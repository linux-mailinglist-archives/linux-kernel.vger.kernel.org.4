Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516ED726EC9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbjFGUwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbjFGUwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:52:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A6C10EA;
        Wed,  7 Jun 2023 13:52:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D25C64771;
        Wed,  7 Jun 2023 20:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3FA4C433D2;
        Wed,  7 Jun 2023 20:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686171159;
        bh=dCvFve7GSz0i0nFV48jGI8InEz9kGV6Iym5GYtXJM+A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rBeZjv8vLpjQ4OmlBTROPlF+lkr5evwh/3FqwMKX1QTIkcL7FwysjDDlfX1tadV4s
         esXMe/Edlo9PVCqwHvFhU2eDkYAmKs1qH0zWjqdCUQKhXbwPIcNpTs08TPBVn9laYs
         4SdGKT0r9br74eseI5UEx5124cS4C8sbcax3mKM6qovoCXC00kNEpIZG6WBysEG6sh
         TGjgg5DqnQq+3dQ2dOXxuMYEHpzOH55qyDk2LgUYvoFmfmwKc7rQJn/OmZwmmRJcft
         H1PC8tvIbvkj++1WF0BmSVO7VGQFozvDpk6zl+Wc90NfKQUq5hk0MMOOhdLk4IQCEt
         O54INxwR2ABMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 927D3E29F39;
        Wed,  7 Jun 2023 20:52:39 +0000 (UTC)
Subject: Re: [git pull] Input updates for v6.4-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZH9zwxXvAd3kacKH@google.com>
References: <ZH9zwxXvAd3kacKH@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZH9zwxXvAd3kacKH@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.4-rc5
X-PR-Tracked-Commit-Id: feee70f4568650cf44c573488798ffc0a2faeea3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5f63595ebd82f56a2dd36ca013dd7f5ff2e2416a
Message-Id: <168617115959.20085.9324608068327486591.pr-tracker-bot@kernel.org>
Date:   Wed, 07 Jun 2023 20:52:39 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 6 Jun 2023 10:58:27 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5f63595ebd82f56a2dd36ca013dd7f5ff2e2416a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
