Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4ED60ED25
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 02:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbiJ0As2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 20:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbiJ0AsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 20:48:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCEC1366AC;
        Wed, 26 Oct 2022 17:48:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DB1E620E2;
        Thu, 27 Oct 2022 00:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1212CC433C1;
        Thu, 27 Oct 2022 00:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666831700;
        bh=K7cDpUkDbt1UFX3VyDRRWQqLBiLKW9Fg7pnj7TrOf1E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ErTTM8/EMiSmGnkNk4aiD1sxDI+H0nevnVFLW+ehpsCoaDRQQlvSuR6TDG0tYr/zf
         kXMwqw5dC5PUnmt1q9yv+Zv8FWvo2KXjHD0RSiMfkqOlqkfUF068gcuUkzdEp7q8hI
         E3F8SS4tFTXO0YXKz3BGJtsqqG35xJ1s72jPfzMZlZNlFjaanFoMPQv28V0G2ww76h
         0ZBnMwQFiIY5dVG4GcWPKe/p1HBjiNAqu+6mKZqjKBIYU1HhwSfK3nr3s9YXXW+Oyk
         zaToemTWBRt06q9KnaWnqmOkDTwyIG18/2EiPWhr9z5lYO19IXwPXOQLE2F2sMNGDS
         KicFFPkFL00Kg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E9BFFE270DB;
        Thu, 27 Oct 2022 00:48:19 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.1-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221026200409.4B5BFC433B5@smtp.kernel.org>
References: <20221026200409.4B5BFC433B5@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221026200409.4B5BFC433B5@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.1-rc2
X-PR-Tracked-Commit-Id: f8aa6c895d482847c9b799dcdac8bbdb56cb8e04
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a2718383ef9d9dcba90212531909aa4c8ab31c0c
Message-Id: <166683169995.19821.11842216394795351762.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Oct 2022 00:48:19 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 26 Oct 2022 21:04:02 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.1-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a2718383ef9d9dcba90212531909aa4c8ab31c0c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
