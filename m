Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995E35FA6AE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbiJJU5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiJJU4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:56:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0529057893;
        Mon, 10 Oct 2022 13:56:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2FD5B810D8;
        Mon, 10 Oct 2022 20:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E12DC43142;
        Mon, 10 Oct 2022 20:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665435398;
        bh=ALsbpkSK7nBAR0/sv+t06EEOPR6CmVC9LUjRH2PrCkA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QnPYj7fRqebxI+W5XiJoDz3LEtCuS1BmKVxexOfOE1BcODVkwxS8O9n+O5fdgExyP
         Smu7+LzRo+n/OoSF7eG7AAu6qZ4MRTAXsIL0U4rP8ULNjXjpn2GPt4wMzvplkJXC9M
         jqF0WtVqvcVIZyqIVLfT8hKzHSSnUuYhj7fBaUAC1eefKTgJ1PTGxKnQwXz7zCsAwL
         0YqZulWJTFvmw8zkwmsF+idjTudf8fdQWz295vp5EBljSXNQweTlySAn60HO4h1AgN
         BPaog+dUPDbbWkxxqhgZM4ZDnxBqEp8NqrvR8FQJj41nUAZcsvo/+HvAyl0q2iHxlB
         HKuRkzXiZkXaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BA06E4D00E;
        Mon, 10 Oct 2022 20:56:38 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fixes for v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i_sK86N5i3sVRE1cdb7TgHOCGnMV5+5JuQewwwLBEp0Q@mail.gmail.com>
References: <CAJZ5v0i_sK86N5i3sVRE1cdb7TgHOCGnMV5+5JuQewwwLBEp0Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i_sK86N5i3sVRE1cdb7TgHOCGnMV5+5JuQewwwLBEp0Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.1-rc1-2
X-PR-Tracked-Commit-Id: e021563fd09e1fd4041a6a573ec10fb5b5d275b0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa512c115a09d9133dcb09466e39f93f99a82fdb
Message-Id: <166543539824.11766.2948882401598095254.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Oct 2022 20:56:38 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Oct 2022 19:47:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.1-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa512c115a09d9133dcb09466e39f93f99a82fdb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
