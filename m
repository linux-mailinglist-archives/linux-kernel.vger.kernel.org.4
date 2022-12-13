Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F82664AEED
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 06:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbiLMFBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 00:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbiLMFAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 00:00:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEEC1DF24
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 21:00:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9746EB810DE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 05:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46220C433F1;
        Tue, 13 Dec 2022 05:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670907614;
        bh=YBm6udfv1OrAXFc8jmOZ47V4Xf5k70MhkDnw+JW+CTQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HBoZju0ta5G0s+73/LI90M8RMpjVfwFSQxGRdzbOUO0ZwAu/V5uKDWFuIhlzT9RS+
         fsa2pIP30vu1MfPVe8hSYe53SZBJE3HtsMENEhWd34CT+Mjhwvyqb3pcP6J8i6/KMe
         uKA9QdWGb1qXjWQCDRBbizC1l4Eb4j6U1pBnU5Eblo3WWMZdihkS3woFwZiuLojU01
         CKluZHZmU3FU+kJVU/BK1V+hwGzaD5lUCjuAz1FRLCZOtEjeU1XJ9Lno1sz/FqyDVu
         HGw941SpLXcksHToaiLhsXkQ0A1lnIZLsiaN2ECcjV0lmBz2OMJ7tHtwlPavKpeFt2
         zLoArB2u9COAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32DBBC395EE;
        Tue, 13 Dec 2022 05:00:14 +0000 (UTC)
Subject: Re: [GIT PULL] jfs updates for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ed5a5cd9-21f9-18b5-cbfa-2af70bffa483@oracle.com>
References: <ed5a5cd9-21f9-18b5-cbfa-2af70bffa483@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ed5a5cd9-21f9-18b5-cbfa-2af70bffa483@oracle.com>
X-PR-Tracked-Remote: git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.2
X-PR-Tracked-Commit-Id: a60dca73a1a8079d867b2c2e9549440346c1ba83
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 56c003e4db4adb1d57e599fb4c7d39f9130f9db1
Message-Id: <167090761420.4886.14742121338069979526.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 05:00:14 +0000
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 14:48:34 -0600:

> git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/56c003e4db4adb1d57e599fb4c7d39f9130f9db1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
