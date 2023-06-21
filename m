Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311A1738D49
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjFURjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjFURjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:39:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC411193
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 10:39:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 580F161648
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 17:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B94E4C433C0;
        Wed, 21 Jun 2023 17:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687369146;
        bh=e/zoXRX5dnVIWz6ewYcrHS/y6250PQq6Y5F8hyM6oE0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tT8h/OQHPgImiCJTSRVqxTdXrdxUh2flMTR1nSOd/e0v0+PsG0lGGC89Sm+NO9abu
         faqjKBKjpZ3UmmT4wsMH6BWqO3eIHg8rUir1Q1pu5/RwWB3HfQHQFxScK49pIKzzNj
         1C6zwED8tcUzgneC/M2RTcxfjEI0hSxYmUbwXAessYujrnV4mlB6BIwRKmErTLSCKn
         0mp9i31B9JZBnSm4zjC5frP4iFgBRa0esxY7Vd8uNcGD/i8w2SdYpqsCUkwT1Fhe43
         h1J/ONorIbJxyk3mpcPANWnk+PEYZCqMuAh6V7IZDlLIhqbjZx+BbA5H370CbnmNnJ
         OL1x4cWYflAxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9BA12E21EDB;
        Wed, 21 Jun 2023 17:39:06 +0000 (UTC)
Subject: Re: [GIT PULL] regmap fixes for v6.4-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230621132028.E6428C433C0@smtp.kernel.org>
References: <20230621132028.E6428C433C0@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230621132028.E6428C433C0@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.4-rc7
X-PR-Tracked-Commit-Id: c8e796895e2310b6130e7577248da1d771431a77
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e075d681a27eea6e3722749dda10cf3c4ddfc9fc
Message-Id: <168736914663.5231.12100038470011023702.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Jun 2023 17:39:06 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 21 Jun 2023 14:20:16 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.4-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e075d681a27eea6e3722749dda10cf3c4ddfc9fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
