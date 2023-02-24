Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEE86A238F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 22:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjBXVQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 16:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjBXVQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 16:16:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4866EB29
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:16:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D5536198C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 21:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D242C4339C;
        Fri, 24 Feb 2023 21:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677273362;
        bh=lOsx649cbHbcGeIz8TscTxLLyFEwRuPfB1apUcfYPZE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EVjA0K14YBOZv3vchxsD/OcVtDD2cgtTVfA3d8K4mjRNvuP86FkZsn+/+pWYPc10T
         UYLUQZ0HwwtZqGERQu8N3PRYhtbCsRlQ9+TvatB5UGPh8PnH6XhEmnYzYd3VH7XcSa
         5Jf2zFLgJC+OCJD/Wv2uJIxwhIq6WaPcbfIu4w1Ur9ZwyLNyi3FHkFJlKp96FXc2VG
         0uDkpEHxqeqr2C9oZ5E4ACbZbST+YBwEu39YwG1GvrH6aeh+yf2HplN2vVhNFhpBT5
         vae9entcIosAkfAHVkBmfdfWYFJDnIiR264HhoFM/QCsfbaX5XBDkzS6jn45oBl8OM
         VFFhVoWKinxag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF46DC43151;
        Fri, 24 Feb 2023 21:16:01 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core updates for 6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/iy9+Kn0SgzngDC@kroah.com>
References: <Y/iy9+Kn0SgzngDC@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/iy9+Kn0SgzngDC@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.3-rc1
X-PR-Tracked-Commit-Id: 88cd618dcc7b63baa1478730b02eaba3e3148467
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a93e884edf61f9debc9ca61ef9e545f0394ab666
Message-Id: <167727336197.26367.17130216662766284051.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Feb 2023 21:16:01 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Feb 2023 13:52:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a93e884edf61f9debc9ca61ef9e545f0394ab666

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
