Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFB0742B58
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 19:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjF2Re5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 13:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjF2Reb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 13:34:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552DE35B6;
        Thu, 29 Jun 2023 10:34:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32ACD615C7;
        Thu, 29 Jun 2023 17:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8ADB9C433C0;
        Thu, 29 Jun 2023 17:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688060066;
        bh=rNGQL6pxR9k9DExiyIujUSlC5Llfm3DUHgdvZVuKaLc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EgrsKVaVCLp/yj7jEgsf0JNuWvqM3eL4qQa7+xag6axYVCNg8q7PYefwwiWB/PIW2
         iBxi8ihDSZxtojIqEDaPmqxxs7X7unLoDFWRE19o2Lpm9MiqW0TrffYl7m+zgGVpQw
         nQ1m+SQaJ3apV6Zl0s9SKbzLh/Wn3IWRce6Qo6+gWjXrmM8MG/kGpdHyYkn+M6AQbo
         MOJpw9kBi3Xu3NhzsHOPFsZclFsqaLYvHP62gQfwPZqF00bemAFhYwtHgVzQb5TVUj
         PX4Gbv2/dIdxtq7NeLcpiZk7eOVPwoAXAW+59HP+/2MBsJRzlyd4W75xtsdHEx+F4s
         Ww4JNN1P/pP/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77F5BC43158;
        Thu, 29 Jun 2023 17:34:26 +0000 (UTC)
Subject: Re: [GIT PULL] clk changes for the merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230627051123.391865-1-sboyd@kernel.org>
References: <20230627051123.391865-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230627051123.391865-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus
X-PR-Tracked-Commit-Id: b9a40506a2cb626da3f21c6d494a76879e3141d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff7ddcf0db48a7d9ae536eb0875428117be1d1f1
Message-Id: <168806006648.7356.16385516546498929578.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Jun 2023 17:34:26 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 22:11:23 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff7ddcf0db48a7d9ae536eb0875428117be1d1f1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
