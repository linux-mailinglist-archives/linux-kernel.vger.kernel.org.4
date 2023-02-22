Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8CE69FC86
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbjBVTyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbjBVTx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:53:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140C41ABC3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 11:53:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0C5FB81708
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 19:53:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4605EC433A0;
        Wed, 22 Feb 2023 19:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677095631;
        bh=a1GkKmZTBke92OQVLwiIuwYj4zdvMwlzvum3DrIEt3Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iEvW5pzLxFeJkZiOtV2r/ziEpq4350e8h1lkeFKJhIAZ+e/u4IU8eYtR7XeEe+Pab
         R4Nu3O9gE2CCAfdmrZ7D/GDrl1CyZ4Bra2eOWzwOLdKzYFVIshuI3cmf8BQKnzBX1f
         gdRJlJElC0yHVl3FL/lnUjp6oY6PdXeAVWCLhaLq9ehU/8662LPyo9tHP/oqeHI9Tr
         0JEPT5TQ+7QPu/p0tMMMCak09VF3c85RwWG80zNqc0naYMmg7ASiF8Hog02bbeTmzO
         KE3Q0gvmpElSaQ6rK6oI4LP8mAEM3WnaX8WEQI1+0mNQPk6R8I9mwMou73vDiZmmSC
         jAVLiEORbOw/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C5E0C43151;
        Wed, 22 Feb 2023 19:53:51 +0000 (UTC)
Subject: Re: [GIT PULL] regmap updates for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230220143343.694A6C433D2@smtp.kernel.org>
References: <20230220143343.694A6C433D2@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230220143343.694A6C433D2@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.3
X-PR-Tracked-Commit-Id: 40f4b05868101e047a8502ebb94f05312186421b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 603ac530f13506e6ce5db4ab953ede4d292c5327
Message-Id: <167709563117.30115.593083415112512878.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Feb 2023 19:53:51 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Feb 2023 14:33:34 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/603ac530f13506e6ce5db4ab953ede4d292c5327

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
