Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E157E741A87
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 23:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjF1VQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 17:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjF1VJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:09:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65DC1FE4;
        Wed, 28 Jun 2023 14:09:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61B1961478;
        Wed, 28 Jun 2023 21:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CAA5CC433CB;
        Wed, 28 Jun 2023 21:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687986574;
        bh=UnIqjbwULWzDA+/nmygU1opUXwKIqdFFriZ7oFzXiic=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ht3QRdQBiSmTzo11erLhobkg1cV8fBOO/mteJa41dc8to7BXCds5lHV3ov+bxRA/K
         d6yP9GrKBz9Tba21XA4gMyLtVUIg0d+rFlWGP+pCTPGk56GLBTSOvFqmdTgugrCQ7k
         R6FcshwxJTmujg5Ucb+rCL6K+TPUvJdT5pthgUgbArQpIFA0lEjvA94G7btPzMrcT6
         tQauXdKfhFZDUj5MhiNhcqjX6hBcfSKm4tEAxa1ItRskfIuqI0cVvK+LJCBupShcuO
         ScTIgp19r8+AurY0vZhAOkMrRYxX7JjGlcnOTyrE2DR7Kv0Q/fj8r7kT28n5oKSy2o
         b6wij1cMhXsyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B2AAAC0C40E;
        Wed, 28 Jun 2023 21:09:34 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230626133342.B7F90C433C8@smtp.kernel.org>
References: <20230626133342.B7F90C433C8@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230626133342.B7F90C433C8@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.5
X-PR-Tracked-Commit-Id: e884a133340a470070b2c59833c9ff87aa6517ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 84fccbba93103b22044617e419ba20e1403b4a65
Message-Id: <168798657472.29247.12962996338723774240.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Jun 2023 21:09:34 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 14:33:33 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/84fccbba93103b22044617e419ba20e1403b4a65

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
