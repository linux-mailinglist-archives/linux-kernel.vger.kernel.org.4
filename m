Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10303674BAA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjATFEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjATFDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:03:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FE86A33E;
        Thu, 19 Jan 2023 20:50:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3417BB82731;
        Thu, 19 Jan 2023 20:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E124AC433F0;
        Thu, 19 Jan 2023 20:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674160278;
        bh=FGm3pJ+3mPrh8GEYeklpHmEmFgqyCNPFtfdqbLifSEE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XBVtMy5K3ADSCKt2nbj8Fq+YdNbFcwSfffvWxArBQqe2oy+7LSef2jsWqPFBzVp7g
         JJRGChsMVrUq0dJLIPG6aUX0mUc1Ur8ON6bIofv81bhC9qhOmPWnQ9XajwMkuDZeBB
         3C4wBYAHFKiUS8LVfgOrGVBPlrXcokxJTyNWFJJvriGzY8pbcl3OvD45lHRA0RXi9v
         hmxNXJgDJM0VMkzjtzSEZKJorKELaB7/bpq4PlKhd9mc3y86dskDmeujGyR809tO4X
         yEnVjSyWacqVplOU5HFfkJR9q/Sx/gnOwLRXe9LQ6Gc1C02XOowzYfPP1JukEy9rff
         +r/qQbVdQZC4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C784EE54D27;
        Thu, 19 Jan 2023 20:31:18 +0000 (UTC)
Subject: Re: [GIT PULL] s390 compile fix for 6.2-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y8k0sZthY7L7rINA@osiris>
References: <Y8k0sZthY7L7rINA@osiris>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y8k0sZthY7L7rINA@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.2-3
X-PR-Tracked-Commit-Id: 41e1992665a2701fa025a8b76970c43b4148446f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a03df4ec37291de74987e4fbfbbcaebb5a8f9a2e
Message-Id: <167416027881.28102.15732091382340470205.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Jan 2023 20:31:18 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 19 Jan 2023 13:16:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.2-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a03df4ec37291de74987e4fbfbbcaebb5a8f9a2e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
