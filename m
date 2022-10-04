Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7975F3AE7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 03:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiJDBDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 21:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiJDBDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 21:03:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B9A39BA8;
        Mon,  3 Oct 2022 18:03:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA24761238;
        Tue,  4 Oct 2022 01:03:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45443C433D7;
        Tue,  4 Oct 2022 01:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664845423;
        bh=zYJk3C6bG86waZPvaIs+xjDkWsPHmX6XD8NlzVwqsxo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Uge307a4MpftOsF0/mU9eBUdLe3xW/MLOQ2dS3miYaPfyP4WMYpk382kz0mAotK31
         rlJDoeVuK1GqmW8TG6xV4UiIInR3zCPG8K0CbQjDkcwqWwu7fNjiTDRUNtWvXclWPr
         HpQ510UolOS7a/WLyvdVfcdEIhUZZtvA494U5Gd1LdO8yN0CPUD6/bsIru3ehCkT+g
         ruHAKAKLK3rQwwYZl9QXcXM+2Wty60VJk4tBRV1plC9CbWJz94Sca8Q0dPIBcQLca2
         TCzpuhPcdu9uJg6aJo2jO4ZqNLySfyraMzx8wxkDU6wgHEi7hGBJGqU1nSB6Ii6SF4
         ITPTMEPSmEDuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E8E8E4D013;
        Tue,  4 Oct 2022 01:03:43 +0000 (UTC)
Subject: Re: [GIT PULL] LSM patches for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhShpEVTuogj4h74PxbEeTUNn4odo8SE6GBvb6sGUM0LHw@mail.gmail.com>
References: <CAHC9VhShpEVTuogj4h74PxbEeTUNn4odo8SE6GBvb6sGUM0LHw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhShpEVTuogj4h74PxbEeTUNn4odo8SE6GBvb6sGUM0LHw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20221003
X-PR-Tracked-Commit-Id: 1e7d8bcbe37d3c63babe628443f13f77970dd06b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26b84401da8458c5cbd6818d5732f7bbb84124a2
Message-Id: <166484542318.7481.11745975415123995034.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Oct 2022 01:03:43 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ebiederm@xmission.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Oct 2022 18:37:59 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20221003

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26b84401da8458c5cbd6818d5732f7bbb84124a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
