Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E2F5E9439
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 18:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiIYQJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 12:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbiIYQI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 12:08:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC0E2B1AE
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 09:08:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9056461553
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 16:08:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02D22C433C1;
        Sun, 25 Sep 2022 16:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664122136;
        bh=aCmJm5/OBtsDYS5j+Pt05LgGCHAVWzfjsg6zg5utEzw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=msP8NOpMrwdlaZ68/ktyV+S3JQrG8/37PptaYB4gZXB1XPZ8rRdOVONy4FlauMten
         MLsw5smOirTvR4f0fXuT9dwQ87O4JlJrlce3q96NyYY2u+o5FGt62GbiXesRNgx6ns
         /mgBSvHNrFrf2PTuu318xqENxCAmQala99XwFqT7ALcyR1dU8u52eBBtLy4P4+kp0/
         xyywG1sECkAHX+wTEc/Bq28Fr/wWFTdhgz2WkHAoj4DOGLMa/O4L+YcBfQW2kUhJQA
         UHFWLc/C83WGF8yQy60nd0wTd299+ep7prhDhWkcJ/5PQ5WLBuIcktfE7h7tTQtJVb
         /Dclcd+nhFW5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E012EC73FEC;
        Sun, 25 Sep 2022 16:08:55 +0000 (UTC)
Subject: Re: [GIT PULL] NVDIMM and DAX fixes for 6.0-final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <632faffe84f7c_746b294d1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <632faffe84f7c_746b294d1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <632faffe84f7c_746b294d1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-and-nvdimm-fixes-v6.0-final
X-PR-Tracked-Commit-Id: b3bbcc5d1da1b654091dad15980b3d58fdae0fc6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4207d59567c017be284dbebc5d3fb5a2037a5df5
Message-Id: <166412213591.26660.13541178879382385096.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Sep 2022 16:08:55 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     torvalds@linux-foundation.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 24 Sep 2022 18:33:50 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-and-nvdimm-fixes-v6.0-final

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4207d59567c017be284dbebc5d3fb5a2037a5df5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
