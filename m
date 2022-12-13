Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AE964AC87
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 01:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbiLMAgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 19:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbiLMAg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 19:36:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CB61649F;
        Mon, 12 Dec 2022 16:36:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FA55612CF;
        Tue, 13 Dec 2022 00:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D43EFC433F1;
        Tue, 13 Dec 2022 00:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670891784;
        bh=fvHQ034cutpEx65j5Ybq2u7ModvubS9jWFEzG52cKGk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gYYDAgPI7XPLGjqxr9+ezRqKlLEqool8ulq8s1/jyOCxXfN9qCb6O5YMhHduhxLGi
         rRM418QithmrhVV7ZEtAXdypar/eNVUyvycJhFb2Iog/BO6cn6Kc8ClIOmTX9gAxWG
         KzT4soqSEY9FShMMU1FvtP9QMhK7R895j9ZT/HmzxmHKNEQvtZL4U6dWOZTcvFbG3z
         1004RvloW+KjyEC5OtTRLmQnh4ECaR702g85T+MUahHwsUozBBXTYVUVHH4ITsl6Ks
         YrgmLBHj1DWJK7tSg5nrj6GtXm3adr9ikYMDJEs3gSxQ0146FdoYLgkSf3aaoqXq9R
         BtfbYOxlKoVeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1E78C41606;
        Tue, 13 Dec 2022 00:36:24 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup changes for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5bIlstHSdB7FOID@slm.duckdns.org>
References: <Y5bIlstHSdB7FOID@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5bIlstHSdB7FOID@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.2
X-PR-Tracked-Commit-Id: 674b745e22b3caae48ad20422795eefd3f832a7b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a312a8cc3c7fe96f5e54e69c676f5bd12995f44e
Message-Id: <167089178479.4798.11333496721193208263.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 00:36:24 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 11 Dec 2022 20:22:14 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a312a8cc3c7fe96f5e54e69c676f5bd12995f44e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
