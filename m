Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04E65FF7EF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 03:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiJOBo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 21:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiJOBop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 21:44:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA44BAE7E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 18:44:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A5F1B82455
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 01:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46CC3C43141;
        Sat, 15 Oct 2022 01:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665798282;
        bh=y/waUCrSLIoQj9RUaRN0g5eGyCFtRYAVDVZFQvwMGjw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=e1GVVXl4XDQqaIKt15r1niB17g6Us61TMRIp9e2DbCCbEZ/Yp8YRw4Y9nHTCn9/61
         LrQIKghEiTDn770kSv7LVAo716QoYQoa7TDBVc6umYjBJm+Q/EPH7pbURIu2iZ0IHM
         HJgXhMUrNVksuu5RztS0dU9IhMqTE0GhK4OEIKUUidHaX/3c3kCjiEBsSydGZE5YcM
         fEglEKr6Qa7E5dOGI/Gr+/YJ5s7TqxE7JqfQGIOnxmPMRsPPmhV6+TNBzCk0qzCnqh
         ZvgTkTp8qys7xKqKvl3iTnUBh6GIfnSNhK0N71UxC3JykBV0YAHLxQwNgXRmzrPS2Z
         a8E1Fl+ICl4Lg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31167E4D00A;
        Sat, 15 Oct 2022 01:44:42 +0000 (UTC)
Subject: Re: [GIT PULL] NVDIMM for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <6349f4435df76_7ddc2943e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <6349f4435df76_7ddc2943e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6349f4435df76_7ddc2943e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-6.1
X-PR-Tracked-Commit-Id: 305a72efa791c826fe84768ca55e31adc4113ea8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 19d17ab7c68b62180e0537f92400a6f798019775
Message-Id: <166579828219.8004.8423814278538619083.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Oct 2022 01:44:42 +0000
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

The pull request you sent on Fri, 14 Oct 2022 16:44:03 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/19d17ab7c68b62180e0537f92400a6f798019775

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
