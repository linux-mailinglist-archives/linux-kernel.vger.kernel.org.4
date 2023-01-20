Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BED6675E8F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjATUGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjATUGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:06:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69531BC894;
        Fri, 20 Jan 2023 12:06:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20418B82A5B;
        Fri, 20 Jan 2023 20:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CAF99C4339C;
        Fri, 20 Jan 2023 20:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674245200;
        bh=4uUJqbfE+tC9cffJRwSpwjVmPyLrQmAhiiFKySxaa24=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CSb3/DBfCey+7kzYN/Fby1M834FIVU619+Wozx7vl4b9EZfNxgXkbrhBMD68auoQH
         mVQFA0XiIjZOV+NKJtkP0Kl5aQ1GVntta08Xai8KQbzbtg8y4cJNJMhs4//hmzRwVi
         k0F5TBypjQT1F4bJDJ6DqvpyhrZEXYtGT4o+RKkhS71lvZMANFYHhTMKOTeU6EwCqs
         6dTqeGWJAPCrqJbjLI6oetZYfqI9zyKfnRZSMjFBQ1MqZ1dRkbHvwnAa16SQ+2pnHv
         7ozIZUZVBzChRtGaqgs2AiGMeaeqeOs8mJdMupWxi6gmvRaWGNXZr7T/KdTMSj7iS2
         52F4JLDVK1zfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AFCC5E54D2B;
        Fri, 20 Jan 2023 20:06:40 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.2-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gFO1nANyUZG9TPiRBNTN8hOJNmgSDb6LE8JtCF5K4+=Q@mail.gmail.com>
References: <CAJZ5v0gFO1nANyUZG9TPiRBNTN8hOJNmgSDb6LE8JtCF5K4+=Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gFO1nANyUZG9TPiRBNTN8hOJNmgSDb6LE8JtCF5K4+=Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.2-rc5
X-PR-Tracked-Commit-Id: 3bdd346ebda37f4cb12461d5e83a5b9d575afc63
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe563a2c554c8cd07078eb1dacd3ea6148bd4681
Message-Id: <167424520071.30775.5376072048749629937.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Jan 2023 20:06:40 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Jan 2023 19:04:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.2-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe563a2c554c8cd07078eb1dacd3ea6148bd4681

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
