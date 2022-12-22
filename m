Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635E3653AE1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 04:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbiLVDHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 22:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbiLVDHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 22:07:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B12EE02A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 19:07:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDBFDB81CD9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6FA1C433D2;
        Thu, 22 Dec 2022 03:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671678447;
        bh=w9vW6QRdcWPEcLJuwvgSijPIIjjCHhq3cqsJnaapYik=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JNIU+5+gYC6/k/zUa8+thOgk2gA1m+mFaBzjv7KB7pXU2XhLYTjSX4/UAsNw/xjkj
         Fg5kdYfP1E4tAoJH4FfsV00VWTKHcAZ7Ro8cfEURlON9xAnl/6c3EpnshbYG8L4nrr
         m6YCYnOX0e7MVDjt6K6UeM2aPlRDzFqH9agXPMHtZk20p1UzzAwirnAcXl4J2jIwch
         a0euu1jp0BblieHyy1P7996bFfiD5AzbPkVq6+xI9Drz4e6rHUD+PH9dVb9y8N73yA
         72kyM6KUlnhXF4sUgHpeSopcqEvw0pyoitadv2oWJtM5dW2QcWnIWKk71a0F6gjeGe
         pylDClQ32WNMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 948D2C43141;
        Thu, 22 Dec 2022 03:07:27 +0000 (UTC)
Subject: Re: [GIT PULL] tracing probes: Updates for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221216094254.7876461d@gandalf.local.home>
References: <20221216094254.7876461d@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221216094254.7876461d@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-probes-v6.2
X-PR-Tracked-Commit-Id: d4505aa6afae17a20c2f3ccfbfb7a07881b7ae02
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: af9b3fa15d6d99d948bcaca5a036ad2b292c8e8a
Message-Id: <167167844760.12654.15728801109582553848.pr-tracker-bot@kernel.org>
Date:   Thu, 22 Dec 2022 03:07:27 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Li Hua <hucool.lihua@huawei.com>,
        Li Huafei <lihuafei1@huawei.com>,
        wuqiang <wuqiang.matt@bytedance.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Dec 2022 09:42:54 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-probes-v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/af9b3fa15d6d99d948bcaca5a036ad2b292c8e8a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
