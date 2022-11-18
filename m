Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6706762FEE2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 21:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiKRUcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 15:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiKRUcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 15:32:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E781313D52;
        Fri, 18 Nov 2022 12:32:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 875126275C;
        Fri, 18 Nov 2022 20:32:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8C61C433C1;
        Fri, 18 Nov 2022 20:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668803557;
        bh=lgV459q3szkOpQDpA5oQQ2cstfhBSeE+WxaG8DPqOs0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TCCQCxv9Dkbx+I/v+8Vqeei8dauptQlfOscp2t50fhxNkBPcNEx1IdPiEYXKP/G1f
         vO1sUj7LC6DqrGp6ObyNk2115TjJEbbYAt0ujx3YvbZZz+bZhu3U3IeYLGiJjaczMx
         u89kqK0plH/bVsKSnwc0WkaiZdO1c/rUyxkhoSXC1hcuUxXsY3HgT/3d9/a4Fzwml0
         bxJfoDan0Gr4Og51l/m7mhAqnFAkdH7D0i+kGirLZk9Z4F+HIfQ30LO6eMr7Sh0enF
         XnzRG3Ha+aQKAZPpw6kyntD4pBkLZkKgPLRS/dYQQnluagMAuQ6UIZDGd1/igihQej
         ypqo7UD9c7MOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7AB5E270F6;
        Fri, 18 Nov 2022 20:32:37 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.1-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y3emu4epRB+EcdoM@tuxmaker.boeblingen.de.ibm.com>
References: <Y3emu4epRB+EcdoM@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y3emu4epRB+EcdoM@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.1-5
X-PR-Tracked-Commit-Id: e3c11025bcd2142a61abe5806b2f86a0e78118df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab290eaddc4c41b237b9a366fa6a5527be890b84
Message-Id: <166880355787.16518.17412967600304618884.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Nov 2022 20:32:37 +0000
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Nov 2022 16:37:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.1-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab290eaddc4c41b237b9a366fa6a5527be890b84

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
