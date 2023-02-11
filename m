Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2870169333E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 20:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjBKTLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 14:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjBKTLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 14:11:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0491A650
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 11:11:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4233DB80AB0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 19:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02269C433EF;
        Sat, 11 Feb 2023 19:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676142696;
        bh=4tRpnWsPjg+qz8gi1CmjgGKN2KQMLKqIWA1vRJuP6mk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sk4s2TfnL/iYiy/A+TFXmzlKkxGwjE+IZP+xZmDeZPJaCcxSAu8z8DTlZagM4VmJV
         RhcVrOE5yCu/Uc2q9XDxU5kcwhUsuHLgRyY6pI0eaglfWrprvAucylcwP8j3XmDMb5
         C6mPWwewdRMlFAv8iSr2fCYpz1DEeiLQup6oDKO6YlqFoJT7tT+6S1eLlHrVQ3+vP2
         u0jfXkL6Qybf5dcQ4cJYYsp3ZXXBXrnelF1yJIyPoFXUee9zoaBpt0hl0lSfuTo6Pe
         3EKns9KNnMZi17+FLa3gOc+Iq0dcTb/jDoLgynJ/vfV1W7rG11fbcrdXWu1L1Gbf6E
         +VPqZ326m9IUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1603E21EC9;
        Sat, 11 Feb 2023 19:11:35 +0000 (UTC)
Subject: Re: [GIT PULL] NVDIMM and DAX fixes for 6.2-final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <63e6fe1b27ea3_88e129491@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <63e6fe1b27ea3_88e129491@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-List-Id: <nvdimm.lists.linux.dev>
X-PR-Tracked-Message-Id: <63e6fe1b27ea3_88e129491@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-6.2
X-PR-Tracked-Commit-Id: c91d713630848460de8669e6570307b7e559863b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95232dd9ae13d6bb52ebd0c295e5dde30acd0d02
Message-Id: <167614269591.18613.10756799553053963987.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Feb 2023 19:11:35 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     torvalds@linux-foundation.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Feb 2023 18:31:55 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95232dd9ae13d6bb52ebd0c295e5dde30acd0d02

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
