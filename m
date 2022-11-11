Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76B16260D2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 19:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbiKKSDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 13:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbiKKSDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:03:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409BE68298;
        Fri, 11 Nov 2022 10:03:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9307B826BE;
        Fri, 11 Nov 2022 18:03:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BA78C433B5;
        Fri, 11 Nov 2022 18:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668189781;
        bh=/4tdlY2rbNbWCC4qxL/t9GtKjccKosgwdM9gDjM8q6Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=K/haRFRQz0bGd48WhqGjlthlZ4W0mORb0Ft9mSf86vDJzw3NYqP3aq9F3tsd9V5vG
         k0FfwSynuUKang3JkjYX6UcenwtrTRH7iAGY+B1kZ0oS2cGniQRKhtnrUykOQ/yh17
         ZYJMr0Ne9O9aJlPCOmwS5YdeI4yAXR+zHQNGhwmMz5VNdO60erMG6yEs8yKsxjT7dh
         lSBbkgDAxgStX80BJDY42Mo5malRVi3omHA6NtjhqShsQfhRjPXXIZWFq12BGaiQ9v
         Pu/5+0V1KsQdBKHc3QVWKaHybSM6gWd2JhCcSGFUDZSgh/aPzzyXL5mHfu0augkOPU
         iePgT9kA8FEeQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83FA1E270C3;
        Fri, 11 Nov 2022 18:03:01 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.1-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221111131635.0A437C433C1@smtp.kernel.org>
References: <20221111131635.0A437C433C1@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221111131635.0A437C433C1@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.1-rc4
X-PR-Tracked-Commit-Id: bff6bef701db784bb159a659e99c785b4594fc96
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a83e18ccc486dc20fdb46109944ea1b450ac771e
Message-Id: <166818978153.15878.4248807959293547572.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Nov 2022 18:03:01 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Nov 2022 13:16:16 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.1-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a83e18ccc486dc20fdb46109944ea1b450ac771e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
